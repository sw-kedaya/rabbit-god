import {getActivityList} from '@/apis/activity'
import {ref, onMounted} from "vue";

export function getActivityVal(){

    const activityList = ref([])
    const getActivity = async () => {
        const res = await getActivityList()
        activityList.value = res.data;
    }

    onMounted(()=> getActivity())

    return {
        activityList
    }
}
