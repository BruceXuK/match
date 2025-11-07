<template>
  <div class="app-container">
    <div class="header-tip">
      <el-alert
        title="欢迎使用赛事报名系统！"
        type="success"
        description="在这里您可以查看所有开放报名的赛事并进行在线报名。请选择您感兴趣的赛事，点击'报名'按钮完成报名操作。"
        show-icon
        :closable="false">
      </el-alert>
    </div>
    
    <el-table 
      v-loading="loading" 
      :data="eventList" 
      border 
      fit 
      highlight-current-row 
      style="width: 100%"
      :row-class-name="tableRowClassName"
      header-cell-class-name="table-header">
      <el-table-column prop="eventName" label="赛事名称" width="180">
        <template slot-scope="scope">
          <el-tag type="primary">{{ scope.row.eventName }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="eventDescription" label="赛事描述" show-overflow-tooltip min-width="200">
        <template slot-scope="scope">
          <span class="event-description">{{ scope.row.eventDescription || '暂无描述' }}</span>
        </template>
      </el-table-column>
      <el-table-column prop="eventTime" label="赛事时间" width="180" align="center">
        <template slot-scope="scope">
          <i class="el-icon-time"></i>
          <span class="event-time">{{ scope.row.eventTime }}</span>
        </template>
      </el-table-column>
      <el-table-column prop="registrationStartTime" label="报名开始时间" width="180" align="center">
        <template slot-scope="scope">
          <i class="el-icon-circle-check" style="color: #67C23A"></i>
          <span>{{ scope.row.registrationStartTime }}</span>
        </template>
      </el-table-column>
      <el-table-column prop="registrationEndTime" label="报名截止时间" width="180" align="center">
        <template slot-scope="scope">
          <i class="el-icon-warning-outline" style="color: #E6A23C"></i>
          <span>{{ scope.row.registrationEndTime }}</span>
        </template>
      </el-table-column>
      <el-table-column label="参赛人数" width="150" align="center">
        <template slot-scope="scope">
          <el-progress 
            :percentage="calculatePercentage(scope.row)" 
            :status="getProgressStatus(scope.row)"
            :stroke-width="12"
            text-inside>
          </el-progress>
          <div class="participant-count">
            {{ scope.row.currentParticipants || 0 }} / {{ scope.row.maxParticipants }}
          </div>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="120" align="center" class-name="small-padding fixed-width" fixed="right">
        <template slot-scope="scope">
          <el-button 
            size="mini" 
            :type="scope.row.isRegistered ? 'success' : 'primary'" 
            round
            @click="handleRegister(scope.row)"
            :disabled="scope.row.isRegistered">
            <i :class="scope.row.isRegistered ? 'el-icon-check' : 'el-icon-edit'"></i>
            {{ scope.row.isRegistered ? '已报名' : '报名' }}
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    
    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />
    
    <!-- 赛事报名对话框 -->
    <el-dialog :title="registerTitle" :visible.sync="registerOpen" width="700px" append-to-body>
      <el-form ref="registerForm" :model="registerForm" :rules="registerRules" label-width="100px">
        <el-card class="box-card">
          <div slot="header" class="clearfix">
            <span>赛事信息</span>
          </div>
          <el-row :gutter="20">
            <el-col :span="12">
              <el-form-item label="赛事名称" prop="eventName">
                <el-input v-model="registerForm.eventName" disabled />
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="赛事时间" prop="eventTime">
                <el-input v-model="registerForm.eventTime" disabled />
              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="20">
            <el-col :span="12">
              <el-form-item label="报名开始时间" prop="registrationStartTime">
                <el-input v-model="registerForm.registrationStartTime" disabled />
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="报名截止时间" prop="registrationEndTime">
                <el-input v-model="registerForm.registrationEndTime" disabled />
              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="20">
            <el-col :span="24">
              <el-form-item label="赛事描述" prop="eventDescription">
                <el-input v-model="registerForm.eventDescription" type="textarea" disabled />
              </el-form-item>
            </el-col>
          </el-row>
        </el-card>
        
        <el-card class="box-card" style="margin-top: 15px">
          <div slot="header" class="clearfix">
            <span>报名人信息</span>
          </div>
          <el-row :gutter="20">
            <el-col :span="12">
              <el-form-item label="用户昵称" prop="nickName">
                <el-input v-model="registerForm.nickName" disabled />
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="登录账号" prop="userName">
                <el-input v-model="registerForm.userName" disabled />
              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="20">
            <el-col :span="12">
              <el-form-item label="手机号码" prop="phonenumber">
                <el-input v-model="registerForm.phonenumber" disabled />
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="邮箱" prop="email">
                <el-input v-model="registerForm.email" disabled />
              </el-form-item>
            </el-col>
          </el-row>
        </el-card>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitRegister" :loading="submitLoading">确 定</el-button>
        <el-button @click="cancelRegister">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listAvailableEvents, registerEvent, isRegistered } from "@/api/event";
import { getUserProfile } from "@/api/system/user";

export default {
  name: "EventList",
  data() {
    return {
      loading: true,
      formLoading: false,
      submitLoading: false,
      eventList: [],
      registeredEvents: [], // 已报名的赛事列表
      total: 0,
      queryParams: {
        pageNum: 1,
        pageSize: 10
      },
      registerOpen: false,
      registerTitle: "赛事报名",
      registerForm: {},
      registerRules: {
        userId: [
          { required: true, message: "用户ID不能为空", trigger: "blur" }
        ]
      },
      userInfo: {}
    };
  },
  created() {
    this.getList();
    this.getUserInfo();
  },
  methods: {
    /** 查询赛事列表 */
    getList() {
      this.loading = true;
      listAvailableEvents().then(response => {
        this.eventList = response.rows;
        this.total = response.total;
        
        // 检查每个赛事用户是否已报名
        if (this.userInfo && this.userInfo.userId) {
          const promises = this.eventList.map(event => {
            return isRegistered(this.userInfo.userId, event.id).then(res => {
              // 使用 $set 确保视图更新
              this.$set(event, 'isRegistered', res.data);
              return event;
            });
          });
          
          Promise.all(promises).then(() => {
            this.loading = false;
          });
        } else {
          this.loading = false;
        }
      }).catch(err => {
        this.loading = false;
        this.$modal.msgError("获取赛事列表失败");
      });
    },
    
    /** 获取当前用户信息 */
    getUserInfo() {
      getUserProfile().then(response => {
        this.userInfo = response.data;
        // 重新加载列表以更新报名状态
        if (this.eventList.length > 0) {
          this.getList();
        }
      }).catch(err => {
        this.$modal.msgError("获取用户信息失败");
      });
    },
    
    /** 计算参赛人数百分比 */
    calculatePercentage(row) {
      if (!row.maxParticipants) return 0;
      const percentage = ((row.currentParticipants || 0) / row.maxParticipants) * 100;
      return Math.min(100, Math.max(0, percentage));
    },
    
    /** 获取进度条状态 */
    getProgressStatus(row) {
      const percentage = this.calculatePercentage(row);
      if (percentage < 30) return null;  // 修改为返回null而不是空字符串
      if (percentage < 60) return 'success';
      if (percentage < 90) return 'warning';
      return 'exception';
    },
    
    /** 表格行样式 */
    tableRowClassName({row, rowIndex}) {
      if (row.isRegistered) {
        return 'registered-row';
      }
      return '';
    },
    
    /** 报名按钮操作 */
    handleRegister(row) {
      this.registerForm = {
        eventId: row.id,
        eventName: row.eventName,
        eventTime: row.eventTime,
        eventDescription: row.eventDescription,
        registrationStartTime: row.registrationStartTime,
        registrationEndTime: row.registrationEndTime,
        nickName: this.userInfo ? this.userInfo.nickName : "",
        userName: this.userInfo ? this.userInfo.userName : "",
        phonenumber: this.userInfo ? this.userInfo.phonenumber : "",
        email: this.userInfo ? this.userInfo.email : "",
        userId: this.userInfo ? this.userInfo.userId : ""
      };
      this.registerOpen = true;
      this.registerTitle = "赛事报名";
    },
    
    /** 提交报名 */
    submitRegister() {
      this.$refs["registerForm"].validate(valid => {
        if (valid) {
          this.submitLoading = true;
          // 从表单中提取userId作为参数传递给registerEvent方法
          const eventId = this.registerForm.eventId;
          const registerData = {
            userId: this.registerForm.userId
          };
          
          registerEvent(eventId, registerData).then(response => {
            this.submitLoading = false;
            this.$modal.msgSuccess("报名成功");
            this.registerOpen = false;
            this.reset();
            this.getList(); // 重新加载列表以更新数据
          }).catch(error => {
            this.submitLoading = false;
            this.$modal.msgError("报名失败: " + (error.message || "未知错误"));
          });
        }
      });
    },
    
    /** 取消报名 */
    cancelRegister() {
      this.registerOpen = false;
      this.reset();
    },
    
    /** 表单重置 */
    reset() {
      this.registerForm = {
        eventId: undefined,
        eventName: undefined,
        eventTime: undefined,
        eventDescription: undefined,
        registrationStartTime: undefined,
        registrationEndTime: undefined,
        nickName: undefined,
        userName: undefined,
        phonenumber: undefined,
        email: undefined,
        userId: undefined
      };
      this.resetForm("registerForm");
    }
  }
};
</script>

<style scoped>
.app-container {
  padding: 20px;
  background-color: #f5f7fa;
}

.header-tip {
  margin-bottom: 20px;
}

.box-card {
  border-radius: 8px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.card-title {
  font-size: 18px;
  font-weight: bold;
  color: #303133;
}

.table-header {
  background-color: #f8f9fa !important;
  color: #303133 !important;
  font-weight: bold;
}

.event-description {
  color: #606266;
  font-size: 14px;
}

.event-time {
  margin-left: 5px;
  color: #409EFF;
  font-weight: 500;
}

.participant-count {
  margin-top: 5px;
  font-size: 12px;
  color: #909399;
  text-align: center;
}

.registered-row {
  background-color: #f0f9eb;
}

.dialog-footer {
  text-align: right;
}

/* 添加一些动画效果 */
.el-card {
  transition: all 0.3s ease;
}

.el-card:hover {
  box-shadow: 0 4px 20px 0 rgba(0, 0, 0, 0.15);
}

/* 优化表格行的悬停效果 */
.el-table tbody tr:hover {
  background-color: #f5f7fa !important;
}

/* 已报名行的特殊标识 */
.registered-row td:first-child {
  border-left: 4px solid #67C23A;
}
</style>