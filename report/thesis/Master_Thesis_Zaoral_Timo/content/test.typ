#import "../src/styles/flex-captions.typ": flex-caption

= Once upon an ipsum

#lorem(100)

= There was a long ipsum

In @ddm, we can see the TUWI Logo, followed by @some-table and @lorem-ipsum-alg. The algorithm was discussed here: @team2019people.

#figure(
  image("../src/graphics/DDM_sim.svg", width: 60%),
  caption: flex-caption(
    [Drift Difusion Model],
    [DDM (short description for list of figures)],
  ),
) <ddm>

#figure(
  table(
    columns: (1fr, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header(
      [],
      [*Area*],
      [*Parameters*],
    ),

    [cylinder],
    $ pi h (D^2 - d^2) / 4 $,
    [
      $h$: height \
      $D$: outer radius \
      $d$: inner radius
    ],

    [tetrahedron], $ sqrt(2) / 12 a^3 $, [$a$: edge length],
  ),
  caption: flex-caption(
    [A table copy pasted from #link("https://typst.app/docs/reference/model/table/")[the docs].],
    [Some table],
  ),
) <some-table>


#figure(
  kind: "algorithm",
  caption: "The Lorem Ipsum algorithm",
)[
  ```python
  def loop():
    print("Lorem")
    print("Ipsum")
  ```
] <lorem-ipsum-alg>

#lorem(200)

== With sub ipsums

#lorem(30)

#lorem(30)

== Many sub ipsums

#lorem(200)

== Many many sub ipsums

#lorem(200)

=== Going

==== Deep