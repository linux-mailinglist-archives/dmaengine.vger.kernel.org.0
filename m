Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DDA6DE191
	for <lists+dmaengine@lfdr.de>; Tue, 11 Apr 2023 18:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjDKQyW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Apr 2023 12:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjDKQyH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Apr 2023 12:54:07 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB04C6A49;
        Tue, 11 Apr 2023 09:53:47 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id e11so11201196lfc.10;
        Tue, 11 Apr 2023 09:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681232025; x=1683824025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xd7blxMbuV2pJWL/mke8wN3aR4SPVzbVIhErjMmhThE=;
        b=Mse7hpUAFYh1mmLVeFVNGGgUKWENpRQi15LBiUwAIWPQG/ddIcXgnC5JhbuhewmddO
         aPSs5jhlaUxthfiR84vIiwUHnVOnYwTFWjPyNhKLUCPVlcg8vTTnd1uhDEM3fmGiqzpV
         lsmt6uBDOGP07BGLosVAM3CtnHs/tBLoR2plDTE71YBNRVcoFKaOZIf5QHxaDqxGGtRx
         aVPvp+2VDFObEiJwXd0Lt69+PuVt2Uiv3MfwgZLCec23pQV79GSmRGPiiFFzzwS2jEbG
         mwmkZegb7/0I8hQnuWBloJAJY99+CA/nT9dKGslbeRbs0f8IJfxESV7zbYY4BwDnuvbw
         regA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681232025; x=1683824025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xd7blxMbuV2pJWL/mke8wN3aR4SPVzbVIhErjMmhThE=;
        b=SoRWwCP+OdUKr2s70CTEFcG2AHSy9zy6834ySfz5qKMsPO+d+OHOwRM5pBkR2P5Ox+
         P7TpzWcAB4LZXW5KjFXh7t1mzEYRjDuBc4QwNmPN5VePMuhYdNCykqsMp1kCKanjrgzD
         dhqAj45iO0bCrDuhAdCB/FO/4lwvoF1S/Cpia/eoVWC/VKHitkump9OhkU3XR7wZP5Ct
         VtWgv407feGK5GbI6QEqLxT3ipcNFDJPdiUXyto0AM3Al/8yYudJqp3csA0iGHxlP/PK
         EbMj5mIKOv+BAR09uBZNHhr1yfzjFd7dDMgXE8ZyekOK2DAVylLcileLrKmlcM/8J9LG
         k6gQ==
X-Gm-Message-State: AAQBX9cuqz8nrJIrj7gkhZVmfYNz/z/8p2/s8dWNCWsZo8B19iKuX1q5
        R403M2qS7aRe4QzaCs+GGM4=
X-Google-Smtp-Source: AKy350YtNCbal4G8hPVRskf40l3SXY0m0d+91irTDLCPDrG5Ej12/tmJNLWQi3N3eS244GQUHt8IkQ==
X-Received: by 2002:a05:6512:110a:b0:4db:971:82cd with SMTP id l10-20020a056512110a00b004db097182cdmr3304550lfg.17.1681232025439;
        Tue, 11 Apr 2023 09:53:45 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id b30-20020a056512025e00b004ec55ac6cd1sm2437299lfo.136.2023.04.11.09.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 09:53:44 -0700 (PDT)
Date:   Tue, 11 Apr 2023 19:53:42 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v9 0/4] dmaengine: dw-edma: Add support for native HDMA
Message-ID: <20230411165342.u6k6vamyejuqqb5z@mobilestation>
References: <20230324021420.73401-1-cai.huoqing@linux.dev>
 <20230324074455.bosmaxwkbo7mlyvj@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324074455.bosmaxwkbo7mlyvj@mobilestation>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Mar 24, 2023 at 10:44:58AM +0300, Serge Semin wrote:
> Hi Vinod
> 
> On Fri, Mar 24, 2023 at 10:14:14AM +0800, Cai Huoqing wrote:
> > Add support for HDMA NATIVE, as long the IP design has set
> > the compatible register map parameter-HDMA_NATIVE,
> > which allows compatibility for native HDMA register configuration.
> > 
> > The HDMA Hyper-DMA IP is an enhancement of the eDMA embedded-DMA IP.
> > And the native HDMA registers are different from eDMA,
> > so this patch add support for HDMA NATIVE mode.
> > 
> > HDMA write and read channels operate independently to maximize
> > the performance of the HDMA read and write data transfer over
> > the link When you configure the HDMA with multiple read channels,
> > then it uses a round robin (RR) arbitration scheme to select
> > the next read channel to be serviced.The same applies when
> > youhave multiple write channels.
> > 
> > The native HDMA driver also supports a maximum of 16 independent
> > channels (8 write + 8 read), which can run simultaneously.
> > Both SAR (Source Address Register) and DAR (Destination Address Register)
> > are aligned to byte.
> > 
> > Cai Huoqing (1):
> >   dmaengine: dw-edma: Add support for native HDMA
> > 
> > Cai huoqing (3):
> >   dmaengine: dw-edma: Rename dw_edma_core_ops structure to
> >     dw_edma_plat_ops
> >   dmaengine: dw-edma: Create a new dw_edma_core_ops structure to
> >     abstract controller operation
> >   dmaengine: dw-edma: Add HDMA DebugFS support
> > 
> > Tested-by: Serge Semin <fancer.lancer@gmail.com>
> 
> I finished the patchset review and testing. Could you have a look at
> the series. If you are ok with what it does please merge in.

@Vinod, merge window will supposedly be in the next week. Could you
give your resolution about this series?

-Serge(y)

> 
> -Serge(y)
> 
> > 
> > v8->v9:
> >   [3/4]
> >   1.Drop an empty line.
> >   [4/4]
> >   2.Update commit log.
> >   3.Remove unused macro
> > 
> > v8 link:
> >   https://lore.kernel.org/lkml/20230323034944.78357-1-cai.huoqing@linux.dev/
> > 
> >  drivers/dma/dw-edma/Makefile                 |   8 +-
> >  drivers/dma/dw-edma/dw-edma-core.c           |  86 ++----
> >  drivers/dma/dw-edma/dw-edma-core.h           |  58 ++++
> >  drivers/dma/dw-edma/dw-edma-pcie.c           |   4 +-
> >  drivers/dma/dw-edma/dw-edma-v0-core.c        |  85 +++++-
> >  drivers/dma/dw-edma/dw-edma-v0-core.h        |  14 +-
> >  drivers/dma/dw-edma/dw-hdma-v0-core.c        | 296 +++++++++++++++++++
> >  drivers/dma/dw-edma/dw-hdma-v0-core.h        |  17 ++
> >  drivers/dma/dw-edma/dw-hdma-v0-debugfs.c     | 170 +++++++++++
> >  drivers/dma/dw-edma/dw-hdma-v0-debugfs.h     |  22 ++
> >  drivers/dma/dw-edma/dw-hdma-v0-regs.h        | 129 ++++++++
> >  drivers/pci/controller/dwc/pcie-designware.c |   2 +-
> >  include/linux/dma/edma.h                     |   7 +-
> >  13 files changed, 807 insertions(+), 91 deletions(-)
> >  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.c
> >  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.h
> >  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
> >  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
> >  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > 
> > -- 
> > 2.34.1
> > 
