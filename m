Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3703A7DDF
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jun 2021 14:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhFOMJx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Jun 2021 08:09:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230208AbhFOMJx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Jun 2021 08:09:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 179EC61241;
        Tue, 15 Jun 2021 12:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623758868;
        bh=51lCS61A39XhM9W1OqX+D9RXpYRQiY7gp/eyopa45Mo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KzqBDUOSt8FTB+s4fEoItuGcRH/2ZSne4v3OKSnPuAmiJ9/Zidx4dh/K9pm6sTAOG
         ay/04EpMAH5Xu8ytpxDjc/MkBxsbWkIYAnW/92HBwCqRv/gAiu0OhkXL/31pPLbwb0
         MQ2O0wpKF3qiCRlOL0vsCkK4qRC5mv9+s3kSIWQ7W/mAYOIOiuXU97uLRId3JsPufo
         GMg3/A4T2vsCvKHOKBg8kBSPgO6Tn+WOdhuSlbiZ8U9kBQKT3MRxDAKOhLhcPezXIt
         7PTgllxYjp0bgj/RJWouKNLAKiWMKV6dkK+X7D3rujOBzSuldoNUL77yt4untHiecM
         AmGx/soYvvzXA==
Date:   Tue, 15 Jun 2021 17:37:45 +0530
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
Message-ID: <YMiYEZDgutW+KRsO@vkoul-mobl>
References: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
 <CAOMZO5CNjpek0vkDrMyTmfbnr2cLcquck6QQBqXLBiyTDKPXvA@mail.gmail.com>
 <VE1PR04MB6688017E125D42C5DCB3C17D89309@VE1PR04MB6688.eurprd04.prod.outlook.com>
 <YMhDvlPrFvSZP//I@vkoul-mobl>
 <VE1PR04MB6688E8EECC03C5290DE10BC089309@VE1PR04MB6688.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6688E8EECC03C5290DE10BC089309@VE1PR04MB6688.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-06-21, 06:36, Robin Gong wrote:
> On 15/06/21 14:08 Vinod Koul <vkoul@kernel.org> wrote:
> > On 15-06-21, 01:55, Robin Gong wrote:
> > > On 06/11/21 21:51 Fabio Estevam <festevam@gmail.com> wrote:
> > 
> > > > Without this series, SPI DMA does not work on i.MX8MM:
> > > >
> > > >  [   41.315984] spi_master spi1: I/O Error in DMA RX
> > > >
> > > > I applied your series and SPI DMA works now:
> > > >
> > > > Reviewed-by: Fabio Estevam <festevam@gmail.com>
> > > Thanks Fabio.
> > > Hello Vinod, Mark,
> > > Is my patch set good enough to merge? I remember someone else are
> > > requesting it from last year like Fabio.
> > 
> > I have acked the last dmaengine patch, is there any else required from me?
> > Which tree will be this merged thru?
> Thanks Vinod, mainline is enough I think. 

I meant which subsystem tree will this go thru :)

-- 
~Vinod
