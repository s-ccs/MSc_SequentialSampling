#import "@preview/abbr:0.1.1"
#import "../src/styles/flex-captions.typ": flex-caption
= Use Cases / Applications<sec:usecases>
The possible use of the #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl] extension is shown below. The fundamental options are first demonstrated through three examples — one for each model — illustrating the simulation space. This approach provides a clear understanding of the basic functionalities. The second section deals specifically with the case of overlap correction from the comment by @Comment2024Fromer. The overlap correction is shown using the example of two different #abbr.pla("SSM").
== Simulation Space<subsec:simspace>
In this basic use case, the three #abbr.pla("SSM") #abbr.a("LBA"), #abbr.a("DDM") and the #abbr.s("KellyModel") were used to demonstrate their possible uses. The same setting of basic requirements for design, components and onsets as well as the presence or absence of noise was used for each of the three experiments. The design consists of a SingleSubjectDesign, which has one condition of two different drift\_rates (0.45, 0.8). This design is then supplemented by an "SCR" SequenceDesign, which results in 6 events that are shown in @tab:SCRSequenceDesign.
#figure(
  table(
    columns: (auto, auto, auto),
    inset: 4pt,
    align: horizon,
    table.header(
      [], [*Event*], [*drift\_rate*],
    ),
    "1", "S","0.45",
    "2", "C","0.45",
    "3", "R","0.45",
    "4", "S","0.8",
    "5", "C","0.8",
    "6", "R","0.8",
  ), caption: ['SCR' SequenceDesign with two different drift\_rates]
)<tab:SCRSequenceDesign>
The events S,C,R stand for e.g. Stimulus, Component, Response. This design would thus represent two trials of an experiment, for example of one participant for two drift_rate conditions. In order to ensure a slightly larger amount of data in the experiment, the RepeatDesign is applied to it, whereby the six events from @tab:SCRSequenceDesign are repeated. In this scenario, the SequenceDesign was repeated 100 times, resulting in 600 events. This completes the creation of the design.

For the components an existing LinearModelComponent was used for the events S,R. This was used with an hanning function to create two normally distributed peaks at 0.5 for the stimulus and -0.5 for the response. The 'C' component is then the DriftComponent with the respective #abbr.a("SSM"). The onsets between the events are defined by two UniformOnsets for S,R with a fixed length equivalent to that of the component. The standard DriftOnset is used for the #abbr.a("SSM"), whereby the pure response time of the models is applied.\
The sampling frequency has been set to 500 and the associated maximum time to 1.0.
#pagebreak()
*Basic #abbr.a("LBA") Simulation:*
The parameters of #abbr.a("LBA") were specified as shown below in @tab:BasicLBAparams.
#figure(
  table(
    columns: (auto, auto, auto, auto),
    inset: 2pt,
    align: horizon,
    table.header(
      [Linear accumulation rate (v)], [Starting point distribution (A)], [Threshold (k)],[Non-decisional time (Ter)]
    ),
    "\"drift_rate\"", "0.01","0.6", "0.0",
  ), caption: flex-caption([Model parameters for #abbr.a("LBA") simulation],[Model parameters for LBA simulation])
)<tab:BasicLBAparams>
The linear accumulation rate is taken from the design. The start point shift is kept to a minimum and no non-decisional time is specified so that the response appears directly after the peak.

In the following @fig:BasicLBAsim, the results of the simulation are shown once with PinkNoise(noiselevel=1) @wikipediaPinkNoise and once without. The noiselevel indicates how the noise is scaled. Therefore, a noiselevel=1 indicates the basic PinkNoise, as it is multiplied by 1. Tile A shows the raw #abbr.a("EEG") signal from two repetitions of the sequence. The vertical lines show the onset of the respective event. As you can see, the events of the ‘SCR’ sequence occur as defined in the design and there are no overlaps due to the matching onsets. The difference between the two drift\_rates defined in the design can also be seen in the 'C' component, with the first accumulating for longer time than the second. Cause the amount of evidence gained per time step is lower.
#figure(
grid(
  columns: 2,
  rows: 2,
  align: left,
  gutter: 1cm,
  grid.cell([*A*
    #image("graphics/use_cases/Base_LBA_Model_EEG_V2.png", width: 80mm)
  ]),
  grid.cell([*B*
    #image("graphics/use_cases/Base_LBA_Model_ERP_V2.png", width: 80mm)
  ]),
  grid.cell([*C*
      #image("graphics/use_cases/Base_LBA_Model_EEG_noise_V2.png", width: 80mm)
    ]),
  grid.cell([*D*
      #image("graphics/use_cases/Base_LBA_Model_ERP_noise_V2.png", width: 80mm)
    ])), caption: flex-caption([#abbr.a("EEG") and #abbr.a("ERP") of a 'SCR' sequence using #abbr.a("LBA") Model as 'C' component. *A:* Raw #abbr.a("EEG") signal from two repetitions of the 'SCR' sequence. *B:* #abbr.a("ERP") created from the raw #abbr.a("EEG"). *C:* #abbr.a("EEG") signal with PinkNoise(noiselevel=1). *D:* #abbr.a("ERP") with PinkNoise(noiselevel=1).], [EEG and ERP of a 'SCR' sequence using LBA Model as 'C' component])
)<fig:BasicLBAsim>
The corresponding #abbr.a("ERP") of the three events created using the #link("https://github.com/unfoldtoolbox/Unfold.jl")[Unfold.jl] package is displayed directly next to it in tile B.
In it, the components are averaged over all occurring events in the #abbr.a("EEG") and thus result in the average expression of these. No difference is to be expected for the events 'S' and R, as these are always the same. For event C, variations in the drift\_rate parameter used in the simulation are reflected in the #abbr.a("ERP"). Since the two simulated traces differ in duration, their overall average also changes. As shown in the figure, both peaks are no longer as high as the threshold. This occurs because the lower drift\_rate traces contribute to the first peak, reducing its magnitude, as their values remain below the threshold at this point in time. Similarly, the second peak of the lower drift\_rate is significantly lower because the higher drift\_rate traces have already returned to zero, pulling the overall average down.

The bottom two tiles C and D of the @fig:BasicLBAsim show the same diagrams as in the top two. However, in this case the PinkNoise was used in the simulation. The noiselevel makes the raw #abbr.a("EEG") signal hard to interpret visually, highlighting the need for modelling-procedures as applied throughout this thesis. By applying epoching to get the #abbr.a("ERP"), the general shapes of the original components of the three events can again be easily recognised despite the noise.

This is the basic use case for the #abbr.a("LBA"), which can be extended in various ways and adapted to the desired research objectives. An example of this is shown in @subsec:deconv when applying an overlap correction.

*Basic #abbr.a("DDM") Simulation:*
For the simple simulation of the sequence with the #abbr.a("DDM"), its parameters are defined as in the following @tab:BasicDDMparams.
#figure(
  table(
    columns: (auto, auto, auto, auto),
    inset: 2pt,
    align: horizon,
    table.header(
      [Drift rate (v):], [Starting point of accumulation (z)], [Threshold distance (a)],[Non-decisional time (Ter)]
    ),
    "\"drift_rate\"", "0.5","4.0", "0.2",
  ), caption: flex-caption([Model parameters for #abbr.a("DDM") simulation],[Model parameters for DDM simulation])
)<tab:BasicDDMparams>
The drift\_rate is again specified in the simulation design and therefore varies from trial to trial. The starting point is set to a positive value in order to set a bias towards the positive threshold. The threshold value is set significantly higher compared to #abbr.a("LBA"), as we no longer have linear accumulation and the threshold value may be reached quite early. In addition, this time a non-decisional time of 0.2 is set as an example, which delays the response time and thus the onset of the response. 

Once again, the #abbr.a("EEG") and #abbr.a("ERP") of the simulation are shown in the @fig:BasicDDMsim once without (A,B) and once with PinkNoise (C,D). In the #abbr.a("EEG") signal without noise, from tile A, the differentiated diffusion curve that is typical for the #abbr.a("DDM") can be seen directly. 
Compared to the #abbr.a("LBA"), the variability in the accumulation process is more apparent, as the progression is no longer strictly linear. For instance, in the first trial, the accumulation initially moves in a positive direction before ultimately reaching the negative threshold. In contrast, in the second trial, no threshold is reached, and the simulation is terminated after reaching the maximum simulation duration. This highlights the increased unpredictability introduced by drift variability, making it nearly impossible to precisely determine when the threshold will be reached for a given drift\_rate.

As expected, the #abbr.a("ERP") in tile B @fig:BasicDDMsim shows that, on average, the 'C' component tends toward the positive threshold. This is evident from the initial positive bias in the starting value and the overall positive trend in the accumulation process. In decision-making terms, this suggests a predisposition toward one decision over the other. Another notable observation is the negative time of the 'R' component, where the prior ramp-up of the accumulation process is clearly visible.
#figure(
grid(
  columns: 2,
  rows: 2,
  align: left,
  gutter: 1cm,
  grid.cell([*A*
    #image("graphics/use_cases/Base_DDM_Model_EEG_V2.png", width: 80mm)
  ]),
  grid.cell([*B*
    #image("graphics/use_cases/Base_DDM_Model_ERP_V2.png", width: 80mm)
  ]),
  grid.cell([*C*
      #image("graphics/use_cases/Base_DDM_Model_EEG_noise_V2.png", width: 80mm)
    ]),
  grid.cell([*D*
      #image("graphics/use_cases/Base_DDM_Model_ERP_noise_V2.png", width: 80mm)
    ])), caption: flex-caption([#abbr.a("EEG") and #abbr.a("ERP") of a 'SCR' sequence using #abbr.a("DDM") Model as 'C' component. *A:* Raw #abbr.a("EEG") signal from two repetitions of the 'SCR' sequence. *B:* #abbr.a("ERP") created from the raw #abbr.a("EEG"). *C:* #abbr.a("EEG") signal with PinkNoise(noiselevel=1). *D:* #abbr.a("ERP") with PinkNoise(noiselevel=1).],[EEG and ERP of a 'SCR' sequence using DDM Model as 'C' component])
)<fig:BasicDDMsim>

In tiles C and D, the simulation with PinkNoise also behaves in the same way, as expected. This means that the clear trends of the events can be recognised in the #abbr.a("ERP") in D.

This basic simulation of the #abbr.a("DDM") already demonstrates, to some extent, how biases can influence the decision-making process. Next, the basic application of the #abbr.s("KellyModel") is demonstrated, which, as previously mentioned, provides significantly more parameters for adjustment and influence.

*Basic #abbr.s("KellyModel") Simulation:*
As the #abbr.s("KellyModel") offers such a large number of parameters, the default parameters are used in this basic example. These were determined through various tests and defined for the model. In this example simulation only the drift\_rate parameter is specified.  As in the other two use cases the drift\_rate originates from the simulation design. But this time the rates are higher (5.45, 7.8) compared to the ones used before, for better visibility of differences.
#figure(
grid(
  columns: 2,
  rows: 2,
  align: left,
  gutter: 1cm,
  grid.cell([*A*
    #image("graphics/use_cases/Base_Kelly_Model_EEG_V2.png", width: 80mm)
  ]),
  grid.cell([*B*
    #image("graphics/use_cases/Base_Kelly_Model_ERP_V2.png", width: 80mm)
  ]),
  grid.cell([*C*
      #image("graphics/use_cases/Base_Kelly_Model_EEG_noise_V2.png", width: 80mm)
    ]),
  grid.cell([*D*
      #image("graphics/use_cases/Base_Kelly_Model_ERP_noise_V2.png", width: 80mm)
    ])), caption: flex-caption([#abbr.a("EEG") and #abbr.a("ERP") of a 'SCR' sequence using #abbr.s("KellyModel") as 'C' component. *A:* Raw #abbr.a("EEG") signal from two repetitions of the 'SCR' sequence. *B:* #abbr.a("ERP") with a distinction between fast and slow response time. *C:* #abbr.a("EEG") signal with PinkNoise(noiselevel=1). *D:* #abbr.a("ERP") with a distinction between fast and slow response time and PinkNoise(noiselevel=1).],[EEG and ERP of a 'SCR' sequence using KellyModel as 'C' component])
)<fig:BasicKellysim>
In the diagram of the EEG signal without noise from @fig:BasicKellysim A, you can directly see how the additional parameters have an influence compared to the other two #abbr.pla("SSM"). For example, the delay in the start of the accumulation after the end of the stimulus due to the sensory encoding is recognisable. Furthermore, the excess after reaching the threshold at 1.0 and the subsequent slow linear decay can be seen. This is also reflected in the #abbr.a("ERP"), as it now looks more like a normal distribution. This is due to the variabilities in sensor and motor delay as well as the difference in drift\_rates. Additionally, the #abbr.a("ERP") now captures the distinction between fast and slow response times. To achieve this, individual trials were categorized based on whether the response time of the 'C' component was above or below the median. The effects of this classification are visible in tile B, specifically in the middle #abbr.a("ERP") diagram for the 'C' component. Notably, the blue trace, representing trials with shorter response times, reaches the threshold and peaks earlier, as expected. Consequently, these traces also return to zero sooner, indicating an earlier onset of the response event. The 'S' and 'R' components, however, do not show any effect of this division, as they are not influenced by it.

Tiles C and D using the PinkNoise reflect the same findings as the previous simulations and the events are relatively easy to recognise in the #abbr.a("ERP").

With these basic simulations, the possible customisation options of #abbr.pla("SSM") could be demonstrated using the basic application. In addition, the clear differences between the models can be recognised, making it necessary to consider which model could be used for which research objectives. In the next section, two use cases will be discussed in more detail, one with the #abbr.s("KellyModel") and the other with the #abbr.s("LBA").

== Deconvolution as a method for correcting an overlap between components<subsec:deconv>
As specified in the description of the #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl] package, such a package can be used to analyse tools and test, validate other toolbox functionalities. This is precisely the case in the two use cases that are build up below. In these cases, the deconvolution method is analysed with the help of the DriftComponent extension. In addition, it can also be shown how the extension can support the further investigation of the discussion between @Fromer2024 and @Comment2024Fromer, described in @subsec:motivation.

*Simulate an Overlap using the #abbr.s("KellyModel"):*
The aim of this UseCase is to simulate an overlap between a simple stimulus component and the DriftComponent with the #abbr.s("KellyModel"). This overlap should then be separated back into the individual components by deconvolution.

The basis from @subsec:simspace is used again for the setup of the simulation. However, this must now be adapted slightly to create the desired overlap. The drift\_rates in the design are changed to 3 and 5. In addition, the negative response component has been replaced by a positive one to enable a positive overlap. There are now two ways to create an overlap from the evidence accumulation to the response component. Firstly, the motor encoding delay parameters (motor\_onset, motor\_delay) and post accumulation spike parameters (post\_accumulation\_duration, post\_accumulation\_duration\_variability) of the #abbr.s("KellyModel") could be adjusted so that there is no delay and the spike is extended. This would cause the response component to start earlier and cause an overlap. An example parameter definition for this is shown in the following @tab:KellyOverlapParams.
#figure(
  table(
    columns: (auto, auto, auto, auto),
    inset: 2pt,
    align: horizon,
    table.header(
      [motor\_onset], [motor\_delay], [post\_accumulation\_duration],[post\_accumulation\_duration\_variability]
    ),
    "0.1", "0.05","0.4", "0.1",
  ), caption: flex-caption([Model parameters for #abbr.a("KellyModel") overlap simulation],[Model parameters for Kelly Model overlap simulation])
)<tab:KellyOverlapParams>
Another somewhat simpler option is to shorten the onset of the subsequent response component and thus have it start earlier. The implementation used here is that a DriftComponent accepts a tuple of onsets. This means that in addition to the DriftOnset, which returns the standard response time of the model, a UniformOnset is also defined. With the UniformOnset, a fixed value can be added/subtracted to the given response time of the DriftOnset. In the simulation, the default parameters of the #abbr.a("KellyModel") were used.

#figure(
  image("graphics/use_cases/Onset_Progession_Kelly_Overlap.png", width: auto),
  caption: flex-caption([Progression of the onsets for a 'SCR' sequence with the following onsets defined: 'S'=>UniformOnset(width=40,offset=600), 'C'=>(DriftOnset(), UniformOnset(width=0, offset=-100)), 'R'=>UniformOnset(width=100,offset=1000). The onset of 'S' event is marked with the blue line, 'C' with orange, 'R' with green and the DriftOnset response time with yellow.],[Progression of the onsets for a 'SCR' sequence])
)<fig:onsets>
The onsets for the simulation are defined as follows:
- 'S'=>UniformOnset(width=40,offset=600),
- 'C'=>(DriftOnset(), UniformOnset(width=0, offset=-100)),
- 'R'=>UniformOnset(width=100,offset=1000)
The 'S' and 'R' components use a UniformOnset with a fixed offset and a variable width, which follows a standard deviation. In contrast, the 'C' component is defined as a tuple combining DriftOnset and UniformOnset, ensuring an intentional overlap with the upcoming 'R' event. The offset of -100 in UniformOnset subtracts 100 time steps from the response time provided by the DriftOnset.

An important aspect to note is that the onsets are cyclically linked, meaning:

- The onset definition of 'S' determines the beginning of the 'C' event.
- The onset definition of 'C' determines the start of 'R'.
- The onset definition of 'R' determines the next occurrence of 'S'.
To better understand this concept, refer to @modeling, where the implementation details are described. Additionally, @fig:onsets illustrates an example of two trials of onsets. In this figure:

- The first event 'S' (marked in blue) begins after 1100 time steps, as dictated by the 'R' onset definition.
- Then, the 'S' onset definition (with an offset of 600) triggers the 'C' event (marked in orange).
- The 'C' component onset has two marks:
  - The response time determined by the DriftOnset (yellow mark).
 - The final 'C' onset, which is the sum of the DriftOnset and the UniformOnset (with a -100 offset), resulting in the green mark.
- The green mark then determines the start of the 'R' event.
This process is repeated across all trials, ensuring consistent onset relationships between the components.

The results of the simulation are shown below in @fig:KellyOverlapSim.
#figure(
grid(
  columns: 2,
  rows: 2,
  align: left,
  gutter: 1cm,
  grid.cell([*A*
    #image("graphics/use_cases/Overlap_Kelly_EEG_V2.png", width: 80mm)
  ]),
  grid.cell([*B*
    #image("graphics/use_cases/Overlap_Kelly_ERP.png", width: 80mm)
  ]),
  grid.cell([*D*
    #image("graphics/use_cases/Overlap_Kelly_ERP_slow_response.png", width: 80mm)
    ]),
  grid.cell([*C*
      #image("graphics/use_cases/Overlap_Kelly_ERP_deconv.png", width: 80mm)
    ])), caption: flex-caption([#abbr.a("EEG") and #abbr.a("ERP") of a 'SCR' sequence using #abbr.a("KellyModel") as 'C' component with an overlap between 'C' and R],[EEG and ERP of a 'SCR' sequence using KellyModel as 'C' component with an overlap between 'C' and R])
)<fig:KellyOverlapSim>
Tile A shows the #abbr.a("EEG") signal from two trials. A minimal overlap can be seen in the first and a somewhat clearer one in the second. This results from the fact that a variability in motor delay is integrated in the #abbr.a("KellyModel") parameters. This overlap is directly reflected in the #abbr.a("ERP") from tile B. In this you can see how the response component never starts at 0 as it should and thus includes the previous course of the 'C' component. The same can also be seen at the end of the 'C' component, which does not run towards 0 but starts to reverse again at 0.5 and merges into the 'R' component.

Such an overlap is not unusual in #abbr.a("EEG") research and occurs relatively frequently, as shown by @Fromer2024 and @connell2021kelly. The #link("https://github.com/unfoldtoolbox/Unfold.jl")[Unfold.jl] package offers a possibility of deconvolution for a renewed equalisation into the individual components. The resulting #abbr.a("ERP") is shown in tile C directly below the "normal" #abbr.a("ERP"). In tile C you can see in comparison how the deconvolution method worked and the 'R' component starts again at 0 and assumes the normal course except for a small time shift. The same can also be seen for the 'C' component at the end, where it now also runs in the direction of 0. 

This showed how an overlap using #abbr.a("KellyModel") and two basic components can be simulated and corrected at the end. It can therefore be concluded that the deconvolution method of #link("https://github.com/unfoldtoolbox/Unfold.jl")[Unfold.jl] works for such a use case.

As an additional small investigation, the influence of the choice of two different drift\_rates can be seen in tile D. In this, the total DriftComponent events were again divided into fast and slow responses according to their mean response time. This shows that the processes labelled as slow reactions have a lower and slower peak value. It is mainly due to the lower drift\_rate of 3 in contrast to the fast reactions with 5. Thus showing how such variation in experimental design can be utilised for different experiments.

*No component activity after deconvolution:*
In this second use case, the first is extended again and an attempt is made to adapt it in the direction of the findings from @Fromer2024. In their publication, as already described in @subsec:motivation, they had shown that in some studies investigating decision-making, the ramp-up component in #abbr.a("CPP") disappears after deconvolution. This needs to be replicated in a simulation, where two overlapping components create the illusion of a third component in the #abbr.a("ERP"). However, after applying deconvolution, this apparent component disappears, revealing that it was merely an artifact of signal overlap. This extends the previous use case, where a real component contributed to the overlap, and all genuinely present components remained after deconvolution. In contrast, this simulation demonstrates how an artificially induced activity —one that never existed as a distinct component— vanishes upon proper signal separation, highlighting the effectiveness of deconvolution in disentangling overlapping signals.

A sequence design consisting of two "SR" events was created for the simulation setup. Like the previous designs, this was supplemented with a list of drift\_rates. This time, the list of drift\_rates contains 500 normally distributed values with an average of 1.2 and a standard distribution of 0.5 and therefore a result as shown in @grid:drift_rate_dist.
#align(center)[
#figure(grid(columns: 2, gutter: 0.2cm,
  "1.39",  "2.00",
  "1.98",  "1.30",
  "1.11",  "0.32",
  "0.94",  "0.32",
  "2.13",  "0.72",
  "...", "...",
  "1.65",  "2.03",
  "1.26",  "1.43"
), caption: [Drift\_rate distribution for simulation])<grid:drift_rate_dist>]
Due to the resulting 500 conditions, no further repetition of the design was carried out, as there are therefore 1000 events. The Kelly model with the parameters defined as follows @tab:KellyCPPParams was used as components for 'S'.
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 2pt,
    align: horizon,
    table.header(
      [drift\_rate], [motor\_onset], [post\_accumulation\_duration],[ramp_down_duration],[boundary]
    ),
    "5.5", "0.6","0.0", "0.6", "0.5",
  ), caption: flex-caption([Model parameters for #abbr.a("KellyModel") deconv use case simulation],[Model parameters for Kelly Model deconv use case simulation])
)<tab:KellyCPPParams>
This parameter setting ensures that the #abbr.a("KellyModel") reaches the boundary early and pulls the ramp down into the next 'R' component with a long delay. The motor delay and ramp down are therefore extended and the post accumulation spike is prevented.

The component for 'R' was defined as a DriftComponent with an #abbr.a("LBA"). This uses the drift\_rate specified in the design and has the following parameter definition.
#figure(
  table(
    columns: (auto, auto, auto, auto),
    inset: 2pt,
    align: horizon,
    table.header(
      [Linear accumulation rate (v)], [Starting point distribution (A)], [Threshold (k)],[Non-decisional time (Ter)]
    ),
    "\"drift_rate\"", "0.01","1.8", "0.0",
  ), caption: flex-caption([Model parameters for #abbr.a("LBA") deconv use case simulation],[Model parameters for LBA deconv use case simulation])
)<tab:OverlapLBAparams>
This defines the components to simulate an activity between these two, using an overlap. As an onset for the #abbr.a("KellyModel"), the option of specifying a tuple as _(DriftOnset(), UniformOnset(width=0,offset=-10))_ was used. With this notation the response time can be reduced slightly by 10. As the UniformOnset has an offset of -10. For the #abbr.a("LBA"), the maximum length of the possible simulation of the component (sample\_frequency\*time\_end) was selected as onset. The simulation produces the results shown below in @fig:CPPActivitySim.
#figure(
grid(
  columns: 2,
  rows: 1,
  align: left,
  gutter: 1cm,
  grid.cell([*A*
    #image("graphics/use_cases/NoComponent_EEG_V2.png", width: 80mm)
  ]),
  grid.cell([*B*
    #image("graphics/use_cases/NoComponent_ERP_all_label_V2.png", width: 80mm)
  ])), caption: flex-caption([#abbr.a("EEG") and #abbr.a("ERP") of a 'SR' sequence with an overlap between 'S' and 'R'. *A:* Raw #abbr.a("EEG") signal for four repetitions of the sequence, showing the overlap between the two components. *B:* #abbr.a("ERP") and deconvolution of the 'S' and 'R' component.],[EEG and ERP of a 'SR' sequence with an overlap between 'S' and 'R'])
)<fig:CPPActivitySim>
Tile A shows the #abbr.a("EEG") of the trials. This clearly shows how the two components overlap. During the ramp down of the #abbr.a("KellyModel"), the #abbr.a("LBA") already begins, which means that it starts to increase. In addition, the variations can be seen in the drift\_rate and the delay as well as the resulting intensity of the overlap.

In the "normal" #abbr.a("ERP") in tile B in the above figure, the events described show an activity between 'S' and 'R'. In the figure, this could suggest that there is another active component between the two components 'S' and 'R'. This component would therefore not be an artefact as an overlap but a real brain activity. However, this cannot be answered in the #abbr.a("ERP") and can only be guessed whether it is a real activity or just an artefact coming from a overlap. As a component overlap can look like evidence accumulation. Therefore a deconvolution would be advisable.

The lower part of tile B from @fig:CPPActivitySim shows the #abbr.a("ERP") with deconvolution. In this, the 'S' and 'R' components have been separated from each other, causing the supposed activity to disappear. As a result, there is no longer any effect between the two components, which means that they once again correspond to their original separate form. This shows that if there really is a component between the two, it should also be visible in the deconvolution. As it was shown in the previous use case. But now in this one similar to the findings of @Fromer2024 a activity coming from an overlap can be removed by using the deconvolution method.

*@Comment2024Fromer comment on @Fromer2024 rebuild:*
In this last use case, a replica of a study from the comment by @Comment2024Fromer is created. This is intended to demonstrate the further application possibilities of the extension in research. In the study by @Comment2024Fromer, the methodology used to analyse the #abbr.a("EEG") studies by @Fromer2024 was investigated by using ramping evidence accumulation signals. The focus was primarily on the "normal" mass-univariate #abbr.a("ERP") and the deconvolution with #link("https://github.com/unfoldtoolbox/Unfold.jl")[Unfold.jl]. In the comment, ramping evidence accumulation signals (similar to #abbr.a("LBA")) were simulated from a stimulus to the peak and thus response with different drift\_rates. These were then displayed in the mass-univariate #abbr.a("ERP") and the deconvolution.

For the reconstruction with this #link("https://github.com/unfoldtoolbox/Unfold.jl")[Unfold.jl] extension, an ‘SR’ design is therefore used, where 'S' represents a drift component with #abbr.a("LBA") and 'R' is an empty component which only has the event onset at the peak of the #abbr.a("LBA"). For the variability in the drift\_rates, the list of distributed drift\_rates was added to the design as in the previous use case (see @grid:drift_rate_dist). The following parameters listed in @tab:CommentLBAparams were selected for the #abbr.a("LBA") in order to obtain a replica that is as true to the original as possible.
#figure(
  table(
    columns: (auto, auto, auto, auto),
    inset: 2pt,
    align: horizon,
    table.header(
      [Linear accumulation rate (v)], [Starting point distribution (A)], [Threshold (k)],[Non-decisional time (Ter)]
    ),
    "\"drift_rate\"", "0.01","0.8", "0.0",
  ), caption: flex-caption([Model parameters for #abbr.a("LBA") comment rebuild use case simulation],[Model parameters for LBA comment rebuild use case simulation])
)<tab:CommentLBAparams>
In the comment, the signals also started at 0 and had a threshold of 0.8. The non-decisional time is set to 0, as this means that the response is directly at the peak of #abbr.a("LBA"). The DriftOnset was also selected for this component and the maximum simulation length of 1 was simply selected for the empty component.The simulation could then be carried out and the results shown in @fig:CommentRebuildSim were obtained.
#figure(
grid(
  columns: 2,
  rows: 1,
  align: left,
  gutter: 1cm,
  grid.cell([*A*
    #image("graphics/use_cases/Comment_LBA_EEG.png", width: 80mm)
  ]),
  grid.cell([*B*
    #image("graphics/use_cases/Comment_LBA_ERP_all_V2.png", width: 80mm)
  ])), caption: flex-caption([#abbr.a("EEG") and #abbr.a("ERP") of the rebuild from @Comment2024Fromer. *A:* Raw #abbr.a("EEG") signal of four repetitions. *B:* #abbr.a("ERP") and deconvolution of the 'S' and 'R' locked events.],[EEG and ERP of the rebuild from @Comment2024Fromer])
)<fig:CommentRebuildSim>
On the left-hand side in tile A, the raw #abbr.a("EEG") signal is shown again. This shows how the ramping evidence accumulation signals from the stimulus onset in blue to the response onset in green show a linear accumulation. The variation of the distributed dirft\_rate can also be seen. This looks very comparable to the upper part of Figure 1b from the comment by @Comment2024Fromer. The more interesting part, however, is tile B, which contains the summary of Figure 1b and 1f from the comment by @Comment2024Fromer. In tile B, the mass-univariate #abbr.a("ERP") is shown in the part above, once stimulus-locked and once response-locked. This representation is very close to that of @Comment2024Fromer from Figure 1e, but the overall distortion of the x-axis should be noted. The lower part of tile B also shows the deconvolution of the stimulus-locked and response-locked component. This comes very close to Figure 1f from @Comment2024Fromer and thus also fulfils the expectations. Overall, this final use case demonstrates how the #link("https://github.com/unfoldtoolbox/Unfold.jl")[Unfold.jl] extension can be applied in research. For instance, the simulations conducted by @Comment2024Fromer could have been performed using this extension. Moreover, this represents just one specific example where #abbr.a("SSM")-based simulations were used for a targeted investigation. In the future, there may be even greater potential for utilizing such simulations to explore neural processes underlying decision-making.

