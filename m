Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB649348AF
	for <lists+dmaengine@lfdr.de>; Tue,  4 Jun 2019 15:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfFDN3f (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Jun 2019 09:29:35 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:53158 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727506AbfFDN3c (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Jun 2019 09:29:32 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7E86AC1F3A;
        Tue,  4 Jun 2019 13:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1559654982; bh=33EtJWH2eT9X+kV9zy6InVkwPzd/OidXTruzdjLCoYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=MNSbHjsUcxhEOILUQBnw8wcIYiw6Xsf9USem375AXMlXf34OsJjkaaAO6vbMeAkRC
         oO0NzQMMGqNwDIvv3A5m9V5NRt6rKm/lrK2Ed7A25tlIfPoqsa7L3f+HiIs3dX39jy
         FBrMa5tDTCUf6H3rk1elL3nhAdyr4GSYaEk/eVii3Scrdr035+QmTKqBOz8NQIQw68
         wcIu2ScBoTaAige0cEx7o0wnJLEqxgib50Zt7DabGhO5AFmoRgz90uKdVfbGyo2GDn
         /vy2t39WeJF8HxAFqyw3SSkEmCwfmBJQRCTiXdCnRjPeGgU/bh7DJq2j0WU7ZxZDzh
         672bs0jfFlrMw==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 49EB6A0230;
        Tue,  4 Jun 2019 13:29:29 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 235B13FAD1;
        Tue,  4 Jun 2019 15:29:29 +0200 (CEST)
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH v2 3/6] dmaengine: Add Synopsys eDMA IP version 0 debugfs support
Date:   Tue,  4 Jun 2019 15:29:24 +0200
Message-Id: <a4f741a9d4ab4b2600b84a9638d2bed38b4b3b31.1559654565.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1559654565.git.gustavo.pimentel@synopsys.com>
References: <cover.1559654565.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1559654565.git.gustavo.pimentel@synopsys.com>
References: <cover.1559654565.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add Synopsys eDMA IP version 0 debugfs support to assist any debug
in the future.

Creates a file system structure composed by folders and files that mimic
the IP register map (this files are read only) to ease any debug.

To enable this feature is necessary to select DEBUG_FS option on kernel
configuration.

Small output example:

(eDMA IP version 0, unroll, 1 write + 1 read channels)

% mount -t debugfs none /sys/kernel/debug/
% tree /sys/kernel/debug/dw-edma-core:0/
dw-edma/
├── version
├── mode
├── wr_ch_cnt
├── rd_ch_cnt
└── registers
    ├── ctrl_data_arb_prior
    ├── ctrl
    ├── write
    │   ├── engine_en
    │   ├── doorbell
    │   ├── ch_arb_weight_low
    │   ├── ch_arb_weight_high
    │   ├── int_status
    │   ├── int_mask
    │   ├── int_clear
    │   ├── err_status
    │   ├── done_imwr_low
    │   ├── done_imwr_high
    │   ├── abort_imwr_low
    │   ├── abort_imwr_high
    │   ├── ch01_imwr_data
    │   ├── ch23_imwr_data
    │   ├── ch45_imwr_data
    │   ├── ch67_imwr_data
    │   ├── linked_list_err_en
    │   ├── engine_chgroup
    │   ├── engine_hshake_cnt_low
    │   ├── engine_hshake_cnt_high
    │   ├── ch0_pwr_en
    │   ├── ch1_pwr_en
    │   ├── ch2_pwr_en
    │   ├── ch3_pwr_en
    │   ├── ch4_pwr_en
    │   ├── ch5_pwr_en
    │   ├── ch6_pwr_en
    │   ├── ch7_pwr_en
    │   └── channel:0
    │       ├── ch_control1
    │       ├── ch_control2
    │       ├── transfer_size
    │       ├── sar_low
    │       ├── sar_high
    │       ├── dar_high
    │       ├── llp_low
    │       └── llp_high
    └── read
        ├── engine_en
        ├── doorbell
        ├── ch_arb_weight_low
        ├── ch_arb_weight_high
        ├── int_status
        ├── int_mask
        ├── int_clear
        ├── err_status_low
        ├── err_status_high
        ├── done_imwr_low
        ├── done_imwr_high
        ├── abort_imwr_low
        ├── abort_imwr_high
        ├── ch01_imwr_data
        ├── ch23_imwr_data
        ├── ch45_imwr_data
        ├── ch67_imwr_data
        ├── linked_list_err_en
        ├── engine_chgroup
        ├── engine_hshake_cnt_low
        ├── engine_hshake_cnt_high
        ├── ch0_pwr_en
        ├── ch1_pwr_en
        ├── ch2_pwr_en
        ├── ch3_pwr_en
        ├── ch4_pwr_en
        ├── ch5_pwr_en
        ├── ch6_pwr_en
        ├── ch7_pwr_en
        └── channel:0
            ├── ch_control1
            ├── ch_control2
            ├── transfer_size
            ├── sar_low
            ├── sar_high
            ├── dar_high
            ├── llp_low
            └── llp_high

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Joao Pinto <jpinto@synopsys.com>
---
Changes:
v1 -> v2:
 - Rebased to v5.2-rc1
 
 drivers/dma/dw-edma/Makefile             |   3 +-
 drivers/dma/dw-edma/dw-edma-v0-core.c    |   2 +
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 310 +++++++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-v0-debugfs.h |  27 +++
 4 files changed, 341 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/dw-edma/dw-edma-v0-debugfs.c
 create mode 100644 drivers/dma/dw-edma/dw-edma-v0-debugfs.h

diff --git a/drivers/dma/dw-edma/Makefile b/drivers/dma/dw-edma/Makefile
index 01c7c63..0c53033 100644
--- a/drivers/dma/dw-edma/Makefile
+++ b/drivers/dma/dw-edma/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_DW_EDMA)		+= dw-edma.o
+dw-edma-$(CONFIG_DEBUG_FS)	:= dw-edma-v0-debugfs.o
 dw-edma-objs			:= dw-edma-core.o \
-					dw-edma-v0-core.o
+					dw-edma-v0-core.o $(dw-edma-y)
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index a38c473..8a3180e 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -345,8 +345,10 @@ int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
 /* eDMA debugfs callbacks */
 void dw_edma_v0_core_debugfs_on(struct dw_edma_chip *chip)
 {
+	dw_edma_v0_debugfs_on(chip);
 }
 
 void dw_edma_v0_core_debugfs_off(void)
 {
+	dw_edma_v0_debugfs_off();
 }
diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
new file mode 100644
index 0000000..3226f52
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018-2019 Synopsys, Inc. and/or its affiliates.
+ * Synopsys DesignWare eDMA v0 core
+ *
+ * Author: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+ */
+
+#include <linux/debugfs.h>
+#include <linux/bitfield.h>
+
+#include "dw-edma-v0-debugfs.h"
+#include "dw-edma-v0-regs.h"
+#include "dw-edma-core.h"
+
+#define REGS_ADDR(name) \
+	((dma_addr_t *)&regs->name)
+#define REGISTER(name) \
+	{ #name, REGS_ADDR(name) }
+
+#define WR_REGISTER(name) \
+	{ #name, REGS_ADDR(wr_##name) }
+#define RD_REGISTER(name) \
+	{ #name, REGS_ADDR(rd_##name) }
+
+#define WR_REGISTER_LEGACY(name) \
+	{ #name, REGS_ADDR(type.legacy.wr_##name) }
+#define RD_REGISTER_LEGACY(name) \
+	{ #name, REGS_ADDR(type.legacy.rd_##name) }
+
+#define WR_REGISTER_UNROLL(name) \
+	{ #name, REGS_ADDR(type.unroll.wr_##name) }
+#define RD_REGISTER_UNROLL(name) \
+	{ #name, REGS_ADDR(type.unroll.rd_##name) }
+
+#define WRITE_STR				"write"
+#define READ_STR				"read"
+#define CHANNEL_STR				"channel"
+#define REGISTERS_STR				"registers"
+
+static struct dentry				*base_dir;
+static struct dw_edma				*dw;
+static struct dw_edma_v0_regs			*regs;
+
+static struct {
+	void					*start;
+	void					*end;
+} lim[2][EDMA_V0_MAX_NR_CH];
+
+struct debugfs_entries {
+	char					name[24];
+	dma_addr_t				*reg;
+};
+
+static int dw_edma_debugfs_u32_get(void *data, u64 *val)
+{
+	if (dw->mode == EDMA_MODE_LEGACY &&
+	    data >= (void *)&regs->type.legacy.ch) {
+		void *ptr = (void *)&regs->type.legacy.ch;
+		u32 viewport_sel = 0;
+		unsigned long flags;
+		u16 ch;
+
+		for (ch = 0; ch < dw->wr_ch_cnt; ch++)
+			if (lim[0][ch].start >= data && data < lim[0][ch].end) {
+				ptr += (data - lim[0][ch].start);
+				goto legacy_sel_wr;
+			}
+
+		for (ch = 0; ch < dw->rd_ch_cnt; ch++)
+			if (lim[1][ch].start >= data && data < lim[1][ch].end) {
+				ptr += (data - lim[1][ch].start);
+				goto legacy_sel_rd;
+			}
+
+		return 0;
+legacy_sel_rd:
+		viewport_sel = BIT(31);
+legacy_sel_wr:
+		viewport_sel |= FIELD_PREP(EDMA_V0_VIEWPORT_MASK, ch);
+
+		raw_spin_lock_irqsave(&dw->lock, flags);
+
+		writel(viewport_sel, &regs->type.legacy.viewport_sel);
+		*val = readl(ptr);
+
+		raw_spin_unlock_irqrestore(&dw->lock, flags);
+	} else {
+		*val = readl(data);
+	}
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(fops_x32, dw_edma_debugfs_u32_get, NULL, "0x%08llx\n");
+
+static void dw_edma_debugfs_create_x32(const struct debugfs_entries entries[],
+				       int nr_entries, struct dentry *dir)
+{
+	int i;
+
+	for (i = 0; i < nr_entries; i++) {
+		if (!debugfs_create_file_unsafe(entries[i].name, 0444, dir,
+						entries[i].reg,	&fops_x32))
+			break;
+	}
+}
+
+static void dw_edma_debugfs_regs_ch(struct dw_edma_v0_ch_regs *regs,
+				    struct dentry *dir)
+{
+	int nr_entries;
+	const struct debugfs_entries debugfs_regs[] = {
+		REGISTER(ch_control1),
+		REGISTER(ch_control2),
+		REGISTER(transfer_size),
+		REGISTER(sar_low),
+		REGISTER(sar_high),
+		REGISTER(dar_low),
+		REGISTER(dar_high),
+		REGISTER(llp_low),
+		REGISTER(llp_high),
+	};
+
+	nr_entries = ARRAY_SIZE(debugfs_regs);
+	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, dir);
+}
+
+static void dw_edma_debugfs_regs_wr(struct dentry *dir)
+{
+	const struct debugfs_entries debugfs_regs[] = {
+		/* eDMA global registers */
+		WR_REGISTER(engine_en),
+		WR_REGISTER(doorbell),
+		WR_REGISTER(ch_arb_weight_low),
+		WR_REGISTER(ch_arb_weight_high),
+		/* eDMA interrupts registers */
+		WR_REGISTER(int_status),
+		WR_REGISTER(int_mask),
+		WR_REGISTER(int_clear),
+		WR_REGISTER(err_status),
+		WR_REGISTER(done_imwr_low),
+		WR_REGISTER(done_imwr_high),
+		WR_REGISTER(abort_imwr_low),
+		WR_REGISTER(abort_imwr_high),
+		WR_REGISTER(ch01_imwr_data),
+		WR_REGISTER(ch23_imwr_data),
+		WR_REGISTER(ch45_imwr_data),
+		WR_REGISTER(ch67_imwr_data),
+		WR_REGISTER(linked_list_err_en),
+	};
+	const struct debugfs_entries debugfs_unroll_regs[] = {
+		/* eDMA channel context grouping */
+		WR_REGISTER_UNROLL(engine_chgroup),
+		WR_REGISTER_UNROLL(engine_hshake_cnt_low),
+		WR_REGISTER_UNROLL(engine_hshake_cnt_high),
+		WR_REGISTER_UNROLL(ch0_pwr_en),
+		WR_REGISTER_UNROLL(ch1_pwr_en),
+		WR_REGISTER_UNROLL(ch2_pwr_en),
+		WR_REGISTER_UNROLL(ch3_pwr_en),
+		WR_REGISTER_UNROLL(ch4_pwr_en),
+		WR_REGISTER_UNROLL(ch5_pwr_en),
+		WR_REGISTER_UNROLL(ch6_pwr_en),
+		WR_REGISTER_UNROLL(ch7_pwr_en),
+	};
+	struct dentry *regs_dir, *ch_dir;
+	int nr_entries, i;
+	char name[16];
+
+	regs_dir = debugfs_create_dir(WRITE_STR, dir);
+	if (!regs_dir)
+		return;
+
+	nr_entries = ARRAY_SIZE(debugfs_regs);
+	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
+
+	if (dw->mode == EDMA_MODE_UNROLL) {
+		nr_entries = ARRAY_SIZE(debugfs_unroll_regs);
+		dw_edma_debugfs_create_x32(debugfs_unroll_regs, nr_entries,
+					   regs_dir);
+	}
+
+	for (i = 0; i < dw->wr_ch_cnt; i++) {
+		snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
+
+		ch_dir = debugfs_create_dir(name, regs_dir);
+		if (!ch_dir)
+			return;
+
+		dw_edma_debugfs_regs_ch(&regs->type.unroll.ch[i].wr, ch_dir);
+
+		lim[0][i].start = &regs->type.unroll.ch[i].wr;
+		lim[0][i].end = &regs->type.unroll.ch[i].padding_1[0];
+	}
+}
+
+static void dw_edma_debugfs_regs_rd(struct dentry *dir)
+{
+	const struct debugfs_entries debugfs_regs[] = {
+		/* eDMA global registers */
+		RD_REGISTER(engine_en),
+		RD_REGISTER(doorbell),
+		RD_REGISTER(ch_arb_weight_low),
+		RD_REGISTER(ch_arb_weight_high),
+		/* eDMA interrupts registers */
+		RD_REGISTER(int_status),
+		RD_REGISTER(int_mask),
+		RD_REGISTER(int_clear),
+		RD_REGISTER(err_status_low),
+		RD_REGISTER(err_status_high),
+		RD_REGISTER(linked_list_err_en),
+		RD_REGISTER(done_imwr_low),
+		RD_REGISTER(done_imwr_high),
+		RD_REGISTER(abort_imwr_low),
+		RD_REGISTER(abort_imwr_high),
+		RD_REGISTER(ch01_imwr_data),
+		RD_REGISTER(ch23_imwr_data),
+		RD_REGISTER(ch45_imwr_data),
+		RD_REGISTER(ch67_imwr_data),
+	};
+	const struct debugfs_entries debugfs_unroll_regs[] = {
+		/* eDMA channel context grouping */
+		RD_REGISTER_UNROLL(engine_chgroup),
+		RD_REGISTER_UNROLL(engine_hshake_cnt_low),
+		RD_REGISTER_UNROLL(engine_hshake_cnt_high),
+		RD_REGISTER_UNROLL(ch0_pwr_en),
+		RD_REGISTER_UNROLL(ch1_pwr_en),
+		RD_REGISTER_UNROLL(ch2_pwr_en),
+		RD_REGISTER_UNROLL(ch3_pwr_en),
+		RD_REGISTER_UNROLL(ch4_pwr_en),
+		RD_REGISTER_UNROLL(ch5_pwr_en),
+		RD_REGISTER_UNROLL(ch6_pwr_en),
+		RD_REGISTER_UNROLL(ch7_pwr_en),
+	};
+	struct dentry *regs_dir, *ch_dir;
+	int nr_entries, i;
+	char name[16];
+
+	regs_dir = debugfs_create_dir(READ_STR, dir);
+	if (!regs_dir)
+		return;
+
+	nr_entries = ARRAY_SIZE(debugfs_regs);
+	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
+
+	if (dw->mode == EDMA_MODE_UNROLL) {
+		nr_entries = ARRAY_SIZE(debugfs_unroll_regs);
+		dw_edma_debugfs_create_x32(debugfs_unroll_regs, nr_entries,
+					   regs_dir);
+	}
+
+	for (i = 0; i < dw->rd_ch_cnt; i++) {
+		snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
+
+		ch_dir = debugfs_create_dir(name, regs_dir);
+		if (!ch_dir)
+			return;
+
+		dw_edma_debugfs_regs_ch(&regs->type.unroll.ch[i].rd, ch_dir);
+
+		lim[1][i].start = &regs->type.unroll.ch[i].rd;
+		lim[1][i].end = &regs->type.unroll.ch[i].padding_2[0];
+	}
+}
+
+static void dw_edma_debugfs_regs(void)
+{
+	const struct debugfs_entries debugfs_regs[] = {
+		REGISTER(ctrl_data_arb_prior),
+		REGISTER(ctrl),
+	};
+	struct dentry *regs_dir;
+	int nr_entries;
+
+	regs_dir = debugfs_create_dir(REGISTERS_STR, base_dir);
+	if (!regs_dir)
+		return;
+
+	nr_entries = ARRAY_SIZE(debugfs_regs);
+	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
+
+	dw_edma_debugfs_regs_wr(regs_dir);
+	dw_edma_debugfs_regs_rd(regs_dir);
+}
+
+void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
+{
+	dw = chip->dw;
+	if (!dw)
+		return;
+
+	regs = (struct dw_edma_v0_regs *)dw->rg_region.vaddr;
+	if (!regs)
+		return;
+
+	base_dir = debugfs_create_dir(dw->name, 0);
+	if (!base_dir)
+		return;
+
+	debugfs_create_u32("version", 0444, base_dir, &dw->version);
+	debugfs_create_u32("mode", 0444, base_dir, &dw->mode);
+	debugfs_create_u16("wr_ch_cnt", 0444, base_dir, &dw->wr_ch_cnt);
+	debugfs_create_u16("rd_ch_cnt", 0444, base_dir, &dw->rd_ch_cnt);
+
+	dw_edma_debugfs_regs();
+}
+
+void dw_edma_v0_debugfs_off(void)
+{
+	debugfs_remove_recursive(base_dir);
+}
diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.h b/drivers/dma/dw-edma/dw-edma-v0-debugfs.h
new file mode 100644
index 0000000..5450a0a
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018-2019 Synopsys, Inc. and/or its affiliates.
+ * Synopsys DesignWare eDMA v0 core
+ *
+ * Author: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+ */
+
+#ifndef _DW_EDMA_V0_DEBUG_FS_H
+#define _DW_EDMA_V0_DEBUG_FS_H
+
+#include <linux/dma/edma.h>
+
+#ifdef CONFIG_DEBUG_FS
+void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip);
+void dw_edma_v0_debugfs_off(void);
+#else
+static inline void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
+{
+}
+
+static inline void dw_edma_v0_debugfs_off(void)
+{
+}
+#endif /* CONFIG_DEBUG_FS */
+
+#endif /* _DW_EDMA_V0_DEBUG_FS_H */
-- 
2.7.4

