Return-Path: <dmaengine+bounces-6414-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFA2B462A7
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 20:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8495E0EB7
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 18:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DC4280324;
	Fri,  5 Sep 2025 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4YmxzDp"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0E927A909;
	Fri,  5 Sep 2025 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098131; cv=none; b=cvvOq2pJXSwf389D8eXGQ8WGAn3F7cCkSQd4c5Vdu3bpFq7lCLAjljBlx3B8ZMM/KJLT76NO1QKy383ilHnyDynihJ+R1o1p7QGo2f1N6/mqstA16w2Y9x0aAaQvkNnUHYIUz5QM5+YQQ96ogrHeH6PGvl7pVHqRtpRDyvnQCt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098131; c=relaxed/simple;
	bh=gxLms/n20WfLhcKgyfWTqx+j2vFsLPMIcU0uK5jEDN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I8jb6+bOX8yF79b0MJFaWgWzcpXEwxM2+dk84Ia+9smRI3iq2YTBbotklucF+YURVXfY4v/UmaNOEOFPRh5YZVj5wb3ZUTTxytGqJY9iHVEOHOvayUoApSWqI37CTnwwK1fMtKnBTikqvthLvgn1j2wAKEE9rJZiJEJQyAn0yHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4YmxzDp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD1EBC113D0;
	Fri,  5 Sep 2025 18:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757098130;
	bh=gxLms/n20WfLhcKgyfWTqx+j2vFsLPMIcU0uK5jEDN8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=N4YmxzDpoD2C4slpYEGXeI5semrRJBCZrHX/mQE4k9GRM8sqLdGMswHu+7fwEFSGZ
	 frlMFCrc3iHRN/rJigjZQNJmC9QjOnSpA+DZ3LQj9gVvn6ZZhOzTJwMenJrqaXFPUy
	 e68NqBNe4Bfi8Y8hvDO+3ej0QLVvHuqCQXfugpTWO2p1Vlpey2rp1981RUlVgM/sUt
	 aZL3goSXV1pZulMji30L8re9VNZalip5mkgprBup2P+1N4EytqRj7LG4TRMVWcxjAD
	 rz/Oz1Je9eF1OPilAAUTqGIQn+G0oDLVWi0tx2ixRcaJWL0Gt+Ua4S4UElJB5Y2Zw2
	 kUhdpykzE7cWw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14C8CA101F;
	Fri,  5 Sep 2025 18:48:50 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 05 Sep 2025 13:48:29 -0500
Subject: [PATCH RFC 06/13] dmaengine: sdxi: Add error reporting support
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-sdxi-base-v1-6-d0341a1292ba@amd.com>
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
In-Reply-To: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Wei Huang <wei.huang2@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757098128; l=11588;
 i=nathan.lynch@amd.com; s=20241010; h=from:subject:message-id;
 bh=6rZREI4qtaKsK3PLJAoeE8SshEtSkRN4UhMeM+BErEk=;
 b=tRj2S/vHwCyhHxb/jjucfFIPOohG6RXZjlIfumuDTioFhUimAkyvOhpE8vQ7jk+W5UsR5/enF
 JvP7BBAknarAyI/W7dLR61u1HsJh+o/kGQf3AVjj0FRY0BI9B2RChkO
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=ZR637UTGg5YLDj56cxFeHdYoUjPMMFbcijfOkAmAnbc=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20241010 with
 auth_id=241
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com

From: Nathan Lynch <nathan.lynch@amd.com>

SDXI implementations provide software with detailed information about
error conditions using a per-device ring buffer in system memory. When
an error condition is signaled via interrupt, the driver retrieves any
pending error log entries and reports them to the kernel log.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/error.c | 340 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/error.h |  16 +++
 2 files changed, 356 insertions(+)

diff --git a/drivers/dma/sdxi/error.c b/drivers/dma/sdxi/error.c
new file mode 100644
index 0000000000000000000000000000000000000000..c5e33f5989250352f6b081a3049b3b1f972c85a6
--- /dev/null
+++ b/drivers/dma/sdxi/error.c
@@ -0,0 +1,340 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI error reporting.
+ *
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irqreturn.h>
+#include <linux/packing.h>
+#include <linux/types.h>
+
+#include "error.h"
+#include "mmio.h"
+#include "sdxi.h"
+
+/*
+ * The error log ring buffer size is configurable, but for now we fix
+ * it to 64 entries (which is the spec minimum).
+ */
+#define ERROR_LOG_ENTRIES 64
+#define ERROR_LOG_SZ (ERROR_LOG_ENTRIES * sizeof(struct sdxi_errlog_hd_ent))
+
+/* The "unpacked" counterpart to ERRLOG_HD_ENT. */
+struct errlog_entry {
+	u64 dsc_index;
+	u16 cxt_num;
+	u16 err_class;
+	u16 type;
+	u8 step;
+	u8 buf;
+	u8 sub_step;
+	u8 re;
+	bool vl;
+	bool cv;
+	bool div;
+	bool bv;
+};
+
+#define ERRLOG_ENTRY_FIELD(hi_, lo_, name_)				\
+	PACKED_FIELD(hi_, lo_, struct errlog_entry, name_)
+#define ERRLOG_ENTRY_FLAG(nr_, name_) \
+	ERRLOG_ENTRY_FIELD(nr_, nr_, name_)
+
+/* Refer to "Error Log Header Entry (ERRLOG_HD_ENT)" */
+static const struct packed_field_u16 errlog_hd_ent_fields[] = {
+	ERRLOG_ENTRY_FLAG(0, vl),
+	ERRLOG_ENTRY_FIELD(13, 8, step),
+	ERRLOG_ENTRY_FIELD(26, 16, type),
+	ERRLOG_ENTRY_FLAG(32, cv),
+	ERRLOG_ENTRY_FLAG(33, div),
+	ERRLOG_ENTRY_FLAG(34, bv),
+	ERRLOG_ENTRY_FIELD(38, 36, buf),
+	ERRLOG_ENTRY_FIELD(43, 40, sub_step),
+	ERRLOG_ENTRY_FIELD(46, 44, re),
+	ERRLOG_ENTRY_FIELD(63, 48, cxt_num),
+	ERRLOG_ENTRY_FIELD(127, 64, dsc_index),
+	ERRLOG_ENTRY_FIELD(367, 352, err_class),
+};
+
+enum {
+	SDXI_PACKING_QUIRKS = QUIRK_LITTLE_ENDIAN | QUIRK_LSW32_IS_FIRST,
+};
+
+/*
+ * Refer to "(Flagged) Processing Step" and
+ * "Error Log Header Entry (ERRLOG_HD_ENT)", subfield "step"
+ */
+enum errv_step {
+	ERRV_INT         = 1,
+	ERRV_CXT_L2      = 2,
+	ERRV_CXT_L1      = 3,
+	ERRV_CXT_CTL     = 4,
+	ERRV_CXT_STS     = 5,
+	ERRV_WRT_IDX     = 6,
+	ERRV_DSC_GEN     = 7,
+	ERRV_DSC_CSB     = 8,
+	ERRV_ATOMIC      = 9,
+	ERRV_DSC_BUF     = 10,
+	ERRV_DSC_AKEY    = 11,
+	ERRV_FN_RKEY     = 12,
+};
+
+static const char *const processing_steps[] = {
+	[ERRV_INT]        = "Internal Error",
+	[ERRV_CXT_L2]     = "Context Level 2 Table Entry - Translate, Read, Validate",
+	[ERRV_CXT_L1]     = "Context Level 1 Table Entry - Translate, Read, Validate",
+	[ERRV_CXT_CTL]    = "Context Control - Translate, Read, Validate",
+	[ERRV_CXT_STS]    = "Context Status - Translate, Access, Validate",
+	[ERRV_WRT_IDX]    = "Write_Index - Translate, Read, Validate",
+	[ERRV_DSC_GEN]    = "Descriptor Entry - Translate, Access, Validate",
+	[ERRV_DSC_CSB]    = "Descriptor CST_BLK - Translate, Access, Validate",
+	[ERRV_ATOMIC]     = "Atomic Return Data - Translate, Access",
+	[ERRV_DSC_BUF]    = "Descriptor: Data Buffer - Translate, Access",
+	[ERRV_DSC_AKEY]   = "Descriptor AKey Lookup - Translate, Access, Validate",
+	[ERRV_FN_RKEY]    = "Function RKey Lookup - Translate, Read, Validate",
+};
+
+static const char *step_str(enum errv_step step)
+{
+	const char *str = "reserved";
+
+	switch (step) {
+	case ERRV_INT ... ERRV_FN_RKEY:
+		str = processing_steps[step];
+		break;
+	}
+
+	return str;
+}
+
+/* Refer to "Error Log Header Entry (ERRLOG_HD_ENT)", subfield "sub_step" */
+enum errv_sub_step {
+	SUB_STEP_OTHER    = 0,
+	SUB_STEP_ATF      = 1,
+	SUB_STEP_DAF      = 2,
+	SUB_STEP_DVF      = 3,
+};
+
+static const char * const processing_sub_steps[] = {
+	[SUB_STEP_OTHER]    = "Other/unknown",
+	[SUB_STEP_ATF]      = "Address Translation Failure",
+	[SUB_STEP_DAF]      = "Data Access Failure",
+	[SUB_STEP_DVF]      = "Data Validation Failure",
+};
+
+static const char *sub_step_str(enum errv_sub_step sub_step)
+{
+	const char *str = "reserved";
+
+	switch (sub_step) {
+	case SUB_STEP_OTHER ... SUB_STEP_DVF:
+		str = processing_sub_steps[sub_step];
+		break;
+	}
+
+	return str;
+}
+
+/* Refer to "Error Log Header Entry (ERRLOG_HD_ENT)", subfield "re" */
+enum fn_reaction {
+	FN_REACT_INFORM      = 0,
+	FN_REACT_CXT_STOP    = 1,
+	FN_REACT_FN_STOP     = 2,
+};
+
+static const char * const fn_reactions[] = {
+	[FN_REACT_INFORM]      = "Informative, nothing stopped",
+	[FN_REACT_CXT_STOP]    = "Context stopped",
+	[FN_REACT_FN_STOP]     = "Function stopped",
+};
+
+static const char *reaction_str(enum fn_reaction reaction)
+{
+	const char *str = "reserved";
+
+	switch (reaction) {
+	case FN_REACT_INFORM ... FN_REACT_FN_STOP:
+		str = fn_reactions[reaction];
+		break;
+	}
+
+	return str;
+}
+
+static void sdxi_print_err(struct sdxi_dev *sdxi, u64 err_rd)
+{
+	struct errlog_entry ent;
+	size_t index;
+
+	index = err_rd % ERROR_LOG_ENTRIES;
+
+	unpack_fields(&sdxi->err_log[index], sizeof(sdxi->err_log[0]),
+		      &ent, errlog_hd_ent_fields, SDXI_PACKING_QUIRKS);
+
+	if (!ent.vl) {
+		dev_err_ratelimited(sdxi_to_dev(sdxi),
+				    "Ignoring error log entry with vl=0\n");
+		return;
+	}
+
+	if (ent.type != OP_TYPE_ERRLOG) {
+		dev_err_ratelimited(sdxi_to_dev(sdxi),
+				    "Ignoring error log entry with type=%#x\n",
+				    ent.type);
+		return;
+	}
+
+	sdxi_err(sdxi, "error log entry[%zu], MMIO_ERR_RD=%#llx:\n",
+		 index, err_rd);
+	sdxi_err(sdxi, "  re: %#x (%s)\n", ent.re, reaction_str(ent.re));
+	sdxi_err(sdxi, "  step: %#x (%s)\n", ent.step, step_str(ent.step));
+	sdxi_err(sdxi, "  sub_step: %#x (%s)\n",
+		 ent.sub_step, sub_step_str(ent.sub_step));
+	sdxi_err(sdxi, "  cv: %u div: %u bv: %u\n", ent.cv, ent.div, ent.bv);
+	if (ent.bv)
+		sdxi_err(sdxi, "  buf: %u\n", ent.buf);
+	if (ent.cv)
+		sdxi_err(sdxi, "  cxt_num: %#x\n", ent.cxt_num);
+	if (ent.div)
+		sdxi_err(sdxi, "  dsc_index: %#llx\n", ent.dsc_index);
+	sdxi_err(sdxi, "  err_class: %#x\n", ent.err_class);
+}
+
+/* Refer to "Error Log Processing by Software" */
+static irqreturn_t sdxi_irq_thread(int irq, void *data)
+{
+	struct sdxi_dev *sdxi = data;
+	u64 write_index;
+	u64 read_index;
+	u64 err_sts;
+
+	/* 1. Check MMIO_ERR_STS and perform any required remediation. */
+	err_sts = sdxi_read64(sdxi, SDXI_MMIO_ERR_STS);
+	if (!(err_sts & SDXI_MMIO_ERR_STS_STS_BIT))
+		return IRQ_HANDLED;
+
+	if (err_sts & SDXI_MMIO_ERR_STS_ERR_BIT) {
+		/*
+		 * Assume this isn't recoverable; e.g. the error log
+		 * isn't configured correctly. Don't clear
+		 * SDXI_MMIO_ERR_STS before returning.
+		 */
+		sdxi_err(sdxi, "attempted but failed to log errors\n");
+		sdxi_err(sdxi, "error log not functional\n");
+		return IRQ_HANDLED;
+	}
+
+	if (err_sts & SDXI_MMIO_ERR_STS_OVF_BIT)
+		sdxi_err(sdxi, "error log overflow, some entries lost\n");
+
+	/* 2. If MMIO_ERR_STS.sts is 1, then compute read_index. */
+	read_index = sdxi_read64(sdxi, SDXI_MMIO_ERR_RD);
+
+	/* 3. Clear MMIO_ERR_STS. The flags in this register are RW1C. */
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_STS,
+		     SDXI_MMIO_ERR_STS_STS_BIT |
+		     SDXI_MMIO_ERR_STS_OVF_BIT |
+		     SDXI_MMIO_ERR_STS_ERR_BIT);
+
+	/* 4. Compute write_index. */
+	write_index = sdxi_read64(sdxi, SDXI_MMIO_ERR_WRT);
+
+	/* 5. If the indexes are equal then exit. */
+	if (read_index == write_index)
+		return IRQ_HANDLED;
+
+	/* 6. While read_index < write_index... */
+	while (read_index < write_index) {
+
+		/*
+		 * 7. and 8. Compute the real ring buffer index from
+		 * read_index and process the entry.
+		 */
+		sdxi_print_err(sdxi, read_index);
+
+		/* 9. Advance read_index. */
+		++read_index;
+
+		/* 10. Return to step 6. */
+	}
+
+	/* 11. Write read_index to MMIO_ERR_RD. */
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_RD, read_index);
+
+	return IRQ_HANDLED;
+}
+
+/* Refer to "Error Log Initialization" */
+int sdxi_error_init(struct sdxi_dev *sdxi)
+{
+	u64 reg;
+	int err;
+
+	/* 1. Clear MMIO_ERR_CFG. Error interrupts are inhibited until step 6. */
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_CFG, 0);
+
+	/* 2. Clear MMIO_ERR_STS. The flags in this register are RW1C. */
+	reg = FIELD_PREP(SDXI_MMIO_ERR_STS_STS_BIT, 1) |
+	      FIELD_PREP(SDXI_MMIO_ERR_STS_OVF_BIT, 1) |
+	      FIELD_PREP(SDXI_MMIO_ERR_STS_ERR_BIT, 1);
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_STS, reg);
+
+	/* 3. Allocate memory for the error log ring buffer, initialize to zero. */
+	sdxi->err_log = dma_alloc_coherent(sdxi_to_dev(sdxi), ERROR_LOG_SZ,
+					   &sdxi->err_log_dma, GFP_KERNEL);
+	if (!sdxi->err_log)
+		return -ENOMEM;
+
+	/*
+	 * 4. Set MMIO_ERR_CTL.intr_en to 1 if interrupts on
+	 * context-level errors are desired.
+	 */
+	reg = sdxi_read64(sdxi, SDXI_MMIO_ERR_CTL);
+	FIELD_MODIFY(SDXI_MMIO_ERR_CTL_EN, &reg, 1);
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_CTL, reg);
+
+	/*
+	 * The spec is not explicit about when to do this, but this
+	 * seems like the right time: enable interrupt on
+	 * function-level transition to error state.
+	 */
+	reg = sdxi_read64(sdxi, SDXI_MMIO_CTL0);
+	FIELD_MODIFY(SDXI_MMIO_CTL0_FN_ERR_INTR_EN, &reg, 1);
+	sdxi_write64(sdxi, SDXI_MMIO_CTL0, reg);
+
+	/* 5. Clear MMIO_ERR_WRT and MMIO_ERR_RD. */
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_WRT, 0);
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_RD, 0);
+
+	/*
+	 * Error interrupts can be generated once MMIO_ERR_CFG.en is
+	 * set in step 6, so set up the handler now.
+	 */
+	err = request_threaded_irq(sdxi->error_irq, NULL, sdxi_irq_thread,
+				   IRQF_TRIGGER_NONE, "SDXI error", sdxi);
+	if (err)
+		goto free_errlog;
+
+	/* 6. Program MMIO_ERR_CFG. */
+	reg = FIELD_PREP(SDXI_MMIO_ERR_CFG_PTR, sdxi->err_log_dma >> 12) |
+	      FIELD_PREP(SDXI_MMIO_ERR_CFG_SZ, ERROR_LOG_ENTRIES >> 6) |
+	      FIELD_PREP(SDXI_MMIO_ERR_CFG_EN, 1);
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_CFG, reg);
+
+	return 0;
+
+free_errlog:
+	dma_free_coherent(sdxi_to_dev(sdxi), ERROR_LOG_SZ,
+			  sdxi->err_log, sdxi->err_log_dma);
+	return err;
+}
+
+void sdxi_error_exit(struct sdxi_dev *sdxi)
+{
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_CFG, 0);
+	free_irq(sdxi->error_irq, sdxi);
+	dma_free_coherent(sdxi_to_dev(sdxi), ERROR_LOG_SZ,
+			  sdxi->err_log, sdxi->err_log_dma);
+}
diff --git a/drivers/dma/sdxi/error.h b/drivers/dma/sdxi/error.h
new file mode 100644
index 0000000000000000000000000000000000000000..50019d9811184464227ae13baa509101a2a3aacc
--- /dev/null
+++ b/drivers/dma/sdxi/error.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SDXI error handling entry points.
+ *
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ */
+
+#ifndef DMA_SDXI_ERROR_H
+#define DMA_SDXI_ERROR_H
+
+struct sdxi_dev;
+
+int sdxi_error_init(struct sdxi_dev *sdxi);
+void sdxi_error_exit(struct sdxi_dev *sdxi);
+
+#endif  /* DMA_SDXI_ERROR_H */

-- 
2.39.5



