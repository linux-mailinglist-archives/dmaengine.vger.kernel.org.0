Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DDD519239
	for <lists+dmaengine@lfdr.de>; Wed,  4 May 2022 01:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244190AbiECXVs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 19:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237650AbiECXVq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 19:21:46 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090AA1D0F2;
        Tue,  3 May 2022 16:18:11 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 16so23822401lju.13;
        Tue, 03 May 2022 16:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Sazi1GWbBcvd2uDJmEHfszuDK6b1MmS8tlFa5Xmh6/U=;
        b=aTU6wLIjsbC5mmW1HMpR0bYpeAIYmq3k5hURzh+JmvgElYWVOE2L3ylkvKyQ+O0c53
         XQn67NbvPrmBUgHZnqoZTzeQ9h+3OhtG9LYhvJKCnPRcsSBi4xvzOVh9bJbSaOLcJA/5
         O1oYL2BldBoy6kgXqIcn5FXIFUM909j5DqUS8ag4HlmfMqDzEX4hrKWi+ONAlcqrVGO2
         Bn2hkFeWHcEk9puSdfB/zjy9M6x/nAx4l2ushIw2k1Ed4MKCsJWBbAHaUQ2htHRhBzuy
         sQBCDVWoFA2DjAAe+tjVXZveOpR1OkibJ/K6Oo64AlPgRaV7CU/wIRavTf0U6x9QIIR2
         qS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sazi1GWbBcvd2uDJmEHfszuDK6b1MmS8tlFa5Xmh6/U=;
        b=PJ65Mm2K5KIyGUX1Vzg1PQrVGWYF0Va5A7d5WV/U3ccdg7+LlLX7IQrFJ/al3MGggr
         BEJX5yFFtCYs2ryvOyCWZprVK0bxvQGFUJh1zxTF8ngdMQOtVcbO7IjBy7E6WaHXRsjI
         akLkA+gw1AHppsIpIdiFpA2VhZzTRwnYvcNehgNis7npF6ChZZGO2FiXgs9+HPAabBB+
         pc4LxVfIY4L/7zubst0QFElrkk5XZJVGNUl3j6ivUKc6u1DpzfFuC7o0aRG3JE03xLhJ
         w/PGX8FUeOp/Q1cD6A3tnyoajvmx5nU8NXG2oEvkjouAYnWg14fEzh1BwNx3VRn2eSHb
         LRZw==
X-Gm-Message-State: AOAM530Y4nXqE0ivDmivE4mnTrzklE3EvK3o/J4ZCW5TiHCaTj45bPXX
        N3wcPYodud0oPnXWBduGQ2s=
X-Google-Smtp-Source: ABdhPJxgY6OP0GGmdTRtJUCiWlhQAxc8VfhCCZjkDYtn1uUzlY8UmBb1LChAE+UzuTVBDP2rEE1+Lg==
X-Received: by 2002:a2e:b0fc:0:b0:24f:1050:ff61 with SMTP id h28-20020a2eb0fc000000b0024f1050ff61mr11277471ljl.290.1651619889081;
        Tue, 03 May 2022 16:18:09 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id s15-20020ac25fef000000b0047255d2115esm1053854lfg.141.2022.05.03.16.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 16:18:08 -0700 (PDT)
Date:   Wed, 4 May 2022 02:18:06 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Frank Li <Frank.Li@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, helgaas@kernel.org, kw@linux.com,
        bhelgaas@google.com, manivannan.sadhasivam@linaro.org,
        Sergey.Semin@baikalelectronics.ru
Subject: Re: [PATCH v10 0/9] Enable designware PCI EP EDMA locally
Message-ID: <20220503231806.w2x4o2b3xymbwn74@mobilestation>
References: <20220503005801.1714345-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503005801.1714345-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, May 02, 2022 at 07:57:52PM -0500, Frank Li wrote:
> Default Designware EDMA just probe remotely at host side.
> This patch allow EDMA driver can probe at EP side.
> 
> 1. Clean up patch
>    dmaengine: dw-edma: Detach the private data and chip info structures
>    dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
>    dmaengine: dw-edma: Change rg_region to reg_base in struct
>    dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
> 
> 2. Enhance EDMA driver to allow prode eDMA at EP side
>    dmaengine: dw-edma: Add support for chip specific flags
>    dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific flags
> 
> 3. Bugs fix at EDMA driver when probe eDMA at EP side
>    dmaengine: dw-edma: Fix programming the source & dest addresses for ep
>    dmaengine: dw-edma: Don't rely on the deprecated "direction" member
> 
> 4. change pci-epf-test to use EDMA driver to transfer data.
>    PCI: endpoint: Add embedded DMA controller test
> 
> 5. Using imx8dxl to do test, but some EP functions still have not
> upstream yet. So below patch show how probe eDMA driver at EP
> controller driver.
> https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#m979eb506c73ab3cfca2e7a43635ecdaec18d8097

As I have already said in my comment to v9, @Lorenzo, @Rob, @Vinod,
my patchset:
Link: https://lore.kernel.org/linux-pci/20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru
is based on this one. In its turn my series depends on the other
patchsets:
[PATCH v3 0/4] clk: Baikal-T1 DDR/PCIe resets and some xGMAC fixes
Link: https://lore.kernel.org/linux-pci/20220503205722.24755-1-Sergey.Semin@baikalelectronics.ru/
[PATCH v2 00/13] PCI: dwc: Various fixes and cleanups
Link: https://lore.kernel.org/linux-pci/20220503212300.30105-1-Sergey.Semin@baikalelectronics.ru/
[PATCH v2 00/17] PCI: dwc: Add dma-ranges/YAML-schema/Baikal-T1 support
Link: https://lore.kernel.org/linux-pci/20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru/
which are currently on review. I am very much eager to get my patches
merged in before the next merge windows. But in order to preserve the
consistency of the corresponding repo with my patchsets the repo needs
to have the @Frank' patches. Seeing aside with @Frank's series my changes
depend on the changes in the clk and pci subsystems, could you please
consider choosing a single repository for merging all my and @Frank
patches in? Since the changes mostly concern the DW PCIe controller I
suggest to use the 'pci/dwc' branch of the
'kernel/git/lpieralisi/pci.git' repository. What do you think?
@Lorenzo?

-Sergey

> 
> 
> Frank Li (7):
>   dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
>   dmaengine: dw-edma: Detach the private data and chip info structures
>   dmaengine: dw-edma: Change rg_region to reg_base in struct
>     dw_edma_chip
>   dmaengine: dw-edma: Rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
>     dw_edma_chip
>   dmaengine: dw-edma: Add support for chip specific flags
>   dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific flags
>   PCI: endpoint: Enable DMA controller tests for endpoints with DMA
>     capabilities
> 
> Serge Semin (2):
>   dmaengine: dw-edma: Drop dma_slave_config.direction field usage
>   dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction
>     semantics
> 
>  drivers/dma/dw-edma/dw-edma-core.c            | 141 +++++++++++-------
>  drivers/dma/dw-edma/dw-edma-core.h            |  31 +---
>  drivers/dma/dw-edma/dw-edma-pcie.c            |  83 +++++------
>  drivers/dma/dw-edma/dw-edma-v0-core.c         |  54 ++++---
>  drivers/dma/dw-edma/dw-edma-v0-core.h         |   4 +-
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c      |  18 +--
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.h      |   8 +-
>  drivers/pci/endpoint/functions/pci-epf-test.c | 108 ++++++++++++--
>  include/linux/dma/edma.h                      |  61 +++++++-
>  9 files changed, 323 insertions(+), 185 deletions(-)
> 
> -- 
> 2.35.1
> 
