Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D951A90C0
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2020 04:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392847AbgDOCH6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Apr 2020 22:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392789AbgDOCH5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Apr 2020 22:07:57 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC414C061A0F
        for <dmaengine@vger.kernel.org>; Tue, 14 Apr 2020 19:07:55 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t40so6033360pjb.3
        for <dmaengine@vger.kernel.org>; Tue, 14 Apr 2020 19:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=u2+cGS1cRmAclSEhKu1ZjnWLakz4YOOfQzuWAv57OAM=;
        b=XCsJXqiLpCpNyksP4j7p6/CF+p6B1Z/TWHZg7DYLvgKLnFfZq6jrVa0Ro2XOLyq05O
         Mr2GOMBFAVcJ8mb9nIaT/cRwsrBdMOmCPZiD4j4d4XM0LBomAJuXe9CBFklYjV6y6OqR
         fi9MYbiUUFCczPMZtvUkoM0WNzpjX6SaWp5aI43UP3oJEz8Dd7gmaO/EW1ki3BqssLRt
         xhfQWS0+otSmtaf3zBU9higbiMsGbWY5+ZnKVPzaMJ4MisDEr0FJCZGddqcnNcXvjz4v
         8K+WD/WTG+iCjEUSYbmflqi4H2UTd1n0MUtnG5iOpJ95qIE4wnAyDWCwCv4sqth7tgwY
         pvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u2+cGS1cRmAclSEhKu1ZjnWLakz4YOOfQzuWAv57OAM=;
        b=eURKh23b1hsQnFj2TNMVnpzu08Xf4NAtPAvZqsvJzmPIb4YTWmTR4Wv4hDAhxmSYuB
         epA8iX1kF/8ukhtyHfaYis7AlOabEAHMtGYnoVlxzoH5RdaF+XumnN8xVR7gYJO+pAAF
         xs9ntjiK02/NtKTWALZ/xt5qNhvZdvnwzBXA1JJ5oz7U8o56vSPp5cRqbr9y8o72i9lz
         MetSDsqv9NqHgxyyWw/4MX8GpTkqaqzJHxpcRaknjx2BTIv7fmbpeZu9ySH181BRMOpq
         PHlskL8ukAPdHMIvtbYjqwCRrNqltN3x+Tb62AFYlCNi00zhx3I5I1uaCF9YxGtI5IM0
         bdnw==
X-Gm-Message-State: AGi0PubqcEGBryB9Qx0VdYUKdqexAWE22qJH4Y6NOVifgZlZXgDmeuUz
        NNoShg1ADbK/67N8Ez4q7SpavcJlsxU=
X-Google-Smtp-Source: APiQypLwDxz25fW2RMa28aKt7qbLdqWW2OpYsgjIwGZ1SibtL9mtqYRYEgVoOjKKUJ2gK5kWcRBTRg==
X-Received: by 2002:a17:902:a503:: with SMTP id s3mr2821309plq.303.1586916474702;
        Tue, 14 Apr 2020 19:07:54 -0700 (PDT)
Received: from nuc7.sifive.com (c-24-5-48-146.hsd1.ca.comcast.net. [24.5.48.146])
        by smtp.gmail.com with ESMTPSA id v67sm8362776pfb.83.2020.04.14.19.07.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2020 19:07:53 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, gustavo.pimentel@synopsys.com,
        dan.j.williams@intel.com, vkoul@kernel.org, kishon@ti.com,
        paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH RFC] dmaengine: dw-edma: Decouple dw-edma-core.c from struct pci_dev
Date:   Tue, 14 Apr 2020 19:07:44 -0700
Message-Id: <1586916464-27727-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Alan Mikhak <alan.mikhak@sifive.com>

While reviewing the Synopsys Designware eDMA PCIe driver, I came across
the following field of struct dw_edma in dw-edma-core.h:

const struct dw_edma_core_ops	*ops;

I was unable to find a definition for struct dw_edma_core_ops. It was
surprising that the kernel would build without failure even though the
dw-edma driver was enabled with what seems to be an undefined struct.

The reason I was reviewing the dw-edma driver was to see if I could
integrate it with pcitest to initiate dma operations from endpoint side.

As I understand from reviewing the dw-edma code, it is designed to run
on the host side of PCIe link to initiate DMA operations remotely using
eDMA channels of PCIe controller on the endpoint side. I am not sure if
my understanding is correct. I infer this from seeing that dw-edma uses
struct pci_dev and accesses hardware registers of dma channels across the
bus using BAR0 and BAR2.

I was exploring what would need to change in dw-edma to integrate it with
pci-epf-test to initiate dma operations locally from the endpoint side.
One barrier I see is dw_edma_probe() and other functions in dw-edma-core.c
depend on struct pci_dev. Hence, instead of posting a patch to remove the
undefined and unused ops field, I would like to define the struct and use
it to decouple dw-edma-core.c from struct pci_dev.

To my surprise, the kernel still builds without error even after defining
struct dw_edma_core_ops in dw-edma-core.h and using it as in this patch.

I would appreciate any comments on my observations about the 'ops' field,
decoupling dw-edma-core.c from struct pci_dev, and how best to use
dw-edma with pcitest.

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 17 ++++++++++-------
 drivers/dma/dw-edma/dw-edma-core.h |  4 ++++
 drivers/dma/dw-edma/dw-edma-pcie.c | 10 ++++++++++
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index ff392c01bad1..9417a5feabbf 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -14,7 +14,7 @@
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/dma/edma.h>
-#include <linux/pci.h>
+#include <linux/dma-mapping.h>
 
 #include "dw-edma-core.h"
 #include "dw-edma-v0-core.h"
@@ -781,7 +781,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 
 	if (dw->nr_irqs == 1) {
 		/* Common IRQ shared among all channels */
-		err = request_irq(pci_irq_vector(to_pci_dev(dev), 0),
+		err = request_irq(dw->ops->irq_vector(dev, 0),
 				  dw_edma_interrupt_common,
 				  IRQF_SHARED, dw->name, &dw->irq[0]);
 		if (err) {
@@ -789,7 +789,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 			return err;
 		}
 
-		get_cached_msi_msg(pci_irq_vector(to_pci_dev(dev), 0),
+		get_cached_msi_msg(dw->ops->irq_vector(dev, 0),
 				   &dw->irq[0].msi);
 	} else {
 		/* Distribute IRQs equally among all channels */
@@ -804,7 +804,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 		dw_edma_add_irq_mask(&rd_mask, *rd_alloc, dw->rd_ch_cnt);
 
 		for (i = 0; i < (*wr_alloc + *rd_alloc); i++) {
-			err = request_irq(pci_irq_vector(to_pci_dev(dev), i),
+			err = request_irq(dw->ops->irq_vector(dev, i),
 					  i < *wr_alloc ?
 						dw_edma_interrupt_write :
 						dw_edma_interrupt_read,
@@ -815,7 +815,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 				return err;
 			}
 
-			get_cached_msi_msg(pci_irq_vector(to_pci_dev(dev), i),
+			get_cached_msi_msg(dw->ops->irq_vector(dev, i),
 					   &dw->irq[i].msi);
 		}
 
@@ -833,6 +833,9 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	u32 rd_alloc = 0;
 	int i, err;
 
+	if (!dw->ops || !dw->ops->irq_vector)
+		return -EINVAL;
+
 	raw_spin_lock_init(&dw->lock);
 
 	/* Find out how many write channels are supported by hardware */
@@ -884,7 +887,7 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 
 err_irq_free:
 	for (i = (dw->nr_irqs - 1); i >= 0; i--)
-		free_irq(pci_irq_vector(to_pci_dev(dev), i), &dw->irq[i]);
+		free_irq(dw->ops->irq_vector(dev, i), &dw->irq[i]);
 
 	dw->nr_irqs = 0;
 
@@ -904,7 +907,7 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 
 	/* Free irqs */
 	for (i = (dw->nr_irqs - 1); i >= 0; i--)
-		free_irq(pci_irq_vector(to_pci_dev(dev), i), &dw->irq[i]);
+		free_irq(dw->ops->irq_vector(dev, i), &dw->irq[i]);
 
 	/* Power management */
 	pm_runtime_disable(dev);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 4e5f9f6e901b..31fc50d31792 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -103,6 +103,10 @@ struct dw_edma_irq {
 	struct dw_edma			*dw;
 };
 
+struct dw_edma_core_ops {
+	int	(*irq_vector)(struct device *dev, unsigned int nr);
+};
+
 struct dw_edma {
 	char				name[20];
 
diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index dc85f55e1bb8..1eafc602e17e 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -54,6 +54,15 @@ static const struct dw_edma_pcie_data snps_edda_data = {
 	.irqs				= 1,
 };
 
+static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
+{
+	return pci_irq_vector(to_pci_dev(dev), nr);
+}
+
+static const struct dw_edma_core_ops dw_edma_pcie_core_ops = {
+	.irq_vector = dw_edma_pcie_irq_vector,
+};
+
 static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			      const struct pci_device_id *pid)
 {
@@ -151,6 +160,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	dw->version = pdata->version;
 	dw->mode = pdata->mode;
 	dw->nr_irqs = nr_irqs;
+	dw->ops = &dw_edma_pcie_core_ops;
 
 	/* Debug info */
 	pci_dbg(pdev, "Version:\t%u\n", dw->version);
-- 
2.7.4

