Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4668220A97
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2020 12:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgGOK7L (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jul 2020 06:59:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbgGOK7L (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Jul 2020 06:59:11 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC5E7206E9;
        Wed, 15 Jul 2020 10:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594810750;
        bh=gQDuwnfiYL4Tg4MTPc2Nx5XzK8KZyztd78Q4IrCdP/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QO6BK+yNqXYbJVg/T/fX7N7KuNMRhxntihPKqWhuwZKwgso2s0Wb8RkgJVyCDpZ+v
         paBdUjj76KIFN8x/POZ5H7K1STLSBUTzYXMBMSW5GowjNYLNi91Y+kFEx4AyCs+1ej
         tBff+Y2zkMMmnD7k78Fiu8Od/lt+I1p79qzSuwbY=
Date:   Wed, 15 Jul 2020 16:29:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dmaengine@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v6 4/6] dmaengine: xilinx: dpdma: Add the Xilinx
 DisplayPort DMA engine driver
Message-ID: <20200715105906.GI34333@vkoul-mobl>
References: <20200708201906.4546-1-laurent.pinchart@ideasonboard.com>
 <20200708201906.4546-5-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708201906.4546-5-laurent.pinchart@ideasonboard.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 08-07-20, 23:19, Laurent Pinchart wrote:

> +static struct dma_async_tx_descriptor *
> +xilinx_dpdma_prep_interleaved_dma(struct dma_chan *dchan,
> +				  struct dma_interleaved_template *xt,
> +				  unsigned long flags)
> +{
> +	struct xilinx_dpdma_chan *chan = to_xilinx_chan(dchan);
> +	struct xilinx_dpdma_tx_desc *desc;
> +
> +	if (xt->dir != DMA_MEM_TO_DEV)
> +		return NULL;
> +
> +	if (!xt->numf || !xt->sgl[0].size)
> +		return NULL;
> +
> +	if (!(flags & DMA_PREP_REPEAT))
> +		return NULL;

is the hw be not capable of supporting single interleave txn?

Also as replied the comment to Peter, we should check chan->running here
and see that DMA_PREP_LOAD_EOT is set. There can still be a case where
descriptor is submitted but not issued causing you to miss, but i guess
that might be overkill for your scenarios

> +static int xilinx_dpdma_config(struct dma_chan *dchan,
> +			       struct dma_slave_config *config)
> +{
> +	struct xilinx_dpdma_chan *chan = to_xilinx_chan(dchan);
> +	unsigned long flags;
> +
> +	/*
> +	 * The destination address doesn't need to be specified as the DPDMA is
> +	 * hardwired to the destination (the DP controller). The transfer
> +	 * width, burst size and port window size are thus meaningless, they're
> +	 * fixed both on the DPDMA side and on the DP controller side.
> +	 */

But we are not doing peripheral transfers, this is memory to memory
(interleave) here right?

> +
> +	spin_lock_irqsave(&chan->lock, flags);
> +
> +	/*
> +	 * Abuse the slave_id to indicate that the channel is part of a video
> +	 * group.
> +	 */
> +	if (chan->id >= ZYNQMP_DPDMA_VIDEO0 && chan->id <= ZYNQMP_DPDMA_VIDEO2)
> +		chan->video_group = config->slave_id != 0;

Okay looking closely here, the video_group is used to tie different
channels together to ensure sync operation is that right? And this seems
to be only reason for DMA_SLAVE capabilities, i don't think I saw slave
ops

> +static int xilinx_dpdma_terminate_all(struct dma_chan *dchan)
> +{
> +	struct xilinx_dpdma_chan *chan = to_xilinx_chan(dchan);
> +	struct xilinx_dpdma_device *xdev = chan->xdev;
> +	LIST_HEAD(descriptors);
> +	unsigned long flags;
> +	unsigned int i;
> +
> +	/* Pause the channel (including the whole video group if applicable). */
> +	if (chan->video_group) {
> +		for (i = ZYNQMP_DPDMA_VIDEO0; i <= ZYNQMP_DPDMA_VIDEO2; i++) {
> +			if (xdev->chan[i]->video_group &&
> +			    xdev->chan[i]->running) {
> +				xilinx_dpdma_chan_pause(xdev->chan[i]);

so there is no terminate here, only pause?
-- 
~Vinod
