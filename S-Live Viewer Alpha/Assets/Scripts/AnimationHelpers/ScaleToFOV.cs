using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ScaleToFOV : MonoBehaviour
{
    private Camera mainCam;
    public GameObject scaleTarget;

    float camFOV = 1f;

    void Start(){
        mainCam = gameObject.GetComponent<Camera>();
    }

    private void Update() {
        camFOV = scaleTarget.transform.localScale.z;
        mainCam.fieldOfView = camFOV;
    }
}
