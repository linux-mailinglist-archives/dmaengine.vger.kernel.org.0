Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F2021352A
	for <lists+dmaengine@lfdr.de>; Fri,  3 Jul 2020 09:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgGCHhK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Jul 2020 03:37:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbgGCHhK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 3 Jul 2020 03:37:10 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 309E6206B6;
        Fri,  3 Jul 2020 07:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593761829;
        bh=1yqL2vPpVRdmj46GQEhej6JgtMfURcJom8VgYKkP6Vw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T2YhTkTZXBmEbVmczcUd0EmkoJbx3/h8OSrLros3IJrWKi5oBzDaKwoZDWbP88p7t
         mJ9bgILACRoz0w+08uunNB0P3qD83hkhGUnGBX6SLLD3mvmIJAMvNDuIiklDIBmwit
         fpSND3PKVISSwUUANeE8f28/JH9PvDH60wV/NQgM=
Date:   Fri, 3 Jul 2020 13:07:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v5 2/3] dmaengine: ptdma: register PTDMA controller as a
 DMA resource
Message-ID: <20200703073704.GK273932@vkoul-mobl>
References: <1592356288-42064-1-git-send-email-Sanju.Mehta@amd.com>
 <1592356288-42064-3-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592356288-42064-3-git-send-email-Sanju.Mehta@amd.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-06-20, 20:11, Sanjay R Mehta wrote:

> --- a/drivers/dma/ptdma/Makefile
> +++ b/drivers/dma/ptdma/Makefile
> @@ -5,6 +5,7 @@
>  
>  obj-$(CONFIG_AMD_PTDMA) += ptdma.o
>  
> -ptdma-objs := ptdma-dev.o
> +ptdma-objs := ptdma-dev.o \
> +	      ptdma-dmaengine.o

Single line?

> +static void pt_free_chan_resources(struct dma_chan *dma_chan)
> +{
> +	struct pt_dma_chan *chan = container_of(dma_chan, struct pt_dma_chan,
> +						 vc.chan);
> +
> +	dev_dbg(chan->pt->dev, "%s - chan=%p\n", __func__, chan);

drop the dbg artifacts here and other places in this and other patches

> +static void pt_do_cleanup(struct virt_dma_desc	*vd)
> +
> +{
> +	struct pt_dma_desc *desc = container_of(vd, struct pt_dma_desc, vd);
> +	struct pt_device *pt = desc->pt;
> +	struct pt_dma_chan *chan;
> +
> +	chan = container_of(desc->vd.tx.chan, struct pt_dma_chan,
> +			    vc.chan);

add a to_pt_chan() macro for this?

> +static int pt_issue_next_cmd(struct pt_dma_desc *desc)
> +{
> +	struct pt_passthru_engine *pt_engine;
> +	struct pt_dma_cmd *cmd;
> +	struct pt_device *pt;
> +	struct pt_cmd *pt_cmd;
> +	struct pt_cmd_queue *cmd_q;
> +
> +	cmd = list_first_entry(&desc->cmdlist, struct pt_dma_cmd, entry);
> +	desc->actv = 1;

active?

> +
> +	dev_dbg(desc->pt->dev, "%s - tx %d, cmd=%p\n", __func__,
> +		desc->vd.tx.cookie, cmd);
> +
> +	pt_cmd = &cmd->pt_cmd;
> +	pt = pt_cmd->pt;
> +	cmd_q = &pt->cmd_q;
> +	pt_engine = &pt_cmd->passthru;
> +
> +	if (!pt_engine->final)
> +		return -EINVAL;

what does final mean here?
> +
> +	if (!pt_engine->src_dma || !pt_engine->dst_dma)
> +		return -EINVAL;

what does this check do? we have a valid cmd which IIUC implies a valid
dma txn so why would one of this be invalid?

> +static struct pt_dma_desc *__pt_next_dma_desc(struct pt_dma_chan *chan)
> +{
> +	/* Get the next DMA descriptor on the active list */
> +	struct virt_dma_desc *vd = vchan_next_desc(&chan->vc);
> +
> +	if (list_empty(&chan->vc.desc_submitted))
> +		return NULL;
> +
> +	vd = list_empty(&chan->vc.desc_issued) ?
> +		  list_first_entry(&chan->vc.desc_submitted,
> +				   struct virt_dma_desc, node) : NULL;

Always remember there might already be a macro, so check. In this case
use of list_first_entry_or_null() looks apt

> +static struct pt_dma_desc *pt_handle_active_desc(struct pt_dma_chan *chan,
> +						 struct pt_dma_desc *desc)
> +{
> +	struct dma_async_tx_descriptor *tx_desc;
> +	struct virt_dma_desc *vd;
> +	unsigned long flags;
> +
> +	/* Loop over descriptors until one is found with commands */

This bit is strange, am not sure I follow. The fn name tell me it would
handle and active descriptor which is passed as an arg, so why do you
loop?

Can you explain this?

> +static void pt_issue_pending(struct dma_chan *dma_chan)
> +{
> +	struct pt_dma_chan *chan = container_of(dma_chan, struct pt_dma_chan,
> +						 vc.chan);
> +	struct pt_dma_desc *desc;
> +	unsigned long flags;
> +
> +	dev_dbg(chan->pt->dev, "%s\n", __func__);
> +
> +	spin_lock_irqsave(&chan->vc.lock, flags);
> +
> +	desc = __pt_next_dma_desc(chan);
> +
> +	spin_unlock_irqrestore(&chan->vc.lock, flags);
> +
> +	/* If there was nothing active, start processing */

What if channel is already active and doing a transaction? This should
check it first..

> +int pt_dmaengine_register(struct pt_device *pt)
> +{
> +	struct pt_dma_chan *chan;
> +	struct dma_device *dma_dev = &pt->dma_dev;
> +	struct dma_chan *dma_chan;
> +	char *dma_cmd_cache_name;
> +	char *dma_desc_cache_name;
> +	int ret;
> +
> +	pt->pt_dma_chan = devm_kcalloc(pt->dev, 1,
> +				       sizeof(*pt->pt_dma_chan),
> +				       GFP_KERNEL);

If n is 1, why you kcalloc, why not devm_kzalloc()?

> +	if (!pt->pt_dma_chan)
> +		return -ENOMEM;
> +
> +	dma_cmd_cache_name = devm_kasprintf(pt->dev, GFP_KERNEL,
> +					    "%s-dmaengine-cmd-cache",
> +					    pt->name);
> +	if (!dma_cmd_cache_name)
> +		return -ENOMEM;
> +
> +	pt->dma_cmd_cache = kmem_cache_create(dma_cmd_cache_name,
> +					      sizeof(struct pt_dma_cmd),
> +					      sizeof(void *),
> +					      SLAB_HWCACHE_ALIGN, NULL);
> +	if (!pt->dma_cmd_cache)
> +		return -ENOMEM;
> +
> +	dma_desc_cache_name = devm_kasprintf(pt->dev, GFP_KERNEL,
> +					     "%s-dmaengine-desc-cache",
> +					     pt->name);
> +	if (!dma_desc_cache_name) {
> +		ret = -ENOMEM;
> +		goto err_cache;
> +	}
> +
> +	pt->dma_desc_cache = kmem_cache_create(dma_desc_cache_name,
> +					       sizeof(struct pt_dma_desc),
> +					       sizeof(void *),
> +					       SLAB_HWCACHE_ALIGN, NULL);
> +	if (!pt->dma_desc_cache) {
> +		ret = -ENOMEM;
> +		goto err_cache;
> +	}
> +
> +	dma_dev->dev = pt->dev;
> +	dma_dev->src_addr_widths = PT_DMA_WIDTH(dma_get_mask(pt->dev));
> +	dma_dev->dst_addr_widths = PT_DMA_WIDTH(dma_get_mask(pt->dev));
> +	dma_dev->directions = DMA_MEM_TO_MEM;
> +	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
> +	dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
> +	dma_cap_set(DMA_INTERRUPT, dma_dev->cap_mask);
> +	dma_cap_set(DMA_PRIVATE, dma_dev->cap_mask);

Why DMA_PRIVATE if it supports only memcpy? Also have you tested this
with dmatest?

-- 
~Vinod
