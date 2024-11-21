import { query, Router } from 'express'
import { prisma } from '../../prisma/prisma'

const router = Router()

router.get('/', async (req, res) => {
  const page = parseInt(req.query.page as string) || 1
  const limit = parseInt(req.query.limit as string) || 10

  try {
    const articles = await prisma.article.findMany({
      take: limit,
      orderBy: { created_at: 'desc' },
    })
    const total = await prisma.article.count()

    res.json({
      articles,
      meta: {
        page,
        limit,
        total,
      },
    })
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch articles' })
  }
})

router.get('/:date', async (req, res) => {
  const date = req.params.date
  const page = parseInt(req.query.page as string) || 1
  const limit = parseInt(req.query.limit as string) || 10

  const start_date = new Date(date)
  start_date.setHours(0, 0, 0, 0)
  const end_date = new Date(date)
  end_date.setHours(23, 59, 59, 59)

  try {
    const articles = await prisma.article.findMany({
      take: limit,
      where: {
        created_at: {
          gte: start_date,
          lte: end_date,
        },
      },
      orderBy: { created_at: 'desc' },
    })

    const total = await prisma.article.count()

    res.json({
      articles,
      meta: {
        page,
        limit,
        total,
      },
    })
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch articles' })
  }
})

router.get('/:id', async (req, res) => {
  const id = parseInt(req.params.id)
  try {
    const article = await prisma.article.findUnique({
      where: {
        id: id,
      },
    })

    if (!article) {
      res.status(404).json({ error: { message: 'Article not found' } })
    }

    res.json(article)
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch article' })
  }
})

router.get('/search', async (req, res) => {
  const { query } = req.query
  const page = parseInt(req.query.page as string) || 1
  const limit = parseInt(req.query.limit as string) || 10

  try {
    const articles = await prisma.article.findMany({
      where: {
        OR: [
          { headline: { contains: query as string } },
          { content: { contains: query as string } },
          { one_line_summary: { contains: query as string } },
        ],
      },
      take: limit,
      skip: (page - 1) * limit,
      orderBy: { created_at: 'desc' },
    })

    if (!articles) {
      res.status(404).json({ error: { message: 'No articles found' } })
    }

    res.json(articles)
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch articles' })
  }
})

export default router
