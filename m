Return-Path: <dmaengine+bounces-9932-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA0HO1hN1mm8DQgAu9opvQ
	(envelope-from <dmaengine+bounces-9932-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Apr 2026 14:43:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 905D23BC55C
	for <lists+dmaengine@lfdr.de>; Wed, 08 Apr 2026 14:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 731403039828
	for <lists+dmaengine@lfdr.de>; Wed,  8 Apr 2026 12:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8EE263C8C;
	Wed,  8 Apr 2026 12:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZ92NwHp"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691C33C660E;
	Wed,  8 Apr 2026 12:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652112; cv=none; b=PnYzADbGK2LUB32ZLEIb2bHaGYd53SCce0i7p7xNGy8S+IbBE7CWVru3LHDbKR/8FpZp0spKTxJ0XmwW93rS7rg91cMPe0DEMBI9RT4yfWud4F5LhlHAmI5FtGss76LUKfTMFOjAKCVLpGxT0Zz71JAEPV4gQou1xJ/SsENlRb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652112; c=relaxed/simple;
	bh=09nJSRlAd6N1UqTYdtf9KSCV6nHMp6BK6/gYyYC5J8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GzjZh/vj3Ivy5xeO59C+NCOJsKgp2QT5gczgBaQS/udpnaNLgtqq6+c9gO/VL4ZYHmi6WzrMs+B+CbMUjnp7OxIEAHfKUBnUlK40XSfrFKC7smFbH1ZSx4b7Cn471iOluLN3THQV5IQ5YS2EnqtjiyOmlfflbdqd69mW1koscuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZ92NwHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01FCAC19424;
	Wed,  8 Apr 2026 12:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775652112;
	bh=09nJSRlAd6N1UqTYdtf9KSCV6nHMp6BK6/gYyYC5J8k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CZ92NwHp9kevRPMk08po5rN8gilb/coxsz11JyTia+9xFb7u/mvp3Np2qyPw5AvlH
	 3KP+MG0XjWN9BvVSvA1+GECtWBZ5NYBnKI7Ua2HJz3YvefRedLWHEUWaXeSHD6ihdn
	 7ChdmWOM7adcT9eVGWmpVEaPVd3+uQ8kSCFFUuz5WzbhGrPp38SIHTrgjnLgweILd2
	 ZsOsLUqOzRaTeo8cRGzG2fo6XmOY3pGDm5US9de82ZoJ95XyTkERftb4DAN38u432t
	 BgqdRhZTIfKXdFOIgMya3Czn0gilQKQzw274hlbakunMM10IpWlq9vn0cN3W7Hw1xz
	 0p44QDrdlRDKQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32951073CAB;
	Wed,  8 Apr 2026 12:41:51 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 08 Apr 2026 13:42:41 +0100
Subject: [PATCH v3 2/4] dmaengine: dma-axi-dmac: Properly free struct
 axi_dmac_desc
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260408-dma-dmac-handle-vunmap-v3-2-2456ad292154@analog.com>
References: <20260408-dma-dmac-handle-vunmap-v3-0-2456ad292154@analog.com>
In-Reply-To: <20260408-dma-dmac-handle-vunmap-v3-0-2456ad292154@analog.com>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775652161; l=889;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=FiW+zvQ0Vg5geNpbllXV8K8Pu2uQGa6K1A0veJRrIZI=;
 b=pGZW9OUn4eE29hNeUkXDCFnvqVaFshghoo22ssxsncbZV8gPmifgJEWB2pP3dYtmhoTfbvfWh
 6jj/ZNNg+fCAuUQq8AGXTtrF7iv2AT8xDl0aCLurO8uy4B2GOnlfv3y
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9932-lists,dmaengine=lfdr.de,nuno.sa.analog.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[nuno.sa@analog.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:email,analog.com:replyto,analog.com:mid]
X-Rspamd-Queue-Id: 905D23BC55C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Nuno Sá <nuno.sa@analog.com>

In axi_dmac_prep_peripheral_dma_vec() if we fail after calling
axi_dmac_alloc_desc(), we need to use axi_dmac_free_desc() to fully free
the descriptor.

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
2.53.0



