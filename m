Return-Path: <dmaengine+bounces-6038-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A076B2783D
	for <lists+dmaengine@lfdr.de>; Fri, 15 Aug 2025 07:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA731C27EBC
	for <lists+dmaengine@lfdr.de>; Fri, 15 Aug 2025 05:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BE012F5A5;
	Fri, 15 Aug 2025 05:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="ai5nYhol"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB84023E347
	for <dmaengine@vger.kernel.org>; Fri, 15 Aug 2025 05:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235083; cv=none; b=i/gzaq2kGcr69/YEcl9ktsqfgL3dtsk76W8dW8S1jSsG0DcZTSTd94tNtvLT9/mhgxBUQ4ON3R3L6J6tpme9GNIjf3+eQdpe7h2k7Y0Oj5vO9Lpl0u9GeE5wATSRKCHB5QLXlUwdp1tS7EpwWOBLWh8jQVbuOuaOpxC792jhD9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235083; c=relaxed/simple;
	bh=YFZIAu2Cuw2zxhvvJqB/+8xvyXeN322rk24+Alg8DHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hO5nLgydXPqAAmSGwX2gqnxXgy1zemj/tQSQNYclxHF0uzXV/YDwqgoKdTUi5GC703Kn0WupWbt7hFknZJ5+Cty5xRl336aa+ZxeB+lyOVQMf8ERa1WE9yNYPmugkUQXyVxazCNo9HDNh58hCg9YCJiPNBLCit78pleujqCVHRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=ai5nYhol; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32326e67c95so2189893a91.3
        for <dmaengine@vger.kernel.org>; Thu, 14 Aug 2025 22:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755235081; x=1755839881; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TNnZupBQfo5mzWE/4b5B3Fm2CaSU88AnrHBI4K5Prb0=;
        b=ai5nYhol66qoxQdl589M8fO1xOXD2GA/5e1oj3BkV45d121j9dg8aUp4WJnZcf6vXm
         q5VB/Bj6h2fd7xHEtPdeeq8FCcuQFTDUFxsFZX5QrozK+gPiEh9WkxBJMG7ghpPP0dAD
         cWytFr9exDY3EbiKO9y1FC387W7utp6+0/YQFiDCNTTv3OFe9RZG61dH5raDrRq3jErl
         n0yhdQvK9O6PqCeLRSal4hn61N/Q24S8T1IT7HLp5wBZsUe4XncLjPSSbNkVto36v8Ti
         zctxmVDOtXiE2VG38tgrB/6CpbO/BwZFgziUjmhm+vhdXH3cNU7g5haWlYxo+Kgb/X0c
         ehcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755235081; x=1755839881;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNnZupBQfo5mzWE/4b5B3Fm2CaSU88AnrHBI4K5Prb0=;
        b=IVYJNEy/uMhjeTzqvbGn/2q0IkHb7duYEdzZwod7yLu282qq7z5KikYA/vl1/gXyiW
         isEtSfwSkjoCs0bsPO4oDEaqMbmhctMRJSpcCBnYvy5NeZ05XkCsc6R024Kf1CpE0ubg
         tFoYwP/J4W2RcNO0kbK9dDccoSoWYiwbqkZtfldV7AZobIQ5wJEqyK5H26fm1OGBMq/a
         hAvqs5Rdhmbrs90giU3eVOJAF0q+a2WewUtdK8OJ2saEzNF0mpZW2kxnY4cGnlPQ00aT
         7iBtyxvm1WLMXx5l/ucJCr8fUnBNqd1m3OQOLXTaaGQ3Ep/h9OWnJbwY6rKw4um6fsxV
         oGog==
X-Forwarded-Encrypted: i=1; AJvYcCWrn75oEwCj5WtOIyusXKsQtg1YoO1uDPgbyd8hzbHwSkU24DLnCaxLLAP1EqgbzyIhxaeQbImNT9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUG2BjVH7tb5tAVM5vIi/FvOSSg+uB8FkBg/eG/wQ0FQqlxVH3
	JaT2wWA/4WbAHYQDXkXD7DKYu78HBHuy9Y3drx7UJBhuufrmEbq8QgLL+3tZtmcZcAQWjDezt8G
	EiThLYq2KRg==
X-Gm-Gg: ASbGnctUEait/dr9vDBPXugFVfsR2Dn8X9oqKV97+wrRuFCUVjTb0GdsNVX9m7On9v/
	pjS3IFErwlTZ0ccSyB61IE+c/iMk9lqKbQcINK9lQDOH5yGLCzHCnbishA2DjxqOgSz5ufMA2c5
	1+JRbIte0WiDpCUcgp+HhoAilAem2e+V5pMYUvHvofY0qIiuSVFMW4kCSFoMvu06KEyp4qBJK5d
	h9gfLlKLFLpjkNtRPM/wUnCGDRiujzOH2x/3I3y/9arYe0bUGvEP1P2xMR3Q7mvGK6aKdrOLr5R
	yGMsrFDjhzCivO9/Wc9bgchvsoMcqqODPp79gcWodA3FlqsMAw0zGovf93wtW6FoTLtYBXq919y
	HGbiBIp7z2JJRfqm+a8lF+g==
X-Google-Smtp-Source: AGHT+IHkSUG6jjnRwJQQkhngD8xO67RADCVWnvDe/xymPLT+NDr07I0lrXvbbQZ9eQUu9TCExLqiTQ==
X-Received: by 2002:a17:90b:58ee:b0:31c:ad57:b97a with SMTP id 98e67ed59e1d1-32341e0e841mr1352729a91.13.1755235081235;
        Thu, 14 Aug 2025 22:18:01 -0700 (PDT)
Received: from [127.0.1.1] ([103.88.46.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-323439978a4sm373212a91.10.2025.08.14.22.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:18:00 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Fri, 15 Aug 2025 13:16:26 +0800
Subject: [PATCH v4 4/8] dmaengine: mmp_pdma: Add operations structure for
 controller abstraction
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-working_dma_0701_v2-v4-4-62145ab6ea30@riscstar.com>
References: <20250815-working_dma_0701_v2-v4-0-62145ab6ea30@riscstar.com>
In-Reply-To: <20250815-working_dma_0701_v2-v4-0-62145ab6ea30@riscstar.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, duje@dujemihanovic.xyz
Cc: Alex Elder <elder@riscstar.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Guodong Xu <guodong@riscstar.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2

Introduce mmp_pdma_ops structure to abstract 32-bit addressing operations
and enable support for different controller variants. This prepares for
adding 64-bit addressing support.

The ops structure includes:
- Hardware register operations (read/write DDADR, DSADR, DTADR)
- Descriptor memory operations (manipulate descriptor structs)
- Controller configuration (run bits, DMA mask)

Convert existing 32-bit operations to use the new abstraction layer
while maintaining backward compatibility.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v4: No change.
v3: No change.
v2: New patch, introduce mmp_pdma_ops for 32-bit addressing operations.
---
 drivers/dma/mmp_pdma.c | 187 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 156 insertions(+), 31 deletions(-)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index fe627efeaff07436647f86ab5ec5333144a3c92d..610df28f429783779c1c143a13b3a829e42cf003 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -25,7 +25,7 @@
 #define DCSR		0x0000
 #define DALGN		0x00a0
 #define DINT		0x00f0
-#define DDADR		0x0200
+#define DDADR(n)	(0x0200 + ((n) << 4))
 #define DSADR(n)	(0x0204 + ((n) << 4))
 #define DTADR(n)	(0x0208 + ((n) << 4))
 #define DCMD		0x020c
@@ -120,12 +120,55 @@ struct mmp_pdma_phy {
 	struct mmp_pdma_chan *vchan;
 };
 
+/**
+ * struct mmp_pdma_ops - Operations for the MMP PDMA controller
+ *
+ * Hardware Register Operations (read/write hardware registers):
+ * @write_next_addr: Function to program address of next descriptor into
+ *                   DDADR/DDADRH
+ * @read_src_addr: Function to read the source address from DSADR/DSADRH
+ * @read_dst_addr: Function to read the destination address from DTADR/DTADRH
+ *
+ * Descriptor Memory Operations (manipulate descriptor structs in memory):
+ * @set_desc_next_addr: Function to set next descriptor address in descriptor
+ * @set_desc_src_addr: Function to set the source address in descriptor
+ * @set_desc_dst_addr: Function to set the destination address in descriptor
+ * @get_desc_src_addr: Function to get the source address from descriptor
+ * @get_desc_dst_addr: Function to get the destination address from descriptor
+ *
+ * Controller Configuration:
+ * @run_bits:   Control bits in DCSR register for channel start/stop
+ * @dma_mask:   DMA addressing capability of controller. 0 to use OF/platform
+ *              settings, or explicit mask like DMA_BIT_MASK(32/64)
+ */
+struct mmp_pdma_ops {
+	/* Hardware Register Operations */
+	void (*write_next_addr)(struct mmp_pdma_phy *phy, dma_addr_t addr);
+	u64 (*read_src_addr)(struct mmp_pdma_phy *phy);
+	u64 (*read_dst_addr)(struct mmp_pdma_phy *phy);
+
+	/* Descriptor Memory Operations */
+	void (*set_desc_next_addr)(struct mmp_pdma_desc_hw *desc,
+				   dma_addr_t addr);
+	void (*set_desc_src_addr)(struct mmp_pdma_desc_hw *desc,
+				  dma_addr_t addr);
+	void (*set_desc_dst_addr)(struct mmp_pdma_desc_hw *desc,
+				  dma_addr_t addr);
+	u64 (*get_desc_src_addr)(const struct mmp_pdma_desc_hw *desc);
+	u64 (*get_desc_dst_addr)(const struct mmp_pdma_desc_hw *desc);
+
+	/* Controller Configuration */
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
+	const struct mmp_pdma_ops	*ops;
 	spinlock_t phy_lock; /* protect alloc/free phy channels */
 };
 
@@ -138,24 +181,61 @@ struct mmp_pdma_device {
 #define to_mmp_pdma_dev(dmadev)					\
 	container_of(dmadev, struct mmp_pdma_device, device)
 
-static int mmp_pdma_config_write(struct dma_chan *dchan,
-			   struct dma_slave_config *cfg,
-			   enum dma_transfer_direction direction);
+/* For 32-bit PDMA */
+static void write_next_addr_32(struct mmp_pdma_phy *phy, dma_addr_t addr)
+{
+	writel(addr, phy->base + DDADR(phy->idx));
+}
 
-static void set_desc(struct mmp_pdma_phy *phy, dma_addr_t addr)
+static u64 read_src_addr_32(struct mmp_pdma_phy *phy)
 {
-	u32 reg = (phy->idx << 4) + DDADR;
+	return readl(phy->base + DSADR(phy->idx));
+}
 
-	writel(addr, phy->base + reg);
+static u64 read_dst_addr_32(struct mmp_pdma_phy *phy)
+{
+	return readl(phy->base + DTADR(phy->idx));
+}
+
+static void set_desc_next_addr_32(struct mmp_pdma_desc_hw *desc, dma_addr_t addr)
+{
+	desc->ddadr = addr;
+}
+
+static void set_desc_src_addr_32(struct mmp_pdma_desc_hw *desc, dma_addr_t addr)
+{
+	desc->dsadr = addr;
+}
+
+static void set_desc_dst_addr_32(struct mmp_pdma_desc_hw *desc, dma_addr_t addr)
+{
+	desc->dtadr = addr;
 }
 
+static u64 get_desc_src_addr_32(const struct mmp_pdma_desc_hw *desc)
+{
+	return desc->dsadr;
+}
+
+static u64 get_desc_dst_addr_32(const struct mmp_pdma_desc_hw *desc)
+{
+	return desc->dtadr;
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
 
@@ -167,18 +247,29 @@ static void enable_chan(struct mmp_pdma_phy *phy)
 	writel(dalgn, phy->base + DALGN);
 
 	reg = (phy->idx << 2) + DCSR;
-	writel(readl(phy->base + reg) | DCSR_RUN, phy->base + reg);
+	writel(readl(phy->base + reg) | pdev->ops->run_bits,
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
+		writel(dcsr & ~pdev->ops->run_bits, phy->base + reg);
+	} else {
+		/* If no vchan, just clear the RUN bit */
+		writel(dcsr & ~DCSR_RUN, phy->base + reg);
+	}
 }
 
 static int clear_chan_irq(struct mmp_pdma_phy *phy)
@@ -297,6 +388,7 @@ static void mmp_pdma_free_phy(struct mmp_pdma_chan *pchan)
 static void start_pending_queue(struct mmp_pdma_chan *chan)
 {
 	struct mmp_pdma_desc_sw *desc;
+	struct mmp_pdma_device *pdev = to_mmp_pdma_dev(chan->chan.device);
 
 	/* still in running, irq will start the pending list */
 	if (!chan->idle) {
@@ -331,7 +423,7 @@ static void start_pending_queue(struct mmp_pdma_chan *chan)
 	 * Program the descriptor's address into the DMA controller,
 	 * then start the DMA transaction
 	 */
-	set_desc(chan->phy, desc->async_tx.phys);
+	pdev->ops->write_next_addr(chan->phy, desc->async_tx.phys);
 	enable_chan(chan->phy);
 	chan->idle = false;
 }
@@ -447,6 +539,7 @@ mmp_pdma_prep_memcpy(struct dma_chan *dchan,
 		     size_t len, unsigned long flags)
 {
 	struct mmp_pdma_chan *chan;
+	struct mmp_pdma_device *pdev = to_mmp_pdma_dev(dchan->device);
 	struct mmp_pdma_desc_sw *first = NULL, *prev = NULL, *new;
 	size_t copy = 0;
 
@@ -478,13 +571,14 @@ mmp_pdma_prep_memcpy(struct dma_chan *dchan,
 			chan->byte_align = true;
 
 		new->desc.dcmd = chan->dcmd | (DCMD_LENGTH & copy);
-		new->desc.dsadr = dma_src;
-		new->desc.dtadr = dma_dst;
+		pdev->ops->set_desc_src_addr(&new->desc, dma_src);
+		pdev->ops->set_desc_dst_addr(&new->desc, dma_dst);
 
 		if (!first)
 			first = new;
 		else
-			prev->desc.ddadr = new->async_tx.phys;
+			pdev->ops->set_desc_next_addr(&prev->desc,
+						      new->async_tx.phys);
 
 		new->async_tx.cookie = 0;
 		async_tx_ack(&new->async_tx);
@@ -528,6 +622,7 @@ mmp_pdma_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 		       unsigned long flags, void *context)
 {
 	struct mmp_pdma_chan *chan = to_mmp_pdma_chan(dchan);
+	struct mmp_pdma_device *pdev = to_mmp_pdma_dev(dchan->device);
 	struct mmp_pdma_desc_sw *first = NULL, *prev = NULL, *new = NULL;
 	size_t len, avail;
 	struct scatterlist *sg;
@@ -559,17 +654,18 @@ mmp_pdma_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 
 			new->desc.dcmd = chan->dcmd | (DCMD_LENGTH & len);
 			if (dir == DMA_MEM_TO_DEV) {
-				new->desc.dsadr = addr;
+				pdev->ops->set_desc_src_addr(&new->desc, addr);
 				new->desc.dtadr = chan->dev_addr;
 			} else {
 				new->desc.dsadr = chan->dev_addr;
-				new->desc.dtadr = addr;
+				pdev->ops->set_desc_dst_addr(&new->desc, addr);
 			}
 
 			if (!first)
 				first = new;
 			else
-				prev->desc.ddadr = new->async_tx.phys;
+				pdev->ops->set_desc_next_addr(&prev->desc,
+							   new->async_tx.phys);
 
 			new->async_tx.cookie = 0;
 			async_tx_ack(&new->async_tx);
@@ -609,6 +705,7 @@ mmp_pdma_prep_dma_cyclic(struct dma_chan *dchan,
 			 unsigned long flags)
 {
 	struct mmp_pdma_chan *chan;
+	struct mmp_pdma_device *pdev = to_mmp_pdma_dev(dchan->device);
 	struct mmp_pdma_desc_sw *first = NULL, *prev = NULL, *new;
 	dma_addr_t dma_src, dma_dst;
 
@@ -651,13 +748,14 @@ mmp_pdma_prep_dma_cyclic(struct dma_chan *dchan,
 
 		new->desc.dcmd = (chan->dcmd | DCMD_ENDIRQEN |
 				  (DCMD_LENGTH & period_len));
-		new->desc.dsadr = dma_src;
-		new->desc.dtadr = dma_dst;
+		pdev->ops->set_desc_src_addr(&new->desc, dma_src);
+		pdev->ops->set_desc_dst_addr(&new->desc, dma_dst);
 
 		if (!first)
 			first = new;
 		else
-			prev->desc.ddadr = new->async_tx.phys;
+			pdev->ops->set_desc_next_addr(&prev->desc,
+						      new->async_tx.phys);
 
 		new->async_tx.cookie = 0;
 		async_tx_ack(&new->async_tx);
@@ -678,7 +776,7 @@ mmp_pdma_prep_dma_cyclic(struct dma_chan *dchan,
 	first->async_tx.cookie = -EBUSY;
 
 	/* make the cyclic link */
-	new->desc.ddadr = first->async_tx.phys;
+	pdev->ops->set_desc_next_addr(&new->desc, first->async_tx.phys);
 	chan->cyclic_first = first;
 
 	return &first->async_tx;
@@ -764,7 +862,9 @@ static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan,
 				     dma_cookie_t cookie)
 {
 	struct mmp_pdma_desc_sw *sw;
-	u32 curr, residue = 0;
+	struct mmp_pdma_device *pdev = to_mmp_pdma_dev(chan->chan.device);
+	u64 curr;
+	u32 residue = 0;
 	bool passed = false;
 	bool cyclic = chan->cyclic_first != NULL;
 
@@ -776,17 +876,18 @@ static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan,
 		return 0;
 
 	if (chan->dir == DMA_DEV_TO_MEM)
-		curr = readl(chan->phy->base + DTADR(chan->phy->idx));
+		curr = pdev->ops->read_dst_addr(chan->phy);
 	else
-		curr = readl(chan->phy->base + DSADR(chan->phy->idx));
+		curr = pdev->ops->read_src_addr(chan->phy);
 
 	list_for_each_entry(sw, &chan->chain_running, node) {
-		u32 start, end, len;
+		u64 start, end;
+		u32 len;
 
 		if (chan->dir == DMA_DEV_TO_MEM)
-			start = sw->desc.dtadr;
+			start = pdev->ops->get_desc_dst_addr(&sw->desc);
 		else
-			start = sw->desc.dsadr;
+			start = pdev->ops->get_desc_src_addr(&sw->desc);
 
 		len = sw->desc.dcmd & DCMD_LENGTH;
 		end = start + len;
@@ -802,7 +903,7 @@ static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan,
 		if (passed) {
 			residue += len;
 		} else if (curr >= start && curr <= end) {
-			residue += end - curr;
+			residue += (u32)(end - curr);
 			passed = true;
 		}
 
@@ -996,9 +1097,26 @@ static int mmp_pdma_chan_init(struct mmp_pdma_device *pdev, int idx, int irq)
 	return 0;
 }
 
+static const struct mmp_pdma_ops marvell_pdma_v1_ops = {
+	.write_next_addr = write_next_addr_32,
+	.read_src_addr = read_src_addr_32,
+	.read_dst_addr = read_dst_addr_32,
+	.set_desc_next_addr = set_desc_next_addr_32,
+	.set_desc_src_addr = set_desc_src_addr_32,
+	.set_desc_dst_addr = set_desc_dst_addr_32,
+	.get_desc_src_addr = get_desc_src_addr_32,
+	.get_desc_dst_addr = get_desc_dst_addr_32,
+	.run_bits = (DCSR_RUN),
+	.dma_mask = 0,			/* let OF/platform set DMA mask */
+};
+
 static const struct of_device_id mmp_pdma_dt_ids[] = {
-	{ .compatible = "marvell,pdma-1.0", },
-	{}
+	{
+		.compatible = "marvell,pdma-1.0",
+		.data = &marvell_pdma_v1_ops
+	}, {
+		/* sentinel */
+	}
 };
 MODULE_DEVICE_TABLE(of, mmp_pdma_dt_ids);
 
@@ -1050,6 +1168,10 @@ static int mmp_pdma_probe(struct platform_device *op)
 	if (IS_ERR(rst))
 		return PTR_ERR(rst);
 
+	pdev->ops = of_device_get_match_data(&op->dev);
+	if (!pdev->ops)
+		return -ENODEV;
+
 	if (pdev->dev->of_node) {
 		/* Parse new and deprecated dma-channels properties */
 		if (of_property_read_u32(pdev->dev->of_node, "dma-channels",
@@ -1111,7 +1233,10 @@ static int mmp_pdma_probe(struct platform_device *op)
 	pdev->device.directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
 	pdev->device.residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
 
-	if (pdev->dev->coherent_dma_mask)
+	/* Set DMA mask based on ops->dma_mask, or OF/platform */
+	if (pdev->ops->dma_mask)
+		dma_set_mask(pdev->dev, pdev->ops->dma_mask);
+	else if (pdev->dev->coherent_dma_mask)
 		dma_set_mask(pdev->dev, pdev->dev->coherent_dma_mask);
 	else
 		dma_set_mask(pdev->dev, DMA_BIT_MASK(64));

-- 
2.43.0


