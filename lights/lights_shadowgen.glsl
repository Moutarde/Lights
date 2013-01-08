#if defined(VERTEX)
uniform mat4 Projection;
uniform mat4 View;
uniform mat4 Object;

in vec3 VertexPosition;
in vec3 VertexNormal;
in vec2 VertexTexCoord;

out vec2 uv;
out vec3 normal;
out vec3 position;

void main(void)
{	
	uv = VertexTexCoord;
	normal = vec3(Object * vec4(VertexNormal, 1.0));; 
	position = vec3(Object * vec4(VertexPosition, 1.0));
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
	gl_Position = Projection * View * vec4(position, 1.0);
}

#endif

#if defined(FRAGMENT)

out vec4  Color;

in vec3 normal;

void main(void)
{
}

#endif
