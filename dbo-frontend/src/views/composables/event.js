import {getEventList} from '@/apis/event'
import {ref, onMounted} from "vue";

export function getEventVal(){

    const eventList = ref([])
    const getEvent = async () => {
        const res = await getEventList()
        eventList.value = res.data;
    }

    onMounted(()=> getEvent())

    return {
        eventList
    }
}
