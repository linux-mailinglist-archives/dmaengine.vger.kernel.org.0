Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBFD7B7FA0
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 14:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242405AbjJDMrp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Oct 2023 08:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242467AbjJDMro (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Oct 2023 08:47:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B61C4;
        Wed,  4 Oct 2023 05:47:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C72C433C8;
        Wed,  4 Oct 2023 12:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696423659;
        bh=sf5GNc24RM8cZSAtHJyjlhg+f+gm+FWuukwdg3PutRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UdAvWUKGyFxGA1O+gR92eO9RezheI2GML6P/JDKJ1W+ePeoYL60/QAEgVsghyjbIO
         qailmD11hfY5Ab4zAm0FdIBH7vLy7SHR76/KgV2Px7YfaXA958y6Gct2c63aiEYdW5
         ou3waWvCeWYBkJv+uLh7jIV+vRai3BiC4bUUQLsvYvPgFFPognvB6wvKS2EePryryX
         dZJGX7Sc2T+aFWtzRIjQhZiwMXvjUTNWVADQEyXLNoR/5AiTgPDAS9PFESJYIPolcg
         4q9m0ialnoYP8Oz0WE3BY/0ZggFpep+B14oEbSr5R1CEVvqhSgm79LNGKwOaDCGXYb
         G6i9SndCUBAMA==
Date:   Wed, 4 Oct 2023 18:17:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        robh@kernel.org, mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 2/3] dmaengine: ae4dma: register AE4DMA controller as a
 DMA resource
Message-ID: <ZR1e5SrtVePDdL/K@matsya>
References: <1694460324-60346-1-git-send-email-Sanju.Mehta@amd.com>
 <1694460324-60346-3-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1694460324-60346-3-git-send-email-Sanju.Mehta@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-09-23, 14:25, Sanjay R Mehta wrote:
> From: Sanjay R Mehta <sanju.mehta@amd.com>
> 
> Register ae4dma queue's to Linux dmaengine framework as general-purpose
> DMA channels.
> 
> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> ---
>  drivers/dma/ae4dma/Kconfig            |   2 +
>  drivers/dma/ae4dma/Makefile           |   2 +-
>  drivers/dma/ae4dma/ae4dma-dev.c       |  17 ++
>  drivers/dma/ae4dma/ae4dma-dmaengine.c | 425 ++++++++++++++++++++++++++++++++++
>  drivers/dma/ae4dma/ae4dma.h           |  28 +++
>  5 files changed, 473 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/dma/ae4dma/ae4dma-dmaengine.c
> 
> diff --git a/drivers/dma/ae4dma/Kconfig b/drivers/dma/ae4dma/Kconfig
> index 1cda9de..3d1dbb7 100644
> --- a/drivers/dma/ae4dma/Kconfig
> +++ b/drivers/dma/ae4dma/Kconfig
> @@ -2,6 +2,8 @@
>  config AMD_AE4DMA
>  	tristate  "AMD AE4DMA Engine"
>  	depends on X86_64 && PCI
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
>  	help
>  	  Enabling this option provides support for the AMD AE4DMA controller,
>  	  which offers DMA capabilities for high-bandwidth memory-to-memory and
> diff --git a/drivers/dma/ae4dma/Makefile b/drivers/dma/ae4dma/Makefile
> index db9cab1..b1e4318 100644
> --- a/drivers/dma/ae4dma/Makefile
> +++ b/drivers/dma/ae4dma/Makefile
> @@ -5,6 +5,6 @@
>  
>  obj-$(CONFIG_AMD_AE4DMA) += ae4dma.o
>  
> -ae4dma-objs := ae4dma-dev.o
> +ae4dma-objs := ae4dma-dev.o ae4dma-dmaengine.o
>  
>  ae4dma-$(CONFIG_PCI) += ae4dma-pci.o
> diff --git a/drivers/dma/ae4dma/ae4dma-dev.c b/drivers/dma/ae4dma/ae4dma-dev.c
> index a3c50a2..af7e510 100644
> --- a/drivers/dma/ae4dma/ae4dma-dev.c
> +++ b/drivers/dma/ae4dma/ae4dma-dev.c
> @@ -25,6 +25,11 @@ static unsigned int max_hw_q = 1;
>  module_param(max_hw_q, uint, 0444);
>  MODULE_PARM_DESC(max_hw_q, "Max queues per engine (any non-zero value less than or equal to 16, default: 1)");
>  
> +static inline struct ae4_dma_chan *to_ae4_chan(struct dma_chan *dma_chan)
> +{
> +	return container_of(dma_chan, struct ae4_dma_chan, vc.chan);
> +}
> +
>  /* Human-readable error strings */
>  static char *ae4_error_codes[] = {
>  	"",
> @@ -273,8 +278,17 @@ int ae4_core_init(struct ae4_device *ae4)
>  		tasklet_setup(&cmd_q->irq_tasklet, ae4_do_cmd_complete);
>  	}
>  
> +	/* register to the DMA engine */
> +	ret = ae4_dmaengine_register(ae4);
> +	if (ret)
> +		goto e_free_irq;
> +
>  	return 0;
>  
> +e_free_irq:
> +	for (i = 0; i < ae4->cmd_q_count; i++)
> +		free_irq(ae4->ae4_irq[i], ae4);
> +
>  e_free_dma:
>  	dma_free_coherent(dev, cmd_q->qsize, cmd_q->qbase, cmd_q->qbase_dma);
>  
> @@ -292,6 +306,9 @@ void ae4_core_destroy(struct ae4_device *ae4)
>  	struct ae4_cmd *cmd;
>  	unsigned int i;
>  
> +	/* Unregister the DMA engine */
> +	ae4_dmaengine_unregister(ae4);
> +
>  	for (i = 0; i < ae4->cmd_q_count; i++) {
>  		cmd_q = &ae4->cmd_q[i];
>  
> diff --git a/drivers/dma/ae4dma/ae4dma-dmaengine.c b/drivers/dma/ae4dma/ae4dma-dmaengine.c
> new file mode 100644
> index 0000000..a50e4f5
> --- /dev/null
> +++ b/drivers/dma/ae4dma/ae4dma-dmaengine.c
> @@ -0,0 +1,425 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * AMD AE4DMA device driver
> + * -- Based on the PTDMA driver

How different is it from PTDMA, why cant this be incorporated in ptdma
driver

> + *
> + * Copyright (C) 2023 Advanced Micro Devices, Inc.
> + *
> + * Author: Sanjay R Mehta <sanju.mehta@amd.com>
> + */
> +#include <linux/delay.h>
> +#include "ae4dma.h"
> +#include "../dmaengine.h"
> +#include "../virt-dma.h"
> +
> +static inline struct ae4_dma_chan *to_ae4_chan(struct dma_chan *dma_chan)
> +{
> +	return container_of(dma_chan, struct ae4_dma_chan, vc.chan);
> +}
> +
> +static inline struct ae4_dma_desc *to_ae4_desc(struct virt_dma_desc *vd)
> +{
> +	return container_of(vd, struct ae4_dma_desc, vd);
> +}
> +
> +static void ae4_free_chan_resources(struct dma_chan *dma_chan)
> +{
> +	struct ae4_dma_chan *chan = to_ae4_chan(dma_chan);
> +
> +	vchan_free_chan_resources(&chan->vc);
> +}
> +
> +static void ae4_synchronize(struct dma_chan *dma_chan)
> +{
> +	struct ae4_dma_chan *chan = to_ae4_chan(dma_chan);
> +
> +	vchan_synchronize(&chan->vc);
> +}
> +
> +static void ae4_do_cleanup(struct virt_dma_desc *vd)
> +{
> +	struct ae4_dma_desc *desc = to_ae4_desc(vd);
> +	struct ae4_device *ae4 = desc->ae4;
> +
> +	kmem_cache_free(ae4->dma_desc_cache, desc);
> +}
> +
> +static int ae4_dma_start_desc(struct ae4_dma_desc *desc, struct ae4_dma_chan *chan)
> +{
> +	struct ae4_passthru_engine *ae4_engine;
> +	struct ae4_device *ae4;
> +	struct ae4_cmd *ae4_cmd;
> +	struct ae4_cmd_queue *cmd_q;
> +
> +	desc->issued_to_hw = 1;
> +	list_del(&desc->vd.node);
> +
> +	ae4_cmd = &desc->ae4_cmd;
> +	ae4 = ae4_cmd->ae4;
> +	cmd_q = chan->cmd_q;
> +	ae4_engine = &ae4_cmd->passthru;
> +
> +	ae4_cmd->qid = cmd_q->qidx;
> +	cmd_q->tdata.cmd = ae4_cmd;
> +
> +	/* Execute the command */
> +	ae4_cmd->ret = ae4_core_perform_passthru(cmd_q, ae4_engine);
> +
> +	return 0;
> +}
> +
> +static struct ae4_dma_desc *ae4_next_dma_desc(struct ae4_dma_chan *chan)
> +{
> +	/* Get the next DMA descriptor on the active list */
> +	struct virt_dma_desc *vd = vchan_next_desc(&chan->vc);
> +
> +	return vd ? to_ae4_desc(vd) : NULL;
> +}
> +
> +static void ae4_cmd_callback_tasklet(void *data, int err)
> +{
> +	struct ae4_dma_desc *desc = data;
> +	struct dma_chan *dma_chan;
> +	struct ae4_dma_chan *chan;
> +	struct dma_async_tx_descriptor *tx_desc;
> +	struct virt_dma_desc *vd;
> +	unsigned long flags;
> +
> +	dma_chan = desc->vd.tx.chan;
> +	chan = to_ae4_chan(dma_chan);
> +
> +	if (err == -EINPROGRESS)
> +		return;
> +
> +	tx_desc = &desc->vd.tx;
> +	vd = &desc->vd;
> +
> +	if (err)
> +		desc->status = DMA_ERROR;
> +
> +	spin_lock_irqsave(&chan->vc.lock, flags);
> +	if (desc) {
> +		if (desc->status != DMA_COMPLETE) {
> +			if (desc->status != DMA_ERROR)
> +				desc->status = DMA_COMPLETE;

So a DMA_IN_PROGRESS descriptor would be marked complete?

> +
> +			dma_cookie_complete(tx_desc);
> +			dma_descriptor_unmap(tx_desc);
> +		} else {
> +			/* Don't handle it twice */
> +			tx_desc = NULL;
> +		}
> +	}
> +	spin_unlock_irqrestore(&chan->vc.lock, flags);
> +
> +	if (tx_desc) {
> +		dmaengine_desc_get_callback_invoke(tx_desc, NULL);
> +		dma_run_dependencies(tx_desc);
> +	}
> +}
> +
> +static struct ae4_dma_desc *ae4_handle_active_desc(struct ae4_dma_chan *chan,
> +						   struct ae4_dma_desc *desc)
> +{
> +	struct dma_async_tx_descriptor *tx_desc;
> +	struct virt_dma_desc *vd;
> +	unsigned long flags;
> +
> +	/* Loop over descriptors until one is found with commands */
> +	do {
> +		if (desc) {
> +			if (!desc->issued_to_hw) {
> +				/* No errors, keep going */
> +				if (desc->status != DMA_ERROR)
> +					return desc;
> +			}
> +			tx_desc = &desc->vd.tx;
> +			vd = &desc->vd;
> +		} else {
> +			tx_desc = NULL;
> +		}
> +		spin_lock_irqsave(&chan->vc.lock, flags);
> +		desc = ae4_next_dma_desc(chan);
> +		spin_unlock_irqrestore(&chan->vc.lock, flags);
> +	} while (desc);
> +
> +	return NULL;
> +}
> +
> +static void ae4_cmd_callback(void *data, int err)
> +{
> +	struct ae4_dma_desc *desc = data;
> +	struct dma_chan *dma_chan;
> +	struct ae4_dma_chan *chan;
> +	struct ae4_device *ae4;
> +	int ret;
> +
> +	if (err == -EINPROGRESS)
> +		return;
> +
> +	dma_chan = desc->vd.tx.chan;
> +	chan = to_ae4_chan(dma_chan);
> +	ae4 = chan->ae4;
> +
> +	if (err)
> +		desc->status = DMA_ERROR;
> +
> +	while (true) {
> +		/* Check for DMA descriptor completion */
> +		desc = ae4_handle_active_desc(chan, desc);
> +
> +		/* Don't submit cmd if no descriptor or DMA is paused */
> +		if (!desc)
> +			break;
> +
> +		/* if queue is full dont submit to queue */
> +		if (ae4_core_queue_full(ae4, chan->cmd_q)) {
> +			usleep_range(100, 200);
> +			continue;
> +		}
> +
> +		ret = ae4_dma_start_desc(desc, chan);
> +		if (!ret)
> +			break;
> +
> +		desc->status = DMA_ERROR;
> +	}
> +}
> +
> +static struct ae4_dma_desc *ae4_alloc_dma_desc(struct ae4_dma_chan *chan, unsigned long flags)
> +{
> +	struct ae4_dma_desc *desc;
> +	struct ae4_cmd_queue *cmd_q = chan->cmd_q;
> +
> +	desc = kmem_cache_zalloc(chan->ae4->dma_desc_cache, GFP_NOWAIT);
> +	if (!desc)
> +		return NULL;
> +
> +	vchan_tx_prep(&chan->vc, &desc->vd, flags);
> +
> +	desc->ae4 = chan->ae4;
> +	cmd_q->int_en = !!(flags & DMA_PREP_INTERRUPT);
> +	desc->issued_to_hw = 0;
> +	desc->status = DMA_IN_PROGRESS;
> +
> +	return desc;
> +}
> +
> +static struct ae4_dma_desc *ae4_create_desc(struct dma_chan *dma_chan,
> +					    dma_addr_t dst,
> +					    dma_addr_t src,
> +					    unsigned int len,
> +					    unsigned long flags)
> +{
> +	struct ae4_dma_chan *chan = to_ae4_chan(dma_chan);
> +	struct ae4_cmd_queue *cmd_q = chan->cmd_q;
> +	struct ae4_passthru_engine *ae4_engine;
> +	struct ae4_dma_desc *desc;
> +	struct ae4_cmd *ae4_cmd;
> +
> +	desc = ae4_alloc_dma_desc(chan, flags);
> +	if (!desc)
> +		return NULL;
> +
> +	ae4_cmd = &desc->ae4_cmd;
> +	ae4_cmd->ae4 = chan->ae4;
> +	ae4_engine = &ae4_cmd->passthru;
> +	ae4_cmd->engine = AE4_ENGINE_PASSTHRU;
> +	ae4_engine->src_dma = src;
> +	ae4_engine->dst_dma = dst;
> +	ae4_engine->src_len = len;
> +	ae4_cmd->ae4_cmd_callback = ae4_cmd_callback_tasklet;
> +	ae4_cmd->data = desc;
> +
> +	desc->len = len;
> +
> +	spin_lock_irqsave(&cmd_q->cmd_lock, flags);
> +	list_add_tail(&ae4_cmd->entry, &cmd_q->cmd);
> +	spin_unlock_irqrestore(&cmd_q->cmd_lock, flags);
> +
> +	return desc;
> +}
> +
> +static struct dma_async_tx_descriptor *
> +ae4_prep_dma_memcpy(struct dma_chan *dma_chan, dma_addr_t dst,
> +		    dma_addr_t src, size_t len, unsigned long flags)
> +{
> +	struct ae4_dma_desc *desc;
> +
> +	desc = ae4_create_desc(dma_chan, dst, src, len, flags);
> +	if (!desc)
> +		return NULL;

I dont see any logic in splitting these into two!

> +
> +	return &desc->vd.tx;
> +}
> +
> +static struct dma_async_tx_descriptor *
> +ae4_prep_dma_interrupt(struct dma_chan *dma_chan, unsigned long flags)
> +{
> +	struct ae4_dma_chan *chan = to_ae4_chan(dma_chan);
> +	struct ae4_dma_desc *desc;
> +
> +	desc = ae4_alloc_dma_desc(chan, flags);
> +	if (!desc)
> +		return NULL;
> +
> +	return &desc->vd.tx;
> +}
> +
> +static void ae4_issue_pending(struct dma_chan *dma_chan)
> +{
> +	struct ae4_dma_chan *chan = to_ae4_chan(dma_chan);
> +	struct ae4_dma_desc *desc;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&chan->vc.lock, flags);
> +	vchan_issue_pending(&chan->vc);
> +	desc = ae4_next_dma_desc(chan);
> +	spin_unlock_irqrestore(&chan->vc.lock, flags);
> +
> +	ae4_cmd_callback(desc, 0);
> +}
> +
> +static int ae4_pause(struct dma_chan *dma_chan)
> +{
> +	struct ae4_dma_chan *chan = to_ae4_chan(dma_chan);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&chan->vc.lock, flags);
> +	//TODO : implemnt pause

typo implemnt and drop this and add when you add support!
No dummy code please


> +	spin_unlock_irqrestore(&chan->vc.lock, flags);
> +
> +	return 0;
> +}
> +
> +static int ae4_resume(struct dma_chan *dma_chan)
> +{
> +	struct ae4_dma_chan *chan = to_ae4_chan(dma_chan);
> +	struct ae4_dma_desc *desc = NULL;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&chan->vc.lock, flags);
> +	ae4_start_queue(chan->cmd_q);
> +	desc = ae4_next_dma_desc(chan);
> +	spin_unlock_irqrestore(&chan->vc.lock, flags);
> +
> +	/* If there was something active, re-start */
> +	if (desc)
> +		ae4_cmd_callback(desc, 0);

resume when no pause is supported..??
-- 
~Vinod
