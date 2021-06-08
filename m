Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E79E3A03DF
	for <lists+dmaengine@lfdr.de>; Tue,  8 Jun 2021 21:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbhFHTWW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Jun 2021 15:22:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238801AbhFHTUG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 8 Jun 2021 15:20:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F2E26108E;
        Tue,  8 Jun 2021 18:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623178600;
        bh=UvBrc/sDGCOjUp74mJfP8xJ6BdpUE/I+lMYBd9oQwnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=khVOw5siKCz3bJ7RxEaHWrVyLbnoTddnQEWV2JncUIAgRwjShdIod63jJBWk3N3Xy
         L9buy6KDKYgK5F0TUd7oKyDOFILdEZBj8h+gEasNHZXLg4GfjMkYUpm5dDHCivw1y4
         +CDER2aIZd5MLmivYR4N2hUGhUh9uNRitC+uwZ1K0rx9bKG71wYtA4gms1bTXT4nfX
         EHlhQIMTOFLigR88od/a1ejK/RX7rvjbCVj8r+aUqJ94LCOFOdmLLVU6im7AD9KaRY
         Kyle3oj0S8dxm+Edbzb1TY6yxCHwbW7ecGGcz3WY0vmb2OraCfvGVDVpTRNR3OLk8/
         l7vWyMwcKcfbg==
Date:   Wed, 9 Jun 2021 00:26:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v9 2/3] dmaengine: ptdma: register PTDMA controller as a
 DMA resource
Message-ID: <YL+9Y8U8XQ2FSV8Q@vkoul-mobl>
References: <1622654551-9204-1-git-send-email-Sanju.Mehta@amd.com>
 <1622654551-9204-3-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622654551-9204-3-git-send-email-Sanju.Mehta@amd.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02-06-21, 12:22, Sanjay R Mehta wrote:

> +static void pt_do_cmd_complete(unsigned long data)
> +{
> +	struct pt_tasklet_data *tdata = (struct pt_tasklet_data *)data;
> +	struct pt_cmd *cmd = tdata->cmd;
> +	struct pt_cmd_queue *cmd_q = &cmd->pt->cmd_q;
> +	u32 tail;
> +
> +	tail = lower_32_bits(cmd_q->qdma_tail + cmd_q->qidx * Q_DESC_SIZE);

why extract tail in non error case?

> +static int pt_issue_next_cmd(struct pt_dma_desc *desc)
> +{
> +	struct pt_passthru_engine *pt_engine;
> +	struct pt_dma_cmd *cmd;
> +	struct pt_device *pt;
> +	struct pt_cmd *pt_cmd;
> +	struct pt_cmd_queue *cmd_q;
> +
> +	cmd = list_first_entry(&desc->cmdlist, struct pt_dma_cmd, entry);
> +	desc->issued_to_hw = 1;

Why do you need this, the descriptor should be in vc.desc_issued list

> +static void pt_free_active_cmd(struct pt_dma_desc *desc)
> +{
> +	struct pt_dma_cmd *cmd = NULL;
> +
> +	if (desc->issued_to_hw)
> +		cmd = list_first_entry_or_null(&desc->cmdlist, struct pt_dma_cmd,
> +					       entry);

single line pls and use lists provided..


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

single line again

> +static struct pt_dma_desc *pt_alloc_dma_desc(struct pt_dma_chan *chan,
> +					     unsigned long flags)
> +{
> +	struct pt_dma_desc *desc;
> +
> +	desc = kmem_cache_zalloc(chan->pt->dma_desc_cache, GFP_NOWAIT);
> +	if (!desc)
> +		return NULL;
> +
> +	vchan_tx_prep(&chan->vc, &desc->vd, flags);
> +
> +	desc->pt = chan->pt;
> +	desc->issued_to_hw = 0;
> +	INIT_LIST_HEAD(&desc->cmdlist);

why do you need your own list, the lists in vc should suffice?

> +static int pt_resume(struct dma_chan *dma_chan)
> +{
> +	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
> +	struct pt_dma_desc *desc = NULL;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&chan->vc.lock, flags);
> +	pt_start_queue(&chan->pt->cmd_q);
> +	desc = __pt_next_dma_desc(chan);
> +	spin_unlock_irqrestore(&chan->vc.lock, flags);
> +
> +	/* If there was something active, re-start */
> +	if (desc)
> +		pt_cmd_callback(desc, 0);

this doesn't sound correct. In pause yoy stop the queue, so start of the
queue should be done here... Why grab a descriptor?

> +static int pt_terminate_all(struct dma_chan *dma_chan)
> +{
> +	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
> +
> +	vchan_free_chan_resources(&chan->vc);

what about the descriptors, are you not going to clear the lists and
free them..

> +int pt_dmaengine_register(struct pt_device *pt)
> +{
> +	struct pt_dma_chan *chan;
> +	struct dma_device *dma_dev = &pt->dma_dev;
> +	char *cmd_cache_name;
> +	char *desc_cache_name;
> +	int ret;
> +
> +	pt->pt_dma_chan = devm_kzalloc(pt->dev, sizeof(*pt->pt_dma_chan),
> +				       GFP_KERNEL);
> +	if (!pt->pt_dma_chan)
> +		return -ENOMEM;
> +
> +	cmd_cache_name = devm_kasprintf(pt->dev, GFP_KERNEL,
> +					"%s-dmaengine-cmd-cache",
> +					pt->name);
> +	if (!cmd_cache_name)
> +		return -ENOMEM;
> +
> +	pt->dma_cmd_cache = kmem_cache_create(cmd_cache_name,
> +					      sizeof(struct pt_dma_cmd),
> +					      sizeof(void *),
> +					      SLAB_HWCACHE_ALIGN, NULL);
> +	if (!pt->dma_cmd_cache)
> +		return -ENOMEM;
> +
> +	desc_cache_name = devm_kasprintf(pt->dev, GFP_KERNEL,
> +					 "%s-dmaengine-desc-cache",
> +					 pt->name);
> +	if (!desc_cache_name) {
> +		ret = -ENOMEM;
> +		goto err_cache;
> +	}
> +
> +	pt->dma_desc_cache = kmem_cache_create(desc_cache_name,
> +					       sizeof(struct pt_dma_desc),
> +					       sizeof(void *),

sizeof void ptr?

> +					       SLAB_HWCACHE_ALIGN, NULL);
> +	if (!pt->dma_desc_cache) {
> +		ret = -ENOMEM;
> +		goto err_cache;
> +	}
> +
> +	dma_dev->dev = pt->dev;
> +	dma_dev->src_addr_widths = DMA_SLAVE_BUSWIDTH_64_BYTES;
> +	dma_dev->dst_addr_widths = DMA_SLAVE_BUSWIDTH_64_BYTES;
> +	dma_dev->directions = DMA_MEM_TO_MEM;
> +	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
> +	dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
> +	dma_cap_set(DMA_INTERRUPT, dma_dev->cap_mask);
> +	dma_cap_set(DMA_PRIVATE, dma_dev->cap_mask);

Why DMA_PRIVATE ? this is a dma mempcy controller ...
-- 
~Vinod
