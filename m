Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C6C31F013
	for <lists+dmaengine@lfdr.de>; Thu, 18 Feb 2021 20:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhBRTkK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 18 Feb 2021 14:40:10 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:33074 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233364AbhBRTFl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 18 Feb 2021 14:05:41 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F3BE64014D;
        Thu, 18 Feb 2021 19:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613675056; bh=LMVv0cLJ3D0bpe2oO+Ggm1bTc1v5DBYdH82tYjfbfQE=;
        h=From:To:Cc:Subject:Date:From;
        b=EbkxfAIOMBYv4ON8ujSO9gV2kfzulP4U/xQy5ruXVCNByUi6qwKMAGThm4O8QJH3T
         hoNm9i8rU5Ljx4e+Z2GCVR/4ukOxUXUO6i0grYuF4QOvNxZqJcg8g4GbkaA90svdV3
         m9mzqk6wrY2lZV4oU4Fect+xijdqC6wT9uHalrGz06QwfYiZUwMoeqyooQNVFMjFJA
         4bRtkNAw2P5Qcs17NQT0FStHRxj1dcsWbFUAz4zbNC9nI3K/M7DCmj579W2ibcisQD
         XePgfYuktYNS8sElQTTKZzPCRWCTbuJGIhHCDd3GWOLn3IfJuFhqZE46mA5gOKOzRG
         ygSaWWDzKB4XA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3759AA005D;
        Thu, 18 Feb 2021 19:04:14 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v7 00/15] dmaengine: dw-edma: HDMA support
Date:   Thu, 18 Feb 2021 20:03:54 +0100
Message-Id: <cover.1613674948.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
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
 V5: Rework driver accordingly to Bjorn Helgaas's feedback
 V6: Rework driver accordingly to Krzysztof Wilczyński's feedback
 V7: Rework driver accordingly to Bjorn Helgaas's feedback
     Rebased patches on top of Bjorn Helgaas next branch due to the
     support of PCI_VNDR_* defines

Cc: dmaengine@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Krzysztof Wilczyński <kw@linux.com>
Cc: Lukas Wunner <lukas@wunner.de>

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
  dmaengine: dw-edma: Add pcim_iomap_table return check

 drivers/dma/dw-edma/dw-edma-core.c       | 178 +++++++++++-------
 drivers/dma/dw-edma/dw-edma-core.h       |  37 ++--
 drivers/dma/dw-edma/dw-edma-pcie.c       | 277 +++++++++++++++++++++-------
 drivers/dma/dw-edma/dw-edma-v0-core.c    | 300 ++++++++++++++++++++++++-------
 drivers/dma/dw-edma/dw-edma-v0-core.h    |   2 +-
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c |  77 ++++----
 drivers/dma/dw-edma/dw-edma-v0-debugfs.h |   4 +-
 drivers/dma/dw-edma/dw-edma-v0-regs.h    | 291 +++++++++++++++++++-----------
 drivers/pci/pci.c                        |  30 ++++
 include/linux/pci.h                      |   1 +
 10 files changed, 842 insertions(+), 355 deletions(-)

-- 
2.7.4

