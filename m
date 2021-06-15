Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862CC3A76E5
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jun 2021 08:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhFOGKH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Jun 2021 02:10:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229734AbhFOGKF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Jun 2021 02:10:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D26D4613FA;
        Tue, 15 Jun 2021 06:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623737282;
        bh=oNg+lpbroPJmXQTgaVwv9UgXlBPuvAUCTA/4UHKJM8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ppUlInrszUcsKMKm12Jri0gV0R+A1BCeujX5cDapcNvXY11xj0LVd1TPjdM13Er/O
         phmAY/qrRf8fT8Lc7Su+P72mqJMs/8MZ4SpCeA5ncb1NCTT+H9JTM6cvrm0DyicNOE
         MmTlORyubMdevVTNW692NawUXugmKVfqZWFPj84KOFpZrOnMJ7mevLIPb2UxZh5xsa
         SdtDg9Dd0dJ+Z/kr8+0RxPPt/9pBJfLObmpTjZB55yaiO8bdK1kvz2dnEcGyfJ39b8
         DnrMb75rLHfsf0HUCyMBEoisOMqEfvhduexATyNTzFLPS020hBVBjNV4911DNFitR7
         gVxJSHmsykFCg==
Date:   Tue, 15 Jun 2021 11:37:58 +0530
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
Message-ID: <YMhDvlPrFvSZP//I@vkoul-mobl>
References: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
 <CAOMZO5CNjpek0vkDrMyTmfbnr2cLcquck6QQBqXLBiyTDKPXvA@mail.gmail.com>
 <VE1PR04MB6688017E125D42C5DCB3C17D89309@VE1PR04MB6688.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6688017E125D42C5DCB3C17D89309@VE1PR04MB6688.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-06-21, 01:55, Robin Gong wrote:
> On 06/11/21 21:51 Fabio Estevam <festevam@gmail.com> wrote: 

> > Without this series, SPI DMA does not work on i.MX8MM:
> > 
> >  [   41.315984] spi_master spi1: I/O Error in DMA RX
> > 
> > I applied your series and SPI DMA works now:
> > 
> > Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Thanks Fabio.
> Hello Vinod, Mark, 
> Is my patch set good enough to merge? I remember someone else are
> requesting it from last year like Fabio. 

I have acked the last dmaengine patch, is there any else required from
me? Which tree will be this merged thru?

-- 
~Vinod
