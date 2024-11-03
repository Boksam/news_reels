import axios from 'axios'
import { PrismaClient } from '@prisma/client'
import dayjs from 'dayjs'

import summarizeArticle from './summarize_article'

const prisma = new PrismaClient()

const fetch_news = async () => {
  const api_key = process.env.NEWS_API_KEY
  if (!api_key) {
    throw new Error('API key not found')
  }

  const today = dayjs().format('YYYY-MM-DD')
  const yesterday = dayjs().subtract(1, 'day').format('YYYY-MM-DD')

  const url = 'https://content.guardianapis.com/search'
  const params = {
    'api-key': api_key,
    'from-date': yesterday,
    'to-date': today,
    'show-fields': 'headline,thumbnail,bodyText,lang,lastModified',
    section: 'world',
    'page-size': 20,
  }

  try {
    // TODO: add API response type
    const response = await axios.get(url, { params }) // TODO: replace to got
    const articles = response.data.response.results

    for (const article of articles) {
      const { fields, sectionId, type, webUrl, webPublicationDate } = article

      const headline = fields?.headline || ''
      const thumbnail = fields?.thumbnail || ''
      const content = fields?.bodyText || ''
      const language = fields?.lang || 'en'
      const modifiedDate = fields?.lastModified || webPublicationDate

      const existing_news = await prisma.article.findUnique({
        where: {
          url: webUrl,
        },
      })
      if (existing_news) {
        console.log('News already exists')
        continue
      }

      const summary = await summarizeArticle(content)

      await prisma.article.create({
        data: {
          headline: headline,
          content: content,
          full_summary: summary.full_summary,
          one_line_summary: summary.one_line_summary,
          section: sectionId,
          type: type,
          thumbnail: thumbnail,
          language: language,
          url: webUrl,
          created_at: new Date(webPublicationDate),
          updated_at: new Date(modifiedDate),
        },
      })
      console.log('News added')
    }
  } catch (error) {
    console.error(error)
  } finally {
    await prisma.$disconnect()
  }
}

export { fetch_news }
