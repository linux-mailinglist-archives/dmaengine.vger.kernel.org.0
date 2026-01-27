Return-Path: <dmaengine+bounces-8534-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLF9KNjMeGmNtQEAu9opvQ
	(envelope-from <dmaengine+bounces-8534-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 15:34:00 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D9795C89
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 15:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 866DB3014131
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 14:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6811735B642;
	Tue, 27 Jan 2026 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTPD6yLj"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3189635B62A
	for <dmaengine@vger.kernel.org>; Tue, 27 Jan 2026 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524065; cv=none; b=FBbiqA7Qf16Lk6ejTsx+KV+YiGY7DD47MzEYyF4y5yDgN4GU25uidZNqcuxXsHBSkdH0i2T/oYBHKZIqVjtli96TIqkZSOmIcTZsKc4JyrH5bW2bAYR9AgAlIWSWc/nraLXOyTbrk8WsTqoTbqjAbXqgB2jw6a3NKGx9VtwlKWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524065; c=relaxed/simple;
	bh=TsN3+2f8NBy0wbrgXGHVk2Qs0sIwfFC5HGrt2R3wz78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jt0NIwIQ3S4V5vOvi87BhkAIR1A2YiW+/v1B/146sutSfYFhsejOkxCFX/kYaN8NQRWMACgrRcHbWzNBSVql/zmfRlKbKwEs7Y2ghwtPd6lqPNGWYg2KKNmF9rsrQZE6IazDCzEb9kdXz4QZeiWwffLLetbX0BQuwbLxFw5u+Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTPD6yLj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB52AC2BC86;
	Tue, 27 Jan 2026 14:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769524065;
	bh=TsN3+2f8NBy0wbrgXGHVk2Qs0sIwfFC5HGrt2R3wz78=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mTPD6yLjCBgRqP+oqgMgrpbM+KmwBxqjk1/VZamLeoaZZmKEpwk0RCuu2wXmOhfrW
	 jSpdR5+WzaT18irn7pFxNontdWckppdc44JrEFBD1JjvzmSNLM8rnNOXqAYzV1pFC2
	 NG6HiP+tcDuSDMXX+x+FlPSMSWIIuFx8GYLs+3T/Ny0qW92hsMZs3Ss9Dh/21PLKwP
	 iB4UzCozPqqsRKo88qhdgHaB2ds4pWb7W0osbYd3QtMXjKDtZxT/Blk41ZoJvksT6o
	 WL317L4mctpMjnWVLkFOAebn+JpTFswAlFf4jOKS0oHQ4z2sx0iznW14xK2xkaj9hA
	 Hq0OmUL5mjwNQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94D2D2F039;
	Tue, 27 Jan 2026 14:27:44 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 27 Jan 2026 14:28:24 +0000
Subject: [PATCH 3/5] dma: dma-axi-dmac: add helper for getting next desc
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260127-axi-dac-cyclic-support-v1-3-b32daca4b3c7@analog.com>
References: <20260127-axi-dac-cyclic-support-v1-0-b32daca4b3c7@analog.com>
In-Reply-To: <20260127-axi-dac-cyclic-support-v1-0-b32daca4b3c7@analog.com>
To: dmaengine@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769524107; l=1936;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=BR4Apl19xp83XGAyxvW1BHptEpCk3eFm5vTB8511sW0=;
 b=WHCZQHo9nHskB9VUvmdlSX0EI8BvAdrnb1q87vnny1VY7vYx8F82itnC5ZfqnFgJ2V8I88wSc
 IHg6m3u7JNSBJPv0B3tJ99Th1syh0G5hzFpas4NP1VdVZRvrM4CaCoX
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8534-lists,dmaengine=lfdr.de,nuno.sa.analog.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	HAS_REPLYTO(0.00)[nuno.sa@analog.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:replyto,analog.com:email,analog.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 22D9795C89
X-Rspamd-Action: no action

From: Nuno Sá <nuno.sa@analog.com>

Add a new helper for getting the next valid struct axi_dmac_desc. This
will be extended in follow up patches to support to gracefully terminate
cyclic transfers.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index b083b6176593..3984236717a6 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -227,10 +227,29 @@ static bool axi_dmac_check_addr(struct axi_dmac_chan *chan, dma_addr_t addr)
 	return true;
 }
 
+static struct axi_dmac_desc *axi_dmac_get_next_desc(struct axi_dmac *dmac,
+						    struct axi_dmac_chan *chan)
+{
+	struct virt_dma_desc *vdesc;
+	struct axi_dmac_desc *desc;
+
+	if (chan->next_desc)
+		return chan->next_desc;
+
+	vdesc = vchan_next_desc(&chan->vchan);
+	if (!vdesc)
+		return NULL;
+
+	list_move_tail(&vdesc->node, &chan->active_descs);
+	desc = to_axi_dmac_desc(vdesc);
+	chan->next_desc = desc;
+
+	return desc;
+}
+
 static void axi_dmac_start_transfer(struct axi_dmac_chan *chan)
 {
 	struct axi_dmac *dmac = chan_to_axi_dmac(chan);
-	struct virt_dma_desc *vdesc;
 	struct axi_dmac_desc *desc;
 	struct axi_dmac_sg *sg;
 	unsigned int flags = 0;
@@ -240,16 +259,10 @@ static void axi_dmac_start_transfer(struct axi_dmac_chan *chan)
 	if (val) /* Queue is full, wait for the next SOT IRQ */
 		return;
 
-	desc = chan->next_desc;
+	desc = axi_dmac_get_next_desc(dmac, chan);
+	if (!desc)
+		return;
 
-	if (!desc) {
-		vdesc = vchan_next_desc(&chan->vchan);
-		if (!vdesc)
-			return;
-		list_move_tail(&vdesc->node, &chan->active_descs);
-		desc = to_axi_dmac_desc(vdesc);
-		chan->next_desc = desc;
-	}
 	sg = &desc->sg[desc->num_submitted];
 
 	/* Already queued in cyclic mode. Wait for it to finish */

-- 
2.52.0



