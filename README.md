# KSC2Demo
A demonstration project for the Dual Channel Kulite Signal Conditioner (KSC-2) and a MATLAB API to control all of its features via USB. The KSC-2 is developed and produced by Kulite Semiconductor Products, Inc. based in Leonia, New Jersey.

## Build/Run Requirements
You will need MATLAB R2015b or later, especially if you are planning to compile the software into an executable with the MATLAB Application Compiler because earlier versions had a bug with recognizing the National Instruments NI 9218/9171 DAQ and chassis combo.
The setup is supposed to operate under specific connections (although these can change):

### Physical Setup
The microphone/pressure transducer is connected without a preamplifier to the first channel of the KSC-2 where it is only amplified (and applied a low-pass filter with 127kHz cutoff frequency by default). Then, the output of the first channel feeds into the input of the second channel where the proprietary resonance compensation (REZCOMP&copy;) is applied to the signal. The compensated signal is then fed to the second channel of the DAQ device. The DAQ is connected to the computer via USB. The KSC-2 also needs to be connected for this demo (so that its settings change while the experiment is run - namely the software reevaluates the correct value for the resonant frequency and the quality factor).

### Software
MATLAB R2015b or later and the Signal Analysis Toolbox are required to run the source code. The MATLAB Runtime is required for running the executable under /Multi-Window/for_testing/.

___

## Bug reports
If you encounter any bugs while using the software, or would like some clarifications, email me at [emmanuel@kulite.com](mailto:emmanuel@kulite.com)
