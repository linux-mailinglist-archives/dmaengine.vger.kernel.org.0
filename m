Return-Path: <dmaengine+bounces-11425-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wiBUN1MyKmqqjwMAu9opvQ
	(envelope-from <dmaengine+bounces-11425-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 05:58:11 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E0B66E17A
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 05:58:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Rz2YvnFy;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11425-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11425-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31BF732671AE
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 03:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CF33314B7;
	Thu, 11 Jun 2026 03:53:27 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231B633D6F7
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 03:53:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781150007; cv=none; b=h48TRK6MbW5ijnoI/NGqt6ttQ7NWMxwQL8DuNFpnQ2ct5Inap+q9BjLHaPycDTsWw6yGdlXadXzw+mxNmGoHf8EjjnOVdJ70jr88W3vQOoCSFKEDimsN8wPtSyf/G0SeSC/GHflHm5vgaolvtAIP59Ht1nY37MM13S5x7z2FiyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781150007; c=relaxed/simple;
	bh=jfLTQBXqXxvw70iEv1i6xCExnx46J4bUPF8pUSY2PwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPwXlFKcZ1aqwyd0SBWa3EnNSuz1CE9JZHOxUADbDovn9lkMavf/0wBlHkG9P0qMRjgu2MUhwnnD598y5nWUj1SrNTH45AjSY1kY846+GAQ5ceqcoR9JiT24cyi6PwPhnqJmcKlVK37O2Sv2HGvDUoBqRj1P378QdfosYruiOjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rz2YvnFy; arc=none smtp.client-ip=209.85.216.42
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36d630c0e35so7976837a91.3
        for <dmaengine@vger.kernel.org>; Wed, 10 Jun 2026 20:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781150001; x=1781754801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUIaRwpiq+bPDJ7oRrThyVs0svDhFW8QwchzUggrjyo=;
        b=Rz2YvnFy06E+Q1/VnUqZAWoVAAKNvOGuZlGMa8ozVBF3x1DRxn3v4/QLONMIZUOf3E
         gNUcLY50oanwKVEFV2n8ihD2NbN+pRm9ZR23qaspc5NlQ3fDlUwTTTrW1W3VhDcGPIYf
         PNMRayo61NWa8zv0+sZ+lzsBfxH4996jOGIehnkEqzztHBYZLAdXH5MumfPPhRFpptGH
         wVJkdQAlQayM44erqJM/R/qFMnov9IU24et5/E0UYvFs+tNhyaHMp353Nm/MKeqXAa9t
         LKiBDzwmHfDNePYMbduGOKRrvVQCiXuJa/4wmD6s4UWJFZYxFlZgXdgsnXfXeViQDsu7
         Jb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781150001; x=1781754801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fUIaRwpiq+bPDJ7oRrThyVs0svDhFW8QwchzUggrjyo=;
        b=gH25QxcNebbyWQb6zhCsUANfGp3e50eH6z6m+MW5jMiH7gfPAn+2QLChBdx2ob9wzc
         hj7tZ7Jqr5qzMAV+YC5WNkNlJqePoUBVVOY03vYlNn7c0shFQbJ98iV3RKvzGZecSo3d
         +5fl8L4ULt1DLrgWIPLj3+7No1jG0QXzKTVSZ+qQ4CImt9gbcgnQ+3BPM6nPdJA0Tklg
         ml2aoyXPd4ABPpgOiG2veERgm2glmymUpIp4vsRtcnJczQ4Cn71AkvcdDy4qpvu+w8dG
         mjeXRl8/XM/Fbf0F2L9WV7yduNKC5mR1Lni1Li3W3nSHQuC7jZk60LXmUUAjgWPisxfL
         sI3g==
X-Gm-Message-State: AOJu0YzfJdmOoF6ouGezh7HAuzcHoTC3o89KOw5jSlDR342V2e+WnJsz
	geD6FJdJjxBrKx9OMrT/Sh/Yc8ZOSz/B99ZEErMUzXHr29qmavkDhE+8CwGWPQ==
X-Gm-Gg: Acq92OH+1dlfkzqD/4eQbscN36WW3W7sjuupe/uFo/FnQB4Ov2/c17R794f3GrV7SIB
	gVpp5fyBNGp0hCys/mdvhFxVQ5AvJ8/20Bmi0xamL3WkcldWw1jrdOiZGDBWeFSbtUzyCma7SAN
	UVuvnWA4bv9P+XMfMtJb0/FDYcWN3QIZV3eBqEAQqTrTz3bLBj9rRD+JX5Z1URmMkb/iiXOmCLt
	Lf1KvBZ12aytrrAo2Xp3g7fe9D5G86lEyWgWv5QGvTo5HWO4xdn/Ncnv0TEWqfXfYOM0CuQ5+HU
	dCzYDIUASuTrNcWvG4KzrlLIS60cRBlZ5RX/ywJ6uvnP4W4Rez245R3g8LPlci7bgrwnLsbwFDy
	upwnPG08fb14vGaznciVHDeDx8wnkFkFACfA9FNZSqrhRWucucXf6UVxyMBxM2iv/3ep+zTXBVQ
	liqBUzvsfr/WpiVMnc1YY5kYecWYAcwWQSFzxlDzbpBzePJOqeL2qQRTxJQ6dN4ucAKjRVlEoMv
	65tJ34IrShT52t4sc8+jaZEyZxzLmh/1YCrJP8pcVfhWQ==
X-Received: by 2002:a17:90b:48cd:b0:36b:b3f4:d578 with SMTP id 98e67ed59e1d1-377a73e273dmr1261621a91.15.1781150001523;
        Wed, 10 Jun 2026 20:53:21 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a188asm910131a91.3.2026.06.10.20.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:53:20 -0700 (PDT)
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
Subject: [PATCHv4 12/15] dmaengine: fsldma: use devm_of_iomap() to simplify code
Date: Wed, 10 Jun 2026 20:52:42 -0700
Message-ID: <20260611035245.13439-13-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611035245.13439-1-rosenp@gmail.com>
References: <20260611035245.13439-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zh-kernel.org,gmail.com,google.com,vger.kernel.org,lists.ozlabs.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11425-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:zw@zh-kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 43E0B66E17A

Replace of_iomap() with devm_of_iomap() for per-channel register
mappings. This eliminates the iounmap calls in both the probe
error path and fsl_dma_chan_remove, and simplifies the error
handling by returning directly on failure.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 0df09789187d..dc70a6bf5723 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1119,18 +1119,13 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 		return -ENOMEM;
 
 	/* ioremap registers for use */
-	chan->regs = of_iomap(node, 0);
-	if (!chan->regs) {
-		dev_err(fdev->dev, "unable to ioremap registers\n");
-		err = -ENOMEM;
-		goto out_free_chan;
-	}
+	chan->regs = devm_of_iomap(fdev->dev, node, 0, NULL);
+	if (IS_ERR(chan->regs))
+		return dev_err_probe(fdev->dev, PTR_ERR(chan->regs), "unable to ioremap registers\n");
 
 	err = of_address_to_resource(node, 0, &res);
-	if (err) {
-		dev_err(fdev->dev, "unable to find 'reg' property\n");
-		goto out_iounmap_regs;
-	}
+	if (err)
+		return dev_err_probe(fdev->dev, err, "unable to find 'reg' property\n");
 
 	chan->feature = feature;
 	if (!fdev->feature)
@@ -1146,11 +1141,8 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 	chan->id = (res.start & 0xfff) < 0x300 ?
 		   ((res.start - 0x100) & 0xfff) >> 7 :
 		   ((res.start - 0x200) & 0xfff) >> 7;
-	if (chan->id >= FSL_DMA_MAX_CHANS_PER_DEVICE) {
-		dev_err(fdev->dev, "too many channels for device\n");
-		err = -EINVAL;
-		goto out_iounmap_regs;
-	}
+	if (chan->id >= FSL_DMA_MAX_CHANS_PER_DEVICE)
+		return dev_err_probe(fdev->dev, -EINVAL, "too many channels for device\n");
 
 	fdev->chan[chan->id] = chan;
 	tasklet_setup(&chan->tasklet, dma_do_tasklet);
@@ -1195,10 +1187,6 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 		 chan->irq ? chan->irq : fdev->irq);
 
 	return 0;
-
-out_iounmap_regs:
-	iounmap(chan->regs);
-	return err;
 }
 
 static void fsl_dma_chan_remove(struct fsldma_chan *chan)
@@ -1209,7 +1197,6 @@ static void fsl_dma_chan_remove(struct fsldma_chan *chan)
 
 	tasklet_kill(&chan->tasklet);
 	list_del(&chan->common.device_node);
-	iounmap(chan->regs);
 }
 
 static void fsldma_device_release(struct dma_device *dma_dev);
-- 
2.54.0


