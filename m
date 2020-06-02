Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338481EB84D
	for <lists+dmaengine@lfdr.de>; Tue,  2 Jun 2020 11:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgFBJUa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Jun 2020 05:20:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:23031 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgFBJUa (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 2 Jun 2020 05:20:30 -0400
IronPort-SDR: CmRx5YRDVsSmKsSZ53574tLdBlKLV7BNqWNZMwIx/3zhIUw8bb3/8G1S9kpBupkHSt+vUKrZwI
 WhlWI+HwMaqA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 02:20:29 -0700
IronPort-SDR: ysZWeoS5k5LV4zJonen/rJs3ApZREOrR04yU2RcA0WQTXtuC+kBOBj08T/ecAtF2N1sMIfoR+2
 R1kBN8b4G/5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,463,1583222400"; 
   d="scan'208";a="470606361"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jun 2020 02:20:27 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Subject: [PATCH 06/15] dmaengine: dw-edma: use PCI_IRQ_MSI_TYPES  where appropriate
Date:   Tue,  2 Jun 2020 11:20:25 +0200
Message-Id: <20200602092025.31922-1-piotr.stankiewicz@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Seeing as there is shorthand available to use when asking for any type
of interrupt, or any type of message signalled interrupt, leverage it.

Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index dc85f55e1bb8..46defe30ac25 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -117,7 +117,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 
 	/* IRQs allocation */
 	nr_irqs = pci_alloc_irq_vectors(pdev, 1, pdata->irqs,
-					PCI_IRQ_MSI | PCI_IRQ_MSIX);
+					PCI_IRQ_MSI_TYPES);
 	if (nr_irqs < 1) {
 		pci_err(pdev, "fail to alloc IRQ vector (number of IRQs=%u)\n",
 			nr_irqs);
-- 
2.17.2

