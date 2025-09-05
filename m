Return-Path: <dmaengine+bounces-6412-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B06ECB462A5
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 20:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE1D1CC16C3
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 18:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FA027F00A;
	Fri,  5 Sep 2025 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwMF/Dwd"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08000277017;
	Fri,  5 Sep 2025 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098131; cv=none; b=DYzwMmZlrRwznXgAbipTEaldYG18dvaytN275Zg1VPNZpTy8CMNjJ6a+HmktFU9R77ZzWlhTX31jDbiJ66D/M4/T43LGByWusd2oGRriup16+MgvWQjsi/FuXf1wYNXCstughSGbt5qhlJTwSOa5Zf1F+Fsy5Qtusr8W8byUZ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098131; c=relaxed/simple;
	bh=B9kAQoXWWXJAF0httlFrFKkdVM5OkPjDH2UJkh+cJ8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FxU/Zhw7O4eSunOM3aHfqLpy0q4gRO3RxJLoPmKoFF7JoCQiwXPBO6PUkZ6yZyr3UGXrXGSuvgdlUxYLaqtu9kX70sC8pDUKNCbbmvufl4+2xHbsK3zrZpv6N6f9PsQGmISoE6Or4MP3auh3WVqR0lcztqF2//v5cVB3BZ6fL/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwMF/Dwd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1411C116D0;
	Fri,  5 Sep 2025 18:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757098130;
	bh=B9kAQoXWWXJAF0httlFrFKkdVM5OkPjDH2UJkh+cJ8Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EwMF/DwdCPbLZgm7Yh9SYMkAQ/nhj+iwfhCUNykgAlXE4c5nhVD84w+sExcHr0kbZ
	 +NUEXsxlGKJC3QB6nlHEZd9orIiDLIQSy5i7h7Z2GYl68LkqoRTwiX6AoaDte6J1Hy
	 k6TNhY5zbH6xGJS87YEM+guF6xvR/x+pDFmE/VsNzRjT4ZrYhkSHwU2MgrdI3G5BlD
	 EbTothHvlg1wzhLRttJSdr1QYEKoD1efvNGxA0jRNk+e3oHFv/nCeKnfBWp4feqIh2
	 StjHifsbxEPLnI91xnB6tE7sEsYLNSnN5TM+UZ00zuDN3ZNRBOJW1cXoV7ULrQ48mZ
	 Rf58Mwm/XV4FQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADBECA1017;
	Fri,  5 Sep 2025 18:48:50 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 05 Sep 2025 13:48:32 -0500
Subject: [PATCH RFC 09/13] dmaengine: sdxi: Add core device management code
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-sdxi-base-v1-9-d0341a1292ba@amd.com>
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
In-Reply-To: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Wei Huang <wei.huang2@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757098128; l=11769;
 i=nathan.lynch@amd.com; s=20241010; h=from:subject:message-id;
 bh=9diIsq+I052wh0xw/r7UWxXJ4kXLffKLLVhFVkqEMsg=;
 b=2Qa7f9ttJwQevg9mRIGXo42mE5vgS17JbEW+6LS8IJKYzBd7Brkd/kuqkEp6mZwX4eWiby4Zc
 8HrjMtAGjBNBkZSJbxdh5vujGeIRtD3SEaXjj8XM8EYn4KLpwDdFFn2
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=ZR637UTGg5YLDj56cxFeHdYoUjPMMFbcijfOkAmAnbc=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20241010 with
 auth_id=241
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com

From: Nathan Lynch <nathan.lynch@amd.com>

Add code that manages device initialization and exit and provides
entry points for the PCI driver code to come.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/device.c | 397 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 397 insertions(+)

diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
new file mode 100644
index 0000000000000000000000000000000000000000..61123bc1d47b6547538b6e783ad96a9c2851494e
--- /dev/null
+++ b/drivers/dma/sdxi/device.c
@@ -0,0 +1,397 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI hardware device driver
+ *
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ */
+
+#include <asm/mmu.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmapool.h>
+#include <linux/log2.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+
+#include "context.h"
+#include "descriptor.h"
+#include "hw.h"
+#include "error.h"
+#include "sdxi.h"
+
+enum sdxi_fn_gsv {
+	SDXI_GSV_STOP,
+	SDXI_GSV_INIT,
+	SDXI_GSV_ACTIVE,
+	SDXI_GSV_STOPG_SF,
+	SDXI_GSV_STOPG_HD,
+	SDXI_GSV_ERROR,
+};
+
+static const char *const gsv_strings[] = {
+	[SDXI_GSV_STOP]     = "stopped",
+	[SDXI_GSV_INIT]     = "initializing",
+	[SDXI_GSV_ACTIVE]   = "active",
+	[SDXI_GSV_STOPG_SF] = "soft stopping",
+	[SDXI_GSV_STOPG_HD] = "hard stopping",
+	[SDXI_GSV_ERROR]    = "error",
+};
+
+static const char *gsv_str(enum sdxi_fn_gsv gsv)
+{
+	if ((size_t)gsv < ARRAY_SIZE(gsv_strings))
+		return gsv_strings[(size_t)gsv];
+
+	WARN_ONCE(1, "unexpected gsv %u\n", gsv);
+
+	return "unknown";
+}
+
+enum sdxi_fn_gsr {
+	SDXI_GSRV_RESET,
+	SDXI_GSRV_STOP_SF,
+	SDXI_GSRV_STOP_HD,
+	SDXI_GSRV_ACTIVE,
+};
+
+static enum sdxi_fn_gsv sdxi_dev_gsv(const struct sdxi_dev *sdxi)
+{
+	return (enum sdxi_fn_gsv)FIELD_GET(SDXI_MMIO_STS0_FN_GSV,
+					sdxi_read64(sdxi, SDXI_MMIO_STS0));
+}
+
+static void sdxi_write_fn_gsr(struct sdxi_dev *sdxi, enum sdxi_fn_gsr cmd)
+{
+	u64 ctl0 = sdxi_read64(sdxi, SDXI_MMIO_CTL0);
+
+	FIELD_MODIFY(SDXI_MMIO_CTL0_FN_GSR, &ctl0, cmd);
+	sdxi_write64(sdxi, SDXI_MMIO_CTL0, ctl0);
+}
+
+static int sdxi_dev_start(struct sdxi_dev *sdxi)
+{
+	unsigned long deadline;
+	enum sdxi_fn_gsv status;
+
+	status = sdxi_dev_gsv(sdxi);
+	if (status != SDXI_GSV_STOP) {
+		sdxi_err(sdxi,
+			 "can't activate busy device (unexpected gsv: %s)\n",
+			 gsv_str(status));
+		return -EIO;
+	}
+
+	sdxi_write_fn_gsr(sdxi, SDXI_GSRV_ACTIVE);
+
+	deadline = jiffies + msecs_to_jiffies(1000);
+	do {
+		status = sdxi_dev_gsv(sdxi);
+		sdxi_dbg(sdxi, "%s: function state: %s\n", __func__, gsv_str(status));
+
+		switch (status) {
+		case SDXI_GSV_ACTIVE:
+			sdxi_dbg(sdxi, "activated\n");
+			return 0;
+		case SDXI_GSV_ERROR:
+			sdxi_err(sdxi, "went to error state\n");
+			return -EIO;
+		case SDXI_GSV_INIT:
+		case SDXI_GSV_STOP:
+			/* transitional states, wait */
+			fsleep(1000);
+			break;
+		default:
+			sdxi_err(sdxi, "unexpected gsv %u, giving up\n", status);
+			return -EIO;
+		}
+	} while (time_before(jiffies, deadline));
+
+	sdxi_err(sdxi, "activation timed out, current status %u\n",
+		sdxi_dev_gsv(sdxi));
+	return -ETIMEDOUT;
+
+}
+
+/* Get the device to the GSV_STOP state. */
+static int sdxi_dev_stop(struct sdxi_dev *sdxi)
+{
+	unsigned long deadline = jiffies + msecs_to_jiffies(1000);
+	bool reset_issued = false;
+
+	do {
+		enum sdxi_fn_gsv status = sdxi_dev_gsv(sdxi);
+
+		sdxi_dbg(sdxi, "%s: function state: %s\n", __func__, gsv_str(status));
+
+		switch (status) {
+		case SDXI_GSV_ACTIVE:
+			sdxi_write_fn_gsr(sdxi, SDXI_GSRV_STOP_SF);
+			break;
+		case SDXI_GSV_ERROR:
+			if (!reset_issued) {
+				sdxi_info(sdxi,
+					  "function in error state, issuing reset\n");
+				sdxi_write_fn_gsr(sdxi, SDXI_GSRV_RESET);
+				reset_issued = true;
+			} else {
+				fsleep(1000);
+			}
+			break;
+		case SDXI_GSV_STOP:
+			return 0;
+		case SDXI_GSV_INIT:
+		case SDXI_GSV_STOPG_SF:
+		case SDXI_GSV_STOPG_HD:
+			/* transitional states, wait */
+			sdxi_dbg(sdxi, "waiting for stop (gsv = %u)\n",
+				 status);
+			fsleep(1000);
+			break;
+		default:
+			sdxi_err(sdxi, "unknown gsv %u, giving up\n", status);
+			return -EIO;
+		}
+	} while (time_before(jiffies, deadline));
+
+	sdxi_err(sdxi, "stop attempt timed out, current status %u\n",
+		sdxi_dev_gsv(sdxi));
+	return -ETIMEDOUT;
+}
+
+static void sdxi_stop(struct sdxi_dev *sdxi)
+{
+	sdxi_dev_stop(sdxi);
+}
+
+/* Refer to "Activation of the SDXI Function by Software". */
+static int sdxi_fn_activate(struct sdxi_dev *sdxi)
+{
+	const struct sdxi_dev_ops *ops = sdxi->dev_ops;
+	u64 cxt_l2;
+	u64 cap0;
+	u64 cap1;
+	u64 ctl2;
+	int err;
+
+	/*
+	 * Clear any existing configuration from MMIO_CTL0 and ensure
+	 * the function is in GSV_STOP state.
+	 */
+	sdxi_write64(sdxi, SDXI_MMIO_CTL0, 0);
+	err = sdxi_dev_stop(sdxi);
+	if (err)
+		return err;
+
+	/*
+	 * 1.a. Discover limits and implemented features via MMIO_CAP0
+	 * and MMIO_CAP1.
+	 */
+	cap0 = sdxi_read64(sdxi, SDXI_MMIO_CAP0);
+	sdxi->sfunc = FIELD_GET(SDXI_MMIO_CAP0_SFUNC, cap0);
+	sdxi->max_ring_entries = SZ_1K;
+	sdxi->max_ring_entries *= 1U << FIELD_GET(SDXI_MMIO_CAP0_MAX_DS_RING_SZ, cap0);
+	sdxi->db_stride = SZ_4K;
+	sdxi->db_stride *= 1U << FIELD_GET(SDXI_MMIO_CAP0_DB_STRIDE, cap0);
+
+	cap1 = sdxi_read64(sdxi, SDXI_MMIO_CAP1);
+	sdxi->max_akeys = SZ_256;
+	sdxi->max_akeys *= 1U << FIELD_GET(SDXI_MMIO_CAP1_MAX_AKEY_SZ, cap1);
+	sdxi->max_cxts = 1 + FIELD_GET(SDXI_MMIO_CAP1_MAX_CXT, cap1);
+	sdxi->op_grp_cap = FIELD_GET(SDXI_MMIO_CAP1_OPB_000_CAP, cap1);
+
+	/*
+	 * 1.b. Configure SDXI parameters via MMIO_CTL2. We don't have
+	 * any reason to impose more conservative limits than those
+	 * reported in the capability registers, so use those for now.
+	 */
+	ctl2 = 0;
+	ctl2 |= FIELD_PREP(SDXI_MMIO_CTL2_MAX_BUFFER,
+			   FIELD_GET(SDXI_MMIO_CAP1_MAX_BUFFER, cap1));
+	ctl2 |= FIELD_PREP(SDXI_MMIO_CTL2_MAX_AKEY_SZ,
+			   FIELD_GET(SDXI_MMIO_CAP1_MAX_AKEY_SZ, cap1));
+	ctl2 |= FIELD_PREP(SDXI_MMIO_CTL2_MAX_CXT,
+			   FIELD_GET(SDXI_MMIO_CAP1_MAX_CXT, cap1));
+	ctl2 |= FIELD_PREP(SDXI_MMIO_CTL2_OPB_000_AVL,
+			   FIELD_GET(SDXI_MMIO_CAP1_OPB_000_CAP, cap1));
+	sdxi_write64(sdxi, SDXI_MMIO_CTL2, ctl2);
+
+	sdxi_dbg(sdxi,
+		 "sfunc:%#x descmax:%llu dbstride:%#x akeymax:%u cxtmax:%u opgrps:%#x\n",
+		 sdxi->sfunc, sdxi->max_ring_entries, sdxi->db_stride,
+		 sdxi->max_akeys, sdxi->max_cxts, sdxi->op_grp_cap);
+
+	/* 2.a-2.b. Allocate and zero the 4KB Context Level 2 Table */
+	sdxi->l2_table = dmam_alloc_coherent(sdxi_to_dev(sdxi), L2_TABLE_SIZE,
+					     &sdxi->l2_dma, GFP_KERNEL);
+	if (!sdxi->l2_table)
+		return -ENOMEM;
+
+	/* 2.c. Program MMIO_CXT_L2 */
+	cxt_l2 = FIELD_PREP(SDXI_MMIO_CXT_L2_PTR, sdxi->l2_dma >> ilog2(SZ_4K));
+	sdxi_write64(sdxi, SDXI_MMIO_CXT_L2, cxt_l2);
+
+	/*
+	 * 2.c.i. TODO: Program MMIO_CTL0.fn_pasid and
+	 * MMIO_CTL0.fn_pasid if guest virtual addressing required.
+	 */
+
+	/*
+	 * This covers the following steps:
+	 *
+	 * 3. Context Level 1 Table Setup for contexts 0..127.
+	 * 4.a. Create the administrative context and associated control
+	 * structures.
+	 * 4.b. Set its CXT_STS.state to CXTV_RUN; see 10.b.
+	 *
+	 * The admin context will not consume descriptors until we
+	 * write its doorbell later.
+	 */
+	sdxi->admin_cxt = sdxi_working_cxt_init(sdxi, SDXI_ADMIN_CXT_ID);
+	if (!sdxi->admin_cxt)
+		return -ENOMEM;
+	/*
+	 * 5. Mailbox: we don't use this facility and we assume the
+	 * reset values are sane.
+	 *
+	 * 6. If restoring saved state, adjust as appropriate. (We're not.)
+	 */
+
+	/*
+	 * MSI allocation is informed by the function's maximum
+	 * supported contexts, which was discovered in 1.a. Need to do
+	 * this before step 7, which claims an IRQ.
+	 */
+	err = (ops && ops->irq_init) ? ops->irq_init(sdxi) : 0;
+	if (err)
+		goto admin_cxt_exit;
+
+	/* 7. Initialize error log according to "Error Log Initialization". */
+	err = sdxi_error_init(sdxi);
+	if (err)
+		goto irq_exit;
+
+	/*
+	 * 8. "Software may also need to configure and enable
+	 * additional [features]". We've already performed MSI setup,
+	 * nothing else for us to do here for now.
+	 */
+
+	/*
+	 * 9. Set MMIO_CTL0.fn_gsr to GSRV_ACTIVE and wait for
+	 * MMIO_STS0.fn_gsv to reach GSV_ACTIVE or GSV_ERROR.
+	 */
+	err = sdxi_dev_start(sdxi);
+	if (err)
+		goto error_exit;
+
+	/*
+	 * 10. Jump start the admin context. This step refers to
+	 * "Starting A context and Context Signaling," where method #3
+	 * recommends writing an "appropriate" value to the doorbell
+	 * register. We haven't queued any descriptors to the admin
+	 * context at this point, so the appropriate value would be 0.
+	 */
+	iowrite64(0, sdxi->admin_cxt->db);
+
+	return 0;
+
+error_exit:
+	sdxi_error_exit(sdxi);
+irq_exit:
+	if (ops && ops->irq_exit)
+		ops->irq_exit(sdxi);
+admin_cxt_exit:
+	sdxi_working_cxt_exit(sdxi->admin_cxt);
+	return err;
+}
+
+int sdxi_device_init(struct sdxi_dev *sdxi, const struct sdxi_dev_ops *ops)
+{
+	struct sdxi_cxt_start params;
+	struct sdxi_cxt *admin_cxt;
+	struct sdxi_desc desc;
+	struct sdxi_cxt *dma_cxt;
+	int err;
+
+	sdxi->dev_ops = ops;
+
+	sdxi->write_index_pool = dmam_pool_create("Write_Index", sdxi_to_dev(sdxi),
+						  sizeof(__le64), sizeof(__le64), 0);
+	sdxi->cxt_sts_pool = dmam_pool_create("CXT_STS", sdxi_to_dev(sdxi),
+					      sizeof(struct sdxi_cxt_sts),
+					      sizeof(struct sdxi_cxt_sts), 0);
+	sdxi->cxt_ctl_pool = dmam_pool_create("CXT_CTL", sdxi_to_dev(sdxi),
+					      sizeof(struct sdxi_cxt_ctl),
+					      sizeof(struct sdxi_cxt_ctl), 0);
+	if (!sdxi->write_index_pool || !sdxi->cxt_sts_pool || !sdxi->cxt_ctl_pool)
+		return -ENOMEM;
+
+	err = sdxi_fn_activate(sdxi);
+	if (err)
+		return err;
+
+	admin_cxt = sdxi->admin_cxt;
+
+	dma_cxt = sdxi_working_cxt_init(sdxi, SDXI_DMA_CXT_ID);
+	if (!dma_cxt) {
+		err = -EINVAL;
+		goto fn_stop;
+	}
+
+	sdxi->dma_cxt = dma_cxt;
+
+	params = (typeof(params)) {
+		.range = sdxi_cxt_range(dma_cxt->id),
+	};
+	err = sdxi_encode_cxt_start(&desc, &params);
+	if (err)
+		goto fn_stop;
+
+	err = sdxi_submit_desc(admin_cxt, &desc);
+	if (err)
+		goto fn_stop;
+
+	return 0;
+fn_stop:
+	sdxi_stop(sdxi);
+	return err;
+}
+
+void sdxi_device_exit(struct sdxi_dev *sdxi)
+{
+	sdxi_working_cxt_exit(sdxi->dma_cxt);
+
+	/* Walk sdxi->cxt_array freeing any allocated rows. */
+	for (size_t i = 0; i < L2_TABLE_ENTRIES; ++i) {
+		if (!sdxi->cxt_array[i])
+			continue;
+		/* When a context is released its entry in the table should be NULL. */
+		for (size_t j = 0; j < L1_TABLE_ENTRIES; ++j) {
+			struct sdxi_cxt *cxt = sdxi->cxt_array[i][j];
+
+			if (!cxt)
+				continue;
+			if (cxt->id != 0)  /* admin context shutdown is last */
+				sdxi_working_cxt_exit(cxt);
+			sdxi->cxt_array[i][j] = NULL;
+		}
+		if (i != 0)  /* another special case for admin cxt */
+			kfree(sdxi->cxt_array[i]);
+	}
+
+	sdxi_working_cxt_exit(sdxi->admin_cxt);
+	kfree(sdxi->cxt_array[0]);  /* ugh */
+
+	sdxi_stop(sdxi);
+	sdxi_error_exit(sdxi);
+	if (sdxi->dev_ops && sdxi->dev_ops->irq_exit)
+		sdxi->dev_ops->irq_exit(sdxi);
+}
+
+MODULE_DESCRIPTION("SDXI driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Wei Huang");
+MODULE_AUTHOR("Nathan Lynch");

-- 
2.39.5



