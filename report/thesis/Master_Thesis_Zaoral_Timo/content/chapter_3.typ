#import "@preview/abbr:0.1.1"
#import "../src/styles/flex-captions.typ": flex-caption
= Implementation

This chapter describes the implementation and integration of the DriftComponent extension in #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl]. The first part covers the basic implementation and the second part addresses the integration and related topics.

== Sequential Sampling Models<subsec:ssm>
This section examines the #link("https://github.com/itsdfish/SequentialSamplingModels.jl")[SequentialSamplingModels.jl] package @SequentialSamplingModels2025 used for the #abbr.pla("SSM") and the additional functions it requires. It outlines the requirements, the final package selection, and also includes a separate discussion on the refactoring of the #abbr.a("KellyModel").

=== The #link("https://github.com/itsdfish/SequentialSamplingModels.jl")[SequentialSamplingModels.jl] Package
We chose to use the preexisting #link("https://github.com/itsdfish/SequentialSamplingModels.jl")[SequentialSamplingModels.jl] package @SequentialSamplingModels2025 for their well-documented implementations of the #abbr.a("LBA") and the #abbr.pla("DDM"). Furthermore the package is regularly maintained and further developed.

In the #link("https://github.com/itsdfish/SequentialSamplingModels.jl")[SequentialSamplingModels.jl] package the two required #abbr.pla("SSM") #abbr.a("LBA") and #abbr.pla("DDM") are split into two functions: defining model parameters and simulating. The simulation function shown below as @eq:simFunc uses a random object, the associated model with parameters and a sampling rate as parameters. From this, the function then simulates the time\_steps, i.e. a time vector in steps of the sampling rate and the associated evidence at the respective point in time.
#figure(
```julia
using SequentialSamplingModels as SSM

time_steps, evidence = SSM.simulate(rng,model;Δt=0.001)
```)<eq:simFunc>
Historically the function of the #abbr.a("LBA") was adapted to the syntax of the function of the #abbr.a("DDM") in collaboration with the developers of the #link("https://github.com/itsdfish/SequentialSamplingModels.jl")[SequentialSamplingModels.jl] package. In addition, a small bug in the simulation was removed. Credits at this point for the quick reaction and co-operation with the developers.

The simulation functions then only had to be encapsulated by the multiple dispatch functionality of Julia. Therefore, the following @eq:ssmSimFunc was defined for each of the two models.
#figure(
  [```julia
SSM_Simulate(rng,model::(LBA/DDM),sfreq,max_length)::Tuple{Float64, Vector{Float64}}
```#link("https://github.com/unfoldtoolbox/UnfoldSim.jl/blob/844262e9544e2b0aaa6557291c21c06bdf6cd929/src/sequentialSamplingModelSimulation.jl#L227C1-L307C4")[Further details about the code on GitHub]])<eq:ssmSimFunc>
In each of these, the model simulate @eq:simFunc is called and the response time is then determined as _rt_ and, if necessary, the evidence length is shortened to _max\_length_ as there should be a maximum range for a simulated signal. Finally, the response time _rt_ and the _evidence_ vector are returned.

All in all, this can be used to simulate the progressions of the respective models. Therefore these functions can be integrated into #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl] at a later stage.

=== Refactoring of the #abbr.a("KellyModel")
As already described in @subsec:kelly the implementation by @Kelly2021notebook was in MATLAB and roughly transferred to Julia by Benedikt Ehinger #cite(<Benedikt2025>). Therefore, I first refactored and reimplemented the functionality. The refactoring included the creation of a composite type as #abbr.a("KellyModel") with sensibly described parameters and documentation. 

Additionally, the evidence accumulation function of the model required a complete revision, as its previous implementation contained numerous parameters and was difficult to interpret. The simulation process has been simplified, making it more intuitive and accessible. Furthermore, the new simulation function was adapted to align with the existing "SSM_Simulate" paradigm @eq:ssmSimFunc. As a result, it now clearly incorporates appropriate model parameters by passing the model class.

The usage of the same "SSM\_Simulate" function ensures a general use for the simulation of #abbr.pla("SSM"), as all models are used for simulation via a single function call with the corresponding parameter. In addition the functionality can be easily extended with other models. Under this condition, the previous implementation can be used and integrated into #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl], as described in the next chapter.

== Integration to UnfoldSim <integration>
The groundwork for integration into #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl] has been established. However, further adaptations are needed to align with the package's modular structure and ensure seamless integration.
The most important elements of the modularity of #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl] are the design, components, onsets and additional functionalities/models. For each of these elements, structures and functions must be newly created or reused in order to enable successful integration in the end. The following section describes the integration step by step using a modular building block kit and finally illustrates the interaction.
=== Modeling the Integration <modeling>
The initial step is to outline the modular building block kit to determine which elements need to be expanded.
#figure(
  image("graphics/modeling/empty_building_box.png", width: 80%),
  caption: flex-caption(
    [Empty building box of #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl] elements],
    [Empty building box of #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl] elements],
  ),
) <fig:empty_building_box>
The three existing elements Design, Component and Onset are shown in the @fig:empty_building_box. These structures are already in place for other simulations and are utilized accordingly. The *green* Model simulation component is a new functionality that should contain the #abbr.pla("SSM").

The empty elements in the @fig:empty_building_box are now sequentially discussed and filled with implementation parts from left to right. The first element "Design" represents the experimental setup for the simulation, such as one or more participants performing conditions classified as heavy, medium, and light. Existing designs that are important for the DriftComponent extension are the SingleSubjectDesign, SequenceDesign and RepeatDesign. The SingleSubjectDesign is used as the base and defines the conditions of a single participant. The SequenceDesign is the decisive one for the DriftComponent extension, as it defines a sequence of components/events. Therefore it allows to build a complex of a stimulus, evidence accumulation and response signal ('SCR'). Finally, the RepeatDesign is used for the repetition of previously defined designs, so that a sequence is repeated 100 times, for example. The designs are predefined and can therefore be reused without the need for customisation. They are therefore already inserted in @fig:component_building_box as blue rectangles.
#figure(
  image("graphics/modeling/component_building_box.png", width: 80%),
  caption: flex-caption(
    [Building box with component adjustments of #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl] package],
    [Building box with component adjustments of #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl] package],
  ),
) <fig:component_building_box>
In the @fig:component_building_box, the first new structure DriftComponent and associated functions have also been added to the component group. 
#math.equation(block: true,numbering: "(1)", supplement: [function], $"DriftComponent(max_length::Int, sfreq::Real, model_type::Any, model_parameters::Dict)"$)<eq:DriftComponent>
A DriftComponent is defined as described in @eq:DriftComponent by a max\_length the maximum length of a simulated component, sfreq the sampling frequency, model\_type the #abbr.a("SSM") type and model\_parameters the parameter specifications for the #abbr.a("SSM"). This means that this component of #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl] can be selected for a simulation. However, a few associated functions are still missing to run the simulation. One of these is the "get_model_parameter" function, which fulfills the purpose of making it possible to specify parameters for an #abbr.a("SSM") as a condition in the design. A key value pair for the parameter is specified in the design and the key is referenced as a string in the model\_parameters dict. The function then unpacks the values from the design for the model as parameters. The advantages of this are shown in @sec:usecases. 

The second function is "calculate_response_times_for_ssm", which determines the response times of the simulated traces for the onsets. This will be discussed further in the description of the onsets. Finally, the "simulate_component" function which ultimately performs the simulation of the #abbr.a("SSM") traces based on the transferred DriftComponent and design. This calls the function "trace_sequential_sampling_model" which is now added to the "Model simulation" functionality in the following extended diagram @fig:ssm_building_box of the building box.
#figure(
  image("graphics/modeling/ssm_building_box.png", width: 80%),
  caption: flex-caption(
    [Building box with component adjustments of #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl] package],
    [Building box with component adjustments of #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl] package],
  ),
) <fig:ssm_building_box>
The structures and functions described in the previous section @subsec:ssm, such as the #abbr.a("KellyModel"), have now been added to the @fig:ssm_building_box. On the other hand, new functions such as the previously mentioned "trace_sequential_sampling_model" have also been added. 
#figure(
  image("graphics/modeling/trace_ssm_flow.png", width: 80%),
  caption: flex-caption(
    [Flow chart of the trace_sequential_sampling_model function],
    [Flow chart of the trace_sequential_sampling_model function],
  ),
) <fig:trace_flow>
The flow of the function is shown in @fig:trace_flow. First, the function creates a DataFrame of events from the given design. The events are iterated over, and the 'get_model_parameters' method is called for each event, allowing for the definition of different parameters per event. The event is represented by an ellipse in the diagram, as it is provided as a parameter in each iteration of the loop. The actual simulation of the response time and the evidence accumulation of the model can then be carried out. This is done by calling the "SSM_Simulate" method, which has also already been described. Once all events have been processed, a list of response times and a matrix of the associated traces of evidence is returned. This function therefore maps the complete simulation scope of #abbr.pla("SSM").

#figure(
  image("graphics/modeling/onset_building_box.png", width: 80%),
  caption: flex-caption(
    [Building box with onset adjustments of #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl] package],
    [Building box with onset adjustments of #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl] package],
  ),
) <fig:onset_building_box>
The last building block is the onset component. This is used to define a time onset for events in #abbr.a("EEG"), i.e. when an event has to start.
The structures and functions added to the entire building box are therefore entered in the @fig:onset_building_box. Two structures have been added to the onset group, the SequenceOnset and the DriftOnset. As the name suggests, a SequenceOnset defines a dictionary of event to onset relations for a SequenceDesign. This means that each defined event in the sequence can have its own onset definition.

An onset is therefore also required for the DriftComponent. This was defined with the DriftOnset structure itself. The idea behind the DriftOnset is to use the response time simulated by #abbr.a("SSM") as the onset for the next event. This is why the aforementioned function "calculate_response_times_for_ssm" was implemented, which returns the pure response times of the simulation and can therefore be used as an onset. To create the DriftOnset, the general function "simulate_interonset_distances" is dispatched and calls "calculate_response_times_for_ssm" and returns the response times. As an additional functionality, the function is dispatched again, but this time it accepts a tuple (DriftOnset, UniformOnset). A UniformOnset can be used to define a fixed value as an onset. This is used here to have a fixed influence on the DriftOnset. Examples of use are shown in @sec:usecases.

Another convenience function is a dispatch of the "simulate_interonset_distances" function with the option of specifying "\_" as an onset. This special specification means that the maximum length of the respective component is used as the onset. In sequence design, for example, this can be used as a separation after each sequence.

Last but not least, the all-encompassing dispatch function for the SequenceOnset must be created. This has the special task of generating all onsets for the events in the sequence and adding them up at the end. Since a #abbr.a("EEG") is a continuous signal and therefore the onsets always increase from event to event. In addition, in this case there is the special feature that in the SequenceOnset the defined onset of a component defines the actual onset for the next component. An example is provided below for better visualisation.
#figure(
grid(
  columns: 2,
  rows: 1,
  align: left,
  gutter: 1cm,
  grid.cell([*A*
    #table(
    columns: (auto, auto),
    inset: 4pt,
    align: horizon,
    table.header(
      [*Event*], [*Onset*]
    ),
    "S", "UniformOnset(100)",
    "C", "DriftOnset()",
    "R", "UniformOnset(150)",
  )
  ]),
  grid.cell([*B*
    #table(
    columns: (auto, auto, auto, auto),
    inset: 4pt,
    align: horizon,
    table.header(
      [*Event*], [*Onset per component*], [*Onset shifted*], [*Onset accumulated*]
    ),
    "S", "100", "150", "150",
    "C", "320", "100", "250",
    "R", "150", "320", "570",
    "S", "100", "150", "720",
    "C", "280", "100", "820",
    "R", "150", "280", "1100",
  )
  ])), caption: flex-caption([SequenceOnset Example. *Table A:* Event Onset definition for a 'SCR' sequence. *Tabel B:* Onset calculation sample for two repetitions of the sequence.],[SequenceOnset Example])
)<grid:SequenceOnset>
The onset definitions of the events are given in Table A, which results in an onset for 'S' of 100 time steps for 'C' a flexible one depending on the response time and for 'R' of 150 time steps. This is also reflected in the second column of Table B, as the example sequence of two repetitions is shown here. The third column of B then shows the onsets shifted by one, which results in the start of each subsequent event. Finally, in the final result in column four of table B, the totalised onset times are given, which then also apply to the #abbr.a("EEG").

This completes the source code technical integration in #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl] and all elements have been created or reused appropriately if possible. The following shows a complete picture of the interaction of the elements.

#figure(
  image("graphics/modeling/overall_few.png", width: 90%),
  caption: flex-caption(
    [Complete picture of the elements interaction in the #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl] package],
    [Complete picture of the elements interaction in the #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl] package],
  ),
) <fig:overall>
This example shows an 'SCR' sequence design. A DriftComponent with the #abbr.a("LBA") was used for the 'C' component. The DriftOnset was therefore also specified for 'C' in the SequenceOnset. By shifting the SequenceOnset, the DriftOnset is not used for 'C' as shown in the figure, but for the subsequent 'R' Event(yellow). Similarly, the UniformOnset of the 'S' component is applied to 'C', blue event. This shows the entire chain of interacting modules and can be applied and extended in a modular way. Concrete examples of application are shown in the @sec:usecases.
=== Tests
In order to deliver a complete development and integration scope, it is also crucial to provide reasonable tests in the implementation. In the #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl] package, unit tests have already been created for the main elements, design, component and onset. It was therefore necessary to create tests for the added elements as shown in the building box @fig:onset_building_box.

Unit tests were therefore written for the DriftComponent and associated functions to check the basic functionality of the functions. As the two implemented simulation methods access the functions of the "Model simulation", their integration was also tested. Another important test coverage was the verification and application of a random seed, which can be used to check the reproducibility of the simulation results and their consistency. As this is a very important part of the simulation, because it  should deliver the same results for the same random seed applied.

The tests for the "Model simulation" group had to be newly created, just like the implementation itself. On the one hand, the #abbr.a("KellyModel") structure was tested. On the other hand, the basic functions of the #abbr.pla("SSM") simulation were tested. This included unit tests from the lowest level of the individual model simulations to the overarching method "trace\_sequential\_sampling\_model". Its integration into the overall simulation has already been tested on the DriftComponent side.

Finally, the onset structures and their functionalities were tested. This was tested analogue to the resolution of the onsets shown in @grid:SequenceOnset. It was particularly important to test the special functionality of the combination of DriftOnset with UniformOnset, as this represents an important core component for later use cases @sec:usecases.

Overall, the newly added functionalities were tested as part of the existing test structure of the #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl] package. This ensures functionality and integration in line with the existing framework.

=== Documentation

The last equally important part of an implementation and integration into an existing package is the documentation. This includes code comments, DocStrings and also a contribution to the #link("https://unfoldtoolbox.github.io/UnfoldSim.jl/stable/")[public documentation page] of the package.

The development team created a specific DocString template for the #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl] package. This was also used here and a suitable DocStrings were written for each new function and structure. This facilitates the contribution of other interested parties to the package enormously and is also essential for uncomplicated use of the extension. In addition, inline code comments have been added for longer, more complicated functions, such as the #abbr.a("KellyModel") simulation function. This ensures easier maintainability and customisation.

The #link("https://unfoldtoolbox.github.io/UnfoldSim.jl/stable/")[public documentation page] of the #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl] package is structured according to the Diátaxis framework @ament_diataxis. Technical documentation is divided into the four categories _tutorials, how-to guides, technical reference and explanation_. As part of the added DriftComponent extension, it makes sense to design two _how-to guides_. A somewhat simpler basic guide on how to use the DriftComponent for simulation. A second, somewhat more complex guide, which deals with a more specialised use case.

Therefore, the basic how-to guide explains "How to Simulate an Evidence Accumulation EEG". It explains step by step how the process works. First the setup, then create a design, select the components, define onsets and finally simulate and display in a figure.

In the second how-to guide, "How-to Simulate an Evidence Accumulation Overlap and Deconvolution", the use case of an overlap simulation and subsequent deconvolution described in the following @subsec:deconv is explained.