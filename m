Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C9F4D52B4
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 20:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242964AbiCJT7k (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 14:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242308AbiCJT7k (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 14:59:40 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F253B297;
        Thu, 10 Mar 2022 11:58:38 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id d10so14459974eje.10;
        Thu, 10 Mar 2022 11:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w6IlZiQ1KfrFCDGnZjvy+a+YFYdf0pWDJIBAdG3khYc=;
        b=K/2DEUvB/1QqRs+WOw3ue0lwYIBIhq7OpkR2hgeiqPURoJArneAP00lxCXGfLjVUr5
         MjfAf9i3BJHjszJUb5YKSTPp9Cyy82R3at/iPG3aF0W3gykxpzpBw0A7er0D19FIiTNB
         axZnEEEr3u06ZvL/9vhkR8SWe9OQK+xQOXa0UyqTKFKz461Oq3O3OPumvSSmh+r3pAVT
         UExfrnnrI/ttBIqfK8yU2Dm9UM4lmZRMuoybh5vFC2sYOqQc/XzfVgE7AeHJUY0ki4Ue
         ULmDvbY/IImHefl6JCSmpQ6L2GoyZSigDTogjXDsfBhdQo7I4RPJ3AdgeoJqJA2xtVwO
         IVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w6IlZiQ1KfrFCDGnZjvy+a+YFYdf0pWDJIBAdG3khYc=;
        b=hTr2inVOMn11cjNeoW3xZ0ltXjRek/Xjndp8WO2jhXQ2VnlHrSVwANpm8+9BVENauY
         OEAR5DD3GAGQFpd/scMmtdSWFwjU016PhVp13FTzruqfPnAs5o9AWVtJiCW3a1zImoXr
         cNBHnONdYyc55MbrLWFOV17AB+d/OntfCD0oAiYT6XMZAmLOQ82R+G2msiJz4a3j/ipF
         yDPrSb1gD+DM+cUgyAfdqkM11nzbu+S32C+00GmNs5zpdrH1bjQSe0fA4L4o8nEJvmiO
         Xkl/US7YkuNyjFyphMm5U5e8dyrgZhhUqHDEGlnoqMHeVosqwEG5U8/lVHieYk1XKqI7
         zTwQ==
X-Gm-Message-State: AOAM532Iab91Mx4L4MzPOEWpfeNtTCUc43f7vB0yQP6eb3W6efcyWkO4
        IUe/3mgLI9tOi+uAN2thZJpjjXX5sI2VzYB4C3U=
X-Google-Smtp-Source: ABdhPJxLDEA4gRgoR7OYjlSD7rIO7E7MwAQ3Ae/IGSnL+xGeu0m4CpWiqEihwpakuKs69dK5crD2CY2OBAsw8T3iWDM=
X-Received: by 2002:a17:906:7245:b0:6cf:d3c6:8c63 with SMTP id
 n5-20020a170906724500b006cfd3c68c63mr5404904ejk.677.1646942316655; Thu, 10
 Mar 2022 11:58:36 -0800 (PST)
MIME-Version: 1.0
References: <20220310192457.3090-1-Frank.Li@nxp.com> <20220310194521.g6emg63bparbjic2@mobilestation>
In-Reply-To: <20220310194521.g6emg63bparbjic2@mobilestation>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Thu, 10 Mar 2022 13:58:25 -0600
Message-ID: <CAHrpEqR=sXkv6A8Ut4+c7iyL9WYpOipC6fzH0sz85wGJkiY7_g@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Enable designware PCI EP EDMA locally
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Frank Li <Frank.Li@nxp.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        dmaengine@vger.kernel.org, vkoul@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 10, 2022 at 1:45 PM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> Frank,
>
> Please don't re-send patch so quickly. We haven't finished discussing
> and reviewing v4 yet, but you've already sent out v5 with possibly some of
> the comments missed. In addition you haven't addressed all my comments

I think I have already finished my patches.
The comments missed are manivannan's patches, which should be fixed by him.

best regards
Frank Li

> in the v4. Please get back there and let's finish all the discussions
> first. Regarding the resibmitting procedure see [1].
>
> [1] Documentation/process/submitting-patches.rst: "Don't get discouraged - or impatient"
>
> -Sergey
>
> On Thu, Mar 10, 2022 at 01:24:48PM -0600, Frank Li wrote:
> > Default Designware EDMA just probe remotely at host side.
> > This patch allow EDMA driver can probe at EP side.
> >
> > 1. Clean up patch
> >    dmaengine: dw-edma: Detach the private data and chip info structures
> >    dmaengine: dw-edma: remove unused field irq in struct dw_edma_chip
> >    dmaengine: dw-edma: change rg_region to reg_base in struct
> >    dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
> >
> > 2. Enhance EDMA driver to allow prode eDMA at EP side
> >    dmaengine: dw-edma: Add support for chip specific flags
> >    dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific flags
> >
> > 3. Bugs fix at EDMA driver when probe eDMA at EP side
> >    dmaengine: dw-edma: Fix programming the source & dest addresses for ep
> >    dmaengine: dw-edma: Don't rely on the deprecated "direction" member
> >
> > 4. change pci-epf-test to use EDMA driver to transfer data.
> >    PCI: endpoint: functions/pci-epf-test: Support PCI controller DMA
> >
> > 5. Using imx8dxl to do test, but some EP functions still have not
> > upstream yet. So below patch show how probe eDMA driver at EP
> > controller driver.
> > https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#m979eb506c73ab3cfca2e7a43635ecdaec18d8097
> >
> >
> >
> > Frank Li (7):
> >   dmaengine: dw-edma: Detach the private data and chip info structures
> >   dmaengine: dw-edma: remove unused field irq in struct dw_edma_chip
> >   dmaengine: dw-edma: change rg_region to reg_base in struct
> >     dw_edma_chip
> >   dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
> >     dw_edma_chip
> >   dmaengine: dw-edma: Add support for chip specific flags
> >   dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific flags
> >   PCI: endpoint: functions/pci-epf-test: Support PCI controller DMA
> >
> > Manivannan Sadhasivam (2):
> >   dmaengine: dw-edma: Fix programming the source & dest addresses for ep
> >   dmaengine: dw-edma: Don't rely on the deprecated "direction" member
> >
> >  drivers/dma/dw-edma/dw-edma-core.c            | 131 +++++++++++-------
> >  drivers/dma/dw-edma/dw-edma-core.h            |  32 +----
> >  drivers/dma/dw-edma/dw-edma-pcie.c            |  83 +++++------
> >  drivers/dma/dw-edma/dw-edma-v0-core.c         |  46 +++---
> >  drivers/dma/dw-edma/dw-edma-v0-debugfs.c      |  10 +-
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 108 +++++++++++++--
> >  include/linux/dma/edma.h                      |  56 +++++++-
> >  7 files changed, 298 insertions(+), 168 deletions(-)
> >
> > --
> > 2.24.0.rc1
> >
