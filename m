Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBEF5A0D9
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2019 18:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfF1Q3x (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Jun 2019 12:29:53 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:35405 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfF1Q3x (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Jun 2019 12:29:53 -0400
Received: from svr-orw-mbx-01.mgc.mentorg.com ([147.34.90.201])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1hgtkH-0001pV-KB from George_Davis@mentor.com ; Fri, 28 Jun 2019 09:29:05 -0700
Received: from localhost (147.34.91.1) by svr-orw-mbx-01.mgc.mentorg.com
 (147.34.90.201) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Fri, 28 Jun
 2019 09:29:03 -0700
Date:   Fri, 28 Jun 2019 12:29:02 -0400
From:   "George G. Davis" <george_davis@mentor.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH 0/2] serial: sh-sci: Fix .flush_buffer() issues
Message-ID: <20190628162902.GA1343@mam-gdavis-lt>
References: <20190624123540.20629-1-geert+renesas@glider.be>
 <20190626173434.GA24702@x230>
 <CAMuHMdWuk7CkfcUSX=706f8b6YMFio7iwZg32+uXsyOKL68fuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWuk7CkfcUSX=706f8b6YMFio7iwZg32+uXsyOKL68fuQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: SVR-ORW-MBX-09.mgc.mentorg.com (147.34.90.209) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello All,

On Fri, Jun 28, 2019 at 01:51:25PM +0200, Geert Uytterhoeven wrote:
> Hi Eugeniu,
> 
> On Wed, Jun 26, 2019 at 7:34 PM Eugeniu Rosca <roscaeugeniu@gmail.com> wrote:
> > On Mon, Jun 24, 2019 at 02:35:38PM +0200, Geert Uytterhoeven wrote:
> > > This patch series attempts to fix the issues Eugeniu Rosca reported
> > > seeing, where .flush_buffer() interfered with transmit DMA operation[*].
> > >
> > > There's a third patch "dmaengine: rcar-dmac: Reject zero-length slave
> > > DMA requests", which is related to the issue, but further independent,
> > > hence submitted separately.
> > >
> > > Eugeniu: does this fix the issues you were seeing?
> >
> > Many thanks for both sh-sci and the rcar-dmac patches.
> > The fixes are very much appreciated.
> >
> > > Geert Uytterhoeven (2):
> > >   serial: sh-sci: Fix TX DMA buffer flushing and workqueue races
> > >   serial: sh-sci: Terminate TX DMA during buffer flushing
> > >
> > >  drivers/tty/serial/sh-sci.c | 33 ++++++++++++++++++++++++---------
> > >  1 file changed, 24 insertions(+), 9 deletions(-)
> >
> > I reserved some time to get a feeling about how the patches behave on
> > a real system (H3-ES2.0-ULCB-KF-M06), so here come my observations.
> 
> Thanks for your extensive testing!
> 
> > First of all, the issue I have originally reported in [0] is only
> > reproducible in absence of [4]. So, one of my questions would be how
> > do you yourself see the relationship between [1-3] and [4]?
> 
> I consider them independent.
> Just applying [4] would fix the issue for the console only, while the
> race condition can still be triggered on other serial ports.
> 
> > That said, all my testing assumes:
> >  - Vanilla tip v5.2-rc6-15-g249155c20f9b with [4] reverted.
> >  - DEBUG is undefined in {sh-sci.c,rcar-dmac.c}, since I've noticed
> >    new issues arising in the debug build, which are unrelated to [0].
> >
> > Below is the summary of my findings:
> >
> >  Version         IS [0]       Is console       Error message when
> > (vanilla+X)    reproduced?  usable after [0]   [0] is reproduced
> >                              is reproduced?
> >  ------------------------------------------------------------
> >  -[4]             Yes           No                [5]
> >  -[4]+[1]         Yes           No                -
> >  -[4]+[2]         Yes           Yes               [5]
> >  -[4]+[3]         Yes           Yes               [6]
> >  -[4]+[1]+[2]     No            -                 -
> >  -[4]+[1]+[2]+[3] No            -                 -
> >  pure vanilla     No            -                 -
> >
> > This looks a little too verbose, but I thought it might be interesting.
> 
> Thanks, it's very helpful to provide these results.
> 
> > The story which I see is that [1] does not fix [0] alone, but it seems
> > to depend on [2]. Furthermore, if cherry picked alone, [1] makes the
> > matters somewhat worse in the sense that it hides the error [5].
> 
> OK.
> 
> > My only question is whether [1-3] are supposed to replace [4] or they
> > are supposed to happily coexist. Since I don't see [0] being reproduced
> 
> They are meant to coexist.
> 
> > with [1-3], I personally prefer to re-enable DMA on SCIF (when the
> > latter is used as console) so that more features and code paths are
> > exercised to increase test coverage.
> 
> If a serial port is used as a console, the port is used for both DMA
> (normal use) and PIO (serial console output).  The latter can have a
> negative impact on the former, aggravating existing bugs, or triggering
> more races, even in the hardware.  So I think it's better to be more
> cautious and keep DMA disabled for the console.

Agreed.

Just a note for the record that [4] was the easiest way to resolve the
reported problem [0] but an alternative solution would be to implement DMA
support for ttySC console ports which will be non-trivial to implement and test
due to the potential for deadlocks in console write critical paths where
various locks are held with interrupts disabled. I see only one tty serial
driver which implements console DMA support, drivers/tty/serial/mpsc.c,
and perhaps there is a good reason why there are no other examples?

> > [0] https://lore.kernel.org/lkml/20190504004258.23574-3-erosca@de.adit-jv.com/
> > [1] https://patchwork.kernel.org/patch/11012983/
> >     ("serial: sh-sci: Fix TX DMA buffer flushing and workqueue races")
> > [2] https://patchwork.kernel.org/patch/11012987/
> >     ("serial: sh-sci: Terminate TX DMA during buffer flushing")
> > [3] https://patchwork.kernel.org/patch/11012991/
> >     ("dmaengine: rcar-dmac: Reject zero-length slave DMA requests")
> > [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=099506cbbc79c0
> >     ("serial: sh-sci: disable DMA for uart_console")
> >
> > [5] rcar-dmac e7300000.dma-controller: Channel Address Error
> > [6] rcar-dmac e7300000.dma-controller: rcar_dmac_prep_slave_sg: bad parameter: len=1, id=19
> >     sh-sci e6e88000.serial: Failed preparing Tx DMA descriptor
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Regards,
George
