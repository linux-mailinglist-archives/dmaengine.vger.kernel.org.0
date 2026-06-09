Return-Path: <dmaengine+bounces-11372-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1LF+B1iSKGqkGQMAu9opvQ
	(envelope-from <dmaengine+bounces-11372-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:23:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 861696648AE
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:23:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VWauepGf;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11372-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11372-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84BAF301A438
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2026 22:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D89737D133;
	Tue,  9 Jun 2026 22:20:16 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FED54D2EF1
	for <dmaengine@vger.kernel.org>; Tue,  9 Jun 2026 22:20:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781043616; cv=none; b=nWzkBMR2jSrmNNZ0+Pg+rjpZ7ixGYTni+f1TSYLhK3y08S5T3ozCn1quV6ITg8o7Be2uIO1SpSCiOhxDYavCt1mocCOR3e00h7iQ0sZZuvpUsHvppHE8tEF9LfkZkCt57aP9xG/GQXkChetHT5+RfADgmyPg7HG6XTOBizVWGbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781043616; c=relaxed/simple;
	bh=9Yea6xTnMAtPCPNuS9VV3xysMhmXAvdi4sueisMN3io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAqasddKHdcPLkrTC6zQYNUB9GpvWWYmOhqOuFA2pFiqfpWNQLLVo++6AYLUUSQbt5HHE0GPql+gQZZXvtmoH7Ri/jOyrp1rKYHAKErRhTIzaqJkSYu7bBa+mqlMcakTv/UG4jVC+UJbfqpnIB/15T9nv/36okho084+exL3Bik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWauepGf; arc=none smtp.client-ip=209.85.216.53
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36da8439078so5404453a91.2
        for <dmaengine@vger.kernel.org>; Tue, 09 Jun 2026 15:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043614; x=1781648414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7abx5gUeKQ1VRxaWBSzbzTorD8zfPoqeElZR6g6xg44=;
        b=VWauepGfrsCMINXFx+icD3YiflHTFMgH8mD3+Nvr6QR41UOr0CFC1tsDgO5uugKnS/
         6zOx3NEBW2m303t8b4F51gY5xAOPlE5EkX0k3tRTE2QL1P5FtIpVye01bdEBkkuV/Mym
         kJBzsPc8inemI0RLGDP3NLw7blUURy5t1B2AXhrOBrWaZrwMg0IusQPWUBM4o5hFWIWd
         RQv6bGYvWP7sW6q34IBNLrPxmZvvKn0kf5ukGdZm9d96kSErADNzFvNtcu55fdvHrCSG
         g4asjeaFyrOyZ21juY0R6EgZxgG+5qfo90ewfRPr6cq31bRJ4fuMq8/emNobZ6Sn5m8q
         q75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043614; x=1781648414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7abx5gUeKQ1VRxaWBSzbzTorD8zfPoqeElZR6g6xg44=;
        b=Kt0mgCvKQCiwXNkvdtLEhnA/L79Z1TtQZiF5OuwoN+Rigp6zz9DsNydUndvwBjJsmy
         8GGh4FhrPrRh7AJLjuX9BGMHGL5Jmedxje+OWLQABkB7l2U+K28c+Jnh/yms0Dxnne+0
         5VudFuHaBby5cvr36xC22SHXsTa/eAmPN4YP+zqQuXV3iQDrqfnGvSgwTOlsimRlPpEK
         Cubk0qGsrlc4p22bfNU9SMDSUmmUl85Svf6Q+SqAiodqyxrfnVDBehVCcS6ZAdnU2W5f
         YvL5+0exzHMjl36ueUEGLgPibZ0nz7AUTksd7Q251SGVWTWsiDzB45Ou8ttetnkovnzR
         b4Nw==
X-Gm-Message-State: AOJu0YxFsS5roTl2Aq6u8xGOf5cIUo5scuRTx7y/N2IhLppUuzw1MLAh
	/culAd0GB22RZy+wNtKEgcXC9vidbtfdtWbkfKBFalRwIbQpOnxjPRUdTmG3wnph
X-Gm-Gg: Acq92OH7uujXZac4MQFS98XTsObpJT6IXv1IGhJRLgcONttgiIy8er/F2/qfPS9y+hA
	8Cv0xZNNsEmHsY6kFM39ets4A3LYXNaHhe/Oeey0VBTgTJS22m6dYmiIup/gsOCCdr4JQRRLM2p
	4NLft/G773nImrspRvZnL2YOPkIglN8EEfKWwEmtr527nTFjkX1+FVevKHiaAbqlzfPlA3qMHot
	gnfHm9OBIgThePQtbZREorkIidFIzaVjNtgcoinZTvp1s0ncTEQFx7yW2AZRud4C6G0th5KKpj7
	h43aBwhH93pvlkFDbcz2NMKE+XESkPlF0uR6Jd4vkncv8LW1GPLLqBx0vSFAZUeU/ScdYBEcS06
	D83lF1wClC4tolT/mEPpvxhfFNPHu5yqR19B/TK1UyLafTBXFxzgrOvGXVTQJtf9uUsYzSJgEJ8
	zP+5btsd7f+xBrhp7gsmtIPfTVlADA8meVpQGRpdXv6zrdztJ36/IQEYfGF2vL5+6MIBy59MGys
	b1Pe3VS0RtUmMqjyl0o3pWATEbx9mXh9y6TTIVXbgpJKHg3dWX6bTEV
X-Received: by 2002:a17:90b:5204:b0:36d:df4f:ab2 with SMTP id 98e67ed59e1d1-370f0772dd1mr26545593a91.13.1781043614688;
        Tue, 09 Jun 2026 15:20:14 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04ff24sm19661834a12.14.2026.06.09.15.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:20:14 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Zhang Wei <zw@zh-kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE DMA DRIVER),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCHv3 15/15] dmaengine: fsldma: fix kernel-doc param names to match function signatures
Date: Tue,  9 Jun 2026 15:19:26 -0700
Message-ID: <20260609221926.35538-16-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609221926.35538-1-rosenp@gmail.com>
References: <20260609221926.35538-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zh-kernel.org,gmail.com,google.com,vger.kernel.org,lists.ozlabs.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11372-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:zw@zh-kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 861696648AE

Fix kernel-doc warnings where the documented parameter names
(@chan) no longer match the actual function signatures (@dchan),
and add the missing @cookie and @txstate parameters to
fsl_tx_status.

These are pre-existing mismatches that predate the recent
devm conversion series.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index d4c9b81ade0d..c0dbcd09999e 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -685,7 +685,7 @@ static void fsldma_cleanup_descriptors(struct fsldma_chan *chan)
 
 /**
  * fsl_dma_alloc_chan_resources - Allocate resources for DMA channel.
- * @chan : Freescale DMA channel
+ * @dchan : Freescale DMA channel
  *
  * This function will create a dma pool for descriptor allocation.
  *
@@ -742,7 +742,7 @@ static void fsldma_free_desc_list_reverse(struct fsldma_chan *chan,
 
 /**
  * fsl_dma_free_chan_resources - Free all resources of the channel.
- * @chan : Freescale DMA channel
+ * @dchan : Freescale DMA channel
  */
 static void fsl_dma_free_chan_resources(struct dma_chan *dchan)
 {
@@ -878,7 +878,7 @@ static int fsl_dma_device_config(struct dma_chan *dchan,
 
 /**
  * fsl_dma_memcpy_issue_pending - Issue the DMA start command
- * @chan : Freescale DMA channel
+ * @dchan : Freescale DMA channel
  */
 static void fsl_dma_memcpy_issue_pending(struct dma_chan *dchan)
 {
@@ -891,7 +891,9 @@ static void fsl_dma_memcpy_issue_pending(struct dma_chan *dchan)
 
 /**
  * fsl_tx_status - Determine the DMA status
- * @chan : Freescale DMA channel
+ * @dchan : Freescale DMA channel
+ * @cookie : DMA transaction identifier
+ * @txstate : DMA transaction state
  */
 static enum dma_status fsl_tx_status(struct dma_chan *dchan,
 					dma_cookie_t cookie,
-- 
2.54.0


