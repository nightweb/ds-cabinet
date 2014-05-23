$ ->
  promos = []
  heights = []
  current = 0

  $('.promo').each ->
    promos.push(this)
    heights.push($(this).outerHeight() + 30)
    $(this).hide()
    $(this).css(height: 0) if promos.length > 1

  $(promos[0]).show()

  setInterval ->
    $(promos[current]).animate {height: 0}, 400, 'linear', ->
      $(promos[current]).hide()
      current++
      current = 0 if current >= promos.length
      $(promos[current]).show()
      $(promos[current]).animate {height: "#{heights[current]}px"}, 400, 'linear'
  , 7000