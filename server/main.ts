import Express from 'express'
import dotenv from 'dotenv'
import cron from 'node-cron'

import fetch_news from './src/fetch_news'

dotenv.config()

const app = Express()

app.get('/', (req, res) => {
  res.send('Hi mom')
})

cron.schedule(
  '0 0 * * *',
  () => {
    fetch_news()
      .then(() => console.log('News fetched successfully'))
      .catch((error) => console.error('Failed to fetch news:', error))
  },
  { timezone: 'UTC' },
)

app.listen(3000, () => {
  console.log('Listening on port 3000')
})
