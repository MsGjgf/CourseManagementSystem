import axios from "axios"

/**
 * 此文件中可修改在发送前请求头中的一些Infomation
 */
let http = axios.create({
    baseURL:'http://localhost:9000',
    timeout:5000
})

http.interceptors.request.use(
    config=>{
        config.headers.token = sessionStorage.getItem('token')
        return config
    },
    error=>{
        return Promise.reject(error)
    }
)

export default http