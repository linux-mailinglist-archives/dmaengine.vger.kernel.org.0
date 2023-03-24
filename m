Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B86E6C792C
	for <lists+dmaengine@lfdr.de>; Fri, 24 Mar 2023 08:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjCXHpG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Mar 2023 03:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjCXHpF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 24 Mar 2023 03:45:05 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5FD26CCE;
        Fri, 24 Mar 2023 00:45:00 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id q16so1063266lfe.10;
        Fri, 24 Mar 2023 00:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679643898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s+UV2/A47c89Jw8feRGPloqstRMGJ9kLamxjoxXavQI=;
        b=CYHlI1+jBadeYcUBefEWaLptMti0Lg7GJOVdshb5STqx0W9f3T4YNMf3DQHzrQ0fqq
         Big01GJiGCkpvLq5EMGJHrR8XYQyhJp0f3t49+iy3B7Jba6pI3T4KQnHqRtYL6KCQ/w1
         ofsxpEDMaMRhANGymFw5KElZ5edQ6VPYhzTPg4h4mjI+mf4tHrMQFsgCSdirGZ/nbDpW
         h6oe/BCDsC5XhZvLUUIHkU9l/GF8RV3D66D6SoQuHqMqvQKwBVRbVArJLz+4ELYh845G
         RskVQ2OgngQRqd7U0vvJAm5XTDe886q415jG9UreOly5Dp8LnrS0Gc/lqMUbNtMHWWC/
         20QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679643898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+UV2/A47c89Jw8feRGPloqstRMGJ9kLamxjoxXavQI=;
        b=qRPy8U0cAt73Ydwn6Ae/1KFsxy9zymw9MmD5FPoI2gSVrbT/e/6Hk7IO+TYP9CJ9Zb
         VwgsDNC3HU033OQx5BeatpCL2bEPltbOgvJkuMYNAPJmXDY98Q/MfQZ5N4N1FYFV3l1H
         s5WyZmB7ILmZUGOTIzwSMa57jlpiSruU9YJSejRXhUGMnlqoMNchgLwBd7p6vU7+rD68
         hmX1U6s4X6G3+hbWBT8prhVITRnN//7WqT6m3NRkdaVaCYI1GTFoL7Pz4/1UWLj3Ux7Z
         JkqH9t9IT6UWTjhDisZsfI8peKRXVdZT2tfY1lighaSX3ngIUyiNGZv51t4csxFN3isU
         EjLg==
X-Gm-Message-State: AAQBX9c7w0v9fj09ccn/d2YjltWUvu9MptLIjg4/UkLy/7Y99p6MU1QA
        AeuY1+WiMi4i8a/QGOxACs4=
X-Google-Smtp-Source: AKy350a98yvebhHpNeg2qVRYbw9cCcFtUHiTM8qakidih2d32psksP7cRfXauD6tixz6UppBoIdrYw==
X-Received: by 2002:ac2:520c:0:b0:4ea:e7ca:6e21 with SMTP id a12-20020ac2520c000000b004eae7ca6e21mr519215lfl.6.1679643898392;
        Fri, 24 Mar 2023 00:44:58 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id u15-20020ac243cf000000b004eaf2291dcdsm1235444lfl.102.2023.03.24.00.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 00:44:57 -0700 (PDT)
Date:   Fri, 24 Mar 2023 10:44:55 +0300
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
Message-ID: <20230324074455.bosmaxwkbo7mlyvj@mobilestation>
References: <20230324021420.73401-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324021420.73401-1-cai.huoqing@linux.dev>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod

On Fri, Mar 24, 2023 at 10:14:14AM +0800, Cai Huoqing wrote:
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
> the next read channel to be serviced.The same applies when
> youhave multiple write channels.
> 
> The native HDMA driver also supports a maximum of 16 independent
> channels (8 write + 8 read), which can run simultaneously.
> Both SAR (Source Address Register) and DAR (Destination Address Register)
> are aligned to byte.
> 
> Cai Huoqing (1):
>   dmaengine: dw-edma: Add support for native HDMA
> 
> Cai huoqing (3):
>   dmaengine: dw-edma: Rename dw_edma_core_ops structure to
>     dw_edma_plat_ops
>   dmaengine: dw-edma: Create a new dw_edma_core_ops structure to
>     abstract controller operation
>   dmaengine: dw-edma: Add HDMA DebugFS support
> 
> Tested-by: Serge Semin <fancer.lancer@gmail.com>

I finished the patchset review and testing. Could you have a look at
the series. If you are ok with what it does please merge in.

-Serge(y)

> 
> v8->v9:
>   [3/4]
>   1.Drop an empty line.
>   [4/4]
>   2.Update commit log.
>   3.Remove unused macro
> 
> v8 link:
>   https://lore.kernel.org/lkml/20230323034944.78357-1-cai.huoqing@linux.dev/
> 
>  drivers/dma/dw-edma/Makefile                 |   8 +-
>  drivers/dma/dw-edma/dw-edma-core.c           |  86 ++----
>  drivers/dma/dw-edma/dw-edma-core.h           |  58 ++++
>  drivers/dma/dw-edma/dw-edma-pcie.c           |   4 +-
>  drivers/dma/dw-edma/dw-edma-v0-core.c        |  85 +++++-
>  drivers/dma/dw-edma/dw-edma-v0-core.h        |  14 +-
>  drivers/dma/dw-edma/dw-hdma-v0-core.c        | 296 +++++++++++++++++++
>  drivers/dma/dw-edma/dw-hdma-v0-core.h        |  17 ++
>  drivers/dma/dw-edma/dw-hdma-v0-debugfs.c     | 170 +++++++++++
>  drivers/dma/dw-edma/dw-hdma-v0-debugfs.h     |  22 ++
>  drivers/dma/dw-edma/dw-hdma-v0-regs.h        | 129 ++++++++
>  drivers/pci/controller/dwc/pcie-designware.c |   2 +-
>  include/linux/dma/edma.h                     |   7 +-
>  13 files changed, 807 insertions(+), 91 deletions(-)
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.c
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.h
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-regs.h
> 
> -- 
> 2.34.1
> 
