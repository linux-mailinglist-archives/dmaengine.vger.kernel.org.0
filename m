Return-Path: <dmaengine+bounces-9692-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKQXFSa3xmnoNwUAu9opvQ
	(envelope-from <dmaengine+bounces-9692-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 27 Mar 2026 17:58:14 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 354D8347F4A
	for <lists+dmaengine@lfdr.de>; Fri, 27 Mar 2026 17:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA31C3038438
	for <lists+dmaengine@lfdr.de>; Fri, 27 Mar 2026 16:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E693644C3;
	Fri, 27 Mar 2026 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmvUqzyw"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09CD3644A5;
	Fri, 27 Mar 2026 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630672; cv=none; b=iujLfjfmDwutYtAFaaeUB7UIl7aqHeuQpahuByGyEq3Ll6UFQgM50xI3JwpWenclfVhY+E9h2U3XFM5K1awNRxSWE1bL665h1Xe7PFu5D+hODXwW50hHY4Qx3pAY10GB+8bBHBqO4dSkltrTWrOAW0ZktCfzcacTa9sQAfX3rMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630672; c=relaxed/simple;
	bh=tM8m65XuDlt5RZNy9a9VEBHaYpJqz9qh0EbGJHjxdUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DEeQDGPb76XOkN1blenqRKmuV27G468GWlAlVTHFfCt/8KNm4rcMUEelK+SgHqvBsrFJbIuMxuSsyaZtHlA+3gQ2d8NhCjxesBJFZSyUVRzK4ZEaj3stMUKxwz6uRADCvnJbVFLqMsONWoRO4Me6UG+lD2TIWgcz1ha55G+duAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmvUqzyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 863A4C19424;
	Fri, 27 Mar 2026 16:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774630672;
	bh=tM8m65XuDlt5RZNy9a9VEBHaYpJqz9qh0EbGJHjxdUg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PmvUqzywgeB3j3SvznZcAElB7X6aZV+dSd9k2cKIrbwPKpocqmKhIDrkhant/Ufke
	 nOLxpCTXUEFXBmIjlmUsGLN6xcoGUQv20pOx5kuLmspWIYMYgozzXW0IhkCKE+XWQF
	 a045j/9pPEEUz5clva7LQyzckoduQgVt/4Ps3/F3NzPHw7OvRtv9MC5q9Ac3CoWElk
	 GllfykrmLXY8QU9qgIg2zgRsEqMT86k90tjFgbWr5LF4OMiHXWQnAYqb5aoi7CfuEj
	 5gI6fRWFK4Rh5lf13qmwGDQlmGw7jlI6l1iN5FH7dbKmEKbRMCRusgPMlYdpBPmpS+
	 3Xtlm5z8Y/lZA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B67010F284F;
	Fri, 27 Mar 2026 16:57:52 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 27 Mar 2026 16:58:38 +0000
Subject: [PATCH v2 1/4] dmaengine: Fix possuible use after free
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260327-dma-dmac-handle-vunmap-v2-1-021f95f0e87b@analog.com>
References: <20260327-dma-dmac-handle-vunmap-v2-0-021f95f0e87b@analog.com>
In-Reply-To: <20260327-dma-dmac-handle-vunmap-v2-0-021f95f0e87b@analog.com>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774630718; l=1349;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=6XbKWWnu/XLY2+T0r/woFDDSj9C/H1ATZbhK/NSCskE=;
 b=lXIMTGocwl8/MP1F1RFhzO+xdmSHtDqB5OsyHuXX7vOGHAs5bnJFZFrvijo0zWLpG5AdmoPFy
 Tg9faofxAzMDjhJakLfrZRqrfhfBLEzcqakWAtNGROYiF+dx9Dm4FeA
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9692-lists,dmaengine=lfdr.de,nuno.sa.analog.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[nuno.sa@analog.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,analog.com:email,analog.com:replyto,analog.com:mid]
X-Rspamd-Queue-Id: 354D8347F4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Nuno Sá <nuno.sa@analog.com>

In dma_release_channel(), we first called dma_chan_put() and then
checked chan->device->privatecnt for possibly clearing DMA_PRIVATE.
However, dma_chan_put() will call dma_device_put() which could,
potentially (if the DMA provider is already gone for example),
release the last reference of the device and hence freeing
the it.

Fix it, by doing the check before calling dma_chan_put().

Fixes: 0f571515c332 ("dmaengine: Add privatecnt to revert DMA_PRIVATE property")
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dmaengine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 405bd2fbb4a3..9049171df857 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -905,11 +905,12 @@ void dma_release_channel(struct dma_chan *chan)
 	mutex_lock(&dma_list_mutex);
 	WARN_ONCE(chan->client_count != 1,
 		  "chan reference count %d != 1\n", chan->client_count);
-	dma_chan_put(chan);
 	/* drop PRIVATE cap enabled by __dma_request_channel() */
 	if (--chan->device->privatecnt == 0)
 		dma_cap_clear(DMA_PRIVATE, chan->device->cap_mask);
 
+	dma_chan_put(chan);
+
 	if (chan->slave) {
 		sysfs_remove_link(&chan->dev->device.kobj, DMA_SLAVE_NAME);
 		sysfs_remove_link(&chan->slave->kobj, chan->name);

-- 
2.53.0



