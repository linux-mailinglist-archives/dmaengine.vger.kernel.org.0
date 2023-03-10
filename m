Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722B16B34C7
	for <lists+dmaengine@lfdr.de>; Fri, 10 Mar 2023 04:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjCJDYn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Mar 2023 22:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjCJDYj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Mar 2023 22:24:39 -0500
Received: from out-24.mta0.migadu.com (out-24.mta0.migadu.com [91.218.175.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E7DFAEC5
        for <dmaengine@vger.kernel.org>; Thu,  9 Mar 2023 19:24:17 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678418655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QcGrBfkq4PTJslZTlgxFAbIpLZXH7rHMxnhZImwrJO4=;
        b=kLONQw4XuQN5BXjzlv1iJZPIVDTTfgKtdTRfUVi1IWanIvJmJE+EeKrDKN4ql+EM/xr9iF
        nFL8sUvCDsh/Odx626Dh6PE1u5TPuwstuo6OUWdnlmGw5ue7ifSm9yUcj1s/uCSY532BxM
        DawlZkjlWQyj1s6/KTqOzeHm1tmX6G8=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     fancer.lancer@gmail.com
Cc:     Cai huoqing <cai.huoqing@linux.dev>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v6 4/5] dmaengine: dw-edma: Add HDMA DebugFS support
Date:   Fri, 10 Mar 2023 11:23:37 +0800
Message-Id: <20230310032342.17395-5-cai.huoqing@linux.dev>
In-Reply-To: <20230310032342.17395-1-cai.huoqing@linux.dev>
References: <20230310032342.17395-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Cai huoqing <cai.huoqing@linux.dev>

Add HDMA DebugFS support to show register information

Signed-off-by: Cai huoqing <cai.huoqing@linux.dev>
---
v5->v6:
  9.Fix 'reg' pointing error in dw_hdma_debugfs_u32_get.
  10.Add padding_1/_2 reserve to fix wrong reg offset.

v5 link:
	https://lore.kernel.org/lkml/20230303124642.5519-5-cai.huoqing@linux.dev/

 drivers/dma/dw-edma/Makefile             |   3 +-
 drivers/dma/dw-edma/dw-hdma-v0-core.c    |   2 +
 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c | 176 +++++++++++++++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-debugfs.h |  22 +++
 drivers/dma/dw-edma/dw-hdma-v0-regs.h    |   3 +-
 5 files changed, 204 insertions(+), 2 deletions(-)
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.h

diff --git a/drivers/dma/dw-edma/Makefile b/drivers/dma/dw-edma/Makefile
index b1c91ef2c63d..83ab58f87760 100644
--- a/drivers/dma/dw-edma/Makefile
+++ b/drivers/dma/dw-edma/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_DW_EDMA)		+= dw-edma.o
-dw-edma-$(CONFIG_DEBUG_FS)	:= dw-edma-v0-debugfs.o
+dw-edma-$(CONFIG_DEBUG_FS)	:= dw-edma-v0-debugfs.o	\
+				   dw-hdma-v0-debugfs.o
 dw-edma-objs			:= dw-edma-core.o	\
 				   dw-edma-v0-core.o	\
 				   dw-hdma-v0-core.o $(dw-edma-y)
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 5446e9f38d65..84a691a2d110 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -11,6 +11,7 @@
 #include "dw-edma-core.h"
 #include "dw-hdma-v0-core.h"
 #include "dw-hdma-v0-regs.h"
+#include "dw-hdma-v0-debugfs.h"
 
 enum dw_hdma_control {
 	DW_HDMA_V0_CB					= BIT(0),
@@ -257,6 +258,7 @@ static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
 /* HDMA debugfs callbacks */
 static void dw_hdma_v0_core_debugfs_on(struct dw_edma *dw)
 {
+	dw_hdma_v0_debugfs_on(dw);
 }
 
 static const struct dw_edma_core_ops dw_hdma_v0_core = {
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
new file mode 100644
index 000000000000..f2082b1bf72a
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Cai Huoqing
+ * Synopsys DesignWare HDMA v0 debugfs
+ *
+ * Author: Cai Huoqing <cai.huoqing@linux.dev>
+ */
+
+#include <linux/debugfs.h>
+#include <linux/bitfield.h>
+
+#include "dw-hdma-v0-debugfs.h"
+#include "dw-hdma-v0-regs.h"
+#include "dw-edma-core.h"
+
+#define REGS_ADDR(dw, name)						       \
+	({								       \
+		struct dw_hdma_v0_regs __iomem *__regs = (dw)->chip->reg_base; \
+									       \
+		(void __iomem *)&__regs->name;				       \
+	})
+
+#define REGS_CH_ADDR(dw, name, _dir, _ch)				       \
+	({								       \
+		struct dw_hdma_v0_ch_regs __iomem *__ch_regs;		       \
+									       \
+		if (_dir == EDMA_DIR_READ)				       \
+			__ch_regs = REGS_ADDR(dw, ch[_ch].rd);		       \
+		else							       \
+			__ch_regs = REGS_ADDR(dw, ch[_ch].wr);		       \
+									       \
+		(void __iomem *)&__ch_regs->name;			       \
+	})
+
+#define CTX_REGISTER(dw, name, dir, ch) \
+	{ dw, #name, REGS_CH_ADDR(dw, name, dir, ch), dir, ch }
+
+#define REGISTER(dw, name) \
+	{ dw, #name, REGS_ADDR(dw, name) }
+
+#define WRITE_STR				"write"
+#define READ_STR				"read"
+#define CHANNEL_STR				"channel"
+#define REGISTERS_STR				"registers"
+
+struct dw_hdma_debugfs_entry {
+	struct dw_edma				*dw;
+	const char				*name;
+	void __iomem				*reg;
+	enum dw_edma_dir			dir;
+	u16					ch;
+};
+
+static int dw_hdma_debugfs_u32_get(void *data, u64 *val)
+{
+	struct dw_hdma_debugfs_entry *entry = data;
+	void __iomem *reg = entry->reg;
+
+	*val = readl(reg);
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(fops_x32, dw_hdma_debugfs_u32_get, NULL, "0x%08llx\n");
+
+static void dw_hdma_debugfs_create_x32(struct dw_edma *dw,
+				       const struct dw_hdma_debugfs_entry ini[],
+				       int nr_entries, struct dentry *dent)
+{
+	struct dw_hdma_debugfs_entry *entries;
+	int i;
+
+	entries = devm_kcalloc(dw->chip->dev, nr_entries, sizeof(*entries),
+			       GFP_KERNEL);
+	if (!entries)
+		return;
+
+	for (i = 0; i < nr_entries; i++) {
+		entries[i] = ini[i];
+
+		debugfs_create_file_unsafe(entries[i].name, 0444, dent,
+					   &entries[i], &fops_x32);
+	}
+}
+
+static void dw_hdma_debugfs_regs_ch(struct dw_edma *dw, enum dw_edma_dir dir,
+				    u16 ch, struct dentry *dent)
+{
+	const struct dw_hdma_debugfs_entry debugfs_regs[] = {
+		CTX_REGISTER(dw, ch_en, dir, ch),
+		CTX_REGISTER(dw, doorbell, dir, ch),
+		CTX_REGISTER(dw, prefetch, dir, ch),
+		CTX_REGISTER(dw, handshake, dir, ch),
+		CTX_REGISTER(dw, llp.lsb, dir, ch),
+		CTX_REGISTER(dw, llp.msb, dir, ch),
+		CTX_REGISTER(dw, cycle_sync, dir, ch),
+		CTX_REGISTER(dw, transfer_size, dir, ch),
+		CTX_REGISTER(dw, sar.lsb, dir, ch),
+		CTX_REGISTER(dw, sar.msb, dir, ch),
+		CTX_REGISTER(dw, dar.lsb, dir, ch),
+		CTX_REGISTER(dw, dar.msb, dir, ch),
+		CTX_REGISTER(dw, watermark_en, dir, ch),
+		CTX_REGISTER(dw, control1, dir, ch),
+		CTX_REGISTER(dw, func_num, dir, ch),
+		CTX_REGISTER(dw, qos, dir, ch),
+		CTX_REGISTER(dw, ch_stat, dir, ch),
+		CTX_REGISTER(dw, int_stat, dir, ch),
+		CTX_REGISTER(dw, int_setup, dir, ch),
+		CTX_REGISTER(dw, int_clear, dir, ch),
+		CTX_REGISTER(dw, msi_stop.lsb, dir, ch),
+		CTX_REGISTER(dw, msi_stop.msb, dir, ch),
+		CTX_REGISTER(dw, msi_watermark.lsb, dir, ch),
+		CTX_REGISTER(dw, msi_watermark.msb, dir, ch),
+		CTX_REGISTER(dw, msi_abort.lsb, dir, ch),
+		CTX_REGISTER(dw, msi_abort.msb, dir, ch),
+		CTX_REGISTER(dw, msi_msgdata, dir, ch),
+	};
+	int nr_entries = ARRAY_SIZE(debugfs_regs);
+
+	dw_hdma_debugfs_create_x32(dw, debugfs_regs, nr_entries, dent);
+}
+
+static void dw_hdma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
+{
+	struct dentry *regs_dent, *ch_dent;
+	char name[16];
+	int i;
+
+	regs_dent = debugfs_create_dir(WRITE_STR, dent);
+
+	for (i = 0; i < dw->wr_ch_cnt; i++) {
+		snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
+
+		ch_dent = debugfs_create_dir(name, regs_dent);
+
+		dw_hdma_debugfs_regs_ch(dw, EDMA_DIR_WRITE, i, ch_dent);
+	}
+}
+
+static void dw_hdma_debugfs_regs_rd(struct dw_edma *dw, struct dentry *dent)
+{
+	struct dentry *regs_dent, *ch_dent;
+	char name[16];
+	int i;
+
+	regs_dent = debugfs_create_dir(READ_STR, dent);
+
+	for (i = 0; i < dw->rd_ch_cnt; i++) {
+		snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
+
+		ch_dent = debugfs_create_dir(name, regs_dent);
+
+		dw_hdma_debugfs_regs_ch(dw, EDMA_DIR_READ, i, ch_dent);
+	}
+}
+
+static void dw_hdma_debugfs_regs(struct dw_edma *dw)
+{
+	struct dentry *regs_dent;
+
+	regs_dent = debugfs_create_dir(REGISTERS_STR, dw->dma.dbg_dev_root);
+
+	dw_hdma_debugfs_regs_wr(dw, regs_dent);
+	dw_hdma_debugfs_regs_rd(dw, regs_dent);
+}
+
+void dw_hdma_v0_debugfs_on(struct dw_edma *dw)
+{
+	if (!debugfs_initialized())
+		return;
+
+	debugfs_create_u32("mf", 0444, dw->dma.dbg_dev_root, &dw->chip->mf);
+	debugfs_create_u16("wr_ch_cnt", 0444, dw->dma.dbg_dev_root, &dw->wr_ch_cnt);
+	debugfs_create_u16("rd_ch_cnt", 0444, dw->dma.dbg_dev_root, &dw->rd_ch_cnt);
+
+	dw_hdma_debugfs_regs(dw);
+}
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.h b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
new file mode 100644
index 000000000000..e6842c83777d
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 Cai Huoqing
+ * Synopsys DesignWare HDMA v0 debugfs
+ *
+ * Author: Cai Huoqing <cai.huoqing@linux.dev>
+ */
+
+#ifndef _DW_HDMA_V0_DEBUG_FS_H
+#define _DW_HDMA_V0_DEBUG_FS_H
+
+#include <linux/dma/edma.h>
+
+#ifdef CONFIG_DEBUG_FS
+void dw_hdma_v0_debugfs_on(struct dw_edma *dw);
+#else
+static inline void dw_hdma_v0_debugfs_on(struct dw_edma *dw)
+{
+}
+#endif /* CONFIG_DEBUG_FS */
+
+#endif /* _DW_HDMA_V0_DEBUG_FS_H */
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
index 1106f56280c0..0a6032aa1a33 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
+++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
@@ -57,7 +57,7 @@ struct dw_hdma_v0_ch_regs {
 	u32 control1;				/* 0x0034 */
 	u32 func_num;				/* 0x0038 */
 	u32 qos;				/* 0x003c */
-	u64 reserved[8];			/* 0x0040..0x0078 */
+	u32 padding_1[16];			/* 0x0040..0x0078 */
 	u32 ch_stat;				/* 0x0080 */
 	u32 int_stat;				/* 0x0084 */
 	u32 int_setup;				/* 0x0088 */
@@ -84,6 +84,7 @@ struct dw_hdma_v0_ch_regs {
 		};
 	} msi_abort;
 	u32 msi_msgdata;			/* 0x00a8 */
+	u32 padding_2[21];			/* 0x00ac..0x00e8 */
 } __packed;
 
 struct dw_hdma_v0_ch {
-- 
2.34.1

