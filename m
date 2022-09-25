Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C555E94EF
	for <lists+dmaengine@lfdr.de>; Sun, 25 Sep 2022 19:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbiIYReT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 25 Sep 2022 13:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiIYReR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 25 Sep 2022 13:34:17 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6A11263E;
        Sun, 25 Sep 2022 10:34:16 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id x29so5223577ljq.2;
        Sun, 25 Sep 2022 10:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=1DQ+A/zmD61KcVWpqhZ9SC5wsRL6ZDGy3hAgi5YTkDc=;
        b=UijSseiqh2+vp4Q/LyKtcj2SfBAYd9gmhEueKBqgn3kZ9bj4ZzsxjuA7GJ2mtCwebV
         7IiSj8LCJGT/BKnIZfL+gA6db82MkkJ4M8Jnk59sckLtvm50CNJi+EsIt6Y/9eN2YSwA
         gNMm0Dyn8periyXf2cQmbbkpFgIQ/uMRI4eDeR8zGd7zQk7cCY8WSHDhtL94K/zRBrug
         hDaqZVPKw/8ZogDKeqDEkSQvAAernhPUi8u5QeROomK9+qZfhUip5EQBWPSqLYBrLgZd
         9PhaHSE1cNByxo8scwvTLJ+ddBMnZdJfEcsACiCoknK9ZwHQ99yx829ZjpQNrlqmFteI
         JMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=1DQ+A/zmD61KcVWpqhZ9SC5wsRL6ZDGy3hAgi5YTkDc=;
        b=LPbFazOfqFwj+iYy3cyP+6mVTkzNuzDcdmuW7v6en4edTz2SBLQ0Z63C2JjxeSNT3b
         hkh2TEzatW18afvvgJ+ChDn6PiNMxej2tupDs1mqmD01pBXSK1alqcGVzNvmP6i+zx++
         Eym1cvkirYOCEuK4MOHu77uhIDL7iZB7Cs2Jk+Oh0JHd1j2GWLtFGsGqwh3tQZpYiDiJ
         Kdd0DtjzsOzv/T9SzHaPm1W5dyS4nb4tV4PEidoyvy5mF+uJ3lVEEYI1i8UThPnTGVGW
         BEoHKPyTxA7B/CPycgM0l0kFwqw4x0EkdrgCDOdJtu/IWRbatS0DaBRZDBHPQnoacxLK
         nH6g==
X-Gm-Message-State: ACrzQf0jHGCOxgOVK03Ph/Y/7hXw51i0NtzyrXxBUZdgdGNNYt1rf0ul
        48kEh/1N67imOwIsc0oRMzHdLNwIGxRoIQ==
X-Google-Smtp-Source: AMsMyM41QqjkVazWGZHBljkGkZ9s122zhTeKQ7ipVJutemr+qo5GleK5ppHy1cI8u3eFeI18Dr2Arg==
X-Received: by 2002:a2e:7d13:0:b0:26c:4062:acfe with SMTP id y19-20020a2e7d13000000b0026c4062acfemr6443232ljc.201.1664127255061;
        Sun, 25 Sep 2022 10:34:15 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id b17-20020ac247f1000000b004a100c21eaesm672434lfp.97.2022.09.25.10.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 10:34:14 -0700 (PDT)
Date:   Sun, 25 Sep 2022 20:34:12 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     caihuoqing <caihuoqing@baidu.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH 0/3] dmaengine: dw-edma: Add support for native HDMA
Message-ID: <20220925173412.u2ez6rbmfc5fupdn@mobilestation>
References: <20220921064859.10328-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921064859.10328-1-cai.huoqing@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Sep 21, 2022 at 02:48:49PM +0800, Cai Huoqing wrote:
> From: caihuoqing <caihuoqing@baidu.com>
> 
> Add support for HDMA NATIVE, as long the IP design has set
> the compatible register map parameter-HDMA_NATIVE,
> which allows compatibility for native HDMA register configuration.
> 
> The HDMA Hyper-DMA IP is an enhancement of the eDMA embedded-DMA IP.
> And the native HDMA registers are different from eDMA,
> so this patch add support for HDMA NATIVE mode.
> 
> HDMA write and read channels operate independently to maximize
> the performance of the HDMA read and write data transfer over
> the link When you configure the HDMA with multiple read channels,
> then it uses a round robin (RR) arbitration scheme to select
> the next read channel to be serviced.
> The same applies when you have multiple write channels.
> 
> The native HDMA driver also supports a maximum of 16 independent
> channels (8 write + 8 read), which can run simultaneously.
> Both SAR (Source Address Register) and DAR (Destination Address Register)
> are alignmented to byte.dmaengine: dw-edma: Add support for native HDMA
> 
> These series based on the series
> https://lore.kernel.org/dmaengine/20220822185332.26149-1-Sergey.Semin@baikalelectronics.ru/

Great! Thanks for rebasing on top of my series. I'll have a look at
your patchset in several weeks (two or most likely three) since the
next merge window is upon us and neither mine nor your patchset will
get into the Bjorn/Vinod repos before that anyway.

-Sergey

> 
> Cai Huoqing (3):
>   dmaengine: dw-edma: Rename dw_edma_core_ops structure to
>     dw_edma_plat_ops
>   dmaengine: dw-edma: Create a new dw_edma_core_ops structure to
>     abstract controller operation
>   dmaengine: dw-edma: Add support for native HDMA
> 
>  drivers/dma/dw-edma/Makefile             |   6 +-
>  drivers/dma/dw-edma/dw-edma-core.c       |  65 ++---
>  drivers/dma/dw-edma/dw-edma-core.h       |  19 ++
>  drivers/dma/dw-edma/dw-edma-pcie.c       |   4 +-
>  drivers/dma/dw-edma/dw-edma-v0-core.c    |  90 ++++++-
>  drivers/dma/dw-edma/dw-edma-v0-core.h    |  14 +-
>  drivers/dma/dw-edma/dw-hdma-v0-core.c    | 304 +++++++++++++++++++++++
>  drivers/dma/dw-edma/dw-hdma-v0-core.h    |  17 ++
>  drivers/dma/dw-edma/dw-hdma-v0-debugfs.c | 150 +++++++++++
>  drivers/dma/dw-edma/dw-hdma-v0-debugfs.h |  22 ++
>  drivers/dma/dw-edma/dw-hdma-v0-regs.h    |  98 ++++++++
>  include/linux/dma/edma.h                 |   7 +-
>  12 files changed, 725 insertions(+), 71 deletions(-)
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.c
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.h
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-regs.h
> 
> -- 
> 2.25.1
> 
