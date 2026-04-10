Return-Path: <dmaengine+bounces-9960-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEynG7H22GkYkQgAu9opvQ
	(envelope-from <dmaengine+bounces-9960-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 15:10:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 024863D7F09
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 15:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4AEB303C4FA
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 13:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5FC38E5C5;
	Fri, 10 Apr 2026 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6OmW/hh"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1032B33F8BC;
	Fri, 10 Apr 2026 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775826470; cv=none; b=endB/kqrKlg+xpDov8gS4J6qEUB3e5L96eKG9CEZAWYpRWZgFsY12cbzcdrX6jY2FE1AF1/lQLlv671pRqjgcHqiy7x3GB+Q7CWcur69ip8IREhU0dhx1bN3qwcUXYe3lYWMYVIqn/wxz7B7O4c5xwsOtBn8+ztw2RPPlDFKRzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775826470; c=relaxed/simple;
	bh=pwA5DOOTsIC9IRWZ9Yn//rvbx+AoipLaEGhOLFIPVqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QAMXSAHok7ebQCxT6gxu354QqLi1p/dGSl6ID8TFv7dQXz+6Wb5UXuku2d23vesCwneL9P84VozjD746dRFQ/h7UXTueCPvib9aGEMOiVYdOeKAAKWTBLXLl8YntBPQpOxlnl62lZFbXR1NbImfdY6rxTXxni/iHvTYo6ovcZzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6OmW/hh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5745C2BCB4;
	Fri, 10 Apr 2026 13:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775826469;
	bh=pwA5DOOTsIC9IRWZ9Yn//rvbx+AoipLaEGhOLFIPVqs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=c6OmW/hh6A0QABgR9FyMXT0tevtLwvFFx1wXGQqmlfcizijnCshSGvzf5WVo2dQAm
	 tgh/0tv1IWR1k4ekcCpgw2l6w4Ao2tXkfDpy6gb74fWy7gA6dckblQ7rEmecFORkZE
	 bLfAGMHIzu4k07op+jFFID3YOkkZuhlLD1v5eZ0Xkheas2TVrkdymdkxa0ZuDpu7WO
	 b4w+/fIvHCRiM2GkOUSEaNTsdaZpd8ScpnoVKNY2vRbsFL08YnkxkOdmBPq4kLc65g
	 IDVQUcGqlpkYYN9oRizUV60LFmv8aqztXClA+vmTS9blC/Nlyf/rcoasIr4/SfFxNq
	 WEh0C6VpXas1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEDDF44855;
	Fri, 10 Apr 2026 13:07:49 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 10 Apr 2026 08:07:17 -0500
Subject: [PATCH 07/23] dmaengine: sdxi: Allocate administrative context
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-sdxi-base-v1-7-1d184cb5c60a@amd.com>
References: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
In-Reply-To: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Wei Huang <wei.huang2@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Stephen Bates <Stephen.Bates@amd.com>, PradeepVineshReddy.Kodamati@amd.com, 
 John.Kariuki@amd.com, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775826467; l=9093;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=5IR26H76UDlcFM7Wa9aSD6wT/Up6jQCxqaCJ4XRcXKE=;
 b=bCtQW+/DPZvbj0rP7gSVEu2yumHr14XsLG/TOWlXxjrAXvvrUz877kx+cK6+e85OHh8rOpsq7
 rG/snavaeMCD2V6oU4zNZI5XJkFEqkS1aAa7UC55GPOYvOHWOFCZSHf
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9960-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[nathan.lynch@amd.com]
X-Rspamd-Queue-Id: 024863D7F09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Nathan Lynch <nathan.lynch@amd.com>

Create the control structure hierarchy in memory for the per-function
administrative context. Use devres to queue the corresponding cleanup
since the admin context is a device-scope resource. The context is
inert for now; changes to follow will make it functional.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/Makefile  |   4 +-
 drivers/dma/sdxi/context.c | 128 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/context.h |  54 +++++++++++++++++++
 drivers/dma/sdxi/device.c  |  11 ++++
 drivers/dma/sdxi/hw.h      |  43 +++++++++++++++
 drivers/dma/sdxi/sdxi.h    |   2 +
 6 files changed, 241 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
index f84b87d53e27..2178f274831c 100644
--- a/drivers/dma/sdxi/Makefile
+++ b/drivers/dma/sdxi/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_SDXI) += sdxi.o
 
-sdxi-objs += device.o
+sdxi-objs += \
+	context.o     \
+	device.o
 
 sdxi-$(CONFIG_PCI_MSI) += pci.o
diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
new file mode 100644
index 000000000000..0a6821992776
--- /dev/null
+++ b/drivers/dma/sdxi/context.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI context management
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#define pr_fmt(fmt)     "SDXI: " fmt
+
+#include <linux/bug.h>
+#include <linux/cleanup.h>
+#include <linux/device/devres.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmapool.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include "context.h"
+#include "sdxi.h"
+
+#define DEFAULT_DESC_RING_ENTRIES 1024
+
+enum {
+	/*
+	 * The admin context always has ID 0. See SDXI 1.0 3.5
+	 * Administrative Context (Context 0).
+	 */
+	SDXI_ADMIN_CXT_ID = 0,
+};
+
+/*
+ * Free context and its resources. @cxt may be partially allocated but
+ * must have ->sdxi set.
+ */
+static void sdxi_free_cxt(struct sdxi_cxt *cxt)
+{
+	struct sdxi_dev *sdxi = cxt->sdxi;
+	struct sdxi_sq *sq = cxt->sq;
+
+	if (cxt->cxt_ctl)
+		dma_pool_free(sdxi->cxt_ctl_pool, cxt->cxt_ctl,
+			      cxt->cxt_ctl_dma);
+	if (cxt->akey_table)
+		dma_free_coherent(sdxi_to_dev(sdxi), sizeof(*cxt->akey_table),
+				  cxt->akey_table, cxt->akey_table_dma);
+	if (sq && sq->write_index)
+		dma_pool_free(sdxi->write_index_pool, sq->write_index,
+			      sq->write_index_dma);
+	if (sq && sq->cxt_sts)
+		dma_pool_free(sdxi->cxt_sts_pool, sq->cxt_sts, sq->cxt_sts_dma);
+	if (sq && sq->desc_ring)
+		dma_free_coherent(sdxi_to_dev(sdxi), sq->ring_size,
+				  sq->desc_ring, sq->ring_dma);
+	kfree(cxt->sq);
+	kfree(cxt);
+}
+
+DEFINE_FREE(sdxi_cxt, struct sdxi_cxt *, if (_T) sdxi_free_cxt(_T))
+
+/* Allocate a context and its control structure hierarchy in memory. */
+static struct sdxi_cxt *sdxi_alloc_cxt(struct sdxi_dev *sdxi)
+{
+	struct device *dev = sdxi_to_dev(sdxi);
+	struct sdxi_sq *sq;
+	struct sdxi_cxt *cxt __free(sdxi_cxt) = kzalloc(sizeof(*cxt), GFP_KERNEL);
+
+	if (!cxt)
+		return NULL;
+
+	cxt->sdxi = sdxi;
+
+	cxt->sq = kzalloc_obj(*cxt->sq, GFP_KERNEL);
+	if (!cxt->sq)
+		return NULL;
+
+	cxt->akey_table = dma_alloc_coherent(dev, sizeof(*cxt->akey_table),
+					     &cxt->akey_table_dma, GFP_KERNEL);
+	if (!cxt->akey_table)
+		return NULL;
+
+	cxt->cxt_ctl = dma_pool_zalloc(sdxi->cxt_ctl_pool, GFP_KERNEL,
+				       &cxt->cxt_ctl_dma);
+	if (!cxt->cxt_ctl_dma)
+		return NULL;
+
+	sq = cxt->sq;
+
+	sq->ring_entries = DEFAULT_DESC_RING_ENTRIES;
+	sq->ring_size = sq->ring_entries * sizeof(sq->desc_ring[0]);
+	sq->desc_ring = dma_alloc_coherent(dev, sq->ring_size, &sq->ring_dma,
+					   GFP_KERNEL);
+	if (!sq->desc_ring)
+		return NULL;
+
+	sq->cxt_sts = dma_pool_zalloc(sdxi->cxt_sts_pool, GFP_KERNEL,
+				      &sq->cxt_sts_dma);
+	if (!sq->cxt_sts)
+		return NULL;
+
+	sq->write_index = dma_pool_zalloc(sdxi->write_index_pool, GFP_KERNEL,
+					  &sq->write_index_dma);
+	if (!sq->write_index)
+		return NULL;
+
+	return_ptr(cxt);
+}
+
+static void free_admin_cxt(void *ptr)
+{
+	struct sdxi_dev *sdxi = ptr;
+
+	sdxi_free_cxt(sdxi->admin_cxt);
+}
+
+int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
+{
+	struct sdxi_cxt *cxt __free(sdxi_cxt) = sdxi_alloc_cxt(sdxi);
+	if (!cxt)
+		return -ENOMEM;
+
+	cxt->id = SDXI_ADMIN_CXT_ID;
+	cxt->db = sdxi->dbs + cxt->id * sdxi->db_stride;
+
+	sdxi->admin_cxt = no_free_ptr(cxt);
+
+	return devm_add_action_or_reset(sdxi_to_dev(sdxi), free_admin_cxt, sdxi);
+}
diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
new file mode 100644
index 000000000000..800b4ead1dd9
--- /dev/null
+++ b/drivers/dma/sdxi/context.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#ifndef DMA_SDXI_CONTEXT_H
+#define DMA_SDXI_CONTEXT_H
+
+#include <linux/dma-mapping.h>
+#include <linux/types.h>
+
+#include "hw.h"
+#include "sdxi.h"
+
+/*
+ * The size of the AKey table is flexible, from 4KB to 1MB. Always use
+ * the minimum size for now.
+ */
+struct sdxi_akey_table {
+	struct sdxi_akey_ent entry[SZ_4K / sizeof(struct sdxi_akey_ent)];
+};
+
+/* Submission Queue */
+struct sdxi_sq {
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
+};
+
+struct sdxi_cxt {
+	struct sdxi_dev *sdxi;
+	unsigned int id;
+
+	__le64 __iomem *db;
+
+	struct sdxi_cxt_ctl *cxt_ctl;
+	dma_addr_t cxt_ctl_dma;
+
+	struct sdxi_akey_table *akey_table;
+	dma_addr_t akey_table_dma;
+
+	struct sdxi_sq *sq;
+};
+
+int sdxi_admin_cxt_init(struct sdxi_dev *sdxi);
+
+#endif /* DMA_SDXI_CONTEXT_H */
diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index 80bd1bbd9c7c..636abc410dcd 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -13,6 +13,7 @@
 #include <linux/log2.h>
 #include <linux/slab.h>
 
+#include "context.h"
 #include "hw.h"
 #include "mmio.h"
 #include "sdxi.h"
@@ -186,6 +187,16 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
 			       sdxi->L1_dma >> ilog2(SZ_4K));
 	L2_ent->lv01_ptr = cpu_to_le64(lv01_ptr);
 
+	/*
+	 * SDXI 1.0 4.1.8.4 Administrative Context
+	 *
+	 * The admin context will not consume descriptors until we
+	 * write its doorbell later.
+	 */
+	err = sdxi_admin_cxt_init(sdxi);
+	if (err)
+		return err;
+
 	return 0;
 }
 
diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
index 846c671c423f..b66eb22f7f90 100644
--- a/drivers/dma/sdxi/hw.h
+++ b/drivers/dma/sdxi/hw.h
@@ -23,6 +23,7 @@
 
 #include <linux/bits.h>
 #include <linux/build_bug.h>
+#include <linux/stddef.h>
 #include <linux/types.h>
 #include <asm/byteorder.h>
 
@@ -72,12 +73,39 @@ static_assert(sizeof(struct sdxi_cxt_ctl) == 64);
 /* SDXI 1.0 Table 3-5: Context Status (CXT_STS) */
 struct sdxi_cxt_sts {
 	__u8 state;
+#define SDXI_CXT_STS_STATE GENMASK(3, 0)
 	__u8 misc0;
 	__u8 rsvd_0[6];
 	__le64 read_index;
 } __packed;
 static_assert(sizeof(struct sdxi_cxt_sts) == 16);
 
+/* SDXI 1.0 Table 3-6: CXT_STS.state Encoding */
+/* Valid values for FIELD_GET(SDXI_CXT_STS_STATE, sdxi_cxt_sts.state). */
+enum cxt_sts_state {
+	CXTV_STOP_SW  = 0x0,
+	CXTV_RUN      = 0x1,
+	CXTV_STOPG_SW = 0x2,
+	CXTV_STOP_FN  = 0x4,
+	CXTV_STOPG_FN = 0x6,
+	CXTV_ERR_FN   = 0xf,
+};
+
+/* SDXI 1.0 Table 3-7: AKey Table Entry (AKEY_ENT) */
+struct sdxi_akey_ent {
+	__le16 intr_num;
+#define SDXI_AKEY_ENT_VL BIT(0)
+#define SDXI_AKEY_ENT_IV BIT(1)
+#define SDXI_AKEY_ENT_INTR_NUM GENMASK(14, 4)
+	__le16 tgt_sfunc;
+	__le32 pasid;
+	__le16 stag;
+	__u8   rsvd_0[2];
+	__le16 rkey;
+	__u8   rsvd_1[2];
+} __packed;
+static_assert(sizeof(struct sdxi_akey_ent) == 16);
+
 /* SDXI 1.0 Table 6-4: CST_BLK (Completion Status Block) */
 struct sdxi_cst_blk {
 	__le64 signal;
@@ -86,4 +114,19 @@ struct sdxi_cst_blk {
 } __packed;
 static_assert(sizeof(struct sdxi_cst_blk) == 32);
 
+struct sdxi_desc {
+	union {
+		/*
+		 * SDXI 1.0 Table 6-3: DSC_GENERIC SDXI Descriptor
+		 * Common Header and Footer Format
+		 */
+		struct_group_tagged(sdxi_dsc_generic, generic,
+			__le32 opcode;
+			__u8 operation[52];
+			__le64 csb_ptr;
+		);
+	};
+} __packed;
+static_assert(sizeof(struct sdxi_desc) == 64);
+
 #endif /* DMA_SDXI_HW_H */
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index 6cda60bb33c4..4ef893ae15f3 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -51,6 +51,8 @@ struct sdxi_dev {
 	struct dma_pool *cxt_ctl_pool;
 	struct dma_pool *cst_blk_pool;
 
+	struct sdxi_cxt *admin_cxt;
+
 	const struct sdxi_bus_ops *bus_ops;
 };
 

-- 
2.53.0



