Return-Path: <dmaengine+bounces-9879-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFyuBV5X0GkA6gYAu9opvQ
	(envelope-from <dmaengine+bounces-9879-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 04 Apr 2026 02:12:14 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BF5399434
	for <lists+dmaengine@lfdr.de>; Sat, 04 Apr 2026 02:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF9EB308F3C1
	for <lists+dmaengine@lfdr.de>; Sat,  4 Apr 2026 00:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2959A19DF4F;
	Sat,  4 Apr 2026 00:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ev3xjZ5P"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7A416CD33
	for <dmaengine@vger.kernel.org>; Sat,  4 Apr 2026 00:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775261263; cv=none; b=BjkuU0my6kHmxZ6YO+FvmcmHgHFt2VSPLse4P4yB+aen5Y7Ee08J3DHtWet2sBxN/5sLC1f3HSMlvrAqzrkeGP7qIkraQuYAx2au2aZ8PUTyUWdSRBnIaBUotykLKOPjSjVZPtkbnzPLPBwok4zxAyENbZ+aFG7e7gnhiSnkwYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775261263; c=relaxed/simple;
	bh=pgtEOoXk5qYTTG7hDMtZ8J76x8eZHoBKGHYOR2BacFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWzaQTFTYzxaKYusHE4B9So3i+LgIRtzrtNcqAs4aj6S89crENfV5Cvr3V31bHvEUIEPtIs1BBtFLF9PeDqyuC7MNP02/7EQzMLRhsQAzi8fh6K14t4drQzTFQdqbi0Rnp8cYj7n8+EzfnwUhxftIzGsIGIOYNbGqfB5cZZzA9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ev3xjZ5P; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12c0433a4b9so10105c88.1
        for <dmaengine@vger.kernel.org>; Fri, 03 Apr 2026 17:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775261260; x=1775866060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcmabhgoUijh3Cpj42DFAN00fMUT4ppReLQYE5Q7FAg=;
        b=ev3xjZ5PnP16m9+POxKLwsiGjTfabEEGhUywjzqdTGG3gvymLWPpCpCl/eyLp7OI3W
         5lqdyiajsK9XLX5OP0Z4eq/YyJBsgy2nxLDkQP3veXH/7+Wmc2txbwQXD1JRmnYDK/wB
         swTAL0zYReTHO83wHsekBADUJVydSWaNa2DTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775261260; x=1775866060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pcmabhgoUijh3Cpj42DFAN00fMUT4ppReLQYE5Q7FAg=;
        b=UG1q0TPY/HnconRdgwAZY/EeK2rnWf6TjZqJbApwEtYxgMxk/O6VJToTn3teyKv+q0
         jUyYExIqEgtqKeC9bbeXWVq1PJ6icX6ZsRvEJEgHC03J2ezLiEVFgsq6NLqNcBooobT5
         auw2LOVIrz3SLdiOYlnOUxfKeyuJDrujjKNEq5QJt2IP17H8roN2CANpYvvsVc/R018W
         bipCXpB+GpR7JuqIyDtUKfxCnnTffWnppRGU0FBMw4h8ebVdTkv7U10yJnzLsashrUWv
         y8EnA8gJh/CJmfG9E7CFZjUeIXajpOXlm5I8jmGEkU1XVKbD71/fiJTssVdTLkXbQFjd
         k+Dg==
X-Forwarded-Encrypted: i=1; AJvYcCWgbjYNbk/O5eR9NSnzem19tgyMMLR6mjaWXLHA88xIugXfcOzDAThoC7cM8w/YVu/2tVlOsUmisJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH5SRhk/+9uymT055VV/KDJMBI0GZm8usrSsRU0Nph8BxZbP7d
	xkGSSA+GfHJZEvlS6HMsfl8JWoIT8r1pU0xXHqNTi30WxjXZtM424jEvGMmtzQnfaA==
X-Gm-Gg: ATEYQzyW+RaFsRXsJW32WYuXDJ7WiftTWaT7NdJy2ak//wK2IerXoWLclossMrZ+KAJ
	Hy5m1hv/Xp3Cira9gVwV+cQ6O/fOTmB2sFTdI2r1NfCE5ZErdtz5Qg1eZVxxR/9heNWH1E4OnDu
	26uDxd8cHqVjd9uKjdUn99nDE1ORE5f2J4y81UUp6Um3ZsH+jM0TF4vuKwvWuBeG96l/Qq6JHPT
	qvu70QdWtuawl2yOtiRj622WAkn1ILUwlkvIe+wjc/yBLuiffcngiLJR2wj6nxdniIRm5K3lSMN
	JW1rh8TsIGSIyD6Wnl1WwDsOUZ8jeKGMCKKroRf9H5bXDMax9QBI3HBG611wN+jglvK78t1MxwT
	7JPTr3v/vYsTqEayP/nVAzajMcTj5SZyW+wn1/7dRb0dcMIoNzNIFo4fpIs7fyMTpn7JsTNPMQn
	P0/Y3h3V/NcKaq983Y0pKTfxeROi1TXQ2Di7JAD9t58ChmSc6IWej/Clp86CfggH53Ha3l1FsTE
	PzvPSyBSwQ=
X-Received: by 2002:a05:7022:ec17:b0:123:3488:899f with SMTP id a92af1059eb24-12bfb776e08mr1990633c88.32.1775261259525;
        Fri, 03 Apr 2026 17:07:39 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:a8b6:55b2:3eb6:2c0e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca79e1d93bsm6520716eec.12.2026.04.03.17.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 17:07:38 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Cc: Saravana Kannan <saravanak@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Eric Dumazet <edumazet@google.com>,
	Johan Hovold <johan@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Robin Murphy <robin.murphy@arm.com>,
	Douglas Anderson <dianders@chromium.org>,
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
	vkoul@kernel.org,
	will@kernel.org,
	willy@infradead.org
Subject: [PATCH v4 7/9] driver core: Replace dev->dma_coherent with dev_dma_coherent()
Date: Fri,  3 Apr 2026 17:05:01 -0700
Message-ID: <20260403170432.v4.7.If839f6dde98979fce177f70c6c74689a1904ee76@changeid>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To: <20260404000644.522677-1-dianders@chromium.org>
References: <20260404000644.522677-1-dianders@chromium.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[41];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9879-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lst.de,google.com,intel.com,ozlabs.ru,arm.com,chromium.org,ghiti.fr,lunn.ch,eecs.berkeley.edu,vger.kernel.org,lists.linux.dev,bootlin.com,ziepe.ca,lists.infradead.org,armlinux.org.uk,samsung.com,dabbelt.com,gmail.com,alpha.franken.de,infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:dkim,chromium.org:email]
X-Rspamd-Queue-Id: A2BF5399434
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In C, bitfields are not necessarily safe to modify from multiple
threads without locking. Switch "dma_coherent" over to the "flags"
field so modifications are safe.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Not fixing any known bugs; problem is theoretical and found by code
inspection. Change is done somewhat manually and only lightly tested
(mostly compile-time tested).

NOTE: even though previously we only took up a bit if
CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE, CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU,
or CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL, in this change I reserve the
bit unconditionally.  While we could get the "dynamic" behavior by
changing the flags definition to be an "enum", it doesn't seem worth
it at this point.

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
index 0986051a6f14..531f02a5469a 100644
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
index a1d59ff9702c..fca986cef2ed 100644
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
 
 /**
  * struct device_link - Device link representation.
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


