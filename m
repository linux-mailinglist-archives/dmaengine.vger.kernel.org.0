Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA9B1AAF85
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2020 19:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410983AbgDOR1W (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Apr 2020 13:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410875AbgDOR1V (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Apr 2020 13:27:21 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B580C061A0F
        for <dmaengine@vger.kernel.org>; Wed, 15 Apr 2020 10:27:21 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a32so124568pje.5
        for <dmaengine@vger.kernel.org>; Wed, 15 Apr 2020 10:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=nY+69lch1Z1eEPsftYngAsdf1DrodOInXT0dD8s9W9c=;
        b=aTrc5dlcIr5Ec1JUMT00OHAtdS1DFD55M4o5HR4FrmM1TrFAZwNiv1oXURyyBNI504
         c4AHjTusPxJMk+Y/TcYfuWbhAnkaYpXYSQcvng0B+6ZkEHKHQqW0mNBQvOYT3adUhrsz
         8FXC3Zoe7wen3sq2Amxl1G9uqE0Pkokfy6qfaw0cyoPYamtvNBrc3XeUhGcUK0EBEjk8
         /h8yRYT+DwivZKTkRyljziAVQM9lA5FG2GWAGQZVhkiuLclUKvgb0O1Hv8xxJcgfaE/7
         5Vkhn4UZL/sYV84G9k+qu3vq/FtPwfpSEKxwIBgcwNKZAFyJ8y6AtAUoi8PkVFi384JU
         sd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nY+69lch1Z1eEPsftYngAsdf1DrodOInXT0dD8s9W9c=;
        b=LDr39qmjbkVorHyC8JbzvGWLldLMnUCzGU49w8NMRN9tG+hsvpTMSkv4uzYISzcUel
         b/fmeJ9M7+pCvtoBlqnB8DPeOlpJtEpfD0X0YkiDmieUdu+bs7WADYNP8X8ldMKeazFJ
         4sMnE2ztYMCcnT3xT80iwlwpFifOojoE3gL5Hhaq0i4VCZwVfk0UAqOqy0Bxhbi9sfoX
         U+zOXOybGXU37azX/eIbdOT2SzDNhXVaSj+51xyajvEJa9dD5EWRVCl5lGYbm/w0U2YG
         UU75Pi7JHlDQMZB65ZuUlBIopRUcGxvxeU7KEco2rsAiKC7ixI0Dd9L0/0/+icu/jgyv
         keOw==
X-Gm-Message-State: AGi0PubBrLGxoyxyLQMGtPMMlMSSKpDTTm2zuC+re1zkceVTWvteN0B9
        KNlj97Sv2z7rpsvqkM0fohf+30XnmpU=
X-Google-Smtp-Source: APiQypJ3S4C89ZxzgEPCaieC6l6nSM9XM24BPwWjPdz80Q0NxTt/+zK9YejYVXMmInn12hTEr/Auiw==
X-Received: by 2002:a17:90a:5d02:: with SMTP id s2mr326816pji.148.1586971640606;
        Wed, 15 Apr 2020 10:27:20 -0700 (PDT)
Received: from nuc7.sifive.com (c-24-5-48-146.hsd1.ca.comcast.net. [24.5.48.146])
        by smtp.gmail.com with ESMTPSA id e66sm10784808pfa.69.2020.04.15.10.27.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2020 10:27:19 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, gustavo.pimentel@synopsys.com,
        dan.j.williams@intel.com, vkoul@kernel.org, kishon@ti.com,
        paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH v2] dmaengine: dw-edma: Decouple dw-edma-core.c from struct pci_dev
Date:   Wed, 15 Apr 2020 10:27:09 -0700
Message-Id: <1586971629-30196-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Alan Mikhak <alan.mikhak@sifive.com>

Decouple dw-edma-core.c from struct pci_dev as a step toward integration
of dw-edma with pci-epf-test so the latter can initiate dma operations
locally from the endpoint side. A barrier to such integration is the
dependency of dw_edma_probe() and other functions in dw-edma-core.c on
struct pci_dev.

The Synopsys DesignWare dw-edma driver was designed to run on host side
of PCIe link to initiate DMA operations remotely using eDMA channels of
PCIe controller on the endpoint side. This can be inferred from seeing
that dw-edma uses struct pci_dev and accesses hardware registers of dma
channels across the bus using BAR0 and BAR2.

The ops field of struct dw_edma in dw-edma-core.h is currenty undefined:

const struct dw_edma_core_ops   *ops;

However, the kernel builds without failure even when dw-edma driver is
enabled. Instead of removing the currently undefined and usued ops field,
define struct dw_edma_core_ops and use the ops field to decouple
dw-edma-core.c from struct pci_dev.

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 29 ++++++++++++++++++++---------
 drivers/dma/dw-edma/dw-edma-core.h |  4 ++++
 drivers/dma/dw-edma/dw-edma-pcie.c | 10 ++++++++++
 3 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index ff392c01bad1..db401eb11322 100644
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
 
@@ -827,12 +827,23 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 
 int dw_edma_probe(struct dw_edma_chip *chip)
 {
-	struct device *dev = chip->dev;
-	struct dw_edma *dw = chip->dw;
+	struct device *dev;
+	struct dw_edma *dw;
 	u32 wr_alloc = 0;
 	u32 rd_alloc = 0;
 	int i, err;
 
+	if (!chip)
+		return -EINVAL;
+
+	dev = chip->dev;
+	if (!dev)
+		return -EINVAL;
+
+	dw = chip->dw;
+	if (!dw || !dw->irq || !dw->ops || !dw->ops->irq_vector)
+		return -EINVAL;
+
 	raw_spin_lock_init(&dw->lock);
 
 	/* Find out how many write channels are supported by hardware */
@@ -884,7 +895,7 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 
 err_irq_free:
 	for (i = (dw->nr_irqs - 1); i >= 0; i--)
-		free_irq(pci_irq_vector(to_pci_dev(dev), i), &dw->irq[i]);
+		free_irq(dw->ops->irq_vector(dev, i), &dw->irq[i]);
 
 	dw->nr_irqs = 0;
 
@@ -904,7 +915,7 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 
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

