Return-Path: <dmaengine+bounces-11043-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKhrKDtTGmpE3AgAu9opvQ
	(envelope-from <dmaengine+bounces-11043-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 05:02:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 926AE60B05E
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 05:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C4C0530046A4
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 03:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BFD343891;
	Sat, 30 May 2026 03:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeOcj3Nt"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4B1175A66
	for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 03:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780110131; cv=none; b=a+JzszZ04iuqn0GxjybkuKAbAHSD09ldk1QKPnhhVi4Ytl6kPdph5XxzuGVTe5tFm7TPRjomPe8y/yPw7UKPOoxlG0QqM2YgaLBJ0V1XNYAtD6UNc5NYCCOfuaJXiBw+z6dO+bUoZoluQUU8tQemZqFda4cz+TnpT2DlvO9PyAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780110131; c=relaxed/simple;
	bh=6MC5Z+CZeXHDlr7J2cBLTyyetV1DPv3+TvICkqCetCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=omd2iL/uOMuNxfJlBVeFJgHzu50o6DH6ofs9tE7Mlbk2gQlYgQP1OBJhCkOQCdWiLacmQIz+0/uPJQ08L5xVqaN06D6NwBMLNWHxmqbi+4J84Yu9CkwNCWOPbL5vTkrMK/mKhjNtMO+pQ9eZrzb7RYv/MxWZJq0+44FruUcWPM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeOcj3Nt; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf237e1433so12570345ad.1
        for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 20:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780110130; x=1780714930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mwp5qGHEC1XkmLGeEsXpK32Xm3+UL5wsm4s/A2RF7JY=;
        b=aeOcj3NtfbwBIvyokSA33s8Z1KhRS5rMJah3sJPtLjjTqrfP0hXwShR7TbR/9mMLHh
         PTfL8BaiHHNc+fSG9LXIwW3tFgMuhJY4ju+euxZyIVo+mun28F5aeXUjfBRR5+Q7MW5F
         Gk6dLwi0o9v9R5FKbIQcbQHbDFQ1HsLHDZrqyuSQ3g7kQU6hE1whw+SGjSKhKG/FaQ53
         PdONyIEQXvx+XkBHt96p1QPpRYrMDbEZ4Ovs+UfLOXI+xbsY4WUYN843CSFnfjTDlKZo
         mQZkRggwaRH/jgxeBsUSDgWshyANTwGL+tOpZtkxcvmhBSrBs2hM2/X3SNXJrPni+fQ8
         B8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780110130; x=1780714930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mwp5qGHEC1XkmLGeEsXpK32Xm3+UL5wsm4s/A2RF7JY=;
        b=IknwgHrImsPlnawNyW8a0LO1whJ2eDgPmWb54dFpcgkj6NeaEmKHL9+RHx9qtM6cAm
         Pof/UBdQ2XPZgmFYlxSh6FUwooInTiWFSAZl8G4CP7dEogmsurQOgn+zOkX+ZNOE3Rps
         KlJzMB8DYqizM2GCc1VSp5I6YvNmvMKHuNHyCgkVu6bjFsUvwgVwyz6/AWP+TPyIzezG
         XOIp+xj/qCefD2xAR4ohUnDEYsITAvsBxKjn5J5OIXVKurv7oGSy5AmCT9Vz5eq+91NE
         hbIqRwarNI2kbwskVoO0OBkMkgBKQbNVrtf0wM+AamEidhoU5SeGDWv+vekh/f4S0mBJ
         9oJQ==
X-Gm-Message-State: AOJu0YyQc6H2P2jkHpBajXYuiq2vlANGmvpOvkUxIIBJXIFdfFcP+GpZ
	/hH7nXpXZLNou7m4cUCClE+TB0KmBnESGAsOEnYNHsEMVvCXG7z3jOa0BP5F1xBs
X-Gm-Gg: Acq92OG+0BVj3kE40E7UHLlJ/7eiROaCWXCD4JtIBso7fQlNxgWVoY4cpF7MlOnSd8X
	H+KKU+XmUuWVRDouAu2ubSskmVClOjo0cy/5mLK/t5WcRPCl7L+reLYjjEc//GHhDWBS9OeP30A
	Fjzgd/YbcryBfXAZnSGAGhoI8BasxnXA+i/iD8qpIQ2bbGeLBLK48KfKXLsaaTg4u50EI6decWP
	FNyv4fNjMQKV5NixJwZnzz/LEJ2BrtzUmY9J1Hpx7plJekY4FxKfw32ry00Uy40cFZ8F3nHFaaW
	Ht7X5HnCbi/8EKmTPOccSfYVyhRk2NGAm88aHbLFUgakvx2CCuwmtKCBIAL5DzCztVF59aVAZqw
	lbglp3fWruX1qOk7FKUhSSzD61So0qCHh7b6l8kr5DjPhOsE1wVMineLjSNqG63nlabUMNam6jU
	8NOIbcOOzDaOkcIlN/l9jY4MKqCNfkw5ORI3S5hBKwYcLRuCQYWCOmfxDRnb8dJWXQwEB//PzDt
	nOriqJg/SN5l1XlzAhOE0/B6tU6X3jaYCMAaQnxDQkP8Q==
X-Received: by 2002:a17:903:41c2:b0:2b2:6df1:1112 with SMTP id d9443c01a7336-2bf368d1b92mr27176235ad.40.1780110129873;
        Fri, 29 May 2026 20:02:09 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c26b3bsm34958975ad.64.2026.05.29.20.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 20:02:09 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] bestcomm/gen_bd: fix out-of-bounds access in PSC parameter lookup
Date: Fri, 29 May 2026 20:01:52 -0700
Message-ID: <20260530030152.49759-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11043-lists,dmaengine=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 926AE60B05E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The bcom_psc_params[] array has 6 entries (indices 0-5), but
bcom_psc_gen_bd_rx_init() checked against MPC52xx_PSC_MAXNUM which can
be 12 when CONFIG_PPC_MPC512x is set, allowing indices 6-11 to pass
and read past the array. The tx init function had no bounds check at
all.

A malformed device tree with a large cell-index could therefore trigger
an out-of-bounds read. The garbage initiator and ipr values would then
be used for MMIO writes via out_8(&bcom_eng->regs->ipr[...], ...),
potentially causing out-of-bounds MMIO accesses.

Fix both functions to use ARRAY_SIZE(bcom_psc_params) for the bounds
check.

Also remove a stray unused 'struct psc;' forward declaration in
bcom_psc_gen_bd_tx_init.

Assisted-by: Opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/bestcomm/gen_bd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/bestcomm/gen_bd.c b/drivers/dma/bestcomm/gen_bd.c
index 61b5746e1a97..00dfdc4b8eba 100644
--- a/drivers/dma/bestcomm/gen_bd.c
+++ b/drivers/dma/bestcomm/gen_bd.c
@@ -321,7 +321,7 @@ static const struct bcom_psc_params bcom_psc_params[] = {
 struct bcom_task * bcom_psc_gen_bd_rx_init(unsigned psc_num, int queue_len,
 					   phys_addr_t fifo, int maxbufsize)
 {
-	if (psc_num >= MPC52xx_PSC_MAXNUM)
+	if (psc_num >= ARRAY_SIZE(bcom_psc_params))
 		return NULL;
 
 	return bcom_gen_bd_rx_init(queue_len, fifo,
@@ -342,7 +342,9 @@ EXPORT_SYMBOL_GPL(bcom_psc_gen_bd_rx_init);
 struct bcom_task *
 bcom_psc_gen_bd_tx_init(unsigned psc_num, int queue_len, phys_addr_t fifo)
 {
-	struct psc;
+	if (psc_num >= ARRAY_SIZE(bcom_psc_params))
+		return NULL;
+
 	return bcom_gen_bd_tx_init(queue_len, fifo,
 				   bcom_psc_params[psc_num].tx_initiator,
 				   bcom_psc_params[psc_num].tx_ipr);
-- 
2.54.0


