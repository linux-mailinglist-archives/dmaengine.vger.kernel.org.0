Return-Path: <dmaengine+bounces-11362-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xAjbGiiSKGqhGQMAu9opvQ
	(envelope-from <dmaengine+bounces-11362-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:22:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB596648A2
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:22:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZTC+94mi;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11362-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11362-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 211D230DBE66
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2026 22:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765BE3FE348;
	Tue,  9 Jun 2026 22:19:57 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82984403B1E
	for <dmaengine@vger.kernel.org>; Tue,  9 Jun 2026 22:19:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781043597; cv=none; b=b9RHVGi2S6OWewPl41cGe3+7IJ0EnATvU5N1TlaN6pCNhgjSYn9J54uM+CAjRbvaEj+9fApg2gWGPkEqrVVXITx2+oSRjJHEZc5jwMt7AQZBgcoXnY5weAk13BEFXvYZa7yP07nrdHcLHTEmbFbGLVDFyNIZrWQ8W/FvH4fWod4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781043597; c=relaxed/simple;
	bh=xvy4bkq3P2rtPuts3OtlogJt4Cz0NMbc+ohhmCAWkn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tG4GAsHfq+8db+47h2ohdzX0q4JCm4hWHVdFN2+pgiLot/Zo+f4xDO0U0gzNyf09cbX2PmNgyVUf00gX0nCVUHwXhfbNbQ8oWh8DIMTM5pvp7DCYBk0/6SBiH/2MXg2xNUKKjjiMBlVkb1w1X0htyEEyLJy/Ck+B4sj9vMaECbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTC+94mi; arc=none smtp.client-ip=209.85.215.173
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c8585ecdd71so2180474a12.0
        for <dmaengine@vger.kernel.org>; Tue, 09 Jun 2026 15:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043595; x=1781648395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6ipJNaJivS6R5/q/SqMYFm/sZfUc0Uv8GQU8fX6jMU=;
        b=ZTC+94miVTLR2xjEyHJ7h9xK04XMw+OpEbD2STgLYjXLBcvu08ftGS6ijwulng8Ee8
         BS6gT1jdCOEjneKD28WtquWg++VX+I/MSzrdn4HrHxBfL/+AzJ4gRSlJKsJsZhjuzQKQ
         ukHltV4S9P0VRkTXpBHWWfDCflD9MitiZZugGrcTF8C5NUjp5uKyxI2Sm0AyCiOGIiVi
         YcurrnMYb9Jm7hdSAJ+bfS1yK+mtoOxEClGFHyaDaz94s4OVHnW42YtNAjnYrEIErVQh
         lbHZxqS068NY1bHleC9DxrX9viBj+NTNjGg6VYk1JDLVy8RCgw5huJpyU2mbRWlDlKzd
         Ohvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043595; x=1781648395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y6ipJNaJivS6R5/q/SqMYFm/sZfUc0Uv8GQU8fX6jMU=;
        b=LRtqF1lsQzifYVn7xtDjDbi5AuCCSKSUtoa3d7edXMR5oL4VofMh7nnzjC2sZT1pq2
         1jKBBWH69FddVovyDEKyF2pg3wnSlkcvizZ3WWiyZiAkVViBvd063kBKeNlwfN24DiFh
         v4ClXysXTzW7vnSIACA1LFbNxyvHb7N/mhN/a5F3AB46ptpRYmpKWEsCdP92OI4v52VR
         +dFKyAPRenmcEv0tyIuxiSmcygvpnDVCha5zXCWFT6c3j3TTS+BJ+uj4YvLGxkM2WFHK
         JPEUTMkZYPyvyjZIa7WRGg4kn0PKCB/wc0LZYCkOHvOFdABL2hhPGOjt/PQedPwuAesS
         KnSQ==
X-Gm-Message-State: AOJu0YwiCTfaAakoYZbk3BjXk9aaz6AIiez/fMlqHmUPIHTyqvQEEZUu
	CJbWDABQLQJH9xEh7M16dr00cvIYEk+hJ/5iNdcN3LgpeVlFMBajcOYJyVq3/RGw
X-Gm-Gg: Acq92OFy5ntKbH3f2lMzqBNOanqT4JXfHG3LDEc7EE8IC8NCFNmUegcGzp8skzxSO7N
	fTWJ9eFHvnlA8RjSwOj1Td6vN5Aa0c5D9mcFC/x+tihpDk6HhXZvoD2CwrpPfAll+IC9Fb7V+94
	M2cVS0vN+ecRtY6eKYlyLbDpPNORxD9nUVuycI/UZaTZdrT1to2KWTieNK9hO2+cPRTxzJhaZTU
	5gMdCyWew9Hg6pumpOpG8D62hfJpdCgx+N0vCqDwHuawffbS0wUfmwC/R/N5m1O8Sr4HGHMHcCH
	HAWMX1zXI8yk3s5/r6HBleyRZ+Vi8Ke6UI2Ei0hCcW1cdbfhSBxNbg+eB67TIIivOp2M9wg9Pg/
	RK+VzBUHtyw/aQ3XoYlB2reUVLFRVKeEmAf0mY+SKIwZXbWIbPS1HUQMGsCBifg5yxmBCeOQduK
	c2/dzobB5zRc+HC0wegeDZhceAK7dbKAjsfPl7iiRbyso7tsnF1j2C+2ds/FuUv3KSC1VCFmi76
	p6s8MMHK9dTQ9cjm0UAxbD2i1L6R/l3GPDekyz/5MRlOA==
X-Received: by 2002:a05:6a20:d043:b0:3b4:84c5:45d0 with SMTP id adf61e73a8af0-3b4ccf35b24mr25054339637.27.1781043594737;
        Tue, 09 Jun 2026 15:19:54 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04ff24sm19661834a12.14.2026.06.09.15.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:19:54 -0700 (PDT)
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
Subject: [PATCHv3 04/15] dmaengine: fsldma: provide device_release callback
Date: Tue,  9 Jun 2026 15:19:15 -0700
Message-ID: <20260609221926.35538-5-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zh-kernel.org,gmail.com,google.com,vger.kernel.org,lists.ozlabs.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11362-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:zw@zh-kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BBB596648A2

The DMA core requires drivers to set dma_device.device_release so that
the container structure is only freed after all references to it have
been dropped (see the comment above dma_async_device_register()).

This driver violated that contract: fdev was devm_kzalloc()'d with no
device_release callback.  If a client still held a channel reference
when the driver was unbound, dma_device_release() would eventually
run on freed memory, causing a use-after-free.

Fix by allocating fdev with kzalloc_obj(), adding
fsldma_device_release() to free it, and setting device_release.
fsldma_of_remove() now saves channel pointers and frees IRQs before
calling dma_async_device_unregister(), since fdev may be freed by
the release callback inside that call.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 1ba10d065278..43d817f6ded1 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1219,6 +1219,8 @@ static void fsl_dma_chan_remove(struct fsldma_chan *chan)
 	kfree(chan);
 }
 
+static void fsldma_device_release(struct dma_device *dma_dev);
+
 static int fsldma_of_probe(struct platform_device *op)
 {
 	struct fsldma_device *fdev;
@@ -1257,6 +1259,7 @@ static int fsldma_of_probe(struct platform_device *op)
 	fdev->common.device_issue_pending = fsl_dma_memcpy_issue_pending;
 	fdev->common.device_config = fsl_dma_device_config;
 	fdev->common.device_terminate_all = fsl_dma_device_terminate_all;
+	fdev->common.device_release = fsldma_device_release;
 	fdev->common.dev = &op->dev;
 
 	fdev->common.src_addr_widths = FSL_DMA_BUSWIDTHS;
@@ -1316,19 +1319,33 @@ static int fsldma_of_probe(struct platform_device *op)
 	return err;
 }
 
+static void fsldma_device_release(struct dma_device *dma_dev)
+{
+	struct fsldma_device *fdev = container_of(dma_dev, struct fsldma_device,
+						  common);
+	kfree(fdev);
+}
+
 static void fsldma_of_remove(struct platform_device *op)
 {
-	struct fsldma_device *fdev;
+	struct fsldma_device *fdev = platform_get_drvdata(op);
+	struct fsldma_chan *chans[FSL_DMA_MAX_CHANS_PER_DEVICE];
 	unsigned int i;
 
-	fdev = platform_get_drvdata(op);
-	dma_async_device_unregister(&fdev->common);
+	for (i = 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++)
+		chans[i] = fdev->chan[i];
 
 	fsldma_free_irqs(fdev);
 
+	/*
+	 * fdev may be freed by fsldma_device_release inside this call;
+	 * use saved copies of the channel pointers afterwards.
+	 */
+	dma_async_device_unregister(&fdev->common);
+
 	for (i = 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++) {
-		if (fdev->chan[i])
-			fsl_dma_chan_remove(fdev->chan[i]);
+		if (chans[i])
+			fsl_dma_chan_remove(chans[i]);
 	}
 	irq_dispose_mapping(fdev->irq);
 
-- 
2.54.0


