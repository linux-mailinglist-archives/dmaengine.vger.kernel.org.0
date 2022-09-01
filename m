Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5A25A9DF1
	for <lists+dmaengine@lfdr.de>; Thu,  1 Sep 2022 19:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbiIARYR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Sep 2022 13:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiIARYQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 1 Sep 2022 13:24:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58F15A174;
        Thu,  1 Sep 2022 10:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662053055; x=1693589055;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=E8rFsh3cOY6TR7v1pVGIy4bcSAYXEqYJdeSl8HkWbzs=;
  b=MaOl98FUSw0hEb3jtBozOS1jfe62pdGnYqW4S07aGdaboozrf4SB08Q6
   pMaDlhrNIZxc0HCIBKvnOtN2TIicl8vpUaaiUA4p2Z8XOO7ZQefENu9+Q
   I95zN3U+iHyKOfaSgBIV7Di10v9OS+LQHH84OLauzVai5TcSZNEz2TGIS
   1Xdq0EkpJc9xNlzn3AWEIasCseFDVCxoQukbvjp5PU6gpi6lWWXDMcYTh
   Bp5IYBeTnIPRbcW3NXboJ6YoGAEyHIvnsSy29fC20PkePFbPceroQJqyW
   Z4AoQm9TAOkar6tPZZy8z5FXB9VfGlX0qsBdvo3xhKyK78KEukrCpkwD1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="382075432"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="382075432"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 10:24:15 -0700
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="612589501"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.209.165.86]) ([10.209.165.86])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 10:24:14 -0700
Message-ID: <2450a184-3a97-f45e-b56a-b5e0ae85df19@intel.com>
Date:   Thu, 1 Sep 2022 10:24:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH v5 6/7] dmaengine: idxd: Support device_tx_status
To:     Ben Walker <benjamin.walker@intel.com>, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>
References: <20220622193753.3044206-1-benjamin.walker@intel.com>
 <20220829203537.30676-1-benjamin.walker@intel.com>
 <20220829203537.30676-7-benjamin.walker@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220829203537.30676-7-benjamin.walker@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 8/29/2022 1:35 PM, Ben Walker wrote:
> This can now be supported even for devices that complete operations out
> of order. Add support for directly polling transactions.
>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Ben Walker <benjamin.walker@intel.com>
> ---
>   drivers/dma/idxd/device.c |  1 +
>   drivers/dma/idxd/dma.c    | 85 ++++++++++++++++++++++++++++++++++++++-
>   drivers/dma/idxd/idxd.h   |  1 +
>   3 files changed, 85 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 5a8cc52c1abfd..752544bef4551 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -148,6 +148,7 @@ int idxd_wq_alloc_resources(struct idxd_wq *wq)
>   			desc->iax_completion = &wq->iax_compls[i];
>   		desc->compl_dma = wq->compls_addr + idxd->data->compl_size * i;
>   		desc->id = i;
> +		desc->gen = 1;
>   		desc->wq = wq;
>   		desc->cpu = -1;
>   	}
> diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
> index e0874cb4721c8..dda5342d273f4 100644
> --- a/drivers/dma/idxd/dma.c
> +++ b/drivers/dma/idxd/dma.c
> @@ -12,6 +12,23 @@
>   #include "registers.h"
>   #include "idxd.h"
>   
> +
> +#define DMA_COOKIE_BITS (sizeof(dma_cookie_t) * 8)
> +/*
> + * The descriptor id takes the lower 16 bits of the cookie.
> + */
> +#define DESC_ID_BITS 16
> +#define DESC_ID_MASK ((1 << DESC_ID_BITS) - 1)
> +/*
> + * The 'generation' is in the upper half of the cookie. But dma_cookie_t
> + * is signed, so we leave the upper-most bit for the sign. Further, we
> + * need to flag whether a cookie corresponds to an operation that is
> + * being completed via interrupt to avoid polling it, which takes
> + * the second most upper bit. So we subtract two bits from the upper half.
> + */
> +#define DESC_GEN_MAX ((1 << (DMA_COOKIE_BITS - DESC_ID_BITS - 2)) - 1)
> +#define DESC_INTERRUPT_FLAG (1 << (DMA_COOKIE_BITS - 2))
> +
>   static inline struct idxd_wq *to_idxd_wq(struct dma_chan *c)
>   {
>   	struct idxd_dma_chan *idxd_chan;
> @@ -158,13 +175,67 @@ static void idxd_dma_free_chan_resources(struct dma_chan *chan)
>   		idxd_wq_refcount(wq));
>   }
>   
> +

Stray blank line

DJ

>   static enum dma_status idxd_dma_tx_status(struct dma_chan *dma_chan,
>   					  dma_cookie_t cookie,
>   					  struct dma_tx_state *txstate)
>   {
> -	return DMA_OUT_OF_ORDER;
> +	u8 status;
> +	struct idxd_wq *wq;
> +	struct idxd_desc *desc;
> +	u32 idx;
> +
> +	memset(txstate, 0, sizeof(*txstate));
> +
> +	if (dma_submit_error(cookie))
> +		return DMA_ERROR;
> +
> +	wq = to_idxd_wq(dma_chan);
> +
> +	idx = cookie & DESC_ID_MASK;
> +	if (idx >= wq->num_descs)
> +		return DMA_ERROR;
> +
> +	desc = wq->descs[idx];
> +
> +	if (desc->txd.cookie != cookie) {
> +		/*
> +		 * The user asked about an old transaction
> +		 */
> +		return DMA_COMPLETE;
> +	}
> +
> +	/*
> +	 * For descriptors completed via interrupt, we can't go
> +	 * look at the completion status directly because it races
> +	 * with the IRQ handler recyling the descriptor. However,
> +	 * since in this case we can rely on the interrupt handler
> +	 * to invalidate the cookie when the command completes we
> +	 * know that if we get here, the command is still in
> +	 * progress.
> +	 */
> +	if ((cookie & DESC_INTERRUPT_FLAG) != 0)
> +		return DMA_IN_PROGRESS;
> +
> +	status = desc->completion->status & DSA_COMP_STATUS_MASK;
> +
> +	if (status) {
> +		/*
> +		 * Check against the original status as ABORT is software defined
> +		 * and 0xff, which DSA_COMP_STATUS_MASK can mask out.
> +		 */
> +		if (unlikely(desc->completion->status == IDXD_COMP_DESC_ABORT))
> +			idxd_dma_complete_txd(desc, IDXD_COMPLETE_ABORT, true);
> +		else
> +			idxd_dma_complete_txd(desc, IDXD_COMPLETE_NORMAL, true);
> +
> +		return DMA_COMPLETE;
> +	}
> +
> +	return DMA_IN_PROGRESS;
>   }
>   
> +
>   /*
>    * issue_pending() does not need to do anything since tx_submit() does the job
>    * already.
> @@ -181,7 +252,17 @@ static dma_cookie_t idxd_dma_tx_submit(struct dma_async_tx_descriptor *tx)
>   	int rc;
>   	struct idxd_desc *desc = container_of(tx, struct idxd_desc, txd);
>   
> -	cookie = dma_cookie_assign(tx);
> +	cookie = (desc->gen << DESC_ID_BITS) | (desc->id & DESC_ID_MASK);
> +
> +	if ((desc->hw->flags & IDXD_OP_FLAG_RCI) != 0)
> +		cookie |= DESC_INTERRUPT_FLAG;
> +
> +	if (desc->gen == DESC_GEN_MAX)
> +		desc->gen = 1;
> +	else
> +		desc->gen++;
> +
> +	tx->cookie = cookie;
>   
>   	rc = idxd_submit_desc(wq, desc);
>   	if (rc < 0) {
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index bd93ada32c89d..d4f0227895075 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -326,6 +326,7 @@ struct idxd_desc {
>   	struct llist_node llnode;
>   	struct list_head list;
>   	u16 id;
> +	u16 gen;
>   	int cpu;
>   	struct idxd_wq *wq;
>   };
