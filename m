Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AA0504A10
	for <lists+dmaengine@lfdr.de>; Mon, 18 Apr 2022 01:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiDQXez (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 17 Apr 2022 19:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiDQXey (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 17 Apr 2022 19:34:54 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3A912A9A;
        Sun, 17 Apr 2022 16:32:17 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bq30so21926456lfb.3;
        Sun, 17 Apr 2022 16:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hz/Bs6t+odJFa38xtKGAQb4BA/DqtUAE6Kcn0vUWPLE=;
        b=Jj+Wx0VeRnKK1CePZTyFIoqrdtKs6cDiiufnZPQJrtR8MV2eBeLb4UKv0X38Nypspk
         uboabiFfUzu3CbMx1gY7BFUk/fBGVB3SVioojN+E/zuzZWK2TWF8ZaGRgYxccfkaZXjG
         74cyNX/zXEdpGf4AzuvG0DkVZ5cXjKD8ZlNkmpChiHk3g8aOEH72hvI8UHTzMMaTtGlD
         NYYkIj406dK26wfkmb6hkB9JyeaSbBNIdeeRfSjRaz7OvU0NVb5qIbL6mXQvik+WZoJU
         fQ/WcP3Gl4a4bkotJxZwtS5sYZ75HRU2YUHG/4dAGxj8qH8j3C1nGL1J3WXf5tX3d9ED
         0edA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hz/Bs6t+odJFa38xtKGAQb4BA/DqtUAE6Kcn0vUWPLE=;
        b=XMLHSXIlFXRGlYb++aYZFruSwBjUpd7asz55k0hhEmFKawDIuYUqJ1Gw9Ir+5Atvay
         ubdRQj64fBrgSjUbelfErX8PaOknP8iM6Nj+5eNG0KwvDiGDP8kQep02ru2V47Tgl0m3
         23jqZD5ixKW4p5nuOSrYIFFVj5HlUqmAd0Tz6IUcbYuxezwQJOXTNOg/Nd331eu4UUKl
         D4I47liQ/NtpT5cCaDmKHpM4jXW1urO+tcPZ3OrVcLDQEUaXxHBV33i+SxCzzGAkLcc1
         1T5UcMiN3sLZqOjrN0lH/EJzwO3yOYFql1X4zgaf7UJbqRFKrpyWU+AqmEsEV6hGzSqo
         qBlQ==
X-Gm-Message-State: AOAM530jzuOxmWWwZa37EaYhI99X6ENUx9MB5GqEO+4ay3ExHwr3ksYN
        9bOxSmN6JxPmf9p9EaBaC6eJhjfForqr0w==
X-Google-Smtp-Source: ABdhPJwoVX4LzhbBeQl8L8GsfYXnC8zW8/k226b7GI1HzuHiYmkLUvsT5kH97RUSNFYtx94jFtKS3g==
X-Received: by 2002:a05:6512:3d22:b0:470:b1a8:352b with SMTP id d34-20020a0565123d2200b00470b1a8352bmr4819832lfv.219.1650238335460;
        Sun, 17 Apr 2022 16:32:15 -0700 (PDT)
Received: from mobilestation (ip1.ibrae.ac.ru. [91.238.191.1])
        by smtp.gmail.com with ESMTPSA id d5-20020a056512320500b0046ed7bf92b7sm966981lfe.177.2022.04.17.16.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 16:32:15 -0700 (PDT)
Date:   Mon, 18 Apr 2022 02:32:12 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Frank Li <frank.li@nxp.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/25] dmaengine: dw-edma: Convert ll/dt phys-address to
 PCIe bus/DMA address
Message-ID: <20220417233212.brl3fpf5aedkci2y@mobilestation>
References: <PAXPR04MB918647BBA46A716EEB4AE96C88199@PAXPR04MB9186.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR04MB918647BBA46A716EEB4AE96C88199@PAXPR04MB9186.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 24, 2022 at 07:23:47PM +0000, Frank Li wrote:
> 
> 
> > -----Original Message-----
> > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Sent: Wednesday, March 23, 2022 8:48 PM
> > To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>; Vinod Koul
> > <vkoul@kernel.org>; Jingoo Han <jingoohan1@gmail.com>; Bjorn Helgaas
> > <bhelgaas@google.com>; Frank Li <frank.li@nxp.com>; Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org>
> > Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>; Serge Semin
> > <fancer.lancer@gmail.com>; Alexey Malahov
> > <Alexey.Malahov@baikalelectronics.ru>; Pavel Parkhomenko
> > <Pavel.Parkhomenko@baikalelectronics.ru>; Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com>; Rob Herring <robh@kernel.org>; Krzysztof
> > Wilczyński <kw@linux.com>; linux-pci@vger.kernel.org;
> > dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org; Gustavo Pimentel
> > <Gustavo.Pimentel@synopsys.com>
> > Subject: [EXT] [PATCH 05/25] dmaengine: dw-edma: Convert ll/dt phys-address
> > to PCIe bus/DMA address
> > 
> > Caution: EXT Email
> > 
> > In accordance with the dw_edma_region.paddr field semantics it is supposed
> > to be initialized with a memory base address visible by the DW eDMA
> > controller. If the DMA engine is embedded into the DW PCIe Host/EP
> > controller, then the address should belong to the Local CPU/Application
> > memory. If eDMA is remotely accessible across the PCIe bus via the PCIe
> > memory IOs, then the address needs to be a part of the PCIe bus memory
> > space. The later case hasn't been well covered in the corresponding
> > glue-driver. Since in general the PCIe memory space doesn't have to match
> > the CPU memory space and the pci_dev.resource[] arrays contain the
> > resources defined in the CPU memory space, a proper conversion needs to be
> > performed, otherwise either the driver won't properly work or much worse
> > the memory corruption will happen. The conversion can be done by means of
> > the pci_bus_address() method. Let's use it to retrieve the LL, DT and CSRs
> > PCIe memory ranges.
> 

> Actually, This driver is dead driver. And no one use it and don't know
> How to test it. 

My considerations were based on the commit logs, the databooks info and the
code logic.

> 
> I think pci_bus_address can't resolve this problem.
> 
> If remote side using iATU map bar 0 into 0x7000_0000
> 
> I supposed DMA link should be use 0x7000_0000, how host side pci_bus_address
> know such iATU mapping information of EP side?

pci_dev.resource[] entries contain the CPU-physical addresses of the
corresponding BARs. In general the CPU and PCIe bus address spaces may
mismatch. That is for instance the 0xF000_0000 CPU address can get to
be mapped to the PCIe address 0x7000_0000. The later address in its
turn can be used to initialize the eDMA BARx register. Since in case
of the remote eDMA setup the application SAR/DAR address is supposed
to be set with the value within the BARx range, we need to have the
BARx PCIe address, not the CPU one. In a cross-platform way the real
BAR' address range can be retrieved by means of the pci_bus_address()
method. That's what this patch is about.

-Sergey

> 
> Best regards
> Frank Li
> 
> 
> > 
> > Note in addition to that we need to extend the dw_edma_region.paddr field
> > size. The field normally contains a memory range base address to be set in
> > the DW eDMA Linked-List pointer register or as a base address of the
> > Linked-List data buffer. In accordance with [1] the LL range is supposed
> > to be created in the Local CPU/Application memory, but depending on the DW
> > eDMA utilization the memory can be created as a part of the PCIe bus
> > address space (as in the case of the DW PCIe EP prototype kit). Thus in
> > the former case the dw_edma_region.paddr field should have the dma_addr_t
> > type, while in the later one - pci_bus_addr_t. Seeing the corresponding
> > CSRs are always 64-bits wide let's convert the dw_edma_region.paddr field
> > type to be u64 and let the client code logic to make sure it has a valid
> > address visible by the DW eDMA controller. For instance the DW eDMA PCIe
> > glue-driver initializes the field with the addresses from the PCIe bus
> > memory space.
> > 
> > [1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
> >     v.5.40a, March 2019, p.1103
> > 
> > Fixes: 41aaff2a2ac0 ("dmaengine: Add Synopsys eDMA IP PCIe glue-logic")
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  drivers/dma/dw-edma/dw-edma-pcie.c | 8 ++++----
> >  include/linux/dma/edma.h           | 2 +-
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-
> > edma-pcie.c
> > index d6b5e2463884..04c95cba1244 100644
> > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > @@ -231,7 +231,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >                         return -ENOMEM;
> > 
> >                 ll_region->vaddr += ll_block->off;
> > -               ll_region->paddr = pdev->resource[ll_block->bar].start;
> > +               ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
> >                 ll_region->paddr += ll_block->off;
> >                 ll_region->sz = ll_block->sz;
> > 
> > @@ -240,7 +240,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >                         return -ENOMEM;
> > 
> >                 dt_region->vaddr += dt_block->off;
> > -               dt_region->paddr = pdev->resource[dt_block->bar].start;
> > +               dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
> >                 dt_region->paddr += dt_block->off;
> >                 dt_region->sz = dt_block->sz;
> >         }
> > @@ -256,7 +256,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >                         return -ENOMEM;
> > 
> >                 ll_region->vaddr += ll_block->off;
> > -               ll_region->paddr = pdev->resource[ll_block->bar].start;
> > +               ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
> >                 ll_region->paddr += ll_block->off;
> >                 ll_region->sz = ll_block->sz;
> > 
> > @@ -265,7 +265,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >                         return -ENOMEM;
> > 
> >                 dt_region->vaddr += dt_block->off;
> > -               dt_region->paddr = pdev->resource[dt_block->bar].start;
> > +               dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
> >                 dt_region->paddr += dt_block->off;
> >                 dt_region->sz = dt_block->sz;
> >         }
> > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > index 8897f8a79b52..5abac9640a4e 100644
> > --- a/include/linux/dma/edma.h
> > +++ b/include/linux/dma/edma.h
> > @@ -18,7 +18,7 @@
> >  struct dw_edma;
> > 
> >  struct dw_edma_region {
> > -       phys_addr_t     paddr;
> > +       u64             paddr;
> >         void __iomem    *vaddr;
> >         size_t          sz;
> >  };
> > --
> > 2.35.1
> 
