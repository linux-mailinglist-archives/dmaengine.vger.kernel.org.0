Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1BD54E9A9
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jun 2022 20:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbiFPSte (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jun 2022 14:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiFPStc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jun 2022 14:49:32 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7D35370D;
        Thu, 16 Jun 2022 11:49:31 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id h23so2437882ljl.3;
        Thu, 16 Jun 2022 11:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=79Ks8rDEr2tFH1dWaaHo2QKKffv+K7aszYPtxlZkmQ4=;
        b=KZkmtzwxEuE7GCiL2f65ThLOb/MXxtS0yyp2nO+ENlEJ0EnJ/3SQm3crxrV+lulEho
         Tz4Hf+7oI700Tho3qmmV0jkstVXNKOv+v7HvlqZTKWbP99Xbo3sJaOoTtHsnXgH96YW7
         ht7NcutFBdv4NEOgwSbEBeAWEfagsh1wfkCVQm+z5FP/9mmx/yDp6zrHcE0wwO1/+p6Y
         YHpH3s62Rbcc4IWz0hBdQ8wFapOydKvua/He1+dOjc3UeBLTCPSSGR1DwLLjHs+JKymG
         B5QWrx4pKesxyWsiGSqOqsX9Ryfz47bsp5Zh4dHHUxyAG6FtKjQn/ZW+cZGl8i3ykxNY
         0VoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=79Ks8rDEr2tFH1dWaaHo2QKKffv+K7aszYPtxlZkmQ4=;
        b=S5kuDoPd6XsYozHcxCIUwewm5M8AZ7+sWj7WNPv3iWTJEEb4PAMCIi/KP8FfiiwBrZ
         wnwIIvcTW4c/+sSsjR2dAln8NqQ2TOAuXsYIzAvYo25B5UIpto8aJ7uwN0zkONX3aa4A
         Sn1b3E4QBV3XdiAXjvyzTwxEtXbLTKW6fg3nLEguYCvnK3IAZlIUmO4H5lHb7GueL/CB
         tMlZ137mFHOSzxIIxyyhKM0wcbqICvZDw5t5VWvOtpocdQCL6O6NIR59/Z4Wdf/RjWfj
         1UgtrA/SuZqDEJrp1j6wUWPd0wDCmtuxt4SUBUNmzzfoN/lq0ekIAkM7scbCyGh/obm1
         HFwg==
X-Gm-Message-State: AJIora/hnQNZ/XUUwLVwDwNMhBIE5vtSoPBPbrXwQMmDJz3wULsrLHWp
        K2OmnZ1VLcHEviDV2Hnuc5M=
X-Google-Smtp-Source: AGRyM1vARbPodOc1L2rb9cUFkcBLSOCl5ihCmbQw8/oECDKpPD+vgLO98hIligp33HSXpKB68205sg==
X-Received: by 2002:a2e:a226:0:b0:255:8f29:a272 with SMTP id i6-20020a2ea226000000b002558f29a272mr3370591ljm.42.1655405369465;
        Thu, 16 Jun 2022 11:49:29 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id a14-20020a194f4e000000b0047255d210e2sm334335lfk.17.2022.06.16.11.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 11:49:28 -0700 (PDT)
Date:   Thu, 16 Jun 2022 21:49:26 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Frank Li <Frank.Li@nxp.com>, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, kishon@ti.com, vkoul@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, manivannan.sadhasivam@linaro.org,
        Sergey.Semin@baikalelectronics.ru
Subject: Re: [PATCH v12 0/8] Enable designware PCI EP EDMA locally
Message-ID: <20220616184926.bwdzudvl3ifkc7kx@mobilestation>
References: <20220524152159.2370739-1-Frank.Li@nxp.com>
 <20220616163533.GA1094478@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616163533.GA1094478@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jun 16, 2022 at 11:35:33AM -0500, Bjorn Helgaas wrote:
> On Tue, May 24, 2022 at 10:21:51AM -0500, Frank Li wrote:
> > Default Designware EDMA just probe remotely at host side.
> > This patch allow EDMA driver can probe at EP side.
> > 
> > 1. Clean up patch
> >    dmaengine: dw-edma: Detach the private data and chip info structures
> >    dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
> >    dmaengine: dw-edma: Change rg_region to reg_base in struct
> >    dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
> > 
> > 2. Enhance EDMA driver to allow prode eDMA at EP side
> >    dmaengine: dw-edma: Add support for chip specific flags
> >    dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific
> > flags (this patch removed at v11 because dma tree already have fixed
> > patch)
> > 
> > 3. Bugs fix at EDMA driver when probe eDMA at EP side
> >    dmaengine: dw-edma: Fix programming the source & dest addresses for
> > ep
> >    dmaengine: dw-edma: Don't rely on the deprecated "direction" member
> > 
> > 4. change pci-epf-test to use EDMA driver to transfer data.
> >    PCI: endpoint: Add embedded DMA controller test
> > 
> > 5. Using imx8dxl to do test, but some EP functions still have not
> > upstream yet. So below patch show how probe eDMA driver at EP
> > controller driver.
> > https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#m979eb506c73ab3cfca2e7a43635ecdaec18d8097
> > 
> > Frank Li (6):
> >   dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
> >   dmaengine: dw-edma: Detach the private data and chip info structures
> >   dmaengine: dw-edma: Change rg_region to reg_base in struct
> >     dw_edma_chip
> >   dmaengine: dw-edma: Rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
> >     dw_edma_chip
> >   dmaengine: dw-edma: Add support for chip specific flags
> >   PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities
> > 
> > Serge Semin (2):
> >   dmaengine: dw-edma: Drop dma_slave_config.direction field usage
> >   dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction
> >     semantics
> > 
> >  drivers/dma/dw-edma/dw-edma-core.c            | 141 +++++++++++-------
> >  drivers/dma/dw-edma/dw-edma-core.h            |  31 +---
> >  drivers/dma/dw-edma/dw-edma-pcie.c            |  83 +++++------
> >  drivers/dma/dw-edma/dw-edma-v0-core.c         |  41 ++---
> >  drivers/dma/dw-edma/dw-edma-v0-core.h         |   4 +-
> >  drivers/dma/dw-edma/dw-edma-v0-debugfs.c      |  18 +--
> >  drivers/dma/dw-edma/dw-edma-v0-debugfs.h      |   8 +-
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 112 ++++++++++++--
> >  include/linux/dma/edma.h                      |  59 +++++++-
> >  9 files changed, 317 insertions(+), 180 deletions(-)
> 

> Applied with Vinod's ack to pci/edma for v5.20, thanks!
> 
> Check
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/edma
> (head 7871514c9cff ("PCI: endpoint: Enable DMA tests for endpoints
> with DMA capabilities")).

Great! Just what we needed.

> 
> If you post things that need to be applied on top of that branch,
> please mention that in the cover letter.

Ok. I'll mention that in the cover letters of my patchsets.

I've already got several R-b/T-b tags in the series:
https://lore.kernel.org/linux-pci/20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru/
Could you also have a look at it? If no objection we can either
merge it in right away into the pci/edma branch or wait for a little
while for a few more rc-cycles until I get to fix all the comments posted
for the dependant patchsets.

> 
> I don't guarantee the immutability of the branch because sometimes I
> fix typos or similar errors before the merge window.

Got it.

-Sergey

> 
> Bjorn
