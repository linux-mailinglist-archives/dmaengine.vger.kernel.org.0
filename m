Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C527045F9EC
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 02:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346532AbhK0B24 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Nov 2021 20:28:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36128 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346575AbhK0B0y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Nov 2021 20:26:54 -0500
Message-ID: <20211126230526.111397616@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=t/L3bect6Otcyaj5o3pOpna8DPyPttA1iOCagOeFNh8=;
        b=uPVGIEZysuDFheLAvBLfc+Jubu4K+kqJiowq/57mk6FzMxJ3uWAZyEPOEfrRqntesLbzgB
        ZLIV/Mki40we1MaJOaEw4PJuN19pmujdZoE907RAhaC36FrJ7XigqxurbZoSzM1TZXZ4zQ
        n5Xwt3jzWxKXYCzV8CR2AQIVjokb1ctZlPPb92L0b3ELj4cF1sNV2gl9KLgiNqeYkycYpF
        uJNdPayzyxqDRwGilHzJoTqxwCj8zTYKXYxdx7PQ6TbHZt8LonyjKCEkBekluNXPyjfqBH
        Xptpv7EI5Kv6VGetsY+zwItYkI/2KdNAwod1polDssznrN+AWr8LUMqXWiYpPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=t/L3bect6Otcyaj5o3pOpna8DPyPttA1iOCagOeFNh8=;
        b=5GlBKX2jwhx+qkHdtSvbhhsoVE/Kwc8V/8tOf3y1uo87BiuMCpniEuDny/pl1Ro5kOW7Kr
        fkYICB6MZllCxjDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sinan Kaya <okaya@kernel.org>, dmaengine@vger.kernel.org,
        Santosh Shilimkar <ssantosh@kernel.org>,
        iommu@lists.linux-foundation.org,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [patch 37/37] dmaengine: qcom_hidma: Cleanup MSI handling
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:21:05 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There is no reason to walk the MSI descriptors to retrieve the interrupt
number for a device. Use msi_get_virq() instead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Sinan Kaya <okaya@kernel.org>
Cc: dmaengine@vger.kernel.org
---
 drivers/dma/qcom/hidma.c |   42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -678,11 +678,13 @@ static void hidma_free_msis(struct hidma
 {
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
 	struct device *dev = dmadev->ddev.dev;
-	struct msi_desc *desc;
+	int i, virq;
 
-	/* free allocated MSI interrupts above */
-	for_each_msi_entry(desc, dev)
-		devm_free_irq(dev, desc->irq, &dmadev->lldev);
+	for (i = 0; i < HIDMA_MSI_INTS; i++) {
+		virq = msi_get_virq(dev, i);
+		if (virq)
+			devm_free_irq(dev, virq, &dmadev->lldev);
+	}
 
 	platform_msi_domain_free_irqs(dev);
 #endif
@@ -692,45 +694,37 @@ static int hidma_request_msi(struct hidm
 			     struct platform_device *pdev)
 {
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
-	int rc;
-	struct msi_desc *desc;
-	struct msi_desc *failed_desc = NULL;
+	int rc, i, virq;
 
 	rc = platform_msi_domain_alloc_irqs(&pdev->dev, HIDMA_MSI_INTS,
 					    hidma_write_msi_msg);
 	if (rc)
 		return rc;
 
-	for_each_msi_entry(desc, &pdev->dev) {
-		if (!desc->msi_index)
-			dmadev->msi_virqbase = desc->irq;
-
-		rc = devm_request_irq(&pdev->dev, desc->irq,
+	for (i = 0; i < HIDMA_MSI_INTS; i++) {
+		virq = msi_get_virq(&pdev->dev, i);
+		rc = devm_request_irq(&pdev->dev, virq,
 				       hidma_chirq_handler_msi,
 				       0, "qcom-hidma-msi",
 				       &dmadev->lldev);
-		if (rc) {
-			failed_desc = desc;
+		if (rc)
 			break;
-		}
+		if (!i)
+			dmadev->msi_virqbase = virq;
 	}
 
 	if (rc) {
 		/* free allocated MSI interrupts above */
-		for_each_msi_entry(desc, &pdev->dev) {
-			if (desc == failed_desc)
-				break;
-			devm_free_irq(&pdev->dev, desc->irq,
-				      &dmadev->lldev);
+		for (--i; i >= 0; i--) {
+			virq = msi_get_virq(&pdev->dev, i);
+			devm_free_irq(&pdev->dev, virq, &dmadev->lldev);
 		}
+		dev_warn(&pdev->dev,
+			 "failed to request MSI irq, falling back to wired IRQ\n");
 	} else {
 		/* Add callback to free MSIs on teardown */
 		hidma_ll_setup_irq(dmadev->lldev, true);
-
 	}
-	if (rc)
-		dev_warn(&pdev->dev,
-			 "failed to request MSI irq, falling back to wired IRQ\n");
 	return rc;
 #else
 	return -EINVAL;

