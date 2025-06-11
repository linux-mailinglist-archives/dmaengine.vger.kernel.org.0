Return-Path: <dmaengine+bounces-5357-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0838FAD5644
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 15:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36DF23A5BAE
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 13:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75209283FEB;
	Wed, 11 Jun 2025 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="Lj3mfJpF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C82F288C8F
	for <dmaengine@vger.kernel.org>; Wed, 11 Jun 2025 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749646811; cv=none; b=s/g/n4oia+pCwA0MqSR3PilrBVVOOz6Hqd9xH9Q9HxOuocqjvLh7D1RxgOstY7bU3LM8dB1sc/9WGWo+DK2PftNxk7fCJmbtn0eDlg2vptxFi2lDXIThtHdLWXRcNwd2ZlIQlxq+NduP3XHetat/kFMOIghyawKFSc1B4gk4htM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749646811; c=relaxed/simple;
	bh=eGMVc5h94PL2B2E3UrKcFyODORQJmy/6+RlRQQdLCbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0PUfaXBnJdKcya8A+lrzDe3GJyKGvYBEOr4/lBhzzNV9xwtmRxXBfsa90L3E3e3gX3ExlB5lEKMjqviMLCcpwmbQctKIOOQGXcHOpT0okmI+aPj+DtP8/R42hoVBtJzgNREuIUi1aRNqBOciQdwgogTc5F/YtYW7B+uAHOIfpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=Lj3mfJpF; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23636167afeso21444475ad.3
        for <dmaengine@vger.kernel.org>; Wed, 11 Jun 2025 06:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1749646808; x=1750251608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/NsOpvMXQBYdYoYMIoGcM16eh3qz+f1G2mte69Ome0=;
        b=Lj3mfJpF3TT0yh6MUl3cCdSnY9z+VVfWMwoXz0WxENm0Sog1THndF/5umE22TidkqH
         c6jfRRNVv9xXh/h1yT2PFXmhSuIDLskuDf9WNmqN8Hbfdhjyz1/3O1gx351zLCUKxBU+
         SuoVi4V3V2wP1eYgXkovMaZM67G+sLtmt8LMSrvYswuLqCMun9uH/kt/yl+9Rjht/MkW
         641uxBtFvwLtZZFJ6hgk5zj+tCp8J7thnniZAuJNlBHFqbSwQszO4juaiF5LXsk0yNKv
         5a6SbUcP6CudzWDFMe6mQvxkhAZS4O/yeItQvFAw0XNtzQAxOGIbEYhZFQnzmgdZ5XwL
         cydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749646808; x=1750251608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/NsOpvMXQBYdYoYMIoGcM16eh3qz+f1G2mte69Ome0=;
        b=BZRH/U5ZOF/+zfkgBQ2lB93CaRgqTaPp8wiMGzJLYZYPZRMmaxOq+Daa7f0tEom3WQ
         3n45hSIup5QXYXVV0ZUGrftFJa6TcSZ6gZqJOWJWy5nwwhPcG7zj8MQwKGZw3DvuW2l7
         mMaZJI1H2MF6TfbSJ+nzlnqtMlWFThaGdrLMVMt0kKCasg5Ot6CFaJ85F2mEfIht30PD
         lisepmOxIifmLeJ/ApSr3bHdKH10oLqb1ZI5e41qy8jNYjqF6mZsloJhbk8WPazV16Mn
         EdNMDU0AfxFivFhLAUQHTP0POInge4VFzb8ETrEVMyFEJiSgWGHz7IAmoLDdZK2t1bu5
         ruhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBapb9OgNRABQm9ehiq9jDlhYF+tCogzCFhf6HDgRzfcCgoGyKusmmMhS0n256YM32nBY1mCLrwxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt0y2SjEIu4aBmQquPzms7Gbg+yhfqnyP44a3ko1oSbpjaIYh2
	t6+MtsdbU65p1Uywfnm2hD0JMcHbFCeJZNTCvQu0JyjQWPnjpXTX5pTC/t+KlQ/r39Y=
X-Gm-Gg: ASbGnctzbOF/kqTWYZMnjK+dQOpVD4UXnF+XpW91S5sYJJeB6t2MDUdyxoseyBv/F5x
	O9Hk86Pqx6+ncmG4sqVFLe/xmtN8CA7Kau67hUoOWzmfuA2vjafWUcky6UDVPMmQldZ/NMRpNA0
	2uDvnEMhcm/Won1XU0B2C2W//rrPHKgZpHlWqiXs5EATHVsGubj4wRWU2SDYm9J66yV2jDiFIqb
	xcRMqufEK2b1FFGxHm6dQfvRjezGnTr0q7QRMVc7cMTFEHNCP4gaWVhQFWmCu7QC39lOssasod4
	c9wX45kafuDewLCZeRoHVW38pIKfMXWrSr+BhSXAxQWQdkCbvbWd6JGzWzgvgHZR+w80ckHMdSH
	wT9xIsFr+ZQpHGUp6PxtL4A==
X-Google-Smtp-Source: AGHT+IFAd6T3/67ht19F0MK/g7NtaPkmZC41svy2FhzOoer8pe2Va/OnaRRT/Pa7aVpyF0HN5Jgqig==
X-Received: by 2002:a17:902:f545:b0:234:a139:1215 with SMTP id d9443c01a7336-23641b141b0mr42125965ad.35.1749646808176;
        Wed, 11 Jun 2025 06:00:08 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a00:31a4:6520:3d67:ceb1:7c60:9098])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030925e3sm86984115ad.53.2025.06.11.05.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 06:00:07 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
To: vkoul@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlan@gentoo.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	drew@pdp7.com,
	emil.renner.berthing@canonical.com,
	inochiama@gmail.com,
	geert+renesas@glider.be,
	tglx@linutronix.de,
	hal.feng@starfivetech.com,
	joel@jms.id.au,
	duje.mihanovic@skole.hr
Cc: guodong@riscstar.com,
	elder@riscstar.com,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Subject: [PATCH 4/8] dma: mmp_pdma: Add SpacemiT PDMA support with 64-bit addressing
Date: Wed, 11 Jun 2025 20:57:19 +0800
Message-ID: <20250611125723.181711-5-guodong@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250611125723.181711-1-guodong@riscstar.com>
References: <20250611125723.181711-1-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the MMP PDMA driver to support SpacemiT PDMA controllers with
64-bit physical addressing capabilities, as used in the K1 SoC. This
change introduces a flexible architecture that maintains compatibility
with existing 32-bit Marvell platforms while adding 64-bit support.

Key changes:
- Add struct mmp_pdma_config to abstract platform-specific behaviors
- Implement 64-bit address support through:
  * New high address registers (DDADRH, DSADRH, DTADRH)
  * DCSR_LPAEEN bit for Long Physical Address Extension mode
  * Helper functions for 32/64-bit address handling
- Add "spacemit,pdma-1.0" compatible string with associated config
- Extend descriptor structure to support 64-bit addresses
- Refactor address handling code to be platform-agnostic
- Add proper DMA mask configuration for both 32-bit and 64-bit modes

The implementation uses a configuration-based approach to keeps all
platform-specific code isolated in config structures. It maintains clean
separation between 32-bit and 64-bit code paths, provides consistent
API for both addressing modes and preserves backward compatibility.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
 drivers/dma/mmp_pdma.c | 236 +++++++++++++++++++++++++++++++++++------
 1 file changed, 205 insertions(+), 31 deletions(-)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index fe627efeaff0..57313754b611 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -25,9 +25,12 @@
 #define DCSR		0x0000
 #define DALGN		0x00a0
 #define DINT		0x00f0
-#define DDADR		0x0200
+#define DDADR(n)	(0x0200 + ((n) << 4))
 #define DSADR(n)	(0x0204 + ((n) << 4))
 #define DTADR(n)	(0x0208 + ((n) << 4))
+#define DDADRH(n)	(0x0300 + ((n) << 4))
+#define DSADRH(n)	(0x0304 + ((n) << 4))
+#define DTADRH(n)	(0x0308 + ((n) << 4))
 #define DCMD		0x020c
 
 #define DCSR_RUN	BIT(31)	/* Run Bit (read / write) */
@@ -44,6 +47,7 @@
 #define DCSR_EORSTOPEN	BIT(26)	/* STOP on an EOR */
 #define DCSR_SETCMPST	BIT(25)	/* Set Descriptor Compare Status */
 #define DCSR_CLRCMPST	BIT(24)	/* Clear Descriptor Compare Status */
+#define DCSR_LPAEEN	BIT(21)	/* Long Physical Address Extension Enable */
 #define DCSR_CMPST	BIT(10)	/* The Descriptor Compare Status */
 #define DCSR_EORINTR	BIT(9)	/* The end of Receive */
 
@@ -76,6 +80,16 @@ struct mmp_pdma_desc_hw {
 	u32 dsadr;	/* DSADR value for the current transfer */
 	u32 dtadr;	/* DTADR value for the current transfer */
 	u32 dcmd;	/* DCMD value for the current transfer */
+	/*
+	 * The following 32-bit words are only used in the 64-bit, ie.
+	 * LPAE (Long Physical Address Extension) mode.
+	 * They are used to specify the high 32 bits of the descriptor's
+	 * addresses.
+	 */
+	u32 ddadrh;	/* High 32-bit of DDADR */
+	u32 dsadrh;	/* High 32-bit of DSADR */
+	u32 dtadrh;	/* High 32-bit of DTADR */
+	u32 rsvd;	/* reserved */
 } __aligned(32);
 
 struct mmp_pdma_desc_sw {
@@ -120,12 +134,36 @@ struct mmp_pdma_phy {
 	struct mmp_pdma_chan *vchan;
 };
 
+/**
+ * struct mmp_pdma_ops - Operations for the MMP PDMA controller
+ * @set_desc:   Function to program descriptor addresses into DDADR/DDADRH
+ *              channel registers
+ * @addr_split: Function to split DMA address into 32-bit low/high parts
+ *              for hardware programming
+ * @addr_join:  Function to combine 32-bit low/high values into 64-bit
+ *              for software processing
+ * @reg_read64: Function to read and combine two 32-bit registers into
+ *              64-bit value
+ * @run_bits:   Control bits in DCSR register for channel start/stop
+ * @dma_mask:   DMA addressing capability of controller. 0 to use OF/platform
+ *              settings, or explicit mask like DMA_BIT_MASK(32/64)
+ */
+struct mmp_pdma_ops {
+	void (*set_desc)(struct mmp_pdma_phy *phy, dma_addr_t addr);
+	void (*addr_split)(u32 *lower, u32 *upper, dma_addr_t addr);
+	u64 (*addr_join)(u32 lower, u32 upper);
+	u64 (*reg_read64)(void __iomem *base, u32 low_offset, u32 high_offset);
+	u32 run_bits;
+	u64 dma_mask;
+};
+
 struct mmp_pdma_device {
 	int				dma_channels;
 	void __iomem			*base;
 	struct device			*dev;
 	struct dma_device		device;
 	struct mmp_pdma_phy		*phy;
+	const struct mmp_pdma_ops	*config;
 	spinlock_t phy_lock; /* protect alloc/free phy channels */
 };
 
@@ -138,24 +176,89 @@ struct mmp_pdma_device {
 #define to_mmp_pdma_dev(dmadev)					\
 	container_of(dmadev, struct mmp_pdma_device, device)
 
-static int mmp_pdma_config_write(struct dma_chan *dchan,
-			   struct dma_slave_config *cfg,
-			   enum dma_transfer_direction direction);
+/* For 32-bit version */
+static void addr_split_32(u32 *lower, u32 *upper __maybe_unused,
+			  dma_addr_t addr)
+{
+	*lower = addr;
+}
+
+static void set_desc_32(struct mmp_pdma_phy *phy, dma_addr_t addr)
+{
+	writel(addr, phy->base + DDADR(phy->idx));
+}
+
+static u64 addr_join_32(u32 lower, u32 upper __maybe_unused)
+{
+	return lower;
+}
 
-static void set_desc(struct mmp_pdma_phy *phy, dma_addr_t addr)
+static u64 reg_read64_32(void __iomem *base, u32 low_offset,
+			 u32 high_offset __maybe_unused)
 {
-	u32 reg = (phy->idx << 4) + DDADR;
+	return readl(base + low_offset);
+}
 
-	writel(addr, phy->base + reg);
+/* For 64-bit version */
+static void addr_split_64(u32 *lower, u32 *upper, dma_addr_t addr)
+{
+	*lower = lower_32_bits(addr);
+	*upper = upper_32_bits(addr);
+}
+
+static void set_desc_64(struct mmp_pdma_phy *phy, dma_addr_t addr)
+{
+	writel(lower_32_bits(addr), phy->base + DDADR(phy->idx));
+	writel(upper_32_bits(addr), phy->base + DDADRH(phy->idx));
+}
+
+static u64 addr_join_64(u32 lower, u32 upper)
+{
+	return ((u64)upper << 32) | lower;
+}
+
+static u64 reg_read64_64(void __iomem *base, u32 low_offset,
+			 u32 high_offset)
+{
+	return addr_join_64(readl(base + low_offset),
+			    readl(base + high_offset));
 }
 
+/* Helper functions */
+static inline void pdma_desc_set_addr(struct mmp_pdma_device *pdev,
+				      u32 *addr_low, u32 *addr_high,
+				      dma_addr_t addr)
+{
+	pdev->config->addr_split(addr_low, addr_high, addr);
+}
+
+static inline u64 pdma_read_addr(struct mmp_pdma_phy *phy,
+				 struct mmp_pdma_device *pdev,
+				 u32 reg_low, u32 reg_high)
+{
+	return pdev->config->reg_read64(phy->base, reg_low, reg_high);
+}
+
+static inline u64 pdma_desc_addr(struct mmp_pdma_device *pdev,
+				 u32 addr_low, u32 addr_high)
+{
+	return pdev->config->addr_join(addr_low, addr_high);
+}
+
+static int mmp_pdma_config_write(struct dma_chan *dchan,
+				 struct dma_slave_config *cfg,
+				 enum dma_transfer_direction direction);
+
 static void enable_chan(struct mmp_pdma_phy *phy)
 {
 	u32 reg, dalgn;
+	struct mmp_pdma_device *pdev;
 
 	if (!phy->vchan)
 		return;
 
+	pdev = to_mmp_pdma_dev(phy->vchan->chan.device);
+
 	reg = DRCMR(phy->vchan->drcmr);
 	writel(DRCMR_MAPVLD | phy->idx, phy->base + reg);
 
@@ -167,18 +270,29 @@ static void enable_chan(struct mmp_pdma_phy *phy)
 	writel(dalgn, phy->base + DALGN);
 
 	reg = (phy->idx << 2) + DCSR;
-	writel(readl(phy->base + reg) | DCSR_RUN, phy->base + reg);
+	writel(readl(phy->base + reg) | pdev->config->run_bits,
+	       phy->base + reg);
 }
 
 static void disable_chan(struct mmp_pdma_phy *phy)
 {
-	u32 reg;
+	u32 reg, dcsr;
 
 	if (!phy)
 		return;
 
 	reg = (phy->idx << 2) + DCSR;
-	writel(readl(phy->base + reg) & ~DCSR_RUN, phy->base + reg);
+	dcsr = readl(phy->base + reg);
+
+	if (phy->vchan) {
+		struct mmp_pdma_device *pdev;
+
+		pdev = to_mmp_pdma_dev(phy->vchan->chan.device);
+		writel(dcsr & ~pdev->config->run_bits, phy->base + reg);
+	} else {
+		/* If no vchan, just clear the RUN bit */
+		writel(dcsr & ~DCSR_RUN, phy->base + reg);
+	}
 }
 
 static int clear_chan_irq(struct mmp_pdma_phy *phy)
@@ -297,6 +411,7 @@ static void mmp_pdma_free_phy(struct mmp_pdma_chan *pchan)
 static void start_pending_queue(struct mmp_pdma_chan *chan)
 {
 	struct mmp_pdma_desc_sw *desc;
+	struct mmp_pdma_device *pdev = to_mmp_pdma_dev(chan->chan.device);
 
 	/* still in running, irq will start the pending list */
 	if (!chan->idle) {
@@ -331,7 +446,7 @@ static void start_pending_queue(struct mmp_pdma_chan *chan)
 	 * Program the descriptor's address into the DMA controller,
 	 * then start the DMA transaction
 	 */
-	set_desc(chan->phy, desc->async_tx.phys);
+	pdev->config->set_desc(chan->phy, desc->async_tx.phys);
 	enable_chan(chan->phy);
 	chan->idle = false;
 }
@@ -447,6 +562,7 @@ mmp_pdma_prep_memcpy(struct dma_chan *dchan,
 		     size_t len, unsigned long flags)
 {
 	struct mmp_pdma_chan *chan;
+	struct mmp_pdma_device *pdev = to_mmp_pdma_dev(dchan->device);
 	struct mmp_pdma_desc_sw *first = NULL, *prev = NULL, *new;
 	size_t copy = 0;
 
@@ -478,13 +594,17 @@ mmp_pdma_prep_memcpy(struct dma_chan *dchan,
 			chan->byte_align = true;
 
 		new->desc.dcmd = chan->dcmd | (DCMD_LENGTH & copy);
-		new->desc.dsadr = dma_src;
-		new->desc.dtadr = dma_dst;
+		pdma_desc_set_addr(pdev, &new->desc.dsadr, &new->desc.dsadrh,
+					 dma_src);
+		pdma_desc_set_addr(pdev, &new->desc.dtadr, &new->desc.dtadrh,
+					 dma_dst);
 
 		if (!first)
 			first = new;
 		else
-			prev->desc.ddadr = new->async_tx.phys;
+			pdma_desc_set_addr(pdev, &prev->desc.ddadr,
+						 &prev->desc.ddadrh,
+						 new->async_tx.phys);
 
 		new->async_tx.cookie = 0;
 		async_tx_ack(&new->async_tx);
@@ -528,6 +648,7 @@ mmp_pdma_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 		       unsigned long flags, void *context)
 {
 	struct mmp_pdma_chan *chan = to_mmp_pdma_chan(dchan);
+	struct mmp_pdma_device *pdev = to_mmp_pdma_dev(dchan->device);
 	struct mmp_pdma_desc_sw *first = NULL, *prev = NULL, *new = NULL;
 	size_t len, avail;
 	struct scatterlist *sg;
@@ -559,17 +680,23 @@ mmp_pdma_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 
 			new->desc.dcmd = chan->dcmd | (DCMD_LENGTH & len);
 			if (dir == DMA_MEM_TO_DEV) {
-				new->desc.dsadr = addr;
+				pdma_desc_set_addr(pdev, &new->desc.dsadr,
+							 &new->desc.dsadrh,
+							 addr);
 				new->desc.dtadr = chan->dev_addr;
 			} else {
 				new->desc.dsadr = chan->dev_addr;
-				new->desc.dtadr = addr;
+				pdma_desc_set_addr(pdev, &new->desc.dtadr,
+							 &new->desc.dtadrh,
+							 addr);
 			}
 
 			if (!first)
 				first = new;
 			else
-				prev->desc.ddadr = new->async_tx.phys;
+				pdma_desc_set_addr(pdev, &prev->desc.ddadr,
+							 &prev->desc.ddadrh,
+							 new->async_tx.phys);
 
 			new->async_tx.cookie = 0;
 			async_tx_ack(&new->async_tx);
@@ -609,6 +736,7 @@ mmp_pdma_prep_dma_cyclic(struct dma_chan *dchan,
 			 unsigned long flags)
 {
 	struct mmp_pdma_chan *chan;
+	struct mmp_pdma_device *pdev = to_mmp_pdma_dev(dchan->device);
 	struct mmp_pdma_desc_sw *first = NULL, *prev = NULL, *new;
 	dma_addr_t dma_src, dma_dst;
 
@@ -651,13 +779,17 @@ mmp_pdma_prep_dma_cyclic(struct dma_chan *dchan,
 
 		new->desc.dcmd = (chan->dcmd | DCMD_ENDIRQEN |
 				  (DCMD_LENGTH & period_len));
-		new->desc.dsadr = dma_src;
-		new->desc.dtadr = dma_dst;
+		pdma_desc_set_addr(pdev, &new->desc.dsadr, &new->desc.dsadrh,
+					 dma_src);
+		pdma_desc_set_addr(pdev, &new->desc.dtadr, &new->desc.dtadrh,
+					 dma_dst);
 
 		if (!first)
 			first = new;
 		else
-			prev->desc.ddadr = new->async_tx.phys;
+			pdma_desc_set_addr(pdev, &prev->desc.ddadr,
+						 &prev->desc.ddadrh,
+						 new->async_tx.phys);
 
 		new->async_tx.cookie = 0;
 		async_tx_ack(&new->async_tx);
@@ -678,7 +810,8 @@ mmp_pdma_prep_dma_cyclic(struct dma_chan *dchan,
 	first->async_tx.cookie = -EBUSY;
 
 	/* make the cyclic link */
-	new->desc.ddadr = first->async_tx.phys;
+	pdma_desc_set_addr(pdev, &new->desc.ddadr, &new->desc.ddadrh,
+				 first->async_tx.phys);
 	chan->cyclic_first = first;
 
 	return &first->async_tx;
@@ -764,7 +897,9 @@ static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan,
 				     dma_cookie_t cookie)
 {
 	struct mmp_pdma_desc_sw *sw;
-	u32 curr, residue = 0;
+	struct mmp_pdma_device *pdev = to_mmp_pdma_dev(chan->chan.device);
+	u64 curr;
+	u32 residue = 0;
 	bool passed = false;
 	bool cyclic = chan->cyclic_first != NULL;
 
@@ -776,17 +911,24 @@ static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan,
 		return 0;
 
 	if (chan->dir == DMA_DEV_TO_MEM)
-		curr = readl(chan->phy->base + DTADR(chan->phy->idx));
+		curr = pdma_read_addr(chan->phy, pdev,
+				      DTADR(chan->phy->idx),
+				      DTADRH(chan->phy->idx));
 	else
-		curr = readl(chan->phy->base + DSADR(chan->phy->idx));
+		curr = pdma_read_addr(chan->phy, pdev,
+				      DSADR(chan->phy->idx),
+				      DSADRH(chan->phy->idx));
 
 	list_for_each_entry(sw, &chan->chain_running, node) {
-		u32 start, end, len;
+		u64 start, end;
+		u32 len;
 
 		if (chan->dir == DMA_DEV_TO_MEM)
-			start = sw->desc.dtadr;
+			start = pdma_desc_addr(pdev, sw->desc.dtadr,
+						     sw->desc.dtadrh);
 		else
-			start = sw->desc.dsadr;
+			start = pdma_desc_addr(pdev, sw->desc.dsadr,
+						     sw->desc.dsadrh);
 
 		len = sw->desc.dcmd & DCMD_LENGTH;
 		end = start + len;
@@ -802,7 +944,7 @@ static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan,
 		if (passed) {
 			residue += len;
 		} else if (curr >= start && curr <= end) {
-			residue += end - curr;
+			residue += (u32)(end - curr);
 			passed = true;
 		}
 
@@ -996,9 +1138,34 @@ static int mmp_pdma_chan_init(struct mmp_pdma_device *pdev, int idx, int irq)
 	return 0;
 }
 
+static const struct mmp_pdma_ops marvell_pdma_v1_config = {
+	.set_desc = set_desc_32,
+	.addr_split = addr_split_32,
+	.addr_join = addr_join_32,
+	.reg_read64 = reg_read64_32,
+	.run_bits = (DCSR_RUN),
+	.dma_mask = 0,			/* let OF/platform set DMA mask */
+};
+
+static const struct mmp_pdma_ops spacemit_k1_pdma_v1_config = {
+	.set_desc = set_desc_64,
+	.addr_split = addr_split_64,
+	.addr_join = addr_join_64,
+	.reg_read64 = reg_read64_64,
+	.run_bits = (DCSR_RUN | DCSR_LPAEEN),
+	.dma_mask = DMA_BIT_MASK(64),	/* force 64-bit DMA addr capability */
+};
+
 static const struct of_device_id mmp_pdma_dt_ids[] = {
-	{ .compatible = "marvell,pdma-1.0", },
-	{}
+	{
+		.compatible = "marvell,pdma-1.0",
+		.data = &marvell_pdma_v1_config
+	}, {
+		.compatible = "spacemit,pdma-1.0",
+		.data = &spacemit_k1_pdma_v1_config
+	}, {
+		/* sentinel */
+	}
 };
 MODULE_DEVICE_TABLE(of, mmp_pdma_dt_ids);
 
@@ -1050,6 +1217,10 @@ static int mmp_pdma_probe(struct platform_device *op)
 	if (IS_ERR(rst))
 		return PTR_ERR(rst);
 
+	pdev->config = of_device_get_match_data(&op->dev);
+	if (!pdev->config)
+		return -ENODEV;
+
 	if (pdev->dev->of_node) {
 		/* Parse new and deprecated dma-channels properties */
 		if (of_property_read_u32(pdev->dev->of_node, "dma-channels",
@@ -1111,7 +1282,10 @@ static int mmp_pdma_probe(struct platform_device *op)
 	pdev->device.directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
 	pdev->device.residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
 
-	if (pdev->dev->coherent_dma_mask)
+	/* Set DMA mask based on config, or OF/platform */
+	if (pdev->config->dma_mask)
+		dma_set_mask(pdev->dev, pdev->config->dma_mask);
+	else if (pdev->dev->coherent_dma_mask)
 		dma_set_mask(pdev->dev, pdev->dev->coherent_dma_mask);
 	else
 		dma_set_mask(pdev->dev, DMA_BIT_MASK(64));
-- 
2.43.0


