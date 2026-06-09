Return-Path: <dmaengine+bounces-11370-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +y8BCeeSKGrFGQMAu9opvQ
	(envelope-from <dmaengine+bounces-11370-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:25:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 727236648E3
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:25:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=h8Hj3bMC;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11370-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11370-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E64FE313F748
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2026 22:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AECA4963C9;
	Tue,  9 Jun 2026 22:20:11 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E133447D950
	for <dmaengine@vger.kernel.org>; Tue,  9 Jun 2026 22:20:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781043611; cv=none; b=URfyXDkv1B7RXZrOx1A19bKpkvr1QBzI36BaKQ8iiaqs3Q2wHgvQT1ZSLa2/UvtNCNAgfJV3e0SwaDOsmwRM4LD6t+jcxrLSvuKLgWUXvzIRimyZy7JVQ8s7LxuvKulD69uPU8OfJArocCSKGi32OD/UUc14PRkAiei614hmVDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781043611; c=relaxed/simple;
	bh=9qwdRZtx3KBcbhi/AHfGrB5L04xheEFVgi0S7d9rfpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=plbQAcg2QD2SlMbt8YtCy6ajZaUlgrgGZfrwoAGh/PEZII+c7//kqttXLJx2HgO9t1esdnWGa66CZMUk90tqpJrZhRCygZtxd/XP3VCMFBQeyJNzd2brFY3k3eMSVC3LdKE48OSRY0O84JRnHfOZ6wRVssLalqvlh3WtKLYhnMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8Hj3bMC; arc=none smtp.client-ip=209.85.215.181
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c86307c4e6bso1003645a12.0
        for <dmaengine@vger.kernel.org>; Tue, 09 Jun 2026 15:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043609; x=1781648409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6APiQiw2BT/NGR5IuAfPSsypVG22xWgyAJZHy+kmaO0=;
        b=h8Hj3bMCdA3OF910+gCJZXP5W/0gstvWCVV+QCVzHcyzWGtk9yzwHyRtkiICruH/Gt
         D09kmv38t3vKDHP49V+ie9bMBGRzYKY7QcUY5f3NOv4XqfrCcKUKr0snAf3Ma+fmUA6f
         +HpQmtRF08nNhxSATTCtUaslIgO50wLSH8Qu4utw6WEeIps1h6WtqFLP97R7omicNxQN
         QWbksBjx7RLft2SHTB8Ky8+2vMpMjafa8e6HBGPz4RXqHiUVP7a2vnl7tJjsuGlkOTik
         Lk7lds1YmOMl8891H8xLN8jqnvGJ+9r0VuxVJrs0LJBTLe3ZDmbHJkSRFg8KxSRmyO+M
         fhmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043609; x=1781648409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6APiQiw2BT/NGR5IuAfPSsypVG22xWgyAJZHy+kmaO0=;
        b=sgZaR11NiUSwe8OIPiMQ3a8jnf3CzJgJpce3ls1jcqZLQimOL3JwpAPsKKaZDar0wf
         tshoVSg+F8wMea3nwrx0RB3TfEJjDZm08X11Bx6bOGNYXodKR6ceOFuIgC3Q0USCe2G9
         S/F7AYcmf0qujdRW+FYtg9RJ/6hVMTG8zre04eLzDaFB6o96eCSWtt9uHlFv1lcXtXgJ
         fv+EB6cjlSdzfeKDiWbqcJDovQhR1PXSFVOO57McP3MxROX0IjTiDkhNihN9MYRF4x30
         Z8HogytRVc82hJ6Z4ihDKQvbksUmCLQmxv47FnYdXTyj/lMiIkzbzdpbvt9uCwjg9gYt
         ix9w==
X-Gm-Message-State: AOJu0YybJOPPKn3OSYmpwP8vwBz/pvJUPp8AOFPXtuVb9a+dIapdgCOe
	6tSCd55qARlyaT3la+8CRpaU3THKlChlRAUxF7aM1n4IGi7B3rixAQIQWjcg4JgG
X-Gm-Gg: Acq92OHxQEg/RLA+9UTUwAwuyQj4rfOOvYZ35AxnmxC/dC+nTNsa/N0bLk0Thy6cXHU
	+nbQMNeAppOJmbc8pF4esPaSxlzdHtewzNbsScUiIWvBHFk4wTiMJ5qU3U8vePTuLZ/h0XQn4iw
	cxxvHRfS+wZj7twsW7JFehC9GyMIvWTOHB4th7K2bNKVQAgMANtDUQXkL9vTDiEWqbvSplJUmOz
	IoG61jioCzg5nbcP3DBZOy9wah1wlOrNEn1/D7LRD4X6mr3t9XrC/f5jXZPl1MU2APMV1NT/uI8
	MsMjpqsbNTEd980K6tSzojDWdC96g3ycAkjeyvI1AVQOLeY3E2Httzw7tJ8YRi+cD7vsB+6BqGG
	I1kt/JV03hlXlOFIiq8WbhKfVkgSQaLYcki5489LsofduzTNzRtA9DNyA3TwVAjMiX44AG8gfdk
	AUfOY5OhBOPP9LQKs2O8KlIboy8bj2TGrvcNNd9WtOHK8oSQoVVkYRtj0DYRP/gtyhGoASrVKwh
	ydSft7wRXARKFBDQSbPW73hcdGcLOmdaWr0QFH6O3BHJg==
X-Received: by 2002:a05:6a20:9f8c:b0:398:6ea8:21d2 with SMTP id adf61e73a8af0-3b53bccd5c1mr6114388637.19.1781043609267;
        Tue, 09 Jun 2026 15:20:09 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04ff24sm19661834a12.14.2026.06.09.15.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:20:07 -0700 (PDT)
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
Subject: [PATCHv3 12/15] dmaengine: fsldma: use devm for of_iomap()
Date: Tue,  9 Jun 2026 15:19:23 -0700
Message-ID: <20260609221926.35538-13-rosenp@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-11370-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 727236648E3

Replace of_iomap() with devm_of_iomap() for per-channel register
mappings. This eliminates the iounmap calls in both the probe
error path and fsl_dma_chan_remove, and simplifies the error
handling by returning directly on failure.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 0df09789187d..a3792864f02a 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1111,7 +1111,6 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 {
 	struct fsldma_chan *chan;
 	struct resource res;
-	int err;
 
 	/* alloc channel */
 	chan = devm_kzalloc(fdev->dev, sizeof(*chan), GFP_KERNEL);
@@ -1119,17 +1118,14 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
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
 
-	err = of_address_to_resource(node, 0, &res);
+	int err = of_address_to_resource(node, 0, &res);
 	if (err) {
 		dev_err(fdev->dev, "unable to find 'reg' property\n");
-		goto out_iounmap_regs;
+		return err;
 	}
 
 	chan->feature = feature;
@@ -1148,8 +1144,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 		   ((res.start - 0x200) & 0xfff) >> 7;
 	if (chan->id >= FSL_DMA_MAX_CHANS_PER_DEVICE) {
 		dev_err(fdev->dev, "too many channels for device\n");
-		err = -EINVAL;
-		goto out_iounmap_regs;
+		return -EINVAL;
 	}
 
 	fdev->chan[chan->id] = chan;
@@ -1195,10 +1190,6 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 		 chan->irq ? chan->irq : fdev->irq);
 
 	return 0;
-
-out_iounmap_regs:
-	iounmap(chan->regs);
-	return err;
 }
 
 static void fsl_dma_chan_remove(struct fsldma_chan *chan)
@@ -1209,7 +1200,6 @@ static void fsl_dma_chan_remove(struct fsldma_chan *chan)
 
 	tasklet_kill(&chan->tasklet);
 	list_del(&chan->common.device_node);
-	iounmap(chan->regs);
 }
 
 static void fsldma_device_release(struct dma_device *dma_dev);
-- 
2.54.0


