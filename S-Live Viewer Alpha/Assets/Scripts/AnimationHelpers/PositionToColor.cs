using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PositionToColor : MonoBehaviour{

    private Vector3 position;
    public Color color;
    public Transform alpha;

    private void Start(){
        position = transform.position;
        color = Color.white;
    }

    private void Update(){

        float OldValue, NewValue;
        int OldMax = 1, NewMax = 255, OldMin = 0, NewMin = 0;

        position = transform.position;

        OldValue = alpha.rotation.x;

        NewValue = (((OldValue - OldMin) * (NewMax - NewMin)) / (OldMax - OldMin)) + NewMin;

        color = new Color(position.x, position.y, position.z, NewValue);

        if(transform.GetComponent<Light>()){
            transform.GetComponent<Light>().color = color;
        }
    }

}
