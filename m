Return-Path: <dmaengine+bounces-914-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEBF8432CB
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jan 2024 02:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241B31F27A1E
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jan 2024 01:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FEB610C;
	Wed, 31 Jan 2024 01:32:32 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B7C5673;
	Wed, 31 Jan 2024 01:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706664752; cv=none; b=Bet2j3G02vD6niwzPisE1jjm8RxDJ021OjL2YWHElwJ8QVQOFUrH5WnlMoZ4FusRRMVyZRlukgLqLzCWf7hgl8mWtuoMS7blDH/GWYR0K1Dn8mdkfk6El2wONTHNq9zD0zxO4VLLhK5oLr7P05zgcJB9So899P+BU5II20mxH0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706664752; c=relaxed/simple;
	bh=wXAG89Jg85kyQ0hkGzO4RqMCTStmhZosYYWzFuOJTP0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=lrS+60SX1oYd/WOPu4As3TXLOpTqR7KKLu6jymSX8sH3vS2QhBi70Sqma7mzQyRppk3+JvYJBbzZ3wE4hwHIDFsPGZMYts3IxxodVn+di7Wz3l/LM8JHFVhzwnZNZ+mi9B67r6JGTRSihzGXeLBkDTkAbHdK3H86jkLtscGJFjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TPkxg45cHz1Q8Jr;
	Wed, 31 Jan 2024 09:30:31 +0800 (CST)
Received: from kwepemd100004.china.huawei.com (unknown [7.221.188.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 0299E1A016C;
	Wed, 31 Jan 2024 09:32:22 +0800 (CST)
Received: from [10.67.121.175] (10.67.121.175) by
 kwepemd100004.china.huawei.com (7.221.188.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Wed, 31 Jan 2024 09:32:21 +0800
Message-ID: <665af2fb-5ac7-cfb6-0fc4-3dae816629b1@huawei.com>
Date: Wed, 31 Jan 2024 09:32:20 +0800
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
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100004.china.huawei.com (7.221.188.31)

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

