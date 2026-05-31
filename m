Return-Path: <dmaengine+bounces-11066-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLLMCTWYG2rvEQkAu9opvQ
	(envelope-from <dmaengine+bounces-11066-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 04:08:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A05A6614374
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 04:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E61B30566B1
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 02:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434EF3655CF;
	Sun, 31 May 2026 02:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1VXEde0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B49E3612DB
	for <dmaengine@vger.kernel.org>; Sun, 31 May 2026 02:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780193163; cv=none; b=Z4pO6OtY5EayhQw9w7lr1IJ1KM69j5bRHy5xmCfhETTDcTYSFivT1k79sAoOV+HeMuUuKtQ7zueAfTJC9VStWKwbzepnu8W1jMwhQyZh9LUxqtkNx6CECCc0TySI75g0h9gVGlhEPVs1/JDalY0d5XkLTkkcK/Ngu/y2sk9dD+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780193163; c=relaxed/simple;
	bh=J6YChUmyD3xRmPfZq01QjdSSzKNUlsorT+F2G536OjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZugxX5bw/p9QADnvZ9o1IqeBBxjUPojxVLtUdDFY0o6s+Qwp1m6ZImRDWKiGCEdxtfBZkbuEfrhfsxDPu4P+AzACZO8ft5LhWHqaDYcrYKVYznoofMplZSOHZDotYvyk7MT4I/wmz4PCLJPQllVRTgFdFnCtjlYMkrb/Iy6RCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o1VXEde0; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-914b5f85129so772945285a.3
        for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 19:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780193161; x=1780797961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/Rv5j798E/wJxW6Lz2s/cY52hep39bRvHPoM4YeyHU=;
        b=o1VXEde0wIndEwV76+95gt1fjsFCE5UiHApVkpiM9Id5iueWU/TBewDHouLwOzFM0h
         S80zJzquY4Fx0qnFiNgy+4VBRmMhMzkyjT0HhjfKsIO+ccyGfCh2U1YUeo8yckqZpgab
         2WqQiCNiBR0UOhiWIRmr36fJBCrz1pBxaElBHHNyVSjl/eA+wczK461cxGHls2wOgaoO
         uyd6AwsqOIPxZlqRhjgVmDHjy+wkHGGPSGEQE1DAIufzpJzvairr7Y9bdufA42RWLezt
         CIsGwFpk5x5DqVdGFmRq5X0C5L8ZXdi8EH6RqSv4hmMi5sg7IawIlYS2ITWyg40i87Ba
         kN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780193161; x=1780797961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0/Rv5j798E/wJxW6Lz2s/cY52hep39bRvHPoM4YeyHU=;
        b=OhafixpEdJiSobMOHTCEOQUz96xrTkLtXd4JL7GSLO34VtmoIvDPC3KFb8QHnAp9PR
         sdtx+uGvAnNnyPeQMKDaCi9PeTeG33WTp6zkPrIo+74tOiLYb4F3WyTnMPvN0mLAOHqo
         wMFfIzV0bmg0xxSXZfP8MhvQ95Qq4mYWQj4SZ5DcscLNJdThlGlhyiSmL95BdepKrH+J
         BwOVCrEEoUK1hOeryeTOoInZlJ6nFl++BNqjpr8MhqzhCuO0J9jZFoA5TmroCaTOmYEy
         1exkX0G5PngWpInBgXo8Y3KCk/zyzP7tJF72+F0vC8lsvFDSOiipkAh5s3voAide0G1M
         b4cw==
X-Gm-Message-State: AOJu0YzXwr57bRtfKQ3CL4Q9RjIbA5uplgiYD0jDCmsQ92LStR2Xi1EW
	pKthzK92RprF1WjpFbYYCS+jxcQKXmrTUzO4Ef2eN/3ovk6Wmk/FWLVD7ZAm4BIT
X-Gm-Gg: Acq92OGd+4BFJPzRz54VRqiHY6DByag/ZirCJj/aWGRX18yfwoMiZBQlPMCXhphadQX
	RcTvTbInw6gI8xQpa0PqAuUNfbR2OWl0B5s7IfwBFVywp6RfQx5SlWs4Q9SICfENhmWdxqgNLHm
	duLrrDpAd2kygee584Cyc0fxn2Hn4+scqDj50q/F+RGn+Y3MmUdA3uLStBc2jOwYDpEiEw3uJJQ
	21SP8Rw5h5WpT2q44IWlXdjP8mtIlNM+xM/FDyBvXRfCo+SCFiKwUzboCRPH/Jh/hoeINIR/wnG
	wuCfLjngFZxGgtK6unLrWgdMCvX4FgVj36wEQwLAGUrowQ5beNwWufaLWoXhn3IsijLfm/7Pguk
	EC8UVJQLB4JE0/IwXeGXNQUsO1nqDy8V+2H3HwXO4Vh0sk4FGBmmIchQLalSSuIyVSKMpr2LZxG
	Kv8v6jNJ1YbzrcmGAXuBrABma2i91vKq77EYIs3P+q3fQ7pAV/3SxFxmMXAYkp+xDc8f11uJFQr
	sKmr+vIU0oXkCMVYdQbgAdz5gXk7JLyCP5q6zB18KxNpA==
X-Received: by 2002:a05:620a:4688:b0:8cf:c106:faca with SMTP id af79cd13be357-9153d9f87d5mr879641385a.36.1780193161058;
        Sat, 30 May 2026 19:06:01 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915324745cfsm620246285a.12.2026.05.30.19.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 19:06:00 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/4] dmaengine: ti: omap-dma: fix dma_pool_destroy before omap_dma_free in error paths
Date: Sat, 30 May 2026 19:05:34 -0700
Message-ID: <20260531020535.594460-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260531020535.594460-1-rosenp@gmail.com>
References: <20260531020535.594460-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iscas.ac.cn,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11066-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A05A6614374
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

omap_dma_free() tears down channels and may free t2_desc entries from
the descriptor pool via tasklet cleanup. Destroying the pool before
omap_dma_free() is a use-after-free. Move omap_dma_free() ahead of
dma_pool_destroy() in both probe error paths and the remove path.

Fixes: 2e1136acf8a8 ("dmaengine: omap-dma: fix dma_pool resource leak in error paths")
Cc: stable@vger.kernel.org
Assisted-by: Opencode:BigPickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/ti/omap-dma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 839e04f53fc2..fd1ad3b4268c 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1808,9 +1808,9 @@ static int omap_dma_probe(struct platform_device *pdev)
 	if (rc) {
 		pr_warn("OMAP-DMA: failed to register slave DMA engine device: %d\n",
 			rc);
+		omap_dma_free(od);
 		if (od->ll123_supported)
 			dma_pool_destroy(od->desc_pool);
-		omap_dma_free(od);
 		return rc;
 	}
 
@@ -1825,9 +1825,9 @@ static int omap_dma_probe(struct platform_device *pdev)
 		if (rc) {
 			pr_warn("OMAP-DMA: failed to register DMA controller\n");
 			dma_async_device_unregister(&od->ddev);
+			omap_dma_free(od);
 			if (od->ll123_supported)
 				dma_pool_destroy(od->desc_pool);
-			omap_dma_free(od);
 			return rc;
 		}
 	}
@@ -1869,10 +1869,10 @@ static void omap_dma_remove(struct platform_device *pdev)
 		omap_dma_glbl_write(od, IRQENABLE_L0, 0);
 	}
 
+	omap_dma_free(od);
+
 	if (od->ll123_supported)
 		dma_pool_destroy(od->desc_pool);
-
-	omap_dma_free(od);
 }
 
 static const struct omap_dma_config omap2420_data = {
-- 
2.54.0


