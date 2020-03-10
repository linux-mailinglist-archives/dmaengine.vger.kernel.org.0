Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97EA817F371
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2020 10:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgCJJZy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Mar 2020 05:25:54 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35503 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgCJJZx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Mar 2020 05:25:53 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1jBb8q-00066g-Ok; Tue, 10 Mar 2020 10:25:36 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1jBb8n-0006XS-8W; Tue, 10 Mar 2020 10:25:33 +0100
Date:   Tue, 10 Mar 2020 10:25:33 +0100
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
Subject: Re: [RESEND v6  07/13] spi: imx: remove ERR009165 workaround on
 i.mx6ul
Message-ID: <20200310092533.GV3335@pengutronix.de>
References: <1583839922-22699-1-git-send-email-yibin.gong@nxp.com>
 <1583839922-22699-8-git-send-email-yibin.gong@nxp.com>
 <20200310080240.GS3335@pengutronix.de>
 <VE1PR04MB66384342F94C7B789C980F7A89FF0@VE1PR04MB6638.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB66384342F94C7B789C980F7A89FF0@VE1PR04MB6638.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:08:54 up 19 days, 16:39, 58 users,  load average: 0.05, 0.18,
 0.20
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Mar 10, 2020 at 08:43:10AM +0000, Robin Gong wrote:
> On 2020/03/10 Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > On Tue, Mar 10, 2020 at 07:31:56PM +0800, Robin Gong wrote:
> > > ERR009165 fixed on i.mx6ul/6ull/6sll. All other i.mx6/7 and i.mx8m/8mm
> > > still need this errata. Please refer to nxp official errata document
> > > from
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.nx
> > p.com%2F&amp;data=02%7C01%7Cyibin.gong%40nxp.com%7Cf73bfc11a68c4
> > 2f5f6d308d7c4c96efa%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C
> > 637194241755109112&amp;sdata=xzIUP8qZkrlDXX0yjTcUNZB6zDrevTdHFg1o4
> > PZZd8E%3D&amp;reserved=0 .
> > >
> > > For removing workaround on those chips. Add new i.mx6ul type.
> > >
> > > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > > Acked-by: Mark Brown <broonie@kernel.org>
> > > ---
> > >  drivers/spi/spi-imx.c | 50
> > > +++++++++++++++++++++++++++++++++++++++++++++-----
> > >  1 file changed, 45 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c index
> > > 842a86e..f7ee2ec 100644
> > > --- a/drivers/spi/spi-imx.c
> > > +++ b/drivers/spi/spi-imx.c
> > > @@ -57,6 +57,7 @@ enum spi_imx_devtype {
> > >  	IMX35_CSPI,	/* CSPI on all i.mx except above */
> > >  	IMX51_ECSPI,	/* ECSPI on i.mx51 */
> > >  	IMX53_ECSPI,	/* ECSPI on i.mx53 and later */
> > > +	IMX6UL_ECSPI,	/* ERR009165 fix from i.mx6ul */
> > >  };
> > >
> > >  struct spi_imx_data;
> > > @@ -75,6 +76,11 @@ struct spi_imx_devtype_data {
> > >  	bool has_slavemode;
> > >  	unsigned int fifo_size;
> > >  	bool dynamic_burst;
> > > +	/*
> > > +	 * ERR009165 fixed or not:
> > > +	 *
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.nx
> > p.com%2Fdocs%2Fen%2Ferrata%2FIMX6DQCE.pdf&amp;data=02%7C01%7Cyi
> > bin.gong%40nxp.com%7Cf73bfc11a68c42f5f6d308d7c4c96efa%7C686ea1d3bc
> > 2b4c6fa92cd99c5c301635%7C0%7C1%7C637194241755109112&amp;sdata=m
> > uw4HL5nMDjREJwVd885Wrxka0moMaaZ%2BhJgsAgY3eo%3D&amp;reserved=
> > 0
> > > +	 */
> > > +	bool tx_glitch_fixed;
> > >  	enum spi_imx_devtype devtype;
> > >  };
> > >
> > > @@ -128,7 +134,8 @@ static inline int is_imx35_cspi(struct
> > > spi_imx_data *d)
> > >
> > >  static inline int is_imx51_ecspi(struct spi_imx_data *d)  {
> > > -	return d->devtype_data->devtype == IMX51_ECSPI;
> > > +	return d->devtype_data->devtype == IMX51_ECSPI ||
> > > +	       d->devtype_data->devtype == IMX6UL_ECSPI;
> > >  }
> > 
> > Erm, no. A i.MX51 ECSPI is a i.MX51 ECSPI and not a i.MX6UL ECSPI. If you want
> > to handle them equally somewhere then explicitly test for i.MX6ul *and*
> > i.MX51 there.
> But all i.mx6 chips including i.MX53 ECSPI are almost same as i.MX51 ECSPI, and ERR00915 is fixed from i.mx6ul....

You introduce .devtype = IMX6UL_ECSPI in this series, so apparently it
is *not* the same as IMX51_ECSPI, then please also don't introduce a
function which claims they are the same.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
