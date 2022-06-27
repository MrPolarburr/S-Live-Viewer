using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FacialAnimsConverter : MonoBehaviour{

    public List<PathToAnim> facePaths = new List<PathToAnim>();
    public List<PathToAnim> mouthPaths = new List<PathToAnim>();
    public PathToAnim eyesPath;
    public float blendAmount;
    public GameObject eyes;
    private Material eyeMat;
    public Animator mainAnimator;
    private float previousFaceValue, previousMouthValue;
    private PathToAnim previousFacePath, previousMouthPath;

    private void Start() {
        if(eyeMat != null)
            eyeMat = eyes.GetComponent<Renderer>().material;
    }

    private void Update() {
        checkEyePath();
        checkFacePaths();
        checkMouthPaths();
    }

    private void checkEyePath() {
        if(eyesPath != null && eyeMat != null)
            eyeMat.SetFloat("_Scroll", eyesPath.blendValue);
    }

    private void checkFacePaths() {
        foreach (var path in facePaths){
            if(path.selectedParam != PathToAnim.AnimParams.Null && path.type == PathToAnim.AnimType.Face) {
                if(path.blendValue + blendAmount >= previousFaceValue){
                        previousFacePath = path;
                        previousFaceValue = path.blendValue;
                        mainAnimator.SetBool(path.selectedParam.ToString(), true);
                        mainAnimator.SetLayerWeight(mainAnimator.GetLayerIndex(path.type.ToString()), path.blendValue);                   
                }else{
                    if(previousFacePath == path) {
                        mainAnimator.SetLayerWeight(mainAnimator.GetLayerIndex(path.type.ToString()), path.blendValue);
                        previousFaceValue = path.blendValue;
                    }else{
                        mainAnimator.SetBool(path.selectedParam.ToString(), false);
                    }
                }
            }
        }
    }

    private void checkMouthPaths() {
        foreach (var path in mouthPaths) {
            if(path.selectedParam != PathToAnim.AnimParams.Null && path.type == PathToAnim.AnimType.Mouth) {
                if(path.blendValue >= previousMouthValue) {
                    previousMouthPath = path;
                    previousMouthValue = path.blendValue;
                    mainAnimator.SetLayerWeight(mainAnimator.GetLayerIndex(path.type.ToString()), path.blendValue);                   
                    mainAnimator.SetBool(path.selectedParam.ToString(), true);
                }else{
                    if(previousMouthPath == path) {
                        mainAnimator.SetLayerWeight(mainAnimator.GetLayerIndex(path.type.ToString()), path.blendValue);
                        previousMouthValue = path.blendValue;
                    }else{
                       mainAnimator.SetBool(path.selectedParam.ToString(), false); 
                    }
                }
            }
        }
    }
}