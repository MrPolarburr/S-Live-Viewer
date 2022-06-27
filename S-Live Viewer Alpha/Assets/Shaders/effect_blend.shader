Shader "MCRS/Effect/Blend" {
	Properties {
		_MainTex ("DiffuseTex", 2D) = "white" {}
		_Color ("Main Color", Vector) = (1,1,1,1)
	}
SubShader
	{
		Tags { "Queue"="Transparent" "RenderType"="Geometry" "LightMode" = "Vertex"}
		Blend SrcAlpha OneMinusSrcAlpha
		ZWrite Off
		Pass
		{
			CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

			struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
				float4 color : COLOR;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
				float4 color : COLOR;
            };

			sampler2D _MainTex;
			float _Power;
			float4 _Color;
			float4 _MainTex_ST;

			v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.color = v.color
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv) * i.color *_Power;

                col.rgba *= _Color.rgba;

                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
			ENDCG
		}
	}
}