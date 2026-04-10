Return-Path: <dmaengine+bounces-9963-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJO8I7n22GkYkQgAu9opvQ
	(envelope-from <dmaengine+bounces-9963-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 15:10:17 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC43F3D7F29
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 15:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78392303FFB6
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 13:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE763A1A22;
	Fri, 10 Apr 2026 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l28k8Jt4"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24780345740;
	Fri, 10 Apr 2026 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775826470; cv=none; b=lJbPRvYxSSk0RY1z4zXEXyftugs9qfPbAp46MfbqF70GDBEICpSnVa9cy65jwXpC4f6YJtVbmfSQc0815Bz4uQCIuoP79y0T0aqqdrn070swkIZf+gsZI+iXkeO1k87hT1ZLy9FrsgB5nKv8rpmzpJEZqMuw/vM95ZBzoQ0Eigk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775826470; c=relaxed/simple;
	bh=o4CczMmB0uKw2Q7FShkkYeYEWX3YJgkcsAuiDHhXLlI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JFPW1+Zosw0ep1wPREBX023n5wfD/tCLnlpNp5xviPjkLsNVp/880+uIweiSBzr8ReF+Xt9ptXtvi/5Y3W+t1zaSw1cTinbDqdwDN6YITZF3dv24q8LEj2tH9jma6tfgqOnVqV48fkGZbymbDhDDwP276XwD7n8huwks4KjNgdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l28k8Jt4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03614C19421;
	Fri, 10 Apr 2026 13:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775826470;
	bh=o4CczMmB0uKw2Q7FShkkYeYEWX3YJgkcsAuiDHhXLlI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=l28k8Jt4Y2ipiMNUG7Q8Iu86FeEe6gztmzl60938flEY0vjqcX0bAE9+lzWGnvVGj
	 8TMrwW1W330jujvQt5EjK7GOXEz8HOjqLhiOcxexO5gYkWlpkrchWFxYiAgr2fhXqD
	 76K73t1PKoqwkVHD65cZJm4i67A1BJxjU9K1zl+ADMWXcRT5sVBb8bzY6f1/EJr17f
	 mnG3Q5mS8my+mo4m/jEJ9DYlS1Rge7i2qjtblkxuQ7v9FQgpm9pp1OeRjt+ImcZFme
	 DahLtqSheqQ+OPtoyCujZXk/uJQAHz9/MQ4RVs2tetwzbSna+E7HLgY1fhgK7v1qbg
	 1PSNtnlMMuiWg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F078FF4485D;
	Fri, 10 Apr 2026 13:07:49 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 10 Apr 2026 08:07:18 -0500
Subject: [PATCH 08/23] dmaengine: sdxi: Install administrative context
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-sdxi-base-v1-8-1d184cb5c60a@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775826467; l=9127;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=/Fx8iXeI3HhobtRV06Z9oEZi8ZGsAE/ooN/wWY95pT4=;
 b=I+EfpuSbb6B3BwWS4qy9I1U0djZdk/TtIBgr8BNLJ7nq3Vq2T6NwRkd+KhgzujLvaEMpcxouo
 gIOsRq/j1YlAg5LKpf44DxX67HFzjrcYC/nDKTDWcYUIq/tX3gp9p6u
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9963-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
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
X-Rspamd-Queue-Id: DC43F3D7F29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Nathan Lynch <nathan.lynch@amd.com>

Serialize the context control block, akey table, and L1 entry for the
admin context, making its descriptor ring, write index, and context
status block visible to the SDXI implementation once it is activated.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/context.c | 162 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/context.h |   7 ++
 drivers/dma/sdxi/hw.h      |  15 +++++
 drivers/dma/sdxi/sdxi.h    |   9 +++
 4 files changed, 193 insertions(+)

diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
index 0a6821992776..097d871e530f 100644
--- a/drivers/dma/sdxi/context.c
+++ b/drivers/dma/sdxi/context.c
@@ -7,16 +7,22 @@
 
 #define pr_fmt(fmt)     "SDXI: " fmt
 
+#include <linux/align.h>
+#include <linux/bitfield.h>
 #include <linux/bug.h>
 #include <linux/cleanup.h>
 #include <linux/device/devres.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
 #include <linux/errno.h>
+#include <linux/iommu.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <asm/barrier.h>
+#include <asm/rwonce.h>
 
 #include "context.h"
+#include "hw.h"
 #include "sdxi.h"
 
 #define DEFAULT_DESC_RING_ENTRIES 1024
@@ -106,6 +112,152 @@ static struct sdxi_cxt *sdxi_alloc_cxt(struct sdxi_dev *sdxi)
 	return_ptr(cxt);
 }
 
+struct sdxi_cxt_ctl_cfg {
+	dma_addr_t ds_ring_ptr;
+	dma_addr_t cxt_sts_ptr;
+	dma_addr_t write_index_ptr;
+	u32 ds_ring_sz;
+	u8 qos;
+	u8 csa;
+	bool se;
+};
+
+static int configure_cxt_ctl(struct sdxi_cxt_ctl *ctl, const struct sdxi_cxt_ctl_cfg *cfg)
+{
+	u64 ds_ring_ptr, cxt_sts_ptr, write_index_ptr;
+
+	write_index_ptr = FIELD_PREP(SDXI_CXT_CTL_WRITE_INDEX_PTR,
+				     cfg->write_index_ptr >> WRT_INDEX_PTR_SHIFT);
+	cxt_sts_ptr = FIELD_PREP(SDXI_CXT_CTL_CXT_STS_PTR,
+				 cfg->cxt_sts_ptr >> CXT_STATUS_PTR_SHIFT);
+
+	*ctl = (typeof(*ctl)) {
+		/*
+		 * ds_ring_ptr contains the validity bit and is updated
+		 * after a barrier is issued.
+		 */
+		.ds_ring_sz      = cpu_to_le32(cfg->ds_ring_sz),
+		.cxt_sts_ptr     = cpu_to_le64(cxt_sts_ptr),
+		.write_index_ptr = cpu_to_le64(write_index_ptr),
+	};
+
+	ds_ring_ptr = FIELD_PREP(SDXI_CXT_CTL_VL, 1) |
+		FIELD_PREP(SDXI_CXT_CTL_QOS, cfg->qos) |
+		FIELD_PREP(SDXI_CXT_CTL_SE, cfg->se) |
+		FIELD_PREP(SDXI_CXT_CTL_CSA, cfg->csa) |
+		FIELD_PREP(SDXI_CXT_CTL_DS_RING_PTR,
+			   cfg->ds_ring_ptr >> DESC_RING_BASE_PTR_SHIFT);
+	/* Ensure other fields are visible before hw sees vl=1. */
+	dma_wmb();
+	WRITE_ONCE(ctl->ds_ring_ptr, cpu_to_le64(ds_ring_ptr));
+
+	return 0;
+}
+
+/*
+ * Logical representation of CXT_L1_ENT subfields.
+ */
+struct sdxi_cxt_L1_cfg {
+	dma_addr_t cxt_ctl_ptr;
+	dma_addr_t akey_ptr;
+	u32 cxt_pasid;
+	u32 opb_000_enb;
+	u16 max_buffer;
+	u8 akey_sz;
+	bool ka;
+	bool pv;
+};
+
+static int configure_L1_entry(struct sdxi_cxt_L1_ent *ent,
+			      const struct sdxi_cxt_L1_cfg *cfg)
+{
+	u64 cxt_ctl_ptr, akey_ptr;
+	u32 misc0;
+
+	if (WARN_ON_ONCE(!IS_ALIGNED(cfg->cxt_ctl_ptr, SZ_64)))
+		return -EFAULT;
+	if (WARN_ON_ONCE(!IS_ALIGNED(cfg->akey_ptr, SZ_4K)))
+		return -EFAULT;
+
+	akey_ptr = FIELD_PREP(SDXI_CXT_L1_ENT_AKEY_SZ, cfg->akey_sz) |
+		FIELD_PREP(SDXI_CXT_L1_ENT_AKEY_PTR,
+			   cfg->akey_ptr >> L1_CXT_AKEY_PTR_SHIFT);
+
+	misc0 = FIELD_PREP(SDXI_CXT_L1_ENT_PASID, cfg->cxt_pasid) |
+		FIELD_PREP(SDXI_CXT_L1_ENT_MAX_BUFFER, cfg->max_buffer);
+
+	*ent = (typeof(*ent)) {
+		/*
+		 * cxt_ctl_ptr contains the validity bit and is
+		 * updated after a barrier is issued.
+		 */
+		.akey_ptr    = cpu_to_le64(akey_ptr),
+		.misc0       = cpu_to_le32(misc0),
+		.opb_000_enb = cpu_to_le32(cfg->opb_000_enb),
+	};
+
+	cxt_ctl_ptr = FIELD_PREP(SDXI_CXT_L1_ENT_VL, 1) |
+		FIELD_PREP(SDXI_CXT_L1_ENT_KA, cfg->ka) |
+		FIELD_PREP(SDXI_CXT_L1_ENT_PV, cfg->pv) |
+		FIELD_PREP(SDXI_CXT_L1_ENT_CXT_CTL_PTR,
+			   cfg->cxt_ctl_ptr >> L1_CXT_CTRL_PTR_SHIFT);
+	/* Ensure other fields are visible before hw sees vl=1. */
+	dma_wmb();
+	WRITE_ONCE(ent->cxt_ctl_ptr, cpu_to_le64(cxt_ctl_ptr));
+
+	return 0;
+}
+
+/*
+ * Make the context control structure hierarchy valid from the POV of
+ * the SDXI implementation. This may eventually involve allocation of
+ * a L1 table page, so it needs to be fallible.
+ */
+static int sdxi_publish_cxt(const struct sdxi_cxt *cxt)
+{
+	struct sdxi_cxt_ctl_cfg ctl_cfg;
+	struct sdxi_cxt_L1_cfg L1_cfg;
+	struct sdxi_cxt_L1_ent *ent;
+	u8 l1_idx;
+	int err;
+
+	if (WARN_ONCE(cxt->id > cxt->sdxi->max_cxtid,
+		      "can't install cxt with id %u (limit %u)",
+		      cxt->id, cxt->sdxi->max_cxtid))
+		return -EINVAL;
+
+	ctl_cfg = (typeof(ctl_cfg)) {
+		.se              = 1,
+		.csa             = 1,
+		.ds_ring_ptr     = cxt->sq->ring_dma,
+		.ds_ring_sz      = cxt->sq->ring_size >> 6,
+		.cxt_sts_ptr     = cxt->sq->cxt_sts_dma,
+		.write_index_ptr = cxt->sq->write_index_dma,
+	};
+
+	err = configure_cxt_ctl(cxt->cxt_ctl, &ctl_cfg);
+	if (err)
+		return err;
+
+	l1_idx = ID_TO_L1_INDEX(cxt->id);
+
+	ent = &cxt->sdxi->L1_table->entry[l1_idx];
+
+	L1_cfg = (typeof(L1_cfg)) {
+		.ka          = 1,
+		.pv          = 0,
+		.cxt_ctl_ptr = cxt->cxt_ctl_dma,
+		.akey_sz     = akey_table_order(cxt->akey_table),
+		.akey_ptr    = cxt->akey_table_dma,
+		.cxt_pasid   = IOMMU_NO_PASID,
+		.max_buffer  = 11, /* 4GB */
+		.opb_000_enb = cxt->sdxi->op_grp_cap,
+	};
+
+	return configure_L1_entry(ent, &L1_cfg);
+	/* todo: need to send DSC_CXT_UPD to admin */
+}
+
 static void free_admin_cxt(void *ptr)
 {
 	struct sdxi_dev *sdxi = ptr;
@@ -115,13 +267,23 @@ static void free_admin_cxt(void *ptr)
 
 int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
 {
+	int err;
+	struct sdxi_sq *sq;
+
 	struct sdxi_cxt *cxt __free(sdxi_cxt) = sdxi_alloc_cxt(sdxi);
 	if (!cxt)
 		return -ENOMEM;
 
+	sq = cxt->sq;
+	/* SDXI 1.0 4.1.8.4.b: Set CXT_STS.state to CXTV_RUN. */
+	sq->cxt_sts->state = FIELD_PREP(SDXI_CXT_STS_STATE, CXTV_RUN);
 	cxt->id = SDXI_ADMIN_CXT_ID;
 	cxt->db = sdxi->dbs + cxt->id * sdxi->db_stride;
 
+	err = sdxi_publish_cxt(cxt);
+	if (err)
+		return err;
+
 	sdxi->admin_cxt = no_free_ptr(cxt);
 
 	return devm_add_action_or_reset(sdxi_to_dev(sdxi), free_admin_cxt, sdxi);
diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
index 800b4ead1dd9..bbde1fd49af3 100644
--- a/drivers/dma/sdxi/context.h
+++ b/drivers/dma/sdxi/context.h
@@ -20,6 +20,13 @@ struct sdxi_akey_table {
 	struct sdxi_akey_ent entry[SZ_4K / sizeof(struct sdxi_akey_ent)];
 };
 
+/* For encoding the akey table size in CXT_L1_ENT's akey_sz. */
+static inline u8 akey_table_order(const struct sdxi_akey_table *tbl)
+{
+	static_assert(sizeof(*tbl) == SZ_4K);
+	return 0;
+}
+
 /* Submission Queue */
 struct sdxi_sq {
 	u32 ring_entries;
diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
index b66eb22f7f90..46424376f26f 100644
--- a/drivers/dma/sdxi/hw.h
+++ b/drivers/dma/sdxi/hw.h
@@ -45,8 +45,16 @@ static_assert(sizeof(struct sdxi_cxt_L2_table) == 4096);
 /* SDXI 1.0 Table 3-3: Context Level 1 Table Entry (CXT_L1_ENT) */
 struct sdxi_cxt_L1_ent {
 	__le64 cxt_ctl_ptr;
+#define SDXI_CXT_L1_ENT_VL             BIT_ULL(0)
+#define SDXI_CXT_L1_ENT_KA             BIT_ULL(1)
+#define SDXI_CXT_L1_ENT_PV             BIT_ULL(2)
+#define SDXI_CXT_L1_ENT_CXT_CTL_PTR    GENMASK_ULL(63, 6)
 	__le64 akey_ptr;
+#define SDXI_CXT_L1_ENT_AKEY_SZ        GENMASK_ULL(3, 0)
+#define SDXI_CXT_L1_ENT_AKEY_PTR       GENMASK_ULL(63, 12)
 	__le32 misc0;
+#define SDXI_CXT_L1_ENT_PASID          GENMASK(19, 0)
+#define SDXI_CXT_L1_ENT_MAX_BUFFER     GENMASK(23, 20)
 	__le32 opb_000_enb;
 	__u8 rsvd_0[8];
 } __packed;
@@ -62,10 +70,17 @@ static_assert(sizeof(struct sdxi_cxt_L1_table) == 4096);
 /* SDXI 1.0 Table 3-4: Context Control (CXT_CTL) */
 struct sdxi_cxt_ctl {
 	__le64 ds_ring_ptr;
+#define SDXI_CXT_CTL_VL             BIT_ULL(0)
+#define SDXI_CXT_CTL_QOS            GENMASK_ULL(3, 2)
+#define SDXI_CXT_CTL_SE             BIT_ULL(4)
+#define SDXI_CXT_CTL_CSA            BIT_ULL(5)
+#define SDXI_CXT_CTL_DS_RING_PTR    GENMASK_ULL(63, 6)
 	__le32 ds_ring_sz;
 	__u8 rsvd_0[4];
 	__le64 cxt_sts_ptr;
+#define SDXI_CXT_CTL_CXT_STS_PTR    GENMASK_ULL(63, 4)
 	__le64 write_index_ptr;
+#define SDXI_CXT_CTL_WRITE_INDEX_PTR GENMASK_ULL(63, 3)
 	__u8 rsvd_1[32];
 } __packed;
 static_assert(sizeof(struct sdxi_cxt_ctl) == 64);
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index 4ef893ae15f3..bbc14364a5c9 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -17,6 +17,15 @@
 
 #define SDXI_DRV_DESC		"SDXI driver"
 
+#define ID_TO_L1_INDEX(id)	((id) & 0x7F)
+
+#define DESC_RING_BASE_PTR_SHIFT	6
+#define CXT_STATUS_PTR_SHIFT		4
+#define WRT_INDEX_PTR_SHIFT		3
+
+#define L1_CXT_CTRL_PTR_SHIFT		6
+#define L1_CXT_AKEY_PTR_SHIFT		12
+
 struct sdxi_dev;
 
 /**

-- 
2.53.0



