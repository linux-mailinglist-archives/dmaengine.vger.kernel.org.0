Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6AE1ECEE3
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2020 13:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgFCLrt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Jun 2020 07:47:49 -0400
Received: from mga12.intel.com ([192.55.52.136]:38517 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgFCLrt (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 3 Jun 2020 07:47:49 -0400
IronPort-SDR: nKCWeLfvh7oZRNDjemAPT+Gw1GEDkT2mPTvycAGLXVCdeMRTMYierMCJCUjBHkd/TGW3jqJktM
 FxoSLU7Ng4dA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 04:47:49 -0700
IronPort-SDR: ZvVIiUqQLG8/jTe2Nag4+7ugrh9OsoiRl2s0i3N6x5ELPGlUvXr4ho9iW0J3AmISRgzWbXJ31W
 sJxpstgs9uEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400"; 
   d="scan'208";a="471110771"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jun 2020 04:47:47 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/15] dmaengine: dw-edma: Use PCI_IRQ_MSI_TYPES  where appropriate
Date:   Wed,  3 Jun 2020 13:47:42 +0200
Message-Id: <20200603114745.13212-1-piotr.stankiewicz@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200603114212.12525-1-piotr.stankiewicz@intel.com>
References: <20200603114212.12525-1-piotr.stankiewicz@intel.com>
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

