Return-Path: <dmaengine+bounces-9965-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iI7OOMj22GkYkQgAu9opvQ
	(envelope-from <dmaengine+bounces-9965-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 15:10:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 626D13D7F47
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 15:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FE64304E0DB
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 13:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719813A759F;
	Fri, 10 Apr 2026 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZoK3NPj"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FEB395D85;
	Fri, 10 Apr 2026 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775826470; cv=none; b=OiPQfbh7XIoBWVmWRqROrJHcwFxdFB0lA0wKRiIjXZ+hEAqoDtH6WtFu2Xaf/cixgN+4809zecNqeS6cnFZfWQKmi8rJ5zTasveOG0PbsygMdlZY/glQLDxCYUi538q83ruCU01V98qMW571gMcEYDG54Qf0pLmslxiLRSkIibY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775826470; c=relaxed/simple;
	bh=Wxk7H4obpIFjzAES9jna1gaVL0e16DOiq/fj8eJzij4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yax2uLfJX8FaftS5xg2z/d0W0JKhQsQxTwp4dSRfX+xrWhHV5fPDmrG9dzdB9cTzu37LymXIhwvwKhZasHDujfvgQckbHeD837vhl/EtM+u8lCOBuS73nGjtDiiF8Vog1Qm27ylM30T2odEEArlec1AUgRccX5VLkhbtVrpiPj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZoK3NPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24574C2BC9E;
	Fri, 10 Apr 2026 13:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775826470;
	bh=Wxk7H4obpIFjzAES9jna1gaVL0e16DOiq/fj8eJzij4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tZoK3NPjxycGFBwbM9yBB9NrqGRsJGLDwKXtzOALvy5X8rUtqZH1zoRmraqR71zYt
	 vp+PJ3L2J22YeVrSk5kL99RJWyH6eZjkd6YmMM/CYsSIXC02qYFsQy6RpJu1OqkW/Q
	 3qzKGCzxWlOm3VlHWszJojD/ndJYosCyVE9VkQ3weJpcU9OnQ/nEhHTS2GVt06cLfk
	 JV2m0IfHfavx0A2QM+QqEa2vc08K9kRTAYe5C1lenqF/7doG05AzeVzKVixWORafTa
	 60P9To/FZw7e9sT598SXbqL8XPcQ0dtp/Px2CoJXIhK6ynBxa3vcR5LCSh9OthllTQ
	 v2u59zXgiA0sA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF1CF4485E;
	Fri, 10 Apr 2026 13:07:50 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 10 Apr 2026 08:07:20 -0500
Subject: [PATCH 10/23] dmaengine: sdxi: Complete administrative context
 jump start
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-sdxi-base-v1-10-1d184cb5c60a@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775826467; l=2661;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=kubAcpoNvMH0mX/GJJdrwMYFQK1FnJy4kZUeWUFVoLw=;
 b=7pj9RgnhwKsDbTwFx6YSm1hoIlRSARyL8X3IESnCY+LyM8dxaxYEWK1wLINHf77w93JiWP2AD
 2nopQyUJRXTCKSmk2UdY9lvB6Jz4ldpN5EmC8pDiHFBqka38tBGG5B4
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
	TAGGED_FROM(0.00)[bounces-9965-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
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
X-Rspamd-Queue-Id: 626D13D7F47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Nathan Lynch <nathan.lynch@amd.com>

Now that the SDXI function has been placed in active state, the admin
context can finally be started by writing its doorbell. Introduce
sdxi_cxt_push_doorbell() to pair the necessary barrier with the
doorbell update.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/context.c |  8 ++++++++
 drivers/dma/sdxi/context.h |  2 ++
 drivers/dma/sdxi/device.c  | 15 ++++++++++++++-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
index 097d871e530f..934c487b4774 100644
--- a/drivers/dma/sdxi/context.c
+++ b/drivers/dma/sdxi/context.c
@@ -16,6 +16,7 @@
 #include <linux/dmapool.h>
 #include <linux/errno.h>
 #include <linux/iommu.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <asm/barrier.h>
@@ -258,6 +259,13 @@ static int sdxi_publish_cxt(const struct sdxi_cxt *cxt)
 	/* todo: need to send DSC_CXT_UPD to admin */
 }
 
+void sdxi_cxt_push_doorbell(struct sdxi_cxt *cxt, u64 index)
+{
+	/* Ensure preceding write index increment is visible. */
+	dma_wmb();
+	iowrite64(index, cxt->db);
+}
+
 static void free_admin_cxt(void *ptr)
 {
 	struct sdxi_dev *sdxi = ptr;
diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
index bbde1fd49af3..c34acd730acb 100644
--- a/drivers/dma/sdxi/context.h
+++ b/drivers/dma/sdxi/context.h
@@ -58,4 +58,6 @@ struct sdxi_cxt {
 
 int sdxi_admin_cxt_init(struct sdxi_dev *sdxi);
 
+void sdxi_cxt_push_doorbell(struct sdxi_cxt *cxt, u64 index);
+
 #endif /* DMA_SDXI_CONTEXT_H */
diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index 145aa098c269..15f61d1ce490 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -244,7 +244,20 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
 	 * SDXI 1.0 4.1.8.9: Set MMIO_CTL0.fn_gsr to GSRV_ACTIVE and
 	 * wait for MMIO_STS0.fn_gsv to reach GSV_ACTIVE or GSV_ERROR.
 	 */
-	return sdxi_dev_start(sdxi);
+	err = sdxi_dev_start(sdxi);
+	if (err)
+		return err;
+
+	/*
+	 * SDXI 1.0 4.1.8.10.b: Start the admin context using method
+	 * #3 ("Jump Start 1") from 4.3.4 Starting A Context and
+	 * Context Signaling. We haven't queued any descriptors to the
+	 * admin context at this point, so the appropriate value for
+	 * the doorbell is 0.
+	 */
+	sdxi_cxt_push_doorbell(sdxi->admin_cxt, 0);
+
+	return 0;
 }
 
 static int sdxi_create_dma_pool(struct sdxi_dev *sdxi, struct dma_pool **pool,

-- 
2.53.0



