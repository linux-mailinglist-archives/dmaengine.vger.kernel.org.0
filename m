Return-Path: <dmaengine+bounces-9213-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMZAFz23pmk7TAAAu9opvQ
	(envelope-from <dmaengine+bounces-9213-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 11:26:05 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06ADF1ECA42
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 11:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4409E3045A9C
	for <lists+dmaengine@lfdr.de>; Tue,  3 Mar 2026 10:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4728A35B63D;
	Tue,  3 Mar 2026 10:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="by5pO4Yk"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AA8382387
	for <dmaengine@vger.kernel.org>; Tue,  3 Mar 2026 10:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772533458; cv=none; b=pjrQyP4apEQWAo++myRviDrNC6uPaIP1415gAoB+pCu5Dvhpg/FVDc/tcTCkID/Ty3BRcl5ubMHrRqs3QsC8RlqARTTThP3pCSDMFVv4w18CLgQSm6vG/zaZ7qAVgEZa18nkY+R630WYdJWp5Hp+p7pgYQxbMtCkEstZoDK5gNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772533458; c=relaxed/simple;
	bh=1paRApFNOfzxl76xzLpAXTJjNKszG+jG5RJYWDI0fiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OwqPREy1F1c82krIUjoe7JfOg2uGHIlEXaNMyUra0uw/mqsj5Ert+O1MOCMFMbJS6ojJ9Wl/QbJ4+brF40aKY2xihyeheMj7zn9PA77oJCpk6bSv6qWIIKnifc2+qB8OmAasLD6qffDVJDCPkB/oLWt2k5HrGp3HaQ/2unbUWHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=by5pO4Yk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D99CCC2BCB4;
	Tue,  3 Mar 2026 10:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772533457;
	bh=1paRApFNOfzxl76xzLpAXTJjNKszG+jG5RJYWDI0fiQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=by5pO4Ykzoiul+iI5t13WtPgN0evaRtrNK0LBJ/8U37SWW7VFu0tROxVvG7Gl6z5F
	 daBTW3NJxIjxhM+JcWj601cVOz1sI1OG3Vdrcq5u4X5HTXywl9iqBXvuY3x03RbZdN
	 2C90grmAJfCYeEitZcVPUzsACEHgUQ0h/Pyy+irzMH/FNdZiNJ0qtSc/hr+kuxq/o6
	 Hk/UoXaUINgtw/MHf0+t5bFxO532cM1OBzgyhmxDgE/tNxVGHBXK2G0ayEYTWlPLNk
	 gcwmbClbq2gCJKTVihdZ0qYX6vXKAK/Ilp6OVsq7PZOprJinNwQTRTu1GDRHr/o5GT
	 SEkjzPmUAyjkw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D321EFD006E;
	Tue,  3 Mar 2026 10:24:17 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 03 Mar 2026 10:25:03 +0000
Subject: [PATCH v2 4/5] dmaengine: dma-axi-dmac: Gracefully terminate SW
 cyclic transfers
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260303-axi-dac-cyclic-support-v2-4-0db27b4be95a@analog.com>
References: <20260303-axi-dac-cyclic-support-v2-0-0db27b4be95a@analog.com>
In-Reply-To: <20260303-axi-dac-cyclic-support-v2-0-0db27b4be95a@analog.com>
To: dmaengine@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772533501; l=2568;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=by16V5/NLFw/3DRhfR0r4tQVR69bWmLI/moWu8EK0w0=;
 b=ZCJTjmqmBu0fkqNoG+OfB7eMaUU/Z1l91yuLS/Oag2TdVLrMGeYmnyFH3GDwWXZAzQjZ32d6O
 HauB8Ma4x/YDyxzv3Bbw2WBzb24wco1ArcBoeCupeR4EiiN1lw4NVtc
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com
X-Rspamd-Queue-Id: 06ADF1ECA42
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9213-lists,dmaengine=lfdr.de,nuno.sa.analog.com];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	HAS_REPLYTO(0.00)[nuno.sa@analog.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,analog.com:replyto,analog.com:email,analog.com:mid]
X-Rspamd-Action: no action

From: Nuno Sá <nuno.sa@analog.com>

As of now, to terminate a cyclic transfer, one pretty much needs to use
brute force and terminate all transfers with .device_terminate_all().
With this change, when a cyclic transfer terminates (and generates an
EOT interrupt), look at any new pending transfer with the DMA_PREP_LOAD_EOT
flag set. If there is one, the current cyclic transfer is terminated and
the next one is enqueued. If the flag is not set, that transfer is ignored.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index a47e08d3dbbc..e9814d725322 100644
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
2.53.0



