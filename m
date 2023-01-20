Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6425167584C
	for <lists+dmaengine@lfdr.de>; Fri, 20 Jan 2023 16:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjATPR0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Jan 2023 10:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjATPRZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 20 Jan 2023 10:17:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469A52D42;
        Fri, 20 Jan 2023 07:17:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 934D261FAF;
        Fri, 20 Jan 2023 15:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2D4C433D2;
        Fri, 20 Jan 2023 15:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674227843;
        bh=9ELKS484+oMKzPe7AQaURyoWVSurZKXj+tYOnsbQYNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U1NMpWSyxIOaEYHWN+GfT8k3O3qL+f0J6beDmdsJ5R/K3R8DdDEedpaPSuCuoLqPc
         5hHC6ciO+bCZIQk+WqwomMnxLcPbVtFRP0RKlpqSFOsynRgNOTyrkhN2pPFWVq+f7c
         TSmJsIg/1ssbgnp/jt3v20VVkju9Gy8IFvlN/Puhebg3DRKJgtER65qD3F/1K78EJM
         IjWj0o78mvYstD27Csylpa/Hh7lv8V6SI1aZtn1DF5EFoAxpJXaxvEBsxVLZ5j1QO4
         KxYSsZ29FHhonsFKzpSNHjuiRZryOcuE2aenztgWSX4yw/Ojr4g7AGYMVANchvkVdp
         BZ5MnjkQclyMA==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Frank Li <Frank.Li@nxp.com>, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v9 00/27] dmaengine: dw-edma: Add RP/EP local DMA controllers support
Date:   Fri, 20 Jan 2023 16:17:13 +0100
Message-Id: <167422777541.1648445.11187141235329504308.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113171409.30470-1-Sergey.Semin@baikalelectronics.ru>
References: <20230113171409.30470-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, 13 Jan 2023 20:13:42 +0300, Serge Semin wrote:
> This is a final patchset in the series created in the framework of
> my Baikal-T1 PCIe/eDMA-related work:
> 
> [1: Done v5] PCI: dwc: Various fixes and cleanups
> Link: https://lore.kernel.org/linux-pci/20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru/
> Merged: kernel 6.0-rc1
> [2: Done v4] PCI: dwc: Add hw version and dma-ranges support
> Link: https://lore.kernel.org/linux-pci/20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru/
> Merged: kernel 6.0-rc1
> [3: Done v7] PCI: dwc: Add generic resources and Baikal-T1 support
> Link: https://lore.kernel.org/linux-pci/20221113191301.5526-1-Sergey.Semin@baikalelectronics.ru/
> Merged: kernel 6.2-rc1
> [4: In-review v9] dmaengine: dw-edma: Add RP/EP local DMA controllers support
> Link: ---you are looking at it---
> 
> [...]

Applied to pci/dwc, thanks!

[01/27] dmaengine: Fix dma_slave_config.dst_addr description
        https://git.kernel.org/lpieralisi/pci/c/064f216c0320
[02/27] dmaengine: dw-edma: Release requested IRQs on failure
        https://git.kernel.org/lpieralisi/pci/c/0abe230898c5
[03/27] dmaengine: dw-edma: Convert ll/dt phys-address to PCIe bus/DMA address
        https://git.kernel.org/lpieralisi/pci/c/e9bff321a78e
[04/27] dmaengine: dw-edma: Fix missing src/dst address of the interleaved xfers
        https://git.kernel.org/lpieralisi/pci/c/dba023658bb8
[05/27] dmaengine: dw-edma: Don't permit non-inc interleaved xfers
        https://git.kernel.org/lpieralisi/pci/c/66fd2f907b5e
[06/27] dmaengine: dw-edma: Fix invalid interleaved xfers semantics
        https://git.kernel.org/lpieralisi/pci/c/669e5b693ed0
[07/27] dmaengine: dw-edma: Add CPU to PCIe bus address translation
        https://git.kernel.org/lpieralisi/pci/c/3e52c2d7440a
[08/27] dmaengine: dw-edma: Add PCIe bus address getter to the remote EP glue-driver
        https://git.kernel.org/lpieralisi/pci/c/262be8be4446
[09/27] dmaengine: dw-edma: Drop chancnt initialization
        https://git.kernel.org/lpieralisi/pci/c/cbc8047b3c14
[10/27] dmaengine: dw-edma: Fix DebugFS reg entry type
        https://git.kernel.org/lpieralisi/pci/c/09d4dc211c98
[11/27] dmaengine: dw-edma: Stop checking debugfs_create_*() return value
        https://git.kernel.org/lpieralisi/pci/c/db75236638be
[12/27] dmaengine: dw-edma: Add dw_edma prefix to the DebugFS nodes descriptor
        https://git.kernel.org/lpieralisi/pci/c/3e2b815a909a
[13/27] dmaengine: dw-edma: Convert DebugFS descs to being kz-allocated
        https://git.kernel.org/lpieralisi/pci/c/65fc08f34f1b
[14/27] dmaengine: dw-edma: Rename DebugFS dentry variables to 'dent'
        https://git.kernel.org/lpieralisi/pci/c/12f5703e8f3e
[15/27] dmaengine: dw-edma: Simplify the DebugFS context CSRs init procedure
        https://git.kernel.org/lpieralisi/pci/c/7d087c23ce0b
[16/27] dmaengine: dw-edma: Move eDMA data pointer to DebugFS node descriptor
        https://git.kernel.org/lpieralisi/pci/c/75ea6127b19a
[17/27] dmaengine: dw-edma: Join Write/Read channels into a single device
        https://git.kernel.org/lpieralisi/pci/c/f19aba4d6c56
[18/27] dmaengine: dw-edma: Use DMA-engine device DebugFS subdirectory
        https://git.kernel.org/lpieralisi/pci/c/5e1c2b6d9d6e
[19/27] dmaengine: dw-edma: Use non-atomic io-64 methods
        https://git.kernel.org/lpieralisi/pci/c/647c614949f3
[20/27] dmaengine: dw-edma: Drop DT-region allocation
        https://git.kernel.org/lpieralisi/pci/c/f27b5d39fdf2
[21/27] dmaengine: dw-edma: Replace chip ID number with device name
        https://git.kernel.org/lpieralisi/pci/c/e2d483f30e93
[22/27] dmaengine: dw-edma: Skip cleanup procedure if no private data found
        https://git.kernel.org/lpieralisi/pci/c/6bdc8b38c1c3
[23/27] dmaengine: dw-edma: Add mem-mapped LL-entries support
        https://git.kernel.org/lpieralisi/pci/c/06a2a118d36f
[24/27] dmaengine: dw-edma: Relax driver config settings
        https://git.kernel.org/lpieralisi/pci/c/9dd4a16f2540
[25/27] PCI: dwc: Set coherent DMA-mask on MSI-address allocation
        https://git.kernel.org/lpieralisi/pci/c/b838544be814
[26/27] PCI: bt1: Set 64-bit DMA-mask
        https://git.kernel.org/lpieralisi/pci/c/2484fb4c8581
[27/27] PCI: dwc: Add DW eDMA engine support
        https://git.kernel.org/lpieralisi/pci/c/95624672bb3e

Thanks,
Lorenzo
