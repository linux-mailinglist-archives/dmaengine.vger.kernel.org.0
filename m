Return-Path: <dmaengine+bounces-10308-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cB1LHUIrAmp0ogEAu9opvQ
	(envelope-from <dmaengine+bounces-10308-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:17:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFEC514F29
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1EF23035B5A
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 19:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA58B4D2EEF;
	Mon, 11 May 2026 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKFPTPxg"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8FB4D2EDA;
	Mon, 11 May 2026 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778526997; cv=none; b=s3SqVW08M5Ri1ldMpW87YTd89PP7gK8VnyDz2IE/jwu7lBvFJwQpr7BZ4oiyqGG2kmQueQki4CjP5gaHOtaLQkiQrwgWFFgraUk0ytxVdfjEB81SA74DoRiYVkyLTb5klz3h2qGKtVYeagm0rFByCQDuLgCiOnE7G927AUgvEAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778526997; c=relaxed/simple;
	bh=5EaLhiQRKh/1xKPTdAD7haoRyFZSqSn67IDxbvmhQlw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xospw2Zo5pvVU/mSpZj958BntIwDDL/KQutIge0f9A0Nw7fN+K55HeayDuVvvHbQA51I9BWM7n2nHpuvDaUaS2R940AfZdVuuqO0bNKj2F/HO8eZO/Hqpmc9GomhR9zsdJcX7jIQaf+h20wci+vW1WbR/5sXh4uJPRN8Q+1U7kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKFPTPxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A201C2BCC9;
	Mon, 11 May 2026 19:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778526997;
	bh=5EaLhiQRKh/1xKPTdAD7haoRyFZSqSn67IDxbvmhQlw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uKFPTPxgrVW39F7RpDY9L14WtvqQAl2pPRu9HgaOnqr5TlhelL5pbvQdLfqzCAjng
	 kCeUnSnAyNI1JeD5M4KD081jsQC8omDB+zx21NIImd6roMrJvDqx+ULdulHSH9pe6w
	 YFwxzO60aE4+miwdnX0L38CsJQjm6t29hlWeQhhIopNLw5to+a6FDzsZr7Cl2LLk2i
	 d6qcSbZGMOoIgbLriqxX6iTismnObLJYr8Qv4yyMXUy36AbD/OdJsGD3sHXaLYqUIu
	 VB5eQDQ+upXbuefgp+NiZCd2YOzggcg+79Fp5f4T9wNP1vlwzlBxbIyoUjn7QqcrCx
	 Mb7m+lly1uGTQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932BBCD484E;
	Mon, 11 May 2026 19:16:37 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Mon, 11 May 2026 14:16:19 -0500
Subject: [PATCH v2 07/23] dmaengine: sdxi: Allocate administrative context
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-sdxi-base-v2-7-889cfed17e3f@amd.com>
References: <20260511-sdxi-base-v2-0-889cfed17e3f@amd.com>
In-Reply-To: <20260511-sdxi-base-v2-0-889cfed17e3f@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 David Rientjes <rientjes@google.com>, John.Kariuki@amd.com, 
 Kinsey Ho <kinseyho@google.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 PradeepVineshReddy.Kodamati@amd.com, Shivank Garg <shivankg@amd.com>, 
 Stephen Bates <Stephen.Bates@amd.com>, Wei Huang <wei.huang2@amd.com>, 
 Wei Xu <weixugc@google.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778526994; l=9093;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=AHot4P44ao/e+m4slR2c9J5CGwKq2ZHizE+HLvmY5Fw=;
 b=pG6JdbjJuP8TXEh1x/qdhhzToJAYsUN+kjiaEdvoMG4qBRQLRh2b9ZRQsqcreEOhOi9hEscbJ
 Om6ml/C7G8LCjrmGfIfdzoCASO5Q6aynytWz2kG20ypv3gYnjULoLyy
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
X-Rspamd-Queue-Id: EAFEC514F29
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10308-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	HAS_REPLYTO(0.00)[nathan.lynch@amd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:mid,amd.com:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Action: no action

From: Nathan Lynch <nathan.lynch@amd.com>

Create the control structure hierarchy in memory for the per-function
administrative context. Use devres to queue the corresponding cleanup
since the admin context is a device-scope resource. The context is
inert for now; changes to follow will make it functional.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
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
index 000000000000..27821cfaf031
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
+		dma_free_coherent(sdxi->dev, sizeof(*cxt->akey_table),
+				  cxt->akey_table, cxt->akey_table_dma);
+	if (sq && sq->write_index)
+		dma_pool_free(sdxi->write_index_pool, sq->write_index,
+			      sq->write_index_dma);
+	if (sq && sq->cxt_sts)
+		dma_pool_free(sdxi->cxt_sts_pool, sq->cxt_sts, sq->cxt_sts_dma);
+	if (sq && sq->desc_ring)
+		dma_free_coherent(sdxi->dev, sq->ring_size,
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
+	struct device *dev = sdxi->dev;
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
+	return devm_add_action_or_reset(sdxi->dev, free_admin_cxt, sdxi);
+}
diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
new file mode 100644
index 000000000000..a29387900df7
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
+	u16 id;
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
index 851e73597c22..9d8729b62685 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/time.h>
 
+#include "context.h"
 #include "hw.h"
 #include "mmio.h"
 #include "sdxi.h"
@@ -211,6 +212,16 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
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
index fbc95ef69d5c..f723bead4d93 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -49,6 +49,8 @@ struct sdxi_dev {
 	struct dma_pool *cxt_ctl_pool;
 	struct dma_pool *cst_blk_pool;
 
+	struct sdxi_cxt *admin_cxt;
+
 	const struct sdxi_bus_ops *bus_ops;
 };
 

-- 
2.54.0



