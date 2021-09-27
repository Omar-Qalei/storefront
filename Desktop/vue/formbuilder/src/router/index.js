import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'
import httpClient from '../services/configurations/axios.config';

function guard(to, from, next) {
  // if (localStorage.getItem('LoggedUser'))
  //   isAuthenticated = true;
  // else
  //   isAuthenticated = false;
  if (localStorage.getItem('user')) {
    const data = JSON.parse(localStorage.getItem('user'));
    const token = `Bearer ${data.access_token}`;
    httpClient.interceptors.request.use(req => {
      req.headers.authorization = token
      return req;
    });
    next();
  } else {
    if (from.path !== '/login')
      next('/login'); // go to '/login';
  }
}

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home,
    beforeEnter: guard,
  },
  {
    path: '/preview',
    name: 'Preview',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "preview" */ '../views/Preview.vue'),
    beforeEnter: guard,
  },
  {
    path: '/formBuilder',
    name: 'FormBuilder',
    component: () => import(/* webpackChunkName: "formBuilder" */ '../views/FormBuilder.vue'),
    beforeEnter: guard,
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import(/* webpackChunkName: "login" */ '../views/authentication/Login.vue')
  },
  {
    path: '/register',
    name: 'Register',
    component: () => import(/* webpackChunkName: "register" */ '../views/authentication/Register.vue'),
  },
  {
    path: '/marketing/compose',
    name: 'Compose',
    component: () => import(/* webpackChunkName: "compose" */ '../views/marketing/components/compose/Compose.vue'),
  },
  // {
  //   path: '/marketing/campaigns',
  //   name: 'Campaigns',
  //   component: () => import(/* webpackChunkName: "campaigns" */ '../views/marketing/components/campaigns/Campaigns.vue'),
  // },
  // {
  //   path: '/marketing/mail-lists',
  //   name: 'MailingLists',
  //   component: () => import(/* webpackChunkName: "mail-lists" */ '../views/marketing/components/mailing-lists/MailingLists.vue'),
  // },
  // {
  //   path: '/marketing/senders',
  //   name: 'Senders',
  //   component: () => import(/* webpackChunkName: "senders" */ '../views/marketing/components/senders/Senders.vue'),
  // },
]

const router = new VueRouter({
  mode: 'history',
  hash: false,
  routes
})

export default router
