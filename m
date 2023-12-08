Return-Path: <dmaengine+bounces-408-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E37EF8098CC
	for <lists+dmaengine@lfdr.de>; Fri,  8 Dec 2023 02:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2044B1C20BF9
	for <lists+dmaengine@lfdr.de>; Fri,  8 Dec 2023 01:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A90B1863;
	Fri,  8 Dec 2023 01:53:02 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3461719;
	Thu,  7 Dec 2023 17:52:57 -0800 (PST)
Received: from kwepemd100004.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SmYzK5hDPzWhMl;
	Fri,  8 Dec 2023 09:51:57 +0800 (CST)
Received: from [10.67.121.175] (10.67.121.175) by
 kwepemd100004.china.huawei.com (7.221.188.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Fri, 8 Dec 2023 09:52:54 +0800
Message-ID: <c6fb5131-7549-bdbc-6a8d-d2733632a474@huawei.com>
Date: Fri, 8 Dec 2023 09:52:53 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] dmaengine: virt-dma : fix vchan error on multi-thread
From: Jie Hai <haijie1@huawei.com>
To: <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230720114212.51224-1-haijie1@huawei.com>
In-Reply-To: <20230720114212.51224-1-haijie1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100004.china.huawei.com (7.221.188.31)
X-CFilter-Loop: Reflected

Hi, Vkoul,

Kindly ping...

Thanks,
Jie Hai
On 2023/7/20 19:42, Jie Hai wrote:
> List desc_allocated was introduced for the case of a transfer
> submitted multiple times. But elegating descriptors on the list
> causes other problems.
> 
> For example, in the multi-thread scenario, which tasks are
> continuously created and submitted by each thread. If one of
> the threads calls dmaengine_terminate_all, for dirvers using
> vchan_get_all_descriptors, all descriptors will be freed. If
> there's another thread submitting a transfer A by
> vchan_tx_submit, the following results may be generated:
> 1. desc A is freeing -> visit wrong address of node prep/next.
> 2. desc A is freed -> visit invalid address of A.
> 
> In the above case, calltrace is generated and the system is
> suspended. This can be tested by dmatest.
> 
> This patch removes desc_allocated from vchan_get_all_descriptors,
> and add new function 'vchan_get_all_allocated_descs' to get all
> descriptors ever allocated.
> 
> And apply vchan_get_all_allocated_descs to free chan resource and
> vchan_get_all_descriptors to terminate all transfers, respectively.
> This avoids freeing up descriptors in use by other threads.
> 
> Signed-off-by: Jie Hai <haijie1@huawei.com>
> ---
>   drivers/dma/fsl-edma-common.c |  2 +-
>   drivers/dma/fsl-qdma.c        |  2 +-
>   drivers/dma/sf-pdma/sf-pdma.c |  2 +-
>   drivers/dma/virt-dma.h        | 20 ++++++++++++++++++--
>   4 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index a06a1575a2a5..c6d2e54ab85d 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -674,7 +674,7 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
>   	if (edma->drvdata->dmamuxs)
>   		fsl_edma_chan_mux(fsl_chan, 0, false);
>   	fsl_chan->edesc = NULL;
> -	vchan_get_all_descriptors(&fsl_chan->vchan, &head);
> +	vchan_get_all_allocated_descs(&fsl_chan->vchan, &head);
>   	fsl_edma_unprep_slave_dma(fsl_chan);
>   	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
>   
> diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
> index eddb2688f234..5ffd7ba92058 100644
> --- a/drivers/dma/fsl-qdma.c
> +++ b/drivers/dma/fsl-qdma.c
> @@ -311,7 +311,7 @@ static void fsl_qdma_free_chan_resources(struct dma_chan *chan)
>   	LIST_HEAD(head);
>   
>   	spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
> -	vchan_get_all_descriptors(&fsl_chan->vchan, &head);
> +	vchan_get_all_allocated_descs(&fsl_chan->vchan, &head);
>   	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
>   
>   	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
> diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
> index d1c6956af452..f35dc68e1a7c 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.c
> +++ b/drivers/dma/sf-pdma/sf-pdma.c
> @@ -144,7 +144,7 @@ static void sf_pdma_free_chan_resources(struct dma_chan *dchan)
>   	sf_pdma_disable_request(chan);
>   	kfree(chan->desc);
>   	chan->desc = NULL;
> -	vchan_get_all_descriptors(&chan->vchan, &head);
> +	vchan_get_all_allocated_descs(&chan->vchan, &head);
>   	sf_pdma_disclaim_chan(chan);
>   	spin_unlock_irqrestore(&chan->vchan.lock, flags);
>   	vchan_dma_desc_free_list(&chan->vchan, &head);
> diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
> index e9f5250fbe4d..65b4f3bdecf7 100644
> --- a/drivers/dma/virt-dma.h
> +++ b/drivers/dma/virt-dma.h
> @@ -177,13 +177,29 @@ static inline struct virt_dma_desc *vchan_next_desc(struct virt_dma_chan *vc)
>   static inline void vchan_get_all_descriptors(struct virt_dma_chan *vc,
>   	struct list_head *head)
>   {
> -	list_splice_tail_init(&vc->desc_allocated, head);
>   	list_splice_tail_init(&vc->desc_submitted, head);
>   	list_splice_tail_init(&vc->desc_issued, head);
>   	list_splice_tail_init(&vc->desc_completed, head);
>   	list_splice_tail_init(&vc->desc_terminated, head);
>   }
>   
> +/**
> + * vchan_get_all_allocated_descs - obtain all descriptors
> + * @vc: virtual channel to get descriptors from
> + * @head: list of descriptors found
> + *
> + * vc.lock must be held by caller
> + *
> + * Removes all descriptors from internal lists, and provides a list of all
> + * descriptors found
> + */
> +static inline void vchan_get_all_allocated_descs(struct virt_dma_chan *vc,
> +	struct list_head *head)
> +{
> +	list_splice_tail_init(&vc->desc_allocated, head);
> +	vchan_get_all_descriptors(vc, head);
> +}
> +
>   static inline void vchan_free_chan_resources(struct virt_dma_chan *vc)
>   {
>   	struct virt_dma_desc *vd;
> @@ -191,7 +207,7 @@ static inline void vchan_free_chan_resources(struct virt_dma_chan *vc)
>   	LIST_HEAD(head);
>   
>   	spin_lock_irqsave(&vc->lock, flags);
> -	vchan_get_all_descriptors(vc, &head);
> +	vchan_get_all_allocated_descs(vc, &head);
>   	list_for_each_entry(vd, &head, node)
>   		dmaengine_desc_clear_reuse(&vd->tx);
>   	spin_unlock_irqrestore(&vc->lock, flags);

