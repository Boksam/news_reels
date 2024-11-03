import OpenAI from 'openai'
import { CONFIG } from './config'
import type { ArticleSummary } from './types'

const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
  organization: process.env.OPENAI_ORGANIZATION_ID,
})

export class ArticleSummarizer {
  private openai: OpenAI

  constructor() {
    if (!CONFIG.OPENAI_API_KEY || !CONFIG.OPENAI_ORGANIZATION_ID) {
      throw new Error('OpenAI API key or organization ID is not provided')
    }
    this.openai = new OpenAI({
      apiKey: CONFIG.OPENAI_API_KEY,
      organization: CONFIG.OPENAI_ORGANIZATION_ID,
    })
  }

  private createPrompt(content: string) {
    return `
      Here is a full content of the article:
      "${content}"

      Please provide
      1. Fully summarized content of the article. (around 500 characters)
        Full summary should be detailed and informative.
      2. One line summary of the article.

      Return a JSON object like below:
      {
        "oneLineSummary": "...",
        "fullSummary": "..."
      }
    `
  }

  async summarize(content: string): Promise<ArticleSummary> {
    try {
      const response = await this.openai.chat.completions.create({
        model: CONFIG.GPT_MODEL,
        messages: [{ role: 'system', content: this.createPrompt(content) }],
      })
      const summarizedMessage = response.choices[0].message?.content
      if (!summarizedMessage) {
        throw new Error('Failed to summarize the article')
      }
      const summary = JSON.parse(summarizedMessage) as ArticleSummary
      return summary
    } catch (error) {
      console.error(error)
      if (error instanceof Error) {
        throw new Error(`Failed to summarize the article: ${error.message}`)
      } else {
        throw new Error('Failed to summarize the article due to an unknown error')
      }
    }
  }
}

export default ArticleSummarizer
