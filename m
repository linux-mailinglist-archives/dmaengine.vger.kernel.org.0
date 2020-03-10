Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 238EB17F20B
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2020 09:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgCJIhn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Mar 2020 04:37:43 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37435 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgCJIhm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Mar 2020 04:37:42 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jBaOF-0008Uo-Lg; Tue, 10 Mar 2020 09:37:27 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jBaOD-00047A-I9; Tue, 10 Mar 2020 09:37:25 +0100
Date:   Tue, 10 Mar 2020 09:37:25 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
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
Subject: Re: [RESEND v6  06/13] spi: imx: fix ERR009165
Message-ID: <20200310083725.sb6cufp5wznvxcji@pengutronix.de>
References: <1583839922-22699-1-git-send-email-yibin.gong@nxp.com>
 <1583839922-22699-7-git-send-email-yibin.gong@nxp.com>
 <20200310073920.GR3335@pengutronix.de>
 <VE1PR04MB66384DA6732A840FE1D80C1989FF0@VE1PR04MB6638.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VE1PR04MB66384DA6732A840FE1D80C1989FF0@VE1PR04MB6638.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

On Tue, Mar 10, 2020 at 08:27:41AM +0000, Robin Gong wrote:
> On 2020/03/10 Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > On Tue, Mar 10, 2020 at 07:31:55PM +0800, Robin Gong wrote:
> > >  	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
> > >
> > > @@ -612,12 +613,14 @@ static int mx51_ecspi_prepare_transfer(struct
> > > spi_imx_data *spi_imx,
> > >
> > >  static void mx51_setup_wml(struct spi_imx_data *spi_imx)  {
> > > +	u32 tx_wml = 0;
> > > +
> > >  	/*
> > >  	 * Configure the DMA register: setup the watermark
> > >  	 * and enable DMA request.
> > >  	 */
> > >  	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml - 1) |
> > > -		MX51_ECSPI_DMA_TX_WML(spi_imx->wml) |
> > > +		MX51_ECSPI_DMA_TX_WML(tx_wml) |
> > 
> > tx_wml is never assigned any other value than 0. Drop the variable.
> That's prepared for 07/13 patch which may assign spi_imx->wml to tx_wml.

Then this belongs into patch 7, right?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
