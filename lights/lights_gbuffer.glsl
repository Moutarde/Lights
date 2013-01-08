#if defined(VERTEX)
uniform mat4 Projection;// view to clip
uniform mat4 View;		// world to view
uniform mat4 Object;	// object to world

uniform sampler2D NormalMap;	//ADD

in vec3 VertexPosition;
in vec3 VertexNormal;
in vec2 VertexTexCoord;

out vec2 uv;
out vec3 normal;
out vec3 position;

// out vec3 tangent;	//ADD
// out vec3 binormal;	//ADD

void main(void)
{	
	uv = VertexTexCoord;
	vec3 vNormal = vec3(Object * vec4(VertexNormal, 1.0));	//normals in World space
	position = vec3(Object * vec4(VertexPosition, 1.0));	//positions in World space
	int size = 2;
	switch(gl_InstanceID) {
	  case 0:
	   position.x += size; 
	   position.z += size; 
	   break;
	  case 1:
	   position.x += -size; 
	   position.z += size; 
	   break;
	  case 2:
	   position.x += size; 
	   position.z += -size; 
	   break;
	  case 3:
	   position.x += -size; 
	   position.z += -size; 
	   break;
	  case 4:
	   position.x += size; 
	   position.y += 2*size; 
	   position.z += size; 
	   break;
	  case 5:
	   position.x += -size; 
	   position.y += 2*size; 
	   position.z += size; 
	   break;
	  case 6:
	   position.x += size; 
	   position.y += 2*size; 
	   position.z += -size; 
	   break;
	  case 7:
	   position.x += -size; 
	   position.y += 2*size; 
	   position.z += -size; 
	   break;
	  case 8:
	   position.y += size; 
	   break;
	}
	gl_Position = Projection * View * Object * vec4(position, 1.0);	//positions in Clipping space
	
	//############  ADD  ##################
	
	vec3 NormalFromMap = normalize(texture(NormalMap, uv).rgb * 2.0 - 1.0);
	vec3 tmpNormal;
	tmpNormal.x = VertexNormal.x + NormalFromMap.x;
	tmpNormal.y = VertexNormal.y + NormalFromMap.y;
	tmpNormal.z = VertexNormal.z + NormalFromMap.z -1;
	normal = normalize(vec3(Object * vec4(tmpNormal, 1.0)));	//normals in World space ? // couleurs chelous ça doit pas etre le bon repere
	VertexNormal = normal;
	/*
	vec3 vTangent;
	vec3 c1 = cross(normal, vec3(0.0, 0.0, 1.0)); 
	vec3 c2 = cross(normal, vec3(0.0, 1.0, 0.0)); 
	
	if(length(c1)>length(c2))
	{
		vTangent = c1;	
	}
	else
	{
		vTangent = c2;	
	}
	normal = normalize(normal);
	tangent = normalize(vTangent);
	
	vBinormal = cross(normal, tangent);
	vBinormal = normalize(vBinormal);
	*/
}

#endif

#if defined(FRAGMENT)
uniform vec3 CameraPosition;
uniform float Time;

in vec2 uv;
in vec3 position;
in vec3 normal;

uniform sampler2D Diffuse;
uniform sampler2D Spec;

out vec4  Color;
out vec4  Normal;

void main(void)
{
	vec3 diffuse = texture(Diffuse, uv).rgb;
	float spec = texture(Spec, uv).r;
	Color = vec4(diffuse, spec);
	Normal = vec4(normal, spec);
}

#endif
