Return-Path: <dmaengine+bounces-9893-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGQfJHhB1GmRsQcAu9opvQ
	(envelope-from <dmaengine+bounces-9893-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 01:27:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8573A827F
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 01:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58622303DA1C
	for <lists+dmaengine@lfdr.de>; Mon,  6 Apr 2026 23:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EFF3A3801;
	Mon,  6 Apr 2026 23:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ePzKf5w8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DF839FCB3
	for <dmaengine@vger.kernel.org>; Mon,  6 Apr 2026 23:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775517947; cv=none; b=VUQ/FlilusSzXP61sRDlgG/BDhmlpxOAuGvD8DJkgfTCOt45Rd6ndGU6pK4/N5mT3kliugscqY0OuBCssTVUQcdYlgKPNrRSu2Obg9SNFWoxa0UoQol7K+7qnbhXCFm/t/BXVxiEPXRYK1srGbCDwUcq7sSqEzs/uBa57Xq23WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775517947; c=relaxed/simple;
	bh=WAk3CbC0UCD7Z2dahJaOEqxHzONEBbmkQeRy9YA3MaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8OHaWm/UXZecjwd9TeSOTNayYgsXuFTLBBr4yGL5Emnqv3dy9LX8fCqxl+HykhuLipuLCokM2f+kbHtHEHucTddBD3pCdhK8ALYYmfw0zdCqPYY6J7VNhkx+XCgRawHHhQb7SQBQ7Z3y1uwlxevvkoNCIV0EhaDZrR/trazlvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ePzKf5w8; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12c080efc1eso1279916c88.0
        for <dmaengine@vger.kernel.org>; Mon, 06 Apr 2026 16:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775517943; x=1776122743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFmDYcnnDgWKdH7Fx1pvQvOvhn076UMYFbFndXl8P/A=;
        b=ePzKf5w81yqM7EVF1K5T2ATgEnpdFaj9qeJGNty7kbDCwRJTfCMtdjZ4F2VsZM8z47
         8EhfA9BPXlKdzSSzwAG0s8ITVfxlHW3lnOEMEbrRS4qBriB3PQobNPk0ShzsbDcegvP4
         BTmCEWs3VyiDihKo0142o06idYEjtjG6sD61U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775517943; x=1776122743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qFmDYcnnDgWKdH7Fx1pvQvOvhn076UMYFbFndXl8P/A=;
        b=jcBMxMFmaoRxeMmWStIrhNSt75r1lHPM0t3NGOvD9M1S2AR9FNppYYr/UvinGLVzjC
         aU1SCmNj05scP9Ix0a5dAPjo7ZN7ScGEzEpCxtfO61fTw2NnqOCUm6d8zZ08XSIWd4T1
         MT0UuhKonVkTiU1aBpMV0eGKL467IP3Hf/eF2pG1xkxul/G+QgBON1FHDlKQQgJDrw+E
         Mabx6rJUXeygL5B29souMhdFrEraPfLij3l7oU5/ZujxOi2i1GyASNDaJWtx4Jsx2ghg
         TIc1Y+nA4SRQg3EH4O29Oq11/vnCRJXMY9cAwWyifrJ5xd+fvPYIIQM1x1rKG9AgrXNo
         IGwA==
X-Forwarded-Encrypted: i=1; AJvYcCVncpS2nZ3BwSc28YaFF8qNMZhiFrEnKGlcbJkA5NcouIt9QBhTVrIK07L1txAMmiavIS8lEchY738=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpXojhwsjUT98F4VHxMekEszTGKPjUqnGA/IV34tYoRo52T5s2
	YjBw0tQh5J0uxDosHmdtOluj3EGNEF3N5ds5O1loGxN0+skbKUpn8HxpXYiYGs7ZSOnBjWpKXc4
	DOFfAz+vm
X-Gm-Gg: AeBDievc4gQt5u2rtNAJXebWeKIP0DgvP69hFOj6lsK46ruSrwQm4BZpo6UtqI07M8H
	sDzEqHOeH7sTFSwrpiNyhE0H3rEpiZbrsGr4LbG/5ZBi/2dWYYvMNoCzGcVomVaGkrtVwL8Lojk
	rTOXmYD6aVbzzIDpoiP3nyxRhwivrDEks0vaZJzHR2ZYK4D1TQDOyhYqNN1ethjyVQTjqQao6bS
	f4rq6CLpUE6X4YQv5eTfqAj22QTJSHIQ6L84BVOwyZBXBFvZlG6j8Hc3MEcsOzWhji+jPy8FGSJ
	XYG7XzW3/ccahotkvo4p5uQR5or+f/ozwE4HCHgYVkf9V9Rw2KTIEEg/sXt0oXlpaSR6RBUYWJX
	9LiKjmjib07S1/W/GXBopcFe5qdM4vKuXemc9Um7XzdCMTEe6c3KGHgBQ7gtL+CBldVkfUxiGYn
	cKx1jJhV4w6Gqsxm9VXIc13VUlC6uI89YDqumT+7n8qzHcVnzhb6vAo45FhBl6m6ulO9hOFhYxI
	hAgU/bijPJjezqKxeG9
X-Received: by 2002:a05:693c:300c:b0:2be:acac:af7f with SMTP id 5a478bee46e88-2cad6ab1abfmr6524179eec.7.1775517943447;
        Mon, 06 Apr 2026 16:25:43 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:c071:3b78:5a5:824a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca760b0518sm14730975eec.0.2026.04.06.16.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 16:25:41 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
	Johan Hovold <johan@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	maz@kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank.Li@kernel.org,
	alex@ghiti.fr,
	andre.przywara@arm.com,
	andrew@lunn.ch,
	aou@eecs.berkeley.edu,
	catalin.marinas@arm.com,
	dmaengine@vger.kernel.org,
	driver-core@lists.linux.dev,
	gregory.clement@bootlin.com,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
	kees@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-snps-arc@lists.infradead.org,
	linux@armlinux.org.uk,
	m.szyprowski@samsung.com,
	palmer@dabbelt.com,
	peter.ujfalusi@gmail.com,
	pjw@kernel.org,
	sebastian.hesselbarth@gmail.com,
	tsbogend@alpha.franken.de,
	vgupta@kernel.org,
	will@kernel.org,
	willy@infradead.org
Subject: [PATCH v5 7/9] driver core: Replace dev->dma_coherent with dev_dma_coherent()
Date: Mon,  6 Apr 2026 16:23:00 -0700
Message-ID: <20260406162231.v5.7.If839f6dde98979fce177f70c6c74689a1904ee76@changeid>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To: <20260406232444.3117516-1-dianders@chromium.org>
References: <20260406232444.3117516-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[42];
	FREEMAIL_CC(0.00)[ozlabs.ru,kernel.org,google.com,lst.de,arm.com,intel.com,chromium.org,ghiti.fr,lunn.ch,eecs.berkeley.edu,vger.kernel.org,lists.linux.dev,bootlin.com,ziepe.ca,lists.infradead.org,armlinux.org.uk,samsung.com,dabbelt.com,gmail.com,alpha.franken.de,infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9893-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[chromium.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4C8573A827F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In C, bitfields are not necessarily safe to modify from multiple
threads without locking. Switch "dma_coherent" over to the "flags"
field so modifications are safe.

Cc: Christoph Hellwig <hch@lst.de>
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Acked-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Not fixing any known bugs; problem is theoretical and found by code
inspection. Change is done somewhat manually and only lightly tested
(mostly compile-time tested).

NOTE: even though previously we only took up a bit if
CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE, CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU,
or CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL, in this change I reserve the
bit unconditionally.  While we could get the "dynamic" behavior by
changing the flags definition to be an unnumbered "enum", Greg has
requested that the numbers be stable.

(no changes since v4)

Changes in v4:
- Use accessor functions for flags

Changes in v3:
- New

 arch/arc/mm/dma.c                 |  4 ++--
 arch/arm/mach-highbank/highbank.c |  2 +-
 arch/arm/mach-mvebu/coherency.c   |  2 +-
 arch/arm/mm/dma-mapping-nommu.c   |  4 ++--
 arch/arm/mm/dma-mapping.c         | 28 ++++++++++++++--------------
 arch/arm64/mm/dma-mapping.c       |  2 +-
 arch/mips/mm/dma-noncoherent.c    |  2 +-
 arch/riscv/mm/dma-noncoherent.c   |  2 +-
 drivers/base/core.c               |  2 +-
 drivers/dma/ti/k3-udma-glue.c     |  6 +++---
 drivers/dma/ti/k3-udma.c          |  6 +++---
 include/linux/device.h            | 11 ++++-------
 include/linux/dma-map-ops.h       |  2 +-
 13 files changed, 35 insertions(+), 38 deletions(-)

diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index 6b85e94f3275..9b9adb02b4c5 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -98,8 +98,8 @@ void arch_setup_dma_ops(struct device *dev, bool coherent)
 	 * DMA buffers.
 	 */
 	if (is_isa_arcv2() && ioc_enable && coherent)
-		dev->dma_coherent = true;
+		dev_set_dma_coherent(dev);
 
 	dev_info(dev, "use %scoherent DMA ops\n",
-		 dev->dma_coherent ? "" : "non");
+		 dev_dma_coherent(dev) ? "" : "non");
 }
diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 47335c7dadf8..8b7d0929dac4 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -98,7 +98,7 @@ static int highbank_platform_notifier(struct notifier_block *nb,
 	if (of_property_read_bool(dev->of_node, "dma-coherent")) {
 		val = readl(sregs_base + reg);
 		writel(val | 0xff01, sregs_base + reg);
-		dev->dma_coherent = true;
+		dev_set_dma_coherent(dev);
 	}
 
 	return NOTIFY_OK;
diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index fa2c1e1aeb96..7234d487ff39 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -95,7 +95,7 @@ static int mvebu_hwcc_notifier(struct notifier_block *nb,
 
 	if (event != BUS_NOTIFY_ADD_DEVICE)
 		return NOTIFY_DONE;
-	dev->dma_coherent = true;
+	dev_set_dma_coherent(dev);
 
 	return NOTIFY_OK;
 }
diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
index fecac107fd0d..c6a70686507b 100644
--- a/arch/arm/mm/dma-mapping-nommu.c
+++ b/arch/arm/mm/dma-mapping-nommu.c
@@ -42,11 +42,11 @@ void arch_setup_dma_ops(struct device *dev, bool coherent)
 		 * enough to check if MPU is in use or not since in absence of
 		 * MPU system memory map is used.
 		 */
-		dev->dma_coherent = cacheid ? coherent : true;
+		dev_assign_dma_coherent(dev, cacheid ? coherent : true);
 	} else {
 		/*
 		 * Assume coherent DMA in case MMU/MPU has not been set up.
 		 */
-		dev->dma_coherent = (get_cr() & CR_M) ? coherent : true;
+		dev_assign_dma_coherent(dev, (get_cr() & CR_M) ? coherent : true);
 	}
 }
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f304037d1c34..f9bc53b60f99 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1076,7 +1076,7 @@ static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
 	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
 	struct page **pages;
 	void *addr = NULL;
-	int coherent_flag = dev->dma_coherent ? COHERENT : NORMAL;
+	int coherent_flag = dev_dma_coherent(dev) ? COHERENT : NORMAL;
 
 	*handle = DMA_MAPPING_ERROR;
 	size = PAGE_ALIGN(size);
@@ -1124,7 +1124,7 @@ static int arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 	if (vma->vm_pgoff >= nr_pages)
 		return -ENXIO;
 
-	if (!dev->dma_coherent)
+	if (!dev_dma_coherent(dev))
 		vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot);
 
 	err = vm_map_pages(vma, pages, nr_pages);
@@ -1141,7 +1141,7 @@ static int arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 static void arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 	dma_addr_t handle, unsigned long attrs)
 {
-	int coherent_flag = dev->dma_coherent ? COHERENT : NORMAL;
+	int coherent_flag = dev_dma_coherent(dev) ? COHERENT : NORMAL;
 	struct page **pages;
 	size = PAGE_ALIGN(size);
 
@@ -1202,7 +1202,7 @@ static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
 		phys_addr_t phys = page_to_phys(sg_page(s));
 		unsigned int len = PAGE_ALIGN(s->offset + s->length);
 
-		if (!dev->dma_coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		if (!dev_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 			arch_sync_dma_for_device(sg_phys(s), s->length, dir);
 
 		prot = __dma_info_to_prot(dir, attrs);
@@ -1304,7 +1304,7 @@ static void arm_iommu_unmap_sg(struct device *dev,
 		if (sg_dma_len(s))
 			__iommu_remove_mapping(dev, sg_dma_address(s),
 					       sg_dma_len(s));
-		if (!dev->dma_coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		if (!dev_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 			arch_sync_dma_for_cpu(sg_phys(s), s->length, dir);
 	}
 }
@@ -1323,7 +1323,7 @@ static void arm_iommu_sync_sg_for_cpu(struct device *dev,
 	struct scatterlist *s;
 	int i;
 
-	if (dev->dma_coherent)
+	if (dev_dma_coherent(dev))
 		return;
 
 	for_each_sg(sg, s, nents, i)
@@ -1345,7 +1345,7 @@ static void arm_iommu_sync_sg_for_device(struct device *dev,
 	struct scatterlist *s;
 	int i;
 
-	if (dev->dma_coherent)
+	if (dev_dma_coherent(dev))
 		return;
 
 	for_each_sg(sg, s, nents, i)
@@ -1371,7 +1371,7 @@ static dma_addr_t arm_iommu_map_phys(struct device *dev, phys_addr_t phys,
 	dma_addr_t dma_addr;
 	int ret, prot;
 
-	if (!dev->dma_coherent &&
+	if (!dev_dma_coherent(dev) &&
 	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
 		arch_sync_dma_for_device(phys, size, dir);
 
@@ -1412,7 +1412,7 @@ static void arm_iommu_unmap_phys(struct device *dev, dma_addr_t handle,
 	if (!iova)
 		return;
 
-	if (!dev->dma_coherent &&
+	if (!dev_dma_coherent(dev) &&
 	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO))) {
 		phys_addr_t phys = iommu_iova_to_phys(mapping->domain, iova);
 
@@ -1431,7 +1431,7 @@ static void arm_iommu_sync_single_for_cpu(struct device *dev,
 	unsigned int offset = handle & ~PAGE_MASK;
 	phys_addr_t phys;
 
-	if (dev->dma_coherent || !iova)
+	if (dev_dma_coherent(dev) || !iova)
 		return;
 
 	phys = iommu_iova_to_phys(mapping->domain, iova);
@@ -1446,7 +1446,7 @@ static void arm_iommu_sync_single_for_device(struct device *dev,
 	unsigned int offset = handle & ~PAGE_MASK;
 	phys_addr_t phys;
 
-	if (dev->dma_coherent || !iova)
+	if (dev_dma_coherent(dev) || !iova)
 		return;
 
 	phys = iommu_iova_to_phys(mapping->domain, iova);
@@ -1701,13 +1701,13 @@ static void arm_teardown_iommu_dma_ops(struct device *dev) { }
 void arch_setup_dma_ops(struct device *dev, bool coherent)
 {
 	/*
-	 * Due to legacy code that sets the ->dma_coherent flag from a bus
-	 * notifier we can't just assign coherent to the ->dma_coherent flag
+	 * Due to legacy code that sets the dma_coherent flag from a bus
+	 * notifier we can't just assign coherent to the dma_coherent flag
 	 * here, but instead have to make sure we only set but never clear it
 	 * for now.
 	 */
 	if (coherent)
-		dev->dma_coherent = true;
+		dev_set_dma_coherent(dev);
 
 	/*
 	 * Don't override the dma_ops if they have already been set. Ideally
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index b2b5792b2caa..dc1fce939451 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -48,7 +48,7 @@ void arch_setup_dma_ops(struct device *dev, bool coherent)
 		   dev_driver_string(dev), dev_name(dev),
 		   ARCH_DMA_MINALIGN, cls);
 
-	dev->dma_coherent = coherent;
+	dev_assign_dma_coherent(dev, coherent);
 
 	xen_setup_dma_ops(dev);
 }
diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.c
index ab4f2a75a7d0..30ef3e247eb7 100644
--- a/arch/mips/mm/dma-noncoherent.c
+++ b/arch/mips/mm/dma-noncoherent.c
@@ -139,6 +139,6 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 #ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
 void arch_setup_dma_ops(struct device *dev, bool coherent)
 {
-	dev->dma_coherent = coherent;
+	dev_assign_dma_coherent(dev, coherent);
 }
 #endif
diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
index cb89d7e0ba88..a1ec2d71d1c9 100644
--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -140,7 +140,7 @@ void arch_setup_dma_ops(struct device *dev, bool coherent)
 		   "%s %s: device non-coherent but no non-coherent operations supported",
 		   dev_driver_string(dev), dev_name(dev));
 
-	dev->dma_coherent = coherent;
+	dev_assign_dma_coherent(dev, coherent);
 }
 
 void riscv_noncoherent_supported(void)
diff --git a/drivers/base/core.c b/drivers/base/core.c
index e94749092345..8a83d7c93361 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3173,7 +3173,7 @@ void device_initialize(struct device *dev)
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
-	dev->dma_coherent = dma_default_coherent;
+	dev_assign_dma_coherent(dev, dma_default_coherent);
 #endif
 	swiotlb_dev_init(dev);
 }
diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index f87d244cc2d6..686dc140293e 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -312,7 +312,7 @@ k3_udma_glue_request_tx_chn_common(struct device *dev,
 
 	if (xudma_is_pktdma(tx_chn->common.udmax)) {
 		/* prepare the channel device as coherent */
-		tx_chn->common.chan_dev.dma_coherent = true;
+		dev_set_dma_coherent(&tx_chn->common.chan_dev);
 		dma_coerce_mask_and_coherent(&tx_chn->common.chan_dev,
 					     DMA_BIT_MASK(48));
 	}
@@ -1003,7 +1003,7 @@ k3_udma_glue_request_rx_chn_priv(struct device *dev, const char *name,
 
 	if (xudma_is_pktdma(rx_chn->common.udmax)) {
 		/* prepare the channel device as coherent */
-		rx_chn->common.chan_dev.dma_coherent = true;
+		dev_set_dma_coherent(&rx_chn->common.chan_dev);
 		dma_coerce_mask_and_coherent(&rx_chn->common.chan_dev,
 					     DMA_BIT_MASK(48));
 	}
@@ -1104,7 +1104,7 @@ k3_udma_glue_request_remote_rx_chn_common(struct k3_udma_glue_rx_channel *rx_chn
 
 	if (xudma_is_pktdma(rx_chn->common.udmax)) {
 		/* prepare the channel device as coherent */
-		rx_chn->common.chan_dev.dma_coherent = true;
+		dev_set_dma_coherent(&rx_chn->common.chan_dev);
 		dma_coerce_mask_and_coherent(&rx_chn->common.chan_dev,
 					     DMA_BIT_MASK(48));
 		rx_chn->single_fdq = false;
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index c964ebfcf3b6..1cf158eb7bdb 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -428,18 +428,18 @@ static void k3_configure_chan_coherency(struct dma_chan *chan, u32 asel)
 		/* No special handling for the channel */
 		chan->dev->chan_dma_dev = false;
 
-		chan_dev->dma_coherent = false;
+		dev_clear_dma_coherent(chan_dev);
 		chan_dev->dma_parms = NULL;
 	} else if (asel == 14 || asel == 15) {
 		chan->dev->chan_dma_dev = true;
 
-		chan_dev->dma_coherent = true;
+		dev_set_dma_coherent(chan_dev);
 		dma_coerce_mask_and_coherent(chan_dev, DMA_BIT_MASK(48));
 		chan_dev->dma_parms = chan_dev->parent->dma_parms;
 	} else {
 		dev_warn(chan->device->dev, "Invalid ASEL value: %u\n", asel);
 
-		chan_dev->dma_coherent = false;
+		dev_clear_dma_coherent(chan_dev);
 		chan_dev->dma_parms = NULL;
 	}
 }
diff --git a/include/linux/device.h b/include/linux/device.h
index b7a8b902efb3..5b0fb6ad4c72 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -481,6 +481,8 @@ struct device_physical_location {
  * @DEV_FLAG_STATE_SYNCED: The hardware state of this device has been synced to
  *		match the software state of this device by calling the
  *		driver/bus sync_state() callback.
+ * @DEV_FLAG_DMA_COHERENT: This particular device is dma coherent, even if the
+ *		architecture supports non-coherent devices.
  */
 enum struct_device_flags {
 	DEV_FLAG_READY_TO_PROBE = 0,
@@ -489,6 +491,7 @@ enum struct_device_flags {
 	DEV_FLAG_DMA_SKIP_SYNC = 3,
 	DEV_FLAG_DMA_OPS_BYPASS = 4,
 	DEV_FLAG_STATE_SYNCED = 5,
+	DEV_FLAG_DMA_COHERENT = 6,
 
 	DEV_FLAG_COUNT
 };
@@ -572,8 +575,6 @@ enum struct_device_flags {
  * @offline:	Set after successful invocation of bus type's .offline().
  * @of_node_reused: Set if the device-tree node is shared with an ancestor
  *              device.
- * @dma_coherent: this particular device is dma coherent, even if the
- *		architecture supports non-coherent devices.
  * @flags:	DEV_FLAG_XXX flags. Use atomic bitfield operations to modify.
  *
  * At the lowest level, every device in a Linux system is represented by an
@@ -681,11 +682,6 @@ struct device {
 	bool			offline_disabled:1;
 	bool			offline:1;
 	bool			of_node_reused:1;
-#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
-    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
-    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
-	bool			dma_coherent:1;
-#endif
 
 	DECLARE_BITMAP(flags, DEV_FLAG_COUNT);
 };
@@ -718,6 +714,7 @@ __create_dev_flag_accessors(dma_iommu, DEV_FLAG_DMA_IOMMU);
 __create_dev_flag_accessors(dma_skip_sync, DEV_FLAG_DMA_SKIP_SYNC);
 __create_dev_flag_accessors(dma_ops_bypass, DEV_FLAG_DMA_OPS_BYPASS);
 __create_dev_flag_accessors(state_synced, DEV_FLAG_STATE_SYNCED);
+__create_dev_flag_accessors(dma_coherent, DEV_FLAG_DMA_COHERENT);
 
 #undef __create_dev_flag_accessors
 
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index edd7de60a957..44dd9035b4fe 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -230,7 +230,7 @@ int dma_direct_set_offset(struct device *dev, phys_addr_t cpu_start,
 extern bool dma_default_coherent;
 static inline bool dev_is_dma_coherent(struct device *dev)
 {
-	return dev->dma_coherent;
+	return dev_dma_coherent(dev);
 }
 #else
 #define dma_default_coherent true
-- 
2.53.0.1213.gd9a14994de-goog


