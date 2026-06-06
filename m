Return-Path: <dmaengine+bounces-11230-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /2gSOphjI2rcsAEAu9opvQ
	(envelope-from <dmaengine+bounces-11230-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:02:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1673E64BE55
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:02:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=oTYXx4eD;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11230-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11230-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E61803017CED
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2026 00:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3609C214204;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D61155757;
	Sat,  6 Jun 2026 00:02:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780704143; cv=none; b=B4u4PmesMhI72Tytwshr8lpxsQVdD3tPMg8cIyA7Tx+wOUc0OUbbWx0wshgLq8K/xrznFTZeacRCK6KqjUx7ZLX4VQ1LcRdneQbsknVq+Hr6YeZXPDCupkmOSdBtfQ9KQRatA7fiBlzNMgYJ+p3bx1R5Z5GHm5PzRAth3IFZ2M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780704143; c=relaxed/simple;
	bh=kraf85ZUwOLQ1KSQQioSLX8q4CoMjnXQdR9OB/u06BM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GCvk7oKSaxEujOLzRjrf1jy6nQMlLsYEXD+tN8jmvCDomAPwX1g66C4Fwu6jn6JBXJvdEDENZJPkPOIOjM0dEA5KJmC8vHeVAWR9PYRMSFdol8bplS+W2NayGikGbFdlGkzuwT6nymHXEaiEMMDP+gSJANHUXZy/uxAVIiQAZjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTYXx4eD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AED54C2BCF6;
	Sat,  6 Jun 2026 00:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780704142;
	bh=kraf85ZUwOLQ1KSQQioSLX8q4CoMjnXQdR9OB/u06BM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oTYXx4eDfswVmXaby8o5ok27jk5qtOMRNJEjVRF8T+Wlb0T5ozfj6SwJ217VxZCp6
	 Ei/EDuNzc0JrjEWSU0wsGzUgB6SdmeDX1wxDEcBlr6pIupCz0s9KUtWbcM88YXPoNb
	 MTyBFHMoQ7Zd+AmjLZRUsvVPkKERDNjjpCIV2mhL0P1lPEE9fxNGeYwcFEOZ/+1/4I
	 0529gShPFbRwOKj/HIVxexpzMuAzwvN9A6gxR2l6bIjEQbH7KAodneNw8HXr06ZvF8
	 ipZulTUY/8OHDzFB4RAdpF6uJKdeJmfxN9wRNRKWWMXMa14dmL+JDsPe4zkSZgPNLq
	 FTgBfFKMZ6Lkg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A75CD6E7B;
	Sat,  6 Jun 2026 00:02:22 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 05 Jun 2026 19:02:10 -0500
Subject: [PATCH v3 07/23] dmaengine: sdxi: Allocate administrative context
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-sdxi-base-v3-7-4d38ca2bdffe@amd.com>
References: <20260605-sdxi-base-v3-0-4d38ca2bdffe@amd.com>
In-Reply-To: <20260605-sdxi-base-v3-0-4d38ca2bdffe@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 David Rientjes <rientjes@google.com>, John.Kariuki@amd.com, 
 Jonathan Cameron <jic23@kernel.org>, Kinsey Ho <kinseyho@google.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 PradeepVineshReddy.Kodamati@amd.com, Shivank Garg <shivankg@amd.com>, 
 Stephen Bates <Stephen.Bates@amd.com>, Tycho Andersen <tycho@kernel.org>, 
 Wei Huang <wei.huang2@amd.com>, Wei Xu <weixugc@google.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780704140; l=9183;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=pO1tBUN47TwpUNMIsAV28iMvmtfvg1vVtjUFD1Ue9T0=;
 b=wJKaeR8gJdi6k2e4kU+z+gHsTEPm8yTiEf3Kps8iux57D9d8Rd+urc8RFkBYb/ySYKwyRehj5
 S9YaZORP8+TBfkhsL/i74IrhcaVnrwDblyYGZaEVsDrXGTKbGBa1j6i
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11230-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:bhelgaas@google.com,m:rientjes@google.com,m:John.Kariuki@amd.com,m:jic23@kernel.org,m:kinseyho@google.com,m:mario.limonciello@amd.com,m:PradeepVineshReddy.Kodamati@amd.com,m:shivankg@amd.com,m:Stephen.Bates@amd.com,m:tycho@kernel.org,m:wei.huang2@amd.com,m:weixugc@google.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:Frank.Li@nxp.com,m:nathan.lynch@amd.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[nathan.lynch@amd.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:mid,amd.com:email,amd.com:replyto,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1673E64BE55

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
index 0006edf74d86..cdf8a455077b 100644
--- a/drivers/dma/sdxi/Makefile
+++ b/drivers/dma/sdxi/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_SDXI_CORE) += sdxi-core.o
-sdxi-core-y := device.o
+sdxi-core-y := \
+	context.o     \
+	device.o
 
 obj-$(CONFIG_SDXI_PCI) += sdxi-pci.o
 sdxi-pci-y := pci.o
diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
new file mode 100644
index 000000000000..443c231303af
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
+	if (!cxt->cxt_ctl)
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
index 7aa62a989bac..4d595e79b8ce 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/time.h>
 
+#include "context.h"
 #include "hw.h"
 #include "mmio.h"
 #include "sdxi.h"
@@ -218,6 +219,16 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
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
index b3fd3587ccf8..55d63d50a01b 100644
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
 } __packed __aligned(16);
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
+} __packed __aligned(16);
+static_assert(sizeof(struct sdxi_akey_ent) == 16);
+
 /* SDXI 1.0 Table 6-4: CST_BLK (Completion Status Block) */
 struct sdxi_cst_blk {
 	__le64 signal;
@@ -86,4 +114,19 @@ struct sdxi_cst_blk {
 } __packed __aligned(32);
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
+} __packed __aligned(64);
+static_assert(sizeof(struct sdxi_desc) == 64);
+
 #endif /* DMA_SDXI_HW_H */
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index ade702b6bec5..f5e0cd986b9e 100644
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



