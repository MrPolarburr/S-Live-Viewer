using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Linq;

public class PathToAnim : MonoBehaviour{

    [HideInInspector]
    public float blendValue;
    public AnimType type;
    public AnimParams selectedParam;

    private void Update() {
        if(blendValue > 0){
            //Debug.Log($"[PathToAnim] {this.gameObject.name}");
        }
        if(this.selectedParam == AnimParams.eye_wink){
            if(blendValue <= .8f){
                blendValue = 0f;
            }else{
                blendValue = this.transform.position.x;
            }
        }
        blendValue = this.transform.position.x;
    }

    public enum AnimType{
        Face,
        Mouth,
        Eyes,
    }

    public enum AnimParams{
        Null,
        #region Face
        eyes,
        face_exp_anger,
        face_exp_joy,
        face_exp_laugh,
        face_exp_normal,
        face_exp_smile,
        face_exp_sorrow,
        face_exp_suprise,
        face_exp_transience,
        face_exp_trouble,
        eye_close,
        eye_close2,
        eye_close3,
        eye_doyagao,
        eye_wink,
        eye_winkL, //sheryl only
        eye_yawn, //freyja only

        #endregion

        #region Mouth

        mouth_exp_anger,
        mouth_exp_doyagao,
        mouth_exp_joy,
        mouth_exp_laugh,
        mouth_exp_normal,
        mouth_exp_smile,
        mouth_exp_sorrow,
        mouth_exp_suprise,
        mouth_exp_transience,
        mouth_exp_trouble,
        lip_A,
        lip_bigA,
        lip_bigO,
        lip_E,
        lip_I,
        lip_O,
        lip_U,
        lip_N,
        mouth_exp_yawn, //freyja only

        #endregion
    }
}
