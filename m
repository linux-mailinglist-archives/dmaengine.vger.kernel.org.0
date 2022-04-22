Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC71750BF37
	for <lists+dmaengine@lfdr.de>; Fri, 22 Apr 2022 20:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbiDVSDm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Apr 2022 14:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbiDVR6p (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Apr 2022 13:58:45 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4EAC0E49;
        Fri, 22 Apr 2022 10:55:48 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g19so15600195lfv.2;
        Fri, 22 Apr 2022 10:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZwTHPEGeQ+1Bh1Yl4i+sW511LLzqtPPBtHa2K6hKisk=;
        b=LT2TNnHuPUXMdf8ceHGSkEb7yCsZVzRs9kduPMa3csXb4Lm3BRUnzWDIEnJhy/emy6
         UNRk+hp9l8V+VrT9Zk/JgExTPMJvB3C+HgnCpskJNBoezZlBI+2EyMKIrbVN39T/VAVq
         w7TmbLczjnR42SxoF9a96slBABa8R5pbTJphwdHE74MYDMKCKY2gkFkB7d+BDNrpk87U
         gm7I5uGEcdpd85OIddEw9ey7QShR3/zYSADPKjDYkrGf4BoyI4sn/zjZ2NkMkcNdeuQV
         6RjLwADr8CwgYyJv6Dh6FNQIY7/2gTXDMCHtzoGvKIgE/aeWZIAiK/NAO6uKt6q1c9/7
         Kmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZwTHPEGeQ+1Bh1Yl4i+sW511LLzqtPPBtHa2K6hKisk=;
        b=6ONE7VlGtn56wp2uOB4mcWDkYFOXp8skgMSUXSc/Z7MrNRj2MYUzdBVIwhrhFqvNQj
         SFo5z8sMbC2vDN7fZE/WQkGA8caljUj5bpZKajccJt0opjXtxUPtxcwaxSJEDlasklP/
         3KQu4ddlZgFfA5uqc8tovIc7kT6gyqY13JUVMcDzlM4brIvuIP64Ovg5+K4TWDzLBBP6
         9xJx+DMVfOrymlORRg/6cjd0KcGs5znh4XfLuKV5iJWjsPjVVMmZTfC6EdwYfjr5+tUx
         KqmxsVP/qHhYYNn/Mmk5TtL2EcYdt1i+7Y73aw2+3YQ4HBLoWdaiBgBYATu0mK9ZDPi6
         NA0A==
X-Gm-Message-State: AOAM532Kne47oRAGrMQvFERXV8aJGPlgybCe4q0WOTf5WRbCK5uvIm55
        2DvI21JsRVAebBhe+m9YFao=
X-Google-Smtp-Source: ABdhPJwec6GEfr9POjmFnK3G+iv3uBbgT68XpxmXgZocyoCy5Bbwuhz6pCdPmkEInaHpQ/wGNYDtVA==
X-Received: by 2002:a05:6512:1513:b0:448:39c0:def0 with SMTP id bq19-20020a056512151300b0044839c0def0mr3841531lfb.469.1650650018931;
        Fri, 22 Apr 2022 10:53:38 -0700 (PDT)
Received: from mobilestation ([95.79.183.147])
        by smtp.gmail.com with ESMTPSA id m4-20020a2e9104000000b0024db18a2015sm291348ljg.58.2022.04.22.10.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 10:53:38 -0700 (PDT)
Date:   Fri, 22 Apr 2022 20:53:35 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Frank Li <Frank.Li@nxp.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, helgaas@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v9 0/9] Enable designware PCI EP EDMA locally
Message-ID: <20220422175335.ucs2nmfq44tmcbn3@mobilestation>
References: <20220422143643.727871-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422143643.727871-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello folks,

My review is finally over. Aside with that I've tested the series on
Baikal-T1 SoC, which has DW PCIe Host controller v4.60 and DW eDMA
embedded. A test was performed on kernel v5.18-rc3 by a simple driver
copying random data from system memory to SM768 framebuffer and
vise-versa. So @Frank feel free to add my tag to the entire series:

Tested-by: Serge Semin <fancer.lancer@gmail.com>

@Lorenzo, @Rob, @Vinod, my patchset:
Link: https://lore.kernel.org/linux-pci/20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru
is based on this one. In its turn my series depends on the other
patchsets:
[PATCH v2 0/4] clk: Baikal-T1 DDR/PCIe resets and some xGMAC fixes
Link: [https://lore.kernel.org/linux-pci/20220330144320.27039-1-Sergey.Semin@baikalelectronics.ru
[PATCH 00/12] PCI: dwc: Various fixes and cleanups
Link: https://lore.kernel.org/linux-pci/20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru
[PATCH 00/16] PCI: dwc: Add dma-ranges/YAML-schema/Baikal-T1 support
https://lore.kernel.org/linux-pci/20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru
which are currently on review. (BTW @Rob I am waiting for your
responses there to go on with v2 re-spin.) I am very much eager to get
my patches ready before the next merge windows. But in order to
preserve the consistency of the corresponding repo with my patchsets
it needs to have the @Frank' patches. Seeing aside with @Frank's
series my changes depends on the changes in the clk and pci
subsystems, could you please consider choosing a single repository for
merging all my and @Frank patches in. Since the changes mostly concern
the DW PCIe controller I suggest to use the 'pci/dwc' branch of the
'kernel/git/lpieralisi/pci.git' repository. What do you think?
@Lorenzo?

-Sergey

On Fri, Apr 22, 2022 at 09:36:34AM -0500, Frank Li wrote:
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
>   PCI: endpoint: Add embedded DMA controller test
> 
> Serge Semin (2):
>   dmaengine: dw-edma: Drop dma_slave_config.direction field usage
>   dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction
>     semantics
> 
>  drivers/dma/dw-edma/dw-edma-core.c            | 139 +++++++++++-------
>  drivers/dma/dw-edma/dw-edma-core.h            |  31 +---
>  drivers/dma/dw-edma/dw-edma-pcie.c            |  83 +++++------
>  drivers/dma/dw-edma/dw-edma-v0-core.c         |  54 ++++---
>  drivers/dma/dw-edma/dw-edma-v0-core.h         |   4 +-
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c      |  10 +-
>  drivers/pci/endpoint/functions/pci-epf-test.c | 108 ++++++++++++--
>  include/linux/dma/edma.h                      |  59 +++++++-
>  8 files changed, 312 insertions(+), 176 deletions(-)
> 
> -- 
> 2.35.1
> 
