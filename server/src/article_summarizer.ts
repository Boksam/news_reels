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
    // Escape content to avoid JSON parsing issues
    const escapedContent = content.replace(/\\/g, '\\\\').replace(/"/g, '\\"')

    return `
      Please analyze the following article content and provide two summaries:
        1. A detailed summary (around 500 characters)
        2. A one-line summary

      Article content: ${escapedContent}

      Respond in the following JSON format, being careful to escape any quotes in the summaries:
      {
        "oneLineSummary": "your one line summary here",
        "fullSummary": "your detailed summary here"
      }`
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
