Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7349F142884
	for <lists+dmaengine@lfdr.de>; Mon, 20 Jan 2020 11:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgATKvO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Jan 2020 05:51:14 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45939 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgATKvN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Jan 2020 05:51:13 -0500
Received: by mail-oi1-f194.google.com with SMTP id n16so28120739oie.12;
        Mon, 20 Jan 2020 02:51:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uvHX7RkeGS1j3292t6lYP6xOMynSovwccmbxVM2lgsw=;
        b=YJJeXw6ae7qgYqMitzMkrRdQUq6678B5XnQgKb/ZREeHQabqsvViNGCVCe2Cd0CbpB
         vkUIlB+o+Ah+Vnrfrrakp/bsJodJD1YrNYwnReGQdoPXOdPPT5KiedYaLeMZuwx635Fn
         c/Q/oZBsRrSa6WL3Jho1o/gy4/zL/4x44ZX+xKDbLvzpbmtSmYK5lDK/Do3KHPJUPBaH
         yqZLHU63OMyjYkowR16M1/7Gcbwpv8AetwMJ0qJTKO31q/V9UIzkj/Z4d1FpOCs6Kr4s
         IcBa+txrrmu71Sd56llLT4wFOha9QSJ5LxFi7n68nPXGU/08d7XGgu/6HPpmO3BKM2xa
         99HQ==
X-Gm-Message-State: APjAAAWZnXldiqx7hro8oaOENIw2xL1oxzn+8D7uaheiPVjrbeIlKKKo
        F3iKCXXezOagHsj7RK3fHGyTX5gJ2YzE8+BMUeo=
X-Google-Smtp-Source: APXvYqyKxm5Fxmfn34wBVirSiayi+wKFT6KoBe9Fd0oC618a+sBxaaTmyWk2Wq5mWaKcGGVoGFHx5+VXEDE0rH0qqjw=
X-Received: by 2002:a05:6808:292:: with SMTP id z18mr11864654oic.131.1579517473071;
 Mon, 20 Jan 2020 02:51:13 -0800 (PST)
MIME-Version: 1.0
References: <20200117153056.31363-1-geert+renesas@glider.be>
 <d2b669e7-a5d4-20ec-5b54-103b71df7407@ti.com> <CAMuHMdVzQCWvH-LJ9ME5dRyafudZBHQLaJQzkSCPnughv_q2aA@mail.gmail.com>
 <1cdc4f71-f365-8c9e-4634-408c59e6a3f9@ti.com>
In-Reply-To: <1cdc4f71-f365-8c9e-4634-408c59e6a3f9@ti.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Jan 2020 11:51:01 +0100
Message-ID: <CAMuHMdU=-Eo29=DQmq96OegdYAvW7Vw9PpgNWSTfjDWVF5jd-A@mail.gmail.com>
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

Hi Peter,

On Mon, Jan 20, 2020 at 11:16 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On 20/01/2020 11.01, Geert Uytterhoeven wrote:
> > On Fri, Jan 17, 2020 at 9:08 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> >> On 1/17/20 5:30 PM, Geert Uytterhoeven wrote:
> >>> Currently it is not easy to find out which DMA channels are in use, and
> >>> which slave devices are using which channels.
> >>>
> >>> Fix this by creating two symlinks between the DMA channel and the actual
> >>> slave device when a channel is requested:
> >>>   1. A "slave" symlink from DMA channel to slave device,
> >>
> >> Have you considered similar link name as on the slave device:
> >> slave:<name>
> >>
> >> That way it would be easier to grasp which channel is used for what
> >> purpose by only looking under /sys/class/dma/ and no need to check the
> >> slave device.
> >
> > Would this really provide more information?
> > The device name is already provided in the target of the symlink:
> >
> > root@koelsch:~# readlink
> > /sys/devices/platform/soc/e6720000.dma-controller/dma/dma1chan2/slave
> > ../../../ee140000.sd
>
> e6720000.dma-controller/dma/dma1chan2/slave -> ../../../ee140000.sd
> e6720000.dma-controller/dma/dma1chan3/slave -> ../../../ee140000.sd
>
> It is hard to tell which one is the tx and RX channel without looking
> under the ee140000.sd:
>
> ee140000.sd/dma:rx -> ../e6720000.dma-controller/dma/dma1chan3
> ee140000.sd/dma:tx -> ../e6720000.dma-controller/dma/dma1chan2

Oh, you meant the name of the channel, not the name of the device.
My mistake.

As this name is a property of the slave device, not of the DMA channel,
I don't think it belongs under dma*chan*.

> Another option would be to not have symlinks, but a debugfs file where
> this information can be extracted and would only compiled if debugfs is
> enabled.

Like /proc/interrupts?
That brings the complexity of traversing all channels etc.

What do other people think?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
