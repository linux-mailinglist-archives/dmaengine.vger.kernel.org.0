Return-Path: <dmaengine+bounces-8535-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AM7hNn3LeGnBtQEAu9opvQ
	(envelope-from <dmaengine+bounces-8535-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 15:28:13 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8997895A5C
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 15:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C53B630193B0
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 14:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6819735B64A;
	Tue, 27 Jan 2026 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPzcuzho"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3176335B14C
	for <dmaengine@vger.kernel.org>; Tue, 27 Jan 2026 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524065; cv=none; b=Zkp3CGdvsfGqE2zTbYYs1zufNpPFTESGbRH5t3OoCbEphgXFFS2Vdb/JTQVkQNa60GQVtAB13wvCOyr+m0L5EouHFc06yan6UvaFJZlG8BrerTAwu7GaSDiyKRJVUidk4X1jOcFj9nH/ZePC06V44WlQKzSesMYLJNs6q8Xy06w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524065; c=relaxed/simple;
	bh=03z6USFxQ7v9N2EaJkyBHOwcbyi5uZun0BgUwupeUXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zutp4wysVrUot3Q6n/wGSm5B5qHdW8emIbglqYjqD0Otj69o3TIgDlUOnQODVtrIiIyuK4TgEXZR51x4pQRUwnaPoNHZhrVLOXNPnn1p6Nj+MraNveQc0UhWiV2nDJtsGTtpoAFGbraPrFO9oGATEt5pFS+GkDYsnYAw/dsbh3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPzcuzho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4631C16AAE;
	Tue, 27 Jan 2026 14:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769524064;
	bh=03z6USFxQ7v9N2EaJkyBHOwcbyi5uZun0BgUwupeUXY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kPzcuzhoq+ei4cJr90hk4fMc7Tip/wpvABgdNmCb38TvnrOcywhVyZblEJji5n/h0
	 9QSUEFiftlX+5skJYnMbRmWR+OVpQrSaY2f2cglT6K+eOnR/I02b4MWmLchnCsytlt
	 IY99vUlZGcBPbjSaFzWgFsDg2Xgm7t2ybFmnhFmPv437nMpW16DONtQzuM7Q2dgeLG
	 FGfvX6FLJZV9a/UGDsDohg0tFH67LEOPDcu8xkI3JXX36789ydotJyWR7ClNNrgaYO
	 UzfXObgVV1dLb8iZUwredNomdWXvMIezyYFvZvD8hMadwWWeDt3SB2U+0ccMSJWiOS
	 842ckdioR9RWQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB38D2F037;
	Tue, 27 Jan 2026 14:27:44 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 27 Jan 2026 14:28:22 +0000
Subject: [PATCH 1/5] dmaengine: Document cyclic transfer for
 dmaengine_prep_peripheral_dma_vec()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260127-axi-dac-cyclic-support-v1-1-b32daca4b3c7@analog.com>
References: <20260127-axi-dac-cyclic-support-v1-0-b32daca4b3c7@analog.com>
In-Reply-To: <20260127-axi-dac-cyclic-support-v1-0-b32daca4b3c7@analog.com>
To: dmaengine@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769524107; l=1056;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=BEZcMmBHOTRyRMifvwwtob/CQu0G30yF4zSIlGcRh/A=;
 b=+rj34g4ATJGfj27smTYYekoyiIGtId+A82QX3yUpTjSCgpcqfU1X2K1iNpCCQdbBUz499KR7k
 ntvXbYzqc0+ARbEZQFAbRTxI5HlS9djcLmDq0nt87xDrl590GLY1gsC
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8535-lists,dmaengine=lfdr.de,nuno.sa.analog.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	HAS_REPLYTO(0.00)[nuno.sa@analog.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:replyto,analog.com:email,analog.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8997895A5C
X-Rspamd-Action: no action

From: Nuno Sá <nuno.sa@analog.com>

Document that the DMA_PREP_REPEAT flag can be used with the
dmaengine_prep_peripheral_dma_vec() to mark a transfer as cyclic similar
to dmaengine_prep_dma_cyclic().

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 include/linux/dmaengine.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 99efe2b9b4ea..b3d251c9734e 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -996,7 +996,8 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_single(
  * @vecs: The array of DMA vectors that should be transferred
  * @nents: The number of DMA vectors in the array
  * @dir: Specifies the direction of the data transfer
- * @flags: DMA engine flags
+ * @flags: DMA engine flags - DMA_PREP_REPEAT can be used to mark a cyclic
+ *         DMA transfer
  */
 static inline struct dma_async_tx_descriptor *dmaengine_prep_peripheral_dma_vec(
 	struct dma_chan *chan, const struct dma_vec *vecs, size_t nents,

-- 
2.52.0



