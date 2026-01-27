Return-Path: <dmaengine+bounces-8536-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IP9gNGPLeGmNtQEAu9opvQ
	(envelope-from <dmaengine+bounces-8536-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 15:27:47 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A6795A13
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 15:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7DFA3004DCA
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 14:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6807735B63F;
	Tue, 27 Jan 2026 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNEyWXXH"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BD635B632
	for <dmaengine@vger.kernel.org>; Tue, 27 Jan 2026 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524065; cv=none; b=EVlx2atPVnE4uZ5v0i8g/8EKhFSk0RPrlh11sbbs9JlyhBqSSUP9tHjUP+TDLTkJGNYIpfzy/ZJNGEWpTcJ72t6375wSZjByWmkaEeL/J6Ruv/GKun5N8QT8dDTngB7b4lWyBr8953thaJxXSviQ0MOn7nnHgb1xwifGw7KF974=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524065; c=relaxed/simple;
	bh=ou/9lAxll3YU5HGPe8Eh+dFy/lTZoZq80waHof16dCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dbn6n11aLo1gtmjscRI1ACwgfyyhzma5iDtJZx29o6oli91sOL6IEfH0RKuDHZZwEz58vqkXbHYwIDrvIwevxnBztUFdPcl8Gyl5j4X002u7WfBXP+TWXLl7jliccaKiX3B3vynIuCjBMaf9llXK+1HiJ8RirP77u9fOEBwDyWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNEyWXXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02D1BC19422;
	Tue, 27 Jan 2026 14:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769524065;
	bh=ou/9lAxll3YU5HGPe8Eh+dFy/lTZoZq80waHof16dCk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eNEyWXXHfiT8mdNetcMarRnyn6HXqSYaxUHeINkcloLiynzpTm6o9a5mTb32mZGsd
	 xMlkRw/rOXM7N0Xu354pconjBXnxIh1wwvRe7tpF/7gVWIVBO1NXUakfkL1E9IBOWE
	 smo4EV3rH/LCvvAyLQ4qgKVqJYKnBEA620RxBsDaZ/x9WLXmoWAMJiwK9dcr7b1SUy
	 VqU4xQVcDCsuVfX1UwE/cXfmajyZvj4CS2poib2HfhN+qlgTjuiGMv0VJRbv5S7YN7
	 LZ5b6PBDRUXPKPCuhfnkGA8k9ExLUHy2xxldxrYPiiT/sCd7OTBHWhGb7DQteyAQR5
	 zAHwPz4QAOK0Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61BDD2F03B;
	Tue, 27 Jan 2026 14:27:44 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 27 Jan 2026 14:28:25 +0000
Subject: [PATCH 4/5] dma: dma-axi-dmac: Gracefully terminate SW cyclic
 transfers
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260127-axi-dac-cyclic-support-v1-4-b32daca4b3c7@analog.com>
References: <20260127-axi-dac-cyclic-support-v1-0-b32daca4b3c7@analog.com>
In-Reply-To: <20260127-axi-dac-cyclic-support-v1-0-b32daca4b3c7@analog.com>
To: dmaengine@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769524107; l=2541;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Slzv8A3zvxjLZy++p0j3/rLtEyvn8HAns4tsjJyxk/4=;
 b=PXe5QqFI/r2x0RY7axMcxsuWcd+I8k0dfPVmyau2m1Hi7eXDjElF8Ijs0OeZyz5d7SJDT13rQ
 1GAAYxQhsa8A3fvF7bC59rH13PQgh11V/5oBQqGmgygtyQ2080QI8uf
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8536-lists,dmaengine=lfdr.de,nuno.sa.analog.com];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	HAS_REPLYTO(0.00)[nuno.sa@analog.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,analog.com:replyto,analog.com:email,analog.com:mid]
X-Rspamd-Queue-Id: 82A6795A13
X-Rspamd-Action: no action

From: Nuno Sá <nuno.sa@analog.com>

As of now, to terminate a cyclic transfer, one pretty much needs to use
brute force and terminate all transfers with .device_terminate_all().
With this change, when a cyclic transfer terminates we look and see if
we have any pending transfer with the DMA_PREP_LOAD_EOT flag set. If
we do, we terminate the cyclic transfer and prepare to start the next
one. If we don't see the flag we'll ignore that transfer.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 3984236717a6..638625647152 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -233,6 +233,11 @@ static struct axi_dmac_desc *axi_dmac_get_next_desc(struct axi_dmac *dmac,
 	struct virt_dma_desc *vdesc;
 	struct axi_dmac_desc *desc;
 
+	/*
+	 * It means a SW cyclic transfer is in place so we should just return
+	 * the same descriptor. SW cyclic transfer termination is handled
+	 * in axi_dmac_transfer_done().
+	 */
 	if (chan->next_desc)
 		return chan->next_desc;
 
@@ -411,6 +416,32 @@ static void axi_dmac_compute_residue(struct axi_dmac_chan *chan,
 	}
 }
 
+static bool axi_dmac_handle_cyclic_eot(struct axi_dmac_chan *chan,
+				       struct axi_dmac_desc *active)
+{
+	struct device *dev = chan_to_axi_dmac(chan)->dma_dev.dev;
+	struct virt_dma_desc *vdesc;
+
+	/* wrap around */
+	active->num_completed = 0;
+
+	vdesc = vchan_next_desc(&chan->vchan);
+	if (!vdesc)
+		return false;
+	if (!(vdesc->tx.flags & DMA_PREP_LOAD_EOT)) {
+		dev_warn(dev, "Discarding non EOT transfer after cyclic\n");
+		list_del(&vdesc->node);
+		return false;
+	}
+
+	/* then let's end the cyclic transfer */
+	chan->next_desc = NULL;
+	list_del(&active->vdesc.node);
+	vchan_cookie_complete(&active->vdesc);
+
+	return true;
+}
+
 static bool axi_dmac_transfer_done(struct axi_dmac_chan *chan,
 	unsigned int completed_transfers)
 {
@@ -458,7 +489,8 @@ static bool axi_dmac_transfer_done(struct axi_dmac_chan *chan,
 			if (active->num_completed == active->num_sgs ||
 			    sg->partial_len) {
 				if (active->cyclic) {
-					active->num_completed = 0; /* wrap around */
+					/* keep start_next as is, if already true... */
+					start_next |= axi_dmac_handle_cyclic_eot(chan, active);
 				} else {
 					list_del(&active->vdesc.node);
 					vchan_cookie_complete(&active->vdesc);

-- 
2.52.0



