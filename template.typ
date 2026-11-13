

///////////////////////////////////////////////////////////
// USER DATA
///////////////////////////////////////////////////////////

// Required
#let names = "Max Musterman"
#let typ = "Hausaufgabe"
#let fach = "Mathematik LXIX"
#let tutorium = "deine Tutorium Gruppe"
#let woche = 999

// optional (wird automatisch ausgerechnet)
#let semester = "Wintersemester 2026/27"


///////////////////////////////////////////////////////////
// DOCUMENT SETTINGS
///////////////////////////////////////////////////////////

#set text(
  lang: "de",
  size: 12pt,
)


#set enum(numbering: "1.")

#set page(
  paper: "a4",
  margin: (
    top: 15mm,
    inside: 1in,
    outside: 1in,
    bottom: 25mm,
  ),

  // Running header, except on page 1
  header: context {
    if counter(page).get().first() > 1 {
      grid(
        columns: (1fr, 1fr),
        [#names], align(right)[#fach #typ],
      )
      line(length: 100%)
    }
  },

  // Centered page number, except on page 1
  footer: context {
    if counter(page).get().first() > 1 {
      align(center, counter(page).display("1"))
    }
  },
)

#let isWintersemester(date) = {
  let month = date.month()

  if (month > 4 and month < 10) {
    return false
  } else {
    return true
  }
}

#let semesterSetter(overwrite: "") = {
  if (overwrite != "") {
    return overwrite
  }

  let date = datetime.today()
  let year = date.year() - 2000 // TO DO: change before the year 3000

  let semesterString = ""

  if (not isWintersemester(date)) {
    semesterString = "Sommersemester " + str(year)
  } else {
    semesterString = "Wintersemester " + str(year) + "/" + str(year + 1)
  }
  return semesterString
}

///////////////////////////////////////////////////////////
// FRAMED HEADER (FIRST PAGE)
///////////////////////////////////////////////////////////

#let makeheader() = block(
  width: 100%,
  stroke: 0.6pt,
  inset: 8pt,
  below: 1.5em,
)[
  #grid(
    columns: (1fr, 1fr),
    row-gutter: 10pt,

    [#names],
    align(right)[#fach],

    grid.cell(colspan: 2, inset: 8pt)[
      #align(center)[
        #text(size: 16pt, weight: "bold")[
          #typ Woche #woche
        ]
      ]
    ],

    [Tutorium: #tutorium],
    align(right)[#semesterSetter(overwrite: semester)],
  )
]


///////////////////////////////////////////////////////////
// EXERCISE ENVIRONMENT
///////////////////////////////////////////////////////////

#let exercise-counter = counter("exercise")

#let exercise(body, title: none, numbered: true) = block(
  width: 100%,
  above: 2em,
  below: 1em,
)[
  #if numbered {
    exercise-counter.step()
  }

  #let label = if numbered {
    [Aufgabe #context exercise-counter.display("1")]
  } else {
    [Aufgabe]
  }

  #strong[
    #label#if title != none [ (#title)]:
  ]

  #v(0.4em)

  #pad(left: 1.5em)[
    #body
  ]
]


///////////////////////////////////////////////////////////
// SOLUTION ENVIRONMENT
///////////////////////////////////////////////////////////

#let solution(body) = block(
  width: 100%,
  above: 2em,
  below: 1em,
)[
  *Lösung:*

  #v(0.4em)

  #pad(left: 1.5em)[
    #body
  ]
]


///////////////////////////////////////////////////////////
// DOCUMENT START
///////////////////////////////////////////////////////////

#makeheader()

#exercise(title: "optionaler Titel")[
  //exercise space
]

#solution[
  // solution space
]

#exercise(title: "nicht nummerierte Aufgabe", numbered: false)[
  // exercise space
]
