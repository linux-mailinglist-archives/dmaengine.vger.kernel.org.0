Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0325BF8807
	for <lists+dmaengine@lfdr.de>; Tue, 12 Nov 2019 06:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbfKLFes (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Nov 2019 00:34:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:60958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfKLFes (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 12 Nov 2019 00:34:48 -0500
Received: from localhost (unknown [122.167.70.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80D8D2084F;
        Tue, 12 Nov 2019 05:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573536887;
        bh=Jb7dYixP6yIjsrokC6NTgrZ/74+6EVtRM48rK5FZNvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=swnFRxTopGg49WadsvYOwM4ZljN75NOKNOp1Z9e5BW0FyYQHYvejgIuS/T6ZaeS+f
         gxIT4lF0hqOk50dDZyDJJSafiZ3bZ8R9mleb8cOsMrZAepP86BKYPsfg0wzquvM826
         YuIVlpKmlK7CHZSlLwZbDQfxBtffsMv1FmSgU/Ak=
Date:   Tue, 12 Nov 2019 11:04:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, grygorii.strashko@ti.com,
        lokeshvutla@ti.com, t-kristo@ti.com, tony@atomide.com,
        j-keerthy@ti.com
Subject: Re: [PATCH v4 10/15] dmaengine: ti: New driver for K3 UDMA -
 split#2: probe/remove, xlate and filter_fn
Message-ID: <20191112053440.GV952516@vkoul-mobl>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-11-peter.ujfalusi@ti.com>
 <20191111053301.GO952516@vkoul-mobl>
 <9b0f8bec-4964-8136-4173-7b45e479c0c5@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b0f8bec-4964-8136-4173-7b45e479c0c5@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-11-19, 11:16, Peter Ujfalusi wrote:
> 
> 
> On 11/11/2019 7.33, Vinod Koul wrote:
> > On 01-11-19, 10:41, Peter Ujfalusi wrote:
> > 
> >> +static bool udma_dma_filter_fn(struct dma_chan *chan, void *param)
> >> +{
> >> +	struct psil_endpoint_config *ep_config;
> >> +	struct udma_chan *uc;
> >> +	struct udma_dev *ud;
> >> +	u32 *args;
> >> +
> >> +	if (chan->device->dev->driver != &udma_driver.driver)
> >> +		return false;
> >> +
> >> +	uc = to_udma_chan(chan);
> >> +	ud = uc->ud;
> >> +	args = param;
> >> +	uc->remote_thread_id = args[0];
> >> +
> >> +	if (uc->remote_thread_id & K3_PSIL_DST_THREAD_ID_OFFSET)
> >> +		uc->dir = DMA_MEM_TO_DEV;
> >> +	else
> >> +		uc->dir = DMA_DEV_TO_MEM;
> > 
> > Can you explain this a bit?
> 
> The UDMAP in K3 works between two PSI-L endpoint. The source and
> destination needs to be paired to allow data flow.
> Source thread IDs are in range of 0x0000 - 0x7fff, while destination
> thread IDs are 0x8000 - 0xffff.
> 
> If the remote thread ID have the bit 31 set (0x8000) then the transfer
> is MEM_TO_DEV and I need to pick one unused tchan for it. If the remote
> is the source then it can be handled by rchan.
> 
> dmas = <&main_udmap 0xc400>, <&main_udmap 0x4400>;
> dma-names = "tx", "rx";
> 
> 0xc400 is a destination thread ID, so it is MEM_TO_DEV
> 0x4400 is a source thread ID, so it is DEV_TO_MEM
> 
> Even in MEM_TO_MEM case I need to pair two UDMAP channels:
> UDMAP source threads are starting at offset 0x1000, UDMAP destination
> threads are 0x9000+

Okay so a channel is set for a direction until teardown. Also this and
other patch comments are quite useful, can we add them here?

> Changing direction runtime is hardly possible as it would involve
> tearing down the channel, removing interrupts, destroying rings,
> removing the PSI-L pairing and redoing everything.

okay I would expect the prep_ to check for direction and reject the call
if direction is different.

-- 
~Vinod
