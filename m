Return-Path: <dmaengine+bounces-9700-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIZ5JNBDx2mSUwUAu9opvQ
	(envelope-from <dmaengine+bounces-9700-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 28 Mar 2026 03:58:24 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 732E634D1D8
	for <lists+dmaengine@lfdr.de>; Sat, 28 Mar 2026 03:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51CB730550B5
	for <lists+dmaengine@lfdr.de>; Sat, 28 Mar 2026 02:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC4270810;
	Sat, 28 Mar 2026 02:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AU9kc0le"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9273A35A383
	for <dmaengine@vger.kernel.org>; Sat, 28 Mar 2026 02:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774666639; cv=none; b=dXz09l03RnaxGgX2f1nwJAnf/Vq9CNamAvah3XUJKHDoQQ3I9FtxQpSt0cV3DizWETxWMfX04nlbJ0K8cmWf8fsvSP+ct+h7X5D82zK6TeHib57qpMWGEaNbSEkr1qkoaGnvQ6k+O/F9+10sAJ0oQbI9Nh01FCGYF66Kjs/3n/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774666639; c=relaxed/simple;
	bh=+tSHHgSHCm6FxyiQVm7rgCXztzsdZcy8uAoLh8o0wl0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mEdU/kJu59ir4pjQo+wBKNS1jSChmE0UDHrBz0UaspCiBcR+sqaCID8WuZKsr/cdvdKz8m1NlQowWILRkwz137UkuhuMMhQY5Ax0OKM1BAqROtK5AL0Tado5+QMObSr4yjDc7ttul5sZCdqh8ZFgmZGUHMAAz0rJRO8THm49Uoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AU9kc0le; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b0b0064027so17029425ad.3
        for <dmaengine@vger.kernel.org>; Fri, 27 Mar 2026 19:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774666638; x=1775271438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=huQ/DnSJjWkOQFDa2nPbARuFb5hfAPwh1SD0p5XINsw=;
        b=AU9kc0leXuQdDPAMkRu+CXgMLfnpITi2pOgIojozfNXpr8MK2hyY0ILIhrlYAN+akt
         FTTt/lEVGGGB4YvgIKCciN73lvrV52dje0yTRjn3J+pbZMdTO/4FT7kLcbhv9ihQQ7xL
         cUPbT+U3QqyV1iPjahmO69HekbApN8nC9+a0yLef+me0ob989tVr+QSvpvRyqD4VoDjE
         rvI+x4pkkAIZnHihM7qFwoDAYPwpGrGbZ8TWeJOkXjH6+XIoxXzS2ooEM4CPuYZ5L0Ie
         oIjvfqyHHc6MiJ13wyf1pnIYoi6BkjQlKhC0Zv51G6rR4ZAKBDES/2PXngRgsdXI8CLS
         W2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774666638; x=1775271438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=huQ/DnSJjWkOQFDa2nPbARuFb5hfAPwh1SD0p5XINsw=;
        b=HB5ttq3HAJcOkcl1WrKH01ahmpXKe5LDeyhAFmprhegpBfH0o9ycRcFxQKZG+1msRK
         KCip2YSK6aeMo37n0TfWLc/ODdFG4PcuRy1vWIuOD+zaQ7Y+oIq2QDq6oTACYxAIgPLM
         OSWTUO6DBWTsIDui0q6Uou51Kcy7RBuvSm9weJHyI8kMp7vyd3vjQeG7K7gmHDnjFcqa
         XdtMee+wsjAWuGUe0nAxn/a6O8vLybF62l0Lu2I6K7B8qRAa1NizADN7d5B+aed/QGc+
         2pVNOcBQhgKboTecOvS5wew8x4IC13Fdvl+AYpd4AzLMVJR+iwp3k+lXqoMWsInQ1P+r
         1T7g==
X-Forwarded-Encrypted: i=1; AJvYcCVUgLZwkAb5z3Eipm5NYNM5p95b2izRxAyzedUzp/zVhNEezgqGec5SmAEshEcmOwgCgYL0hj7FY1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfBtD/0WVX46/nsKzP2HyPQxA/LMGV4IOfYMmtJH8XJmZtVvSY
	14LSPoJ1hUMogMvi9tkYnosGAoBoj9+9cX/6EbDjkRpXrUaxZHv6SS0bLD4Fuw==
X-Gm-Gg: ATEYQzyMzT7S8JccnLS938uKz4bJZMp4oaSbacY4CeNbK11TfbAZgzmZ1ZCsbmXjALk
	au/S9tWGpuUO82pEBe0DnZkXzWJWFYuWRQhIaQWg3HTNsfKqtC7/oy1HcBpEaX/2yPO0ldqrF0u
	9u4UU2WTrr15BbjIrszyaeL2cLEOj441MxKMWVia1ZxwfL/DXIMzc39pKMgQtuXKnu8hn2RmZMc
	3tYY6qLBy38Xc0XMopQS6pPtThBDs5e0YV6iO6SewOoSvKbcyTp7yP11MmxPZYkM69u64j9Snky
	ri/ti9jppWDy4f3YbDQMnuBj59zsEkr8CMgzZJR2dvP0LvfHm5xmgfYaZ+qGLQjWPWyv6Dj1aBZ
	BryAu8feU8YZAkvEMT6nDxOBFsaN4uO01AgVPm1SZ8Dwkk29WYow4ifPEcUuRp9IJR4GGM7Z4gq
	z9YlzShyNaagYbA2gpQMMFPfvc3UHI+LYickFF/eJauJKJwSblvYc+OuiOjA==
X-Received: by 2002:a17:902:d487:b0:2ae:6579:4795 with SMTP id d9443c01a7336-2b0cdc5f3ddmr49237805ad.21.1774666637758;
        Fri, 27 Mar 2026 19:57:17 -0700 (PDT)
Received: from localhost.localdomain ([60.49.20.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24277fb50sm7194835ad.56.2026.03.27.19.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 19:57:17 -0700 (PDT)
From: Khairul Anuar Romli <karom.9560@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus.Elfring@web.de,
	Khairul Anuar Romli <karom.9560@gmail.com>
Subject: [PATCH 2/3] dmaengine: dw-axi-dmac: fix Lines should not end with a '(' warning
Date: Sat, 28 Mar 2026 10:56:56 +0800
Message-ID: <20260328025706.52722-3-karom.9560@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328025706.52722-1-karom.9560@gmail.com>
References: <20260328025706.52722-1-karom.9560@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9700-lists,dmaengine=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[metafoo.de,kernel.org,vger.kernel.org,web.de,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[karom9560@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[checkpatch.pl:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 732E634D1D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

    checkpatch.pl --strict reports a CHECK warning in dw-axi-dmac.c:

      CHECK: Alignment should match open parenthesis

    This warning occurs when multi-line function calls or expressions have
    continuation lines that don't properly align with the opening
    parenthesis position.

    Fixes all instances in dw-axi-dmac.c where lines were ended with '('.
    Proper alignment improves code readability and maintainability by
    making parameter lists visually consistent across the kernel codebase.

Fixes: 0e3b67b348b8 ("dmaengine: Add support for the Analog Devices AXI-DMAC DMA controller")
Signed-off-by: Khairul Anuar Romli <karom.9560@gmail.com>
---
 drivers/dma/dma-axi-dmac.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 0017f4dc6dcc..49e59a534e22 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -789,10 +789,10 @@ axi_dmac_prep_peripheral_dma_vec(struct dma_chan *c, const struct dma_vec *vecs,
 	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
 }
 
-static struct dma_async_tx_descriptor *axi_dmac_prep_slave_sg(
-	struct dma_chan *c, struct scatterlist *sgl,
-	unsigned int sg_len, enum dma_transfer_direction direction,
-	unsigned long flags, void *context)
+static struct dma_async_tx_descriptor *
+axi_dmac_prep_slave_sg(struct dma_chan *c, struct scatterlist *sgl,
+		       unsigned int sg_len, enum dma_transfer_direction direction,
+		       unsigned long flags, void *context)
 {
 	struct axi_dmac_chan *chan = to_axi_dmac_chan(c);
 	struct axi_dmac_desc *desc;
@@ -827,10 +827,10 @@ static struct dma_async_tx_descriptor *axi_dmac_prep_slave_sg(
 	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
 }
 
-static struct dma_async_tx_descriptor *axi_dmac_prep_dma_cyclic(
-	struct dma_chan *c, dma_addr_t buf_addr, size_t buf_len,
-	size_t period_len, enum dma_transfer_direction direction,
-	unsigned long flags)
+static struct dma_async_tx_descriptor *
+axi_dmac_prep_dma_cyclic(struct dma_chan *c, dma_addr_t buf_addr, size_t buf_len,
+			 size_t period_len, enum dma_transfer_direction direction,
+			 unsigned long flags)
 {
 	struct axi_dmac_chan *chan = to_axi_dmac_chan(c);
 	struct axi_dmac_desc *desc;
@@ -866,9 +866,9 @@ static struct dma_async_tx_descriptor *axi_dmac_prep_dma_cyclic(
 	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
 }
 
-static struct dma_async_tx_descriptor *axi_dmac_prep_interleaved(
-	struct dma_chan *c, struct dma_interleaved_template *xt,
-	unsigned long flags)
+static struct dma_async_tx_descriptor *
+axi_dmac_prep_interleaved(struct dma_chan *c, struct dma_interleaved_template *xt,
+			  unsigned long flags)
 {
 	struct axi_dmac_chan *chan = to_axi_dmac_chan(c);
 	struct axi_dmac_desc *desc;
-- 
2.43.0


