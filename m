Return-Path: <dmaengine+bounces-10314-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJX2LngrAmq/ogEAu9opvQ
	(envelope-from <dmaengine+bounces-10314-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:18:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB03514FC3
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 127463054F75
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 19:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DFC4D8DB4;
	Mon, 11 May 2026 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEIV5tk2"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5194D8D9B;
	Mon, 11 May 2026 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778526998; cv=none; b=XHln7B7287MoAXDNrcm1TFvYBDJtQYpBnRzCBJx83zty+7e/u3pF3KrA2dzMl7XDjNEJPeWmVV2kP2IhtkRSGXvpWE4W3E3XvK4vu0NXJjI6LImURNRpqtHM9ITNfEO+jPJ2yjgfvt4UBa/D7CHjNHJGRdchWib7Xsb18y4innU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778526998; c=relaxed/simple;
	bh=JKwGVQ5FA54XgqfdJB1eEmPYEuBAKrERXJttJwx7+QA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lHFVgi522XoC/YN5+snQJ8ePr6hdgSdmvsTWufxUQyqKtxznXuayN2HC/2bsqha30o282OnbcRtaGvtpn64bVBD4Yt7+RmLtHU70NIctF46L0GPBqyVmA+k4z1hKbf2FMXhjVOI40Uw1k+SBnCUSFYgW+1k7st8BPlFCiDzkvwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEIV5tk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D95AC4AF4D;
	Mon, 11 May 2026 19:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778526998;
	bh=JKwGVQ5FA54XgqfdJB1eEmPYEuBAKrERXJttJwx7+QA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YEIV5tk2579Ml4lyIYSxmYOgWOt3jo7dnQiFd+qIIujRrPMPLNPttK86vP/kNB+Z+
	 gk8CfyfqPQXq9rpVVRwUCBPO4GK8hUMgJR30UIgVFamBOHzatm8SCbTTdpaoylazDT
	 HlYuXxDqiot5IUk1RunNy1SetsfdOLzyhGY5IHAAoYKKCurxPwx7EMhHxDaxA1wBlI
	 B8gTA5DPHgcOWNZ4OrnubGU4yAogQxACLKLr9gPJRK3ywCGAvJwNs9YURFoO42ITOe
	 C/48mEFGhRx/65ocSojRBqzSScTwgM24TzpN2XqqZCifCamD0SxgJPXjsuSluwQYpL
	 rbKtK4zT5O//Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EA8CD4840;
	Mon, 11 May 2026 19:16:38 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Mon, 11 May 2026 14:16:26 -0500
Subject: [PATCH v2 14/23] dmaengine: sdxi: Attach descriptor ring state to
 contexts
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-sdxi-base-v2-14-889cfed17e3f@amd.com>
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
 Jonathan Cameron <jic23@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778526994; l=2755;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=ytfFjB0cliTXEDdWXmhsIUkwFIPPuxrcuEaZHoqzV04=;
 b=cqNJ/i1Uw9ae4KhfsFPYCCD6rdrtNNvAMUTeVPKmQpCWykLEmNtgx0p8r+2IYjgQF9Doju2ol
 7gz0E7R4tSWDKAt5aMeylYupR5M7Mq9Xg60AXGOBwiTxbEf1mFwgxSN
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
X-Rspamd-Queue-Id: 4BB03514FC3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10314-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:mid,amd.com:replyto]
X-Rspamd-Action: no action

From: Nathan Lynch <nathan.lynch@amd.com>

Attach an instance of struct sdxi_ring_state to each context upon
allocation. Each ring state has the same lifetime has its context and
is freed upon context release.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/context.c | 14 ++++++++++++++
 drivers/dma/sdxi/context.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
index c0b294836ede..a9c68227cc32 100644
--- a/drivers/dma/sdxi/context.c
+++ b/drivers/dma/sdxi/context.c
@@ -23,6 +23,7 @@
 
 #include "context.h"
 #include "hw.h"
+#include "ring.h"
 #include "sdxi.h"
 
 #define DEFAULT_DESC_RING_ENTRIES 1024
@@ -63,6 +64,7 @@ static void sdxi_free_cxt(struct sdxi_cxt *cxt)
 		dma_free_coherent(sdxi->dev, sq->ring_size,
 				  sq->desc_ring, sq->ring_dma);
 	kfree(cxt->sq);
+	kfree(cxt->ring_state);
 	kfree(cxt);
 }
 
@@ -80,6 +82,10 @@ static struct sdxi_cxt *sdxi_alloc_cxt(struct sdxi_dev *sdxi)
 
 	cxt->sdxi = sdxi;
 
+	cxt->ring_state = kzalloc_obj(*cxt->ring_state, GFP_KERNEL);
+	if (!cxt->ring_state)
+		return NULL;
+
 	cxt->sq = kzalloc_obj(*cxt->sq, GFP_KERNEL);
 	if (!cxt->sq)
 		return NULL;
@@ -314,6 +320,8 @@ int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
 	sq->cxt_sts->state = FIELD_PREP(SDXI_CXT_STS_STATE, CXTV_RUN);
 	cxt->id = SDXI_ADMIN_CXT_ID;
 	cxt->db = sdxi->dbs + cxt->id * sdxi->db_stride;
+	sdxi_ring_state_init(cxt->ring_state, &sq->cxt_sts->read_index,
+			     sq->write_index, sq->ring_entries, sq->desc_ring);
 
 	err = sdxi_publish_cxt(cxt);
 	if (err)
@@ -380,6 +388,8 @@ static void sdxi_cxt_id_assign(struct sdxi_cxt *cxt, struct sdxi_cxt_id *cxt_id)
  */
 struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi)
 {
+	struct sdxi_sq *sq;
+
 	/*
 	 * Ensure an ID is available before allocating memory for the
 	 * context and its control structures.
@@ -396,6 +406,10 @@ struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi)
 
 	cxt->db = sdxi->dbs + cxt->id * sdxi->db_stride;
 
+	sq = cxt->sq;
+	sdxi_ring_state_init(cxt->ring_state, &sq->cxt_sts->read_index,
+			     sq->write_index, sq->ring_entries, sq->desc_ring);
+
 	if (sdxi_publish_cxt(cxt))
 		return NULL;
 
diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
index b422a04ae4db..377e40c61401 100644
--- a/drivers/dma/sdxi/context.h
+++ b/drivers/dma/sdxi/context.h
@@ -55,6 +55,8 @@ struct sdxi_cxt {
 	dma_addr_t akey_table_dma;
 
 	struct sdxi_sq *sq;
+
+	struct sdxi_ring_state *ring_state;
 };
 
 int sdxi_admin_cxt_init(struct sdxi_dev *sdxi);

-- 
2.54.0



