Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8733C6D7A
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jul 2021 11:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbhGMJdM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jul 2021 05:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbhGMJdL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Jul 2021 05:33:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFC1C0613EF
        for <dmaengine@vger.kernel.org>; Tue, 13 Jul 2021 02:30:21 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1m3Ejr-0000rp-Gk; Tue, 13 Jul 2021 11:30:03 +0200
Message-ID: <695d47eb5dad9292d8f87e69ad1bccaa2e132a66.camel@pengutronix.de>
Subject: Re: [PATCH v14 08/12] spi: imx: remove ERR009165 workaround on
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
Date:   Tue, 13 Jul 2021 11:30:01 +0200
In-Reply-To: <VE1PR04MB66889D0BC546DE2580BF614089149@VE1PR04MB6688.eurprd04.prod.outlook.com>
References: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
         <1617809456-17693-9-git-send-email-yibin.gong@nxp.com>
         <dfa12f89f112966197518aa8df25cb47d69b30f7.camel@pengutronix.de>
         <VE1PR04MB668852203A2920C6C9E9E3CF89159@VE1PR04MB6688.eurprd04.prod.outlook.com>
         <7ca4554c58908618705768e01239409d19f83d17.camel@pengutronix.de>
         <VE1PR04MB66889D0BC546DE2580BF614089149@VE1PR04MB6688.eurprd04.prod.outlook.com>
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

Am Dienstag, dem 13.07.2021 um 09:12 +0000 schrieb Robin Gong:
> On 12/07/21 17:31 Lucas Stach <l.stach@pengutronix.de> wrote: 
> > Am Montag, dem 12.07.2021 um 03:48 +0000 schrieb Robin Gong:
> > > On 09/07/21 17:42 Lucas Stach <l.stach@pengutronix.de> wrote:
> > > > Am Mittwoch, dem 07.04.2021 um 23:30 +0800 schrieb Robin Gong:
> > > > > ERR009165 fixed on i.mx6ul/6ull/6sll. All other i.mx6/7 and
> > > > > i.mx8m/8mm still need this errata. Please refer to nxp official
> > > > > errata document from
> > > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fww
> > > > w.n
> > xp.com%2F&amp;data=04%7C01%7Cyibin.gong%40nxp.com%7C48156bc93d
> > > > 
> > c84ac26e9d08d942bdc0ac%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> > > > 
> > 7C1%7C637614205017900475%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> > > > 
> > wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&a
> > > > 
> > mp;sdata=keYQubzt1jWrKhaxXr40RL41vzFuIn7x1Sasa3p%2F9Xo%3D&amp;res
> > > > erved=0 .
> > > > > 
> > > > > For removing workaround on those chips. Add new i.mx6ul type.
> > > > > 
> > > > > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > > > > Acked-by: Mark Brown <broonie@kernel.org>
> > > > > ---
> > > > >  drivers/spi/spi-imx.c | 47
> > > > > +++++++++++++++++++++++++++++++++++++++++++----
> > > > >  1 file changed, 43 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c index
> > > > > cf235b9..d18ee25 100644
> > > > > --- a/drivers/spi/spi-imx.c
> > > > > +++ b/drivers/spi/spi-imx.c
> > > > > @@ -59,6 +59,7 @@ enum spi_imx_devtype {
> > > > >  	IMX35_CSPI,	/* CSPI on all i.mx except above */
> > > > >  	IMX51_ECSPI,	/* ECSPI on i.mx51 */
> > > > >  	IMX53_ECSPI,	/* ECSPI on i.mx53 and later */
> > > > > +	IMX6UL_ECSPI,	/* ERR009165 fix from i.mx6ul */
> > > > 
> > > > This patch could be a lot smaller if you didn't introduce a new
> > > > devtype. You could just use the IMX51_ECSPI in
> > > > imx6ul_ecspi_devtype_data, as all you care about as a relevant
> > > > difference is the tx_glitch_fixed property, which isn't tied to the devtype.
> > > I knew tx_glitch_fixed was enough but I still prefer to add new
> > > 'IMX6UL_ECSPI' because we can clearly choose the right IP which has
> > > fix the issue while legacy IMX51 if it's not fixed by dts.
> > > 
> > Sorry, I don't follow this reasoning. You are not using the new IMX6UL_ECSPI
> > devtype in any way in this patch, other than a single location, where you just
> > handle it the same as the IMX51_ECSPI devtype.
> Okay, will reuse IMX51_ECSPI as devtype, but will still keep "fsl,imx6ul-ecspi".
> 
That's exactly what I meant: have a "fsl,imx6ul-ecspi" compatible with
it's own imx6ul_ecspi_devtype_data, but reuse the IMX51_ECSPI devtype.

Glad we are on the same page now.

Regards,
Lucas


