Return-Path: <dmaengine+bounces-9966-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGMWMtX22GkYkQgAu9opvQ
	(envelope-from <dmaengine+bounces-9966-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 15:10:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B293D7F7A
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 15:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83C3330570DC
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 13:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965933A8730;
	Fri, 10 Apr 2026 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mj+dDl5T"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D69C3A6F0A;
	Fri, 10 Apr 2026 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775826470; cv=none; b=YaguefK5CB7AbYwm5Fw/48UEnqfAZlwYlUoxMg628ZYR6lo4/Ov3ZsfV64rusbAMLgGrg2Cjo7TDSyBdbpxANzr9e+0+Nv5QtEVC64orNlKnux7f75jEGIxtqIkVKn0/YKZyUtphPQEBabQs2uvlHKkC/W3CjEG4jisJ/ojC/5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775826470; c=relaxed/simple;
	bh=CwnH20nbnZeEx71kjJfqgW1Kkik5vXHnbnNTIzkpXZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dxFV59W2X3oVvV6D9601zBoK123HArRnaEhT4UUGVsfOjlvyaN6Lv5JUjZNWEhGvud5w7Voy8yC+1OwHVeQ+Pc2g9sM05pUP+CRZWxjnkM2HcoY/btLbHG/QGLLDRI4J4qCyOHiHrvmN8izDgKyYD3c0b1i5rkim/RMkY7vx2Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mj+dDl5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BFF7C2BCAF;
	Fri, 10 Apr 2026 13:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775826470;
	bh=CwnH20nbnZeEx71kjJfqgW1Kkik5vXHnbnNTIzkpXZ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Mj+dDl5TBDivPfUpl6elvcmNetF4UKH2FqDtF+qABbocSH5Gyx+bfFftG2amuNfn6
	 zEqJQNJVYD1zAS0575K5p55jIzEC3Fgvgnoa1+fov5KtqNe1h5Z3ufuOt/3ozOkcNT
	 FG/o6vHy9ne7iRGwzRETWYQVtNvH3eyRIObAAVZEjDfliP3h/CHfy0UDzC4+19BOOG
	 2+kzI4JWeTJ3Qif4wwlNfD2OHZsnjiMgnExZgmtA9PHa60EOYvvUFQDgCu92YSiLFj
	 adE7sCQdAzzpd36ocEAL7UODFhAMkvKkwokRjTiEz50vzoohpY0qX88i5f6XrZCcko
	 PV42hzeseWD1A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F83CF44858;
	Fri, 10 Apr 2026 13:07:50 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 10 Apr 2026 08:07:21 -0500
Subject: [PATCH 11/23] dmaengine: sdxi: Add client context alloc and
 release APIs
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-sdxi-base-v1-11-1d184cb5c60a@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775826467; l=7502;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=L09ifU2t1M66vemGzv844gf5trJUsLLPkMvoKJ9/BWU=;
 b=1wnV9tnj4bjG+TusTQcZRbOfOcwafacenADlcgVb9vf+dMBelEbNHJutiK8mBDq5FrgtayL7e
 ee9XuJBASLiANTLPt64q12nZrouPjHd6BC0fpsloQuUxvtXK3JyRrYk
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
	TAGGED_FROM(0.00)[bounces-9966-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
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
X-Rspamd-Queue-Id: 34B293D7F7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Nathan Lynch <nathan.lynch@amd.com>

Expose sdxi_cxt_new() and sdxi_cxt_exit(), which are the rest of the
driver's entry points to creating and releasing SDXI contexts.

Track client contexts in a device-wide allocating xarray, mapping
context ID to the context object. The admin context always has ID 0,
so begin allocations at 1. Define a local class for ID allocation to
facilitate automatic release of an ID if an error is encountered when
"publishing" a context to the L1 table.

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
 drivers/dma/sdxi/context.c | 111 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/context.h |  13 ++++++
 drivers/dma/sdxi/device.c  |   8 ++++
 drivers/dma/sdxi/sdxi.h    |   2 +
 4 files changed, 134 insertions(+)

diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
index 934c487b4774..7cae140c0a20 100644
--- a/drivers/dma/sdxi/context.c
+++ b/drivers/dma/sdxi/context.c
@@ -155,6 +155,16 @@ static int configure_cxt_ctl(struct sdxi_cxt_ctl *ctl, const struct sdxi_cxt_ctl
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
@@ -209,6 +219,16 @@ static int configure_L1_entry(struct sdxi_cxt_L1_ent *ent,
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
@@ -259,6 +279,17 @@ static int sdxi_publish_cxt(const struct sdxi_cxt *cxt)
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
 void sdxi_cxt_push_doorbell(struct sdxi_cxt *cxt, u64 index)
 {
 	/* Ensure preceding write index increment is visible. */
@@ -266,6 +297,61 @@ void sdxi_cxt_push_doorbell(struct sdxi_cxt *cxt, u64 index)
 	iowrite64(index, cxt->db);
 }
 
+/* Enable automatic cleanup of an allocated context ID */
+struct __class_sdxi_cxt_id {
+	struct sdxi_dev *sdxi;
+	s32 id;
+};
+
+#define sdxi_cxt_id_null ((struct __class_sdxi_cxt_id){ NULL, -1 })
+#define take_sdxi_cxt_id(x) __get_and_null(x, sdxi_cxt_id_null)
+
+DEFINE_CLASS(sdxi_alloc_cxt_id, struct __class_sdxi_cxt_id,
+	if (_T.id >= 0)
+		xa_erase(&_T.sdxi->client_cxts, _T.id),
+	((struct __class_sdxi_cxt_id){
+		.sdxi = sdxi,
+		.id = ({
+			struct xa_limit limit = XA_LIMIT(1, sdxi->max_cxtid);
+			u32 id;
+			int err = xa_alloc(&sdxi->client_cxts, &id, cxt,
+					   limit, GFP_KERNEL);
+			err ? err : id;
+		}),
+	}),
+	struct sdxi_dev *sdxi, struct sdxi_cxt *cxt)
+
+/*
+ * Allocate the context ID; link the context back to the device;
+ * perform some final initialization of the context based on the ID
+ * allocated; update the context tables.
+ */
+static int register_cxt(struct sdxi_dev *sdxi, struct sdxi_cxt *cxt)
+{
+	int err;
+
+	CLASS(sdxi_alloc_cxt_id, slot)(sdxi, cxt);
+	if (slot.id < 0)
+		return slot.id;
+
+	cxt->sdxi = sdxi;
+	cxt->id = slot.id;
+	cxt->db = sdxi->dbs + slot.id * sdxi->db_stride;
+
+	err = sdxi_publish_cxt(cxt);
+	if (err)
+		return err;
+
+	take_sdxi_cxt_id(slot);
+	return 0;
+}
+
+static void unregister_cxt(struct sdxi_cxt *cxt)
+{
+	sdxi_rescind_cxt(cxt);
+	xa_erase(&cxt->sdxi->client_cxts, cxt->id);
+}
+
 static void free_admin_cxt(void *ptr)
 {
 	struct sdxi_dev *sdxi = ptr;
@@ -296,3 +382,28 @@ int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
 
 	return devm_add_action_or_reset(sdxi_to_dev(sdxi), free_admin_cxt, sdxi);
 }
+
+/*
+ * Allocate a context for in-kernel use. Starting the context is the
+ * caller's responsibility.
+ */
+struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi)
+{
+	struct sdxi_cxt *cxt __free(sdxi_cxt) = sdxi_alloc_cxt(sdxi);
+	if (!cxt)
+		return NULL;
+
+	if (register_cxt(sdxi, cxt))
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
+	unregister_cxt(cxt);
+	sdxi_free_cxt(cxt);
+}
diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
index c34acd730acb..5cd78e883c8d 100644
--- a/drivers/dma/sdxi/context.h
+++ b/drivers/dma/sdxi/context.h
@@ -58,6 +58,19 @@ struct sdxi_cxt {
 
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
 void sdxi_cxt_push_doorbell(struct sdxi_cxt *cxt, u64 index);
 
 #endif /* DMA_SDXI_CONTEXT_H */
diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index 15f61d1ce490..aaff6b15325a 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -12,6 +12,7 @@
 #include <linux/dmapool.h>
 #include <linux/log2.h>
 #include <linux/slab.h>
+#include <linux/xarray.h>
 
 #include "context.h"
 #include "hw.h"
@@ -302,6 +303,7 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 
 	sdxi->dev = dev;
 	sdxi->bus_ops = ops;
+	xa_init_flags(&sdxi->client_cxts, XA_FLAGS_ALLOC1);
 	dev_set_drvdata(dev, sdxi);
 
 	err = sdxi->bus_ops->init(sdxi);
@@ -314,6 +316,12 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
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
index 426101875334..da33719735ab 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -12,6 +12,7 @@
 #include <linux/dev_printk.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/types.h>
+#include <linux/xarray.h>
 
 #include "mmio.h"
 
@@ -61,6 +62,7 @@ struct sdxi_dev {
 	struct dma_pool *cst_blk_pool;
 
 	struct sdxi_cxt *admin_cxt;
+	struct xarray client_cxts; /* context id -> (struct sdxi_cxt *) */
 
 	const struct sdxi_bus_ops *bus_ops;
 };

-- 
2.53.0



