Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7467817F38B
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2020 10:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgCJJ2X (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Mar 2020 05:28:23 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35061 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgCJJ2X (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Mar 2020 05:28:23 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1jBbBE-0006N3-GD; Tue, 10 Mar 2020 10:28:04 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1jBbBE-0006Yx-0M; Tue, 10 Mar 2020 10:28:04 +0100
Date:   Tue, 10 Mar 2020 10:28:03 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "martin.fuzzey@flowbird.group" <martin.fuzzey@flowbird.group>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RESEND v6  09/13] dmaengine: imx-sdma: remove ERR009165 on
 i.mx6ul
Message-ID: <20200310092803.GW3335@pengutronix.de>
References: <1583839922-22699-1-git-send-email-yibin.gong@nxp.com>
 <1583839922-22699-10-git-send-email-yibin.gong@nxp.com>
 <20200310081925.GT3335@pengutronix.de>
 <VE1PR04MB6638029458AFDE3005C6E4A489FF0@VE1PR04MB6638.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6638029458AFDE3005C6E4A489FF0@VE1PR04MB6638.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:25:44 up 19 days, 16:56, 51 users,  load average: 0.30, 0.15,
 0.14
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Mar 10, 2020 at 08:59:03AM +0000, Robin Gong wrote:
> On 2020/03/10 Sascha Hauer <s.hauer@pengutronix.de> wrote: 
> > On Tue, Mar 10, 2020 at 07:31:58PM +0800, Robin Gong wrote:
> > > ECSPI issue fixed from i.mx6ul at hardware level, no need
> > > ERR009165 anymore on those chips such as i.mx8mq. Add i.mx6sx from
> > > where i.mx6ul source.
> > >
> > > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > > Acked-by: Vinod Koul <vkoul@kernel.org>
> > > ---
> > >  drivers/dma/imx-sdma.c | 51
> > > +++++++++++++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 50 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c index
> > > 56288d8..5ae7237 100644
> > > --- a/drivers/dma/imx-sdma.c
> > > +++ b/drivers/dma/imx-sdma.c
> > > @@ -419,6 +419,13 @@ struct sdma_driver_data {
> > >  	int num_events;
> > >  	struct sdma_script_start_addrs	*script_addrs;
> > >  	bool check_ratio;
> > > +	/*
> > > +	 * ecspi ERR009165 fixed should be done in sdma script
> > > +	 * and it has been fixed in soc from i.mx6ul.
> > > +	 * please get more information from the below link:
> > > +	 *
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.nx
> > p.com%2Fdocs%2Fen%2Ferrata%2FIMX6DQCE.pdf&amp;data=02%7C01%7Cyi
> > bin.gong%40nxp.com%7C91d42046e6894501d48508d7c4cbcae2%7C686ea1d3
> > bc2b4c6fa92cd99c5c301635%7C0%7C1%7C637194251876090170&amp;sdata=
> > T6LA4xz9CUFlNpnyjHSThEQb8i1rhbY9e1nUyxIGD5Q%3D&amp;reserved=0
> > > +	 */
> > > +	bool ecspi_fixed;
> > >  };
> > >
> > >  struct sdma_engine {
> > > @@ -539,6 +546,31 @@ static struct sdma_driver_data sdma_imx6q = {
> > >  	.script_addrs = &sdma_script_imx6q,
> > >  };
> > >
> > > +static struct sdma_script_start_addrs sdma_script_imx6sx = {
> > > +	.ap_2_ap_addr = 642,
> > > +	.uart_2_mcu_addr = 817,
> > > +	.mcu_2_app_addr = 747,
> > > +	.uartsh_2_mcu_addr = 1032,
> > > +	.mcu_2_shp_addr = 960,
> > > +	.app_2_mcu_addr = 683,
> > > +	.shp_2_mcu_addr = 891,
> > > +	.spdif_2_mcu_addr = 1100,
> > > +	.mcu_2_spdif_addr = 1134,
> > > +};
> > > +
> > > +static struct sdma_driver_data sdma_imx6sx = {
> > > +	.chnenbl0 = SDMA_CHNENBL0_IMX35,
> > > +	.num_events = 48,
> > > +	.script_addrs = &sdma_script_imx6sx, };
> > > +
> > > +static struct sdma_driver_data sdma_imx6ul = {
> > > +	.chnenbl0 = SDMA_CHNENBL0_IMX35,
> > > +	.num_events = 48,
> > > +	.script_addrs = &sdma_script_imx6sx,
> > > +	.ecspi_fixed = true,
> > > +};
> > > +
> > >  static struct sdma_script_start_addrs sdma_script_imx7d = {
> > >  	.ap_2_ap_addr = 644,
> > >  	.uart_2_mcu_addr = 819,
> > > @@ -584,9 +616,15 @@ static const struct platform_device_id
> > sdma_devtypes[] = {
> > >  		.name = "imx6q-sdma",
> > >  		.driver_data = (unsigned long)&sdma_imx6q,
> > >  	}, {
> > > +		.name = "imx6sx-sdma",
> > > +		.driver_data = (unsigned long)&sdma_imx6sx,
> > > +	}, {
> > 
> > Now the i.MX6sx uses a new sdma_script_start_addrs entry which is the same
> > as the i.MX6q one we used before with one exception: it lacks the
> > per_2_per_addr = 6331 entry. This is only used for IMX_DMATYPE_ASRC and
> Totally same script for i.mx6 chips whatever i.MX6sx, i.MX6q or i.MX6ul. 

When it's the same then use it.

> > IMX_DMATYPE_ASRC_SP, both are entirely unused in the mainline kernel. So
> > why must the i.MX6sx changed here and what has this to do with ECSPI?
> i.MX6ul is based on i.MX6sx, so adding i.MX6sx could keep good shape on our i.MX family evolution.

My point is that there is no difference between i.MX6q and i.MX6sx here,
so do not artificially introduce i.MX6sx support when all you do is
copying the i.MX6q support.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
