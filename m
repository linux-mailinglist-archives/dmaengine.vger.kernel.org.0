Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361413C5A2C
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jul 2021 13:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbhGLJgV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jul 2021 05:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbhGLJgU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jul 2021 05:36:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6106AC0613DD
        for <dmaengine@vger.kernel.org>; Mon, 12 Jul 2021 02:33:32 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1m2sJS-0006eq-JK; Mon, 12 Jul 2021 11:33:18 +0200
Message-ID: <1159a6b7f30402b07aaa5654bd98bfaa95457960.camel@pengutronix.de>
Subject: Re: [PATCH v14 09/12] dmaengine: imx-sdma: remove ERR009165 on
 i.mx6ul
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "martin.fuzzey@flowbird.group" <martin.fuzzey@flowbird.group>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "matthias.schiffer@ew.tq-group.com" 
        <matthias.schiffer@ew.tq-group.com>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        Clark Wang <xiaoning.wang@nxp.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 12 Jul 2021 11:33:16 +0200
In-Reply-To: <VE1PR04MB6688F74F67882E3DC26495E489159@VE1PR04MB6688.eurprd04.prod.outlook.com>
References: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
         <1617809456-17693-10-git-send-email-yibin.gong@nxp.com>
         <3ade0741d94e53eb2bca86743ad11e55899381d7.camel@pengutronix.de>
         <VE1PR04MB6688F74F67882E3DC26495E489159@VE1PR04MB6688.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Am Montag, dem 12.07.2021 um 04:03 +0000 schrieb Robin Gong:
> On 09/07/21 17:45 Lucas Stach <l.stach@pengutronix.de> wrote:
> > Am Mittwoch, dem 07.04.2021 um 23:30 +0800 schrieb Robin Gong:
> > > ECSPI issue fixed from i.mx6ul at hardware level, no need
> > > ERR009165 anymore on those chips such as i.mx8mq.
> > > 
> > > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > > Acked-by: Vinod Koul <vkoul@kernel.org>
> > > ---
> > >  drivers/dma/imx-sdma.c | 26 +++++++++++++++++++++++++-
> > >  1 file changed, 25 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c index
> > > 86bd383..af85116 100644
> > > --- a/drivers/dma/imx-sdma.c
> > > +++ b/drivers/dma/imx-sdma.c
> > > @@ -422,6 +422,13 @@ struct sdma_driver_data {
> > >  	int num_events;
> > >  	struct sdma_script_start_addrs	*script_addrs;
> > >  	bool check_ratio;
> > > +	/*
> > > +	 * ecspi ERR009165 fixed should be done in sdma script
> > > +	 * and it has been fixed in soc from i.mx6ul.
> > > +	 * please get more information from the below link:
> > > +	 *
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.n
> > xp.com%2Fdocs%2Fen%2Ferrata%2FIMX6DQCE.pdf&amp;data=04%7C01%7C
> > yibin.gong%40nxp.com%7Cc950b1bdb6544eda369408d942be35d9%7C686ea
> > 1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C637614206980361737%7CU
> > nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6
> > Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=6iT6%2FbzJHyWnkhkDynY
> > wmK9nn2hgCDy1GyzELeEk9K8%3D&amp;reserved=0
> > > +	 */
> > > +	bool ecspi_fixed;
> > >  };
> > > 
> > >  struct sdma_engine {
> > > @@ -542,6 +549,13 @@ static struct sdma_driver_data sdma_imx6q = {
> > >  	.script_addrs = &sdma_script_imx6q,
> > >  };
> > > 
> > > +static struct sdma_driver_data sdma_imx6ul = {
> > > +	.chnenbl0 = SDMA_CHNENBL0_IMX35,
> > > +	.num_events = 48,
> > > +	.script_addrs = &sdma_script_imx6q,
> > > +	.ecspi_fixed = true,
> > > +};
> > > +
> > >  static struct sdma_script_start_addrs sdma_script_imx7d = {
> > >  	.ap_2_ap_addr = 644,
> > >  	.uart_2_mcu_addr = 819,
> > > @@ -575,6 +589,7 @@ static const struct of_device_id sdma_dt_ids[] = {
> > >  	{ .compatible = "fsl,imx31-sdma", .data = &sdma_imx31, },
> > >  	{ .compatible = "fsl,imx25-sdma", .data = &sdma_imx25, },
> > >  	{ .compatible = "fsl,imx7d-sdma", .data = &sdma_imx7d, },
> > > +	{ .compatible = "fsl,imx6ul-sdma", .data = &sdma_imx6ul, },
> > >  	{ .compatible = "fsl,imx8mq-sdma", .data = &sdma_imx8mq, },
> > >  	{ /* sentinel */ }
> > >  };
> > > @@ -1144,8 +1159,17 @@ static int sdma_config_channel(struct dma_chan
> > *chan)
> > >  			if (sdmac->peripheral_type == IMX_DMATYPE_ASRC_SP ||
> > >  			    sdmac->peripheral_type == IMX_DMATYPE_ASRC)
> > >  				sdma_set_watermarklevel_for_p2p(sdmac);
> > > -		} else
> > > +		} else {
> > > +			/*
> > > +			 * ERR009165 fixed from i.mx6ul, no errata need,
> > > +			 * set bit31 to let sdma script skip the errata.
> > > +			 */
> > > +			if (sdmac->peripheral_type == IMX_DMATYPE_CSPI &&
> > > +			    sdmac->direction == DMA_MEM_TO_DEV &&
> > > +			    sdmac->sdma->drvdata->ecspi_fixed)
> > > +				__set_bit(31, &sdmac->watermark_level);
> > 
> > Hm, I don't care much either way, but couldn't we just return the regular
> > mcu_2_app script in sdma_get_pc when ecspi_fixed == true? Seems like this
> > would be a simpler and more targeted code change.
> Yes, return mcu_2_app if ecspi_fixed == true also works, but since sdma firmware
> have already been here to fix ERR009165 on most of legacy i.mx6/7/8 chips, so choosing
> firmware/ram script to do like ROM/mcu_2_app is okay too since both ram script and rom
> script in case of ecspi_fixed are almost same.
> 
Actually, while thinking some more about this: it is preferable to
return mcu_2_app in the ecspi_fixed case, as this allows proper DMA
support on the fixed SoCs without loading the firmware. The way you do
it here still requires the RAM firmware to be loaded in order to get
DMA support at all.

Regards,
Lucas

> > 
> > >  			__set_bit(sdmac->event_id0, sdmac->event_mask);
> > > +		}
> > > 
> > >  		/* Address */
> > >  		sdmac->shp_addr = sdmac->per_address;
> > 
> 


