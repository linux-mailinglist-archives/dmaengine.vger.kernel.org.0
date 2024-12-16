Return-Path: <dmaengine+bounces-3982-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B8D9F2E27
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 11:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BFFA1882866
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 10:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798ED202F8C;
	Mon, 16 Dec 2024 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="Owl+o4Tx"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7C1BA49
	for <dmaengine@vger.kernel.org>; Mon, 16 Dec 2024 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734344777; cv=none; b=ilY/2FLh7yKq8XzIILGyMQsC/kxLNnNB8JZ3GkllDYa/xQ58krDJA3F2sGJrKEYLUo/CgUqunPQXOzqPdrQsvYf357UlJJ+ucsW5ghh5K7VsulV1n2NZ77xYdWSQHEn5G9605DbAOxcxU05nTyfNktTf7el1VQ5vtXoW0lw7Gvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734344777; c=relaxed/simple;
	bh=kKaZQLeK5qlDUJ5eYM0JtfN66gW8Ml038wNS6CBVEVg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K2Jc8fryxlqWO73m/TYmr6dohOqryN43FbijBodJKz5VB+IFtU46AgKW4vm4kaUcEo9+otAaS4RzsJGEGPWo8zyEcCH72Jc2+AHt3Y76j6+roufNtukYbYJgoUPYT5QsNTXFHJkRwFOIohJZJoKEAYnvdAYcEafx3QwoMSdub5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=Owl+o4Tx; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-725d9f57d90so2752237b3a.1
        for <dmaengine@vger.kernel.org>; Mon, 16 Dec 2024 02:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734344774; x=1734949574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r5qtmt2odWwzEQNbyog0qcFC1sj6j6cn0kFyNeNospQ=;
        b=Owl+o4TxkJCOQZcayqwuzznkD67CDMtz/ZwCWSRfg3bfZQ+rBPtsGH7u7WgE46fuJK
         ABeEJH9fYkrowhLF3DIkk9Dnnyq1vSjusvmflSo0InHVpOT9IwwW02f6O8AIkFtsa75V
         dIuDg8i3EhYm16h1CQtxvABY1ANQqNWEexGWFdyWBZUCvRSYYsq8pzPmZgzjYQ9aOoF/
         LJtKKFngxUqZoFyqRRbiPLgaHA0zdRFwre7UqCnzAQ0Nzwzhe119IxkSoel8JT2wRcS0
         P2ObBdIf4S1zASWHszn/X9Ovi5ts3GL2vx1Tyxrb4ewt0RLq1hBvpkbd5DXD8Ev6AYoQ
         xsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734344774; x=1734949574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r5qtmt2odWwzEQNbyog0qcFC1sj6j6cn0kFyNeNospQ=;
        b=amYdw1xcFVni5qOAgIP7uHrc5RBmHvo6KqSDthSE3G6PIt1iQn+nBgN3d4JUq80Yj+
         KpAQREYWbTbOf8lYE6trCnzLdjIITS8y7ekmtPoAAziFX0wxJewrFMAr63EZMh9eB4wp
         9X30+AMTis50xYO8A1NIYvXWr9nVQV3Kmuns8BKFIen1Rqszf3Qpw04uq3IczsiVf3cy
         J9bLHChqUi3VTdN53aMKi2QROYETq9Rxg1FByBQfBatOwYzJ7EoLi/rBZmrPRwKR/4fO
         Tek3N+/vJetN+s/5szaOHe4Rix4IJJOnpv0TVf6CkxKuYzXuEMGiHn/g3ADqISkPXM95
         v4fw==
X-Gm-Message-State: AOJu0Ywa6R30NlIqnqWVrnSPMyZoPQDTQUAtH+k1MjWFBjuHuZuvyTok
	MyBYNfq4RPbUTakGnOkuZablfbBqCn/Uqzr0gBpAQ45ZruMFcI8RxgokpnHwYmA=
X-Gm-Gg: ASbGnctTvjYrSTkZagEUK+mOgYffB760HU542GpZsYqQ/d2S6E3jqAm+EudyIvuSGZD
	Hb8SkZYtdJW48euBa5Zb19pwxwgfyS59ZQizCEkD8UWdW4Oyo6MZyfUTk8WB8zsRz+A0r4iPBBI
	+jof+hrcsiVt4frd9F034oFILrY/jZAGb8RDaJDSH0SnHs67QA0tErfvbO8AShBSdPSHZBvoYTu
	AAmrufYSxaTULqCIK4lYAP6S/9JYSsZpK+XfY96op8utGZXe9hODNnXMXxFjK+lqbOT279EhaKL
	+kE85ZyfHa/0ZVwcarsubqGr1MOZplvu70iBRCHDbho=
X-Google-Smtp-Source: AGHT+IECHIgqdOqEAONGQwSf2UBmkDrrxf5TLip5ulDhrlFUMrNdrniM74hFEswgfB+rHpIlRR4MuA==
X-Received: by 2002:a05:6a21:150a:b0:1e1:beea:8898 with SMTP id adf61e73a8af0-1e1dfec9476mr18657806637.45.1734344774159;
        Mon, 16 Dec 2024 02:26:14 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bad621sm4396566b3a.156.2024.12.16.02.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 02:26:13 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: peter.ujfalusi@gmail.com,
	vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH] dmaengine: ti: edma: fix OF node reference leaks in edma_driver
Date: Mon, 16 Dec 2024 19:26:09 +0900
Message-Id: <20241216102609.760571-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The .probe() of edma_driver calls of_parse_phandle_with_fixed_args() but
does not release the obtained OF nodes. Thus implement
edma_cleanup_tc_list(), which releases those OF nodes, and call it in
the error path of .probe() and in .remove().

This bug was found by an experimental static analysis tool that I am
developing.

Fixes: 1be5336bc7ba ("dmaengine: edma: New device tree binding")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
 drivers/dma/ti/edma.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 343e986e66e7..e6eee6cfa94a 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2279,6 +2279,18 @@ static struct dma_chan *of_edma_xlate(struct of_phandle_args *dma_spec,
 
 static bool edma_filter_fn(struct dma_chan *chan, void *param);
 
+static void edma_cleanup_tc_list(struct edma_cc *ecc)
+{
+	int i;
+
+	if (!ecc->tc_list)
+		return;
+	for (i = 0; i < ecc->num_tc; i++) {
+		if (ecc->tc_list[i].node)
+			of_node_put(ecc->tc_list[i].node);
+	}
+}
+
 static int edma_probe(struct platform_device *pdev)
 {
 	struct edma_soc_info	*info = pdev->dev.platform_data;
@@ -2460,10 +2472,10 @@ static int edma_probe(struct platform_device *pdev)
 			goto err_reg1;
 		}
 
-		for (i = 0;; i++) {
+		for (i = 0; i < ecc->num_tc; i++) {
 			ret = of_parse_phandle_with_fixed_args(node, "ti,tptcs",
 							       1, i, &tc_args);
-			if (ret || i == ecc->num_tc)
+			if (ret)
 				break;
 
 			ecc->tc_list[i].node = tc_args.np;
@@ -2521,7 +2533,7 @@ static int edma_probe(struct platform_device *pdev)
 	ret = dma_async_device_register(&ecc->dma_slave);
 	if (ret) {
 		dev_err(dev, "slave ddev registration failed (%d)\n", ret);
-		goto err_reg1;
+		goto err_put;
 	}
 
 	if (ecc->dma_memcpy) {
@@ -2530,7 +2542,7 @@ static int edma_probe(struct platform_device *pdev)
 			dev_err(dev, "memcpy ddev registration failed (%d)\n",
 				ret);
 			dma_async_device_unregister(&ecc->dma_slave);
-			goto err_reg1;
+			goto err_put;
 		}
 	}
 
@@ -2541,6 +2553,8 @@ static int edma_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_put:
+	edma_cleanup_tc_list(ecc);
 err_reg1:
 	edma_free_slot(ecc, ecc->dummy_slot);
 err_disable_pm:
@@ -2575,6 +2589,7 @@ static void edma_remove(struct platform_device *pdev)
 	dma_async_device_unregister(&ecc->dma_slave);
 	if (ecc->dma_memcpy)
 		dma_async_device_unregister(ecc->dma_memcpy);
+	edma_cleanup_tc_list(ecc);
 	edma_free_slot(ecc, ecc->dummy_slot);
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
-- 
2.34.1


