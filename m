Return-Path: <dmaengine+bounces-9891-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPRoCDAN1GncqQcAu9opvQ
	(envelope-from <dmaengine+bounces-9891-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 06 Apr 2026 21:44:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 844DA3A6BDA
	for <lists+dmaengine@lfdr.de>; Mon, 06 Apr 2026 21:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FA8D3023DCF
	for <lists+dmaengine@lfdr.de>; Mon,  6 Apr 2026 19:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EEF322A;
	Mon,  6 Apr 2026 19:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlcThNXc"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6916438D008
	for <dmaengine@vger.kernel.org>; Mon,  6 Apr 2026 19:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775504685; cv=none; b=qSpQ49WuafNGuMWYdDxZNTOt7KVlEInGmFRjlhNakwt3LZ9gluAjP100vfwzz+ey9CHnhbBm7FqA8Rx8VS47GEr9dRHqglXQ+UgP4E0EgEKjumPfGM2hWoTaSqbqc8iq2namNKuq/QB1xb54ph+wVvJBEI2NaOYK768DNegIEEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775504685; c=relaxed/simple;
	bh=GR2DfTz553Yog8V3bm8Wviid+hmeEqLWZb0hdHRbJqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S1d/r+NsCYy6Grhm93vYUAA7oWISqrtYLhSTiLmdyabsSoH4RpXJSantttGUzEGvFAT6NnEg4m9R8WRDrW4u54SPPuslfwSBnsy2ciFXFFI71I0lnrA1PJR+IMApP08Ubg0ltcavu8SKP2Mp9YU5hZEuCqUkClChkulMx7NxRbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlcThNXc; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-89fc4147f2eso56759456d6.3
        for <dmaengine@vger.kernel.org>; Mon, 06 Apr 2026 12:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775504683; x=1776109483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8TKUkyB7WvjQA6crvLqj/5jSGIGyrb8D9bz30WYCfA4=;
        b=AlcThNXcUsJCE30LnfdKvG6lIi7PWMEKIoNJhnHzSxnSS4FpaACodnbUh6m6C7/nEc
         dcvsXCL4VqINHvBuT3o/IIroQyhsCovZ5z/KhQ7ug/tR137nWPj6hyqB/IKzlNqlLBgA
         WwoQZmvA19bBXFagJG8NBvQumw5eftu2x/RzS5fs/5yR2oQxR2MBKa4FLEC/78jTVU7I
         mO3xa1ImnGCw4ZT9VonelXB2Ot2ZkZE8r2UnLJMh/UK72oSlk62LB8cNqxogrQmBRfa4
         XPohfquQRbxvNwg15l07kFQ0jriekKFXil9xgHMiyHYAy8KK2mRmh5+ji33z0p16ymTk
         MZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775504683; x=1776109483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TKUkyB7WvjQA6crvLqj/5jSGIGyrb8D9bz30WYCfA4=;
        b=pPFrxbK585QwND0dWdJo36fKJlWeHW02YXkhVk/A1mBDmaynuzjgr4xCaBAeeVc5RF
         dwwtUJPv/Th7kvYI8FzUcMHLgdgnrtrHv9rMi+cRvu6WY5uH5eVYibbRMEf94YzgbxoF
         0NxjaeJKuP9CLKx4GwknSB5KYn7icKnu7VKK7bKrzKsg2DNUmn6Ywaru9QTd7vwsmSfL
         vrxlzyOiEsXpdgkvxJoHmjSeUmunP7TUiCkC9qwiitqkuaXDcoRcmd+gjNb+TazO1B98
         X5eE6EcHK/qHO6yY5OkTHCWaeE5AB6L+ZutrRGpTvw8sRqtLE4OaEhqryHfQmjOOrXs1
         RAgg==
X-Gm-Message-State: AOJu0YxGbFceoWfXPKTERFJORcGbkSpTk3a252IOo8tv30dNshdAPwdN
	50AUKGiASFxaDHNoPm2B5gaXL38wgE0UieiMmbRxIoh7InoO+zNb8rncerYSoA==
X-Gm-Gg: AeBDieszCau0+eyhQmbSOhdIFyxFlDjWSLYXx6jwIkaB7ngyrD91su/tOezhnN3tcZs
	C5m3YEheJbCLOrEr2Gj0MMcpUwajmmSECJ6T26B5dNi2Ph+E7/MPImlrcqhbLG7E2T7TxEnoy/S
	d8ssNKccMD9EoMnAq2LuGamqmRUf2OubIohsL/5/3Dv78SE/hXJM2SQTvPKKa9Gb7oCNIOW3KWn
	sxX1mcyu7FB2tshakCAMnc65e0padDGi2E06r1Wn6bB9K83eOIgXWnUDKLwhUO4NjX5SRdQ9AXq
	MVqK13HS+4fKGbgfR8UclJVAOKrnkQTemj3Vg5lDWQ6s484ZBXKRuEjvzAa1w5OG6w8cvysVXEy
	J1TS9ErCYh/7Cgq4PSaMaQGEXa3CArRnG+QZIlU1Iwnxa3DxX7QpE5ipGr83Ky4h1n2qvbbd7Lg
	WNxaD1pIO6sPJzg0i/Y79uXQKqVPpIoEuncuTxEqXMvFY+uBbGvH254dI=
X-Received: by 2002:a05:6214:f0c:b0:89c:c668:9d3a with SMTP id 6a1803df08f44-8a7022bb7c9mr241401586d6.12.1775504682954;
        Mon, 06 Apr 2026 12:44:42 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a5969156d3sm129833856d6.31.2026.04.06.12.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 12:44:42 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2] dmaengine: dw-axi-dmac: simplify allocation
Date: Mon,  6 Apr 2026 12:44:24 -0700
Message-ID: <20260406194424.13365-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9891-lists,dmaengine=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 844DA3A6BDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use a flexible array member with kzalloc_flex() to combine allocations.

Add __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: use () for kzalloc_flex in description.
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 8 +-------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          | 4 ++--
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 4d53f077e9d2..d3ca202dc478 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -294,15 +294,10 @@ static struct axi_dma_desc *axi_desc_alloc(u32 num)
 {
 	struct axi_dma_desc *desc;
 
-	desc = kzalloc_obj(*desc, GFP_NOWAIT);
+	desc = kzalloc_flex(*desc, hw_desc, num, GFP_NOWAIT);
 	if (!desc)
 		return NULL;
 
-	desc->hw_desc = kzalloc_objs(*desc->hw_desc, num, GFP_NOWAIT);
-	if (!desc->hw_desc) {
-		kfree(desc);
-		return NULL;
-	}
 	desc->nr_hw_descs = num;
 
 	return desc;
@@ -339,7 +334,6 @@ static void axi_desc_put(struct axi_dma_desc *desc)
 		dma_pool_free(chan->desc_pool, hw_desc->lli, hw_desc->llp);
 	}
 
-	kfree(desc->hw_desc);
 	kfree(desc);
 	atomic_sub(descs_put, &chan->descs_allocated);
 	dev_vdbg(chan2dev(chan), "%s: %d descs put, %d still allocated\n",
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index 67cc199e24d1..a04a4e03eb3d 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -98,14 +98,14 @@ struct axi_dma_hw_desc {
 };
 
 struct axi_dma_desc {
-	struct axi_dma_hw_desc	*hw_desc;
-
 	struct virt_dma_desc		vd;
 	struct axi_dma_chan		*chan;
 	u32				completed_blocks;
 	u32				length;
 	u32				period_len;
 	u32				nr_hw_descs;
+
+	struct axi_dma_hw_desc		hw_desc[] __counted_by(nr_hw_descs);
 };
 
 struct axi_dma_chan_config {
-- 
2.53.0


