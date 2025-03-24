#import "../src/styles/flex-captions.typ": flex-caption
#import "@preview/abbr:0.1.1"
#import "@preview/big-todo:0.2.0": todo
= Fundamentals/Foundations
This chapter serves as an introduction, offering an overview of the terminology and to lay the foundations for the following chapters of the thesis. These foundations consist of a brief explanation of #abbr.a("EEG"), #abbr.a("ERP"), Neural Implementation of the Decision-Making Process and the introduction of #abbr.pla("SSM") and the #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl] package.
==  Electroencephalography and Event-related potentials
=== #abbr.a("EEG")
#abbr.a("EEG") is a technique for continuously recording electrical voltage fluctuations that reflect brain activity and are measured using electrodes attached to the scalp. However, EEG has inherent limitations due to the brain’s natural structure. The human skull, positioned between the brain potentials and the electrodes, attenuates and distorts the signals. As a result, EEG is more sensitive to activity from the outer cortical layers while being less effective at capturing signals from deeper brain structures. The consequence of the limitations is a poorer spatial resolution @EEGCite. The poor spatial resolution of #abbr.a("EEG") can limit our ability to precisely localize the neural sources of decision variables and to distinguish different accumulation mechanisms occurring at various brain levels.

=== #abbr.a("ERP")
#abbr.a("ERP") are neural responses derived from the continuous #abbr.a("EEG") signal, obtained by averaging time-locked activity across repeated occurrences of the same event. #abbr.a("ERP") reflect the brain’s processing of specific stimuli, such as visual images or motor responses, by isolating stimulus-related electrical activity from ongoing neural fluctuations. Since individual #abbr.a("EEG") recordings contain significant noise, #abbr.a("ERP") waveforms are typically averaged across multiple trials and participants to improve the signal-to-noise ratio, making it easier to identify consistent neural responses @luck2014introduction.

=== Overlapping potential artifact
In #abbr.a("EEG") analysis, overlapping potential artefacts occur when neuronal signals from different cognitive or motor processes overlap and disturb the measured waveform. For example, activity related to sensory processing can overlap with subsequent motor-related activity, creating a combined signal that does not accurately reflect either process individually. In experiments involving both stimulus presentation and motor responses, this can lead to ambiguities in interpreting #abbr.a("ERP"). To address this issue, deconvolution techniques are used in #abbr.a("EEG") analysis to separate overlapping neural signals, improving the accuracy of #abbr.a("ERP") analysis @Ehinger2019.

== Neural Implementation of the Decision-Making Process
A part of cognitive neuroscience is investigating the neural mechanisms underlying decision-making, one research goal is to understand how the brain collects and processes information in order to make a decision.
The investigation of electrophysiological signals such as #abbr.a("EEG") or magnetoencephalography (MEG) play an important role in this. Thanks to their high temporal resolution, these signals make it possible to observe neuronal dynamics during a decision-making task in real time. This makes it possible to identify indicators and influencing factors in the neuronal mechanism of decision-making processes @connell2021kelly@vanvugt2019cppxdmp.

This has led to an increasing number of scientific papers investigating how brain regions and neuronal circuits contribute to the decision-making process.
Further research has identified the #abbr.a("CPP") as a neural marker of decision-making, recorded using EEG electrodes (Cz, CPz, and Pz) over centro-parietal scalp regions. This signal refers to the process of accumulating evidence up to a decision threshold. The decision threshold indicates the point at which enough evidence has been accumulated to make a decision. How exactly the #abbr.a("CPP") signal emerges as a neural correlate of decision-making is still unclear. However, some insights into the #abbr.a("CPP") have been gained. A steeper #abbr.a("CPP") indicated a faster accumulation of evidence, which leads to a faster decision. In addition, the #abbr.a("CPP") was active in both perceptual and memory decisions, reflecting similar dynamic processes but with a delay in perceptual decisions. The #abbr.a("CPP") also showed a graded response depending on the difficulty of the decision. Thus, more difficult tasks have a lower amplitude of the #abbr.a("CPP"). This establishes the #abbr.a("CPP") as a useful marker for investigating the neural basis of decision making @connell2021kelly@vanvugt2019cppxdmp@kelly2013internal.

By using #abbr.pla("SSM") to interpret neural data, promising progress has been made in understanding the temporal dynamics of decision-making processes. Publications such as those by @connell2021kelly and @van2012eeg show that #abbr.a("EEG") can capture neuronal signatures of evidence accumulation in real time by linking specific #abbr.a("SSM") parameters, such as drift rate, to observable neuronal signals. In this way, the #abbr.a("CPP") could again be used to compare neurophysiological data with the decision-making processes generated from #abbr.a("SSM"). Such comparisons can provide deeper insights into how the underlying cognitive mechanism of decision-making takes place in the brain @forstmann2016sequential@mulder2014perceptual. This is also supported by the publication of @murphy2016neural who demonstrated that decision-related neural signals, including the #abbr.a("CPP"), accurately reflect the dynamics predicted by #abbr.pla("SSM"). Which can demonstrate a direct link between model parameters and brain activity @murphy2016neural.

== Drift Diffusion Model
The #abbr.a("DDM") is a mathematical model used in cognitive neuroscience and psychology to describe decision-making processes. It is often used to explain reaction times and the accuracy of decisions in binary choice processes in which a person has to choose between two alternatives. The #abbr.a("DDM") is based on the idea that information is accumulated over time until a decision criterion is reached, which then triggers the selection of one of the two alternatives #cite(<ratcliff1978theory>).

=== Basic principles of the DDM
The #abbr.a("DDM") depicts the decision-making process as a stochastic (random) drift-diffusion movement. The process begins at a neutral starting point and moves in an ‘evidence space’ until it reaches one of the two thresholds that represent the decision in favour of one of the two alternatives. The time at which a threshold is reached corresponds to the reaction time for the decision, and the threshold reached indicates the choice made. @ddm shows an example of such a model #cite(<ratcliff1978theory>).
#figure(
  image("graphics/DDM_sim.png", width: 60%),
  caption: flex-caption(
    [Simulated evidence accumulation signal using the #abbr.a("DDM"). Model parameters of the figure: Drift rate (v)=2, Threshold distance (a)=1(red), Starting point of accumulation (z)=0.2],
    [Simulated evidence accumulation signal using the DDM with drift\_rate=2, threshold=1(red)],
  ),
) <ddm>
=== Main parameters of the DDM
The #abbr.a("DDM") comprises several key parameters that quantitatively describe the decision-making process. The parameters are described below with their argument names from the implementation in brackets:

*Drift rate (v):* The drift rate represents the average rate at which information is accumulated in favour of one of the two alternatives. It is a measure of the conclusiveness or strength of the evidence in favour of a particular choice. A higher drift rate usually leads to faster and more accurate decisions, as the threshold is reached more quickly. The drift rate varies between trials and tasks as it is influenced by the difficulty of the task or the availability of information.

*Threshold distance (a):* This parameter determines the decision thresholds. A larger distance between the threshold values leads to a longer accumulation time, which results in longer reaction times, but also to a higher level of decision certainty as more evidence has been accumulated. A smaller threshold distance can lead to faster but potentially less accurate decisions. This parameter therefore reflects the preference for speed or accuracy.

*Starting point of accumulation (z):* The starting point represents the initial position in the accumulation process and indicates a possible bias in favour of one of the two alternatives. If the starting point is closer to one of the two thresholds, there is a bias in favour of this threshold (i.e., this decision), which makes the decision for this alternative more likely and faster. The starting point can vary to reflect biases or preferences in the decision-making process.

*Non-decisional time (t):* This parameter represents the time required for all processes that are not part of the actual decision accumulation, such as motor response. This time is added to the reaction time and is crucial for modelling the total observed reaction time. #cite(<ratcliff1978theory>) #cite(<ratcliff2008diffusion>) #cite(<RATCLIFF2016diffusion_trends>) #cite(<forstmann2016sequential>)

=== Properties and characteristics of the DDM
The #abbr.a("DDM") has several characteristic properties that make it particularly suitable for modelling decision-making processes in various cognitive tasks:

*Stochastic nature of the decision process:* the drift-diffusion process involves random fluctuations that reflect the natural uncertainty factor in human decisions. This makes it possible to model the variability of reaction times and accuracy.

*Balancing accuracy and speed:* The #abbr.a("DDM") offers an explanation of how people adapt their decisions to the requirements of the tasks, whether by striving for higher accuracy (higher thresholds) or shorter reaction times (lower thresholds). This balance is controlled by the threshold parameter a and reflects real-life decision-making situations well.

*Adaptability to different task difficulties:* The drift rate v often varies depending on the difficulty of the task or the clarity of the information presented. With complex alternatives that are difficult to distinguish, the model drifts more slowly, resulting in a lower drift rate. As a consequence, decision times are longer, and accuracy may be reduced.

*Prediction of reaction times and error rates:* The #abbr.a("DDM") can predict the probability distribution of reaction times for correct and incorrect decisions. By modelling reaction times and errors as the result of the same process, the model can make accurate predictions for both, which contributes to its popularity in cognitive psychology.

*Explanation of biased decisions:* The starting point parameter z allows the model to take into account preferences or biases that favour a decision in favour of an alternative before accumulation begins. #cite(<ratcliff1978theory>) #cite(<ratcliff2008diffusion>) #cite(<RATCLIFF2016diffusion_trends>) #cite(<forstmann2016sequential>)

=== Application and scientific relevance
The #abbr.a("DDM") has been shown to be useful for modelling a variety of decision-making processes, ranging from simple reaction time tasks to more complex cognitive tasks. In cognitive neuroscience, it is used to understand neural mechanisms of decision making. The accumulation process in the #abbr.a("DDM") can map specific neural activity patterns in regions such as the prefrontal cortex and parietal cortex. The model can also be used to make comparisons with actual EEG data from a decision-making process. This allows to analyze the entire process in more detail #cite(<ratcliff1978theory>)#cite(<Myers2022ddm>)#cite(<ratcliff2008diffusion>) #cite(<RATCLIFF2016diffusion_trends>) #cite(<forstmann2016sequential>).

== Linear Ballistic Accumulator
The #abbr.a("LBA") model is a mathematical model belonging to the family of #abbr.pla("SSM") and can also be used to explain decision-making processes. It was developed to provide a simplified and easier to calculate alternative to the #abbr.a("DDM"). The #abbr.a("LBA") model is mainly used to model reaction times and decisions in cognitive tasks with two or more choices. Thus it is based on a deterministic, linear accumulation process without the stochastic diffusion that is characteristic of the #abbr.a("DDM") #cite(<brown2008linear>).

=== Basic principles of the LBA model
The #abbr.a("LBA") model assumes that a decision process can be described by a series of independent accumulators that collect evidence for each decision option in parallel. Each accumulator represents a choice. In contrast to the #abbr.a("DDM"), the #abbr.a("LBA") model is based on a linear, non-stochastic (deterministic) accumulation rate. Therefore it accumulates evidence for each decision option at a constant rate per time step. As soon as an accumulator reaches its threshold value, the corresponding decision is made #cite(<brown2008linear>).

=== Main parameters of the LBA model
The #abbr.a("LBA") model uses a number of parameters that mathematically describe the decision-making process. These parameters are:

*Starting point distribution (A):* Each accumulator starts with a random starting point that lies within a fixed distribution (often uniform). This starting point distribution models the initial bias in the collection of evidence. The variability of the starting point allows the model to explain the differences in reaction times and accuracy between different runs. A lower starting point means more time to reach the threshold, while a higher starting point signals less need for evidence to make a decision.

*Linear Accumulation rate (v):* The accumulation rate, also known as the drift rate, describes the speed at which an accumulator gathers evidence. Each choice option has its own accumulation rate, which is assumed to be normally distributed in order to model fluctuations in decision quality or task difficulty. A higher accumulation rate leads to faster decisions in favour of the corresponding option and reflects the preference or strength of evidence for that choice. Unlike the #abbr.a("DDM"), the #abbr.a("LBA") uses a linear accumulation process without noise during the accumulation itself.  This makes the accumulation deterministic once the initial parameters are set. #cite(<brown2008linear>) #cite(<tillman2020sequential>)

*Threshold (k):* This Parameter defines the amount of evidence needed to accumulate in order to make a decision. Similar to the Threshold distance (a) of the #abbr.a("DDM").

*Non-decisional time (t):* Represents the time required for example the motor response. Similar to the Non-decisional time of the #abbr.a("DDM").

The differences and similarities as the threshold or the drift\_rate between the #abbr.a("LBA") and the #abbr.a("DDM") are also shown in the @ddm-vs-lba.
#figure(
  image("graphics/DDM_vs_LBA.jpg", width: 60%),
  caption: flex-caption(
    [#abbr.a("DDM") compared to #abbr.a("LBA"): differences in accumulation over time. Figure from: @brown2008linear],
    [DDM compared to LBA: differences in accumulation over time. Figure from: @brown2008linear],
  ),
) <ddm-vs-lba>
=== Properties and characteristics of the LBA model
The #abbr.a("LBA") model has some specific features and characteristics that distinguish it from other accumulation models, such as the drift-diffusion model:

*Linear and deterministic accumulation:* The #abbr.a("LBA") model is based on linear accumulation, i.e. evidence is accumulated at a constant rate, without the stochastic fluctuations that play a role in the #abbr.a("DDM"). This simplifies the calculations and makes the model analytically more accessible, which in turn facilitates statistical modelling.

*Flexibility in multiple choice decisions:* The #abbr.a("LBA") model is well suited for decisions with more than two alternatives, as it considers each decision process as an independent accumulation channel. The independent accumulators allow an easy extension to multiple choice options, as each accumulator is modelled with a specific accumulation rate and its own threshold value.

*Distribution of starting points as an explanation for variability:* The initial variability of the accumulators is modelled by the distribution of the starting point. This provides a natural explanation for variations in reaction times between different runs of the same task. As a result, the #abbr.a("LBA") model can predict reaction times more accurately as the #abbr.a("DDM"), especially for fast or slow decisions, without the additional noise component of the #abbr.a("DDM").

*Adaptation to task requirements:* The #abbr.a("LBA") model allows the decision thresholds and accumulation rate to be adapted to the requirements of the task. Higher thresholds can be set for tasks that require high accuracy, while lower thresholds can be set for tasks with time pressure. Because the #abbr.a("LBA") model describes accumulation without stochastic drift, it is less sensitive to stochastic noise and is often more robust in situations where fluctuations in evidence accumulation are small. This can allow for more stable modelling, especially in experimental tasks where the evidence is constant or nearly constant. In addition, an accumulation-to-bound process ramping from stimulus to response can be specifically generated #cite(<brown2008linear>) #cite(<tillman2020sequential>).

=== Applications and scientific significance
The #abbr.a("LBA") model has gained importance in cognitive psychology and neuroscience, especially because of its simplicity and predictability. It is used to model reaction times and decision accuracy in various cognitive tasks and provides a more efficient analysis of large data sets due to the simplified linear accumulation. Compared to the #abbr.a("DDM"), the #abbr.a("LBA") model is particularly useful in experimental situations where the decision process is less influenced by noise and allows the modelling of decisions with multiple options. The decision in favour of the #abbr.a("LBA") model instead of the #abbr.a("DDM") may be preferred in research situations where the complexity of the #abbr.a("DDM") is unnecessary or difficult to calculate #cite(<brown2008linear>) #cite(<tillman2020sequential>).

== Advanced Drift Diffusion Model from @Kelly2021notebook <subsec:kelly>
In their publication “Neurocomputational mechanisms of prior-informed perceptual decision-making in humans” by #cite(<Kelly2021notebook>), the authors construct a decision making model that includes a build-up to threshold process with multiple build-up (evidence accumulation and urgency) and delay (pre- and post-decision) components. The model extends the #abbr.a("DDM") by incorporating additional parameters, resulting in a more complex accumulation process. The original model was implemented in MATLAB by Kelly et al. and later transferred to Julia through an initial conversion by my supervisor, Benedikt Ehinger #cite(<Benedikt2025>). Therefore, the further use and description of the model in this paper is based on the initial Julia version which was refactored by me. In this paper, the Advanced Drift Diffusion Model from Kelly et. al. is abbreviated as #abbr.s("KellyModel"). You can find the original MATLAB code here: #link("https://osf.io/53gmw/files/osfstorage#")[
  OSF Storage
].
=== Basic principles of the Model
As the #abbr.a("DDM") the #abbr.s("KellyModel") depicts the decision-making process as a stochastic (random) drift-diffusion movement. The process begins at a neutral starting point and moves in an "evidence space" until it reaches the threshold that represent the decision. The time at which a threshold is reached corresponds to the reaction time for the decision. Additionally, the process includes a sensor encoding delay, causing a time shift before accumulation begins after stimulus onset. It also features a post-accumulation phase, called a non decision time, during which evidence continues to accumulate even after the threshold is reached and the decision is made. An example of an trace of such a model is shown in the @kelly-model-trace.
#figure(
  image("graphics/Kelly_Model_trace_V2_Parameters.png", width: 70%),
  caption: flex-caption(
    [Simulated evidence accumulation signal using the #abbr.a("KellyModel") with parameter annotations (Fixed parameters: drift\_rate=6.0, boundary=1.0, event\_onset=0.2, post\_accumulation\_duration=0.1, ramp\_down\_duration=0.1, motor\_onset=0.4; Parameters based on distributions: accumulative\_level\_noise=0.5, sensor\_encoding\_delay=0.1, motor\_delay=0.1, post\_accumulation\_duration\_variability=0.2)],
    [Simulated evidence accumulation signal using the KellyModel with parameter annotations],
  ),
) <kelly-model-trace>
=== Main parameters of the #abbr.s("KellyModel")
The #abbr.s("KellyModel") comprises several key parameters that quantitatively describe the decision-making process. The influence of the model's parameters can be seen in @kelly-model-trace through annotations on a simulated evidence accumulation signal.:

*Drift rate (drift\_rate):* The drift rate represents the average rate at which information is accumulated per time step. A higher drift rate usually leads to faster and more accurate decisions, as the threshold is reached more quickly. The drift rate varies between individuals and tasks as it is influenced by the difficulty of the task or the availability of information.

*Accumulation noise (accumulative\_level\_noise):*
To introduce variability in the accumulation process over time, the accumulative\_level\_noise parameter can be used to control the amount of evidence accumulated per time step. This allows for variations between individual traces or, if desired, greater consistency by reducing the variability.

*Sensory encoding delay (event\_onset, sensor\_encoding\_delay):* This component is divided in two parameters and determines the delay between the stimulus onset and the actual start of the evidence accumulation process as shown in @kelly-model-trace. This can be seen as a reaction time where an participant need time to analyze the environment/task. For the Model the event\_onset defines a fixed delay in seconds. The sensor\_encoding\_delay defines a uniform distributed(range[-0.5*x, 0.5*x] where x is the parameters value) delay also given in seconds which is applied on top. With this combination a wide variability in parameterizing the sensory encoding delay between subjects can be achieved. This parameters therefore reflect the preference for speed up or delay in the overall process.

*Boundary/Threshold height (boundary):* Similar to the #abbr.a("DDM"). Indicated in @kelly-model-trace as a horizontal red line.

*Post accumulation spike (post\_accumulation\_duration, post\_accumulation\_duration \_variability):* Once the boundary has been reached, it might be assumed that the accumulation process will continue for a certain period of time as shown annotated in yellow in @kelly-model-trace. This behavior can be influenced by the two parameters post\_accumulation\_duration/\_variability. As with other components, the post\_accumulation\_duration is a fixed time specification in seconds for the excess and the post\_accumulation\_duration\_variability is a variable influence in the form of a uniform distribution(range[-0.5*x, 0.5*x] where x is the parameters value).

*Ramp down process (ramp\_down\_duration):* After the spike of the accumulation process a ramp down component back to zero is implemented. The duration of this fixed ramp down is specified in seconds by the parameter ramp\_down\_duration and can be seen in @kelly-model-trace with the orange annotation. EEG studies show that neuronal decision signals do not end abruptly after reaching a threshold value, but gradually fade away, which can be realistically simulated by using this ramp down component #cite(<Myers2022ddm>).

*Motor encoding delay (motor\_onset, motor\_delay):* This component can be seen as the opposite of the sensory encoding delay. As this is the motor delay that is required after a decision has been made to perform the resulting action to communicate the decision. This amount of time starts therefore after the model turns back to zero as shown in @kelly-model-trace. A practical example would be, when a person has to press a button or point to something, this needs time to be proceed. The model parameter motor\_onset specifies a fixed value in seconds for the delay. A variable value is specified with motor\_delay, which also influences the delay as a uniform distribution(range[-0.5*x, 0.5*x] where x is the parameters value). These parameters can therefore delay or accelerate a subsequent event #cite(<Kelly2021notebook>) .

=== Properties and characteristics of the #abbr.s("KellyModel")
The KellyModel is designed to simulate the neural temporal dynamics of decision-making through an evidence accumulation framework. It incorporates several key characteristics that make it a flexible and biologically plausible model for cognitive processes:

*Adaptability to Individual Differences:*
The model allows for variation in drift rate, sensory encoding, and motor delays, enabling it to reflect differences in cognitive processing speed, task difficulty, and participant-specific response behaviors.

*Temporal Structure and Variability:*
With distinct parameters for sensory and motor delays, as well as post-accumulation effects, the model captures the full decision-making process—from stimulus onset to motor execution—while introducing natural variability through stochastic components.

*Noisy Evidence Accumulation:*
The inclusion of accumulative level noise ensures that the model accounts for fluctuations in information processing, which aligns with empirical findings from neural and behavioral studies. In contrast to the classic #abbr.a("DDM"), where the drift rate remains constant across trials (and even more so in the #abbr.a("LBA")), the inclusion of accumulative level noise introduces trial-by-trial variability in the accumulation process.

*Gradual Decision Termination:*
Unlike traditional drift-diffusion models that assume abrupt decision termination, the ramp-down process provides a gradual decline in accumulation signals, making the model more consistent with observed neural data.

*Task-Specific Customization:*
By adjusting parameters such as boundary height, drift rate, and delay distributions, the model can be tailored to simulate different cognitive tasks, from rapid perceptual judgments to more complex decision-making scenarios.

=== Application and scientific relevance
As previously described, the model was already used by its namesakes in the publication ‘Neurocomputational mechanisms of prior-informed perceptual decision-making in humans’ #cite(<Kelly2021notebook>). The model was used to compare simulated evidence signals with evidence accumulation processes that are reflected in the #abbr.a("CPP") in real #abbr.a("EEG") data. 

The model was also used in the publication by @Fromer2024 mentioned under #ref(<subsec:motivation>, form: "normal"). In this publication, the model was used to perform a comparison of mass univariate and deconvolution analyses on the basis of simulated evidence accumulation signals. The sensor encoding and motor encoding parameters were varied so that the evidence accumulation peak was closer to the stimulus, closer to the response and neutral. These three scenarios showed that the evidence accumulation signal is most likely to appear in the stimulus-locked deconvolution when it is more closely coupled to the stimulus and vice versa for the response. Thus, it could be shown that under these different conditions no signal is lost depending on the deconvolution.

== #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl] Package @UnfoldSim
#link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl] is a Julia-based framework for simulating multivariate time-series data, particularly for #abbr.a("EEG") and #abbr.pla("ERP"). It provides a controlled environment to test and validate statistical modeling approaches by generating synthetic datasets that resemble real #abbr.a("EEG") data while allowing full control over underlying parameters.

#abbr.a("EEG") analysies often faces challenges such as overlapping neural responses, complex experimental designs, and measurement noise. #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl] enables the modeling of realistic, continuous #abbr.a("EEG") data by allowing precise control over event timing, response functions, and noise properties. This makes it a valuable tool for testing #abbr.a("EEG") analysis methods, validating statistical approaches, illustrating conceptual issues, evaluating toolbox functionalities, and identifying limitations in traditional analysis workflows. Ultimately, this facilitates addressing the aforementioned challenges.

*Key Features:*
- Modularity and extensibility: Modular structure in the building blocks (designs, components, onset distributions or noise types) of which different variants can be selected and new ones can be added easily as a contributor.
- Flexible Experimental Designs: Enabling realistic event structures and hierarchical effects, such as creating designs with repeated event sequences.
- Handling Overlapping Events: Generates continuous #abbr.a("EEG") signals with overlapping event-related activity, enabling validation of deconvolution-based approaches.
- Noise Modeling: Incorporates realistic noise sources (e.g., pink noise).

*Integration with Other Tools:*
As part of the overall Unfold package family, #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl] is designed to work seamlessly with the other packages. For example, with Unfold.jl, to create the #abbr.a("ERP") from the simulated #abbr.a("EEG") and further analysis tools like the deconvolution method. Or UnfoldMakie.jl, which provides visualisation tools for #abbr.a("EEG")/#abbr.a("ERP") analysis. This integration ensures a standardised workflow from simulation to analysis.

#link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl] plays a key role in testing and improving new analysis methodologies, making it an valuable tool for computational neuroscience. Therefore, it provides the best framework to incorporate the simulation of the evidence accumulation process using the #abbr.pla("SSM") in this package. The following section introduces the new contribution and extension that further enhance the capabilities of #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl].