Return-Path: <dmaengine+bounces-10312-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKCPAV4rAmq/ogEAu9opvQ
	(envelope-from <dmaengine+bounces-10312-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:17:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D33514F71
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67FC93049291
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 19:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391374D8D94;
	Mon, 11 May 2026 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hY/LRG1r"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135BC4D2EFE;
	Mon, 11 May 2026 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778526998; cv=none; b=qKwaAhXj6Laf30Ygm4tO62P3aZD/Q9BNS1cFFlLddz1pXhhDlBZj7zOUlha9PjbEVDWLRWZPVpYOkEEDcN+Uq4qc8usIborJACqnzckd5ryR8M5kflkK/7E6FYCfejrUKSWB+jc4i7ZrOGJnsFZca03TTw4OfP3EqzcEa6lNxYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778526998; c=relaxed/simple;
	bh=OeCVQsV5hiu5LI8vf1K1udE2KzjPKtpUftBTiUp7HTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W6VDPFgjEV5MPDckcLZyT+TvqKXaAyh4SH24yP//TeqGiiLH/bXil/Y65DVaTSYaPSzfvahq/KugNFX6WcEoQZUEVzTc9iU5LGxO0tf4xKPXHCwekVGm0XfVl5oBlXGF7kbBw94JpXzZNf2FzRV2jp4omoVAU9tRdAotKq94tpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hY/LRG1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E071FC4AF0C;
	Mon, 11 May 2026 19:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778526997;
	bh=OeCVQsV5hiu5LI8vf1K1udE2KzjPKtpUftBTiUp7HTU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hY/LRG1rSvPRJlLVBwXbppTpzmJfjc9UUD8/FnuLHMTXwaCq8ZTUwUbvZ3C2TQBA7
	 1WpYuUv/ptk62uTM4SUQbg+Wmd1LJgqphuzv8Ds+ER0+BtgeCaEff6LY0NWIHVx68k
	 O3ORAOnbphDKnN7VQR4ob+Ib6f2lXYn2/d4DWMS6mk3amiy9FsAvIARNIPRx01pEIJ
	 aXI3bPyWnQT9WlERD5jUsaaQorZOUVGKYF11ko20Oy5kYJ+KjTloozsxfCCSSRcgVK
	 7pr2iI83YWxAvFoUPlMP8btSqqFv/PH/oePfMvQ0rd0Uoe5nnjSi7SHdr1SNWxDKtd
	 8gqABBdQzeSNg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F48CD4840;
	Mon, 11 May 2026 19:16:37 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Mon, 11 May 2026 14:16:23 -0500
Subject: [PATCH v2 11/23] dmaengine: sdxi: Add client context alloc and
 release APIs
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-sdxi-base-v2-11-889cfed17e3f@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778526994; l=7937;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=VjGJJnutoIQBzqsUQGWQ33TreaYKPWyLs/IDOcXPrp8=;
 b=qFqIfPrdinaFVKsG2COdP5+uxfBDd/0Zru/4vojw3xUi5j8hAExWYU+/TDQW3979TVp924INf
 dByxOAxq740Do+YWTBhxaweagZ/MmXL/o9MSweTe9wpmfab0GxFc+wt
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
X-Rspamd-Queue-Id: A3D33514F71
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10312-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
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

Expose sdxi_cxt_new() and sdxi_cxt_exit(), which are the rest of the
driver's entry points to creating and releasing SDXI contexts.

Track client contexts in a device-wide allocating xarray, mapping
context ID to the context object. The admin context always has ID 0,
so begin allocations at 1. Define a local sdxi_cxt_id class to
facilitate early allocation (before committing more resources) and
automatic release of context IDs.

Introduce new code to invalidate a context's entry in the L1 table on
deallocation.

Support for starting and stopping contexts will be added in changes to
follow.

The only expected user of sdxi_cxt_new() and sdxi_cxt_exit() at this
point is the DMA engine provider code where a client context per
channel will be created.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/context.c | 122 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/context.h |  13 +++++
 drivers/dma/sdxi/device.c  |   8 +++
 drivers/dma/sdxi/sdxi.h    |   2 +
 4 files changed, 145 insertions(+)

diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
index c0b55c945cc4..c0b294836ede 100644
--- a/drivers/dma/sdxi/context.c
+++ b/drivers/dma/sdxi/context.c
@@ -44,6 +44,10 @@ static void sdxi_free_cxt(struct sdxi_cxt *cxt)
 	struct sdxi_dev *sdxi = cxt->sdxi;
 	struct sdxi_sq *sq = cxt->sq;
 
+	/* Release the id if this is a client context. */
+	if (cxt->id)
+		WARN_ON(xa_erase(&sdxi->client_cxts, cxt->id) != cxt);
+
 	if (cxt->cxt_ctl)
 		dma_pool_free(sdxi->cxt_ctl_pool, cxt->cxt_ctl,
 			      cxt->cxt_ctl_dma);
@@ -154,6 +158,16 @@ static int configure_cxt_ctl(struct sdxi_cxt_ctl *ctl, const struct sdxi_cxt_ctl
 	return 0;
 }
 
+static void invalidate_cxtl_ctl(struct sdxi_cxt_ctl *ctl)
+{
+	u64 ds_ring_ptr = le64_to_cpu(ctl->ds_ring_ptr);
+
+	FIELD_MODIFY(SDXI_CXT_CTL_VL, &ds_ring_ptr, 0);
+	WRITE_ONCE(ctl->ds_ring_ptr, cpu_to_le64(ds_ring_ptr));
+	dma_wmb();
+	*ctl = (typeof(*ctl)) { 0 };
+}
+
 /*
  * Logical representation of CXT_L1_ENT subfields.
  */
@@ -208,6 +222,16 @@ static int configure_L1_entry(struct sdxi_cxt_L1_ent *ent,
 	return 0;
 }
 
+static void invalidate_L1_entry(struct sdxi_cxt_L1_ent *ent)
+{
+	u64 cxt_ctl_ptr = le64_to_cpu(ent->cxt_ctl_ptr);
+
+	FIELD_MODIFY(SDXI_CXT_L1_ENT_VL, &cxt_ctl_ptr, 0);
+	WRITE_ONCE(ent->cxt_ctl_ptr, cpu_to_le64(cxt_ctl_ptr));
+	dma_wmb();
+	*ent = (typeof(*ent)) { 0 };
+}
+
 /*
  * Make the context control structure hierarchy valid from the POV of
  * the SDXI implementation. This may eventually involve allocation of
@@ -258,6 +282,17 @@ static int sdxi_publish_cxt(const struct sdxi_cxt *cxt)
 	/* todo: need to send DSC_CXT_UPD to admin */
 }
 
+/* Invalidate a context. */
+static void sdxi_rescind_cxt(struct sdxi_cxt *cxt)
+{
+	u8 l1_idx = ID_TO_L1_INDEX(cxt->id);
+	struct sdxi_cxt_L1_ent *ent = &cxt->sdxi->L1_table->entry[l1_idx];
+
+	invalidate_L1_entry(ent);
+	invalidate_cxtl_ctl(cxt->cxt_ctl);
+	/* todo: need to send DSC_CXT_UPD to admin */
+}
+
 static void free_admin_cxt(void *ptr)
 {
 	struct sdxi_dev *sdxi = ptr;
@@ -288,3 +323,90 @@ int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
 
 	return devm_add_action_or_reset(sdxi->dev, free_admin_cxt, sdxi);
 }
+
+/*
+ * Temporary owner for context id until it can be assigned to a
+ * context object; enables scope-based cleanup.
+ */
+struct sdxi_cxt_id {
+	struct sdxi_dev *sdxi;
+	u16 index;
+};
+
+static void sdxi_cxt_id_dtor(const struct sdxi_cxt_id *cxt_id)
+{
+	if (cxt_id->index == 0)
+		return;
+	WARN_ON(xa_erase(&cxt_id->sdxi->client_cxts, cxt_id->index) != NULL);
+}
+
+static struct sdxi_cxt_id sdxi_cxt_id_ctor(struct sdxi_dev *sdxi)
+{
+	struct xa_limit limit = XA_LIMIT(1, sdxi->max_cxtid);
+	u32 index;
+
+	return (struct sdxi_cxt_id) {
+		.sdxi = sdxi,
+		.index = xa_alloc(&sdxi->client_cxts, &index, NULL,
+				  limit, GFP_KERNEL) ? 0 : (u16)index,
+	};
+}
+
+DEFINE_CLASS(sdxi_cxt_id, struct sdxi_cxt_id, sdxi_cxt_id_dtor(&_T),
+	     sdxi_cxt_id_ctor(sdxi), struct sdxi_dev *sdxi)
+
+static bool sdxi_cxt_id_valid(const struct sdxi_cxt_id *cxt_id)
+{
+	return cxt_id->index > 0;
+}
+
+/*
+ * Transfer ownership of the id to the context object, recording the
+ * context pointer in the device's client_cxt xarray. sdxi_cxt_free()
+ * is responsible for releasing the id from now on.
+ */
+static void sdxi_cxt_id_assign(struct sdxi_cxt *cxt, struct sdxi_cxt_id *cxt_id)
+{
+	/* We reserved the space in the constructor so this should not fail. */
+	WARN_ON(xa_store(&cxt_id->sdxi->client_cxts,
+			 cxt_id->index, cxt, GFP_KERNEL));
+	cxt->id = cxt_id->index;
+	cxt_id->index = 0;
+}
+
+/*
+ * Allocate a context for in-kernel use. Starting the context is the
+ * caller's responsibility.
+ */
+struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi)
+{
+	/*
+	 * Ensure an ID is available before allocating memory for the
+	 * context and its control structures.
+	 */
+	CLASS(sdxi_cxt_id, id)(sdxi);
+	if (!sdxi_cxt_id_valid(&id))
+		return NULL;
+
+	struct sdxi_cxt *cxt __free(sdxi_cxt) = sdxi_alloc_cxt(sdxi);
+	if (!cxt)
+		return NULL;
+
+	sdxi_cxt_id_assign(cxt, &id);
+
+	cxt->db = sdxi->dbs + cxt->id * sdxi->db_stride;
+
+	if (sdxi_publish_cxt(cxt))
+		return NULL;
+
+	return_ptr(cxt);
+}
+
+void sdxi_cxt_exit(struct sdxi_cxt *cxt)
+{
+	if (WARN_ON(sdxi_cxt_is_admin(cxt)))
+		return;
+
+	sdxi_rescind_cxt(cxt);
+	sdxi_free_cxt(cxt);
+}
diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
index 8dd6beb7a642..b422a04ae4db 100644
--- a/drivers/dma/sdxi/context.h
+++ b/drivers/dma/sdxi/context.h
@@ -59,6 +59,19 @@ struct sdxi_cxt {
 
 int sdxi_admin_cxt_init(struct sdxi_dev *sdxi);
 
+struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi);
+void sdxi_cxt_exit(struct sdxi_cxt *cxt);
+
+static inline struct sdxi_cxt *to_admin_cxt(const struct sdxi_cxt *cxt)
+{
+	return cxt->sdxi->admin_cxt;
+}
+
+static inline bool sdxi_cxt_is_admin(const struct sdxi_cxt *cxt)
+{
+	return cxt == to_admin_cxt(cxt);
+}
+
 static inline void sdxi_cxt_push_doorbell(struct sdxi_cxt *cxt, u64 index)
 {
 	iowrite64(index, cxt->db);
diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index 8e621875b10b..cc289b271ae2 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -17,6 +17,7 @@
 #include <linux/minmax.h>
 #include <linux/slab.h>
 #include <linux/time.h>
+#include <linux/xarray.h>
 
 #include "context.h"
 #include "hw.h"
@@ -326,6 +327,7 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 
 	sdxi->dev = dev;
 	sdxi->bus_ops = ops;
+	xa_init_flags(&sdxi->client_cxts, XA_FLAGS_ALLOC1);
 	dev_set_drvdata(dev, sdxi);
 
 	err = sdxi->bus_ops->init(sdxi);
@@ -338,6 +340,12 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 void sdxi_unregister(struct device *dev)
 {
 	struct sdxi_dev *sdxi = dev_get_drvdata(dev);
+	struct sdxi_cxt *cxt;
+	unsigned long index;
+
+	xa_for_each(&sdxi->client_cxts, index, cxt)
+		sdxi_cxt_exit(cxt);
+	xa_destroy(&sdxi->client_cxts);
 
 	sdxi_dev_stop(sdxi);
 }
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index 7462fb912dc6..1786da7642cc 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -12,6 +12,7 @@
 #include <linux/dev_printk.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/types.h>
+#include <linux/xarray.h>
 
 #include "mmio.h"
 
@@ -59,6 +60,7 @@ struct sdxi_dev {
 	struct dma_pool *cst_blk_pool;
 
 	struct sdxi_cxt *admin_cxt;
+	struct xarray client_cxts; /* context id -> (struct sdxi_cxt *) */
 
 	const struct sdxi_bus_ops *bus_ops;
 };

-- 
2.54.0



