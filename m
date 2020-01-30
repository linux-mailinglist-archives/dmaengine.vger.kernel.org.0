Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40AC814D93B
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 11:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgA3KrU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Thu, 30 Jan 2020 05:47:20 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44305 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgA3KrU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jan 2020 05:47:20 -0500
Received: by mail-oi1-f193.google.com with SMTP id d62so2990447oia.11;
        Thu, 30 Jan 2020 02:47:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bPds3H999b4sbHrI2xdAWDEqcLze26VG68J4dxk2Yzk=;
        b=hMJEGbqCGoXqKSMm7XRaHGmbjlgrwgA35iGbJ6tjlpXkjSz9HM5pUHHn8ZIiiHeeLe
         2Lnhbyqpw+Kb4JkIdM0qHToDd85qVJ74mIho77RoWzEXha+ZabgI7sQ+ZQZGD9ueR0dc
         o9k+GGWM5kOd9qDV/fH92l9MF0QHEmejEGBcJCcszmMeZh80CQTVDt9jtjgbS8QYY3or
         RkfExkDASbxI10MM3qf4Z+Q+HK7c/BuegdFSB87HbsNB4nP1XQXxtexFG1AZ5CEZiYFH
         cIPlB6BSsVlvTHd8O5zJ5GS0wHqQDSTsFim6TYB318kTYV8LiE3Zm8JDFjYd9iWH4gF2
         ZtIQ==
X-Gm-Message-State: APjAAAW2hfsMAlsVDdNYmMVVWbSgEEe4z3wQ0PKacILSF//G5ty5OCMB
        NtfdQXhJaCY7uehkiwAXKNzW55U/KWzJYh6KNEY=
X-Google-Smtp-Source: APXvYqxIIIUZohrSHPenmUgXJVSQveonFR4aBuAgIfsx5KeWWKf4XoO8s9HK9UDm6Zq9rBqeQiGzkmicCj+rhBlMZPs=
X-Received: by 2002:aca:48cd:: with SMTP id v196mr2530305oia.102.1580381238139;
 Thu, 30 Jan 2020 02:47:18 -0800 (PST)
MIME-Version: 1.0
References: <CGME20200129174723eucas1p1fe4f76325f463fc9e3645ce18740d2eb@eucas1p1.samsung.com>
 <20200117153056.31363-1-geert+renesas@glider.be> <fde812a2-aea6-c16e-5ed7-ab5195b1259f@samsung.com>
 <CAMuHMdXds2HuBAnLXmLVaCWKX77iZGvNSnD35-ysY9AnG9TKMw@mail.gmail.com> <ab83c4e0-87d2-c60e-afa7-4549ffb15397@samsung.com>
In-Reply-To: <ab83c4e0-87d2-c60e-afa7-4549ffb15397@samsung.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Jan 2020 11:47:06 +0100
Message-ID: <CAMuHMdV3iCgcOxNnjEaAW-E=OzyWfnFJppS5pPoGD6O6h6kcfg@mail.gmail.com>
Subject: Re: [PATCH v2] dmaengine: Create symlinks between DMA channels and slaves
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Marek,

On Thu, Jan 30, 2020 at 11:33 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> On 30.01.2020 09:30, Geert Uytterhoeven wrote:
> > On Wed, Jan 29, 2020 at 6:47 PM Marek Szyprowski
> > <m.szyprowski@samsung.com> wrote:
> >> On 17.01.2020 16:30, Geert Uytterhoeven wrote:
> >>> Currently it is not easy to find out which DMA channels are in use, and
> >>> which slave devices are using which channels.
> >>>
> >>> Fix this by creating two symlinks between the DMA channel and the actual
> >>> slave device when a channel is requested:
> >>>     1. A "slave" symlink from DMA channel to slave device,
> >>>     2. A "dma:<name>" symlink slave device to DMA channel.
> >>> When the channel is released, the symlinks are removed again.
> >>> The latter requires keeping track of the slave device and the channel
> >>> name in the dma_chan structure.
> >>>
> >>> Note that this is limited to channel request functions for requesting an
> >>> exclusive slave channel that take a device pointer (dma_request_chan()
> >>> and dma_request_slave_channel*()).
> >>>
> >>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >>> Tested-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>
> >> This patch breaks booting on almost all Exynos based boards:
> >>
> >> https://lore.kernel.org/linux-samsung-soc/20200129161113.GE3928@sirena.org.uk/T/#u
> > Sorry for the breakage.
>
> No problem, that's why we have linux-next.

Not really: by that time it had been upstream for 2 days :-(

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
