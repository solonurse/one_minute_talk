module ApplicationHelper
  def default_mata_tags
    {
      site: 'OneMinuteTalk',
      title: 'OneMinuteTalk',
      reverse: true,
      charset: 'utf-8',
      description: 'OneMinuteTalkは話したいことを整理し、1分間で相手に伝わるように効果的に話すためのアプリです。',
      keywords: 'メモ,マインドアップ',
      canonical: request.original_url,
      separator: '|',
      icon: [
        { href: image_url('ogp.png'), rel: 'apple-touch-icon', type: 'image/png' }
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'), 
        local: 'ja-JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@',
        image: image_url('ogp.png')
      }
    }
  end
end
