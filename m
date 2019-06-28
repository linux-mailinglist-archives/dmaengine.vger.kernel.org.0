Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 957B75996B
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2019 13:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfF1Lvj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Jun 2019 07:51:39 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:47064 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfF1Lvj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Jun 2019 07:51:39 -0400
Received: by mail-ot1-f66.google.com with SMTP id z23so5635912ote.13;
        Fri, 28 Jun 2019 04:51:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K8l4MtGQkJM9EGnhldzQahBFzyBF13zgVztQH0T3zG8=;
        b=En1XTpCJ8Tva6I6cqpz5cjcjW8cWwfQ1YuofpA9ZmUtgP6gEIIhBWjwLg203BNxSlc
         CfflUV1OTxpSD2+ubya/bOj9Aga1UdqmAXmAJ9GecBDYPqcATEETcJGfl+B/G1K6hr6W
         gKhxyDqd+9TR+UJpZ6QCEmStOUbEhHXhoTLGDb84Ryf9P3/cKrlSmLKZXGtnXIeYnmow
         kf/Fkf02eqyVOyMdI7mO8Jx3fR9OwVUQxwsKSxhmzTQqEr7YgHPQ2v+/nDmfvo2/7ssc
         To6/IQoUIzFUNySdKbCm9T51z+d6RLQmXmY/+CggXqS0EwUjc0Jdbg1mf2kbx+XpLGKI
         daig==
X-Gm-Message-State: APjAAAUJl24Zpil33akM+qLBxt0x51Zf4F7a8QATiEiYUq0mCdDgI08a
        JLrftfLqwkZ6kJArbBa5UiQ6X9+d1s4fIuxnU+8=
X-Google-Smtp-Source: APXvYqzdFuGSxoSUOdpGgJD/2b8tbD8y18L4dvgELocB/59oKsEp1AZwISkSvtI+PPQw9bPShX7p10Fke5Dzrbp60OY=
X-Received: by 2002:a05:6830:210f:: with SMTP id i15mr7712294otc.250.1561722697415;
 Fri, 28 Jun 2019 04:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190624123540.20629-1-geert+renesas@glider.be> <20190626173434.GA24702@x230>
In-Reply-To: <20190626173434.GA24702@x230>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 28 Jun 2019 13:51:25 +0200
Message-ID: <CAMuHMdWuk7CkfcUSX=706f8b6YMFio7iwZg32+uXsyOKL68fuQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] serial: sh-sci: Fix .flush_buffer() issues
To:     Eugeniu Rosca <roscaeugeniu@gmail.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        dmaengine@vger.kernel.org,
        "George G . Davis" <george_davis@mentor.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Eugeniu,

On Wed, Jun 26, 2019 at 7:34 PM Eugeniu Rosca <roscaeugeniu@gmail.com> wrote:
> On Mon, Jun 24, 2019 at 02:35:38PM +0200, Geert Uytterhoeven wrote:
> > This patch series attempts to fix the issues Eugeniu Rosca reported
> > seeing, where .flush_buffer() interfered with transmit DMA operation[*].
> >
> > There's a third patch "dmaengine: rcar-dmac: Reject zero-length slave
> > DMA requests", which is related to the issue, but further independent,
> > hence submitted separately.
> >
> > Eugeniu: does this fix the issues you were seeing?
>
> Many thanks for both sh-sci and the rcar-dmac patches.
> The fixes are very much appreciated.
>
> > Geert Uytterhoeven (2):
> >   serial: sh-sci: Fix TX DMA buffer flushing and workqueue races
> >   serial: sh-sci: Terminate TX DMA during buffer flushing
> >
> >  drivers/tty/serial/sh-sci.c | 33 ++++++++++++++++++++++++---------
> >  1 file changed, 24 insertions(+), 9 deletions(-)
>
> I reserved some time to get a feeling about how the patches behave on
> a real system (H3-ES2.0-ULCB-KF-M06), so here come my observations.

Thanks for your extensive testing!

> First of all, the issue I have originally reported in [0] is only
> reproducible in absence of [4]. So, one of my questions would be how
> do you yourself see the relationship between [1-3] and [4]?

I consider them independent.
Just applying [4] would fix the issue for the console only, while the
race condition can still be triggered on other serial ports.

> That said, all my testing assumes:
>  - Vanilla tip v5.2-rc6-15-g249155c20f9b with [4] reverted.
>  - DEBUG is undefined in {sh-sci.c,rcar-dmac.c}, since I've noticed
>    new issues arising in the debug build, which are unrelated to [0].
>
> Below is the summary of my findings:
>
>  Version         IS [0]       Is console       Error message when
> (vanilla+X)    reproduced?  usable after [0]   [0] is reproduced
>                              is reproduced?
>  ------------------------------------------------------------
>  -[4]             Yes           No                [5]
>  -[4]+[1]         Yes           No                -
>  -[4]+[2]         Yes           Yes               [5]
>  -[4]+[3]         Yes           Yes               [6]
>  -[4]+[1]+[2]     No            -                 -
>  -[4]+[1]+[2]+[3] No            -                 -
>  pure vanilla     No            -                 -
>
> This looks a little too verbose, but I thought it might be interesting.

Thanks, it's very helpful to provide these results.

> The story which I see is that [1] does not fix [0] alone, but it seems
> to depend on [2]. Furthermore, if cherry picked alone, [1] makes the
> matters somewhat worse in the sense that it hides the error [5].

OK.

> My only question is whether [1-3] are supposed to replace [4] or they
> are supposed to happily coexist. Since I don't see [0] being reproduced

They are meant to coexist.

> with [1-3], I personally prefer to re-enable DMA on SCIF (when the
> latter is used as console) so that more features and code paths are
> exercised to increase test coverage.

If a serial port is used as a console, the port is used for both DMA
(normal use) and PIO (serial console output).  The latter can have a
negative impact on the former, aggravating existing bugs, or triggering
more races, even in the hardware.  So I think it's better to be more
cautious and keep DMA disabled for the console.

> [0] https://lore.kernel.org/lkml/20190504004258.23574-3-erosca@de.adit-jv.com/
> [1] https://patchwork.kernel.org/patch/11012983/
>     ("serial: sh-sci: Fix TX DMA buffer flushing and workqueue races")
> [2] https://patchwork.kernel.org/patch/11012987/
>     ("serial: sh-sci: Terminate TX DMA during buffer flushing")
> [3] https://patchwork.kernel.org/patch/11012991/
>     ("dmaengine: rcar-dmac: Reject zero-length slave DMA requests")
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=099506cbbc79c0
>     ("serial: sh-sci: disable DMA for uart_console")
>
> [5] rcar-dmac e7300000.dma-controller: Channel Address Error
> [6] rcar-dmac e7300000.dma-controller: rcar_dmac_prep_slave_sg: bad parameter: len=1, id=19
>     sh-sci e6e88000.serial: Failed preparing Tx DMA descriptor

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
