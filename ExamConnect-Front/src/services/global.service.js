



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
        if(seconds<10 && minutes<10)
        return `${hours}:0${minutes}:0${seconds}`;
        else if(seconds<10)
        return `${hours}:${minutes}:0${seconds}`;
        else if(minutes<10)
        return `${hours}:0${minutes}:${seconds}`;
        else
        return `${hours}:${minutes}:${seconds}`;
    }
    getTimeWithoutSeconds(date1) {
        const date = new Date(date1);
        const hours = date.getHours();
        const minutes = date.getMinutes();
        if(minutes<10)
        return `${hours}:0${minutes}`;
        else
        return `${hours}:${minutes}`;
        
    }

    getDate(date1) {
        const date = new Date(date1);
        const year = date.getFullYear();
        const month = date.getMonth();
        const day = date.getDate();
        if(day<10 && month<10)
        return `0${day}-0${month}-${year}`;
        else if(day<10)
        return `0${day}-${month}-0${year}`;
        else if(month<10)
        return `${day}-0${month}-${year}`;
        else
        return `${day}-${month}-${year}`;
     }

    getfullDateTime(date1) {
        const date = new Date(date1);
        const year = date.getFullYear();
        const month = date.getMonth();
        const day = date.getDate();
        const hours = date.getHours();
        const minutes = date.getMinutes();
        const seconds = date.getSeconds();
        return `${day}-${month}-${year} ${hours}:${minutes}:${seconds}`;
        }



    




}

export default new GlobalService();