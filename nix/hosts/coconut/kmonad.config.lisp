(defsrc
  caps h j k l
)

(defalias
  cap (tap-next-release esc (layer-toggle arrows))
)

(deflayer default
  @cap h j k l
)

(deflayer arrows
  _    left down up right
)
