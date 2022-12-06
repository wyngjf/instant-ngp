export ngp_path=$(pwd)

function init_ngp(){
	module load devel/cuda/11.6
	module load vis/ffmpeg/5.1
	export GLEW_INCLUDE_DIRS="$ngp_path/dependencies/glew/glew-2.1.0/include"
	export GLEW_LIBRARIES="$ngp_path/dependencies/glew/glew-2.1.0/lib"
}


function setup_glew() {
  local prev_pwd=$(pwd)

  mkdir -p "$ngp_path/dependencies/glew" &>/dev/null || true
  cd "$ngp_path/dependencies/glew"

  if [[ ! -d usr ]]; then
    wget "https://nav.dl.sourceforge.net/project/glew/glew/2.1.0/glew-2.1.0.tgz"
    tar zxvf glew-2.1.0.tgz
    rm zxvf glew-2.1.0.tgz
  fi

  cd "$prev_pwd"
}
