<template>
  <div class="manage">
    <h1>基于SpringBoot课程管理系统
      <el-button @click="exit" type="info" style="position: absolute; right: 20px;">退出</el-button>
    </h1>
    <nav>
      <router-link to="/student">学生管理</router-link>
      <router-link to="/course">课程管理</router-link>
      <router-link to="/score">成绩管理</router-link>
    </nav>
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name:'Manage',
  methods:{
    exit(){
      sessionStorage.clear()
      this.$router.push('/login')
      this.$message({
        type:'success',
        message:'我已出仓，感觉良好>_<'
      })
    }
  }
}
</script>

<style scoped>
  .manage{
    text-align: center;
    padding: 20px;
  }
  nav{
    font-size: 30px;
    margin: 10px;
  }
  nav *{
    text-decoration: none;
    color: skyblue;
  }
  nav *:hover{
    background-color: skyblue;
    color: white;
  }
</style>
