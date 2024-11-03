import got from 'got'
import dayjs from 'dayjs'
import { prisma } from '../prisma/prisma'
import ArticleSummarizer from './article_summarizer'
import { CONFIG } from './config'
import type { GuardianArticle, GuardianResponse } from './types'

export class NewsFetcher {
  private summarizer: ArticleSummarizer

  constructor() {
    this.summarizer = new ArticleSummarizer()
  }

  private getDateRange() {
    return {
      today: dayjs().format('YYYY-MM-DD'),
      yesterday: dayjs().subtract(1, 'day').format('YYYY-MM-DD'),
    }
  }

  private async fetchArticles(): Promise<GuardianArticle[]> {
    if (!CONFIG.NEWS_API_KEY) {
      throw new Error('Guardian API key not found')
    }

    const { today, yesterday } = this.getDateRange()

    const response = await got.get<GuardianResponse>(CONFIG.GUARDIAN_API_URL, {
      searchParams: {
        'api-key': CONFIG.NEWS_API_KEY,
        'from-date': yesterday,
        'to-date': today,
        'show-fields': 'headline,thumbnail,bodyText,lang,lastModified',
        section: 'world',
        'page-size': 5,
      },
      responseType: 'json',
    })

    return response.body.response.results
  }

  private async processArticle(article: GuardianArticle) {
    const { fields, sectionId, type, webUrl, webPublicationDate } = article

    const existing = await prisma.article.findUnique({
      where: { url: webUrl },
    })

    if (existing) {
      console.log('Article already exists:', webUrl)
      return
    }

    const content = fields?.bodyText || ''
    const summary = await this.summarizer.summarize(content)

    await prisma.article.create({
      data: {
        headline: fields?.headline || '',
        content,
        full_summary: summary.fullSummary,
        one_line_summary: summary.oneLineSummary,
        section: sectionId,
        type,
        thumbnail: fields?.thumbnail || '',
        language: fields?.lang || 'en',
        url: webUrl,
        created_at: new Date(webPublicationDate),
        updated_at: new Date(fields?.lastModified || webPublicationDate),
      },
    })

    console.log('Article added:', webUrl)
  }

  async fetchAndStore(): Promise<void> {
    try {
      const articles = await this.fetchArticles()

      for (const article of articles) {
        await this.processArticle(article)
      }
    } catch (error) {
      if (error instanceof Error) {
        throw new Error(`Failed to fetch and store news: ${error.message}`)
      }
      throw error
    } finally {
      await prisma.$disconnect()
    }
  }
}

const fetcher = new NewsFetcher()
fetcher.fetchAndStore()
