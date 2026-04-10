Return-Path: <dmaengine+bounces-9962-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOQaKLv22GkYkQgAu9opvQ
	(envelope-from <dmaengine+bounces-9962-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 15:10:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F253D7F38
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 15:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF2183041A7E
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 13:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438D13932CA;
	Fri, 10 Apr 2026 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaKoNb8T"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A33B344031;
	Fri, 10 Apr 2026 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775826470; cv=none; b=I+zH34Q92z+w9BnSZftKj4wNKnmtUYpgJdpvWNlf2IHsN/Y3KDr/6m1cBPzdKOYdu+oJyNj2xzkl4JJbLIaJlXhZvx5Zq8F9U6H5n2sLf8jHjNgNuWLnFr9KrxqXzPS8kYIVHxyS7pFHk+sXXVe9foT9p8Mpl4xIYdMsIZbU55s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775826470; c=relaxed/simple;
	bh=hpysSDdkkiKhjp1o0gRPLKO/3dcD0MkxiD0l9bXNbKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t9p9MP3XcwgT71GX8gitOUtOV89kPOTIzX+22s14TKmbAyjTzdWEjG0mPuP1RqTZ9xy09t2sYMCkigunBHdPtmw0BYEW0/9m5IZ4O1cfiSVljuSFOGwsd/gyVgo35qYwtyaqRPaaKPS9ds0aDyJD3QwrE/zTclGpm8Ew3pp82Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaKoNb8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6646C2BCB2;
	Fri, 10 Apr 2026 13:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775826469;
	bh=hpysSDdkkiKhjp1o0gRPLKO/3dcD0MkxiD0l9bXNbKM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UaKoNb8TNtZJCPfCswc+cr5n/qvXntnz5+p4YHzX5IwYTxGQpqhQ4p77LWsQhTCmF
	 oHufQvFzzduxAxD57Tkwp8h3oczupclbqm04fSs1qkQs8/rq/AXk1f+Xf0zk9fMadl
	 tc4PjsRlVUw58Tkq8AfjHdyrpryFEjRXWXo5Q+mIpE6nhJlUBkGbZXmtFQDLQWAppY
	 +fKy1Yh7JlfehmewWF6Biz3xm5iv3xMnzfLslgQvjA/abGEB7duCEUmlg7egq5hHAG
	 /vdpFxunjL9Sd9FJNWioJvxy5oFROz2h/z5H+02t7jV01et9a2lfQ9v28sULmg5HR7
	 Wup/Utnjtl9Dw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDE8F4485B;
	Fri, 10 Apr 2026 13:07:49 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 10 Apr 2026 08:07:16 -0500
Subject: [PATCH 06/23] dmaengine: sdxi: Allocate DMA pools
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-sdxi-base-v1-6-1d184cb5c60a@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775826467; l=4160;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=yYsDKehkM4Su6gA/w8eyy9OZyEDpuCpJ6inX5B52w14=;
 b=wAVdujdNT6YNKgQ26NGu8syqu1ZYOAPoCK0Kpv5qHmpAE5Hs22ujLAZMKUrpY5EKAAEvIN38+
 f/3+JTAETKODXyk/g9POCTXV9E2qjlypR2KZ3oVphLIu4IzECrkwBiE
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
	TAGGED_FROM(0.00)[bounces-9962-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
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
X-Rspamd-Queue-Id: 45F253D7F38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Nathan Lynch <nathan.lynch@amd.com>

Each SDXI context consists of several control structures in system
memory:

* Descriptor ring
* Access key (AKey) table
* Context control block (CXT_CTL)
* Context status block (CXT_STS)
* Write index

Of these, the write index, context control and context status blocks
are small enough to justify DMA pools.

SDXI descriptors may optionally have 32-byte completion status
blocks (CST_BLK) associated with them that software can poll for
completion.

Introduce the C structures for context control, context status, and
completion status blocks. Create a DMA pool for each of these objects
as well as write indexes during SDXI function initialization.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/device.c | 34 +++++++++++++++++++++++++++++++++-
 drivers/dma/sdxi/hw.h     | 28 ++++++++++++++++++++++++++++
 drivers/dma/sdxi/sdxi.h   |  5 +++++
 3 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index 7e772ce81365..80bd1bbd9c7c 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -9,6 +9,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
+#include <linux/dmapool.h>
 #include <linux/log2.h>
 #include <linux/slab.h>
 
@@ -188,6 +189,37 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
 	return 0;
 }
 
+static int sdxi_create_dma_pool(struct sdxi_dev *sdxi, struct dma_pool **pool,
+				const char *name, size_t size)
+{
+	*pool = dmam_pool_create(name, sdxi_to_dev(sdxi), size, size, 0);
+	return *pool ? 0 : -ENOMEM;
+}
+
+static int sdxi_device_init(struct sdxi_dev *sdxi)
+{
+	int err;
+
+	if (sdxi_create_dma_pool(sdxi, &sdxi->write_index_pool,
+				 "Write_Index", sizeof(__le64)))
+		return -ENOMEM;
+	if (sdxi_create_dma_pool(sdxi, &sdxi->cxt_sts_pool,
+				 "CXT_STS", sizeof(struct sdxi_cxt_sts)))
+		return -ENOMEM;
+	if (sdxi_create_dma_pool(sdxi, &sdxi->cxt_ctl_pool,
+				 "CXT_CTL", sizeof(struct sdxi_cxt_ctl)))
+		return -ENOMEM;
+	if (sdxi_create_dma_pool(sdxi, &sdxi->cst_blk_pool,
+				 "CST_BLK", sizeof(struct sdxi_cst_blk)))
+		return -ENOMEM;
+
+	err = sdxi_fn_activate(sdxi);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 {
 	struct sdxi_dev *sdxi;
@@ -205,5 +237,5 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 	if (err)
 		return err;
 
-	return sdxi_fn_activate(sdxi);
+	return sdxi_device_init(sdxi);
 }
diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
index df520ca7792b..846c671c423f 100644
--- a/drivers/dma/sdxi/hw.h
+++ b/drivers/dma/sdxi/hw.h
@@ -58,4 +58,32 @@ struct sdxi_cxt_L1_table {
 };
 static_assert(sizeof(struct sdxi_cxt_L1_table) == 4096);
 
+/* SDXI 1.0 Table 3-4: Context Control (CXT_CTL) */
+struct sdxi_cxt_ctl {
+	__le64 ds_ring_ptr;
+	__le32 ds_ring_sz;
+	__u8 rsvd_0[4];
+	__le64 cxt_sts_ptr;
+	__le64 write_index_ptr;
+	__u8 rsvd_1[32];
+} __packed;
+static_assert(sizeof(struct sdxi_cxt_ctl) == 64);
+
+/* SDXI 1.0 Table 3-5: Context Status (CXT_STS) */
+struct sdxi_cxt_sts {
+	__u8 state;
+	__u8 misc0;
+	__u8 rsvd_0[6];
+	__le64 read_index;
+} __packed;
+static_assert(sizeof(struct sdxi_cxt_sts) == 16);
+
+/* SDXI 1.0 Table 6-4: CST_BLK (Completion Status Block) */
+struct sdxi_cst_blk {
+	__le64 signal;
+	__le32 flags;
+	__u8 rsvd_0[20];
+} __packed;
+static_assert(sizeof(struct sdxi_cst_blk) == 32);
+
 #endif /* DMA_SDXI_HW_H */
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index 185f58b725da..6cda60bb33c4 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -46,6 +46,11 @@ struct sdxi_dev {
 	struct sdxi_cxt_L1_table *L1_table;
 	dma_addr_t L1_dma;
 
+	struct dma_pool *write_index_pool;
+	struct dma_pool *cxt_sts_pool;
+	struct dma_pool *cxt_ctl_pool;
+	struct dma_pool *cst_blk_pool;
+
 	const struct sdxi_bus_ops *bus_ops;
 };
 

-- 
2.53.0



