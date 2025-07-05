Return-Path: <dmaengine+bounces-5743-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E48FAFA0CF
	for <lists+dmaengine@lfdr.de>; Sat,  5 Jul 2025 18:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C041BC6351
	for <lists+dmaengine@lfdr.de>; Sat,  5 Jul 2025 16:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3804B1CEEBE;
	Sat,  5 Jul 2025 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsKz44Xh"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87486156C40;
	Sat,  5 Jul 2025 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751731270; cv=none; b=SHP5Ztk2YWLdnMKOhPCbRdTky9F+7MtB2LLphsq9VmbCY/DQNDH8lPcDEAlRKd7RzoQPIX0kh9a4TDX/oxQr3KLCMBG8ZkU15xxZeWzgeoUqTRo8SmWIo0D29dYIDm55UIL6AQJZ0s1i1rfeb+8MYPBJ0JfXxSOsIrRBnfA3oLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751731270; c=relaxed/simple;
	bh=ZwlYSDrR6cRq1lX8xrIs6L01c2NSiRskHUJTkqM+BLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fhcv9iJueRuuUmxJgKblAOqMKQdIFAx5wi8RQyqI8ZQT+kAam7/cu8cUrEWQucK1dem234cEEOHeqICLFL/0OJGswCVs7itlRKuB752qIP1RCnLWTCNlUrvr4tYxJAHo5YgwnH3EOSwsI+dJa1lLuTn8r4BOF8vfVoIjN92jmgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsKz44Xh; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23c703c471dso24146055ad.0;
        Sat, 05 Jul 2025 09:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751731268; x=1752336068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PczZ2yQWpsqzC7ti5geiTXw4UnZuMfFlqf02EPlXpYI=;
        b=ZsKz44XhgzWmEfiLozuqwzn3ArTLkGdiJdwMwMAE0rSLiAy+hv2q21Fe6rKr/oAw1+
         1fT8Krj+/s7BWB3Zh2BfE1IgIb3b7Bm1vVLlS+juvUxEoeEhLZWNUDexzrjeg9pUV4As
         4j3NdkHW44fYoSiawQBRUeKNZq5VPUv9ZhlW1RYU9OSrg6Nu+Z0KMsoTF+P9fjRBaUK2
         6MKdIRi0Xetz4nFy6JjSbU08xY3OCNiAyl5NgbM+UiTNICu2PTlPzTP7tYQ0/rRBDCO9
         hXg0ApGs9SbN9VmLEy9mh8cBxdH0ngIMaJQFqHk/Qfv58Jp1s91qUSjdcUdaCB5zFjMq
         +XyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751731268; x=1752336068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PczZ2yQWpsqzC7ti5geiTXw4UnZuMfFlqf02EPlXpYI=;
        b=LZsFj1IEvW++BpSwxLijrak2cQG8dapngooE0NyIJV6LiusEphiF0lBjzYgSxQijM0
         yWNlKMswYZkTu/PC/kg865o6/Bxqn+RDkT6jJ/I9kdLP2ejgqFqXUNEHmGaUS9uTTAbb
         RIUxt9wdTmedkswmjpFguNgamaTQgyuRwSddH/tjGADP5dT9uwa/6H2PLK6QBj7kMWjQ
         jv5wjJsjrx7uTOGJhhFzCtchK/wlhMufKj4k2v3ZRMdZsBQPxTlfQX6YpDViE0gFpq+S
         0eT79n+j7X7U4v2lXC0lGyUsNuqA6Ye32vmO8CMiMbQYQFNoOXjcAuNMVogPfNisRKT7
         ZX2w==
X-Forwarded-Encrypted: i=1; AJvYcCUO4MqlTZiINY1KDU5Z/epInyUnjcRfcT7IAvt2hh5s/ZuZb7k7kA+Umqc17C1OZcRZ3C8AuYf86Lhqd/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmSQD0Q8Lt4NI7ZL49U+N34Z1Xqt7CTz/zX8LBuOCG4s782/66
	71XIgU2bqOoNVtLKwArAqU9aOrUNiQU3dVoahjmy2T3OsKGFzszT0JggDlRaDe0D
X-Gm-Gg: ASbGncsYhYac0PVrD2AeYz+hXWoZtNU4xSPvpWe4K2r14wvCk7BGJfdtl7vKA2fbO3P
	4I0DgmLYE2bXx720VedZxsU6NofFzkoUgCY7SP0B2RKtlCmYnkveNx6BFWes06lTb0VdbjqN2/x
	VafvEixl07LAU78RHt7ak5MwBidDmqXXW626UQ6UDbD5XT4lX4VhH70LdTL6LOkIgldEvfxLald
	Aexs/iinb5nmbeHBoWTi7crAEv88TPtkd6dOzppC6kKcpJ2okptl8v2JIevim516DIgoUoAuPJL
	Ha5bDFVEH4QvJd+o1C3NTEACs2RJ+dKmV/NrljC/f6q+NkNbnnq7e3M0liXrQW/jr6GcjdBLVSv
	wMtufW6Z++qdxIY4=
X-Google-Smtp-Source: AGHT+IFxKBixgyWEyAxhwG1ktTeSupr+ZtlzFnIhOBHnU1mn2wsmpVsDPUBoZi5gGf/hGYRV2MxM5w==
X-Received: by 2002:a17:903:3212:b0:231:fd73:f8e5 with SMTP id d9443c01a7336-23c8a505280mr50159465ad.24.1751731267590;
        Sat, 05 Jul 2025 09:01:07 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:882f:293:70ba:30fe:2559:8217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c845c5c73sm44811275ad.259.2025.07.05.09.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 09:01:07 -0700 (PDT)
From: Abinash Singh <abinashlalotra@gmail.com>
X-Google-Original-From: Abinash Singh <abinashsinghlalotra@gmail.com>
To: mani@kernel.org,
	vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abinash Singh <abinashsinghlalotra@gmail.com>
Subject: [PATCH RFC] dma: dw-edma: Fix build warning in dw_edma_pcie_probe()
Date: Sat,  5 Jul 2025 21:30:55 +0530
Message-ID: <20250705160055.808165-1-abinashsinghlalotra@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function dw_edma_pcie_probe() in dw-edma-pcie.c triggered a
frame size warning:
ld.lld:warning:
  drivers/dma/dw-edma/dw-edma-pcie.c:162:0: stack frame size (1040) exceeds limit (1024) in function 'dw_edma_pcie_probe'

This patch reduces the stack usage by dynamically allocating the
`vsec_data` structure using kmalloc(), rather than placing it on
the stack. This eliminates the overflow warning and improves kernel
robustness.

Signed-off-by: Abinash Singh <abinashsinghlalotra@gmail.com>
---
The stack usage was further confirmed by using -fstack-usage flag.
it was usiing 928 bytes:
..............................
drivers/dma/dw-edma/dw-edma-pcie.c:377:cleanup_module   8       static
drivers/dma/dw-edma/dw-edma-pcie.c:160:dw_edma_pcie_probe       928     static
......................................
After applying the patch it becomes :
.........
drivers/dma/dw-edma/dw-edma-pcie.c:381:cleanup_module   8       static
drivers/dma/dw-edma/dw-edma-pcie.c:160:dw_edma_pcie_probe       120     static
.......

This function is used for probing . So dynamic allocation will not create
any issues.

Thank You
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 60 ++++++++++++++++--------------
 1 file changed, 32 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 49f09998e5c0..1536395eacd2 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -161,12 +161,16 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			      const struct pci_device_id *pid)
 {
 	struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
-	struct dw_edma_pcie_data vsec_data;
+	struct dw_edma_pcie_data *vsec_data __free(kfree) = NULL;
 	struct device *dev = &pdev->dev;
 	struct dw_edma_chip *chip;
 	int err, nr_irqs;
 	int i, mask;
 
+	vsec_data = kmalloc(sizeof(*vsec_data), GFP_KERNEL);
+	if (!vsec_data)
+		return -ENOMEM;
+
 	/* Enable PCI device */
 	err = pcim_enable_device(pdev);
 	if (err) {
@@ -174,23 +178,23 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		return err;
 	}
 
-	memcpy(&vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
+	memcpy(vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
 
 	/*
 	 * Tries to find if exists a PCIe Vendor-Specific Extended Capability
 	 * for the DMA, if one exists, then reconfigures it.
 	 */
-	dw_edma_pcie_get_vsec_dma_data(pdev, &vsec_data);
+	dw_edma_pcie_get_vsec_dma_data(pdev, vsec_data);
 
 	/* Mapping PCI BAR regions */
-	mask = BIT(vsec_data.rg.bar);
-	for (i = 0; i < vsec_data.wr_ch_cnt; i++) {
-		mask |= BIT(vsec_data.ll_wr[i].bar);
-		mask |= BIT(vsec_data.dt_wr[i].bar);
+	mask = BIT(vsec_data->rg.bar);
+	for (i = 0; i < vsec_data->wr_ch_cnt; i++) {
+		mask |= BIT(vsec_data->ll_wr[i].bar);
+		mask |= BIT(vsec_data->dt_wr[i].bar);
 	}
-	for (i = 0; i < vsec_data.rd_ch_cnt; i++) {
-		mask |= BIT(vsec_data.ll_rd[i].bar);
-		mask |= BIT(vsec_data.dt_rd[i].bar);
+	for (i = 0; i < vsec_data->rd_ch_cnt; i++) {
+		mask |= BIT(vsec_data->ll_rd[i].bar);
+		mask |= BIT(vsec_data->dt_rd[i].bar);
 	}
 	err = pcim_iomap_regions(pdev, mask, pci_name(pdev));
 	if (err) {
@@ -213,7 +217,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		return -ENOMEM;
 
 	/* IRQs allocation */
-	nr_irqs = pci_alloc_irq_vectors(pdev, 1, vsec_data.irqs,
+	nr_irqs = pci_alloc_irq_vectors(pdev, 1, vsec_data->irqs,
 					PCI_IRQ_MSI | PCI_IRQ_MSIX);
 	if (nr_irqs < 1) {
 		pci_err(pdev, "fail to alloc IRQ vector (number of IRQs=%u)\n",
@@ -224,22 +228,22 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	/* Data structure initialization */
 	chip->dev = dev;
 
-	chip->mf = vsec_data.mf;
+	chip->mf = vsec_data->mf;
 	chip->nr_irqs = nr_irqs;
 	chip->ops = &dw_edma_pcie_plat_ops;
 
-	chip->ll_wr_cnt = vsec_data.wr_ch_cnt;
-	chip->ll_rd_cnt = vsec_data.rd_ch_cnt;
+	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
+	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
 
-	chip->reg_base = pcim_iomap_table(pdev)[vsec_data.rg.bar];
+	chip->reg_base = pcim_iomap_table(pdev)[vsec_data->rg.bar];
 	if (!chip->reg_base)
 		return -ENOMEM;
 
 	for (i = 0; i < chip->ll_wr_cnt; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
 		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
-		struct dw_edma_block *ll_block = &vsec_data.ll_wr[i];
-		struct dw_edma_block *dt_block = &vsec_data.dt_wr[i];
+		struct dw_edma_block *ll_block = &vsec_data->ll_wr[i];
+		struct dw_edma_block *dt_block = &vsec_data->dt_wr[i];
 
 		ll_region->vaddr.io = pcim_iomap_table(pdev)[ll_block->bar];
 		if (!ll_region->vaddr.io)
@@ -263,8 +267,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	for (i = 0; i < chip->ll_rd_cnt; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
 		struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
-		struct dw_edma_block *ll_block = &vsec_data.ll_rd[i];
-		struct dw_edma_block *dt_block = &vsec_data.dt_rd[i];
+		struct dw_edma_block *ll_block = &vsec_data->ll_rd[i];
+		struct dw_edma_block *dt_block = &vsec_data->dt_rd[i];
 
 		ll_region->vaddr.io = pcim_iomap_table(pdev)[ll_block->bar];
 		if (!ll_region->vaddr.io)
@@ -298,31 +302,31 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		pci_dbg(pdev, "Version:\tUnknown (0x%x)\n", chip->mf);
 
 	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p)\n",
-		vsec_data.rg.bar, vsec_data.rg.off, vsec_data.rg.sz,
+		vsec_data->rg.bar, vsec_data->rg.off, vsec_data->rg.sz,
 		chip->reg_base);
 
 
 	for (i = 0; i < chip->ll_wr_cnt; i++) {
 		pci_dbg(pdev, "L. List:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
-			i, vsec_data.ll_wr[i].bar,
-			vsec_data.ll_wr[i].off, chip->ll_region_wr[i].sz,
+			i, vsec_data->ll_wr[i].bar,
+			vsec_data->ll_wr[i].off, chip->ll_region_wr[i].sz,
 			chip->ll_region_wr[i].vaddr.io, &chip->ll_region_wr[i].paddr);
 
 		pci_dbg(pdev, "Data:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
-			i, vsec_data.dt_wr[i].bar,
-			vsec_data.dt_wr[i].off, chip->dt_region_wr[i].sz,
+			i, vsec_data->dt_wr[i].bar,
+			vsec_data->dt_wr[i].off, chip->dt_region_wr[i].sz,
 			chip->dt_region_wr[i].vaddr.io, &chip->dt_region_wr[i].paddr);
 	}
 
 	for (i = 0; i < chip->ll_rd_cnt; i++) {
 		pci_dbg(pdev, "L. List:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
-			i, vsec_data.ll_rd[i].bar,
-			vsec_data.ll_rd[i].off, chip->ll_region_rd[i].sz,
+			i, vsec_data->ll_rd[i].bar,
+			vsec_data->ll_rd[i].off, chip->ll_region_rd[i].sz,
 			chip->ll_region_rd[i].vaddr.io, &chip->ll_region_rd[i].paddr);
 
 		pci_dbg(pdev, "Data:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
-			i, vsec_data.dt_rd[i].bar,
-			vsec_data.dt_rd[i].off, chip->dt_region_rd[i].sz,
+			i, vsec_data->dt_rd[i].bar,
+			vsec_data->dt_rd[i].off, chip->dt_region_rd[i].sz,
 			chip->dt_region_rd[i].vaddr.io, &chip->dt_region_rd[i].paddr);
 	}
 
-- 
2.43.0


