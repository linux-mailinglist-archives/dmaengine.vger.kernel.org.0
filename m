Return-Path: <dmaengine+bounces-10318-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGIzLDUrAmp0ogEAu9opvQ
	(envelope-from <dmaengine+bounces-10318-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:17:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08959514EF8
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90905301156F
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 19:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA2F4D90BD;
	Mon, 11 May 2026 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMsEf4Rr"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909084D90A2;
	Mon, 11 May 2026 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778526998; cv=none; b=MbSya8ELcB1Fi90qGJp1j2pLQJWLBtxf0MCEodRAHbKi4ke7ffLsA7mlwue4XyUDW7vDG5UvrWPTDknqFbB0d3WKry2lcsYVAnxqE/MrAfxY6BR8r5vUmmZ74b11FcqkTBQdwCcHqAHT4KbFoZQ/KtMLI/Empsi75X+tNX+mOoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778526998; c=relaxed/simple;
	bh=j4lNO/fYePaZgOpGoCKKg+z5lTw6764bjfzODEn4uIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PkznK4o/sQ4GxpHhyAIkmQ+Va5nVuyeVleJe6H2dJg1Pv1q3fKSmMdntKHP1sOPLHS1X1WdwD4Q+cvXoZYl9oQCndzKemomEGy80FPEFwbISnNhZDTp5F37Fbzcr3ntcLEj6OLjzlpCo4T+b/PvBRUuAeMmNOHwgmtj9Pd6fDgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMsEf4Rr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D14FC4AF18;
	Mon, 11 May 2026 19:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778526998;
	bh=j4lNO/fYePaZgOpGoCKKg+z5lTw6764bjfzODEn4uIk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eMsEf4Rrmyy+BX3BkzKiFkIRAPYnV0sqXUV8IcetptXzgZWaBILrtTYgPYBdmxvGN
	 emqfqiDYMSruoU1MxFZ5vA2sgFy8OjWEg7WYy3qtCqdkTocjzA380Q+zxCX9vLRfH3
	 kJH68VoOqo/23p+RDu8HGqH3XNQ9HVmvY1UlkSzLy/5spftnn5F93IJo8ARFS17lUu
	 m+DcT1+igOpzAhp+Dq69DKiLzyTJR5gzwUnnLi6cxHi6ERI2WBPxuNz8vs0Bv92we5
	 3329vSndjZX3B+gyl4Gz5CK6lnh/BEOkKcPaJTlooSmaME189HsGiaKnBscWja2/Ua
	 tgxCQ9cXFNPUg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F479CD484E;
	Mon, 11 May 2026 19:16:38 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Mon, 11 May 2026 14:16:31 -0500
Subject: [PATCH v2 19/23] dmaengine: sdxi: Provide context start and stop
 APIs
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-sdxi-base-v2-19-889cfed17e3f@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778526994; l=3811;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=dyk2K59UsQ99gOajnSyAw3cmnjU9e3YFtwnlMUYZ/3E=;
 b=GI1Rg/sAFjnfI8Rz+c5MIf+SVxlz5tPG+QVkDo8naoy8PNkePeET0AvxX4NsamYNa7SzG43H/
 AT9VK9vPrLqAZh5xpSqSrZV9gVDY0s4cejCg1zpSChAx0sF8QUnYoox
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
X-Rspamd-Queue-Id: 08959514EF8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10318-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	HAS_REPLYTO(0.00)[nathan.lynch@amd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:email,amd.com:mid,amd.com:replyto]
X-Rspamd-Action: no action

From: Nathan Lynch <nathan.lynch@amd.com>

Starting and stopping SDXI client contexts is implemented by submitting
special-purpose descriptors to a function's admin context.

Introduce high-level context start and stop APIs that operate on
struct sdxi_cxt objects, encapsulating the administrative descriptor
submission and completion signaling. These are intended for use by
clients such as the DMA engine provider to come.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/context.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/context.h |  3 ++
 2 files changed, 80 insertions(+)

diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
index 56e21aa08857..28eb4ccd6c1d 100644
--- a/drivers/dma/sdxi/context.c
+++ b/drivers/dma/sdxi/context.c
@@ -22,7 +22,9 @@
 #include <asm/barrier.h>
 #include <asm/rwonce.h>
 
+#include "completion.h"
 #include "context.h"
+#include "descriptor.h"
 #include "hw.h"
 #include "ring.h"
 #include "sdxi.h"
@@ -335,6 +337,81 @@ int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
 	return devm_add_action_or_reset(sdxi->dev, free_admin_cxt, sdxi);
 }
 
+int sdxi_start_cxt(struct sdxi_cxt *cxt)
+{
+	struct sdxi_cxt *adm = to_admin_cxt(cxt);
+	struct sdxi_desc *desc;
+	struct sdxi_ring_resv resv;
+	int err;
+
+	might_sleep();
+
+	struct sdxi_completion *sc __free(sdxi_completion) =
+		sdxi_completion_alloc(cxt->sdxi);
+
+	if (!sc)
+		return -ENOMEM;
+
+	/* This is not how to start the admin context. */
+	if (WARN_ON(adm == cxt))
+		return -EINVAL;
+
+	err = sdxi_ring_reserve(adm->ring_state, 1, &resv);
+	if (err)
+		return err;
+
+	desc = sdxi_ring_resv_next(&resv);
+	sdxi_encode_cxt_start(desc, &(const struct sdxi_cxt_start) {
+			.range = sdxi_cxt_range_single(cxt->id),
+		});
+	sdxi_completion_attach(desc, sc);
+	sdxi_desc_make_valid(desc);
+	sdxi_cxt_push_doorbell(adm, sdxi_ring_resv_dbval(&resv));
+
+	return sdxi_completion_poll(sc);
+}
+
+void sdxi_stop_cxt(struct sdxi_cxt *cxt)
+{
+	struct sdxi_cxt *adm = to_admin_cxt(cxt);
+	struct sdxi_desc *stop, *sync;
+	struct sdxi_ring_resv resv;
+	int err;
+
+	might_sleep();
+
+	struct sdxi_completion *sc __free(sdxi_completion) =
+		sdxi_completion_alloc(cxt->sdxi);
+
+	if (!sc)
+		return;
+
+	/* This is not how to stop the admin context. */
+	if (WARN_ON(adm == cxt))
+		return;
+
+	err = sdxi_ring_reserve(adm->ring_state, 2, &resv);
+	if (WARN_ON_ONCE(err))
+		return;
+
+	stop = sdxi_ring_resv_next(&resv);
+	sync = sdxi_ring_resv_next(&resv);
+
+	sdxi_encode_cxt_stop(stop, &(const struct sdxi_cxt_stop) {
+			.range = sdxi_cxt_range_single(cxt->id),
+		});
+	sdxi_encode_sync(sync, &(const struct sdxi_sync) {
+			.filter = SDXI_SYNC_FLT_STOP,
+			.range = sdxi_cxt_range_single(cxt->id),
+		});
+	sdxi_completion_attach(sync, sc);
+	sdxi_desc_make_valid(stop);
+	sdxi_desc_make_valid(sync);
+	sdxi_cxt_push_doorbell(adm, sdxi_ring_resv_dbval(&resv));
+
+	WARN_ON(sdxi_completion_poll(sc));
+}
+
 /*
  * Temporary owner for context id until it can be assigned to a
  * context object; enables scope-based cleanup.
diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
index 329cafe94fe2..d7f67a435a9f 100644
--- a/drivers/dma/sdxi/context.h
+++ b/drivers/dma/sdxi/context.h
@@ -68,6 +68,9 @@ int sdxi_admin_cxt_init(struct sdxi_dev *sdxi);
 struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi);
 void sdxi_cxt_exit(struct sdxi_cxt *cxt);
 
+int sdxi_start_cxt(struct sdxi_cxt *cxt);
+void sdxi_stop_cxt(struct sdxi_cxt *cxt);
+
 static inline struct sdxi_cxt *to_admin_cxt(const struct sdxi_cxt *cxt)
 {
 	return cxt->sdxi->admin_cxt;

-- 
2.54.0



