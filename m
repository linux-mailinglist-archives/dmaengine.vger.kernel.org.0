Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5792614D78D
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 09:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgA3Iax convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Thu, 30 Jan 2020 03:30:53 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40323 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbgA3Iaw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jan 2020 03:30:52 -0500
Received: by mail-oi1-f194.google.com with SMTP id a142so2696378oii.7;
        Thu, 30 Jan 2020 00:30:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HFTK0wLPJ+srAEMsmW9EKJT73bxP4s92jNe0BbzHj1g=;
        b=CR93tJ3WcpSPgIxergpCOlxP5AIPboPtJy4YA1T/L+bQZ7kd4Tl2KheszhxN2aN05K
         iUkRHFiq/QW0HOh/oOZEN5wSVIllPTQDUY6iZmxf5vM7YSZ7WszMKFTkpos30mBdlsib
         Q0BtuVATIFvr6NkUSurPUn5VPBTMmbs/jG9U0DQDmbmZ+qTyIYlB70HOYNLSwGpOVXtg
         FQ6hWlKM0Vi/FHjGkkUSAjOfgnxEbEYEXeRkhzyWHX3zDcGz7ojiqba9NnJqOMbjt8ST
         l21i73rsPYJXF10CIO+raLyR28FsX7fFRq1VXHqgLcNZHAlh4Vac+9TGapzX2KfjUL6d
         6J+A==
X-Gm-Message-State: APjAAAXacx5q0kYcrNP3nSV94HtGtUpVry4gL/XSxc+DZYmSKZW7soUZ
        bZlcF4Hr44MKojv5KKHPC12LfYGjMpPaGEiqa84=
X-Google-Smtp-Source: APXvYqwdBg3qw8VeW5AasrBWdbzZwZ65QZDik+thkFtTX1iARiC/7M8S0iGAXnwKuQ9SN1mrRsJB2TwXIC6DBGV06FA=
X-Received: by 2002:aca:5905:: with SMTP id n5mr2177710oib.54.1580373051929;
 Thu, 30 Jan 2020 00:30:51 -0800 (PST)
MIME-Version: 1.0
References: <CGME20200129174723eucas1p1fe4f76325f463fc9e3645ce18740d2eb@eucas1p1.samsung.com>
 <20200117153056.31363-1-geert+renesas@glider.be> <fde812a2-aea6-c16e-5ed7-ab5195b1259f@samsung.com>
In-Reply-To: <fde812a2-aea6-c16e-5ed7-ab5195b1259f@samsung.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Jan 2020 09:30:38 +0100
Message-ID: <CAMuHMdXds2HuBAnLXmLVaCWKX77iZGvNSnD35-ysY9AnG9TKMw@mail.gmail.com>
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

On Wed, Jan 29, 2020 at 6:47 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> On 17.01.2020 16:30, Geert Uytterhoeven wrote:
> > Currently it is not easy to find out which DMA channels are in use, and
> > which slave devices are using which channels.
> >
> > Fix this by creating two symlinks between the DMA channel and the actual
> > slave device when a channel is requested:
> >    1. A "slave" symlink from DMA channel to slave device,
> >    2. A "dma:<name>" symlink slave device to DMA channel.
> > When the channel is released, the symlinks are removed again.
> > The latter requires keeping track of the slave device and the channel
> > name in the dma_chan structure.
> >
> > Note that this is limited to channel request functions for requesting an
> > exclusive slave channel that take a device pointer (dma_request_chan()
> > and dma_request_slave_channel*()).
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Tested-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>
>
> This patch breaks booting on almost all Exynos based boards:
>
> https://lore.kernel.org/linux-samsung-soc/20200129161113.GE3928@sirena.org.uk/T/#u

Sorry for the breakage.

> I've already sent a fix:
>
> https://lkml.org/lkml/2020/1/29/498

Thanks a lot!

> BTW, this patch reminds me some of my earlier work:
>
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1329778.html
>
> I had similar need to keep a client's struct device pointer for every
> requested channel, but it turned out to be much more complicated than
> I've initially thought. I've abandoned that, due to lack of time, but
> maybe some of that discussion and concerns are still valid (I hope that
> links to earlier versions are still working)...

Oh right, Runtime PM for DMA channels.

As several DMA calls can be made from atomic context, probably the API
should be split in a non-atomic and an atomic part, cfr. the difference
between clk_prepare() and clk_enable().  Still, DMA slave drivers would need
to be modified, to call the "prepare" to make use of this...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
