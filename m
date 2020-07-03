Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B87213E98
	for <lists+dmaengine@lfdr.de>; Fri,  3 Jul 2020 19:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgGCRcq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Jul 2020 13:32:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGCRcq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 3 Jul 2020 13:32:46 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF781206DD;
        Fri,  3 Jul 2020 17:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593797565;
        bh=D95yF3wchkvtpDxhZgKXSezU+wVuikkrUAV9Ghh5kVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WKS4OjkX/XDQtB61MUZNyutIWOoYzdzzwPsE8tF4d7FUhYH4kPjiV+BY2FZOYsBZI
         c1vnjF8N9dWjw+F3NPHPjfDmb2y9/ouNVpBYhuyilLP3Ix/ncEEFfR3woR2BQfqNZv
         urBiF9D2fPUgmT1taU0l2lq59mHVj+BGybHH2MQU=
Date:   Fri, 3 Jul 2020 23:02:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dmaengine@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v5 4/6] dmaengine: xilinx: dpdma: Add the Xilinx
 DisplayPort DMA engine driver
Message-ID: <20200703173239.GP273932@vkoul-mobl>
References: <20200528025228.31638-1-laurent.pinchart@ideasonboard.com>
 <20200528025228.31638-5-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528025228.31638-5-laurent.pinchart@ideasonboard.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-05-20, 05:52, Laurent Pinchart wrote:

> +++ b/drivers/dma/xilinx/xilinx_dpdma.c
> @@ -0,0 +1,1554 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx ZynqMP DPDMA Engine driver
> + *
> + * Copyright (C) 2015 - 2019 Xilinx, Inc.

2020 please

> +static struct xilinx_dpdma_tx_desc *
> +xilinx_dpdma_chan_alloc_tx_desc(struct xilinx_dpdma_chan *chan)
> +{
> +	struct xilinx_dpdma_tx_desc *tx_desc;
> +
> +	tx_desc = kzalloc(sizeof(*tx_desc), GFP_KERNEL);

GFP_NOWAIT please, this is called from a prep call so needs to be atomic
context

> +static int xilinx_dpdma_config(struct dma_chan *dchan,
> +			       struct dma_slave_config *config)
> +{
> +	struct xilinx_dpdma_chan *chan = to_xilinx_chan(dchan);
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	if (config->direction != DMA_MEM_TO_DEV)
> +		return -EINVAL;

sorry but direction is deprecated and supposed to be remove, can you
please remove this
> +
> +	/*
> +	 * The destination address doesn't need to be specified as the DPDMA is
> +	 * hardwired to the destination (the DP controller). The transfer
> +	 * width, burst size and port window size are thus meaningless, they're
> +	 * fixed both on the DPDMA side and on the DP controller side.
> +	 */
> +
> +	spin_lock_irqsave(&chan->lock, flags);
> +
> +	/* Can't reconfigure a running channel. */
> +	if (chan->running) {
> +		ret = -EBUSY;
> +		goto unlock;
> +	}

why does this part matter? The configuration is passed here and should
be applied to next descriptor submitted, channel can be busy.

> +
> +	/*
> +	 * Abuse the slave_id to indicate that the channel is part of a video
> +	 * group.
> +	 */

Of course, what does video grp mean here? 

> +	if (chan->id >= ZYNQMP_DPDMA_VIDEO0 && chan->id <= ZYNQMP_DPDMA_VIDEO2)
> +		chan->video_group = config->slave_id != 0;

so only thing we care here is slave_id? What about dma burst parameters?
-- 
~Vinod
