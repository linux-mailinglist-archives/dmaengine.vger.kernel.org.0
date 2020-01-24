Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2B0147872
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2020 07:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbgAXGFh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Jan 2020 01:05:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:59104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbgAXGFh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 24 Jan 2020 01:05:37 -0500
Received: from localhost (unknown [106.200.244.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66A9D2071A;
        Fri, 24 Jan 2020 06:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579845936;
        bh=O4VGvtDvjcC1nUtedyxB+0sSubL0ZZpjKeBF+Knm1qw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W/ezq8gS3TtnXkKWlPfTtCWmf4XkUckEfqJyHY5XOcwAC2mH78JB0bPXyu8/e560v
         +mzYxSRidBPebCaygjngo1XhHfso3c9wY+MelMtYrzeLaT0/DC1xl1pe5AyCpngVY5
         RGNfGZzcZmcATxEjhx0xwf+4Apvq5hwbRUhs6sYQ=
Date:   Fri, 24 Jan 2020 11:35:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        Jonathan.Cameron@huawei.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dmaengine: ptdma: Register pass-through engine as
 a DMA resource
Message-ID: <20200124060532.GD2841@vkoul-mobl>
References: <1579597494-60348-1-git-send-email-Sanju.Mehta@amd.com>
 <1579597494-60348-3-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579597494-60348-3-git-send-email-Sanju.Mehta@amd.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-01-20, 03:04, Sanjay R Mehta wrote:

> +static void pt_free_chan_resources(struct dma_chan *dma_chan)
> +{
> +	struct pt_dma_chan *chan = container_of(dma_chan, struct pt_dma_chan,
> +						 dma_chan);
> +	unsigned long flags;
> +
> +	dev_dbg(chan->pt->dev, "%s - chan=%p\n", __func__, chan);
> +
> +	spin_lock_irqsave(&chan->lock, flags);
> +
> +	pt_free_desc_resources(chan->pt, &chan->complete);
> +	pt_free_desc_resources(chan->pt, &chan->active);
> +	pt_free_desc_resources(chan->pt, &chan->pending);
> +	pt_free_desc_resources(chan->pt, &chan->created);

can you use the virt-dma layer instead for list and descriptor
management..

> +static enum dma_status pt_tx_status(struct dma_chan *dma_chan,
> +				    dma_cookie_t cookie,
> +				    struct dma_tx_state *state)
> +{
> +	struct pt_dma_chan *chan = container_of(dma_chan, struct pt_dma_chan,
> +						 dma_chan);
> +	struct pt_dma_desc *desc;
> +	enum dma_status ret;
> +	unsigned long flags;
> +
> +	if (chan->status == DMA_PAUSED) {
> +		ret = DMA_PAUSED;

the pt_tx_status is for a specific cookie and not for the channel, so
you need to return status of the cookie which may have been completed or
pending (where pause makes sense)

> +static int pt_pause(struct dma_chan *dma_chan)
> +{
> +	struct pt_dma_chan *chan = container_of(dma_chan, struct pt_dma_chan,
> +						 dma_chan);
> +
> +	chan->status = DMA_PAUSED;
> +
> +	/*TODO: Wait for active DMA to complete before returning? */

When will the be resolved :)

-- 
~Vinod
