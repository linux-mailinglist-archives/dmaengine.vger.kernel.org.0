Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE661C327B
	for <lists+dmaengine@lfdr.de>; Mon,  4 May 2020 08:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgEDGOx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 May 2020 02:14:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbgEDGOw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 4 May 2020 02:14:52 -0400
Received: from localhost (unknown [171.76.84.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AF73206B9;
        Mon,  4 May 2020 06:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588572892;
        bh=N0yq5ahXgMtgtu91eiz8HXvEkM1smExwUQNbeJhVm90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=znPn/xmRZBsl9Cqux5lgOg2EXM8P3iOA/D6w5D6hv/aEEJ90kAs2PreaLAjsVcJCo
         NhlwZCpIr90Z1zHF5LGKeqzvFgtoAN/8C8afMW7WrJdN+4VCPQVtWkRkhcnPyeCkMw
         KBRPvwQXAOvoveIhm3b5Je5SAQQyTxQdw1AAwT4E=
Date:   Mon, 4 May 2020 11:44:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dmaengine: ptdma: register PTDMA controller as a
 DMA resource
Message-ID: <20200504061445.GK1375924@vkoul-mobl>
References: <1588108416-49050-1-git-send-email-Sanju.Mehta@amd.com>
 <1588108416-49050-3-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588108416-49050-3-git-send-email-Sanju.Mehta@amd.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-04-20, 16:13, Sanjay R Mehta wrote:

> +static void pt_do_cmd_complete(unsigned long data)
> +{
> +	struct pt_tasklet_data *tdata = (struct pt_tasklet_data *)data;
> +	struct pt_cmd *cmd = tdata->cmd;
> +	struct pt_cmd_queue *cmd_q = &cmd->pt->cmd_q;
> +	u32 tail;
> +
> +	tail = lower_32_bits(cmd_q->qdma_tail + cmd_q->qidx * Q_DESC_SIZE);
> +	if (cmd_q->cmd_error) {
> +	       /*
> +		* Log the error and flush the queue by
> +		* moving the head pointer
> +		*/
> +		pt_log_error(cmd_q->pt, cmd_q->cmd_error);
> +		iowrite32(tail, cmd_q->reg_head_lo);
> +	}
> +
> +	cmd->pt_cmd_callback(cmd->data, cmd->ret);

So in the isr you schedule this tasklet and this invokes the calback..
this is very inefficient.

You should submit the next txn to dmaengine in your isr, keeping the dma
idle at this point is very inefficient.

> +static void pt_cmd_callback(void *data, int err)
> +{
> +	struct pt_dma_desc *desc = data;
> +	struct pt_dma_chan *chan;
> +	int ret;

This is called as callback from pt layer..
> +
> +	if (err == -EINPROGRESS)
> +		return;
> +
> +	chan = container_of(desc->vd.tx.chan, struct pt_dma_chan,
> +			    vc.chan);
> +
> +	dev_dbg(chan->pt->dev, "%s - tx %d callback, err=%d\n",
> +		__func__, desc->vd.tx.cookie, err);
> +
> +	if (err)
> +		desc->status = DMA_ERROR;
> +
> +	while (true) {
> +		/* Check for DMA descriptor completion */
> +		desc = pt_handle_active_desc(chan, desc);
> +
> +		/* Don't submit cmd if no descriptor or DMA is paused */
> +		if (!desc || chan->status == DMA_PAUSED)
> +			break;
> +
> +		ret = pt_issue_next_cmd(desc);

And you call this to issue next cmd... The missing thing I am seeing
here is vchan_cookie_complete() you need to call that here for correct
vchan list mgmt

> +static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
> +					  struct scatterlist *dst_sg,
> +					    unsigned int dst_nents,
> +					    struct scatterlist *src_sg,
> +					    unsigned int src_nents,
> +					    unsigned long flags)

unaligned add indentation! Pls run checkpatch --strict to check for
these oddities

> +	dma_dev->dev = pt->dev;
> +	dma_dev->src_addr_widths = PT_DMA_WIDTH(dma_get_mask(pt->dev));
> +	dma_dev->dst_addr_widths = PT_DMA_WIDTH(dma_get_mask(pt->dev));
> +	dma_dev->directions = DMA_MEM_TO_MEM;
> +	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
> +	dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
> +	dma_cap_set(DMA_INTERRUPT, dma_dev->cap_mask);
> +	dma_cap_set(DMA_PRIVATE, dma_dev->cap_mask);
> +
> +	INIT_LIST_HEAD(&dma_dev->channels);
> +
> +	chan = pt->pt_dma_chan;
> +	chan->pt = pt;
> +	dma_chan = &chan->vc.chan;
> +
> +	dma_dev->device_free_chan_resources = pt_free_chan_resources;
> +	dma_dev->device_prep_dma_memcpy = pt_prep_dma_memcpy;
> +	dma_dev->device_prep_dma_interrupt = pt_prep_dma_interrupt;
> +	dma_dev->device_issue_pending = pt_issue_pending;
> +	dma_dev->device_tx_status = pt_tx_status;
> +	dma_dev->device_pause = pt_pause;
> +	dma_dev->device_resume = pt_resume;
> +	dma_dev->device_terminate_all = pt_terminate_all;

Pls implement .device_synchronize as well

> +struct pt_dma_desc {
> +	struct virt_dma_desc vd;
> +
> +	struct pt_device *pt;
> +
> +	struct list_head pending;
> +	struct list_head active;

why not use vc->desc_submitted, desc_issued instead!

> +
> +	enum dma_status status;
> +
> +	size_t len;
> +};
> +
> +struct pt_dma_chan {
> +	struct virt_dma_chan vc;
> +
> +	struct pt_device *pt;
> +
> +	enum dma_status status;

channel status as well as desc, why do you need both?
-- 
~Vinod
