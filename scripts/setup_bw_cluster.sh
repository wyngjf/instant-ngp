export ngp_path
ngp_path=$(pwd)

function init_ngp(){
	module load devel/cuda/11.8
	module load vis/ffmpeg/5.1
	module load devel/cmake/3.23.3
}


function compile() {
	cd $ngp_path || return
	TCNN_CUDA_ARCHITECTURES=70 cmake . -B build -DNGP_BUILD_ON_CLUSTER=ON
	cmake --build build --config RelWithDebInfo -j60
}


function setup_glew() {
	local prev_pwd
	prev_pwd=$(pwd)

	mkdir -p "$ngp_path/dependencies/glew" &>/dev/null || true
	cd "$ngp_path/dependencies/glew" || return

	if [[ ! -d usr ]]; then
		wget "https://nav.dl.sourceforge.net/project/glew/glew/2.1.0/glew-2.1.0.tgz"
		tar zxvf glew-2.1.0.tgz
		rm glew-2.1.0.tgz
	fi

	cd "$prev_pwd" || return
}

function setup_cmake() {
	local prev_pwd
	prev_pwd=$(pwd)

	mkdir -p "$ngp_path/dependencies/cmake" &>/dev/null || true
	cd "$ngp_path/dependencies/cmake" || return

	if [[ ! -d "$ngp_path/dependencies/cmake/cmake-3.21.0" ]]; then
		wget "https://cmake.org/files/v3.21/cmake-3.21.0.tar.gz"
		tar zxvf cmake-3.21.0.tar.gz
		rm cmake-3.21.0.tar.gz
	fi

	cd cmake-3.21.0 || return
	./bootstrap
	make -j60

	cd "$prev_pwd" || return

}
