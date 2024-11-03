import Express from 'express'
import dotenv from 'dotenv'
import cron from 'node-cron'

import { NewsFetcher } from './src/news_fetcher'

dotenv.config()

const app = Express()
const newsFetcher = new NewsFetcher()

app.get('/', (req, res) => {
  res.send('Hi mom')
})

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
