$ ->

  # IE用Fix
  if $("html").hasClass "lt-ie7"
    $ ".list-inline > li"
      .addClass "ie-child"
    $ ".unit > .units"
      .assClass "ie-units-fix"
