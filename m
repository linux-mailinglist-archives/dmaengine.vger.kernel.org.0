Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D8E30E560
	for <lists+dmaengine@lfdr.de>; Wed,  3 Feb 2021 23:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhBCV7W (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Feb 2021 16:59:22 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:52188 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232549AbhBCV7Q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Feb 2021 16:59:16 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 806C4C0111;
        Wed,  3 Feb 2021 21:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612389495; bh=21k8tX4RGiOVgJbGOCzP5GHVanYEIotdSyZRgKlTQls=;
        h=From:To:Cc:Subject:Date:From;
        b=lzZjnHn9ALv3nd81X9ahGCxzacxy7564skkU3NRi2IrsdnEEv5IMOOOncYxGzjOcw
         VW1fMjiYCG25Nw/Arj9ksA4Mhq4H5JO8qkwIghNGPPIhot+ZxXMI1ROM/RMw/xEomc
         la6+0G9d2xAWBA0GbNq/OZfU5deaUmfnzQjPBiR9stkWiNvNcyJK0mkiMYWMyBZYZQ
         NdOC4mPlQvkmRnEtCkqLDsJaCnFwP4csZffcfmx9O8oUkt/lihj39/aGjt+3aKAMgU
         7gH0YOfRguoi5rei+SEgZ4um1obupB4W3wtacnzXwHuCuMp3XJ0xwPXYrcUM1+Y1bj
         +euvCwwaanO4A==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id EC22AA0249;
        Wed,  3 Feb 2021 21:58:13 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v4 00/15] dmaengine: dw-edma: HDMA support
Date:   Wed,  3 Feb 2021 22:57:51 +0100
Message-Id: <cover.1612389406.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch series adds the HDMA support, as long the IP design has set
the compatible register map parameter, which allows compatibility at
some degree for the existing Synopsys DesignWare eDMA driver that is
already available on the Kernel.

The HDMA "Hyper-DMA" IP is an enhancement of the eDMA "embedded-DMA" IP.

This new improvement comes with a PCI DVSEC that allows to the driver
recognize and switch behavior if it's an eDMA or an HDMA, becoming
retrocompatible, in the absence of this DVSEC, the driver will assume
that is an eDMA IP.

It also adds the interleaved support, since it will be similar to the
current scatter-gather implementation.

As well fixes/improves some abnormal behaviors not detected before, such as:
 - crash on loading/unloading driver
 - memory space definition for the data area and for the linked list space
 - scatter-gather address calculation on 32 bits platforms
 - minor comment and variable reordering

Changes:
 V2: Applied changes based on Bjorn Helgaas' review
     Rebased patches on top of v5.11-rc1 version
 V3: Applied changes based on Lukas Wunner' review
 V4: Fix a typo detected by kernel test robot

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org

Gustavo Pimentel (15):
  dmaengine: dw-edma: Add writeq() and readq() for 64 bits architectures
  dmaengine: dw-edma: Fix comments offset characters' alignment
  dmaengine: dw-edma: Add support for the HDMA feature
  PCI: Add pci_find_vsec_capability() to find a specific VSEC
  dmaengine: dw-edma: Add PCIe VSEC data retrieval support
  dmaengine: dw-edma: Add device_prep_interleave_dma() support
  dmaengine: dw-edma: Improve number of channels check
  dmaengine: dw-edma: Reorder variables to keep consistency
  dmaengine: dw-edma: Improve the linked list and data blocks definition
  dmaengine: dw-edma: Change linked list and data blocks offset and
    sizes
  dmaengine: dw-edma: Move struct dentry variable from static definition
    into dw_edma struct
  dmaengine: dw-edma: Fix crash on loading/unloading driver
  dmaengine: dw-edma: Change DMA abreviation from lower into upper case
  dmaengine: dw-edma: Revert fix scatter-gather address calculation
  dmaengine: dw-edma: Add pcim_iomap_table return checker

 drivers/dma/dw-edma/dw-edma-core.c       | 178 +++++++++++-------
 drivers/dma/dw-edma/dw-edma-core.h       |  37 ++--
 drivers/dma/dw-edma/dw-edma-pcie.c       | 275 +++++++++++++++++++++-------
 drivers/dma/dw-edma/dw-edma-v0-core.c    | 300 ++++++++++++++++++++++++-------
 drivers/dma/dw-edma/dw-edma-v0-core.h    |   2 +-
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c |  77 ++++----
 drivers/dma/dw-edma/dw-edma-v0-debugfs.h |   4 +-
 drivers/dma/dw-edma/dw-edma-v0-regs.h    | 291 +++++++++++++++++++-----------
 drivers/pci/pci.c                        |  34 ++++
 include/linux/pci.h                      |   2 +
 include/uapi/linux/pci_regs.h            |   6 +
 11 files changed, 851 insertions(+), 355 deletions(-)

-- 
2.7.4

