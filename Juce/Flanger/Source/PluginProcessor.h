/*
  ==============================================================================

    This file contains the basic framework code for a JUCE plugin processor.

  ==============================================================================
*/

#pragma once

#include <JuceHeader.h>

#define MAX_DELAY_TIME 2
#define PI 3.14159265358979323846


//==============================================================================
/**
*/
class FlangerAudioProcessor  : public juce::AudioProcessor
{
public:
    //==============================================================================
    FlangerAudioProcessor();
    ~FlangerAudioProcessor() override;

    //==============================================================================
    void prepareToPlay (double sampleRate, int samplesPerBlock) override;
    void releaseResources() override;

   #ifndef JucePlugin_PreferredChannelConfigurations
    bool isBusesLayoutSupported (const BusesLayout& layouts) const override;
   #endif

    void processBlock (juce::AudioBuffer<float>&, juce::MidiBuffer&) override;

    //==============================================================================
    juce::AudioProcessorEditor* createEditor() override;
    bool hasEditor() const override;

    //==============================================================================
    const juce::String getName() const override;

    bool acceptsMidi() const override;
    bool producesMidi() const override;
    bool isMidiEffect() const override;
    double getTailLengthSeconds() const override;

    //==============================================================================
    int getNumPrograms() override;
    int getCurrentProgram() override;
    void setCurrentProgram (int index) override;
    const juce::String getProgramName (int index) override;
    void changeProgramName (int index, const juce::String& newName) override;

    //==============================================================================
    void getStateInformation (juce::MemoryBlock& destData) override;
    void setStateInformation (const void* data, int sizeInBytes) override;

    static juce::AudioProcessorValueTreeState::ParameterLayout createParameterLayout();
    juce::AudioProcessorValueTreeState apvts{ *this, nullptr, "Parameters", createParameterLayout() };

    juce::dsp::WaveShaper<float> waveshaper;

    float squareWave(float x) {

        if (x >= -1 && x < 0) {
            x = -1;
        }
        else if (x >= 0 && x <= 1) {
            x = 1;
        }

        return x;
    }

    float triangleWave(float x) {
        x *= 2;
        if (x <= 0) {
            return (x + 1)/2;
        }
        else {    
            return (1 - x)/2;
        }
    }

    float linear_interp(float sample_x, float sample_x1, float inPhase) {
        return (1 - inPhase) * sample_x + inPhase * sample_x1;
    }

private:
    //==============================================================================
    float LFO_phase;
    float delayTimeSmooth;
    float delayTimeSamples;
    float feedback_l = 0;
    float feedback_r = 0;
    float delayReadHead;
    float LFO_out = 0;

    int circularBufferLength;
    int circularBufferWriteHead;
    std::unique_ptr<float> circularBufferLeft = nullptr;
    std::unique_ptr<float> circularBufferRight = nullptr;
    

    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR (FlangerAudioProcessor)
};
