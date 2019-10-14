Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBC0D5BCB
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2019 09:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfJNHBs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Oct 2019 03:01:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfJNHBs (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 14 Oct 2019 03:01:48 -0400
Received: from localhost (unknown [122.167.124.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10A2C207FF;
        Mon, 14 Oct 2019 07:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571036507;
        bh=mE97jSeuIdSHPAiDkvSSy2UYsHj6stB9L7qIbfb6xPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HQ2Pzm2v1MHZuluhB3/bkh4eVmw+hg4xWK2WSMnX7eWi9mPFxjvxva2cEa2WToej4
         VqM9Mj1B+dDD407auf4a00w2g4S+bjuJJT5zJabWpxRjmuEYlbLbYvdc+v6ccNsWUm
         psFJtZoXSJVrDQOEU+afjRFf8ij159c49y0Estug=
Date:   Mon, 14 Oct 2019 12:31:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Rodrigo Alencar <alencar.fmce@imbel.gov.br>
Subject: Re: [PATCH] dmaengine: axi-dmac: simple device_config operation
 implemented
Message-ID: <20191014070142.GB2654@vkoul-mobl>
References: <20190913145404.28715-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913145404.28715-1-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-09-19, 17:54, Alexandru Ardelean wrote:
> From: Rodrigo Alencar <alencar.fmce@imbel.gov.br>
> 
> dmaengine_slave_config is called by dmaengine_pcm_hw_params when using
> axi-i2s with axi-dmac. If device_config is NULL, -ENOSYS  is returned,
> which breaks the snd_pcm_hw_params function.
> This is a fix for the error:

and what is that?

> 
> $ aplay -D plughw:ADAU1761 /usr/share/sounds/alsa/Front_Center.wav
> Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit
> Little Endian, Rate 48000 Hz, Mono
> axi-i2s 43c20000.axi-i2s: ASoC: 43c20000.axi-i2s hw params failed: -38
> aplay: set_params:1403: Unable to install hw params:
> ACCESS:  RW_INTERLEAVED
> FORMAT:  S16_LE
> SUBFORMAT:  STD
> SAMPLE_BITS: 16
> FRAME_BITS: 16
> CHANNELS: 1
> RATE: 48000
> PERIOD_TIME: 125000
> PERIOD_SIZE: 6000
> PERIOD_BYTES: 12000
> PERIODS: 4
> BUFFER_TIME: 500000
> BUFFER_SIZE: 24000
> BUFFER_BYTES: 48000
> TICK_TIME: 0
> 
> Signed-off-by: Rodrigo Alencar <alencar.fmce@imbel.gov.br>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
> 
> Note: Fixes tag not added intentionally.
> 
>  drivers/dma/dma-axi-dmac.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index a0ee404b736e..ab2677343202 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
> @@ -564,6 +564,21 @@ static struct dma_async_tx_descriptor *axi_dmac_prep_slave_sg(
>  	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
>  }
>  
> +static int axi_dmac_device_config(struct dma_chan *c,
> +			struct dma_slave_config *slave_config)
> +{
> +	struct axi_dmac_chan *chan = to_axi_dmac_chan(c);
> +	struct axi_dmac *dmac = chan_to_axi_dmac(chan);
> +
> +	/* no configuration required, a sanity check is done instead */
> +	if (slave_config->direction != chan->direction) {

 slave_config->direction is a deprecated field, pls dont use that

> +		dev_err(dmac->dma_dev.dev, "Direction not supported by this DMA Channel");
> +		return -EINVAL;

So you intent to support slave dma but do not use dma_slave_config.. how
are you getting the slave address and other details?

Thanks
-- 
~Vinod
