import { config } from 'dotenv'

config()

export const CONFIG = {
  NEWS_API_KEY: process.env.NEWS_API_KEY,
  OPENAI_API_KEY: process.env.OPENAI_API_KEY,
  OPENAI_ORGANIZATION_ID: process.env.OPENAI_ORGANIZATION_ID,
  GUARDIAN_API_URL: 'https://content.guardianapis.com/search',
  GPT_MODEL: 'gpt-3.5-turbo',
} as const
