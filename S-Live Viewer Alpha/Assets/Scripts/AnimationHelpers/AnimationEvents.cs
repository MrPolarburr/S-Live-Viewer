using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AnimationEvents : MonoBehaviour{

    public GameObject mic;
    public void AttachMikeToLeftHand(){
        var attachSpot = transform.Find("joint_root").Find("hips").Find("spine").Find("spine1").Find("spine2").Find("shoulder_l").Find("arm_l").Find("forearm_l").Find("hand_l").Find("MIKE_L_attach");
        mic.transform.SetParent(attachSpot.transform);
        mic.transform.localPosition = Vector3.zero;
        mic.transform.localRotation = Quaternion.identity;
        mic.SetActive(true);
    }

    public void AttachMikeToRightHand(){
        var attachSpot = transform.Find("joint_root").Find("hips").Find("spine").Find("spine1").Find("spine2").Find("shoulder_r").Find("arm_r").Find("forearm_r").Find("hand_r").Find("MIKE_R_attach");
        mic.transform.localPosition = Vector3.zero;
        mic.transform.localRotation = Quaternion.identity;
        mic.SetActive(true);
    }

    public void HideMike(){
        mic.SetActive(false);
    }

    public void AttachMikeToMikeStand(){
        //do thing
    }

}
