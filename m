Return-Path: <dmaengine+bounces-9210-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +L45Izi3pmk7TAAAu9opvQ
	(envelope-from <dmaengine+bounces-9210-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 11:26:00 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0551ECA1C
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 11:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE5BD303E484
	for <lists+dmaengine@lfdr.de>; Tue,  3 Mar 2026 10:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB0F38236C;
	Tue,  3 Mar 2026 10:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tps+8lA8"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED31E37104C
	for <dmaengine@vger.kernel.org>; Tue,  3 Mar 2026 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772533458; cv=none; b=c/tGcp8SE5OsLXSEAmgBYfHpY9Izxxp/2IEaGq7ftMjbt+8vcmlmsOPzQOLFPDoy5pA/OSU08+iRGET6kefEM3jf4rwVr8PbHqDb76Uh2JAsRx+ujTE1q+rLgq+Z/d8hI5tphPOKFVpcgTb0zD1jspZvpiMExW8J+kw3qzYNx3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772533458; c=relaxed/simple;
	bh=d1gOkH/iou74P3jKC3QMWk+mZ1i2pxd2PmMirtYmE2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K0fwDw0AwoVlwh11PxESiluXoUaZlpCqeDC3cQ2sVVm2dZ5wuy0v4VJg3by5VY2XIDd3TRynEpwkuOBsWHkF96ECBdD4xWr9cczyC0vAcqVCuoMN+RvJ6n821birIRFTNd8jmDAy9LkGWZVgZn9TZWd3nr8laZVowUS7A8qQkcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tps+8lA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5A79C2BCAF;
	Tue,  3 Mar 2026 10:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772533457;
	bh=d1gOkH/iou74P3jKC3QMWk+mZ1i2pxd2PmMirtYmE2E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tps+8lA8rO7SEorWW2sg5gxUt+eWHyFIXgmZX3JGn1zQ0s0oAqXr7KWDlsszAPDb6
	 UnjIONyWK312HbSZ2G3hRbojnKGG7xq3SzKwyOczdHHgD5Ym8sQvQu2uvrqfoSatW2
	 aJOyplyl+xngZKRKTBoCHkrhCCdn8Hmf7TOtJ+GEW80lHSN7FSh2UukMRXUkitbAjS
	 TSWdm0dMwUzN2VBXo1CZDhh8biXV+jewdJiukPyTxZI+DFwHMq8Pic2KyMIcWt+CG8
	 1kPBmTFtjCs3EcTj2pgR6Z/qRQpUEe3G8Lqna2q1sJ8mtvgHCwNCV/AZhnhr7B44K6
	 jecB6BMB48Fbw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE6CE67A9E;
	Tue,  3 Mar 2026 10:24:17 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 03 Mar 2026 10:25:00 +0000
Subject: [PATCH v2 1/5] dmaengine: Document cyclic transfer for
 dmaengine_prep_peripheral_dma_vec()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260303-axi-dac-cyclic-support-v2-1-0db27b4be95a@analog.com>
References: <20260303-axi-dac-cyclic-support-v2-0-0db27b4be95a@analog.com>
In-Reply-To: <20260303-axi-dac-cyclic-support-v2-0-0db27b4be95a@analog.com>
To: dmaengine@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772533501; l=1098;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=yXia4IEm2OrW4b2StmsQIMPrlDDrPl69ZDlKQBbXA0M=;
 b=/EbZ36mt7Ai9+xXqnfOVx6Y5EmKpWpYL44PsbEKKO8BuPSDv41r2wH2AJMueOJgPs64LD+Jqb
 0FoNr/SCMc2BVG1KwE9/3SpFG6gl3ZQAsC2LEwE5ILSAr7h2mLC+ZjU
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com
X-Rspamd-Queue-Id: 0C0551ECA1C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9210-lists,dmaengine=lfdr.de,nuno.sa.analog.com];
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

Document that the DMA_PREP_REPEAT flag can be used with the
dmaengine_prep_peripheral_dma_vec() to mark a transfer as cyclic similar
to dmaengine_prep_dma_cyclic().

Reviewed-by: Frank Li <Frank.Li@nxp.com>
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
2.53.0



