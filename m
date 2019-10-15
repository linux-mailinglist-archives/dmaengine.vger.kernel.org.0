Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A56FD7392
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2019 12:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfJOKns (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Oct 2019 06:43:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728214AbfJOKns (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Oct 2019 06:43:48 -0400
Received: from localhost (unknown [171.76.96.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6334820854;
        Tue, 15 Oct 2019 10:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571136226;
        bh=S3B+ofswemQthW/eKUQJFkeu8fu8WPXvCfq+gdh/oNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a4+5VIBfbh54Faf9vFA1aBP8YseXHySX3OEYN04PVDvBJ3P7wDiAPqUx3wU/ENTq+
         Rh021lx5OjEP4fAVs4Vw0PEIUfDXwBjBpiaznH6L9jFnabOP17QmQcVbleYtC3doFj
         OipAfTTHfzq52r0S2xGyKBITF69ag8ZaE+p+FFQo=
Date:   Tue, 15 Oct 2019 16:13:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "alencar.fmce@imbel.gov.br" <alencar.fmce@imbel.gov.br>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH] dmaengine: axi-dmac: simple device_config operation
 implemented
Message-ID: <20191015104342.GW2654@vkoul-mobl>
References: <20190913145404.28715-1-alexandru.ardelean@analog.com>
 <20191014070142.GB2654@vkoul-mobl>
 <4384347cc94a54e3fa22790aaa91375afda54e1b.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4384347cc94a54e3fa22790aaa91375afda54e1b.camel@analog.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-10-19, 07:05, Ardelean, Alexandru wrote:
> On Mon, 2019-10-14 at 12:31 +0530, Vinod Koul wrote:
> > [External]
> > 
> 
> Hey,
> 
> > On 13-09-19, 17:54, Alexandru Ardelean wrote:
> > > From: Rodrigo Alencar <alencar.fmce@imbel.gov.br>
> > > 
> > > dmaengine_slave_config is called by dmaengine_pcm_hw_params when using
> > > axi-i2s with axi-dmac. If device_config is NULL, -ENOSYS  is returned,
> > > which breaks the snd_pcm_hw_params function.
> > > This is a fix for the error:
> > 
> > and what is that?
> > 
> > > $ aplay -D plughw:ADAU1761 /usr/share/sounds/alsa/Front_Center.wav
> > > Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit
> > > Little Endian, Rate 48000 Hz, Mono
> > > axi-i2s 43c20000.axi-i2s: ASoC: 43c20000.axi-i2s hw params failed: -38
> 
> Error is above this line [code -38].

Right and it would help explaining a bit more on the error!

> 
> > > aplay: set_params:1403: Unable to install hw params:
> > > ACCESS:  RW_INTERLEAVED
> > > FORMAT:  S16_LE
> > > SUBFORMAT:  STD
> > > SAMPLE_BITS: 16
> > > FRAME_BITS: 16
> > > CHANNELS: 1
> > > RATE: 48000
> > > PERIOD_TIME: 125000
> > > PERIOD_SIZE: 6000
> > > PERIOD_BYTES: 12000
> > > PERIODS: 4
> > > BUFFER_TIME: 500000
> > > BUFFER_SIZE: 24000
> > > BUFFER_BYTES: 48000
> > > TICK_TIME: 0
> > > 
> > > Signed-off-by: Rodrigo Alencar <alencar.fmce@imbel.gov.br>
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > > ---
> > > 
> > > Note: Fixes tag not added intentionally.
> > > 
> > >  drivers/dma/dma-axi-dmac.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > > 
> > > diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> > > index a0ee404b736e..ab2677343202 100644
> > > --- a/drivers/dma/dma-axi-dmac.c
> > > +++ b/drivers/dma/dma-axi-dmac.c
> > > @@ -564,6 +564,21 @@ static struct dma_async_tx_descriptor
> > > *axi_dmac_prep_slave_sg(
> > >  	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
> > >  }
> > >  
> > > +static int axi_dmac_device_config(struct dma_chan *c,
> > > +			struct dma_slave_config *slave_config)
> > > +{
> > > +	struct axi_dmac_chan *chan = to_axi_dmac_chan(c);
> > > +	struct axi_dmac *dmac = chan_to_axi_dmac(chan);
> > > +
> > > +	/* no configuration required, a sanity check is done instead */
> > > +	if (slave_config->direction != chan->direction) {
> > 
> >  slave_config->direction is a deprecated field, pls dont use that
> 
> ack
> any alternative recommendations of what to do in this case?
> i can take a look, but if you have something on-the-top-of-your-head, i'm
> open to suggestions
> we can also just drop this completely and let userspace fail

Yeah it is tricky, this should be ideally implemented properly.

> > > +		dev_err(dmac->dma_dev.dev, "Direction not supported by this
> > > DMA Channel");
> > > +		return -EINVAL;
> > 
> > So you intent to support slave dma but do not use dma_slave_config.. how
> > are you getting the slave address and other details?
> 
> This DMA controller is a bit special.
> It gets synthesized in FPGA, so the configuration is fixed and cannot be
> changed at runtime. Maybe later we would allow/implement this
> functionality, but this is a question for my HDL colleagues.
> 
> Two things are done (in this order):
> 1. For some paramters, axi_dmac_parse_chan_dt() is used to determine things
> from device-tree; as it's an FPGA core, things are synthesized once and
> cannot change (yet)
> 2. For other parameters, the axi_dmac_detect_caps() is used to guess some
> of them at probe time, by doing some reg reads/writes

So the question for you hw folks is how would a controller work with
multiple slave devices, do they need to synthesize it everytime?

Rather than that why cant they make the peripheral addresses
programmable so that you dont need updating fpga everytime!

> 
> I'll admit that maybe the whole approach could be done a bit
> differently/better. But I guess this approach was chosen by the fact that
> it's FPGA.

Well FPGA doesnt mean hw should know everything, having SW program
things is not a terrible idea

-- 
~Vinod
