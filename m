Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75414D6A35
	for <lists+dmaengine@lfdr.de>; Sat, 12 Mar 2022 00:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiCKXDh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Mar 2022 18:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiCKXDV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Mar 2022 18:03:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823054C417;
        Fri, 11 Mar 2022 14:58:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EBFCB82B70;
        Fri, 11 Mar 2022 22:58:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC98C340E9;
        Fri, 11 Mar 2022 22:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647039527;
        bh=0jub9hYC7U636c/1gwv/XIn7E8RVj0QvzIboV92Ufyg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZKfwSfeTyDsePoj+6I9lRMSz1t5x7z4QQtc1zBKo420OA2HqJfRXGK+ZxLkZnhfO8
         qUlepla4Uzndr7TEJMo/tkNKByqVKjav6ExNilODFvBzS/quqyDvoujCgenzpfg0C0
         isH+CeYVms2YIFGmFziGMENJpgmCW+bh5UGmuZMkNP7PR10aDZY1YjtucvDZd7OeDn
         HTNPi/RjdTRFwkL9vj7XX6a6e4UAWfLq2XuATZfbVnhZgn8GWKZqdvHJ3z1bBgzslS
         6dtwi89fqLIIc+F2xjHwU85y38wXBXh9z1n0pJFN71jjIUlffjd4+bFbwuOrd1zNKZ
         e70h6cxoYGUjw==
Date:   Fri, 11 Mar 2022 16:58:46 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, vkoul@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v5 0/9] Enable designware PCI EP EDMA locally
Message-ID: <20220311225846.GA334303@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310192457.3090-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 10, 2022 at 01:24:48PM -0600, Frank Li wrote:
> Default Designware EDMA just probe remotely at host side.
> This patch allow EDMA driver can probe at EP side.
> 
> 1. Clean up patch
>    dmaengine: dw-edma: Detach the private data and chip info structures
>    dmaengine: dw-edma: remove unused field irq in struct dw_edma_chip
>    dmaengine: dw-edma: change rg_region to reg_base in struct
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
>    PCI: endpoint: functions/pci-epf-test: Support PCI controller DMA
> 
> 5. Using imx8dxl to do test, but some EP functions still have not
> upstream yet. So below patch show how probe eDMA driver at EP
> controller driver.
> https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#m979eb506c73ab3cfca2e7a43635ecdaec18d8097
> 
> 
> 
> Frank Li (7):
>   dmaengine: dw-edma: Detach the private data and chip info structures
>   dmaengine: dw-edma: remove unused field irq in struct dw_edma_chip
>   dmaengine: dw-edma: change rg_region to reg_base in struct
>     dw_edma_chip
>   dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
>     dw_edma_chip

These should be consistently capitalized to match previous commits
(and the rest of your own commits :)):

s/remove unused/Remove unused/
s/change rg_region/Change rg_region/
s/rename wr/Rename wr/

>   dmaengine: dw-edma: Add support for chip specific flags
>   dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific flags
>   PCI: endpoint: functions/pci-epf-test: Support PCI controller DMA

There are a couple commits that use the whole "PCI: endpoint:
functions/pci-epf-test:" prefix, but IMO it's a bit of overkill to use
so much space just for the prefix.

Maybe something like this would be enough?

  PCI: endpoint: Add embedded DMA controller test

> Manivannan Sadhasivam (2):
>   dmaengine: dw-edma: Fix programming the source & dest addresses for ep
>   dmaengine: dw-edma: Don't rely on the deprecated "direction" member
> 
>  drivers/dma/dw-edma/dw-edma-core.c            | 131 +++++++++++-------
>  drivers/dma/dw-edma/dw-edma-core.h            |  32 +----
>  drivers/dma/dw-edma/dw-edma-pcie.c            |  83 +++++------
>  drivers/dma/dw-edma/dw-edma-v0-core.c         |  46 +++---
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c      |  10 +-
>  drivers/pci/endpoint/functions/pci-epf-test.c | 108 +++++++++++++--
>  include/linux/dma/edma.h                      |  56 +++++++-
>  7 files changed, 298 insertions(+), 168 deletions(-)
> 
> -- 
> 2.24.0.rc1
> 
