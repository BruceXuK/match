<template>
  <div>
    <!-- 上传区域 -->
    <div class="upload-area" v-show="!uploadStatus.showProgress">
      <el-upload
        class="upload-demo"
        ref="upload"
        drag
        action="#"
        :auto-upload="false"
        :on-change="handleFileChange"
        :on-exceed="handleExceed"
        :limit="1"
        :show-file-list="false"
      >
        <i class="el-icon-upload"></i>
        <div class="el-upload__text">
          <p>将文件拖到此处，或<em>点击上传</em></p>
          <p class="upload-tips">支持多种格式文件上传</p>
        </div>
      </el-upload>
    </div>

    <!-- 上传进度 -->
    <div class="upload-progress" v-show="uploadStatus.showProgress">
      <div class="file-info">
        <i class="el-icon-document file-icon"></i>
        <span class="file-name">{{ uploadStatus.fileName }}</span>
      </div>
      <el-progress 
        :percentage="uploadStatus.percentage" 
        :stroke-width="10" 
        status="success"
        v-show="uploadStatus.percentage > 0"
      ></el-progress>
      <div class="progress-text">
        <span v-if="uploadStatus.percentage < 100">
          上传进度: {{ uploadStatus.percentage }}% ({{ formatFileSize(uploadStatus.uploadedSize) }} / {{ formatFileSize(uploadStatus.totalSize) }})
        </span>
        <span v-else class="success-text">上传完成</span>
      </div>
    </div>
  </div>
</template>

<script>
import SparkMD5 from "spark-md5";
import { 
  initUploadLargeFile, 
  listUploadLargeFileUrls, 
  completeMultipartUpload 
} from "@/api/system/oss";

export default {
  name: "OssFileUpload",
  props: {
    // 文件保存路径
    savePath: {
      type: String,
      default: ""
    },
    // 允许的文件类型
    accept: {
      type: String,
      default: ""
    }
  },
  data() {
    return {
      // 上传的文件
      file: null,
      // 分片大小 (5MB)
      chunkSize: 5 * 1024 * 1024,
      // 上传状态
      uploadStatus: {
        showProgress: false,
        fileName: "",
        percentage: 0,
        uploadedSize: 0,
        totalSize: 0,
        status: "ready" // ready, uploading, completed
      }
    };
  },
  methods: {
    // 处理文件选择
    handleFileChange(file, fileList) {
      if (!file) return;
      
      // 检查文件类型
      if (this.accept && !this.checkFileType(file.name)) {
        this.$message.error(`不支持的文件类型，请上传${this.accept}格式的文件`);
        return;
      }
      
      this.file = file.raw || file;
      this.startUpload();
    },
    
    // 检查文件类型
    checkFileType(fileName) {
      if (!this.accept) return true;
      
      const fileExt = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();
      const acceptExts = this.accept.split(",").map(ext => ext.trim().toLowerCase());
      return acceptExts.includes(fileExt);
    },
    
    // 开始上传
    async startUpload() {
      if (!this.file) {
        this.$message.error("未选择文件");
        return;
      }
      
      try {
        // 显示上传进度
        this.uploadStatus.showProgress = true;
        this.uploadStatus.fileName = this.file.name;
        this.uploadStatus.totalSize = this.file.size;
        this.uploadStatus.uploadedSize = 0;
        this.uploadStatus.percentage = 0;
        this.uploadStatus.status = "uploading";
        
        // 计算文件MD5
        const md5 = await this.calculateFileMD5(this.file);
        
        // 初始化大文件上传
        const initResponse = await initUploadLargeFile(this.file.name, md5, this.savePath);
        
        if (initResponse.code !== 200) {
          throw new Error("初始化上传失败");
        }
        
        const initData = initResponse.data;
        
        // 如果文件已存在，直接完成
        if (initData.uploadStatus === "finish_upload") {
          this.uploadStatus.percentage = 100;
          this.uploadStatus.uploadedSize = this.file.size;
          this.uploadStatus.status = "completed";
          this.$emit("success", {
            ossId: initData.ossId,
            fileName: this.file.name,
            url: initData.url
          });
          return;
        }
        
        // 获取分片上传URL
        const partCount = Math.ceil(this.file.size / this.chunkSize);
        const urlResponse = await listUploadLargeFileUrls(
          initData.objectKey || this.file.name,
          initData.uploadId,
          partCount
        );
        
        if (urlResponse.code !== 200) {
          throw new Error("获取分片上传地址失败");
        }
        
        // 上传各个分片
        const uploadUrls = urlResponse.data;
        for (let i = 0; i < partCount; i++) {
          const start = i * this.chunkSize;
          const end = Math.min(this.file.size, start + this.chunkSize);
          const chunk = this.file.slice(start, end);
          
          // 上传分片
          await this.uploadChunk(uploadUrls[`chunk_${i}`], chunk);
          
          // 更新进度
          this.uploadStatus.uploadedSize = end;
          this.uploadStatus.percentage = Math.floor((end / this.file.size) * 100);
        }
        
        // 合并分片
        await completeMultipartUpload(initData.objectKey || this.file.name, initData.uploadId);
        
        // 上传完成
        this.uploadStatus.percentage = 100;
        this.uploadStatus.status = "completed";
        
        this.$emit("success", {
          ossId: initData.ossId,
          fileName: this.file.name,
          url: initData.url
        });
        
        this.$emit("complete");
        
        this.$message.success("文件上传成功");
      } catch (error) {
        console.error("上传失败:", error);
        this.$message.error("文件上传失败: " + (error.message || "未知错误"));
        this.resetUpload();
      }
    },
    
    // 上传单个分片
    uploadChunk(url, chunk) {
      return new Promise((resolve, reject) => {
        const xhr = new XMLHttpRequest();
        
        xhr.open("PUT", url, true);
        
        xhr.onload = function() {
          if (xhr.status === 200) {
            resolve();
          } else {
            reject(new Error(`上传分片失败: ${xhr.status}`));
          }
        };
        
        xhr.onerror = function() {
          reject(new Error("网络错误"));
        };
        
        xhr.send(chunk);
      });
    },
    
    // 计算文件MD5
    calculateFileMD5(file) {
      return new Promise((resolve, reject) => {
        const spark = new SparkMD5.ArrayBuffer();
        const fileReader = new FileReader();
        const chunkSize = 2 * 1024 * 1024; // 2MB per chunk
        let currentChunk = 0;
        const chunks = Math.ceil(file.size / chunkSize);
        
        fileReader.onload = function(e) {
          spark.append(e.target.result);
          
          currentChunk++;
          
          if (currentChunk < chunks) {
            loadNext();
          } else {
            const md5 = spark.end();
            resolve(md5);
          }
        };
        
        fileReader.onerror = function() {
          reject(new Error("计算文件MD5失败"));
        };
        
        function loadNext() {
          const start = currentChunk * chunkSize;
          const end = Math.min(start + chunkSize, file.size);
          const blobSlice = File.prototype.slice || File.prototype.mozSlice || File.prototype.webkitSlice;
          const chunk = blobSlice.call(file, start, end);
          fileReader.readAsArrayBuffer(chunk);
        }
        
        loadNext();
      });
    },
    
    // 格式化文件大小
    formatFileSize(size) {
      if (size === 0) return "0 Bytes";
      
      const k = 1024;
      const sizes = ["Bytes", "KB", "MB", "GB"];
      const i = Math.floor(Math.log(size) / Math.log(k));
      
      return parseFloat((size / Math.pow(k, i)).toFixed(2)) + " " + sizes[i];
    },
    
    // 处理文件超出限制
    handleExceed() {
      this.$message.warning("只能上传一个文件");
    },
    
    // 重置上传状态
    resetUpload() {
      this.file = null;
      this.uploadStatus.showProgress = false;
      this.uploadStatus.fileName = "";
      this.uploadStatus.percentage = 0;
      this.uploadStatus.uploadedSize = 0;
      this.uploadStatus.totalSize = 0;
      this.uploadStatus.status = "ready";
    },
    
    // 手动触发上传（对外暴露的方法）
    upload() {
      if (this.file) {
        this.startUpload();
      } else {
        this.$message.warning("请先选择文件");
      }
    }
  }
};
</script>

<style scoped>
.upload-area {
  width: 100%;
}

.upload-demo ::v-deep .el-upload {
  width: 100%;
}

.upload-demo ::v-deep .el-upload-dragger {
  width: 100%;
  padding: 40px 0;
}

.upload-tips {
  font-size: 12px;
  color: #999;
  margin-top: 8px;
}

.upload-progress {
  padding: 20px;
}

.file-info {
  display: flex;
  align-items: center;
  margin-bottom: 15px;
}

.file-icon {
  font-size: 24px;
  color: #409EFF;
  margin-right: 10px;
}

.file-name {
  font-size: 14px;
  color: #333;
  flex: 1;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.progress-text {
  margin-top: 10px;
  font-size: 12px;
  color: #666;
  text-align: center;
}

.success-text {
  color: #67C23A;
  font-weight: bold;
}
</style>