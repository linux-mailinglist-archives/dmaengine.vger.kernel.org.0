Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3332524EF
	for <lists+dmaengine@lfdr.de>; Wed, 26 Aug 2020 03:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgHZBLn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 21:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgHZBLl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Aug 2020 21:11:41 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08525C061574
        for <dmaengine@vger.kernel.org>; Tue, 25 Aug 2020 18:11:41 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id n23so191266otq.11
        for <dmaengine@vger.kernel.org>; Tue, 25 Aug 2020 18:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KlAlC0zWlvlcip1yPeOIjVGEV2NwRo1ZMC1lvDQyYTo=;
        b=AULby94oUcfqeriwlTiz1Yx4ajB/Df33m3gqCmjDG44yekGGE+RhVbuP6CB4NaBWqd
         +I8SdhylH7tXdjtWXAfBLp1bA0WL2vXPuHh4MWHXXbrxXyw5itUU8/vi4YTbRCx9zg3z
         ney8MdhHVtiWGhxJeYh/xPmyi5dLTGVmHIflzhzEtyElXZQSmxejzj96rmZ1u3k3B92n
         pTdupKoLLOsDyF4AXUDlXL6aj0600uT+N7lTWVmmGtuMd0QLmZ3P4etnqADhWEWUAOD0
         vX4LBqSFZagZfR6Fhy07rRUXZshmRKlPW5jZ87JVVuo22uCibrvetk+rRE9nAnhBBPcg
         YWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KlAlC0zWlvlcip1yPeOIjVGEV2NwRo1ZMC1lvDQyYTo=;
        b=TFeiZM1kmHn88v2LujkIw2lHKs6F7SjzbOnwDkKoEdR2oz1T4WgesRY25QHxm0txAX
         n/3JHXwD0QSp2d+O05eyA1uE9EuzgyCQ0RatA8KqMbNrBAoMrR0ptgsWXZlJMhABrFmd
         kiB+sHMnmfbsg55XR9qMJBKMSLjWeoXAVfM54w1qayZgwWCOuQjvzQfpxuWZeIh28cmy
         uwr7OBVll86L9OxUHOkuq3dNc783MC5IxJUcuzgedmcW0Rty/cyDRMCIh4dc1i0geGw4
         xqV76chADyOsKiKKpmqF+dEprMetPKQhGHbwCuDcIhbUkqT1VN+Cztm/xYw1qNcWEG0O
         I3ew==
X-Gm-Message-State: AOAM531YYxGHn/3YUmaBaIBfYTif1prpV69aS+VuIzAbJBQfsofW0SvX
        v8WTQ0TEvZ9cpvTyLqJt9KwoFEQoPVbFPSfQ7hI=
X-Google-Smtp-Source: ABdhPJzN2sDV1aZG82JvEUNpf9sb8BHW2vA4Xv0eS3E8svhrElq99l9p4ZOTyMU/8YRj94VXbezAeRlDJEe3+BkxQ38=
X-Received: by 2002:a05:6830:15d0:: with SMTP id j16mr6253266otr.242.1598404300210;
 Tue, 25 Aug 2020 18:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200818090638.26362-1-allen.lkml@gmail.com> <20200825110331.GG2639@vkoul-mobl>
In-Reply-To: <20200825110331.GG2639@vkoul-mobl>
From:   Allen <allen.lkml@gmail.com>
Date:   Wed, 26 Aug 2020 06:41:28 +0530
Message-ID: <CAOMdWSKvj9Bwt_JpJ072c-LYKRO4aA+vEPyJLZSYgMvuXhTBmQ@mail.gmail.com>
Subject: Re: [PATCH 00/35] dma: convert tasklets to use new tasklet_setup()
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org,
        dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Vinod,

> > Commit 12cc923f1ccc ("tasklet: Introduce new initialization API")'
> > introduced a new tasklet initialization API. This series converts
> > all the dma drivers to use the new tasklet_setup() API
> >
> > This is based on 5.9-rc1.
> >
> > Please pick this series, as I missed updating a couple of fixes and marking
> > the correct mailing list.
>
> The patches should have been tagged "dmaengine: ...".

 My bad, Will have it fixed.

>
> What is the status of this API conversion, I think I saw some
> discussions on API change, what is the conclusion?

 Yes, the updated API should land into Linus's tree shortly.
Will send out V2 with the new API soon.

Thanks.

> Thanks
>
> >
> > Allen Pais (35):
> >   dma: altera-msgdma: convert tasklets to use new tasklet_setup() API
> >   dma: at_hdmac: convert tasklets to use new tasklet_setup() API
> >   dma: at_xdmac: convert tasklets to use new tasklet_setup() API
> >   dma: coh901318: convert tasklets to use new tasklet_setup() API
> >   dma: dw: convert tasklets to use new tasklet_setup() API
> >   dma: ep93xx: convert tasklets to use new tasklet_setup() API
> >   dma: fsl: convert tasklets to use new tasklet_setup() API
> >   dma: imx-dma: convert tasklets to use new tasklet_setup() API
> >   dma: ioat: convert tasklets to use new tasklet_setup() API
> >   dma: iop_adma: convert tasklets to use new tasklet_setup() API
> >   dma: ipu: convert tasklets to use new tasklet_setup() API
> >   dma: k3dma: convert tasklets to use new tasklet_setup() API
> >   dma: mediatek: convert tasklets to use new tasklet_setup() API
> >   dma: mmp: convert tasklets to use new tasklet_setup() API
> >   dma: mpc512x: convert tasklets to use new tasklet_setup() API
> >   dma: mv_xor: convert tasklets to use new tasklet_setup() API
> >   dma: mxs-dma: convert tasklets to use new tasklet_setup() API
> >   dma: nbpfaxi: convert tasklets to use new tasklet_setup() API
> >   dma: pch_dma: convert tasklets to use new tasklet_setup() API
> >   dma: pl330: convert tasklets to use new tasklet_setup() API
> >   dma: ppc4xx: convert tasklets to use new tasklet_setup() API
> >   dma: qcom: convert tasklets to use new tasklet_setup() API
> >   dma: sa11x0: convert tasklets to use new tasklet_setup() API
> >   dma: sirf-dma: convert tasklets to use new tasklet_setup() API
> >   dma: ste_dma40: convert tasklets to use new tasklet_setup() API
> >   dma: sun6i: convert tasklets to use new tasklet_setup() API
> >   dma: tegra20: convert tasklets to use new tasklet_setup() API
> >   dma: timb_dma: convert tasklets to use new tasklet_setup() API
> >   dma: txx9dmac: convert tasklets to use new tasklet_setup() API
> >   dma: virt-dma: convert tasklets to use new tasklet_setup() API
> >   dma: xgene: convert tasklets to use new tasklet_setup() API
> >   dma: xilinx: convert tasklets to use new tasklet_setup() API
> >   dma: plx_dma: convert tasklets to use new tasklet_setup() API
> >   dma: sf-pdma: convert tasklets to use new tasklet_setup() API
> >   dma: k3-udma: convert tasklets to use new tasklet_setup() API
> >
> >  drivers/dma/altera-msgdma.c      |  6 +++---
> >  drivers/dma/at_hdmac.c           |  7 +++----
> >  drivers/dma/at_xdmac.c           |  7 +++----
> >  drivers/dma/coh901318.c          |  7 +++----
> >  drivers/dma/dw/core.c            |  6 +++---
> >  drivers/dma/ep93xx_dma.c         |  7 +++----
> >  drivers/dma/fsl_raid.c           |  6 +++---
> >  drivers/dma/fsldma.c             |  6 +++---
> >  drivers/dma/imx-dma.c            |  7 +++----
> >  drivers/dma/ioat/dma.c           |  6 +++---
> >  drivers/dma/ioat/dma.h           |  2 +-
> >  drivers/dma/ioat/init.c          |  4 +---
> >  drivers/dma/iop-adma.c           |  8 ++++----
> >  drivers/dma/ipu/ipu_idmac.c      |  6 +++---
> >  drivers/dma/k3dma.c              |  6 +++---
> >  drivers/dma/mediatek/mtk-cqdma.c |  7 +++----
> >  drivers/dma/mmp_pdma.c           |  6 +++---
> >  drivers/dma/mmp_tdma.c           |  6 +++---
> >  drivers/dma/mpc512x_dma.c        |  6 +++---
> >  drivers/dma/mv_xor.c             |  7 +++----
> >  drivers/dma/mv_xor_v2.c          |  8 ++++----
> >  drivers/dma/mxs-dma.c            |  7 +++----
> >  drivers/dma/nbpfaxi.c            |  6 +++---
> >  drivers/dma/pch_dma.c            |  7 +++----
> >  drivers/dma/pl330.c              | 12 ++++++------
> >  drivers/dma/plx_dma.c            |  7 +++----
> >  drivers/dma/ppc4xx/adma.c        |  7 +++----
> >  drivers/dma/qcom/bam_dma.c       |  6 +++---
> >  drivers/dma/qcom/hidma.c         |  6 +++---
> >  drivers/dma/qcom/hidma_ll.c      |  6 +++---
> >  drivers/dma/sa11x0-dma.c         |  6 +++---
> >  drivers/dma/sf-pdma/sf-pdma.c    | 14 ++++++--------
> >  drivers/dma/sirf-dma.c           |  6 +++---
> >  drivers/dma/ste_dma40.c          |  7 +++----
> >  drivers/dma/sun6i-dma.c          |  6 +++---
> >  drivers/dma/tegra20-apb-dma.c    |  7 +++----
> >  drivers/dma/ti/k3-udma.c         |  7 +++----
> >  drivers/dma/timb_dma.c           |  6 +++---
> >  drivers/dma/txx9dmac.c           | 14 ++++++--------
> >  drivers/dma/virt-dma.c           |  6 +++---
> >  drivers/dma/xgene-dma.c          |  7 +++----
> >  drivers/dma/xilinx/xilinx_dma.c  |  7 +++----
> >  drivers/dma/xilinx/zynqmp_dma.c  |  6 +++---
> >  43 files changed, 136 insertions(+), 158 deletions(-)
> >
> > --
> > 2.17.1
>
> --
> ~Vinod



-- 
       - Allen
