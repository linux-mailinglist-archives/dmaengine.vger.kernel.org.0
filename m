Return-Path: <dmaengine+bounces-10306-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJhqNEwrAmp0ogEAu9opvQ
	(envelope-from <dmaengine+bounces-10306-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:17:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A069514F3E
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFF33303FDCB
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 19:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96584D2EEE;
	Mon, 11 May 2026 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWwoa0Qz"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4784D2ED6;
	Mon, 11 May 2026 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778526997; cv=none; b=KhtiEd6rwcxOnvlgsTfK0RiNlr4ZdUb9/37XRDtcxywaO2LPHqt8EiZJY7EFi59Ja6qkX2rbxKZFsbmqD3At7ZgV1yXDn2+O4IO9m0umNONRUgdkXlYHmNSKZcgnILeMVq1VyhE59g5y/DXgRrbQTHsYNZiPzSlc5qJzj8/VEMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778526997; c=relaxed/simple;
	bh=dibbtsoHVtBkvjIbTYNSYlSZiq7/NvYCg+uFR3qLLxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G/Pqgyq8IZltU7aWh3HnZFhVDYZQlnN7FH9ReGHuFgf8otwNZt9UFfdqquybnwtAHYBUeEeIfr6bAR/CzYdGm+c20rzWN7kaGRUt/SEGjQ3Gz5xaAcusMls54d/4o81mD9ioo//qokQIJqGS45MuQ/YS5llQS4X/Bj2o26i+Fac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWwoa0Qz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CA73C2BCFF;
	Mon, 11 May 2026 19:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778526997;
	bh=dibbtsoHVtBkvjIbTYNSYlSZiq7/NvYCg+uFR3qLLxA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QWwoa0QzFXzPLWW/PHcWVvdJPzqY7SXUJK+TDiUYaB2WZnc8LnPqAwR5PYklhHkmF
	 C8sbEBya5ZauOLp78v0jHkbmKqJaiaB0jBFeyU+MzF1hT60oAbGIGWcMloD7fX+tOD
	 B3m7nQ+sWxpyScL/fBhU623UhB+1TpiOnVhcjVlUeoPENrRcH1sYamoBXbpgtO6WfT
	 Tw/f02vR2T3+5YrqEecyBeWar/Qc+VbNQayES2wLxXkrs3O6cXf6cqYzvSeL2bRC48
	 tqY9aWVGvXORfCgczDwnTHmfwd5XbR3LZtQb4aV8an/BLTap0YQDfpdQ2b6aF0c19H
	 xcXnkM0lQsKZQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DC9CD4840;
	Mon, 11 May 2026 19:16:37 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Mon, 11 May 2026 14:16:17 -0500
Subject: [PATCH v2 05/23] dmaengine: sdxi: Configure context tables
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-sdxi-base-v2-5-889cfed17e3f@amd.com>
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
 Jonathan Cameron <jic23@kernel.org>, Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778526994; l=6882;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=SJzCBbJFQwsyPu9ZY+bi1GfbFcp2Ugeir8s9gli+zx8=;
 b=PC/X78ReHlbxSzzDkjYMmCaUWPeUsaVWTpwro9y1f0Lauwi5uHvMJc9tiB5OsfRpcCs7WbWKW
 kYjdXpgN3LxANhYHG7rC5J+8+2I1f5T/KgiB1IAs2qULISOcwgjrzh+
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
X-Rspamd-Queue-Id: 4A069514F3E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10306-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	HAS_REPLYTO(0.00)[nathan.lynch@amd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:mid,amd.com:replyto]
X-Rspamd-Action: no action

From: Nathan Lynch <nathan.lynch@amd.com>

SDXI uses a two-level table hierarchy to track contexts. There is a
single level 2 table per function which enumerates up to 512 level 1
tables. Each level 1 table enumerates up to 128 contexts.

Allocate and install the L2 table and a single L1 table, enough for
context IDs 0-127 (i.e. the admin context with reserved id 0, plus 127
client contexts). For now, to avoid dynamic management of additional
L1 tables, cap ctl2.max_cxt to 127.

Since the table allocations are devres-managed, there is no
corresponding cleanup code required.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/device.c | 40 +++++++++++++++++++++++++++++--
 drivers/dma/sdxi/hw.h     | 61 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/mmio.h   |  6 +++++
 drivers/dma/sdxi/sdxi.h   |  5 ++++
 4 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index f9a9944ad892..6a2204ff7fde 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -8,11 +8,14 @@
 #include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/dma-mapping.h>
 #include <linux/iopoll.h>
 #include <linux/jiffies.h>
+#include <linux/log2.h>
 #include <linux/slab.h>
 #include <linux/time.h>
 
+#include "hw.h"
 #include "mmio.h"
 #include "sdxi.h"
 
@@ -136,7 +139,8 @@ static int sdxi_dev_stop(struct sdxi_dev *sdxi)
  */
 static int sdxi_fn_activate(struct sdxi_dev *sdxi)
 {
-	u64 version, cap0, cap1, ctl2;
+	u64 version, cap0, cap1, ctl2, cxt_l2, lv01_ptr;
+	struct sdxi_cxt_L2_ent *L2_ent;
 	int err;
 
 	/*
@@ -160,7 +164,13 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
 
 	cap1 = sdxi_read64(sdxi, SDXI_MMIO_CAP1);
 	sdxi->op_grp_cap = FIELD_GET(SDXI_MMIO_CAP1_OPB_000_CAP, cap1);
-	sdxi->max_cxtid = FIELD_GET(SDXI_MMIO_CAP1_MAX_CXT, cap1);
+
+	/*
+	 * Constrain the number of client contexts supported by the
+	 * driver to what fits in a single L1 table.
+	 */
+	sdxi->max_cxtid = min(SDXI_L1_TABLE_ENTRIES - 1,
+			      FIELD_GET(SDXI_MMIO_CAP1_MAX_CXT, cap1));
 
 	/* Apply our configuration. */
 	ctl2 = FIELD_PREP(SDXI_MMIO_CTL2_MAX_CXT, sdxi->max_cxtid);
@@ -172,6 +182,32 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
 			   FIELD_GET(SDXI_MMIO_CAP1_OPB_000_CAP, cap1));
 	sdxi_write64(sdxi, SDXI_MMIO_CTL2, ctl2);
 
+	/* SDXI 1.0 4.1.8.2 Context Level 2 Table Setup */
+	sdxi->L2_table = dmam_alloc_coherent(sdxi->dev,
+					     sizeof(*sdxi->L2_table),
+					     &sdxi->L2_dma, GFP_KERNEL);
+	if (!sdxi->L2_table)
+		return -ENOMEM;
+
+	cxt_l2 = FIELD_PREP(SDXI_MMIO_CXT_L2_PTR, sdxi->L2_dma >> ilog2(SZ_4K));
+	sdxi_write64(sdxi, SDXI_MMIO_CXT_L2, cxt_l2);
+
+	/* SDXI 1.0 4.1.8.3 Context Level 1 Table Setup */
+	sdxi->L1_table = dmam_alloc_coherent(sdxi->dev,
+					     sizeof(*sdxi->L1_table),
+					     &sdxi->L1_dma, GFP_KERNEL);
+	if (!sdxi->L1_table)
+		return -ENOMEM;
+	/*
+	 * SDXI 1.0 4.1.8.3.c: Initialize the Context level 2 table to
+	 * point to the Context Level 1 [table].
+	 */
+	L2_ent = &sdxi->L2_table->entry[0];
+	lv01_ptr = FIELD_PREP(SDXI_CXT_L2_ENT_VL, 1) |
+		   FIELD_PREP(SDXI_CXT_L2_ENT_LV01_PTR,
+			      sdxi->L1_dma >> ilog2(SZ_4K));
+	L2_ent->lv01_ptr = cpu_to_le64(lv01_ptr);
+
 	return 0;
 }
 
diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
new file mode 100644
index 000000000000..df520ca7792b
--- /dev/null
+++ b/drivers/dma/sdxi/hw.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright Advanced Micro Devices, Inc. */
+
+/*
+ * Control structures and constants defined in the SDXI specification,
+ * with low-level accessors. The ordering of the structures here
+ * follows the order of their definitions in the SDXI spec.
+ *
+ * Names of structures, members, and subfields (bit ranges within
+ * members) are written to match the spec, generally. E.g. struct
+ * sdxi_cxt_L2_ent corresponds to CXT_L2_ENT in the spec.
+ *
+ * Note: a member can have a subfield whose name is identical to the
+ * member's name. E.g. CXT_L2_ENT's lv01_ptr.
+ *
+ * All reserved fields and bits (usually named "rsvd" or some
+ * variation) must be set to zero by the driver unless otherwise
+ * specified.
+ */
+
+#ifndef DMA_SDXI_HW_H
+#define DMA_SDXI_HW_H
+
+#include <linux/bits.h>
+#include <linux/build_bug.h>
+#include <linux/types.h>
+#include <asm/byteorder.h>
+
+/* SDXI 1.0 Table 3-2: Context Level 2 Table Entry (CXT_L2_ENT) */
+struct sdxi_cxt_L2_ent {
+	__le64 lv01_ptr;
+#define SDXI_CXT_L2_ENT_VL       BIT_ULL(0)
+#define SDXI_CXT_L2_ENT_LV01_PTR GENMASK_ULL(63, 12)
+} __packed;
+static_assert(sizeof(struct sdxi_cxt_L2_ent) == 8);
+
+/* SDXI 1.0 3.2.1 Context Level 2 Table */
+#define SDXI_L2_TABLE_ENTRIES 512
+struct sdxi_cxt_L2_table {
+	struct sdxi_cxt_L2_ent entry[SDXI_L2_TABLE_ENTRIES];
+};
+static_assert(sizeof(struct sdxi_cxt_L2_table) == 4096);
+
+/* SDXI 1.0 Table 3-3: Context Level 1 Table Entry (CXT_L1_ENT) */
+struct sdxi_cxt_L1_ent {
+	__le64 cxt_ctl_ptr;
+	__le64 akey_ptr;
+	__le32 misc0;
+	__le32 opb_000_enb;
+	__u8 rsvd_0[8];
+} __packed;
+static_assert(sizeof(struct sdxi_cxt_L1_ent) == 32);
+
+/* SDXI 1.0 3.2.2 Context Level 1 Table */
+#define SDXI_L1_TABLE_ENTRIES 128
+struct sdxi_cxt_L1_table {
+	struct sdxi_cxt_L1_ent entry[SDXI_L1_TABLE_ENTRIES];
+};
+static_assert(sizeof(struct sdxi_cxt_L1_table) == 4096);
+
+#endif /* DMA_SDXI_HW_H */
diff --git a/drivers/dma/sdxi/mmio.h b/drivers/dma/sdxi/mmio.h
index c9a11c3f2f76..d8d631849938 100644
--- a/drivers/dma/sdxi/mmio.h
+++ b/drivers/dma/sdxi/mmio.h
@@ -19,6 +19,9 @@ enum sdxi_reg {
 	SDXI_MMIO_CAP0       = 0x00200,
 	SDXI_MMIO_CAP1       = 0x00208,
 	SDXI_MMIO_VERSION    = 0x00210,
+
+	/* SDXI 1.0 9.2 Context and RKey Table Registers */
+	SDXI_MMIO_CXT_L2     = 0x10000,
 };
 
 /* SDXI 1.0 Table 9-2: MMIO_CTL0 */
@@ -48,4 +51,7 @@ enum sdxi_reg {
 #define SDXI_MMIO_VERSION_MINOR GENMASK_ULL(7, 0)
 #define SDXI_MMIO_VERSION_MAJOR GENMASK_ULL(23, 16)
 
+/* SDXI 1.0 Table 9-9: MMIO_CXT_L2 */
+#define SDXI_MMIO_CXT_L2_PTR GENMASK_ULL(63, 12)
+
 #endif  /* DMA_SDXI_MMIO_H */
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index 84b87066f438..85ff17c48d40 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -39,6 +39,11 @@ struct sdxi_dev {
 	u16 max_cxtid;			/* Maximum context ID allowed. */
 	u32 op_grp_cap;			/* supported operation group cap */
 
+	struct sdxi_cxt_L2_table *L2_table;
+	dma_addr_t L2_dma;
+	struct sdxi_cxt_L1_table *L1_table;
+	dma_addr_t L1_dma;
+
 	const struct sdxi_bus_ops *bus_ops;
 };
 

-- 
2.54.0



