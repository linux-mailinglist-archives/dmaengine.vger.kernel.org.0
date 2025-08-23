Return-Path: <dmaengine+bounces-6175-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1629CB32A30
	for <lists+dmaengine@lfdr.de>; Sat, 23 Aug 2025 18:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DE2B3BBCFE
	for <lists+dmaengine@lfdr.de>; Sat, 23 Aug 2025 16:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF65A2EE294;
	Sat, 23 Aug 2025 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WryLcYN9"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA7B2EE286;
	Sat, 23 Aug 2025 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964693; cv=none; b=o2lFr/ONgPlWB3nfY1Vfj6mRUQGznt5y+39bZqlHZstLN3lXegdMmNshw3KmN8rBtbwnUEuXl3YTRAlIlGYTGD6KJyFycDKOWQaH5Gf7neICs4OupNsvyli+fbTU5a/5AICERqs5nWxfrVXKLxTvWNIWRm95wqJhupt273hWqg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964693; c=relaxed/simple;
	bh=qolTBlBw2PozsN1Fup62X3yppfz8OpcDwdfJ1vDz0f8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFCQ+V/0x+BvCGYJ7Ckw91w2OwcjmTrx58KHttuyzAHyM6yHfBtibPQNpM4CI6mod6scuGT1zeMhSJs4llMAriaNzRjPVBV7naxtO0ZHDoBWIc8LSEInp7NSx8aAOjg08CXbmSoSnY/V2Pu/hi44SytdLScCNnzaQ5dWGF373C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WryLcYN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D700C4CEE7;
	Sat, 23 Aug 2025 15:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755964693;
	bh=qolTBlBw2PozsN1Fup62X3yppfz8OpcDwdfJ1vDz0f8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WryLcYN9gb5NscqUUE608gxgzI6JFjz2ED7ziimYFhHNAwa26FvmC96TQwqInOJtO
	 klQJv/49Svzx+B12Br464PBTyqRpqu+s08Y8/CpIKU0qBL+wNw/jdD0BfVLKOxeE/d
	 s2Bz2ys+3zQj5TQFsImNpmULzM+mpfuUKNLIKA1Dzl49T1MUE/qBBDuaxvLSq3H4TW
	 D2HSHRfE4jgPKdnvoYIBspufIIffzaQ4POtx8cld/1Cj/PrAbOxQIh1AZ3og6kvubx
	 kg0TLOPYSPiNi3rFhvdXzSJv4yYw7Hb4q7G7QF0t/85C3erBbKNm0+iaOhfbwY25EP
	 6mSVhzvNjcBjA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/14] dmaengine: dma350: Support ARM DMA-250
Date: Sat, 23 Aug 2025 23:40:09 +0800
Message-ID: <20250823154009.25992-15-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250823154009.25992-1-jszhang@kernel.org>
References: <20250823154009.25992-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compared with ARM DMA-350, DMA-250 is a simplified version. They share
many common parts, but they do have difference. Add DMA-250 support
by handling their difference by using different device_prep_slave_sg,
device_prep_dma_cyclic and device_prep_dma_memcpy. DMA-250 doesn't
support device_prep_dma_memset.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/dma/arm-dma350.c | 444 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 424 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
index 5abb965c6687..0ee807424b7e 100644
--- a/drivers/dma/arm-dma350.c
+++ b/drivers/dma/arm-dma350.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2024-2025 Arm Limited
 // Copyright (C) 2025 Synaptics Incorporated
-// Arm DMA-350 driver
+// Arm DMA-350/DMA-250 driver
 
 #include <linux/bitfield.h>
 #include <linux/dmaengine.h>
@@ -16,6 +16,10 @@
 #include "dmaengine.h"
 #include "virt-dma.h"
 
+#define DMANSECCTRL		0x0200
+
+#define NSEC_CNTXBASE		0x10
+
 #define DMAINFO			0x0f00
 
 #define DMA_BUILDCFG0		0xb0
@@ -26,12 +30,16 @@
 #define DMA_BUILDCFG1		0xb4
 #define DMA_CFG_NUM_TRIGGER_IN	GENMASK(8, 0)
 
+#define DMA_BUILDCFG2		0xb8
+#define DMA_CFG_HAS_TZ		BIT(8)
+
 #define IIDR			0xc8
 #define IIDR_PRODUCTID		GENMASK(31, 20)
 #define IIDR_VARIANT		GENMASK(19, 16)
 #define IIDR_REVISION		GENMASK(15, 12)
 #define IIDR_IMPLEMENTER	GENMASK(11, 0)
 
+#define PRODUCTID_DMA250	0x250
 #define PRODUCTID_DMA350	0x3a0
 #define IMPLEMENTER_ARM		0x43b
 
@@ -140,6 +148,7 @@
 #define CH_CFG_HAS_TRIGSEL	BIT(7)
 #define CH_CFG_HAS_TRIGIN	BIT(5)
 #define CH_CFG_HAS_WRAP		BIT(1)
+#define CH_CFG_HAS_XSIZEHI	BIT(0)
 
 
 #define LINK_REGCLEAR		BIT(0)
@@ -218,6 +227,7 @@ struct d350_chan {
 	bool cyclic;
 	bool has_trig;
 	bool has_wrap;
+	bool has_xsizehi;
 	bool coherent;
 };
 
@@ -225,6 +235,10 @@ struct d350 {
 	struct dma_device dma;
 	int nchan;
 	int nreq;
+	bool is_d250;
+	dma_addr_t cntx_mem_paddr;
+	void *cntx_mem;
+	u32 cntx_mem_size;
 	struct d350_chan channels[] __counted_by(nchan);
 };
 
@@ -238,6 +252,11 @@ static inline struct d350_desc *to_d350_desc(struct virt_dma_desc *vd)
 	return container_of(vd, struct d350_desc, vd);
 }
 
+static inline struct d350 *to_d350(struct dma_device *dd)
+{
+	return container_of(dd, struct d350, dma);
+}
+
 static void d350_desc_free(struct virt_dma_desc *vd)
 {
 	struct d350_chan *dch = to_d350_chan(vd->tx.chan);
@@ -585,6 +604,337 @@ static int d350_slave_config(struct dma_chan *chan, struct dma_slave_config *con
 	return 0;
 }
 
+static struct dma_async_tx_descriptor *d250_prep_memcpy(struct dma_chan *chan,
+		dma_addr_t dest, dma_addr_t src, size_t len, unsigned long flags)
+{
+	struct d350_chan *dch = to_d350_chan(chan);
+	struct d350_desc *desc;
+	u32 *cmd, *la_cmd, tsz;
+	int sglen, i;
+	struct d350_sg *sg;
+	size_t xfer_len, step_max;
+	dma_addr_t phys;
+
+	tsz = __ffs(len | dest | src | (1 << dch->tsz));
+	step_max = ((1UL << 16) - 1) << tsz;
+	sglen = DIV_ROUND_UP(len, step_max);
+
+	desc = kzalloc(struct_size(desc, sg, sglen), GFP_NOWAIT);
+	if (!desc)
+		return NULL;
+
+	desc->sglen = sglen;
+	sglen = 0;
+	while (len) {
+		sg = &desc->sg[sglen];
+		xfer_len = (len > step_max) ? step_max : len;
+		sg->tsz = __ffs(xfer_len | dest | src | (1 << dch->tsz));
+		sg->xsize = lower_16_bits(xfer_len >> sg->tsz);
+
+		sg->command = dma_pool_zalloc(dch->cmd_pool, GFP_NOWAIT, &phys);
+		if (unlikely(!sg->command))
+			goto err_cmd_alloc;
+		sg->phys = phys;
+
+		cmd = sg->command;
+		if (!sglen) {
+			cmd[0] = LINK_CTRL | LINK_SRCADDR | LINK_DESADDR |
+				 LINK_XSIZE | LINK_SRCTRANSCFG |
+				 LINK_DESTRANSCFG | LINK_XADDRINC | LINK_LINKADDR;
+
+			cmd[1] = FIELD_PREP(CH_CTRL_TRANSIZE, sg->tsz) |
+				 FIELD_PREP(CH_CTRL_XTYPE, CH_CTRL_XTYPE_CONTINUE);
+
+			cmd[2] = lower_32_bits(src);
+			cmd[3] = lower_32_bits(dest);
+			cmd[4] = FIELD_PREP(CH_XY_SRC, sg->xsize) |
+				 FIELD_PREP(CH_XY_DES, sg->xsize);
+			cmd[5] = dch->coherent ? TRANSCFG_WB : TRANSCFG_NC;
+			cmd[6] = dch->coherent ? TRANSCFG_WB : TRANSCFG_NC;
+			cmd[7] = FIELD_PREP(CH_XY_SRC, 1) | FIELD_PREP(CH_XY_DES, 1);
+			la_cmd = &cmd[8];
+		} else {
+			*la_cmd = phys | CH_LINKADDR_EN;
+			if (len <= step_max) {
+				cmd[0] = LINK_CTRL | LINK_XSIZE | LINK_LINKADDR;
+				cmd[1] = FIELD_PREP(CH_CTRL_TRANSIZE, sg->tsz) |
+					 FIELD_PREP(CH_CTRL_XTYPE, CH_CTRL_XTYPE_CONTINUE);
+				cmd[2] = FIELD_PREP(CH_XY_SRC, sg->xsize) |
+					 FIELD_PREP(CH_XY_DES, sg->xsize);
+				la_cmd = &cmd[3];
+			} else {
+				cmd[0] = LINK_XSIZE | LINK_LINKADDR;
+				cmd[1] = FIELD_PREP(CH_XY_SRC, sg->xsize) |
+					 FIELD_PREP(CH_XY_DES, sg->xsize);
+				la_cmd = &cmd[2];
+			}
+		}
+
+		len -= xfer_len;
+		src += xfer_len;
+		dest += xfer_len;
+		sglen++;
+	}
+
+	/* the last cmdlink */
+	*la_cmd = 0;
+	desc->sg[sglen - 1].command[1] |= FIELD_PREP(CH_CTRL_DONETYPE, CH_CTRL_DONETYPE_CMD);
+
+	mb();
+
+	return vchan_tx_prep(&dch->vc, &desc->vd, flags);
+
+err_cmd_alloc:
+	for (i = 0; i < sglen; i++)
+		dma_pool_free(dch->cmd_pool, desc->sg[i].command, desc->sg[i].phys);
+	kfree(desc);
+	return NULL;
+}
+
+static struct dma_async_tx_descriptor *
+d250_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
+		   unsigned int sg_len, enum dma_transfer_direction dir,
+		   unsigned long flags, void *context)
+{
+	struct d350_chan *dch = to_d350_chan(chan);
+	dma_addr_t src, dst, phys, mem_addr;
+	size_t xfer_len, step_max;
+	u32 len, trig, *cmd, *la_cmd, tsz;
+	struct d350_desc *desc;
+	struct scatterlist *sg;
+	struct d350_sg *dsg;
+	int i, sglen = 0;
+
+	if (unlikely(!is_slave_direction(dir) || !sg_len))
+		return NULL;
+
+	if (dir == DMA_MEM_TO_DEV)
+		tsz = __ffs(dch->config.dst_addr_width | (1 << dch->tsz));
+	else
+		tsz = __ffs(dch->config.src_addr_width | (1 << dch->tsz));
+	step_max = ((1UL << 16) - 1) << tsz;
+
+	for_each_sg(sgl, sg, sg_len, i)
+		sglen += DIV_ROUND_UP(sg_dma_len(sg), step_max);
+
+	desc = kzalloc(struct_size(desc, sg, sglen), GFP_NOWAIT);
+	if (!desc)
+		return NULL;
+
+	desc->sglen = sglen;
+
+	sglen = 0;
+	for_each_sg(sgl, sg, sg_len, i) {
+		len = sg_dma_len(sg);
+		mem_addr = sg_dma_address(sg);
+
+		do {
+			desc->sg[sglen].command = dma_pool_zalloc(dch->cmd_pool, GFP_NOWAIT, &phys);
+			if (unlikely(!desc->sg[sglen].command))
+				goto err_cmd_alloc;
+
+			xfer_len = (len > step_max) ? step_max : len;
+			desc->sg[sglen].phys = phys;
+			dsg = &desc->sg[sglen];
+
+			if (dir == DMA_MEM_TO_DEV) {
+				src = mem_addr;
+				dst = dch->config.dst_addr;
+				trig = CH_CTRL_USEDESTRIGIN;
+			} else {
+				src = dch->config.src_addr;
+				dst = mem_addr;
+				trig = CH_CTRL_USESRCTRIGIN;
+			}
+			dsg->tsz = tsz;
+			dsg->xsize = lower_16_bits(xfer_len >> dsg->tsz);
+
+			cmd = dsg->command;
+			if (!sglen) {
+				cmd[0] = LINK_CTRL | LINK_SRCADDR | LINK_DESADDR |
+					 LINK_XSIZE | LINK_SRCTRANSCFG |
+					 LINK_DESTRANSCFG | LINK_XADDRINC | LINK_LINKADDR;
+
+				cmd[1] = FIELD_PREP(CH_CTRL_TRANSIZE, dsg->tsz) | trig |
+					 FIELD_PREP(CH_CTRL_XTYPE, CH_CTRL_XTYPE_CONTINUE);
+
+				cmd[2] = lower_32_bits(src);
+				cmd[3] = lower_32_bits(dst);
+				cmd[4] = FIELD_PREP(CH_XY_SRC, dsg->xsize) |
+					 FIELD_PREP(CH_XY_DES, dsg->xsize);
+				if (dir == DMA_MEM_TO_DEV) {
+					cmd[0] |= LINK_DESTRIGINCFG;
+					cmd[5] = dch->coherent ? TRANSCFG_WB : TRANSCFG_NC;
+					cmd[6] = TRANSCFG_DEVICE;
+					cmd[7] = FIELD_PREP(CH_XY_SRC, 1);
+					cmd[8] = FIELD_PREP(CH_DESTRIGINMODE, CH_DESTRIG_DMA_FC) |
+						  FIELD_PREP(CH_DESTRIGINTYPE, CH_DESTRIG_HW_REQ);
+				} else {
+					cmd[0] |= LINK_SRCTRIGINCFG;
+					cmd[5] = TRANSCFG_DEVICE;
+					cmd[6] = dch->coherent ? TRANSCFG_WB : TRANSCFG_NC;
+					cmd[7] = FIELD_PREP(CH_XY_DES, 1);
+					cmd[8] = FIELD_PREP(CH_SRCTRIGINMODE, CH_SRCTRIG_DMA_FC) |
+						  FIELD_PREP(CH_SRCTRIGINTYPE, CH_SRCTRIG_HW_REQ);
+				}
+				la_cmd = &cmd[9];
+			} else {
+				*la_cmd = phys | CH_LINKADDR_EN;
+				if (sglen == desc->sglen - 1) {
+					cmd[0] = LINK_CTRL | LINK_SRCADDR | LINK_DESADDR |
+						 LINK_XSIZE | LINK_LINKADDR;
+					cmd[1] = FIELD_PREP(CH_CTRL_TRANSIZE, dsg->tsz) | trig |
+						 FIELD_PREP(CH_CTRL_XTYPE, CH_CTRL_XTYPE_CONTINUE);
+					cmd[2] = lower_32_bits(src);
+					cmd[3] = lower_32_bits(dst);
+					cmd[4] = FIELD_PREP(CH_XY_SRC, dsg->xsize) |
+						 FIELD_PREP(CH_XY_DES, dsg->xsize);
+					la_cmd = &cmd[5];
+				} else {
+					cmd[0] = LINK_SRCADDR | LINK_DESADDR |
+						 LINK_XSIZE | LINK_LINKADDR;
+					cmd[1] = lower_32_bits(src);
+					cmd[2] = lower_32_bits(dst);
+					cmd[3] = FIELD_PREP(CH_XY_SRC, dsg->xsize) |
+						 FIELD_PREP(CH_XY_DES, dsg->xsize);
+					la_cmd = &cmd[4];
+				}
+			}
+
+			len -= xfer_len;
+			mem_addr += xfer_len;
+			sglen++;
+		} while (len);
+	}
+
+	/* the last command */
+	*la_cmd = 0;
+	desc->sg[sglen - 1].command[1] |= FIELD_PREP(CH_CTRL_DONETYPE, CH_CTRL_DONETYPE_CMD);
+
+	mb();
+
+	return vchan_tx_prep(&dch->vc, &desc->vd, flags);
+
+err_cmd_alloc:
+	for (i = 0; i < sglen; i++)
+		dma_pool_free(dch->cmd_pool, desc->sg[i].command, desc->sg[i].phys);
+	kfree(desc);
+	return NULL;
+}
+
+static struct dma_async_tx_descriptor *
+d250_prep_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
+		 size_t buf_len, size_t period_len, enum dma_transfer_direction dir,
+		 unsigned long flags)
+{
+	struct d350_chan *dch = to_d350_chan(chan);
+	u32 len, periods, trig, *cmd, tsz;
+	dma_addr_t src, dst, phys, mem_addr;
+	size_t xfer_len, step_max;
+	struct d350_desc *desc;
+	struct scatterlist *sg;
+	struct d350_sg *dsg;
+	int sglen, i;
+
+	if (unlikely(!is_slave_direction(dir) || !buf_len || !period_len))
+		return NULL;
+
+	if (dir == DMA_MEM_TO_DEV)
+		tsz = __ffs(dch->config.dst_addr_width | (1 << dch->tsz));
+	else
+		tsz = __ffs(dch->config.src_addr_width | (1 << dch->tsz));
+	step_max = ((1UL << 16) - 1) << tsz;
+
+	periods = buf_len / period_len;
+	sglen = DIV_ROUND_UP(sg_dma_len(sg), step_max) * periods;
+
+	desc = kzalloc(struct_size(desc, sg, sglen), GFP_NOWAIT);
+	if (!desc)
+		return NULL;
+
+	dch->cyclic = true;
+	dch->periods = periods;
+	desc->sglen = sglen;
+
+	sglen = 0;
+	for (i = 0; i < periods; i++) {
+		len = period_len;
+		mem_addr = buf_addr + i * period_len;
+		do {
+			desc->sg[sglen].command = dma_pool_zalloc(dch->cmd_pool, GFP_NOWAIT, &phys);
+			if (unlikely(!desc->sg[sglen].command))
+				goto err_cmd_alloc;
+
+			xfer_len = (len > step_max) ? step_max : len;
+			desc->sg[sglen].phys = phys;
+			dsg = &desc->sg[sglen];
+
+			if (dir == DMA_MEM_TO_DEV) {
+				src = mem_addr;
+				dst = dch->config.dst_addr;
+				trig = CH_CTRL_USEDESTRIGIN;
+			} else {
+				src = dch->config.src_addr;
+				dst = mem_addr;
+				trig = CH_CTRL_USESRCTRIGIN;
+			}
+			dsg->tsz = tsz;
+			dsg->xsize = lower_16_bits(xfer_len >> dsg->tsz);
+
+			cmd = dsg->command;
+			cmd[0] = LINK_CTRL | LINK_SRCADDR | LINK_DESADDR |
+				 LINK_XSIZE | LINK_SRCTRANSCFG |
+				 LINK_DESTRANSCFG | LINK_XADDRINC | LINK_LINKADDR;
+
+			cmd[1] = FIELD_PREP(CH_CTRL_TRANSIZE, dsg->tsz) |
+				 FIELD_PREP(CH_CTRL_XTYPE, CH_CTRL_XTYPE_CONTINUE) |
+				 FIELD_PREP(CH_CTRL_DONETYPE, CH_CTRL_DONETYPE_CMD) | trig;
+
+			cmd[2] = lower_32_bits(src);
+			cmd[3] = lower_32_bits(dst);
+			cmd[4] = FIELD_PREP(CH_XY_SRC, dsg->xsize) |
+				 FIELD_PREP(CH_XY_DES, dsg->xsize);
+			if (dir == DMA_MEM_TO_DEV) {
+				cmd[0] |= LINK_DESTRIGINCFG;
+				cmd[5] = dch->coherent ? TRANSCFG_WB : TRANSCFG_NC;
+				cmd[6] = TRANSCFG_DEVICE;
+				cmd[7] = FIELD_PREP(CH_XY_SRC, 1);
+				cmd[8] = FIELD_PREP(CH_DESTRIGINMODE, CH_DESTRIG_DMA_FC) |
+					  FIELD_PREP(CH_DESTRIGINTYPE, CH_DESTRIG_HW_REQ);
+			} else {
+				cmd[0] |= LINK_SRCTRIGINCFG;
+				cmd[5] = TRANSCFG_DEVICE;
+				cmd[6] = dch->coherent ? TRANSCFG_WB : TRANSCFG_NC;
+				cmd[7] = FIELD_PREP(CH_XY_DES, 1);
+				cmd[8] = FIELD_PREP(CH_SRCTRIGINMODE, CH_SRCTRIG_DMA_FC) |
+					  FIELD_PREP(CH_SRCTRIGINTYPE, CH_SRCTRIG_HW_REQ);
+			}
+
+			if (sglen)
+				desc->sg[sglen - 1].command[9] = phys | CH_LINKADDR_EN;
+
+			len -= xfer_len;
+			mem_addr += xfer_len;
+			sglen++;
+		} while (len);
+		desc->sg[sglen - 1].command[1] |= FIELD_PREP(CH_CTRL_DONETYPE,
+							     CH_CTRL_DONETYPE_CMD);
+	}
+
+	/* cyclic list */
+	desc->sg[sglen - 1].command[9] = desc->sg[0].phys | CH_LINKADDR_EN;
+
+	mb();
+
+	return vchan_tx_prep(&dch->vc, &desc->vd, flags);
+
+err_cmd_alloc:
+	for (i = 0; i < sglen; i++)
+		dma_pool_free(dch->cmd_pool, desc->sg[i].command, desc->sg[i].phys);
+	kfree(desc);
+	return NULL;
+}
+
 static int d350_pause(struct dma_chan *chan)
 {
 	struct d350_chan *dch = to_d350_chan(chan);
@@ -620,20 +970,31 @@ static u32 d350_get_residue(struct d350_chan *dch)
 	u32 res, xsize, xsizehi, linkaddr, linkaddrhi, hi_new;
 	int i, sgcur, retries = 3; /* 1st time unlucky, 2nd improbable, 3rd just broken */
 	struct d350_desc *desc = dch->desc;
+	struct d350 *dmac = to_d350(dch->vc.chan.device);
 
-	hi_new = readl_relaxed(dch->base + CH_XSIZEHI);
-	do {
-		xsizehi = hi_new;
-		xsize = readl_relaxed(dch->base + CH_XSIZE);
+	if (dch->has_xsizehi) {
 		hi_new = readl_relaxed(dch->base + CH_XSIZEHI);
-	} while (xsizehi != hi_new && --retries);
+		do {
+			xsizehi = hi_new;
+			xsize = readl_relaxed(dch->base + CH_XSIZE);
+			hi_new = readl_relaxed(dch->base + CH_XSIZEHI);
+		} while (xsizehi != hi_new && --retries);
+	} else {
+		xsize = readl_relaxed(dch->base + CH_XSIZE);
+		xsizehi = 0;
+	}
 
-	hi_new = readl_relaxed(dch->base + CH_LINKADDRHI);
-	do {
-		linkaddrhi = hi_new;
-		linkaddr = readl_relaxed(dch->base + CH_LINKADDR);
+	if (!dmac->is_d250) {
 		hi_new = readl_relaxed(dch->base + CH_LINKADDRHI);
-	} while (linkaddrhi != hi_new && --retries);
+		do {
+			linkaddrhi = hi_new;
+			linkaddr = readl_relaxed(dch->base + CH_LINKADDR);
+			hi_new = readl_relaxed(dch->base + CH_LINKADDRHI);
+		} while (linkaddrhi != hi_new && --retries);
+	} else {
+		linkaddr = readl_relaxed(dch->base + CH_LINKADDR);
+		linkaddrhi = 0;
+	}
 
 	for (i = 0; i < desc->sglen; i++) {
 		if (desc->sg[i].phys == (((u64)linkaddrhi << 32) | (linkaddr & ~CH_LINKADDR_EN)))
@@ -876,6 +1237,14 @@ static void d350_free_chan_resources(struct dma_chan *chan)
 	dch->cmd_pool = NULL;
 }
 
+static void d250_cntx_mem_release(void *ptr)
+{
+	struct d350 *dmac = ptr;
+	struct device *dev = dmac->dma.dev;
+
+	dma_free_coherent(dev, dmac->cntx_mem_size, dmac->cntx_mem, dmac->cntx_mem_paddr);
+}
+
 static int d350_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -893,8 +1262,9 @@ static int d350_probe(struct platform_device *pdev)
 	r = FIELD_GET(IIDR_VARIANT, reg);
 	p = FIELD_GET(IIDR_REVISION, reg);
 	if (FIELD_GET(IIDR_IMPLEMENTER, reg) != IMPLEMENTER_ARM ||
-	    FIELD_GET(IIDR_PRODUCTID, reg) != PRODUCTID_DMA350)
-		return dev_err_probe(dev, -ENODEV, "Not a DMA-350!");
+	    ((FIELD_GET(IIDR_PRODUCTID, reg) != PRODUCTID_DMA350) &&
+	    FIELD_GET(IIDR_PRODUCTID, reg) != PRODUCTID_DMA250))
+		return dev_err_probe(dev, -ENODEV, "Not a DMA-350/DMA-250!");
 
 	reg = readl_relaxed(base + DMAINFO + DMA_BUILDCFG0);
 	nchan = FIELD_GET(DMA_CFG_NUM_CHANNELS, reg) + 1;
@@ -917,13 +1287,38 @@ static int d350_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (device_is_compatible(dev, "arm,dma-250")) {
+		u32 cfg2;
+		int secext_present;
+
+		dmac->is_d250 = true;
+
+		cfg2 = readl_relaxed(base + DMAINFO + DMA_BUILDCFG2);
+		secext_present = (cfg2 & DMA_CFG_HAS_TZ) ? 1 : 0;
+		dmac->cntx_mem_size = nchan * 64 * (1 + secext_present);
+		dmac->cntx_mem = dma_alloc_coherent(dev, dmac->cntx_mem_size,
+						    &dmac->cntx_mem_paddr,
+						    GFP_KERNEL);
+		if (!dmac->cntx_mem)
+			return dev_err_probe(dev, -ENOMEM, "Failed to alloc context memory\n");
+
+		ret = devm_add_action_or_reset(dev, d250_cntx_mem_release, dmac);
+		if (ret) {
+			dma_free_coherent(dev, dmac->cntx_mem_size,
+					  dmac->cntx_mem, dmac->cntx_mem_paddr);
+			return ret;
+		}
+		writel_relaxed(dmac->cntx_mem_paddr, base + DMANSECCTRL + NSEC_CNTXBASE);
+	}
+
 	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(aw));
 	coherent = device_get_dma_attr(dev) == DEV_DMA_COHERENT;
 
 	reg = readl_relaxed(base + DMAINFO + DMA_BUILDCFG1);
 	dmac->nreq = FIELD_GET(DMA_CFG_NUM_TRIGGER_IN, reg);
 
-	dev_dbg(dev, "DMA-350 r%dp%d with %d channels, %d requests\n", r, p, dmac->nchan, dmac->nreq);
+	dev_info(dev, "%s r%dp%d with %d channels, %d requests\n",
+		 dmac->is_d250 ? "DMA-250" : "DMA-350", r, p, dmac->nchan, dmac->nreq);
 
 	for (int i = min(dw, 16); i > 0; i /= 2) {
 		dmac->dma.src_addr_widths |= BIT(i);
@@ -935,7 +1330,10 @@ static int d350_probe(struct platform_device *pdev)
 	dmac->dma.device_alloc_chan_resources = d350_alloc_chan_resources;
 	dmac->dma.device_free_chan_resources = d350_free_chan_resources;
 	dma_cap_set(DMA_MEMCPY, dmac->dma.cap_mask);
-	dmac->dma.device_prep_dma_memcpy = d350_prep_memcpy;
+	if (dmac->is_d250)
+		dmac->dma.device_prep_dma_memcpy = d250_prep_memcpy;
+	else
+		dmac->dma.device_prep_dma_memcpy = d350_prep_memcpy;
 	dmac->dma.device_pause = d350_pause;
 	dmac->dma.device_resume = d350_resume;
 	dmac->dma.device_terminate_all = d350_terminate_all;
@@ -971,8 +1369,8 @@ static int d350_probe(struct platform_device *pdev)
 			return dch->irq;
 
 		dch->has_wrap = FIELD_GET(CH_CFG_HAS_WRAP, reg);
-		dch->has_trig = FIELD_GET(CH_CFG_HAS_TRIGIN, reg) &
-				FIELD_GET(CH_CFG_HAS_TRIGSEL, reg);
+		dch->has_xsizehi = FIELD_GET(CH_CFG_HAS_XSIZEHI, reg);
+		dch->has_trig = FIELD_GET(CH_CFG_HAS_TRIGIN, reg);
 
 		/* Fill is a special case of Wrap */
 		memset &= dch->has_wrap;
@@ -994,8 +1392,13 @@ static int d350_probe(struct platform_device *pdev)
 		dma_cap_set(DMA_SLAVE, dmac->dma.cap_mask);
 		dma_cap_set(DMA_CYCLIC, dmac->dma.cap_mask);
 		dmac->dma.device_config = d350_slave_config;
-		dmac->dma.device_prep_slave_sg = d350_prep_slave_sg;
-		dmac->dma.device_prep_dma_cyclic = d350_prep_cyclic;
+		if (dmac->is_d250) {
+			dmac->dma.device_prep_slave_sg = d250_prep_slave_sg;
+			dmac->dma.device_prep_dma_cyclic = d250_prep_cyclic;
+		} else {
+			dmac->dma.device_prep_slave_sg = d350_prep_slave_sg;
+			dmac->dma.device_prep_dma_cyclic = d350_prep_cyclic;
+		}
 	}
 
 	if (memset) {
@@ -1019,6 +1422,7 @@ static void d350_remove(struct platform_device *pdev)
 
 static const struct of_device_id d350_of_match[] __maybe_unused = {
 	{ .compatible = "arm,dma-350" },
+	{ .compatible = "arm,dma-250" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, d350_of_match);
@@ -1035,5 +1439,5 @@ module_platform_driver(d350_driver);
 
 MODULE_AUTHOR("Robin Murphy <robin.murphy@arm.com>");
 MODULE_AUTHOR("Jisheng Zhang <jszhang@kernel.org>");
-MODULE_DESCRIPTION("Arm DMA-350 driver");
+MODULE_DESCRIPTION("Arm DMA-350/DMA-250 driver");
 MODULE_LICENSE("GPL v2");
-- 
2.50.0


