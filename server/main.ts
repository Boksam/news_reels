import Express from 'express'
import dotenv from 'dotenv'
import cron from 'node-cron'
import cors from 'cors'

import { NewsFetcher } from './src/article_fetcher'
import articleRouter from './src/routes/article'

dotenv.config()

const app = Express()

// Middleware
app.use(Express.json())
app.use(cors())

// Router
app.use('/api/articles', articleRouter)

// Cron Job
const newsFetcher = new NewsFetcher()
cron.schedule(
  '0 0 * * *',
  async () => {
    try {
      await newsFetcher.fetchAndStore()
      console.log(`News fetched and stored successfully at ${new Date().toISOString()}`)
    } catch (error) {
      if (error instanceof Error) {
        console.error(`Failed to fetch and store news: ${error.message}`)
      } else {
        console.error(`Failed to fetch and store news: ${error}`)
      }
    }
  },
  { timezone: 'UTC' },
)

app.listen(3000, () => {
  console.log('Listening on port 3000')
})
