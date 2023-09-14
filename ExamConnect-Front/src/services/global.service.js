



class GlobalService {
     
    getCurrentTime() {
        return new Date().toLocaleTimeString();
    }

    // formate Date 
    getTime(date1) {
        const date = new Date(date1);
        const hours = date.getHours();
        const minutes = date.getMinutes();
        const seconds = date.getSeconds();
        return `${hours}:${minutes}:${seconds}`;


    }
    getTimeWithoutSeconds(date1) {
        const date = new Date(date1);
        const hours = date.getHours();
        const minutes = date.getMinutes();
        return `${hours}:${minutes}`;
    }

    getDate(date1) {
        const date = new Date(date1);
        const year = date.getFullYear();
        const month = date.getMonth();
        const day = date.getDate();
        return `${year}-${month}-${day}`;
    }

    getfullDateTime(date1) {
        const date = new Date(date1);
        const year = date.getFullYear();
        const month = date.getMonth();
        const day = date.getDate();
        const hours = date.getHours();
        const minutes = date.getMinutes();
        const seconds = date.getSeconds();
        return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
    }



    




}

export default new GlobalService();