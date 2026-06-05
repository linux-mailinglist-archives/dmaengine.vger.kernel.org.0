Return-Path: <dmaengine+bounces-11201-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P/ToONhHI2o3ngEAu9opvQ
	(envelope-from <dmaengine+bounces-11201-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 00:04:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1B064B897
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 00:04:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XRe3w+67;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11201-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11201-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40E9D306EB36
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 22:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A904B3D3332;
	Fri,  5 Jun 2026 22:02:02 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6022E3D6470
	for <dmaengine@vger.kernel.org>; Fri,  5 Jun 2026 22:02:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780696922; cv=none; b=Mm8dVw3hDYJTTwL3wNp/bLVTN95uAjaXu3LvUKqiF0wIx0yKIY5WYZkBWdPdhaiQJgynsf3kOyed8rpJxHM3WwnIFW2qfN7uDbNtsS/d6bwHBfRTMXvmzOS/q9DnkMtKVYWf5GG7RIgeeBPgSHS/VnPFZpr8IankqlgObBkSgvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780696922; c=relaxed/simple;
	bh=bKQWmItIKnc/fdJSRRktRi/1cUXUvo7d8EoyajRgfGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9RgrJADD47mUXWkoWydmO6RVlok3SRyAdYy9o8s/TbH+gSZj4PsAaQmRk/50T6WsApa/FENtDP+nNatJbjqPj2U+np41KhOOz0ZwBIReWtCosxg4FUw3oN09tHCeCmBl/Om3Zo2/ejBLcF/5edKkwk1F5z7nCg0GBYuSqavQN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRe3w+67; arc=none smtp.client-ip=209.85.210.171
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8423f420455so1088330b3a.3
        for <dmaengine@vger.kernel.org>; Fri, 05 Jun 2026 15:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780696921; x=1781301721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0IcJHFrxrpFxcVE04G7XPPulmPSc2DO5kl+s9g50fo=;
        b=XRe3w+67XoX40v6/5lZDBtC7iEWyCjaWAUcaBLZ03eArr2xSpKaBWLiZk8h2t6Vdah
         uPrMQeo7CrxiP+Ind8TuFeQfXU+ZWf7al2xc/611eeO/F9jYVMhnTitbG0AIaRlHtXJg
         z/c9KyCQPwKAa7CmEmXvB/j351jxVSjYw2Z5++c96A8c8musz8af0gj/WSjZ8WzwQsDy
         bfeh5A3MLYkmuU1u1W3B+QU4D9nH25csyFT5iaprFVF7k/W9+bN/B60nREPhmxDYScF/
         VkDqXx1pi4ERbPzVZ4cug027n1/DSyqO2y7xkDaOKAXyrVDKTBg/PMc/8ZF9WD8fGSnu
         oWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780696921; x=1781301721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w0IcJHFrxrpFxcVE04G7XPPulmPSc2DO5kl+s9g50fo=;
        b=kMcWZa1TdMmW+Jnd1/it4tEkgkHYu7U2p2ieSxrc66UOcHhh6myYJU/P/2jCs5U9Gc
         21tghpD9LbMxoTHIYT1wDzjZ89kgVicnvAeEqbCzlzSmhlatCZVrSnw5tQjJCEqauwro
         YQ2V7vE3lYf6frDBOxaiCFZEttEfhjTO0Nm8MxQPLckNNOWqD1px7TIOCsY8hmfwcRCe
         5aKQgFIGUflD4sIRh5610RqUZ4yjcR7LPCAVux+0qeU4DhP5Hm2l/BMlG0FICJlMZXzZ
         apmQN7VAbDg8n8TuM9wTzW+um2rUyvb/mO0qTW7QN3GbAJd7UUQAuIxzi/J+dbi/o3pi
         1z7w==
X-Gm-Message-State: AOJu0YwMzqh+4KDQwtYfOL4HZO9U50ImJ++07TwpEAUtrpItLUWKdOvm
	7XZkDcM4v0zEMV8fc4WMJIULUBX7HcimY8P+8dyqLJwMT4bMYRQzJEQY4P5bfA==
X-Gm-Gg: Acq92OGKMVpEaTqpje7EySfXdqssIisIWcBCaBv5VjnK2wKXOdCCbUmroMcQNybZtTk
	Pngt8Xswkd43mFJOmR3eGFEU3aCN4tU/oQ1cuL2mwelIsRUpHlhw+HhHsmozTNhYFdskK08bxIP
	C8pBZ3GCZOkaxob72Onqhs6LH4FBqTPilnGX0qHbMb5cR7mbOQ70Ze3t5OPnAH7lW+Su2G9ZS0N
	Lhki5Krt5YkR6YknIrTCT3MVmtQg4Q4cXJ93oIC5dTaUgzyZnHz4doDtA2dvjTcqSc3Cl7WJJVQ
	VKkswHVRlF2PbPiifcuBh127fhmWCHYWkU4lELSPfXA/vS19ZqhCMCIehaJq4NWt4+SlrYM5Fkg
	tXJtvcFT6ppGVEACr8DkzjFx6X3oZJ4WJnZhx4GVwl6vtDpgwiG6bR0woSKCvyoHSqgBn99L+Z+
	BBsAY9ug9B4sqMBhPcCmU9K3F1Buy4viGJG/hYHJKJKo6a83faNEzZXnM4Gn9pt+Lta0IdDfDIv
	Rh3OPPatEmd5xO73cw7u1dZTNYrBk1HqZ/rkktkYgLk8Q==
X-Received: by 2002:a05:6a00:1c94:b0:842:6d5d:58dc with SMTP id d2e1a72fcca58-842b0feef0fmr5682549b3a.43.1780696920695;
        Fri, 05 Jun 2026 15:02:00 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842824a1cb4sm12518883b3a.26.2026.06.05.15.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:02:00 -0700 (PDT)
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
Subject: [PATCH 05/10] dmaengine: fsldma: convert ioremap to devm_platform_ioremap_resource
Date: Fri,  5 Jun 2026 15:01:29 -0700
Message-ID: <20260605220134.43295-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605220134.43295-1-rosenp@gmail.com>
References: <20260605220134.43295-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zh-kernel.org,gmail.com,google.com,vger.kernel.org,lists.ozlabs.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11201-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:zw@zh-kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D1B064B897

Convert of_iomap to devm_platform_ioremap_resource to let the devm
framework handle unmapping. This allows removing the out_iounmap
label, out_return label, and the explicit iounmap in both the probe
error path and the remove function.

The DGSR (fdev->regs) and per-channel registers (chan->regs) map
physically distinct regions in all supported variants
(EloPlus/Elo/Elo3), so there is no overlap risk.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 2efa16d12679..2a6a247761a4 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1229,19 +1229,17 @@ static int fsldma_of_probe(struct platform_device *op)
 	fdev->addr_bits = (long)device_get_match_data(fdev->dev);
 
 	/* ioremap the registers for use */
-	fdev->regs = of_iomap(op->dev.of_node, 0);
-	if (!fdev->regs) {
+	fdev->regs = devm_platform_ioremap_resource(op, 0);
+	if (IS_ERR(fdev->regs)) {
 		dev_err(&op->dev, "unable to ioremap registers\n");
-		return -ENOMEM;
+		return PTR_ERR(fdev->regs);
 	}
 
 	/* map the channel IRQ if it exists, but don't hookup the handler yet */
 	fdev->irq = platform_get_irq_optional(op, 0);
 	if (fdev->irq < 0) {
-		if (fdev->irq != -ENXIO) {
-			err = fdev->irq;
-			goto out_iounmap;
-		}
+		if (fdev->irq != -ENXIO)
+			return fdev->irq;
 		fdev->irq = 0;
 	}
 
@@ -1309,8 +1307,6 @@ static int fsldma_of_probe(struct platform_device *op)
 		if (fdev->chan[i])
 			fsl_dma_chan_remove(fdev->chan[i]);
 	}
-out_iounmap:
-	iounmap(fdev->regs);
 	return err;
 }
 
@@ -1328,8 +1324,6 @@ static void fsldma_of_remove(struct platform_device *op)
 		if (fdev->chan[i])
 			fsl_dma_chan_remove(fdev->chan[i]);
 	}
-
-	iounmap(fdev->regs);
 }
 
 #ifdef CONFIG_PM
-- 
2.54.0


