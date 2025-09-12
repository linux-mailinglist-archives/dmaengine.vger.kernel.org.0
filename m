Return-Path: <dmaengine+bounces-6492-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAEEB55373
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 17:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D15D11D67D78
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 15:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F98D230BDF;
	Fri, 12 Sep 2025 15:28:01 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C63B81ACA
	for <dmaengine@vger.kernel.org>; Fri, 12 Sep 2025 15:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690881; cv=none; b=BVXLWpAi1QXZhLs6jtlD3fNnXQ54J+mxHZQJsgKxPrLYy2DB8YRHBva6FJgKtDCOH43Op+PWVixAAo3v1C0bTr/TdWHhvhrjMGrIDJY9sIUU6LTWCxxdEjO6kgZiQERrgHsSsDeuzwadQmJgSU5bqSJcaREyPJFug1wuvb5c6Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690881; c=relaxed/simple;
	bh=Ich4KrqPFUbEnQGywwwKCnfCdX6kg4ccl6lh+uaHa90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjnKnrxtMm3fpct+f7zcEYVIzlEJGGB3WKc97FdRbtNybwvUL7vnmEHXTAB+js64MiX+HjGfXprN18KvuuERA4uNgAFZ8UKnUM1DbltaAm0oa5BUbrRizuqDfkpRzW1bVQq1ZVsyRKeGIH4vFPcQysl3vQ8tN6kVbKjFuc1CHnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1ux5gi-0005o5-PB; Fri, 12 Sep 2025 17:27:48 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1ux5gi-000xIm-1T;
	Fri, 12 Sep 2025 17:27:48 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1ux5gi-0032oA-14;
	Fri, 12 Sep 2025 17:27:48 +0200
Date: Fri, 12 Sep 2025 17:27:48 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/10] dmaengine: imx-sdma: fix spba-bus handling for
 i.MX8M
Message-ID: <20250912152748.gn66fmmrqyqlqdrb@pengutronix.de>
References: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
 <20250911-v6-16-topic-sdma-v2-2-d315f56343b5@pengutronix.de>
 <aMQ53pZQD4tj+GvN@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMQ53pZQD4tj+GvN@lizhi-Precision-Tower-5810>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org

On 25-09-12, Frank Li wrote:
> On Thu, Sep 11, 2025 at 11:56:43PM +0200, Marco Felsch wrote:
> > Starting with i.MX8M* devices there are multiple spba-busses so we can't
> > just search the whole DT for the first spba-bus match and take it.
> > Instead we need to check for each device to which bus it belongs and
> > setup the spba_{start,end}_addr accordingly per sdma_channel.
> >
> > While on it, don't ignore errors from of_address_to_resource() if they
> > are valid.
> >
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> 
> I think the below method should be better.
> 
> of_translate_address(per_address) == OF_BAD_ADDR to check if belong spba-bus

The SDMA engine doesn't have to be part of the SPBA bus, please see the
i.MX8MM for example.

Regards,
  Marco

> aips3: bus@30800000 {
> 	...
>         ranges = <0x30800000 0x30800000 0x400000>,
>                  <0x8000000 0x8000000 0x10000000>;
> 
>                         spba1: spba-bus@30800000 {
>                                 compatible = "fsl,spba-bus", "simple-bus";
>                                 #address-cells = <1>;
>                                 #size-cells = <1>;
>                                 reg = <0x30800000 0x100000>;
>                                 ranges;
> 
> 				...
> 				sdma1:
> 
> };
> 
> of_translate_address() will 1:1 map at spba-bus@30800000 spba1.
> then
> reach ranges = <0x30800000 0x30800000 0x400000> of aips3
> 
> if per_address is not in this range, it should return OF_BAD_ADDR. So
> needn't parse reg of bus@30800000 at all.
> 
> Frank
> 
> > ---
> >  drivers/dma/imx-sdma.c | 58 ++++++++++++++++++++++++++++++++++----------------
> >  1 file changed, 40 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> > index 3ecb917214b1268b148a29df697b780bc462afa4..56daaeb7df03986850c9c74273d0816700581dc0 100644
> > --- a/drivers/dma/imx-sdma.c
> > +++ b/drivers/dma/imx-sdma.c
> > @@ -429,6 +429,8 @@ struct sdma_desc {
> >   * @event_mask:		event mask used in p_2_p script
> >   * @watermark_level:	value for gReg[7], some script will extend it from
> >   *			basic watermark such as p_2_p
> > + * @spba_start_addr:	SDMA controller SPBA bus start address
> > + * @spba_end_addr:	SDMA controller SPBA bus end address
> >   * @shp_addr:		value for gReg[6]
> >   * @per_addr:		value for gReg[2]
> >   * @status:		status of dma channel
> > @@ -461,6 +463,8 @@ struct sdma_channel {
> >  	dma_addr_t			per_address, per_address2;
> >  	unsigned long			event_mask[2];
> >  	unsigned long			watermark_level;
> > +	u32				spba_start_addr;
> > +	u32				spba_end_addr;
> >  	u32				shp_addr, per_addr;
> >  	enum dma_status			status;
> >  	struct imx_dma_data		data;
> > @@ -534,8 +538,6 @@ struct sdma_engine {
> >  	u32				script_number;
> >  	struct sdma_script_start_addrs	*script_addrs;
> >  	const struct sdma_driver_data	*drvdata;
> > -	u32				spba_start_addr;
> > -	u32				spba_end_addr;
> >  	unsigned int			irq;
> >  	dma_addr_t			bd0_phys;
> >  	struct sdma_buffer_descriptor	*bd0;
> > @@ -1236,8 +1238,6 @@ static void sdma_channel_synchronize(struct dma_chan *chan)
> >
> >  static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
> >  {
> > -	struct sdma_engine *sdma = sdmac->sdma;
> > -
> >  	int lwml = sdmac->watermark_level & SDMA_WATERMARK_LEVEL_LWML;
> >  	int hwml = (sdmac->watermark_level & SDMA_WATERMARK_LEVEL_HWML) >> 16;
> >
> > @@ -1263,12 +1263,12 @@ static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
> >  		swap(sdmac->event_mask[0], sdmac->event_mask[1]);
> >  	}
> >
> > -	if (sdmac->per_address2 >= sdma->spba_start_addr &&
> > -			sdmac->per_address2 <= sdma->spba_end_addr)
> > +	if (sdmac->per_address2 >= sdmac->spba_start_addr &&
> > +			sdmac->per_address2 <= sdmac->spba_end_addr)
> >  		sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_SP;
> >
> > -	if (sdmac->per_address >= sdma->spba_start_addr &&
> > -			sdmac->per_address <= sdma->spba_end_addr)
> > +	if (sdmac->per_address >= sdmac->spba_start_addr &&
> > +			sdmac->per_address <= sdmac->spba_end_addr)
> >  		sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_DP;
> >
> >  	sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_CONT;
> > @@ -1447,6 +1447,31 @@ static void sdma_desc_free(struct virt_dma_desc *vd)
> >  	kfree(desc);
> >  }
> >
> > +static int sdma_config_spba_slave(struct dma_chan *chan)
> > +{
> > +	struct sdma_channel *sdmac = to_sdma_chan(chan);
> > +	struct device_node *spba_bus;
> > +	struct resource spba_res;
> > +	int ret;
> > +
> > +	spba_bus = of_get_parent(chan->slave->of_node);
> > +	/* Device doesn't belong to the spba-bus */
> > +	if (!of_device_is_compatible(spba_bus, "fsl,spba-bus"))
> > +		return 0;
> > +
> > +	ret = of_address_to_resource(spba_bus, 0, &spba_res);
> > +	of_node_put(spba_bus);
> > +	if (ret) {
> > +		dev_err(sdmac->sdma->dev, "Failed to get spba-bus resources\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	sdmac->spba_start_addr = spba_res.start;
> > +	sdmac->spba_end_addr = spba_res.end;
> > +
> > +	return 0;
> > +}
> > +
> >  static int sdma_alloc_chan_resources(struct dma_chan *chan)
> >  {
> >  	struct sdma_channel *sdmac = to_sdma_chan(chan);
> > @@ -1527,6 +1552,8 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
> >
> >  	sdmac->event_id0 = 0;
> >  	sdmac->event_id1 = 0;
> > +	sdmac->spba_start_addr = 0;
> > +	sdmac->spba_end_addr = 0;
> >
> >  	sdma_set_channel_priority(sdmac, 0);
> >
> > @@ -1837,6 +1864,7 @@ static int sdma_config(struct dma_chan *chan,
> >  {
> >  	struct sdma_channel *sdmac = to_sdma_chan(chan);
> >  	struct sdma_engine *sdma = sdmac->sdma;
> > +	int ret;
> >
> >  	memcpy(&sdmac->slave_config, dmaengine_cfg, sizeof(*dmaengine_cfg));
> >
> > @@ -1867,6 +1895,10 @@ static int sdma_config(struct dma_chan *chan,
> >  		sdma_event_enable(sdmac, sdmac->event_id1);
> >  	}
> >
> > +	ret = sdma_config_spba_slave(chan);
> > +	if (ret)
> > +		return ret;
> > +
> >  	return 0;
> >  }
> >
> > @@ -2235,11 +2267,9 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
> >  static int sdma_probe(struct platform_device *pdev)
> >  {
> >  	struct device_node *np = pdev->dev.of_node;
> > -	struct device_node *spba_bus;
> >  	const char *fw_name;
> >  	int ret;
> >  	int irq;
> > -	struct resource spba_res;
> >  	int i;
> >  	struct sdma_engine *sdma;
> >  	s32 *saddr_arr;
> > @@ -2375,14 +2405,6 @@ static int sdma_probe(struct platform_device *pdev)
> >  			dev_err(&pdev->dev, "failed to register controller\n");
> >  			goto err_register;
> >  		}
> > -
> > -		spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
> > -		ret = of_address_to_resource(spba_bus, 0, &spba_res);
> > -		if (!ret) {
> > -			sdma->spba_start_addr = spba_res.start;
> > -			sdma->spba_end_addr = spba_res.end;
> > -		}
> > -		of_node_put(spba_bus);
> >  	}
> >
> >  	/*
> >
> > --
> > 2.47.3
> >
> 

