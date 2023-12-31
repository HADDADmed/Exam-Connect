/*
 * Main and demo navigation arrays
 *
 * 'to' attribute points to the route name, not the path url
 */
export default {
  main: [
     {
      name: "",
      heading: true,
    },
    {
      name: "Dashboard",
      to: "examconnect-dashboard",
      icon: "si si-speedometer",
    }, 
    {
      name: "",
      heading: true,
    },{
      name: "",
      heading: true,
    },
    {
      name: "Exams",
      subActivePaths: "/examconnect/exams",
      icon: "si si-graduation",
      sub: [
        {
          name: "Exams",
          to: "examconnect-exams-list",
          icon: "si si-list",
        },{
          name: "Create Exam",
          to: "examconnect-exams-create",
          icon: "si si-plus",
        },
      ],
    } ,
    {
      name: "Questions",
      subActivePaths: "/examconnect/questions",
      icon: "si si-question",
      sub: [
        {
          name: "Questions",
          to: "examconnect-questions-list",
          icon: "si si-list",
        },{
          name: "Create Question",
          to: "examconnect-questions-create",
          icon: "si si-plus",
        },
      ],
    }
    ,{
      name: "Users",
      subActivePaths: "/examconnect/users",
      icon: "si si-users",
      sub: [
        {
          name: "Users",
          to: "examconnect-users-list",
          icon: "si si-list",
        },{
          name: "Create User",
          to: "examconnect-users-create",
          icon: "si si-plus",
        },
      ],
    },
    {
      name: "",
      heading: true,
    }, {
      name: "",
      heading: true,
    }, 
    {
      name: "Logout",
      to: "examconnect-authentication",
      icon: "si si-logout",
    },
    {
      name: "",
      heading: true,
    },{
      name: "",
      heading: true,
    },
  ]
};
