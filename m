Return-Path: <dmaengine+bounces-6415-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A589B462A8
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 20:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B14A61BED
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 18:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56687280339;
	Fri,  5 Sep 2025 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FglUFUls"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF6527A92D;
	Fri,  5 Sep 2025 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098131; cv=none; b=dl8TcMgFJ3dyy1567bxOJsfOgGrDW5Vu0sq5W9jlPmYX1LIpEOis9YsjtJYcqMS7xzTLyfmGPRK93PzKDB6MrV59ltkpwiftBWJmtpdzgk9Fm5ehgwMEeN96HFtNC4ZSWHAgcwxoDxPItxYsH73HzUsjmyU5+wbJDNbDFxNkOMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098131; c=relaxed/simple;
	bh=oY7DZ4hu+GU2kn9kp52VDZlC4m4nEfN7jMAWydDl790=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aFW6qMviFB0CvUQyHzs2RXJ7GaqMMLroCFMCv3sHzYNpz39uZ2920OWZ+NBOHGM3i8MJvhebjHBWYugiwe5vqi/oWiYD9qSVQVPBB3qonag08aXS1vKeXbxxp0MisOb0GZlzx6TEBm4MmECtNjOK6BkVgUACiigX1qr5uoyFkiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FglUFUls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AEC5C4CEF9;
	Fri,  5 Sep 2025 18:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757098130;
	bh=oY7DZ4hu+GU2kn9kp52VDZlC4m4nEfN7jMAWydDl790=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FglUFUlseaITtECkehYpxpd9i2FQiH1tvTo0q74DfX3/H2ChAScDInehOwTsWKQuu
	 JkvN9icN9jYxsalV9iVnHFxPMzOIMcRL9EoBI0N5zOKyoIrVX77nGX183V9nGvdNIm
	 +E6rZFp/TRIlYRQ2Gk4rRuaWFYOWZIgDXLwUSd5xKorZO8EG+NAUFKKhsAs3PrS6rK
	 9G0RptGZ59F1T9Ad5JaojN1/L4squk8MDgTgDJCuCaZS1IATSegnJBHYrvQAwcs6o7
	 I9rbMI68QYSxZEJs2TiC3+bpgoIB8eyPAuxSwYbBRqQFd+P1YIDVOcKVvZcqJncY5C
	 x5PZF6HYnWoyQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94130CAC581;
	Fri,  5 Sep 2025 18:48:50 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 05 Sep 2025 13:48:28 -0500
Subject: [PATCH RFC 05/13] dmaengine: sdxi: Add software data structures
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-sdxi-base-v1-5-d0341a1292ba@amd.com>
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
In-Reply-To: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Wei Huang <wei.huang2@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757098128; l=6245;
 i=nathan.lynch@amd.com; s=20241010; h=from:subject:message-id;
 bh=6veT8qjJZW/zhzeosOQPDAoX6bJfuMluVBRqdMpn4R0=;
 b=2xrS4Vw5j64mX6zutDqCi9KaHmiUMwtNrlbgWk/6ag/G5hWq881JNMASZ1qj0YOsCmh2inFvJ
 OirL2NdFFWCA/VrewmfKGIgPTO2wwHG/oPShdgR3wL+5Hd22Xae3v8m
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=ZR637UTGg5YLDj56cxFeHdYoUjPMMFbcijfOkAmAnbc=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20241010 with
 auth_id=241
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com

From: Nathan Lynch <nathan.lynch@amd.com>

Add the driver's central header sdxi.h, which brings in the major
software abstractions used throughout the driver -- mainly the SDXI
device or function (sdxi_dev) and context (sdxi_cxt).

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/sdxi.h | 206 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 206 insertions(+)

diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
new file mode 100644
index 0000000000000000000000000000000000000000..13e02f0541e0d60412c99b0b75bd37155a531e1d
--- /dev/null
+++ b/drivers/dma/sdxi/sdxi.h
@@ -0,0 +1,206 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SDXI device driver header
+ *
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ */
+
+#ifndef __SDXI_H
+#define __SDXI_H
+
+#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmapool.h>
+#include <linux/dmaengine.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+
+#include "../virt-dma.h"
+#include "hw.h"
+#include "mmio.h"
+
+#define SDXI_DRV_NAME		"sdxi"
+
+#define ID_TO_L2_INDEX(id)	(((id) >> 9) & 0x1FF)
+#define ID_TO_L1_INDEX(id)	((id) & 0x7F)
+#define IS_VF_DEVICE(sdxi)	((sdxi)->is_vf)
+
+#define L2_TABLE_ENTRIES	(1 << 9)
+#define L1_TABLE_ENTRIES	(1 << 7)
+#define L2_TABLE_SIZE		4096
+#define L1_TABLE_SIZE		4096
+
+#define OP_TYPE_ERRLOG          0x7f7
+
+#define DESC_RING_BASE_PTR_SHIFT	6
+#define CXT_STATUS_PTR_SHIFT		4
+#define WRT_INDEX_PTR_SHIFT		3
+
+#define L1_CXT_CTRL_PTR_SHIFT		6
+#define L1_CXT_AKEY_PTR_SHIFT		12
+
+#define MAX_DMA_COPY_BYTES		(1ULL << 32)
+
+/* Submission Queue */
+struct sdxi_sq {
+	struct sdxi_cxt *cxt;		/* owner */
+
+	u32 ring_entries;
+	u32 ring_size;
+	struct sdxi_desc *desc_ring;
+	dma_addr_t ring_dma;
+
+	__le64 *write_index;
+	dma_addr_t write_index_dma;
+
+	struct sdxi_cxt_sts *cxt_sts;
+	dma_addr_t cxt_sts_dma;
+
+	/* NB: define doorbell here */
+};
+
+struct sdxi_tasklet_data {
+	struct sdxi_cmd *cmd;
+};
+
+struct sdxi_cmd {
+	struct work_struct work;
+	struct sdxi_cxt *cxt;
+	struct sdxi_cst_blk *cst_blk;
+	dma_addr_t cst_blk_dma;
+	int ret;
+	size_t len;
+	u64 src_addr;
+	u64 dst_addr;
+	/* completion callback support */
+	void (*sdxi_cmd_callback)(void *data, int err);
+	void *data;
+};
+
+struct sdxi_dma_chan {
+	struct virt_dma_chan vc;
+	struct sdxi_cxt *cxt;
+};
+
+/*
+ * The size of the AKey table is flexible, from 4KB to 1MB. Always use
+ * the minimum size for now.
+ */
+struct sdxi_akey_table {
+	struct sdxi_akey_ent entry[SZ_4K / sizeof(struct sdxi_akey_ent)];
+};
+
+/* For encoding the akey table size in CXT_L1_ENT's akey_sz. */
+static inline u8 akey_table_order(const struct sdxi_akey_table *tbl)
+{
+	static_assert(sizeof(struct sdxi_akey_table) == SZ_4K);
+	return 0;
+}
+
+/* Context */
+struct sdxi_cxt {
+	struct sdxi_dev *sdxi;	/* owner */
+	unsigned int id;
+
+	resource_size_t db_base;	/* doorbell MMIO base addr */
+	__le64 __iomem *db;		/* doorbell virt addr */
+
+	struct sdxi_cxt_ctl *cxt_ctl;
+	dma_addr_t cxt_ctl_dma;
+
+	struct sdxi_akey_table *akey_table;
+	dma_addr_t akey_table_dma;
+
+	struct sdxi_sq *sq;
+
+	/* NB: might need to move to sdxi_device? */
+	struct sdxi_dma_chan sdxi_dma_chan;
+
+	struct sdxi_process *process;	/* process reprsentation */
+};
+
+/**
+ * struct sdxi_dev_ops - Bus-specific methods for SDXI devices.
+ *
+ * @irq_init: Allocate MSIs.
+ * @irq_exit: Release MSIs.
+ */
+struct sdxi_dev_ops {
+	int (*irq_init)(struct sdxi_dev *sdxi);
+	void (*irq_exit)(struct sdxi_dev *sdxi);
+};
+
+struct sdxi_dev {
+	struct device *dev;
+	resource_size_t ctrl_regs_bar;	/* ctrl registers base (BAR0) */
+	resource_size_t dbs_bar;	/* doorbells base (BAR2) */
+	void __iomem *ctrl_regs;	/* virt addr of ctrl registers */
+	void __iomem *dbs;		/* virt addr of doorbells */
+
+	/* hardware capabilities (from cap0 & cap1) */
+	u16 sfunc;			/* function's requester id */
+	u32 db_stride;			/* doorbell stride in bytes */
+	u64 max_ring_entries;		/* max # of ring entries supported */
+
+	u32 max_akeys;			/* max akey # supported */
+	u32 max_cxts;			/* max contexts # supported */
+	u32 op_grp_cap;			/* supported operatation group cap */
+
+	/* context management */
+	struct mutex cxt_lock;		/* context protection */
+	int cxt_count;
+	struct sdxi_cxt_l2_table *l2_table;
+	dma_addr_t l2_dma;
+	/* list of context l1 tables, on-demand, access with [l2_idx] */
+	struct sdxi_cxt_l1_table *l1_table_array[L2_TABLE_ENTRIES];
+	/* all contexts, on-demand, access with [l2_idx][l1_idx] */
+	struct sdxi_cxt **cxt_array[L2_TABLE_ENTRIES];
+
+	struct dma_pool *write_index_pool;
+	struct dma_pool *cxt_sts_pool;
+	struct dma_pool *cxt_ctl_pool;
+
+	/* error log */
+	int error_irq;
+	struct sdxi_errlog_hd_ent *err_log;
+	dma_addr_t err_log_dma;
+
+	/* DMA engine */
+	struct dma_device dma_dev;
+	struct sdxi_dma_chan *sdxi_dma_chan;
+	struct sdxi_tasklet_data tdata;
+
+	/* special contexts */
+	struct sdxi_cxt *admin_cxt;	/* admin context */
+	struct sdxi_cxt *dma_cxt;	/* DMA engine context */
+
+	const struct sdxi_dev_ops *dev_ops;
+};
+
+static inline struct device *sdxi_to_dev(const struct sdxi_dev *sdxi)
+{
+	return sdxi->dev;
+}
+
+#define sdxi_dbg(s, fmt, ...) dev_dbg(sdxi_to_dev(s), fmt, ## __VA_ARGS__)
+#define sdxi_info(s, fmt, ...) dev_info(sdxi_to_dev(s), fmt, ## __VA_ARGS__)
+#define sdxi_err(s, fmt, ...) dev_err(sdxi_to_dev(s), fmt, ## __VA_ARGS__)
+
+/* Device Control */
+int sdxi_device_init(struct sdxi_dev *sdxi, const struct sdxi_dev_ops *ops);
+void sdxi_device_exit(struct sdxi_dev *sdxi);
+
+static inline u64 sdxi_read64(const struct sdxi_dev *sdxi, enum sdxi_reg reg)
+{
+	return ioread64(sdxi->ctrl_regs + reg);
+}
+
+static inline void sdxi_write64(struct sdxi_dev *sdxi, enum sdxi_reg reg, u64 val)
+{
+	iowrite64(val, sdxi->ctrl_regs + reg);
+}
+
+#endif /* __SDXI_H */

-- 
2.39.5



