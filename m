Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5B30142684
	for <lists+dmaengine@lfdr.de>; Mon, 20 Jan 2020 10:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgATJCO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Mon, 20 Jan 2020 04:02:14 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39842 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgATJCN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Jan 2020 04:02:13 -0500
Received: by mail-oi1-f195.google.com with SMTP id z2so3892632oih.6;
        Mon, 20 Jan 2020 01:02:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EDa/ZVNGvwyY4lRA+wxSdtjDm7nJG1InbdRTQhCgYUs=;
        b=IwkMv58ZRHL1ohFY2z4UYBfLxjCUADjseozTDn+Rif1z1QSesm6F463J4/maGZd1/x
         kFzGbBNJ3Qki2iNejZRJeUzhlkLICaUpVST7mKSj6LO2T8bAukwCfMIKtJBMyvOPy19t
         c8jUF2+TfZu83U0IUHY8H1Jp4S8nA5pDlfLvWvtpLrGB57zOFmPwCk0epapK0kq64ud3
         gs452+HseZPll6uiZjV4iCUJWRj206QLUXvePUzsTdC66u0dXc4UU1YKnsHL+S1/HEmx
         uRnM/Bk/J3ePN7/qPxXanz4iJADwMsD/Y+tjUY3wGEaGrhJ4WOwIwFmNhuhwnN8jZYBt
         NXdA==
X-Gm-Message-State: APjAAAVHKvvIabGkeEbIx82yZioMstHHhJaV3pZxtOUxpeiSOVNz2xQk
        kL1I3V8xm0XMDXGO/oC5BP3wKFazzpHe69boqRw=
X-Google-Smtp-Source: APXvYqy2+nlFf8CNQvNrugEXLRUIQO11SX6/COqt7l6vSF13D0b6ZBMZc6d0k+QLUiI4gi0VYO0PziFbmhdmtWhG8GA=
X-Received: by 2002:a05:6808:292:: with SMTP id z18mr11627160oic.131.1579510933130;
 Mon, 20 Jan 2020 01:02:13 -0800 (PST)
MIME-Version: 1.0
References: <20200117153056.31363-1-geert+renesas@glider.be> <d2b669e7-a5d4-20ec-5b54-103b71df7407@ti.com>
In-Reply-To: <d2b669e7-a5d4-20ec-5b54-103b71df7407@ti.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Jan 2020 10:01:51 +0100
Message-ID: <CAMuHMdVzQCWvH-LJ9ME5dRyafudZBHQLaJQzkSCPnughv_q2aA@mail.gmail.com>
Subject: Re: [PATCH v2] dmaengine: Create symlinks between DMA channels and slaves
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
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

Hi Peter,

On Fri, Jan 17, 2020 at 9:08 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On 1/17/20 5:30 PM, Geert Uytterhoeven wrote:
> > Currently it is not easy to find out which DMA channels are in use, and
> > which slave devices are using which channels.
> >
> > Fix this by creating two symlinks between the DMA channel and the actual
> > slave device when a channel is requested:
> >   1. A "slave" symlink from DMA channel to slave device,
>
> Have you considered similar link name as on the slave device:
> slave:<name>
>
> That way it would be easier to grasp which channel is used for what
> purpose by only looking under /sys/class/dma/ and no need to check the
> slave device.

Would this really provide more information?
The device name is already provided in the target of the symlink:

root@koelsch:~# readlink
/sys/devices/platform/soc/e6720000.dma-controller/dma/dma1chan2/slave
../../../ee140000.sd

> >   2. A "dma:<name>" symlink slave device to DMA channel.
> > When the channel is released, the symlinks are removed again.
> > The latter requires keeping track of the slave device and the channel
> > name in the dma_chan structure.
> >
> > Note that this is limited to channel request functions for requesting an
> > exclusive slave channel that take a device pointer (dma_request_chan()
> > and dma_request_slave_channel*()).
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > v2:
> >   - Add DMA_SLAVE_NAME macro,
> >   - Also handle channels from FIXME,
> >   - Add backlinks from slave device to DMA channel,
> >
> > On r8a7791/koelsch, the following new symlinks are created:
> >
> >     /sys/devices/platform/soc/
> >     ├── e6700000.dma-controller/dma/dma0chan0/slave -> ../../../e6e20000.spi
> >     ├── e6700000.dma-controller/dma/dma0chan1/slave -> ../../../e6e20000.spi
> >     ├── e6700000.dma-controller/dma/dma0chan2/slave -> ../../../ee100000.sd
> >     ├── e6700000.dma-controller/dma/dma0chan3/slave -> ../../../ee100000.sd
> >     ├── e6700000.dma-controller/dma/dma0chan4/slave -> ../../../ee160000.sd
> >     ├── e6700000.dma-controller/dma/dma0chan5/slave -> ../../../ee160000.sd
> >     ├── e6700000.dma-controller/dma/dma0chan6/slave -> ../../../e6e68000.serial
> >     ├── e6700000.dma-controller/dma/dma0chan7/slave -> ../../../e6e68000.serial
> >     ├── e6720000.dma-controller/dma/dma1chan0/slave -> ../../../e6b10000.spi
> >     ├── e6720000.dma-controller/dma/dma1chan1/slave -> ../../../e6b10000.spi
> >     ├── e6720000.dma-controller/dma/dma1chan2/slave -> ../../../ee140000.sd
> >     ├── e6720000.dma-controller/dma/dma1chan3/slave -> ../../../ee140000.sd
> >     ├── e6b10000.spi/dma:rx -> ../e6720000.dma-controller/dma/dma1chan1
> >     ├── e6b10000.spi/dma:tx -> ../e6720000.dma-controller/dma/dma1chan0
> >     ├── e6e20000.spi/dma:rx -> ../e6700000.dma-controller/dma/dma0chan1
> >     ├── e6e20000.spi/dma:tx -> ../e6700000.dma-controller/dma/dma0chan0
> >     ├── e6e68000.serial/dma:rx -> ../e6700000.dma-controller/dma/dma0chan7
> >     ├── e6e68000.serial/dma:tx -> ../e6700000.dma-controller/dma/dma0chan6
> >     ├── ee100000.sd/dma:rx -> ../e6700000.dma-controller/dma/dma0chan3
> >     ├── ee100000.sd/dma:tx -> ../e6700000.dma-controller/dma/dma0chan2
> >     ├── ee140000.sd/dma:rx -> ../e6720000.dma-controller/dma/dma1chan3
> >     ├── ee140000.sd/dma:tx -> ../e6720000.dma-controller/dma/dma1chan2
> >     ├── ee160000.sd/dma:rx -> ../e6700000.dma-controller/dma/dma0chan5
> >     └── ee160000.sd/dma:tx -> ../e6700000.dma-controller/dma/dma0chan4


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
