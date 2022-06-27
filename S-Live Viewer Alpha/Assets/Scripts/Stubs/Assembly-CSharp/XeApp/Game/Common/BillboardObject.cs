using UnityEngine;

namespace XeApp.Game.Common
{
	public class BillboardObject : MonoBehaviour
	{
		public Camera camera;
		public bool enableVertical;

		private void Start() {
			if (camera == null) {
				camera = Camera.main;
			}
		}

		private void Update()
          {
              transform.LookAt(transform.position + Camera.main.transform.rotation * Vector3.forward,
                  Camera.main.transform.rotation * Vector3.up);
                  Vector3 eulerAngles = transform.eulerAngles;
                  eulerAngles.x = 0;
				  eulerAngles.y += 180;
				  eulerAngles.z = 0;
                  transform.eulerAngles = eulerAngles;
          }
	}
}
