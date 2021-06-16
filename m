Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E0D3A9062
	for <lists+dmaengine@lfdr.de>; Wed, 16 Jun 2021 06:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbhFPEUR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Jun 2021 00:20:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229483AbhFPEUQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 16 Jun 2021 00:20:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5075760D07;
        Wed, 16 Jun 2021 04:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623817091;
        bh=wx5OF9P0wEkYHJBr/LkUb7fNP/o5Ys1nWtAh5Cfb/IA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pJ8+an+quymvOjm5lyrGBlV8nOt+drqB1osiYOiMFFpnJqRb2b5RQSJutiFV4jSUl
         I77hUYUPfB4ic+xCu5FLyjgfkBFIBarhBvFHOfYHUGdkzGdoOVYKBnX4mIZf4AFDQu
         El6XWRnnN6UIcMc1eHyUYgjQPfDbdYn5ZG+m0URxo5LtjSWHmcgNkCEqu0GPAmXpks
         3Gjf5nmIW2sQG2iIgepoPZQWxyDd1urvqBxCSzTxojVixY9NHUUGAhCvN2kThWpwO+
         EbJ4enof1dSr1ODzuWgSd2C+Jr1QgZGWwamDHjROwGs4bGtQDsOUwU0Ob8L+H1FRhx
         UvDR07K1vubDA==
Date:   Wed, 16 Jun 2021 09:48:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sanjay R Mehta <sanmehta@amd.com>
Cc:     Sanjay R Mehta <Sanju.Mehta@amd.com>, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, Thomas.Lendacky@amd.com,
        Shyam-sundar.S-k@amd.com, Nehal-bakulchandra.Shah@amd.com,
        robh@kernel.org, mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v9 2/3] dmaengine: ptdma: register PTDMA controller as a
 DMA resource
Message-ID: <YMl7f/nNRMUgFDyq@vkoul-mobl>
References: <1622654551-9204-1-git-send-email-Sanju.Mehta@amd.com>
 <1622654551-9204-3-git-send-email-Sanju.Mehta@amd.com>
 <YL+9Y8U8XQ2FSV8Q@vkoul-mobl>
 <311d14a1-39f4-1aad-bce0-a64fee52d13b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <311d14a1-39f4-1aad-bce0-a64fee52d13b@amd.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-06-21, 17:04, Sanjay R Mehta wrote:
> 
> 
> On 6/9/2021 12:26 AM, Vinod Koul wrote:
> 
> [snipped]
> 
> >> +static struct pt_dma_desc *pt_alloc_dma_desc(struct pt_dma_chan *chan,
> >> +                                          unsigned long flags)
> >> +{
> >> +     struct pt_dma_desc *desc;
> >> +
> >> +     desc = kmem_cache_zalloc(chan->pt->dma_desc_cache, GFP_NOWAIT);
> >> +     if (!desc)
> >> +             return NULL;
> >> +
> >> +     vchan_tx_prep(&chan->vc, &desc->vd, flags);
> >> +
> >> +     desc->pt = chan->pt;
> >> +     desc->issued_to_hw = 0;
> >> +     INIT_LIST_HEAD(&desc->cmdlist);
> > 
> > why do you need your own list, the lists in vc should suffice?
> > 
> 
> Do you think this should be a major blocker for pulling this series in 5.14?
> Would you be okay to accept this change in the subsequent driver updates?

Sorry that is not how upstream works, I would like things to be better
before we merge this

> 
> >> +static int pt_resume(struct dma_chan *dma_chan)
> >> +{
> >> +     struct pt_dma_chan *chan = to_pt_chan(dma_chan);
> >> +     struct pt_dma_desc *desc = NULL;
> >> +     unsigned long flags;
> >> +
> >> +     spin_lock_irqsave(&chan->vc.lock, flags);
> >> +     pt_start_queue(&chan->pt->cmd_q);
> >> +     desc = __pt_next_dma_desc(chan);
> >> +     spin_unlock_irqrestore(&chan->vc.lock, flags);
> >> +
> >> +     /* If there was something active, re-start */
> >> +     if (desc)
> >> +             pt_cmd_callback(desc, 0);
> > 
> > this doesn't sound correct. In pause yoy stop the queue, so start of the
> > queue should be done here... Why grab a descriptor?
> > 
> >> +static int pt_terminate_all(struct dma_chan *dma_chan)
> >> +{
> >> +     struct pt_dma_chan *chan = to_pt_chan(dma_chan);
> >> +
> >> +     vchan_free_chan_resources(&chan->vc);
> > 
> > what about the descriptors, are you not going to clear the lists and
> > free them..
> > 
> >> +int pt_dmaengine_register(struct pt_device *pt)
> >> +{
> >> +     struct pt_dma_chan *chan;
> >> +     struct dma_device *dma_dev = &pt->dma_dev;
> >> +     char *cmd_cache_name;
> >> +     char *desc_cache_name;
> >> +     int ret;
> >> +
> >> +     pt->pt_dma_chan = devm_kzalloc(pt->dev, sizeof(*pt->pt_dma_chan),
> >> +                                    GFP_KERNEL);
> >> +     if (!pt->pt_dma_chan)
> >> +             return -ENOMEM;
> >> +
> >> +     cmd_cache_name = devm_kasprintf(pt->dev, GFP_KERNEL,
> >> +                                     "%s-dmaengine-cmd-cache",
> >> +                                     pt->name);
> >> +     if (!cmd_cache_name)
> >> +             return -ENOMEM;
> >> +
> >> +     pt->dma_cmd_cache = kmem_cache_create(cmd_cache_name,
> >> +                                           sizeof(struct pt_dma_cmd),
> >> +                                           sizeof(void *),
> >> +                                           SLAB_HWCACHE_ALIGN, NULL);
> >> +     if (!pt->dma_cmd_cache)
> >> +             return -ENOMEM;
> >> +
> >> +     desc_cache_name = devm_kasprintf(pt->dev, GFP_KERNEL,
> >> +                                      "%s-dmaengine-desc-cache",
> >> +                                      pt->name);
> >> +     if (!desc_cache_name) {
> >> +             ret = -ENOMEM;
> >> +             goto err_cache;
> >> +     }
> >> +
> >> +     pt->dma_desc_cache = kmem_cache_create(desc_cache_name,
> >> +                                            sizeof(struct pt_dma_desc),
> >> +                                            sizeof(void *),
> > 
> > sizeof void ptr?

This and many more comments are left not replied, do you agree to them,
do you disagree, hard to tell from silence..

> > 
> >> +                                            SLAB_HWCACHE_ALIGN, NULL);
> >> +     if (!pt->dma_desc_cache) {
> >> +             ret = -ENOMEM;
> >> +             goto err_cache;
> >> +     }
> >> +
> >> +     dma_dev->dev = pt->dev;
> >> +     dma_dev->src_addr_widths = DMA_SLAVE_BUSWIDTH_64_BYTES;
> >> +     dma_dev->dst_addr_widths = DMA_SLAVE_BUSWIDTH_64_BYTES;
> >> +     dma_dev->directions = DMA_MEM_TO_MEM;
> >> +     dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
> >> +     dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
> >> +     dma_cap_set(DMA_INTERRUPT, dma_dev->cap_mask);
> >> +     dma_cap_set(DMA_PRIVATE, dma_dev->cap_mask);
> > 
> > Why DMA_PRIVATE ? this is a dma mempcy controller ...
> 
> This DMA controller is intended to be used with AMD Non-Transparent
> Bridge devices and not for general purpose peripheral DMA. Hence marking
> it as DMA_PRIVATE.

Okay, maybe add a comment so that people would know

-- 
~Vinod
