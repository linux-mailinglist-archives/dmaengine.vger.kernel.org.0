Return-Path: <dmaengine+bounces-9209-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIEHEzm3pmk7TAAAu9opvQ
	(envelope-from <dmaengine+bounces-9209-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 11:26:01 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC7F1ECA2A
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 11:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE868303F7F6
	for <lists+dmaengine@lfdr.de>; Tue,  3 Mar 2026 10:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBA1382373;
	Tue,  3 Mar 2026 10:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXen89uj"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED29B36D9EC
	for <dmaengine@vger.kernel.org>; Tue,  3 Mar 2026 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772533458; cv=none; b=h977UBoUy7EXS5FsmNwpYwej12omyDYjOJJpFGA5q3EJOQeo/8V8V9XmmCv4KfCV/96d/yBrjZrbxE8vg9nqyiH9GhPLNdR8hLd9Tr8jIC4bcyzmNZV0UDNrOqJeu7AJk9lm/NpSkLoh0QTiZCnQHgCOynwL9r7eOO3CCpMAgOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772533458; c=relaxed/simple;
	bh=QEwRW1SP1fBjfzZnxq0bPB1Ba1JG6sEpZ8ycQ6WQEHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SoS2fpzkC5Z0oQy12OtzYng/ULOY6DplDLB43a72538fnw1JmP24oCuwDTEfajJEidoRckm2adAhB15jbcQmeZ/omJZ2MITuKVmJc2/GQJLbe4T1z9fIgLthApX2BaRPyEY6a1jlIwT6azL/M4nvcjOZPhOjrDDT/mTxfTq0IzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXen89uj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C14F7C2BCB0;
	Tue,  3 Mar 2026 10:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772533457;
	bh=QEwRW1SP1fBjfzZnxq0bPB1Ba1JG6sEpZ8ycQ6WQEHU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CXen89uj/7TADAV0qTYf+flrAyBOU2S1tL2i/989eYxpHu+DPDn4V5o1zohiTk1RJ
	 Ro2C9upb7rO+8uu+gfU3biT9916DTa33/v1xgd4mezfZpRiReeII6uYzw2q6domZ3B
	 zxfR1aNw38Pq8TfB7ZH09F8rpuSALtg6gQfl9vA64g6MRNO3e2FsJMd5/HtEHXUbx8
	 DMaCXpfspvoqC6eCOd6nFAniX61DgTL/MAEY/8dLUALKamYZXpSkpH9ayoqM/f/crX
	 FThLTAA3i1cGEnt47EuXp53OXChd6ejULjXNpG4AszBCSTfpKZBMtDPrG0w90A1pwf
	 NayI9astkKmuA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFADFEB362F;
	Tue,  3 Mar 2026 10:24:17 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 03 Mar 2026 10:25:01 +0000
Subject: [PATCH v2 2/5] dmaengine: dma-axi-dmac: Add cyclic transfers in
 .device_prep_peripheral_dma_vec()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260303-axi-dac-cyclic-support-v2-2-0db27b4be95a@analog.com>
References: <20260303-axi-dac-cyclic-support-v2-0-0db27b4be95a@analog.com>
In-Reply-To: <20260303-axi-dac-cyclic-support-v2-0-0db27b4be95a@analog.com>
To: dmaengine@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772533501; l=1088;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=J1Cpr1txWVAI64Jhdqr7+Os1z7iyvgdh75sSDV3Ci4k=;
 b=v/I3MEIlmudS9FWZXswCKKIV1hCc23eFisTDnAq2LK31K86cQVZ+436CChEmxUDV0xKYqfKwP
 L5JfIE1cqljD74nUQVs2LXbQH9he3OFJYyTMtxFFyFXpi69mgX9AOh1
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com
X-Rspamd-Queue-Id: DCC7F1ECA2A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9209-lists,dmaengine=lfdr.de,nuno.sa.analog.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	HAS_REPLYTO(0.00)[nuno.sa@analog.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:replyto,analog.com:email,analog.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Action: no action

From: Nuno Sá <nuno.sa@analog.com>

Add support for cyclic transfers by checking the DMA_PREP_REPEAT
flag. If the flag is set, close the loop and clear the flag for the last
segment (the same done for .device_prep_dma_cyclic().

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index eb65872c5d5c..79c01b7d9732 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -657,7 +657,12 @@ axi_dmac_prep_peripheral_dma_vec(struct dma_chan *c, const struct dma_vec *vecs,
 					      vecs[i].len, dsg);
 	}
 
-	desc->cyclic = false;
+	desc->cyclic = flags & DMA_PREP_REPEAT;
+	if (desc->cyclic) {
+		/* Chain the last descriptor to the first, and remove its "last" flag */
+		desc->sg[num_sgs - 1].hw->flags &= ~AXI_DMAC_HW_FLAG_LAST;
+		desc->sg[num_sgs - 1].hw->next_sg_addr = desc->sg[0].hw_phys;
+	}
 
 	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
 }

-- 
2.53.0



