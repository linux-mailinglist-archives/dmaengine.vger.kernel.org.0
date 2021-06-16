Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDBC3A970C
	for <lists+dmaengine@lfdr.de>; Wed, 16 Jun 2021 12:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhFPKSg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Jun 2021 06:18:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232013AbhFPKSf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 16 Jun 2021 06:18:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04FB76128B;
        Wed, 16 Jun 2021 10:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623838589;
        bh=Yl3Fo5sP4nLowKYxQeJ+73AVzv13OFqSVG1zQ6Fifj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PCrvbYraugyfHXvka5f/phJsh3QDa6OznDlXu8faA7q37prFWtVHGl6LuEN00T0SS
         vP0YR5YY0ohYfBI8cxPR0tMn4D90wmj+ELllI0RX5tfsn6vScrffmOccAburP9nQJR
         3Wkdjg0tNJffmta+IbH+DNpGkQhWTPpjDA1fL4m2l3/tIeM+6uYqAwt8Bz2YHfq0wG
         V017dBo6le+T6fViF9eDqgFhhX8H/1SntHmNcfD3zMIyXwfYvCqbtNUAy1d1Vsx8wJ
         srdQAblkQP9BiT2EXtL/X1BAxtalPZjk6mJ6RUV6qA+IDGC4RzK9z5qQdqHjE1bfrg
         CHm5+/UufwQiQ==
Date:   Wed, 16 Jun 2021 15:46:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Clark Wang <xiaoning.wang@nxp.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v14 00/12] add ecspi ERR009165 for i.mx6/7 soc family
Message-ID: <YMnPeLHM8SXTEVQP@vkoul-mobl>
References: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
 <CAOMZO5CNjpek0vkDrMyTmfbnr2cLcquck6QQBqXLBiyTDKPXvA@mail.gmail.com>
 <VE1PR04MB6688017E125D42C5DCB3C17D89309@VE1PR04MB6688.eurprd04.prod.outlook.com>
 <YMhDvlPrFvSZP//I@vkoul-mobl>
 <VE1PR04MB6688E8EECC03C5290DE10BC089309@VE1PR04MB6688.eurprd04.prod.outlook.com>
 <YMiYEZDgutW+KRsO@vkoul-mobl>
 <VE1PR04MB6688F98FE0B76AF20392DD6E89309@VE1PR04MB6688.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6688F98FE0B76AF20392DD6E89309@VE1PR04MB6688.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-06-21, 14:10, Robin Gong wrote:
> On 15/06/21 20:08 Vinod Koul <vkoul@kernel.org> wrote:
> > On 15-06-21, 06:36, Robin Gong wrote:
> > > On 15/06/21 14:08 Vinod Koul <vkoul@kernel.org> wrote:
> > > > On 15-06-21, 01:55, Robin Gong wrote:
> > > > > On 06/11/21 21:51 Fabio Estevam <festevam@gmail.com> wrote:
> > > >
> > > > > > Without this series, SPI DMA does not work on i.MX8MM:
> > > > > >
> > > > > >  [   41.315984] spi_master spi1: I/O Error in DMA RX
> > > > > >
> > > > > > I applied your series and SPI DMA works now:
> > > > > >
> > > > > > Reviewed-by: Fabio Estevam <festevam@gmail.com>
> > > > > Thanks Fabio.
> > > > > Hello Vinod, Mark,
> > > > > Is my patch set good enough to merge? I remember someone else are
> > > > > requesting it from last year like Fabio.
> > > >
> > > > I have acked the last dmaengine patch, is there any else required from me?
> > > > Which tree will be this merged thru?
> > > Thanks Vinod, mainline is enough I think.
> > 
> > I meant which subsystem tree will this go thru :)
> I thought the patches with 'spi' tag could be merged into spi tree while
> 'dmaengine' merged into dmaengine tree, the rest of dts patch merged
> into i.mx branch. But from HW errata view, maybe merging all into i.mx
> branch is a better way?

Are there any dependecies between patches? If not all can merge thru
respective subsystem. You already have the ack, so I dont mind if you
pick thru imx tree

-- 
~Vinod
