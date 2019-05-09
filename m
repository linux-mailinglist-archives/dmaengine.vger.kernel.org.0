Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68D6518A1D
	for <lists+dmaengine@lfdr.de>; Thu,  9 May 2019 14:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfEIMzd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 May 2019 08:55:33 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:51754 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfEIMzd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 May 2019 08:55:33 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 1E50225BE06;
        Thu,  9 May 2019 22:55:31 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 22BA49403F2; Thu,  9 May 2019 14:55:29 +0200 (CEST)
Date:   Thu, 9 May 2019 14:55:29 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        HIROYUKI YOKOYAMA <hiroyuki.yokoyama.vx@renesas.com>
Subject: Re: [PATCH] dmaengine: rcar-dmac: Update copyright information
Message-ID: <20190509125528.d7eryp5iv45yn2mp@verge.net.au>
References: <20190410182657.23034-1-niklas.soderlund+renesas@ragnatech.se>
 <20190411084937.y5m6vzcwtkqqun7s@verge.net.au>
 <20190411151756.GC30887@bigcity.dyn.berto.se>
 <CAMuHMdXLM0hkUva4AukBpYy+=mRQ_tWT4XCGb=ZGbuT5nYMzjA@mail.gmail.com>
 <OSBPR01MB1733615712FC0F8271580D8BD83D0@OSBPR01MB1733.jpnprd01.prod.outlook.com>
 <20190426115343.GY28103@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190426115343.GY28103@vkoul-mobl>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Apr 26, 2019 at 05:23:43PM +0530, Vinod Koul wrote:
> On 25-04-19, 03:52, Yoshihiro Shimoda wrote:
> > Hi Geert-san,
> > 
> > > From: Geert Uytterhoeven, Sent: Wednesday, April 24, 2019 9:22 PM
> > > 
> > > Hi Niklas, Shimoda-san,
> > > 
> > > On Thu, Apr 11, 2019 at 5:18 PM Niklas Söderlund
> > > <niklas.soderlund@ragnatech.se> wrote:
> > > > On 2019-04-11 10:49:37 +0200, Simon Horman wrote:
> > > > > On Wed, Apr 10, 2019 at 08:26:57PM +0200, Niklas Söderlund wrote:
> > > > > Not strictly related, but is it appropriate to:
> > > > >
> > > > > 1. Move this driver and drivers/dma/sh/usb-dmac.c to drivers/dma/renesas/
> > > 
> > > That may make sense...
> > > 
> > > > > 2. Remove drivers/dma/sh/sudmac.c which appears unused
> > > >
> > > > I let someone with a better grasp of history answer this one. From my
> > > > side removing drivers which are unused seems like a good idea :-)
> > > 
> > > There seem to be some (half-baked?) interaction between sudmac.c and
> > > drivers/usb/gadget/udc/r8a66597-udc.c and drivers/usb/renesas_usbhs/fifo.c.
> > > These don't seem to be used at all on Renesas ARM platforms, but
> > > CONFIG_USB_R8A66597_HCD is enabled in shmobile_defconfig and
> > > multi_v7_defconfig?
> > > 
> > > Shimoda-san: can you please enlighten us?
> > > Thanks!
> > 
> > Sure.
> > 
> > - SH4A / sh7757 has SUDMAC. (any other Renesas ARM platforms don't have it).
> >  # sh7757 is not public product though...
> > - At first, I added this SUDMAC support into r8a66597-udc.
> > - But, our direction is changed by some reason. So, we use renesas_usbhs driver anyway.
> > - The renesas_usbhs supports dmaengine, so I added dma/sh/sudmac driver.
> > - However, for some reasons (maybe I'm busy for other projects?),
> >   I didn't add using the sudmac support into arch/sh/kernel/cpu/sh4a/setup-sh7757.c.
> > - So, no one uses both r8a66597-udc and sudmac now.
> > 
> > From 2013 (added the sudmac driver) to now, since no one integrated the sudmac for sh7757,
> > I think we can remove the driver.
> 
> And where is the removal patch :)

Sorry for the delay, I have just posted

[PATCH] dmaengine: sudmac: remove unused driver


Shimoda-san, can we go further and also:

1. Remove the r8a66597-udc driver, which also seems unused
2. Remove (minimal) sudmac integration from usbhs ?
