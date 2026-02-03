Return-Path: <dmaengine+bounces-8690-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBxaGUfsgWkFMAMAu9opvQ
	(envelope-from <dmaengine+bounces-8690-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 13:38:31 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A25D9198
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 13:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D9EE307DD28
	for <lists+dmaengine@lfdr.de>; Tue,  3 Feb 2026 12:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B7D320CB6;
	Tue,  3 Feb 2026 12:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HADU9Iic"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EAC1C69D;
	Tue,  3 Feb 2026 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770121966; cv=none; b=ZRarUPtvP/v6smHbpgXC2euUTLVvJbQ0X5fal2VtJCEWqXmUbCt1DlsAa4uSe4UWA1pR/oOCN88dLus26Eue2ZP3LA6m6U3Y+R4bvRPb6wikQgZ90a5uTj1/Rb7JI/qNoorF1xHW03mKaZlYwxw2nWX8nqX3ysfMOeP2N7iGJdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770121966; c=relaxed/simple;
	bh=qwUeW/HnUqGK5tWdwUybUJOYaW9EOsSLIRupZbdHJxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cgCBZSCBPQWcuysOUr0BMoX5ShREfAUQAsHHOBPHGrMbQCeA6XAWMqR9EFvE66vfQlpbUx6nmTfCN5dMoHD8ahPUEo6B+8G2keD3RY40bSN82UGpuU6U1r/krq34b8NKcioOTm8HjAFLGc5FlKFHVPeR0jZd600wiCA2CR1a08g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HADU9Iic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CCCC116D0;
	Tue,  3 Feb 2026 12:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770121965;
	bh=qwUeW/HnUqGK5tWdwUybUJOYaW9EOsSLIRupZbdHJxo=;
	h=From:To:Cc:Subject:Date:From;
	b=HADU9Iic2EbGl1GEOjaK0lL8RgyO/5quc88weC1IU+BQKNztuoFOUKxqkg87uwCR+
	 rJAhIo6Cgph3Zv+pmPpIkL0AXMYNjiu/L1OhtXu2UabxlbA7XaGT6g8E2idnqPxBXo
	 YDOBhjAh6/k3w58mw1nfm2nd0pOHHPU0zipS6ufvdGxlwdRqqSh8eGhga/GKfwsVQ7
	 v0nNCgD1iqUciShf8NpIQh93pvqr1aggixYhhaO9bww1HDIaC7ly5oG1nZJ3tF1tkK
	 6iMSNcIhe9GWQgcn4Z+8AM7b8Vnh1JjxuyMrxGaUDAhiDmOubws64IxYCksB9vK1Ux
	 uGKiwDO27m/VA==
From: Philipp Stanner <phasta@kernel.org>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>
Subject: [PATCH] dmaengine: amd: Replace deprecated PCI functions
Date: Tue,  3 Feb 2026 13:32:39 +0100
Message-ID: <20260203123238.88598-2-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8690-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phasta@kernel.org,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2A25D9198
X-Rspamd-Action: no action

ae4dma and ptdma make use of pcim_iomap_table(), a deprecated,
problematic PCI function.

Both drivers currently request all IORESOURCE_MEM BARs, and ioremap only
a single bar.

Replace the deprecated function while keeping the aforementioned
behavior identical.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
If it's deemed unnecessary to do the region requests, we could further
simplify the code.

Compiled, not tested.

P.
---
 drivers/dma/amd/ae4dma/ae4dma-pci.c | 17 +++++++++++------
 drivers/dma/amd/ptdma/ptdma-pci.c   | 27 ++++++++++++---------------
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/dma/amd/ae4dma/ae4dma-pci.c b/drivers/dma/amd/ae4dma/ae4dma-pci.c
index 2c63907db228..872011d4dd37 100644
--- a/drivers/dma/amd/ae4dma/ae4dma-pci.c
+++ b/drivers/dma/amd/ae4dma/ae4dma-pci.c
@@ -10,6 +10,8 @@
 
 #include "ae4dma.h"
 
+#define DRIVER_NAME "ae4dma"
+
 static int ae4_get_irqs(struct ae4_device *ae4)
 {
 	struct ae4_msix *ae4_msix = ae4->ae4_msix;
@@ -75,9 +77,10 @@ static int ae4_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct device *dev = &pdev->dev;
 	struct ae4_device *ae4;
+	unsigned long bar_mask
 	struct pt_device *pt;
-	int bar_mask;
 	int ret = 0;
+	int bar;
 
 	ae4 = devm_kzalloc(dev, sizeof(*ae4), GFP_KERNEL);
 	if (!ae4)
@@ -92,15 +95,17 @@ static int ae4_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto ae4_error;
 
 	bar_mask = pci_select_bars(pdev, IORESOURCE_MEM);
-	ret = pcim_iomap_regions(pdev, bar_mask, "ae4dma");
-	if (ret)
-		goto ae4_error;
+	for_each_set_bit(bar, &bar_mask, sizeof(bar_mask)) {
+		ret = pcim_request_region(pdev, bar, DRIVER_NAME);
+		if (ret)
+			goto ae4_error;
+	}
 
 	pt = &ae4->pt;
 	pt->dev = dev;
 	pt->ver = AE4_DMA_VERSION;
 
-	pt->io_regs = pcim_iomap_table(pdev)[0];
+	pt->io_regs = pcim_iomap(pdev, 0, 0);
 	if (!pt->io_regs) {
 		ret = -ENOMEM;
 		goto ae4_error;
@@ -144,7 +149,7 @@ static const struct pci_device_id ae4_pci_table[] = {
 MODULE_DEVICE_TABLE(pci, ae4_pci_table);
 
 static struct pci_driver ae4_pci_driver = {
-	.name = "ae4dma",
+	.name = DRIVER_NAME,
 	.id_table = ae4_pci_table,
 	.probe = ae4_pci_probe,
 	.remove = ae4_pci_remove,
diff --git a/drivers/dma/amd/ptdma/ptdma-pci.c b/drivers/dma/amd/ptdma/ptdma-pci.c
index 22739ff0c3c5..d1c1c14b9292 100644
--- a/drivers/dma/amd/ptdma/ptdma-pci.c
+++ b/drivers/dma/amd/ptdma/ptdma-pci.c
@@ -23,6 +23,8 @@
 
 #include "ptdma.h"
 
+#define DRIVER_NAME ptdma
+
 struct pt_msix {
 	int msix_count;
 	struct msix_entry msix_entry;
@@ -123,9 +125,9 @@ static int pt_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct pt_device *pt;
 	struct pt_msix *pt_msix;
 	struct device *dev = &pdev->dev;
-	void __iomem * const *iomap_table;
-	int bar_mask;
+	unsigned long bar_mask;
 	int ret = -ENOMEM;
+	int bar;
 
 	pt = pt_alloc_struct(dev);
 	if (!pt)
@@ -150,20 +152,15 @@ static int pt_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	bar_mask = pci_select_bars(pdev, IORESOURCE_MEM);
-	ret = pcim_iomap_regions(pdev, bar_mask, "ptdma");
-	if (ret) {
-		dev_err(dev, "pcim_iomap_regions failed (%d)\n", ret);
-		goto e_err;
+	for_each_set_bit(bar, &bar_mask, sizeof(bar_mask)) {
+		ret = pcim_request_region(pdev, bar, DRIVER_NAME);
+		if (ret) {
+			dev_err(dev, "pcim_iomap_regions failed (%d)\n", ret);
+			goto e_err;
+		}
 	}
 
-	iomap_table = pcim_iomap_table(pdev);
-	if (!iomap_table) {
-		dev_err(dev, "pcim_iomap_table failed\n");
-		ret = -ENOMEM;
-		goto e_err;
-	}
-
-	pt->io_regs = iomap_table[pt->dev_vdata->bar];
+	pt->io_regs = pcim_iomap(pdev, pt->dev_vdata->bar, 0);
 	if (!pt->io_regs) {
 		dev_err(dev, "ioremap failed\n");
 		ret = -ENOMEM;
@@ -230,7 +227,7 @@ static const struct pci_device_id pt_pci_table[] = {
 MODULE_DEVICE_TABLE(pci, pt_pci_table);
 
 static struct pci_driver pt_pci_driver = {
-	.name = "ptdma",
+	.name = DRIVER_NAME,
 	.id_table = pt_pci_table,
 	.probe = pt_pci_probe,
 	.remove = pt_pci_remove,
-- 
2.49.0


