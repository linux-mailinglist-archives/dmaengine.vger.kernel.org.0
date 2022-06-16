Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470D754E764
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jun 2022 18:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbiFPQfk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jun 2022 12:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiFPQfj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jun 2022 12:35:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C902628989;
        Thu, 16 Jun 2022 09:35:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6FD461477;
        Thu, 16 Jun 2022 16:35:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD57C34114;
        Thu, 16 Jun 2022 16:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655397336;
        bh=e0FWoTvVpsdyuUm1IRqY6/KMo2Z0X6MiEBNl/Fe3VFY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=P9stg/WF2HIrHcRApGHDiJn49IvFlcDS1bs8eIV4NSzuuyhHAv7iAmDiIsZ9IrZk6
         jgsnl4BSq3ioJo+POrXG70SfVAnictRLEaTg8qUlZ7nw06S0jnD6nv77SuP/4uH/yk
         r+6auY66+e1JCh0R6OY4hS8aOJlfaveM/954gpWpKmq/Z5FtzpLW+wefUFp5+m5t2W
         5TnacckofBNyCi2CvS/BkUoiaFsKm9XuQs+7NNJIXPOSUFneZpMnO5nOYURacSQH5a
         URCF/A6twwfR3jnDNX38INFZYxgNYp38n564RbeggZzeCZhVIdDUurSEFS0YZFnS4Z
         ITOZLsEL421dw==
Date:   Thu, 16 Jun 2022 11:35:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, kishon@ti.com,
        vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: Re: [PATCH v12 0/8] Enable designware PCI EP EDMA locally
Message-ID: <20220616163533.GA1094478@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524152159.2370739-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, May 24, 2022 at 10:21:51AM -0500, Frank Li wrote:
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
>    dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific
> flags (this patch removed at v11 because dma tree already have fixed
> patch)
> 
> 3. Bugs fix at EDMA driver when probe eDMA at EP side
>    dmaengine: dw-edma: Fix programming the source & dest addresses for
> ep
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
> Frank Li (6):
>   dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
>   dmaengine: dw-edma: Detach the private data and chip info structures
>   dmaengine: dw-edma: Change rg_region to reg_base in struct
>     dw_edma_chip
>   dmaengine: dw-edma: Rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
>     dw_edma_chip
>   dmaengine: dw-edma: Add support for chip specific flags
>   PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities
> 
> Serge Semin (2):
>   dmaengine: dw-edma: Drop dma_slave_config.direction field usage
>   dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction
>     semantics
> 
>  drivers/dma/dw-edma/dw-edma-core.c            | 141 +++++++++++-------
>  drivers/dma/dw-edma/dw-edma-core.h            |  31 +---
>  drivers/dma/dw-edma/dw-edma-pcie.c            |  83 +++++------
>  drivers/dma/dw-edma/dw-edma-v0-core.c         |  41 ++---
>  drivers/dma/dw-edma/dw-edma-v0-core.h         |   4 +-
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c      |  18 +--
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.h      |   8 +-
>  drivers/pci/endpoint/functions/pci-epf-test.c | 112 ++++++++++++--
>  include/linux/dma/edma.h                      |  59 +++++++-
>  9 files changed, 317 insertions(+), 180 deletions(-)

Applied with Vinod's ack to pci/edma for v5.20, thanks!

Check
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/edma
(head 7871514c9cff ("PCI: endpoint: Enable DMA tests for endpoints
with DMA capabilities")).

If you post things that need to be applied on top of that branch,
please mention that in the cover letter.

I don't guarantee the immutability of the branch because sometimes I
fix typos or similar errors before the merge window.

Bjorn
