<template>
  <div class="app-container">
    <el-row :gutter="20">
      <el-col :sm="24" :lg="24">
        <EventList />
      </el-col>
    </el-row>
  </div>
</template>

<script>
import EventList from './EventList'

export default {
  name: "EventDashboard",
  components: { EventList },
  data() {
    return {
      version: "3.6.6"
    };
  },
  methods: {
    goTarget(href) {
      window.open(href, "_blank");
    }
  }
};
</script>

<style scoped>
.app-container {
  padding: 20px;
}

.update-log {
  margin-bottom: 20px;
}

.body {
  padding: 10px;
}

.clearfix {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style>