Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D362F3F9A
	for <lists+dmaengine@lfdr.de>; Wed, 13 Jan 2021 01:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394907AbhALW4B (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Jan 2021 17:56:01 -0500
Received: from mailfilter03-out40.webhostingserver.nl ([195.211.72.99]:55106
        "EHLO mailfilter03-out40.webhostingserver.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394903AbhALW4B (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Jan 2021 17:56:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exalondelft.nl; s=whs1;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
         from;
        bh=/iLZF5+MWd8vc9Sg3Pst1Rp9cFBVj8ZZ9VL2up/kMKs=;
        b=ZK0eN8yJwV5QnmjWRSYbhQ6LQ7c22ilEnMsNsHqsJY2FRyRjwC7Ud+WWIdVoUj22o0BDEQdDdD9Cq
         3ABIVt+0QlzGtCl4TgQAKHVhy9vwNsIA5bIcTZmgqB5XFlWEy+OWPljkfafUkQPp8quG4+sQKu6SXF
         cR7Xle6Wx9U/jzRLN7HHVd6vt2SKnSzDJLRPJKEvUQny0QKBaQaXn3nUTc1SjPNFGy6OE6RP8F/zFQ
         lOe4iXm+/qRTOPZiomiSmiv5rKUrz10yE5rtR4Xe7P3mztFQ0ZQBwPyQ5vck/W2LvkzWXwN1EQpKpc
         Z4Krh/P/lJgJSASAwq+ZYPF83KMuXXA==
X-Halon-ID: cfb8d4a0-5526-11eb-bfeb-001a4a4cb9a5
Received: from s198.webhostingserver.nl (s198.webhostingserver.nl [141.138.168.154])
        by mailfilter03.webhostingserver.nl (Halon) with ESMTPSA
        id cfb8d4a0-5526-11eb-bfeb-001a4a4cb9a5;
        Tue, 12 Jan 2021 23:37:54 +0100 (CET)
Received: from [2001:981:6fec:1:228:9916:35b6:34c4] (helo=delfion.fritz.box)
        by s198.webhostingserver.nl with esmtpa (Exim 4.93.0.4)
        (envelope-from <ftoth@exalondelft.nl>)
        id 1kzSIU-000WqI-Dy; Tue, 12 Jan 2021 23:37:54 +0100
From:   Ferry Toth <ftoth@exalondelft.nl>
To:     Ferry Toth <ftoth@exalondelft.nl>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] hsu_dma_pci: disable spurious interrupt
Date:   Tue, 12 Jan 2021 23:37:49 +0100
Message-Id: <20210112223749.97036-1-ftoth@exalondelft.nl>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Intel Tangier B0 and Anniedale the interrupt line, disregarding
to have different numbers, is shared between HSU DMA and UART IPs.
Thus on such SoCs we are expecting that IRQ handler is called in
UART driver only. hsu_pci_irq was handling the spurious interrupt
from HSU DMA by returning immediately. This wastes CPU time and
since HSU DMA and HSU UART interrupt occur simultaneously they race
to be handled causing delay to the HSU UART interrupt handling.
Fix this by disabling the interrupt entirely.

Fixes: 4831e0d9054c ("serial: 8250_mid: handle interrupt correctly in DMA case")
Signed-off-by: Ferry Toth <ftoth@exalondelft.nl>
---
 drivers/dma/hsu/pci.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/hsu/pci.c b/drivers/dma/hsu/pci.c
index 07cc7320a614..9045a6f7f589 100644
--- a/drivers/dma/hsu/pci.c
+++ b/drivers/dma/hsu/pci.c
@@ -26,22 +26,12 @@
 static irqreturn_t hsu_pci_irq(int irq, void *dev)
 {
 	struct hsu_dma_chip *chip = dev;
-	struct pci_dev *pdev = to_pci_dev(chip->dev);
 	u32 dmaisr;
 	u32 status;
 	unsigned short i;
 	int ret = 0;
 	int err;
 
-	/*
-	 * On Intel Tangier B0 and Anniedale the interrupt line, disregarding
-	 * to have different numbers, is shared between HSU DMA and UART IPs.
-	 * Thus on such SoCs we are expecting that IRQ handler is called in
-	 * UART driver only.
-	 */
-	if (pdev->device == PCI_DEVICE_ID_INTEL_MRFLD_HSU_DMA)
-		return IRQ_HANDLED;
-
 	dmaisr = readl(chip->regs + HSU_PCI_DMAISR);
 	for (i = 0; i < chip->hsu->nr_channels; i++) {
 		if (dmaisr & 0x1) {
@@ -105,6 +95,17 @@ static int hsu_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		goto err_register_irq;
 
+	/*
+	 * On Intel Tangier B0 and Anniedale the interrupt line, disregarding
+	 * to have different numbers, is shared between HSU DMA and UART IPs.
+	 * Thus on such SoCs we are expecting that IRQ handler is called in
+	 * UART driver only. Instead of handling the spurious interrupt
+	 * from HSU DMA here and waste CPU time and delay HSU UART interrupt
+	 * handling, disable the interrupt entirely.
+	 */
+	if (pdev->device == PCI_DEVICE_ID_INTEL_MRFLD_HSU_DMA)
+		disable_irq_nosync(chip->irq);
+
 	pci_set_drvdata(pdev, chip);
 
 	return 0;
-- 
2.27.0

