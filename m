Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9CB81445D6
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jan 2020 21:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgAUUWg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Jan 2020 15:22:36 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42960 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbgAUUWg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Jan 2020 15:22:36 -0500
Received: by mail-oi1-f194.google.com with SMTP id 18so3857122oin.9;
        Tue, 21 Jan 2020 12:22:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cZEBIs9b/D6MpJDmgXVh+a+pNQ+8lRhkPW5Xjr/bZzI=;
        b=FF65bbuxrcmDcGLcEgLrJVxf+BAEth1uCsQkECHjDcRh4LKxGysrkyR1Ftq+mbvXWL
         lD4If9ckpRh2X71jsIZqqGsQYEHIR0KMsaNCdqBbuSDfPtsoFIGezLiybbUSmjqBAQ37
         MxczFBOj4BGEHTn3GEk+fc2r+aJPaCJKSLi9Si2rEdEOS4lcmy5pU2vuVyWecZlMaPY/
         CkPTJ97c5qHQrJNb4xzLiC5yRwhHNyUSYpA0YGG7MCzR65s2lnFoXFQzT7hRTJGte9JA
         /P5VGHRQSTDLk20jFpQGX5lxWtjfdK4wjVk85OXoS83LnYx/OMVi1T81fdtF9VL/8U6I
         58/A==
X-Gm-Message-State: APjAAAXbYloCwPrgwcHvB+1utJeNYVX3l/JWOPMKaKSXUQ9/fR3biVMG
        kyu9JIbfpiISpXRWNK9QVLr/QfV79HUTRx+x5f0=
X-Google-Smtp-Source: APXvYqwubKqGRO1njuwFqZQUOdNwgQBOAElyxDeGLkv4mm4wk4RuckT0fyzipRUXM8UWy84MuLDtgzJUpQHmGvqJvvk=
X-Received: by 2002:a05:6808:292:: with SMTP id z18mr4138361oic.131.1579638155224;
 Tue, 21 Jan 2020 12:22:35 -0800 (PST)
MIME-Version: 1.0
References: <20200117153056.31363-1-geert+renesas@glider.be>
 <d2b669e7-a5d4-20ec-5b54-103b71df7407@ti.com> <CAMuHMdVzQCWvH-LJ9ME5dRyafudZBHQLaJQzkSCPnughv_q2aA@mail.gmail.com>
 <1cdc4f71-f365-8c9e-4634-408c59e6a3f9@ti.com> <CAMuHMdU=-Eo29=DQmq96OegdYAvW7Vw9PpgNWSTfjDWVF5jd-A@mail.gmail.com>
 <f7bbb132-1278-7030-7f40-b89733bcbd83@ti.com>
In-Reply-To: <f7bbb132-1278-7030-7f40-b89733bcbd83@ti.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 Jan 2020 21:22:23 +0100
Message-ID: <CAMuHMdXDiwTomiKp8Kaw0NvMNpg78-M88F0mNTWBOz5MLE4LtQ@mail.gmail.com>
Subject: Re: [PATCH v2] dmaengine: Create symlinks between DMA channels and slaves
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jan 20, 2020 at 1:06 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On 20/01/2020 12.51, Geert Uytterhoeven wrote:
> > On Mon, Jan 20, 2020 at 11:16 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> >> On 20/01/2020 11.01, Geert Uytterhoeven wrote:
> >>> On Fri, Jan 17, 2020 at 9:08 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> >>>> On 1/17/20 5:30 PM, Geert Uytterhoeven wrote:
> >>>>> Currently it is not easy to find out which DMA channels are in use, and
> >>>>> which slave devices are using which channels.
> >>>>>
> >>>>> Fix this by creating two symlinks between the DMA channel and the actual
> >>>>> slave device when a channel is requested:
> >>>>>   1. A "slave" symlink from DMA channel to slave device,
> >>>>
> >>>> Have you considered similar link name as on the slave device:
> >>>> slave:<name>
> >>>>
> >>>> That way it would be easier to grasp which channel is used for what
> >>>> purpose by only looking under /sys/class/dma/ and no need to check the
> >>>> slave device.
> >>>
> >>> Would this really provide more information?
> >>> The device name is already provided in the target of the symlink:
> >>>
> >>> root@koelsch:~# readlink
> >>> /sys/devices/platform/soc/e6720000.dma-controller/dma/dma1chan2/slave
> >>> ../../../ee140000.sd
> >>
> >> e6720000.dma-controller/dma/dma1chan2/slave -> ../../../ee140000.sd
> >> e6720000.dma-controller/dma/dma1chan3/slave -> ../../../ee140000.sd
> >>
> >> It is hard to tell which one is the tx and RX channel without looking
> >> under the ee140000.sd:
> >>
> >> ee140000.sd/dma:rx -> ../e6720000.dma-controller/dma/dma1chan3
> >> ee140000.sd/dma:tx -> ../e6720000.dma-controller/dma/dma1chan2
> >
> > Oh, you meant the name of the channel, not the name of the device.
> > My mistake.
> >
> > As this name is a property of the slave device, not of the DMA channel,
> > I don't think it belongs under dma*chan*.
>
> Right, but it gives me only half the information I need to be a link useful.
> I know that device X is using two channels but I need to check the
> device X's directory to know which channel is used for what purpose.
>
> >> Another option would be to not have symlinks, but a debugfs file where
> >> this information can be extracted and would only compiled if debugfs is
> >> enabled.
> >
> > Like /proc/interrupts?
>
> More like /sys/kernel/debug/gpio
>
> > That brings the complexity of traversing all channels etc.
>
> Sure, but only when the file is read.
> You can add
> #ifdef CONFIG_DEBUG_FS
> #endif
>
> around the slave_device and name in struct dma_chan {}
>
> and when user reads the file you print out something like this:
> cat /sys/kernel/debug/dmaengine
>
> e6700000.dma-controller:
> dma0chan0               e6e20000.spi:tx
> dma0chan1               e6e20000.spi:rx
> dma0chan2               ee100000.sd:tx
> dma0chan3               ee100000.sd:rx
> ...
> dma0chan14              non slave
> ...
>
> e6720000.dma-controller:
> dma1chan0               e6b10000.spi:tx
> dma1chan1               e6b10000.spi:rx
> ...
>
> This way we will have all the information in one place, easy to look up
> and you don't need to manage symlinks dynamically, just check all
> channels if they have slave_device/name when they are in_use (in_use w/o
> slave_device is 'non slave')
>
> Some drivers are requesting and releasing the DMA channel per transfer
> or when they are opened/closed or other variations.
>
> > What do other people think?

Vinod: do you have some guidance for your minions? ;-)

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
