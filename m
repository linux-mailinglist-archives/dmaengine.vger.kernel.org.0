Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA34DF96F
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2019 02:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbfJVAZq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Oct 2019 20:25:46 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34314 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbfJVAZq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Oct 2019 20:25:46 -0400
Received: by mail-oi1-f194.google.com with SMTP id 83so12728481oii.1;
        Mon, 21 Oct 2019 17:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HHE4lXB0Szbo7+fcmURF4oO9/wXTXM/IzD0XxCqkq2g=;
        b=rN/6vj/lEinrxc/Mfeo5mp7SXSN+X/ggrU8JQsZ1J2IfR4gkRQ2crN0/9aVBwnQpYM
         JveRIzKemg2nU/UjuZsa2qPlKG4sUyMWlAVBCeXqPXWBIL6HkRPgFkYbaJ8xs0BxW04l
         NFbI9M1Rat5SLNn0Y4P6JHxScClw3+DrXheEP/PR0hFdCziZ3fadXSRFPi+2r4Q3Ls/D
         4fDZ5niaUkrurgMTGnFb3DoiRZZOl+pcZccODTFYIwLFEUl0zwG6+DtCZmg8/4x1gil1
         lK4SQVdPkmKKkZi1Jmo5HWFUBywLfuaaxWhWhu1B/g9nJEhowZELJQYyOhcLggHwgnRq
         Qqgw==
X-Gm-Message-State: APjAAAWkGvg12eBOXnrYKEBhf7Gf5fpnBO1kH0OsxM5R776EWL8XdGFD
        JY6I11yAFwJ8IB0RzgXyCQDGlLiKUG8=
X-Google-Smtp-Source: APXvYqzMFHO5z7QNMQwFtwrgXunDM5Wl8OJV77bp2QoH2FLxNHWcyp6EfARm/GZBvobc4b7zd/qAfw==
X-Received: by 2002:aca:281a:: with SMTP id 26mr624355oix.130.1571703944859;
        Mon, 21 Oct 2019 17:25:44 -0700 (PDT)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com. [209.85.167.170])
        by smtp.gmail.com with ESMTPSA id m50sm577448otc.80.2019.10.21.17.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 17:25:44 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id d140so8383699oib.5;
        Mon, 21 Oct 2019 17:25:44 -0700 (PDT)
X-Received: by 2002:a54:418c:: with SMTP id 12mr648944oiy.154.1571703943863;
 Mon, 21 Oct 2019 17:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191021022149.37112-1-peng.ma@nxp.com> <VE1PR04MB66879FD43E7E7E8A9C157F5D8F690@VE1PR04MB6687.eurprd04.prod.outlook.com>
In-Reply-To: <VE1PR04MB66879FD43E7E7E8A9C157F5D8F690@VE1PR04MB6687.eurprd04.prod.outlook.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Mon, 21 Oct 2019 19:25:32 -0500
X-Gmail-Original-Message-ID: <CADRPPNQgft3BP+VdwRSH=tmHEsRkPaGj7FTmmE3ZXX+H4uD4kA@mail.gmail.com>
Message-ID: <CADRPPNQgft3BP+VdwRSH=tmHEsRkPaGj7FTmmE3ZXX+H4uD4kA@mail.gmail.com>
Subject: Re: [V2] dmaengine: fsl-edma: Add eDMA support for QorIQ LS1028A platform
To:     Peng Ma <peng.ma@nxp.com>, "vkoul@kernel.org" <vkoul@kernel.org>,
        Robin Gong <yibin.gong@nxp.com>
Cc:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "k.kozlowski.k@gmail.com" <k.kozlowski.k@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Oct 21, 2019 at 4:57 PM Leo Li <leoyang.li@nxp.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Peng Ma <peng.ma@nxp.com>
> > Sent: Sunday, October 20, 2019 9:22 PM
> > To: vkoul@kernel.org
> > Cc: dan.j.williams@intel.com; Leo Li <leoyang.li@nxp.com>;
> > k.kozlowski.k@gmail.com; Fabio Estevam <fabio.estevam@nxp.com>;
> > dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org; Peng Ma
> > <peng.ma@nxp.com>
> > Subject: [V2] dmaengine: fsl-edma: Add eDMA support for QorIQ LS1028A
> > platform
> >
> > Our platforms(such as LS1021A, LS1012A, LS1043A, LS1046A, LS1028A) with
> > below
>
> You only covered QorIQ SoCs, how about the situation for IMX SoCs?
>
> > registers(CHCFG0 - CHCFG15) of eDMA as follows:
> > *-----------------------------------------------------------*
> > |     Offset   |      OTHERS      |           LS1028A     |
> > |--------------|--------------------|-----------------------|
> > |     0x0      |        CHCFG0      |           CHCFG3      |
> > |--------------|--------------------|-----------------------|
> > |     0x1      |        CHCFG1      |           CHCFG2      |
> > |--------------|--------------------|-----------------------|
> > |     0x2      |        CHCFG2      |           CHCFG1      |
> > |--------------|--------------------|-----------------------|
> > |     0x3      |        CHCFG3      |           CHCFG0      |
> > |--------------|--------------------|-----------------------|
> > |     ...      |        ......      |           ......      |
> > |--------------|--------------------|-----------------------|
> > |     0xC      |        CHCFG12     |           CHCFG15     |
> > |--------------|--------------------|-----------------------|
> > |     0xD      |        CHCFG13     |           CHCFG14     |
> > |--------------|--------------------|-----------------------|
> > |     0xE      |        CHCFG14     |           CHCFG13     |
> > |--------------|--------------------|-----------------------|
> > |     0xF      |        CHCFG15     |           CHCFG12     |
> > *-----------------------------------------------------------*
> >
> > This patch is to improve edma driver to fit LS1028A platform.
> >
> > Signed-off-by: Peng Ma <peng.ma@nxp.com>
> > ---
> > Changed for V2:
> >       - Explaining what's the "Our platforms"
> >
> >  drivers/dma/fsl-edma-common.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-
> > common.c index b1a7ca9..611186b 100644
> > --- a/drivers/dma/fsl-edma-common.c
> > +++ b/drivers/dma/fsl-edma-common.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> >  #include <linux/dma-mapping.h>
> > +#include <linux/sys_soc.h>
> >
> >  #include "fsl-edma-common.h"
> >
> > @@ -42,6 +43,11 @@
> >
> >  #define EDMA_TCD             0x1000
> >
> > +static struct soc_device_attribute soc_fixup_tuning[] = {
> > +     { .family = "QorIQ LS1028A"},
> > +     { },
> > +};
> > +
> >  static void fsl_edma_enable_request(struct fsl_edma_chan *fsl_chan)  {
> >       struct edma_regs *regs = &fsl_chan->edma->regs; @@ -109,10
> > +115,16 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
> >       u32 ch = fsl_chan->vchan.chan.chan_id;
> >       void __iomem *muxaddr;
> >       unsigned int chans_per_mux, ch_off;
> > +     int endian_diff[4] = {3, 1, -1, -3};
> >       u32 dmamux_nr = fsl_chan->edma->drvdata->dmamuxs;
> >
> >       chans_per_mux = fsl_chan->edma->n_chans / dmamux_nr;
> >       ch_off = fsl_chan->vchan.chan.chan_id % chans_per_mux;
> > +
> > +     if (!fsl_chan->edma->big_endian &&
> > +         soc_device_match(soc_fixup_tuning))
> > +             ch_off += endian_diff[ch_off % 4];
> > +
>
> This probably is not the best fix now.  There is a new mux_configure32() API added but it doesn't consider endianness.  How about making it properly taken care of endianness?  And use it to set these registers?

You can ignore this comment.  The mux_configure32() seems to deal with
a different register layout(32-bit register per CH).

Considering the register per channel is defined as 8-bit in the
reference manual, the hardware seems to be weird to require
byte-swapping as if the register is 32-bit.  Probably you can rename
soc_fixup_tuning something like mux_byte_swap_quirk.

>
> >       muxaddr = fsl_chan->edma->muxbase[ch / chans_per_mux];
> >       slot = EDMAMUX_CHCFG_SOURCE(slot);
> >
> > --
> > 2.9.5
>
