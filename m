Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D53691394
	for <lists+dmaengine@lfdr.de>; Thu,  9 Feb 2023 23:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjBIWlS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Feb 2023 17:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjBIWkx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Feb 2023 17:40:53 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D87C6BD15;
        Thu,  9 Feb 2023 14:40:09 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id m10so3896263ljp.3;
        Thu, 09 Feb 2023 14:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rmR5DPB9qq62N13Qwf3lHgdCau6VrZJ6N1jP54dOWX4=;
        b=SrKlLttRqCMFIu0Vmnuyptfn8MlK0zD49rWCQWlA6b9WcROOe8QSypS0VXmTof/XX0
         Fevp8pkHNCML7iGSfJMoCcpXLXgm5j5FNz3HYKIlMMUlv9L4lLTIN4Uf0z0terv0nWbw
         9/BzIGJxnLHXO+nNcr2wWxjuakf3XxSp6DzD3h6Uxy5n4YbJxDhc0BtA/vbN47HnRCz0
         Os5/nOt8omxFQKofBetRB1iTOGQ8lwlFvdkeVMgNzaKr+q1updxNq5D4Dc79k+foxlr8
         iJ3pBLQADeTWxa90ILiVyGXRBZqJrnkLuw54cYbWphzmmWmKpEgRLOOKme/dimvg+ZhR
         jLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmR5DPB9qq62N13Qwf3lHgdCau6VrZJ6N1jP54dOWX4=;
        b=4fVzD06JjBtJq0NToyXtpueHwcNF4aKRb1ad1R/CCH2+VCujcPKYtqcnYF0a47QKy1
         +uhaTkSAyxq40ZHxSoxpOATSn8UXSkQ9XRSh4AdeYOQL+lM1WAmcjjbmchTdDiXxC4FY
         XAbV2VCD0X0k+y87GReVsWQkHr8iSs2KZJJvtZ736SXR4ImGoFYvnv6O5RLmSriTKMVe
         oUdBDbQOUf3zCWJKIJ2jO7Z13mvYbQmeJkn4SHOk4F2D+DYCaXj9zotG7POgDN0zOldy
         IN65jB2ltrBB+H4h1VgXnVvce2Sb2bv5hb8cyJmkCGMLhTPe6xjuxWe2KBW+BXWCC++Q
         tUag==
X-Gm-Message-State: AO0yUKVgX5MwY+76mj3t0hsqTMC13TelkbydhcVBrkRaxSMY9SnynNJO
        QVrP3qfouBG1OaVihSDSJH0uKgM/EuQ=
X-Google-Smtp-Source: AK7set/N1fpID1gyQoGiAr2LLv+q9wUnNt7dOvEkQ+E2Mc4l5+Fcr9MDKTd0wLRATI2oI/6ujLLnbw==
X-Received: by 2002:a2e:b8c5:0:b0:293:153b:1c74 with SMTP id s5-20020a2eb8c5000000b00293153b1c74mr5075209ljp.29.1675982407045;
        Thu, 09 Feb 2023 14:40:07 -0800 (PST)
Received: from mobilestation ([83.220.236.142])
        by smtp.gmail.com with ESMTPSA id h23-20020a2e9ed7000000b0028f7e86f522sm227346ljk.96.2023.02.09.14.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 14:40:06 -0800 (PST)
Date:   Fri, 10 Feb 2023 01:40:03 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     caihuoqing <caihuoqing@baidu.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 0/3] dmaengine: dw-edma: Add support for native HDMA
Message-ID: <20230209224003.dkayfpzh2xkirloy@mobilestation>
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

Hello Cai

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

My DW PCIe/eDMA series has been finally accepted by @Bjorn:
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/ctrl/dwc
(@Lorenzo, please note my changes in your pci/dwc are a bit outdated.)
The patchset will get into the mainline kernel on v6.3. So if you want
your series to go further you'll need either rebase your patches on the
@Bjorn's branch or wait for the kernel v6.3 release and rebase your work
on top of the latest kernel then. I'll provide some comments regarding
this patchset shortly.

-Serge(y)

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
