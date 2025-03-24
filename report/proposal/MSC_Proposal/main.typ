#import "template.typ": *
#import "@preview/dashy-todo:0.0.1": todo
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "Master Thesis Proposal",
  subtitle: "Simulation of EEG Activity Based on Sequential Sampling Models",
  authors: "Timo Zaoral",
  date: "October 18, 2024",
)
= Introduction <introduction>
The human brain continuously processes and integrates sensory information in order to make decisions. This process is typically modelled as evidence accumulation. The complex cognitive function behind this underlies many of our everyday decisions, whether simple or complex. This function is often modelled by Sequential Sampling Models (SSMs).@ratcliff1978theory The SSMs, such as the drift-diffusion model (DDM), linear ballistic accumulator (LBA) and others, are used to simulate how information is accumulated over time until a decision threshold is reached. But almost all of their applications are for inference. This means that you have the data and want to access the ‘hidden’ states of the assumed evidence integration model. @brown2008simplest Therefore, SSMs provide insight into the underlying neural mechanisms of decision making. Furthermore, the different parameters of the SSMs can represent influencing factors on the underlying cognitive process and thus contribute to a better understanding of the process. Understanding the neural mechanisms underlying this process is crucial to improve our understanding of cognition and its relationship to brain activity.@vanvugt2019cppxdmp@forstmann2016sequential \
Electroencephalography (EEG) can be used to record brain activity during decision-making tasks, providing insight into the temporal aspects of evidence accumulation. The EEG data can be analysed to identify neural indicators of the decision-making process over time, particularly those that reflect the accumulation of evidence. In many studies, the EEG component centro-parietal positivity (CPP) has now been identified as an indicator of evidence accumulation during decision-making. This can be used to compare the course of SSMs with the EEG.@vanvugt2019cppxdmp Simulations of EEG data using SSM can help to bridge the gap between these abstract models and actual EEG data. This also allows an attempt to map the model parameters to observable neuronal activity. This task has so far been a challenge for cognitive neuroscience.@connell2021kelly@forstmann2016sequential \
This thesis proposes to simulate EEG data using different Sequential Sampling Models to explore how these models reflect the evidence accumulation process in the brain. By systematically manipulating model parameters of the different SSMs and evaluating their fit to the EEG data, we seek to identify which model characteristics are most indicative of evidence accumulation processes in the brain. Understanding these indicators could lead to more precise interpretations of EEG data in the context of cognitive decision-making research.

= Related Work <related-work>
== Sequential Sampling Models <sequential-sampling-models>
Sequential sampling models (SSM) have become fundamental tools for understanding decision-making processes, especially in situations where evidence accumulates over time in order to make a decision. One of the most influential models is the drift-diffusion model (DDM), which assumes that decisions are based on the gradual accumulation of noisy evidence towards one of two decision thresholds. The evidence signal of the model starts from a certain predetermined position, then accumulates evidence over time at a certain so-called drift rate until one of the two boundaries is crossed. The accumulation process of the DDM is not straight, the drift rate is biased by an diffusion coefficient, which is the standard deviation of that process. Ratcliff and McKoon @ratcliff2008diffusion have analysed the DDM in detail and shown that it can concurrently explain both the speed and accuracy of decisions in tasks with two alternative choices.@forstmann2016sequential@mulder2014perceptual \
\
Building on the DDM, other models such as the #emph[Linear Ballistic Accumulator (LBA)] and the #emph[Racing Diffusion Model (RDM)] have introduced variations in the way evidence accumulates and how decisions are made. The LBA, developed by Brown and Heathcote @brown2008linear, simplifies the decision-making process by assuming linear accumulation without noise, making it computationally efficient. Moreover, the accumulation of evidence runs independently for the options.@mulder2014perceptual The RDM of is largely the same as LBA, with the difference that it allows for noise during the process of evidence accumulation within a trial. However, the drift rate is constant across trials and only "runs" against a single threshold. Therefore, decision making runs as a race between multiple accumulators, each representing a different choice, which increases the flexibility to capture more complex decision dynamics.@tillmann2020race

== Neural Implementation of the Decision-Making Process <neural-implementation-of-the-decision-making-process>
In cognitive neuroscience, the neuronal mechanism underlying decision-making is investigated. The aim is to find out how the brain collects and processes evidence in order to make a decision. The investigation of electrophysiological signals such as EEG or magnetoencephalography (MEG) play a decisive role in this. Thanks to their high temporal resolution, these signals make it possible to observe neuronal dynamics during a decision-making task in real time. This allows indicators and influencing factors in the neuronal mechanism to be identified.@connell2021kelly@vanvugt2019cppxdmp \
\
This has led to an increasing number of scientific papers investigating how brain regions and neuronal circuits contribute to the decision-making process. Shadlen and Kiani @shadlen2013neurobiology, for example, discuss the model of evidence accumulation and its neuronal correlates. They focus on the parietal and prefrontal cortex of the brain and examine how these integrate sensory information over time until a decision threshold is reached. This model is consistent with sequential sampling, which assumes that decisions are made as soon as sufficient evidence has accumulated. The drift rates and decision thresholds are also reflected in the neuronal activity. \
\
Further research shows the role of centro-parietal positivity (CPP), which is a neuronal signal recorded in the EEG, in the context of the neuronal decision-making process. This signal represents the process of accumulation of evidence up to the decision boundary and can therefore be used as an indicator of accumulatory dynamics. How exactly this representation arises in the brain is still unclear. However, some insights into the CPP have been gained. A steeper CPP indicated a faster accumulation of evidence, which leads to a faster decision. In addition, the CPP was active in both perceptual and memory decisions, reflecting similar dynamic processes but with a delay in perceptual decisions. The CPP also showed a graded response depending on the difficulty of the decision. Thus, more difficult tasks have a lower amplitude of the CPP. This establishes the CPP as a useful tool for investigating the neural basis of decision making.@connell2021kelly@vanvugt2019cppxdmp@kelly2013internal

== SSMs and the neural decision-making process <ssms-and-the-neural-decision-making-process>
By using SSMs to interpret neural data, promising progress has been made in understanding the temporal dynamics of decision-making processes. Publications such as those by O’Connell et al. @connell2021kelly and van Vugt et al. @van2012eeg show that EEG can capture neuronal signatures of evidence accumulation in real time by linking specific SSM parameters, such as drift rate, to observable neuronal signals. In this way, the CPP could again be used to compare neurophysiological data with the decision-making processes generated from SSM. This can provide deeper insights into how the underlying cognitive mechanism of decision-making takes place in the brain.@forstmann2016sequential@mulder2014perceptual This is also supported by the publication of Murphy et al. who demonstrated that decision-related neural signals, including the CPP, accurately reflect the dynamics predicted by SSMs. This demonstrates a direct link between model parameters and brain activity.@murphy2016neural \
\
Another topic area is neurally informed modelling, in which the SSMs are adapted to take into account the variability of evidence accumulation. The adjustment is based on neuronal data for validation and determination of the model parameters. This once again demonstrated the link between neural decision-making and the models. This helps to explain individual differences in decision-making behaviour and neuronal activity. This means that the influence on the process of how the brain converts noisy sensory input into decisions over time can be investigated through targeted manipulation of the model parameters.@connell2021kelly@kelly2021informed

= Goals of the Thesis <goals-of-the-thesis>
The primary aim of this thesis is to investigate the relationship between Sequential Sampling Models (SSMs) and evidence accumulation processes as observed in EEG data. Specifically, the research seeks to simulate EEG data using different SSMs and identify key parameters that serve as indicators of evidence accumulation in the brain. The specific goals of the thesis are outlined as follows:

+ #strong[Theoretical Description of Sequential Sampling Models (SSMs)]:

  - Provide a comprehensive theoretical description of the main SSMs, such as the drift-diffusion model (DDM) and the linear ballistic accumulator (LBA).

  - Describe the critical parameters of these models, such as drift rate, decision threshold and non-decision time, and explain how these parameters influence model behaviour.

  - Review and compare the behaviour of the models (e.g. DDM, LBA)

+ #strong[Reimplementation of the Kelly Model]:

  - Document and re-implement the Kelly et al. model, which uses evidence accumulation to simulate EEG data, using the existing Pluto Notebook implementation.

  - Ensure that this re-implementation accurately reflects the evidence accumulation process described in the original model and provides a basis for EEG simulations.

+ #strong[Integration into UnfoldSIM]:

  - Integrate the Kelly model and other SSM-based simulations into UnfoldSIM

  - Embed these simulations in UnfoldSIM to enable comparisons between the models simulated and thus facilitate the investigation of evidence accumulation processes.

+ #strong[Comparison of Models]:

  - Perform a systematic comparison of different SSMs by varying key parameters, especially the drift rate, and observe how changes in these parameters affect the EEG simulations.

  - Identify and define comparison criteria for the evaluation of the models

  - The aim of this comparison is to determine whether the speed of evidence accumulation (i.e., drift rate) can serve as a reliable indicator of the decision processes observable in EEG data. Other potential indicators that could shed light on the neural mechanisms behind evidence accumulation are also investigated in this work.

By achieving these goals, the thesis aims to advance the understanding of how mathematical models of decision making can be linked to neural activity to gain new insights into the processes of evidence accumulation in the brain observed through EEG signals.

= Milestones and Planned Schedule <milestones-and-planned-schedule>
The work on the proposed thesis is organised into a series of clearly defined milestones that ensure steady progress and alignment with the project goals. The schedule shown in the Gantt chart Figure #link(<fig:gantt>)[1] is divided into several phases. The milestones are outlined as follows:

+ #strong[Proposal Phase] (End of October 2024):

  - Write and submit the proposal where the research plan, objectives are defined. Should be done until end of October 2024 and is the foundation for all subsequent work.

+ #strong[Basic Literature Search and Theoretical Model Description] (October 2024 - November 2024):

  - Gathering key references and understanding the existing work on Sequential Sampling Models and their connection to the neural decision-making process.

  - The theoretical description of the SSMs, including selection of these and parameter description. Should be completed by the end of November 2024.

+ #strong[Programming of Simulations] (November 2024 - January 2025):

  - Implementation and programming of the simulations based on the selected Sequential Sampling Models.

  - A short break over the turn of the year is included to allow time for a review and a small buffer

+ #strong[Simulation and Comparison of Models] (January - February 2025):

  - The simulated data from various Sequential Sampling Models will be analyzed and compared. This step involves testing different model parameters and their impact on EEG simulations.

  - This analysis will provide key insights into which parameters (e.g., drift rate) can be used as indicators of evidence accumulation processes. Should be done til February 2025.

+ #strong[Integration into UnfoldSIM] (January - February 2025):

  - The simulations will be integrated into UnfoldSIM

  - Focus on refining the simulations and ensuring that they are documented and work as expected. Should be done til February 2025.

+ #strong[Writing the Thesis] (January - March 2025):

  - In addition to all the other work, writing the thesis is a continuous process.

+ #strong[Review and Presentation] (March 2025):

  - The final milestone holds space for reviewing the entire thesis and preparing the presentation. A buffer is also planned for additional optional goals.

By following to the schedule, consistent progress should be made in order to deliver good overall work within a controlled framework. \

#figure([#box(width: 100%, image("Timeline_Masterthesis_V2.png"))], caption: [
  Gantt chart showing the planned schedule of the thesis.
])
<fig:gantt>
#pagebreak()
#bibliography("sample.bib")
