import OpenAI from 'openai'

const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
  organization: process.env.OPENAI_ORGANIZATION_ID,
})

const summarize_article = async (content: string) => {
  const prompt = `
    Here is a full content of the article:
    "${content}"

    
    Please provide
    1. Fully summarized content of the article. (around 500 characters)
      Full summary should be detailed and informative.
    2. One line summary of the article.

    Return a JSON object like below:
    {
      "one_line_summary": "...",
      "full_summary": "..."
    }
  `
  try {
    const response = await openai.chat.completions.create({
      model: 'gpt-3.5-turbo',
      messages: [{ role: 'system', content: prompt }],
    })
    const summarized_message = response.choices[0].message?.content
    if (summarized_message) {
      console.log('summarized_message:', summarized_message)
      const summary = JSON.parse(summarized_message)
      return summary
    } else {
      throw new Error('Failed to summarize the article')
    }
  } catch (error) {
    console.error(error)
    throw new Error('Failed to summarize the article')
  }
}

export default summarize_article
