#import "@preview/abbr:0.1.1"
/*#heading(outlined: false)[Danksagung]
#lorem(100)
#heading(outlined: false)[Acknowledgements]
#lorem(100)*/
#heading(outlined: false)[Abstract]
Understanding how the brain accumulates evidence to make decisions is a goal in cognitive neuroscience. Decision-making processes are often modeled using Sequential Sampling Models (SSMs), which describe how information is gradually integrated until a decision threshold is reached. Among these, the Drift Diffusion Model (DDM) and Linear Ballistic Accumulator (LBA) have been widely used to explain behavioral and neural data. More recently, the KellyModel has introduced additional parameters to enhance biological plausibility. 

However, directly linking such models to electroencephalography (EEG) data remains a challenge. In this work, we address this gap by developing a computational toolbox that enables EEG simulations based on SSMs to systematically investigate how these models can be mapped to neuronal activity. The toolbox was developed for seamless integration into #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl], a Julia-based package for EEG simulations. The overall package allows researchers to study the decision-making processes and their influence on the event-related potentials (ERPs) through the possibility of creating simulations. The work provides examples of testing deconvolution techniques using the toolbox created. This addresses component overlap in EEG signals, which is a well-known challenge in cognitive neuroscience.

The toolbox was seamlessly integrated into #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl] with a modular design, comprehensive test coverage, and detailed documentation, ensuring ease of use and extensibility. This structured integration into the #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl] package supports the use of the implementation throughout the entire #link("https://github.com/unfoldtoolbox")[Unfold toolbox].

This work contributes to computational neuroscience by providing a flexible and extensible toolbox for EEG research. Future studies may refine model parameters, validate simulations against real EEG data, and incorporate adaptive modeling approaches to improve accuracy and applicability in decision-making research.

*Keywords:* Electroencephalography (EEG) Simulation,
Sequential Sampling Models (SSMs),
Decision-Making Processes.
Computational Neuroscience.
UnfoldSim.jl Integration


#heading(outlined: false)[Abstract in German]
Ein Ziel der kognitiven Neurowissenschaften ist es zu verstehen, wie das Gehirn Informationen sammelt, um Entscheidungen zu treffen. Entscheidungsprozesse werden häufig mit Hilfe von Sequential-Sampling-Modellen (SSM) modelliert, die beschreiben, wie Informationen schrittweise integriert werden, bis eine Entscheidungsschwelle erreicht ist. Das Drift-Diffusions-Modell (DDM) und der lineare ballistische Akkumulator (LBA) wurden häufig zur Erklärung von Verhaltens- und neuronalen Daten verwendet. In jüngerer Zeit wurden mit dem Kelly-Modell zusätzliche Parameter eingeführt, um die biologische Plausibilität zu erhöhen.

Die direkte Verknüpfung solcher Modelle mit Elektroenzephalographie (EEG)-Daten bleibt jedoch eine Herausforderung. In dieser Arbeit wird diese Lücke durch die Entwicklung einer Toolbox geschlossen, die EEG-Simulationen auf der Grundlage von SSMs ermöglicht, um systematisch zu untersuchen, wie diese Modelle auf die neuronale Aktivität abgebildet werden können. Die Toolbox wurde für eine nahtlose Integration in #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl], ein Julia-basiertes Paket für EEG-Simulationen, entwickelt. Das Gesamtpaket ermöglicht es Forschern, die Entscheidungsprozesse und deren Einfluss auf die ereigniskorrelierten Potentiale (ERPs) durch die Möglichkeit der Erstellung von Simulationen zu untersuchen. Die Arbeit liefert Beispiele für das Testen von Dekonvolutionstechniken unter Verwendung der erstellten Toolbox. Damit werden Komponentenüberlappungen in EEG-Signalen adressiert, die in den kognitiven Neurowissenschaften eine bekannte Herausforderung darstellen.

Die Toolbox wurde nahtlos in #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim] integriert, mit einem modularen Design, umfassender Testabdeckung und detaillierter Dokumentation, die Benutzerfreundlichkeit und Erweiterbarkeit gewährleistet. Diese strukturierte Integration in das #link("https://github.com/unfoldtoolbox/UnfoldSim.jl")[UnfoldSim.jl] Paket unterstützt die Nutzung der Implementierung in der gesamten #link("https://github.com/unfoldtoolbox")[Unfold Toolbox].

Diese Arbeit trägt zur Computational Neuroscience bei, indem sie einen flexiblen und erweiterbaren Werkzeugkasten für die EEG-Forschung bereitstellt. Zukünftige Studien können Modellparameter verfeinern, Simulationen mit realen EEG-Daten validieren und adaptive Modellansätze integrieren, um die Genauigkeit und Anwendbarkeit in der Entscheidungsforschung zu verbessern.

*Keywords:* Electroencephalography (EEG) Simulation,
Sequential Sampling Models (SSMs),
Decision-Making Processes.
Computational Neuroscience.
UnfoldSim.jl Integration
