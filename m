Return-Path: <dmaengine+bounces-8533-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLesJHzLeGmNtQEAu9opvQ
	(envelope-from <dmaengine+bounces-8533-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 15:28:12 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2268895A4E
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 15:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FEFE3018427
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 14:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677AD35B636;
	Tue, 27 Jan 2026 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyC0JcSk"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317E835B15D
	for <dmaengine@vger.kernel.org>; Tue, 27 Jan 2026 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524065; cv=none; b=S2bwdAjqQuSDxItWLVsvd+cb2vZnyEhB9YRry2PwXaR5GEhNpIKAbSJcWedSYQhLvy0h8MZumncSnzZHZFHZ9vvU4emwtdIxHGDGSKo1G9xj5JFssO8XSi9CuVLCzoQ2iwI8nTnexlEKsZi430BNjpZL+W0ZOr0gEe5zviRfn60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524065; c=relaxed/simple;
	bh=x42EjB/L+lVCuCM3TXrpJx9OcNlcCFmbDKXjwqaC8sI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EZB/mWCeaFxNtnGkL8mvQI43ilMWdGNlm7GM2R+cQ73eo9/hCNL2BNPmELKApoWV0Vl682UxKKDP55A5WhBh1xytIaTJwN7v35caBkevmft0W1Ro5stQYqiIJAMtJrta0Df/nbphzxxlJDUmZ19A+Tvk4TBPvdOz0KO/NglSli4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyC0JcSk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB561C4AF09;
	Tue, 27 Jan 2026 14:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769524065;
	bh=x42EjB/L+lVCuCM3TXrpJx9OcNlcCFmbDKXjwqaC8sI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AyC0JcSk1/67dgyklCkhVNiF1XXXmso1EAbxDyFW/oHw7mfyB7JB0oIEi/JfIFMxv
	 Io7jzC4LmSxNTBcmCKjPcYKRxkRb7lKJI7cG+MeQM7+tbvuKLBzEG0p7FjSr7iuX3b
	 8F6sCvEw9QusDg8VYNTiwRwQjlz/ddG3Up61/1pBa+L9enpSjLJMuLIT4MaO9/uBm0
	 FrA1rlWAruSrsmrG1bydPDu0SA8jinU2ZG7vmktTSdapjgztGc78V+6DsIxx4dMvgz
	 izYHj+2TDaCO/ewav8/UZ2zvILQuSTm5F8ICMPGytf0M02r2Ta5TmJcMrw1upckgvv
	 z3lij7s5ikxSA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB395D2F038;
	Tue, 27 Jan 2026 14:27:44 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 27 Jan 2026 14:28:23 +0000
Subject: [PATCH 2/5] dma: dma-axi-dmac: add cyclic transfers in
 .device_prep_peripheral_dma_vec()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260127-axi-dac-cyclic-support-v1-2-b32daca4b3c7@analog.com>
References: <20260127-axi-dac-cyclic-support-v1-0-b32daca4b3c7@analog.com>
In-Reply-To: <20260127-axi-dac-cyclic-support-v1-0-b32daca4b3c7@analog.com>
To: dmaengine@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769524107; l=1047;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=aTU9xL5dsmjMDpgb8es1E5jSSmA7HMSFgMKwQhyr59A=;
 b=TR2rHTx0MQaAMMQfYJIc6poHA9q7dyTjsxLRBCsrELI/OhqCnTzRqXix+KT7CTAc6fghbJuzE
 7VB16lGx84MBkKNMjfElFeNl4SZvW6pKo1bMRVduEMPe3SwJMkDpNDO
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8533-lists,dmaengine=lfdr.de,nuno.sa.analog.com];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	HAS_REPLYTO(0.00)[nuno.sa@analog.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:replyto,analog.com:email,analog.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2268895A4E
X-Rspamd-Action: no action

From: Nuno Sá <nuno.sa@analog.com>

Add support for cyclic transfers by checking the DMA_PREP_REPEAT
flag. If we do see it, close the loop and clear the flag for the last
segment (the same as we do for .device_prep_dma_cyclic().

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index f5caf75dc0e7..b083b6176593 100644
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
2.52.0



