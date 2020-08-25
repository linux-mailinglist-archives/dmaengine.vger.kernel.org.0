Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2812516FB
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 13:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbgHYLCK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 07:02:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgHYLCH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Aug 2020 07:02:07 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B0882068F;
        Tue, 25 Aug 2020 11:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598353327;
        bh=DDDyE6Ys+xQWaczzVFR7SIZBLM50Ajr7dystNrxus6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aJjsMQqVzQlJTIEQaPsBbeT67Ju0Pae1zf9e3uNcjkgL8z+GzELp0qeyVLgrqiZdp
         rDab101C0LinA9Y5EGWQZegix5KVXq+GdvWvcNK2qwP2ngPHhKjgnMv3+ruVjnQK2a
         WLItnGBX/9BKO3qkaTFXa1wzTqEfgsjn67rKrX14=
Date:   Tue, 25 Aug 2020 16:32:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] dmaengine: add peripheral configuration
Message-ID: <20200825110202.GF2639@vkoul-mobl>
References: <20200824084712.2526079-1-vkoul@kernel.org>
 <20200824084712.2526079-3-vkoul@kernel.org>
 <50ed780f-4c1a-2da2-71e4-423f3b224e25@ti.com>
 <20200825071023.GB2639@vkoul-mobl>
 <38bc6986-6d1d-7c35-b2df-967326fc5ca7@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38bc6986-6d1d-7c35-b2df-967326fc5ca7@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On 25-08-20, 11:00, Peter Ujfalusi wrote:
> Hi Vinod,
> 
> On 25/08/2020 10.10, Vinod Koul wrote:
> >>>  /**
> >>>   * struct dma_slave_config - dma slave channel runtime config
> >>>   * @direction: whether the data shall go in or out on this slave
> >>> @@ -418,6 +485,10 @@ enum dma_slave_buswidth {
> >>>   * @slave_id: Slave requester id. Only valid for slave channels. The dma
> >>>   * slave peripheral will have unique id as dma requester which need to be
> >>>   * pass as slave config.
> >>> + * @peripheral: type of peripheral to DMA to/from
> >>> + * @set_config: set peripheral config
> >>> + * @spi: peripheral config for spi
> >>> + * @:i2c peripheral config for i2c
> >>>   *
> >>>   * This struct is passed in as configuration data to a DMA engine
> >>>   * in order to set up a certain channel for DMA transport at runtime.
> >>> @@ -443,6 +514,10 @@ struct dma_slave_config {
> >>>  	u32 dst_port_window_size;
> >>>  	bool device_fc;
> >>>  	unsigned int slave_id;
> >>> +	enum dmaengine_peripheral peripheral;
> >>> +	u8 set_config;
> >>> +	struct dmaengine_spi_config spi;
> >>> +	struct dmaengine_i2c_config i2c;
> >>
> >> Would it be possible to reuse one of the existing feature already
> >> supported by DMAengine?
> >> We have DMA_PREP_CMD to give a command instead of a real transfer:
> >> dmaengine_prep_slave_single(tx_chan, config_data, config_len,
> >> 			    DMA_MEM_TO_DEV, DMA_PREP_CMD);
> >> dmaengine_prep_slave_single(tx_chan, tx_buff, tx_len, DMA_MEM_TO_DEV,
> >> 			    DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> >> dma_async_issue_pending(tx_chan);
> >>
> >> or the metadata support:
> >> tx = dmaengine_prep_slave_single(tx_chan, tx_buff, tx_len,
> >> 				 DMA_MEM_TO_DEV,
> >> 				 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> >> dmaengine_desc_attach_metadata(tx, config_data, config_len);
> >> dma_async_issue_pending(tx_chan);
> >>
> >> By reading the driver itself, it is not clear if you always need to send
> >> the config for TX, or only when the config is changing and what happens
> >> if the first transfer (for SPI, since that is the only implemented one)
> >> is RX, when you don't send config at all...
> > 
> > So this config is sent to driver everytime before the prep call (can be
> > optimized to once if we have similar transfers in queue).
> 
> I see that you queue the TREs in the prep callback.

Yes

> > This config is used to create the configuration passed to dmaengine
> > which is used to actually program both dmaengine as well as peripheral
> > registers (i2c/spi/etc), so we need a way to pass the spi/i2c config.
> 
> But do you need to send it with each DMA_MEM_TO_DEV or only once?
> DMA_DEV_TO_MEM does not set the config, so I assume you must have one TX
> to initialize the peripheral as the first transfer.

Correct and we do transfers on same without sending configuration again.

> > I think prep cmd can be used to send this data, I do not see any issues
> > with that, it would work if we want to go that route.
> 
> The only thing which might be an issue is that with the DMA_PREP_CMD the
> config_data is dma_addr_t (via dmaengine_prep_slave_single).

Yes I came to same conclusion

> > I did have a prototype with metadata but didnt work very well, the
> > problem is it assumes metadata for tx/rx but here i send the data
> > everytime from client data.
> 
> Yes, the intended use case for metadata (per descriptor!) is for
> channels where each transfer might have different metadata needed for
> the given transfer (tx/rx).
> 
> In your case you have semi static peripheral configuration data, which
> is not really changing between transfers.
> 
> A compromise would be to add:
> void *peripheral_config;
> to the dma_slave_config, move the set_config inside of the device
> specific struct you are passing from a client to the core?

That sounds more saner to me and uses existing interfaces cleanly. I
think I like this option ;-)

> >> I'm concerned about the size increase of dma_slave_config (it grows by
> >>> 30 bytes) and for DMAs with hundreds of channels (UDMA) it will add up
> >> to a sizeable amount.
> > 
> > I agree that is indeed a valid concern, that is the reason I tagged this
> > as a RFC patch ;-)
> > 
> > I see the prep_cmd is a better approach for this, anyone else has better
> > suggestions?
> > 
> > Thanks for looking in.
> > 
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
~Vinod
