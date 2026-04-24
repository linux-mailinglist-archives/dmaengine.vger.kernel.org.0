Return-Path: <dmaengine+bounces-10115-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG5jA8+q62nfQAAAu9opvQ
	(envelope-from <dmaengine+bounces-10115-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 19:39:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D4C462098
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 19:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E00A3007AEF
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 17:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2C43E0C70;
	Fri, 24 Apr 2026 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQG+t0wZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A18346760;
	Fri, 24 Apr 2026 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777052364; cv=none; b=OQT+bW//0Go7+Nl29RvD5qqMNo3uf71phLcvvxCh2026ofW8OIqmKRYp+N9SBav1y0csTKxxwGHYwbDSjYS5D6w66wlZfQQZvovpZ3xuuTTrhDWjIvz2gJrQrDUcvck77FxWRgbPuLQG/unbJ16uzMQOQCzpBFBolr4Uz1TKTcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777052364; c=relaxed/simple;
	bh=cDLJpFn92CqJTxMH9bk80u6JF/HxsNTgQn9D8LmRdGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ajl9eNRJBxxVbMJTbWoMD/4TDCEIorw2HEOKQeBZ8ND9qLesTQ5mlENt1cKmKXpAAkhmdEX9qNNDgrqAyHjG8MOh8EG3abywUWnvUYG955UABXqn4RJtn5XB8CvN6+xz9URzNGFIVrPjG04RHb/U60QMe1ElOm3cxCNMfI7gDSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQG+t0wZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C73FC2BCB0;
	Fri, 24 Apr 2026 17:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777052364;
	bh=cDLJpFn92CqJTxMH9bk80u6JF/HxsNTgQn9D8LmRdGY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XQG+t0wZoNccYos5sPAvALZBFs3h0mQLyNDpXVSYm1BJh2T89DomHSqq83Hdyha3l
	 HQeWs0G9GEbU/XozNTI6Tjf4JArn8B2g3jpshSKB0L8nPPiWAFyjtnFnqc5piEFIGC
	 dCPrRATkcui+pGmrg7XPm/z0Bw7Tw64nEF0S+JMj7Eyf1yYQidv835AeZ9mLr0yRJ4
	 019zKoQMm3lcXcZClkAPnR4DRCtyuF10kb+F+iJddxsMulhPeYpHevKqqyPLHI1hIX
	 wRdZunJHhGXn+Y3yR3Hgs/p+IhgHlb9VBWtii4dFE+wmf+f98ff8xqOG/87vCJdyX3
	 tL2czIAiuFH7A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030B6FED3F2;
	Fri, 24 Apr 2026 17:39:24 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 24 Apr 2026 18:40:15 +0100
Subject: [PATCH v4 2/4] dmaengine: dma-axi-dmac: Properly free struct
 axi_dmac_desc
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260424-dma-dmac-handle-vunmap-v4-2-90f43412fdc0@analog.com>
References: <20260424-dma-dmac-handle-vunmap-v4-0-90f43412fdc0@analog.com>
In-Reply-To: <20260424-dma-dmac-handle-vunmap-v4-0-90f43412fdc0@analog.com>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777052415; l=874;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=B1ajbF20z574tNU6MkzXpQc/3VcoJk7X7LFl6JpZA+I=;
 b=Nk9EiMQtLm+6ZmUJeNmaI3JuixJVaUoxMeiVYrFhwKSQYe3C2gni+dEN3JcG95uWAB3gjCA9J
 WOoISnGYxZvCdaqLeUPLRAHdgDXo3hK+nH4urVI2lns7ilca1aBM9n3
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com
X-Rspamd-Queue-Id: 77D4C462098
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10115-lists,dmaengine=lfdr.de,nuno.sa.analog.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[nuno.sa@analog.com]

From: Nuno Sá <nuno.sa@analog.com>

Use axi_dmac_free_desc() to free fully the descriptor at fail path when
call axi_dmac_alloc_desc() in axi_dmac_prep_peripheral_dma_vec().

Fixes: 74609e568670 ("dmaengine: dma-axi-dmac: Implement device_prep_peripheral_dma_vec")
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 45c2c8e4bc45..127c3cf80a0e 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -769,7 +769,7 @@ axi_dmac_prep_peripheral_dma_vec(struct dma_chan *c, const struct dma_vec *vecs,
 	for (i = 0; i < nb; i++) {
 		if (!axi_dmac_check_addr(chan, vecs[i].addr) ||
 		    !axi_dmac_check_len(chan, vecs[i].len)) {
-			kfree(desc);
+			axi_dmac_free_desc(desc);
 			return NULL;
 		}
 

-- 
2.54.0



