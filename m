Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE8872381
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jul 2019 02:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfGXAtZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Jul 2019 20:49:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbfGXAtZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 23 Jul 2019 20:49:25 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D6132253D;
        Wed, 24 Jul 2019 00:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563929364;
        bh=f1BgHRD07iLgL/RGh4ch0V6HXKB6ToEvnZ787DM64e0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UX3gv9jRpafjJM3CJy7HbkTSbt/ys7gAa35KrwrO23HsfEBMYrs3uAfjIb4Oo+6yl
         3O8q/Fwca+iHDZkxXpAk9yp7xJCJYGn1Xisup3xheKcnBIvTH8bi6aDN4q+g+ZZWCt
         5Nf+czS/e/GSOTlPGT7NCihNbmoXCQW/bjYkv0nM=
Date:   Wed, 24 Jul 2019 08:48:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 12/15] ARM: dts: imx6ul: add dma support on ecspi
Message-ID: <20190724004848.GV15632@dragon>
References: <20190610081753.11422-1-yibin.gong@nxp.com>
 <20190610081753.11422-13-yibin.gong@nxp.com>
 <20190717064204.GA3738@dragon>
 <VE1PR04MB663894FA5BC88B130C70AC0789C70@VE1PR04MB6638.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB663894FA5BC88B130C70AC0789C70@VE1PR04MB6638.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jul 23, 2019 at 09:39:38AM +0000, Robin Gong wrote:
> On 2019-7-17 at 14:42 Shawn Guo <shawnguo@kernel.org> wrote:
> > On Mon, Jun 10, 2019 at 04:17:50PM +0800, yibin.gong@nxp.com wrote:
> > > From: Robin Gong <yibin.gong@nxp.com>
> > >
> > > Add dma support on ecspi.
> > >
> > > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > 
> > Applied, thanks.
> Thanks Shawn, but how about other dts patches such as 01/15,02/15?

I need the authors of the commits being reverted agree on the reverting.

  Sean Nyekjaer <sean.nyekjaer@prevas.dk>
  Sascha Hauer <s.hauer@pengutronix.de>

Shawn
