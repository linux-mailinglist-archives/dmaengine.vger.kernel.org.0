Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C992512C7
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 09:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbgHYHKa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 03:10:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729276AbgHYHK2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Aug 2020 03:10:28 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61839207FB;
        Tue, 25 Aug 2020 07:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598339427;
        bh=pQeWltEcxvf6xblO4Zb7iBrXXzII7g6ooH3nnM5Con4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HlbfwRIhKHwI1y2UfxPiiQRFZXwPOHcB6//DIy2uD++z6SUYwv/8SPqV4pIkaxsI8
         CYtrbWIoJGTI3133l6BYjcT6Fs7s3BTfU3s5p4oXT7Hupxmxw+V4zueQBab35arMVE
         Mt+dDAmNs4MbMGqc0qzVym6Z4/c0bGBG6sf4/g6g=
Date:   Tue, 25 Aug 2020 12:40:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] dmaengine: add peripheral configuration
Message-ID: <20200825071023.GB2639@vkoul-mobl>
References: <20200824084712.2526079-1-vkoul@kernel.org>
 <20200824084712.2526079-3-vkoul@kernel.org>
 <50ed780f-4c1a-2da2-71e4-423f3b224e25@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50ed780f-4c1a-2da2-71e4-423f3b224e25@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Peter,

On 25-08-20, 09:52, Peter Ujfalusi wrote:
> Hi Vinod,
> 
> On 24/08/2020 11.47, Vinod Koul wrote:
> > Some complex dmaengine controllers have capability to program the
> > peripheral device, so pass on the peripheral configuration as part of
> > dma_slave_config
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  include/linux/dmaengine.h | 75 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 75 insertions(+)
> > 
> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > index 6fbd5c99e30c..264643ca9209 100644
> > --- a/include/linux/dmaengine.h
> > +++ b/include/linux/dmaengine.h
> > @@ -380,6 +380,73 @@ enum dma_slave_buswidth {
> >  	DMA_SLAVE_BUSWIDTH_64_BYTES = 64,
> >  };
> >  
> > +/**
> > + * enum spi_transfer_cmd - spi transfer commands
> > + */
> > +enum spi_transfer_cmd {
> > +	SPI_TX = 1,
> > +	SPI_RX,
> > +	SPI_DUPLEX,
> > +};
> > +
> > +/**
> > + * struct dmaengine_spi_config - spi config for peripheral
> > + *
> > + * @loopback_en: spi loopback enable when set
> > + * @clock_pol: clock polarity
> > + * @data_pol: data polarity
> > + * @pack_en: process tx/rx buffers as packed
> > + * @word_len: spi word length
> > + * @clk_div: source clock divider
> > + * @clk_src: serial clock
> > + * @cmd: spi cmd
> > + * @cs: chip select toggle
> > + * @rx_len: receive length for spi buffer
> > + */
> > +struct dmaengine_spi_config {
> > +	u8 loopback_en;
> > +	u8 clock_pol;
> > +	u8 data_pol;
> > +	u8 pack_en;
> > +	u8 word_len;
> > +	u32 clk_div;
> > +	u32 clk_src;
> > +	u8 fragmentation;
> > +	enum spi_transfer_cmd cmd;
> > +	u8 cs;
> > +	u32 rx_len;
> > +};
> > +
> > +/**
> > + * struct dmaengine_i2c_config - i2c config for peripheral
> > + *
> > + * @pack_enable: process tx/rx buffers as packed
> > + * @cycle_count: clock cycles to be sent
> > + * @high_count: high period of clock
> > + * @low_count: low period of clock
> > + * @clk_div: source clock divider
> > + * @addr: i2c bus address
> > + * @strech: strech the clock at eot
> > + * @op: i2c cmd
> > + */
> > +struct dmaengine_i2c_config {
> > +	u8 pack_enable;
> > +	u8 cycle_count;
> > +	u8 high_count;
> > +	u8 low_count;
> > +	u16 clk_div;
> > +	u8 addr;
> > +	u8 strech;
> > +	u8 op;
> > +};
> > +
> > +enum dmaengine_peripheral {
> > +	DMAENGINE_PERIPHERAL_SPI,
> > +	DMAENGINE_PERIPHERAL_I2C,
> > +	DMAENGINE_PERIPHERAL_UART,
> > +	DMAENGINE_PERIPHERAL_LAST = DMAENGINE_PERIPHERAL_UART,
> > +};
> > +
> >  /**
> >   * struct dma_slave_config - dma slave channel runtime config
> >   * @direction: whether the data shall go in or out on this slave
> > @@ -418,6 +485,10 @@ enum dma_slave_buswidth {
> >   * @slave_id: Slave requester id. Only valid for slave channels. The dma
> >   * slave peripheral will have unique id as dma requester which need to be
> >   * pass as slave config.
> > + * @peripheral: type of peripheral to DMA to/from
> > + * @set_config: set peripheral config
> > + * @spi: peripheral config for spi
> > + * @:i2c peripheral config for i2c
> >   *
> >   * This struct is passed in as configuration data to a DMA engine
> >   * in order to set up a certain channel for DMA transport at runtime.
> > @@ -443,6 +514,10 @@ struct dma_slave_config {
> >  	u32 dst_port_window_size;
> >  	bool device_fc;
> >  	unsigned int slave_id;
> > +	enum dmaengine_peripheral peripheral;
> > +	u8 set_config;
> > +	struct dmaengine_spi_config spi;
> > +	struct dmaengine_i2c_config i2c;
> 
> Would it be possible to reuse one of the existing feature already
> supported by DMAengine?
> We have DMA_PREP_CMD to give a command instead of a real transfer:
> dmaengine_prep_slave_single(tx_chan, config_data, config_len,
> 			    DMA_MEM_TO_DEV, DMA_PREP_CMD);
> dmaengine_prep_slave_single(tx_chan, tx_buff, tx_len, DMA_MEM_TO_DEV,
> 			    DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> dma_async_issue_pending(tx_chan);
> 
> or the metadata support:
> tx = dmaengine_prep_slave_single(tx_chan, tx_buff, tx_len,
> 				 DMA_MEM_TO_DEV,
> 				 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> dmaengine_desc_attach_metadata(tx, config_data, config_len);
> dma_async_issue_pending(tx_chan);
> 
> By reading the driver itself, it is not clear if you always need to send
> the config for TX, or only when the config is changing and what happens
> if the first transfer (for SPI, since that is the only implemented one)
> is RX, when you don't send config at all...

So this config is sent to driver everytime before the prep call (can be
optimized to once if we have similar transfers in queue).

This config is used to create the configuration passed to dmaengine
which is used to actually program both dmaengine as well as peripheral
registers (i2c/spi/etc), so we need a way to pass the spi/i2c config.

I think prep cmd can be used to send this data, I do not see any issues
with that, it would work if we want to go that route.

I did have a prototype with metadata but didnt work very well, the
problem is it assumes metadata for tx/rx but here i send the data
everytime from client data.

> I'm concerned about the size increase of dma_slave_config (it grows by
> >30 bytes) and for DMAs with hundreds of channels (UDMA) it will add up
> to a sizeable amount.

I agree that is indeed a valid concern, that is the reason I tagged this
as a RFC patch ;-)

I see the prep_cmd is a better approach for this, anyone else has better
suggestions?

Thanks for looking in.

-- 
~Vinod
