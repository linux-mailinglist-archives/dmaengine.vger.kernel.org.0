Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2891959F8
	for <lists+dmaengine@lfdr.de>; Fri, 27 Mar 2020 16:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgC0Pfc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Mar 2020 11:35:32 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:36500 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgC0Pfc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 27 Mar 2020 11:35:32 -0400
Received: by mail-vk1-f196.google.com with SMTP id m131so2787039vkh.3
        for <dmaengine@vger.kernel.org>; Fri, 27 Mar 2020 08:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O9dJ6ogh71Pb5Yhc0YsPgqXvzYYmHlI805Hcr0oRvnk=;
        b=WQmCcaJLCjH+Y/bk6cBwlM3vi2NSt+Eo1g09Ot+7fbNbJKYqBw6CjniZE7QcITNlPu
         Bs6dlOdjHVOANKB+yfblfYscMNRyrifpLf0MH5dVuzCVI8MgPcxBQabIUqL1fBCk58TR
         kpqgBgkEVlBTLhMSzoEnc6cL2KLN09JjGoH+mTCFxuuJa9ao12aXGjekqKJ6cSvs1jxV
         VlEPO1mWVkD5bC6h6kwp/4C81u+OAZV1FZ8ZyGcbGGR6C9R7QNVmLGqPX7RE2R9Aq/SW
         hGtXbdg6xyAJG9dDQrhv+GgzTS1QEYGxtrkzL02rWrEp85aIUjM3G5M6M8eDaJ1noWbc
         AL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O9dJ6ogh71Pb5Yhc0YsPgqXvzYYmHlI805Hcr0oRvnk=;
        b=YZvQsNKlBAaisRZynD1CYDjDGM3qOf/zdt99pDMSFBRkWQFgC1mbrE2gKsaVt20De1
         3wIxm/YDWo2ZCnNiefzk1oYdLNalfdcimiiOGN/Gw2O4Lx/fngVBiAlxdkWluirvF4B5
         HKe70wPlwqzjl47RqOmDhdg3OLk6mARV6ia6nSId3bJrZ50My9wqe0RCMszthiULdTLn
         O3HcSxKLQ/7LtYSiuw1FpcPWWO8nxGK+Des0k0qa/SwPo47lUF6uqHnvHtRJZUH7WJCH
         deJoyXpw2RMNYkqGCP6sEju5wrPDz7TLvPsWAQZsHcB+/XRrc0gnqaZQP1E3pIcVrnUA
         bC3A==
X-Gm-Message-State: ANhLgQ305HRphZ4PWgOLT92WHO+gSXmTcRUPmBR8pYmTWCFxFzx0rhNF
        ygYyRCFXci6u+izQ/P3NksY+t3noTToPBKUkQbZrew==
X-Google-Smtp-Source: ADFU+vtKz15viEUk4xOXDGYZGMYE5SXgcDqR/iXSCAChXlh2gnOavOfVTolvTnJ/rkcoYXRFryMu5lJ34uXAd7dKr3Q=
X-Received: by 2002:a1f:2947:: with SMTP id p68mr11663597vkp.43.1585323330353;
 Fri, 27 Mar 2020 08:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200325113407.26996-1-ulf.hansson@linaro.org>
 <VI1PR04MB504097B40CE0B804FA60D67A90CF0@VI1PR04MB5040.eurprd04.prod.outlook.com>
 <VI1PR04MB5040FFADA4F780422E208AC390CC0@VI1PR04MB5040.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB5040FFADA4F780422E208AC390CC0@VI1PR04MB5040.eurprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 27 Mar 2020 16:34:53 +0100
Message-ID: <CAPDyKFr_yOmZ2MMvp=1krHejCRDRfhC0B+1icYR5xuZfhKy_ag@mail.gmail.com>
Subject: Re: [PATCH 0/2] amba/platform: Initialize dma_parms at the bus level
To:     BOUGH CHEN <haibo.chen@nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, 27 Mar 2020 at 04:02, BOUGH CHEN <haibo.chen@nxp.com> wrote:
>
>
> > -----Original Message-----
> > From: BOUGH CHEN
> > Sent: 2020=E5=B9=B43=E6=9C=8826=E6=97=A5 12:41
> > To: Ulf Hansson <ulf.hansson@linaro.org>; Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org>; Rafael J . Wysocki <rafael@kernel.org>;
> > linux-kernel@vger.kernel.org
> > Cc: Arnd Bergmann <arnd@arndb.de>; Christoph Hellwig <hch@lst.de>;
> > Russell King <linux@armlinux.org.uk>; Linus Walleij <linus.walleij@lina=
ro.org>;
> > Vinod Koul <vkoul@kernel.org>; Ludovic Barre <ludovic.barre@st.com>;
> > linux-arm-kernel@lists.infradead.org; dmaengine@vger.kernel.org
> > Subject: RE: [PATCH 0/2] amba/platform: Initialize dma_parms at the bus=
 level
> >
> > > -----Original Message-----
> > > From: Ulf Hansson <ulf.hansson@linaro.org>
> > > Sent: 2020=E5=B9=B43=E6=9C=8825=E6=97=A5 19:34
> > > To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Rafael J .
> > > Wysocki <rafael@kernel.org>; linux-kernel@vger.kernel.org
> > > Cc: Arnd Bergmann <arnd@arndb.de>; Christoph Hellwig <hch@lst.de>;
> > > Russell King <linux@armlinux.org.uk>; Linus Walleij
> > > <linus.walleij@linaro.org>; Vinod Koul <vkoul@kernel.org>; BOUGH CHEN
> > > <haibo.chen@nxp.com>; Ludovic Barre <ludovic.barre@st.com>;
> > > linux-arm-kernel@lists.infradead.org; dmaengine@vger.kernel.org; Ulf
> > > Hansson <ulf.hansson@linaro.org>
> > > Subject: [PATCH 0/2] amba/platform: Initialize dma_parms at the bus
> > > level
> > >
> > > It's currently the amba/platform driver's responsibility to initializ=
e
> > > the pointer, dma_parms, for its corresponding struct device. The
> > > benefit with this approach allows us to avoid the initialization and
> > > to not waste memory for the struct device_dma_parameters, as this can
> > > be decided on a case by case basis.
> > >
> > > However, it has turned out that this approach is not very practical.
> > > Not only does it lead to open coding, but also to real errors. In
> > > principle callers of
> > > dma_set_max_seg_size() doesn't check the error code, but just assumes
> > > it succeeds.
> > >
> > > For these reasons, this series initializes the dma_parms from the
> > > amba/platform bus at the device registration point. This also follows
> > > the way the PCI devices are being managed, see pci_device_add().
> > >
> > > If it turns out that this is an acceptable solution, we probably also
> > > want the changes for stable, but I am not sure if it applies without =
conflicts.
> > >
> > > The series is based on v5.6-rc7.
> > >
> >
> > Hi Ulf,
> >
> > Since i.MXQM SMMU related code still not upstream yet, so I apply your
> > patches on our internal Linux branch based on v5.4.24, and find it do n=
ot work
> > on my side. Maybe for platform core drivers, there is a gap between v5.=
4.24
> > and v5.6-rc7 which has the impact.
> > I will try to put our SMMU related code into v5.6-rc7, then do the test=
 again.
> >
> >
>
> Hi Ulf,
>
> On the latest Linux-next branch, the top commit 89295c59c1f063b533d071ca4=
9d0fa0c0783ca6f (tag: next-20200326), after add your two patches, I just ad=
d the simple debug code as following in the /driver/mmc/core/queue.c, but s=
eems still not work as our expect, logically, it should work, so can you or=
 anyone test on other platform? This seems weird.

You are right, this doesn't work for platform devices being added
through the OF path.

In other words, of_platform_device_create_pdata() manually allocates
the platform device and assigns it the &platform_bus_type, but without
calling platform_device_add().

For amba, it works fine, as in that OF path, amba_device_add() is called. H=
mm.

I re-spin this, to address the problem. Perhaps we simply need to use
the ->probe() path.

Kind regards
Uffe

>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 25bee3daf9e2..f091280f7ffb 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -403,6 +403,13 @@ static void mmc_setup_queue(struct mmc_queue *mq, st=
ruct mmc_card *card)
>                 blk_queue_max_segment_size(mq->queue,
>                         round_down(host->max_seg_size, block_size));
>
> +       pr_err("###### the max segment size is %d\n", queue_max_segment_s=
ize(mq->queue));
> +       if (host->parent->dma_parms) {
> +                      pr_err("######### the dma parms has value\n");
> +       } else if (!(host->parent->dma_parms)) {
> +                      pr_err("######## the dma parms is zero!!\n");
> +       }
> +
>         dma_set_max_seg_size(mmc_dev(host), queue_max_segment_size(mq->qu=
eue));
>
>         INIT_WORK(&mq->recovery_work, mmc_mq_recovery_handler);
>
> Here is the log I got when system run, even after your patch, the dev->dm=
a_parms is still NULL.
> [    0.989853] mmc0: new HS400 MMC card at address 0001
> [    0.995708] sdhci-esdhc-imx 30b50000.mmc: Got CD GPIO
> [    0.999374] ###### the max segment size is 65024
> [    1.008594] ######## the dma parms is zero!!
> [    1.012875] mmcblk0: mmc0:0001 IB2932 29.2 GiB
> [    1.017569] ###### the max segment size is 65024
> [    1.022195] ######## the dma parms is zero!!
> [    1.026479] mmcblk0boot0: mmc0:0001 IB2932 partition 1 4.00 MiB
> [    1.032541] ###### the max segment size is 65024
> [    1.035198] mmc1: SDHCI controller on 30b50000.mmc [30b50000.mmc] usin=
g ADMA
> [    1.037169] ######## the dma parms is zero!!
> [    1.048493] mmcblk0boot1: mmc0:0001 IB2932 partition 2 4.00 MiB
> [    1.054531] mmcblk0rpmb: mmc0:0001 IB2932 partition 3 4.00 MiB, charde=
v (234:0)
>
>
> Regards
> Haibo Chen
> > Best Regards
> > Haibo Chen
> >
> > > Kind regards
> > > Ulf Hansson
> > >
> > > Ulf Hansson (2):
> > >   driver core: platform: Initialize dma_parms for platform devices
> > >   amba: Initialize dma_parms for amba devices
> > >
> > >  drivers/amba/bus.c              | 2 ++
> > >  drivers/base/platform.c         | 1 +
> > >  include/linux/amba/bus.h        | 1 +
> > >  include/linux/platform_device.h | 1 +
> > >  4 files changed, 5 insertions(+)
> > >
> > > --
> > > 2.20.1
>
