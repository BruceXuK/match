<template>
  <div>
    <div class="uploadButton" v-show="!statusShow && fileList.length == 0">
      <el-upload
        class="upload-demo"
        ref="uploadfiles"
        name="file"
        drag
        action="#"
        :multiple="false"
        :auto-upload="false"
        :on-change="onChange"
        :show-file-list="false"
        :accept="fileType.join(',')"
      >
        <i class="el-icon-upload"></i>
        <div class="el-upload__text">
          <p>
            <span style="color: #3171ee">点击上传 </span>
          </p>
          <p class="upload-tips">
            支持文档格式为{{ this.fileType.join("/") }}大文件
          </p>
        </div>
      </el-upload>
    </div>
    <div class="preview" v-show="!statusShow">
      <img
        src="@/assets/images/dataFile.png"
        width="70px"
        v-show="fileList.length != 0 && !statusShow"
      />
      <span class="text">{{
        fileList.length != 0 ? fileList[0].name : ""
      }}</span>
    </div>

    <!--  提示  -->
    <div class="uploadInfo" v-show="statusShow">
      <img src="@/assets/images/dataFile.png" width="70px" />
      <span class="text">{{ fileInfo.fileName }}</span>
      <el-progress
        class="progress-1"
        :percentage="schedule"
        :stroke-width="4"
        style="width: 200px"
      />
      <span
        v-show="schedule === 100"
        style="font-size: 12px; padding: 0 10px 0 20px; color: #31cd31"
        >上传成功!</span
      >
    </div>
  </div>
</template>

<script>
import SparkMD5 from "spark-md5";
import axios from "axios";
import {
  largeFileInit,
  largerUrlInit,
  mergeFile,
} from "@/api/dataResourceManagement/dataCollection.js";
export default {
  name: "bigFileUpload",
  props: {
    fileSavePath: {
      type: String,
      default: "",
    },
    fileType: {
      type: Array,
      default: () => [],
    },
  },
  data() {
    return {
      fileInfo: {
        fileName: "",
        fileMd5: "",
        chunkCount: 0,
      },
      fileParams: {
        objectKey: null,
        md5: null,
        savePath: null,
        chunkCount: null,
      },
      statusShow: false,
      schedule: 0,
      chunkSize: 5 * 1024 * 1024, // 减小分片大小到1MB，减少单次传输时间
      fileTypes:
        ".doc, .docx, .pdf, .ppt, .md, .xlsx, .txt, .rar, .tiff, .mp4, .json, .jsonl, .csv, .tsv, .zip, .jpg, .png, .pt, .mdl .gguf, .safetensors",
      fileList: [],
    };
  },
  methods: {
    reset() {
      this.fileList = [];
      this.statusShow = false;
    },
    beforeUpload(file) {
      console.log("file", file);
      // if (
      //   file.raw.name.indexOf(".doc") == -1 &&
      //   file.raw.name.indexOf(".docx") == -1 &&
      //   file.raw.name.indexOf(".pdf") == -1 &&
      //   file.raw.name.indexOf(".ppt") == -1 &&
      //   file.raw.name.indexOf(".md") == -1 &&
      //   file.raw.name.indexOf(".xlsx") == -1 &&
      //   file.raw.name.indexOf(".txt") == -1 &&
      //   file.raw.name.indexOf(".rar") == -1 &&
      //   file.raw.name.indexOf(".tiff") == -1 &&
      //   file.raw.name.indexOf(".mp4") == -1 &&
      //   file.raw.name.indexOf(".json") == -1 &&
      //   file.raw.name.indexOf(".csv") == -1 &&
      //   file.raw.name.indexOf(".tsv") == -1 &&
      //   file.raw.name.indexOf(".zip") == -1 &&
      //   file.raw.name.indexOf(".jpg") == -1 &&
      //   file.raw.name.indexOf(".png") == -1 &&
      //   file.raw.name.indexOf(".pt") == -1 &&
      //   file.raw.name.indexOf(".mdl") == -1 &&
      //   file.raw.name.indexOf(".gguf") == -1 &&
      //   file.raw.name.indexOf(".safetensors") == -1
      // ) {
      //   return false;
      // } else if(file.raw.size === 0){
      //   return false;
      // } else {
      //   return true;
      // }
      let isFile = false;
      let fileExtension = "";
      if (file.name.lastIndexOf(".") > -1) {
        fileExtension = file.name.slice(file.name.lastIndexOf(".") + 1);
      }
      isFile = this.fileType.some((type) => {
        if (file.name.indexOf(type) > -1) return true;
        if (fileExtension && fileExtension.indexOf(type) > -1) return true;
        return false;
      });
      if (!isFile) {
        this.$modal.msgError(
          `文件格式不正确, 请上传${this.fileType.join("/")}格式文件!`
        );
        return false;
      } else if (file.raw.size === 0) {
        return false;
      } else {
        return true;
      }
    },
    onChange(file, fileList) {
      if (!this.beforeUpload(file)) {
        // this.$message({
        //   message: "只能上传规定大小或者格式的文件",
        //   type: "error",
        // });
        return;
      }
      this.fileList.push(file);
      // const _this = this;
      // const sigleNum = 20; //单个文件最大20M
      // const isLt = file.size / 1024 / 1024 < sigleNum;
      // if (!isLt) {
      //   this.$message({
      //     message: `${file.name}上传失败，单个文件最大支持20M`,
      //     type: "error",
      //     duration: 3000,
      //   });
      //   return;
      // }
      // const fileName = file.name;
      // const fileType = fileName
      //   .substring(fileName.lastIndexOf("."))
      //   .split(".")[1];
      // file.type = fileType;
      // this.productionList.push(file);
      // console.log(this.productionList);
    },
    async uploadFile() {
      // 获取上传的文件
      const file = this.fileList[0].raw;
      console.log(this.fileList);
      // 检验文件的合法性
      if (file === undefined) {
        this.$message({
          message: "文件损坏请重新上传",
          type: "error",
        });
        return;
      }
      // 封装初始化参数
      if (file.size > 0) {
        this.statusShow = true;
        this.fileParams.objectKey = file.name;
        this.fileParams.md5 = await this.getFileMd5(file);
        this.fileParams.savePath = this.fileSavePath;
        // this.fileParams.chunkCount = Math.ceil(file.size / this.chunkSize)
      }
      console.log("fileParams", this.fileParams);
      // 第一步：初始上传文件判断状态
      largeFileInit(this.fileParams).then(async (res) => {
        console.log("largeFileInit", res);
        if (res.code === 200) {
          this.$emit("uploadSuccess", {
            ossId: res.data.ossId,
            fileName: file.name,
            fileSize: file.size,
          });
          if (res.data.uploadStatus === "finish_upload") {
            return;
          } else {
            let urlObj = {
              objectKey: res.data.fileName || file.name,
              uploadId: res.data.uploadId,
              partSize: Math.ceil(file.size / this.chunkSize),
            };
            console.log("开始切片:"+urlObj.objectKey);
            console.log("开始切片:"+urlObj.uploadId);
            console.log("开始切片:"+urlObj.partSize);
            // 第二步：获取切片后的每一片文件的地址
            largerUrlInit(urlObj).then(async (val) => {
              if (val.code === 200) {
                const arrNew = [];
                for (let i = 0; i < urlObj.partSize; i++) {
                  let object = {
                    partNumber: i + 1,
                    uploadUrl: val.data[`chunk_${i}`],
                  };
                  arrNew.push(object);
                }
                console.log("arrNew", arrNew);
                let progress = 0;
                const allArrNew = arrNew.map(async (item) => {
                  // 分片开始位置
                  const start = (item.partNumber - 1) * this.chunkSize;
                  // 分片结束位置
                  const end = Math.min(file.size, start + this.chunkSize);
                  // 取文件指定范围内的byte，从而得到分片数据
                  const chunkFile = file.slice(start, end);
                  await this.$http.put(item.uploadUrl, chunkFile);
                  progress++;
                  this.schedule = parseFloat(
                    ((progress / urlObj.partSize) * 100)
                      .toString()
                      .substring(0, 4)
                  );
                });
                await Promise.all(allArrNew);
                // 第三步进行切片合并
                mergeFile(urlObj).then((con) => {
                  if (con.code === 200) {
                    this.$message({
                      message: "文件上传成功",
                      type: "success",
                    });
                    this.$emit("uploadFinish");
                    this.fileList = [];
                  }
                });
              }
            });
          }
        } else {
          this.$message({
            message: "上传有误, 请重新上传",
            type: "error",
          });
        }
      });
    },
    getFileMd5(file) {
      const _this = this;
      const fileReader = new FileReader();
      const spark = new SparkMD5.ArrayBuffer(); // 使用 ArrayBuffer 进逐块读取
      return new Promise((resolve, reject) => {
        fileReader.onload = (e) => {
          spark.append(e.target.result);
          resolve(spark.end());
        };

        fileReader.onerror = (e) => {
          reject(e);
        };

        // 分块读取文件
        const chunkSize = 5 * 1024 * 1024; // 每次读取 1MB
        let offset = 0;
        let progress = 0;
        function readNextChunk() {
          const reader = new FileReader();
          const blob = file.slice(offset, offset + chunkSize);
          reader.onload = (e) => {
            spark.append(e.target.result);
            offset += chunkSize;
            if (offset < file.size) {
              // progress++;
              // _this.schedule = parseFloat(
              //   ((progress / offset) * 100).toString().substring(0, 4)
              // );
              // console.log()
              readNextChunk();
            } else {
              resolve(spark.end()); // 文件读取完毕，返回 MD5
            }
          };
          reader.readAsArrayBuffer(blob);
        }

        readNextChunk(); // 开始读取文件
      });
    },
  },
};
</script>

<style scoped lang="scss">
::v-deep .upload-demo .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;

  .el-upload__text {
    line-height: 19px;
    p {
      margin: 0;
      height: 20px;
    }
  }
}
.upload-demo .el-upload:hover {
  border-color: #409eff;
}
.preview {
  display: flex;
  align-items: center;
  .text {
    padding: 0px 10px 0px 10px;
  }
}
.uploadInfo {
  display: flex;
  align-items: center;
  .text {
    font-size: 12px;
    padding: 0px 10px 0px 10px;
    width: 200px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
  }
}
</style>
