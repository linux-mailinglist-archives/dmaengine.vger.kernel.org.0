Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4072B7D82
	for <lists+dmaengine@lfdr.de>; Wed, 18 Nov 2020 13:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgKRMQ7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Nov 2020 07:16:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:45448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgKRMQ7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 18 Nov 2020 07:16:59 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 418D7221FB;
        Wed, 18 Nov 2020 12:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605701818;
        bh=ola7n5nX5CHdtJD585pVIPK8oj/5oYTPEX6sBD4mJzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tz4DkDkQmMFNtVtyx2ZzVyqRK9Ee3IVzDVlIQpbZ+st5pzp9qspWdKPjOKG4Etoky
         GQruj0FonlSINaK906aFAiW5kZXByMAwf0vWnbnMSHczWCuhta/k1M1+Mbw2HhpH7b
         uQY9uKqlz8b05pdlb8L0oqX7tD3ZOMHOtXjyGptE=
Date:   Wed, 18 Nov 2020 17:46:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v7 2/3] dmaengine: ptdma: register PTDMA controller as a
 DMA resource
Message-ID: <20201118121623.GR50232@vkoul-mobl>
References: <1602833947-82021-1-git-send-email-Sanju.Mehta@amd.com>
 <1602833947-82021-3-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602833947-82021-3-git-send-email-Sanju.Mehta@amd.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-10-20, 02:39, Sanjay R Mehta wrote:

> diff --git a/drivers/dma/ptdma/ptdma-dmaengine.c b/drivers/dma/ptdma/ptdma-dmaengine.c
> new file mode 100644
> index 0000000..9b9b77c
> --- /dev/null
> +++ b/drivers/dma/ptdma/ptdma-dmaengine.c
> @@ -0,0 +1,554 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * AMD Passthrough DMA device driver
> + * -- Based on the CCP driver
> + *
> + * Copyright (C) 2016,2020 Advanced Micro Devices, Inc.
> + *
> + * Author: Sanjay R Mehta <sanju.mehta@amd.com>
> + * Author: Gary R Hook <gary.hook@amd.com>
> + */
> +
> +#include "ptdma.h"
> +#include "../dmaengine.h"
> +#include "../virt-dma.h"
> +
> +#define PT_DMA_WIDTH(_mask)		\
> +({					\
> +	u64 mask = (_mask) + 1;		\
> +	(mask == 0) ? 64 : fls64(mask);	\

how would mask be 0 here..?

> +static struct pt_dma_desc *pt_handle_active_desc(struct pt_dma_chan *chan,
> +						 struct pt_dma_desc *desc)
> +{
> +	struct dma_async_tx_descriptor *tx_desc;
> +	struct virt_dma_desc *vd;
> +	unsigned long flags;
> +
> +	/* Loop over descriptors until one is found with commands */
> +	do {
> +		if (desc) {
> +			/* Remove the DMA command from the list and free it */
> +			pt_free_active_cmd(desc);
> +			if (!desc->issued_to_hw) {
> +				/* No errors, keep going */
> +				if (desc->status != DMA_ERROR)
> +					return desc;
> +				/* Error, free remaining commands and move on */
> +				pt_free_cmd_resources(desc->pt,
> +						      &desc->cmdlist);

this should be single line

> +			}
> +
> +			tx_desc = &desc->vd.tx;
> +			vd = &desc->vd;
> +		} else {
> +			tx_desc = NULL;
> +		}
> +
> +		spin_lock_irqsave(&chan->vc.lock, flags);
> +
> +		if (desc) {
> +			if (desc->status != DMA_ERROR)
> +				desc->status = DMA_COMPLETE;
> +
> +			dma_cookie_complete(tx_desc);
> +			dma_descriptor_unmap(tx_desc);
> +			list_del(&desc->vd.node);
> +		}
> +
> +		desc = pt_next_dma_desc(chan);
> +
> +		spin_unlock_irqrestore(&chan->vc.lock, flags);
> +
> +		if (tx_desc) {
> +			dmaengine_desc_get_callback_invoke(tx_desc, NULL);
> +			dma_run_dependencies(tx_desc);
> +			vchan_vdesc_fini(vd);
> +		}
> +	} while (desc);

So IIUC, this has two functions, one to find active desc and second to
complete and invoke callback. These two are different tasks and I am not
sure why these are handled here. Can you split these up into different
routines, that may help making this read better

> +static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
> +					  struct scatterlist *dst_sg,
> +					  unsigned int dst_nents,
> +					  struct scatterlist *src_sg,
> +					  unsigned int src_nents,
> +					  unsigned long flags)
> +{
> +	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
> +	struct pt_device *pt = chan->pt;
> +	struct pt_dma_desc *desc;
> +	struct pt_dma_cmd *cmd;
> +	struct pt_cmd *pt_cmd;
> +	struct pt_passthru_engine *pt_engine;
> +	unsigned int src_offset, src_len;
> +	unsigned int dst_offset, dst_len;
> +	unsigned int len;
> +	size_t total_len;
> +
> +	if (!dst_sg || !src_sg)
> +		return NULL;
> +
> +	if (!dst_nents || !src_nents)
> +		return NULL;
> +
> +	desc = pt_alloc_dma_desc(chan, flags);
> +	if (!desc)
> +		return NULL;
> +
> +	total_len = 0;
> +
> +	src_len = sg_dma_len(src_sg);
> +	src_offset = 0;
> +
> +	dst_len = sg_dma_len(dst_sg);
> +	dst_offset = 0;
> +
> +	while (true) {
> +		if (!src_len) {
> +			src_nents--;
> +			if (!src_nents)
> +				break;
> +
> +			src_sg = sg_next(src_sg);
> +			if (!src_sg)
> +				break;
> +
> +			src_len = sg_dma_len(src_sg);
> +			src_offset = 0;
> +			continue;
> +		}
> +
> +		if (!dst_len) {
> +			dst_nents--;
> +			if (!dst_nents)
> +				break;
> +
> +			dst_sg = sg_next(dst_sg);
> +			if (!dst_sg)
> +				break;
> +
> +			dst_len = sg_dma_len(dst_sg);
> +			dst_offset = 0;
> +			continue;
> +		}
> +
> +		len = min(dst_len, src_len);

Ah why not use for_each_sg()
> +
> +		cmd = pt_alloc_dma_cmd(chan);
> +		if (!cmd)
> +			goto err;
> +
> +		pt_cmd = &cmd->pt_cmd;
> +		pt_cmd->pt = chan->pt;
> +		pt_engine = &pt_cmd->passthru;
> +		pt_cmd->engine = PT_ENGINE_PASSTHRU;
> +		pt_engine->src_dma = sg_dma_address(src_sg) + src_offset;
> +		pt_engine->dst_dma = sg_dma_address(dst_sg) + dst_offset;
> +		pt_engine->src_len = len;
> +		pt_cmd->pt_cmd_callback = pt_cmd_callback;
> +		pt_cmd->data = desc;
> +
> +		list_add_tail(&cmd->entry, &desc->cmdlist);
> +
> +		total_len += len;
> +
> +		src_len -= len;
> +		src_offset += len;
> +
> +		dst_len -= len;
> +		dst_offset += len;
> +	}

since you have both src and dst sgl that needs to be checked as well,
but where are the two lists coming from..? something does not sound
right here

> +static struct dma_async_tx_descriptor *
> +pt_prep_dma_memcpy(struct dma_chan *dma_chan, dma_addr_t dst,
> +		   dma_addr_t src, size_t len, unsigned long flags)
> +{
> +	struct scatterlist dst_sg, src_sg;
> +	struct pt_dma_desc *desc;
> +
> +	sg_init_table(&dst_sg, 1);
> +	sg_dma_address(&dst_sg) = dst;
> +	sg_dma_len(&dst_sg) = len;
> +
> +	sg_init_table(&src_sg, 1);
> +	sg_dma_address(&src_sg) = src;
> +	sg_dma_len(&src_sg) = len;

Why do you need this overhead, why not pass on the addresses here?

So you create sg list here and then unravel that for description
creation. Typically we would have a lower level API which would handle
dma_addr_t and that can be called from here and sgl users!


> +static enum dma_status pt_tx_status(struct dma_chan *dma_chan,
> +				    dma_cookie_t cookie,
> +				    struct dma_tx_state *state)
> +{
> +	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
> +	struct pt_dma_desc *desc;
> +	enum dma_status ret;
> +	unsigned long flags;
> +	struct virt_dma_desc *vd;
> +
> +	ret = dma_cookie_status(dma_chan, cookie, state);
> +	if (ret == DMA_COMPLETE)
> +		return ret;
> +
> +	spin_lock_irqsave(&chan->vc.lock, flags);
> +	vd = vchan_find_desc(&chan->vc, cookie);
> +	desc = vd ? to_pt_desc(vd) : NULL;
> +	ret = desc->status;
> +	spin_unlock_irqrestore(&chan->vc.lock, flags);

how does this block of code help?

> +int pt_dmaengine_register(struct pt_device *pt)
> +{
> +	struct pt_dma_chan *chan;
> +	struct dma_device *dma_dev = &pt->dma_dev;
> +	char *dma_cmd_cache_name;
> +	char *dma_desc_cache_name;
> +	int ret;
> +
> +	pt->pt_dma_chan = devm_kzalloc(pt->dev, sizeof(*pt->pt_dma_chan),
> +				       GFP_KERNEL);
> +	if (!pt->pt_dma_chan)
> +		return -ENOMEM;
> +
> +	dma_cmd_cache_name = devm_kasprintf(pt->dev, GFP_KERNEL,

maybe user shorter variable names

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

Why DMA_PRIVATE for a memcpy function?
-- 
~Vinod
