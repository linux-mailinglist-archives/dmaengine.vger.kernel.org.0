Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7422830BE6D
	for <lists+dmaengine@lfdr.de>; Tue,  2 Feb 2021 13:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbhBBMmK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Feb 2021 07:42:10 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:56096 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231628AbhBBMlt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Feb 2021 07:41:49 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D1C7CC00AD;
        Tue,  2 Feb 2021 12:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612269646; bh=8mgn4YgoiuCWn9IVu0KCglq4i/YbiTIVBIKPedOF7mE=;
        h=From:To:Cc:Subject:Date:From;
        b=BEx2vTwMd1JbmM89JG0l1+/nWR74ys64DPpnMEojBpmYBlzXVxlyhVqfNsEai1X9f
         zEfPql221OeJv/2aGziKk967MylyLr9A6R/EzC7SQyvQUY56LF7rXtNARF97Vw4SDU
         rDgiNOJXexWtw25yvtjNgs5lmQlApsANIb1giIViD+IL0ISIejY6EJzSa8eMnHVDwb
         ihmmpzZczaI4jVUzP5TnUgPwk5uHFdhKfmhAJF5/hr3MeovgjJUIl2kZv3TOPdQSqF
         SUmLnOckgdwBZf7QHnjGyWNzKrJmL0t+0wk70mjQCpNwjUtFgifuRh/GSkis2LLWRi
         IqPeXCRLX/YXA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 15E6FA0249;
        Tue,  2 Feb 2021 12:40:44 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 00/15] dmaengine: dw-edma: HDMA support
Date:   Tue,  2 Feb 2021 13:40:14 +0100
Message-Id: <cover.1612269536.git.gustavo.pimentel@synopsys.com>
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

Change log:
From V1 to V2
 - Applied changes based on Bjorn Helgaas' review
 - Rebased patches on top of v5.11-rc1 version

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
 drivers/pci/pci.c                        |  29 +++
 include/linux/pci.h                      |   2 +
 include/uapi/linux/pci_regs.h            |   6 +
 11 files changed, 846 insertions(+), 355 deletions(-)

-- 
2.7.4

