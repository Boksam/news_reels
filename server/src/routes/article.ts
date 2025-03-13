import { Router } from 'express'
import { prisma } from '../../prisma/prisma'
import dayjs from 'dayjs'
import utc from 'dayjs/plugin/utc'

const router = Router()

dayjs.extend(utc)

const DEFAULT_LIMIT = 20 // 20 rows
const DEFAULT_TIMEFRAME = 24 // 24 hours

/**
 * News API
 * @route GET /api/news
 * @param {number} limit - Maximum number of articles
 * @param {number} timeframe - How many hours of news to retrieve (Default: 24)
 * @returns {Object} JSON object with articles array and metadata
 */
router.get('/', async (req, res) => {
  // TODO: Implement paging & specifying categories, etc
  const limit = parseInt(req.query.limit as string) || DEFAULT_LIMIT
  const timeframe = parseInt(req.query.timeframe as string) || DEFAULT_TIMEFRAME

  const endTime = dayjs.utc()
  const startTime = endTime.subtract(timeframe, 'hour')

  try {
    const articles = await prisma.article.findMany({
      take: limit,
      where: {
        created_at: {
          gte: startTime.toISOString(),
          lte: endTime.toISOString(),
        },
      },
      orderBy: {
        created_at: 'desc',
      },
    })

    res.json({
      articles,
      meta: {
        limit,
        timeframe,
        count: articles.length,
      },
    })
  } catch (error) {
    console.log('Failed to fetch articles:', error)
    res.status(500).json({ error: 'Failed to fetch articles.' })
  }
})

/**
 * Get a specific article by ID
 * @route GET /api/news/:id
 * @param {number} id - Article ID
 * @returns {Object} Article object or error
 */
router.get('/:id', async (req, res) => {
  try {
    const id = parseInt(req.params.id)

    if (isNaN(id)) {
      return res.status(400).json({ error: 'Invalid Article ID' })
    }

    const article = await prisma.article.findUnique({
      where: { id },
    })

    if (!article) {
      res.status(404).json({ error: { message: 'Article not found' } })
    }

    res.json(article)
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch article' })
  }
})

export default router
