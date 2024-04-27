local keep_headings_level     = false -- could be a number (level) or false
local strongen_headings_level = 3     -- could be a number (level)

-- Adjust headings in the document
function Header(elem)

  if elem.classes:includes("keep-headings") then
    keep_headings_level = elem.level
    return elem
  end

  -- turn off keep_headings_level when a new heading of level 1 and 2 is found
  if keep_headings_level ~= false and elem.level <= keep_headings_level then
    keep_headings_level = false
    return elem
  end

  -- if elem.classes:includes("heading") then
  --   print ("keep_headings_level: ", keep_headings_level)
  --   print ("strongen_headings_level: ", strongen_headings_level)
  -- end

  -- Convert all headings to strong text if they are level 3 or higher
  if elem.level >= strongen_headings_level then

    -- keep_headings is true if keep_headings_level is not false
    local keep_headings = keep_headings_level

    -- Do not strongen subheadings
    -- or if the element has a class "heading"
    if keep_headings or elem.classes:includes("heading") then
      -- Do not strongen headings with class "heading"
      return elem
    end

    local text = pandoc.Strong(elem.content)
    return pandoc.Plain({text})
  end

  return elem
end