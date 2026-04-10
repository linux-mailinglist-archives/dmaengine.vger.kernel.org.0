Return-Path: <dmaengine+bounces-9972-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wP9zEhH32GkYkQgAu9opvQ
	(envelope-from <dmaengine+bounces-9972-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 15:11:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCD93D7FC5
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 15:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DA2D308DD9C
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 13:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB7D3BE639;
	Fri, 10 Apr 2026 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpMG9T/i"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B952A3BAD9C;
	Fri, 10 Apr 2026 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775826470; cv=none; b=dnXordN3K6rRKmiTGeGNjFVLOjCtb/Iu/VP+CRT7ws3+tY06ly33cW5LKfs4aXlmKz6HIp1cfNBWLzm0YpyEExoanApS7Q3aWc3iPL8vY5+wIOcOk701goVqAlh2AqqHTgDa+JJiscpUT2I9MVEbIKMzbUpaKw5OvzefnK5d58U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775826470; c=relaxed/simple;
	bh=pdL8gmnInQhr+OkRchs9HrRcYzy7ntT2qg2zGNwakHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eqgsDLVnG9+sDkjIdjB91ZxRSAhBu3XqXqZ5lYCF3T4HZIvYU9JgBKT9FTROgH/BI6yH5hvmDyRa6z2hXn2fbmZlqXPYTgkq9M0yWReZiXbYMYpKBiOcVlrMF/4j3LdKoYibp72XkdHlW9skxUSfAaF64Dagb9P0ZLdKp5NYr1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpMG9T/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AF83C2BC87;
	Fri, 10 Apr 2026 13:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775826470;
	bh=pdL8gmnInQhr+OkRchs9HrRcYzy7ntT2qg2zGNwakHY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GpMG9T/ipSZYV/Tmajx+YOhTe3l9Wgukq5txazMossGOsl/JIUYs4rpjz1sOaOURM
	 aCVp+AU0BIevWFgUFl05DWzGCW5zF6pdBHsWvfRqYvhll6OCkGOu0uTrR4Ol9+8jaz
	 3XupsXxOX5IjyKZ+snp+fz64UbHETkjZ5lWSZE3rmMQmQXR4+xELa9Xfw4fXivLzbs
	 TGV9k6n1zRfWGGfL4kMr0pCcjSK689D70Vt2YpDOSM08NCbGWJI86cqjzuiqNQLHEk
	 fj6Qak0i049tjJuwvNeM8vTrb7Tv6ymJAtBUlnwKItwiW8LvS3tMw/T8eiOSrd0eYJ
	 s6oaYmjKtZGOA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95093F44860;
	Fri, 10 Apr 2026 13:07:50 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 10 Apr 2026 08:07:27 -0500
Subject: [PATCH 17/23] dmaengine: sdxi: Add completion status block API
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-sdxi-base-v1-17-1d184cb5c60a@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775826467; l=5294;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=T6jw1oPuUOWQrLSHLeiikyAfky0tAEzNv9gn5QH5NPY=;
 b=8JlPMftwgxsCVvBorROVYsRdlgrUpWJTxL+8rpQtNutL0O2d0lHmb/qDfgDHaI/Xyw+a0mPEI
 snDlSkfS62fB4b4n2HPNLsb9gqkpoPhxQ7bVAAfTUYTCywj0G9p5EXW
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9972-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[nathan.lynch@amd.com]
X-Rspamd-Queue-Id: DBCD93D7FC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Nathan Lynch <nathan.lynch@amd.com>

Introduce an API for managing completion status blocks. These are
DMA-coherent buffers that may be optionally attached to SDXI
descriptors to signal completion. The SDXI implementation clears the
signal field (initialized to 1) upon completion, setting an
error bit in the flags field if problems were encountered executing
the descriptor.

Callers allocate completion blocks from a per-device DMA pool via
sdxi_completion_alloc(). sdxi_completion_attach() associates a
completion with a descriptor by encoding the completion's DMA address
into the descriptor's csb_ptr field.

sdxi_completion_poll() busy-waits until the signal field is cleared by
the implementation, and is intended for descriptors that are expected
to execute quickly.

sdxi_completion_signaled() and sdxi_completion_errored() query the
signal field and error flag of the completion, respectively.

struct sdxi_completion is kept opaque to callers. A DEFINE_FREE
cleanup handler is provided.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/Makefile     |  1 +
 drivers/dma/sdxi/completion.c | 79 +++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/completion.h | 24 +++++++++++++
 drivers/dma/sdxi/hw.h         |  1 +
 4 files changed, 105 insertions(+)

diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
index 372f793c15b1..dd08f4a5f723 100644
--- a/drivers/dma/sdxi/Makefile
+++ b/drivers/dma/sdxi/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_SDXI) += sdxi.o
 
 sdxi-objs += \
+	completion.o  \
 	context.o     \
 	device.o      \
 	ring.o
diff --git a/drivers/dma/sdxi/completion.c b/drivers/dma/sdxi/completion.c
new file mode 100644
index 000000000000..859c8334f0e7
--- /dev/null
+++ b/drivers/dma/sdxi/completion.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI Descriptor Completion Status Block handling.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+#include <linux/cleanup.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmapool.h>
+#include <linux/slab.h>
+
+#include "completion.h"
+#include "descriptor.h"
+#include "hw.h"
+
+struct sdxi_completion {
+	struct sdxi_dev *sdxi;
+	struct sdxi_cst_blk *cst_blk;
+	dma_addr_t cst_blk_dma;
+};
+
+struct sdxi_completion *sdxi_completion_alloc(struct sdxi_dev *sdxi)
+{
+	struct sdxi_cst_blk *cst_blk;
+	dma_addr_t cst_blk_dma;
+
+	/*
+	 * Assume callers can't tolerate GFP_KERNEL and use
+	 * GFP_NOWAIT. Add a gfp_t flags parameter if that changes.
+	 */
+	struct sdxi_completion *sc __free(kfree) = kmalloc(sizeof(*sc), GFP_NOWAIT);
+	if (!sc)
+		return NULL;
+
+	cst_blk = dma_pool_zalloc(sdxi->cst_blk_pool, GFP_NOWAIT, &cst_blk_dma);
+	if (!cst_blk)
+		return NULL;
+
+	cst_blk->signal = cpu_to_le64(1);
+
+	*sc = (typeof(*sc)) {
+		.sdxi        = sdxi,
+		.cst_blk     = cst_blk,
+		.cst_blk_dma = cst_blk_dma,
+	};
+
+	return_ptr(sc);
+}
+
+void sdxi_completion_free(struct sdxi_completion *sc)
+{
+	dma_pool_free(sc->sdxi->cst_blk_pool, sc->cst_blk, sc->cst_blk_dma);
+	kfree(sc);
+}
+
+void sdxi_completion_poll(const struct sdxi_completion *sc)
+{
+	while (READ_ONCE(sc->cst_blk->signal) != 0)
+		cpu_relax();
+}
+
+bool sdxi_completion_signaled(const struct sdxi_completion *sc)
+{
+	dma_rmb();
+	return (sc->cst_blk->signal == 0);
+}
+
+bool sdxi_completion_errored(const struct sdxi_completion *sc)
+{
+	dma_rmb();
+	return FIELD_GET(SDXI_CST_BLK_ER_BIT, le32_to_cpu(sc->cst_blk->flags));
+}
+
+
+void sdxi_completion_attach(struct sdxi_desc *desc,
+			    const struct sdxi_completion *cs)
+{
+	sdxi_desc_set_csb(desc, cs->cst_blk_dma);
+}
diff --git a/drivers/dma/sdxi/completion.h b/drivers/dma/sdxi/completion.h
new file mode 100644
index 000000000000..b3b2b85796ad
--- /dev/null
+++ b/drivers/dma/sdxi/completion.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright Advanced Micro Devices, Inc. */
+#ifndef DMA_SDXI_COMPLETION_H
+#define DMA_SDXI_COMPLETION_H
+
+#include "sdxi.h"
+
+/*
+ * Polled completion status block that can be attached to a
+ * descriptor.
+ */
+struct sdxi_completion;
+struct sdxi_desc;
+struct sdxi_completion *sdxi_completion_alloc(struct sdxi_dev *sdxi);
+void sdxi_completion_free(struct sdxi_completion *sc);
+void sdxi_completion_poll(const struct sdxi_completion *sc);
+void sdxi_completion_attach(struct sdxi_desc *desc,
+			    const struct sdxi_completion *sc);
+bool sdxi_completion_signaled(const struct sdxi_completion *sc);
+bool sdxi_completion_errored(const struct sdxi_completion *sc);
+
+DEFINE_FREE(sdxi_completion, struct sdxi_completion *, if (_T) sdxi_completion_free(_T))
+
+#endif /* DMA_SDXI_COMPLETION_H */
diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
index cb1bed2f83f2..178161588bd0 100644
--- a/drivers/dma/sdxi/hw.h
+++ b/drivers/dma/sdxi/hw.h
@@ -125,6 +125,7 @@ static_assert(sizeof(struct sdxi_akey_ent) == 16);
 struct sdxi_cst_blk {
 	__le64 signal;
 	__le32 flags;
+#define SDXI_CST_BLK_ER_BIT BIT(31)
 	__u8 rsvd_0[20];
 } __packed;
 static_assert(sizeof(struct sdxi_cst_blk) == 32);

-- 
2.53.0



