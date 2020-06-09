Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9342C1F36D2
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2020 11:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgFIJR5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Jun 2020 05:17:57 -0400
Received: from mga17.intel.com ([192.55.52.151]:29544 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbgFIJR4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 9 Jun 2020 05:17:56 -0400
IronPort-SDR: 3IQZXn/EQhDdVdXMApFMtjiM2Cqc1KPdn4sgi1jJZ8Mkg+sKmesFRPq2eLAyGfcvb/qYSkZ2yA
 OBdp0DQQJN5A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 02:17:55 -0700
IronPort-SDR: r4kAbd1yIygKTXh+u0HT9cULu5ZjkqXVYC0+p4eTSP9FDzipXLeT23fNYyP50gDc4Wn70HPRhe
 NiAtvofwd80Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,491,1583222400"; 
   d="scan'208";a="447062288"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by orsmga005.jf.intel.com with ESMTP; 09 Jun 2020 02:17:53 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/15] dmaengine: dw-edma: Use PCI_IRQ_MSI_TYPES  where appropriate
Date:   Tue,  9 Jun 2020 11:17:47 +0200
Message-Id: <20200609091751.1065-1-piotr.stankiewicz@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200609091148.32749-1-piotr.stankiewicz@intel.com>
References: <20200609091148.32749-1-piotr.stankiewicz@intel.com>
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

