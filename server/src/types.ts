export interface GuardianArticle {
  sectionId: string
  type: string
  webUrl: string
  webPublicationDate: string
  fields: {
    headline?: string
    thumbnail?: string
    bodyText?: string
    lang?: string
    lastModified?: string
  }
}

export interface GuardianResponse {
  response: {
    results: GuardianArticle[]
  }
}

export interface ArticleSummary {
  oneLineSummary: string
  fullSummary: string
}
