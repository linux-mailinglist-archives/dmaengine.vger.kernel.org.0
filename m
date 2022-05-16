Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E069E528B80
	for <lists+dmaengine@lfdr.de>; Mon, 16 May 2022 19:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbiEPRCx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 May 2022 13:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiEPRCv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 May 2022 13:02:51 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132D91FA64
        for <dmaengine@vger.kernel.org>; Mon, 16 May 2022 10:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652720571; x=1684256571;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=7ryH+nbKNneIzUKgszusREAGHwed7n2oBq4OG9TapOM=;
  b=I7wk4MWQc3oOgucyTP5+CUx/sBeZ5rQfvQYCgxbou+kbZm9FXrkG8SQI
   vTfFITHIXZZs1YoABZPgriJnAFsmNTsIEPtOfjcM7PMYGdb2h33Er+6Gg
   HjZZHWVsNoFojcj6Q/qf5b12VqLNPgQwgL8MqlKVHSi8z369OiTNfifCJ
   Xhq14WdPEF2lzuxMIdPBz/89VH9Lf4/+i3x9g+awtKJebIjI48Uh9LnhS
   nu6MpwMJzr4kpJK8Us2HVIs9DoqLpJx9SmHtPOoG9zKcy0DKprc0PfoH5
   uE5iKUl11hFXc/uUJJefCfoCjNp/4NtlQ5AtklfLi4ijfdrNt5O+QU19e
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="296167342"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="296167342"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 10:02:08 -0700
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="626031463"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.19.181]) ([10.212.19.181])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 10:02:02 -0700
Message-ID: <8da7b5af-4536-6c9e-378a-e4313a6171f9@intel.com>
Date:   Mon, 16 May 2022 10:02:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.0
Subject: Re: [PATCH] dmaengine: idxd: add missing callback function to support
 DMA_INTERRUPT
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
References: <165101232637.3951447.15765792791591763119.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <165101232637.3951447.15765792791591763119.stgit@djiang5-desk3.ch.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 4/26/2022 3:32 PM, Dave Jiang wrote:
> When setting DMA_INTERRUPT capability, a callback function
> dma->device_prep_dma_interrupt() is needed to support this capability.
> Without setting the callback, dma_async_device_register() will fail dma
> capability check.
>
> Fixes: 4e5a4eb20393 ("dmaengine: idxd: set DMA_INTERRUPT cap bit")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>


Hi Vinod, can you please make sure this patch goes into the merge 
window? It fixes the patch that's in the dmaengine/next. Thanks!

> ---
>   drivers/dma/idxd/dma.c |   22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
>
> diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
> index 950f06c8aad5..d66cef5a918e 100644
> --- a/drivers/dma/idxd/dma.c
> +++ b/drivers/dma/idxd/dma.c
> @@ -87,6 +87,27 @@ static inline void idxd_prep_desc_common(struct idxd_wq *wq,
>   	hw->completion_addr = compl;
>   }
>   
> +static struct dma_async_tx_descriptor *
> +idxd_dma_prep_interrupt(struct dma_chan *c, unsigned long flags)
> +{
> +	struct idxd_wq *wq = to_idxd_wq(c);
> +	u32 desc_flags;
> +	struct idxd_desc *desc;
> +
> +	if (wq->state != IDXD_WQ_ENABLED)
> +		return NULL;
> +
> +	op_flag_setup(flags, &desc_flags);
> +	desc = idxd_alloc_desc(wq, IDXD_OP_BLOCK);
> +	if (IS_ERR(desc))
> +		return NULL;
> +
> +	idxd_prep_desc_common(wq, desc->hw, DSA_OPCODE_NOOP,
> +			      0, 0, 0, desc->compl_dma, desc_flags);
> +	desc->txd.flags = flags;
> +	return &desc->txd;
> +}
> +
>   static struct dma_async_tx_descriptor *
>   idxd_dma_submit_memcpy(struct dma_chan *c, dma_addr_t dma_dest,
>   		       dma_addr_t dma_src, size_t len, unsigned long flags)
> @@ -198,6 +219,7 @@ int idxd_register_dma_device(struct idxd_device *idxd)
>   	dma_cap_set(DMA_COMPLETION_NO_ORDER, dma->cap_mask);
>   	dma->device_release = idxd_dma_release;
>   
> +	dma->device_prep_dma_interrupt = idxd_dma_prep_interrupt;
>   	if (idxd->hw.opcap.bits[0] & IDXD_OPCAP_MEMMOVE) {
>   		dma_cap_set(DMA_MEMCPY, dma->cap_mask);
>   		dma->device_prep_dma_memcpy = idxd_dma_submit_memcpy;
>
>
