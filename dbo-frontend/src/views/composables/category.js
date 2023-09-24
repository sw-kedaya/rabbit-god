import {getCategoryHead} from '@/apis/layout'
import {ref, onMounted} from "vue";

export function getCategoryHeadList(){

    const categoryList = ref([])
    const getCategory = async () => {
        const res = await getCategoryHead()
        categoryList.value = res.data;
    }

    onMounted(()=> getCategory())

    return {
        categoryList
    }
}
