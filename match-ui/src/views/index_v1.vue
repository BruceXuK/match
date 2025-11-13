<template>
  <div class="dashboard-editor-container">
    <panel-group @handleSetLineChartData="handleSetLineChartData" />

    <!-- 添加文件上传区域 -->
    <el-row :gutter="20" style="margin-bottom: 20px;">
      <el-col :span="24">
        <el-card class="upload-card">
          <div slot="header" class="clearfix">
            <span>数据文件上传</span>
          </div>
          <file-upload
            ref="fileUpload"
            :file-type="['doc', 'docx', 'pdf', 'ppt', 'md', 'xlsx', 'txt', 'rar', 'tiff', 'mp4', 'json', 'jsonl', 'csv', 'tsv', 'zip', 'jpg', 'png', 'pt', 'mdl', 'gguf', 'safetensors']"
            file-save-path=""
            @uploadSuccess="handleUploadSuccess"
            @uploadFinish="handleUploadFinish"
          />
          <div style="margin-top: 20px;">
            <el-button
              type="primary"
              @click="submitUpload"
              :disabled="canUpload"
            >
              提交上传
            </el-button>
            <el-button @click="resetUpload">重置</el-button>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <el-row style="background:#fff;padding:16px 16px 0;margin-bottom:32px;">
      <line-chart :chart-data="lineChartData" />
    </el-row>

    <el-row :gutter="32">
      <el-col :xs="24" :sm="24" :lg="8">
        <div class="chart-wrapper">
          <raddar-chart />
        </div>
      </el-col>
      <el-col :xs="24" :sm="24" :lg="8">
        <div class="chart-wrapper">
          <pie-chart />
        </div>
      </el-col>
      <el-col :xs="24" :sm="24" :lg="8">
        <div class="chart-wrapper">
          <bar-chart />
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import PanelGroup from '@/views/dashboard/PanelGroup'
import LineChart from '@/views/dashboard/LineChart'
import RaddarChart from '@/views/dashboard/RaddarChart'
import PieChart from '@/views/dashboard/PieChart'
import BarChart from '@/views/dashboard/BarChart'
import FileUpload from '@/components/DataCollectionFile/fileUpload'

const lineChartData = {
  newVisitis: {
    expectedData: [100, 120, 161, 134, 105, 160, 165],
    actualData: [120, 82, 91, 154, 162, 140, 145]
  },
  messages: {
    expectedData: [200, 192, 120, 144, 160, 130, 140],
    actualData: [180, 160, 151, 106, 145, 150, 130]
  },
  purchases: {
    expectedData: [80, 100, 121, 104, 105, 90, 100],
    actualData: [120, 90, 100, 138, 142, 130, 130]
  },
  shoppings: {
    expectedData: [130, 140, 141, 142, 145, 150, 160],
    actualData: [120, 82, 91, 154, 162, 140, 130]
  }
}

export default {
  name: 'Index',
  components: {
    PanelGroup,
    LineChart,
    RaddarChart,
    PieChart,
    BarChart,
    FileUpload
  },
  data() {
    return {
      lineChartData: lineChartData.newVisitis
    }
  },
  computed: {
    canUpload() {
      return this.$refs.fileUpload && this.$refs.fileUpload.fileList && this.$refs.fileUpload.fileList.length > 0
    }
  },
  methods: {
    handleSetLineChartData(type) {
      this.lineChartData = lineChartData[type]
    },
    submitUpload() {
      if (this.$refs.fileUpload && this.$refs.fileUpload.fileList && this.$refs.fileUpload.fileList.length > 0) {
        this.$refs.fileUpload.uploadFile()
      } else {
        this.$message.warning('请选择要上传的文件')
      }
    },
    resetUpload() {
      if (this.$refs.fileUpload) {
        this.$refs.fileUpload.reset()
      }
    },
    handleUploadSuccess(data) {
      console.log('上传成功:', data)
      // 这里可以处理上传成功的回调
    },
    handleUploadFinish() {
      console.log('上传完成')
      // 这里可以处理上传完成的回调
      this.$message.success('文件上传完成')
    }
  }
}
</script>

<style lang="scss" scoped>
.dashboard-editor-container {
  padding: 32px;
  background-color: rgb(240, 242, 245);
  position: relative;

  .chart-wrapper {
    background: #fff;
    padding: 16px 16px 0;
    margin-bottom: 32px;
  }

  .upload-card {
    background: #fff;
  }
}

@media (max-width:1024px) {
  .chart-wrapper {
    padding: 8px;
  }
}
</style>
