$ = require "jquery"
require "jquery.ui"
require "jquery.jqmodal"


blocks = require "./blocks.coffee"
autocomplete = require "./core/autocomplete.coffee"

router = window.aRouter

init = ->
  # Popups
  $('#window_login_form').jqm()
  $('#blog_delete_form').jqm trigger: '#blog_delete_show', toTop: true
  $('#add_friend_form').jqm trigger: '#add_friend_show', toTop: true
  $('#window_upload_img').jqm()
  $('#favourite-form-tags').jqm()
  $('#modal_write').jqm trigger: '.js-write-window-show'
  $('#foto-resize').jqm modal: true, toTop: true
  $('#avatar-resize').jqm modal: true, toTop: true
  $('#userfield_form').jqm toTop: true

  # Autocomplete
  autocomplete.add $(".autocomplete-tags-sep"), "#{router.ajax}autocompleter/tag/", true
  autocomplete.add $(".autocomplete-tags"), "#{router.ajax}autocompleter/tag/", false
  autocomplete.add $(".autocomplete-users-sep"), "#{router.ajax}autocompleter/user/", true
  autocomplete.add $(".autocomplete-users"), "#{router.ajax}autocompleter/user/", false

  # Blocks
  blocks.init 'stream', group_items: true, group_min: 3
  blocks.init 'blogs'
  blocks.initSwitch 'tags'
  blocks.initSwitch 'upload-img'
  blocks.initSwitch 'favourite-topic-tags'
  blocks.initSwitch 'popup-login'

  # Handlers
  $('.js-registration-form-show').click ->
    if ls.blocks.switchTab 'registration', 'popup-login'
      $('#window_login_form').jqmShow()
    else
      window.location = router.registration
    false
  $('.js-login-form-show').click ->
    if ls.blocks.switchTab 'login', 'popup-login'
      $('#window_login_form').jqmShow()
    else
      window.location = router.login
    false

  # Datepicker
  $('.date-picker').datepicker
    dateFormat: 'dd.mm.yy'
    dayNamesMin: ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб']
    monthNames: ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь']
    firstDay: 1

  # Tag search
  $('.js-tag-search-form').submit ->
    val = $(this).find('.js-tag-search').val()
    if val
      window.location = "#{router.tag}#{encodeURIComponent(val)}/"
    false



module.exports = init