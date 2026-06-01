Return-Path: <dmaengine+bounces-11082-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBXFEvXUHGqUTAkAu9opvQ
	(envelope-from <dmaengine+bounces-11082-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 02:40:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE1B6187EE
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 02:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54AEA3058BAF
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jun 2026 00:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776AC175A80;
	Mon,  1 Jun 2026 00:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPOB73fB"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942491DDC2B
	for <dmaengine@vger.kernel.org>; Mon,  1 Jun 2026 00:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780274180; cv=none; b=rJcY6vmzgxuCwx8N4nKKjjKkYURnqL/8rfZk4y2KPMDOAC7Unq57mOY1Y6uUhfCNCV3xbVzwP8O4a6LZgqID1F4h+wm1A1cC+HN4EVZKA0hA1oJ2CJ46nbXz5m2fPQc9Qby7/EosHVCR2Lu91OPurhkiIBok5qadL4VvCPz0INk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780274180; c=relaxed/simple;
	bh=F36T/8vrzMlC5yvZm/9OkGm1W8NNSS1qMIE6aZEPPLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjYewf2uIDNAffBb/qdTs1v6ts2pRqLXS49+I3dmlLnRzRD5nzzKvzTk1vi+dKjasNSr4TvbZZRaswuB1jNLktuAvbJbGG7U6VGN9Xnnp5FmrXiYF7EJ23OCWdrASJP0ioEYkD8hCHi/M3Gmdo9KlzOtUFEptpfKpJTYi1DR7uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPOB73fB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c0bb4a94b8so5784505ad.2
        for <dmaengine@vger.kernel.org>; Sun, 31 May 2026 17:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780274177; x=1780878977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLx2I+SI6ZAAbvwA7AP1QE/bdiqJuNwqRo7WWHC7m6E=;
        b=UPOB73fBDW5AK3GsVl4AJVaq/5dIXPaU/YVYXxIGyDIrwvbbjrAewzZhDr1wpRmbAU
         FJ46m/MfOWLCSQDKlk26HQNfN6DgBT3mCoJA6HGdo6J7kPKK+03tzHJvYZoCq9CXOFOH
         QXH+IhTWNrWWUCDpcoqVxmeWCW4vED+5vtc+Z4y0xbPSrXq2rjs3k/jFQSBMjbqnudf3
         uXa0N5nH7JjloUbaGeIJZswS0n9BDvmicFF1OrXQpguo8triV+KrnFxRealxwusLzXgz
         CUCDIadnggrAQlAURC78erCYS8bdfhmGM5FWM1NnBf4laYFuYim1mxVso7z2f09WoZ7+
         YG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780274177; x=1780878977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YLx2I+SI6ZAAbvwA7AP1QE/bdiqJuNwqRo7WWHC7m6E=;
        b=R3HLP8pE2mDV7ez8eP0pR60l+7kT8cZW4rB9yz56ReBRETMOcFtGzM+WO5qqHiaaqs
         8gLrL9uq/tcH7HviDboh+7Io0KzUUQrwIpcztvNi5JrXKwjE+hZKcZsuT6nTw3CfozaC
         wAF+JknsnvUTE8UrRAbBGWG8NLw8h29MMv+PAuEx51SlsGrZv1yBXlXJSBxdiK3o7ho2
         /p+f5FKzTXNBevq76Oqu+e/pA3vCZNtKEpbiCBMTCgcggD8gg9J7xx8cY09DLWxHjJO4
         wqdE+mWbZrJ6lTdq+CQnUEu3DN6GMClukx+ApFNUzEQkd1s8IH4ETTSmb7GqVwRGLiRQ
         j50Q==
X-Gm-Message-State: AOJu0YwkT2qOPHnAp35u65HCliQUlTNHHZSGGNoZPiUBCkpcn22Fbvc0
	P+bXsRYfl0rWv3mt+C8sAcB3WFqsF3RFFHsE/8GNlqq70pEPcrO4ciZURlHkKw==
X-Gm-Gg: Acq92OGGnEtXjfN7sPpN7D///eTZ8ya5tGjDj9MMgyPHf+AfHojAKAAOThZEXiSfVCF
	HxJ1ga0xSatjHn3FnD8Jktk0hwGEiWTMwwuVE+YrSG62mcUQWfycOgCaeBs8PD0Gx80NokcaWmU
	GkqAS/hfRN/sYBIFsrD1F+Aj4IXkK0fVU3VbL3gr8C/8rLooebp2L7Z7Jm+h92FXUXnuTYexuzX
	EFm03woCLv/rirwu88eBIWb/sggTtuPS01iIcTReI//fEluW3CWf8Ziv3kI11TlGey2f4yVf27+
	31j77lzDpFfqd1B6nhZbZne+V+vw1XSupM+j7X6IhXhKLUDWYZ0ku86K6bOEJM/jAY5hyEB+rjL
	kML1x08cHUu9edN03dSM/yeUPjx70qqXkzV8X6ordAUy4mtJxieh1c7rDYf0F0PWnpt1kw7t+G1
	WdLlSO4yZcAN1B6LdoxpEVyHdeVtj2kNqRelYBc4bWaCtHUOyyldvc0Z87majpWLgdV9DLziefL
	zcKCV38bzx9N11ncfo9FrStZtIbNxzjDYZpZviqswYsvQ==
X-Received: by 2002:a17:903:1b64:b0:2b7:aa20:3c61 with SMTP id d9443c01a7336-2bf36858f5bmr97140315ad.33.1780274177013;
        Sun, 31 May 2026 17:36:17 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b011f7sm111929565ad.41.2026.05.31.17.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 17:36:16 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 5/5] dmaengine: ti: omap-dma: use devm for dmaengine registration
Date: Sun, 31 May 2026 17:35:53 -0700
Message-ID: <20260601003553.72573-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601003553.72573-1-rosenp@gmail.com>
References: <20260601003553.72573-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iscas.ac.cn,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11082-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9CE1B6187EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use dmaenginem_async_device_register() instead of
dma_async_device_register() so that unregistration is handled
automatically by devres on probe failure or driver detach. This
lets us drop:
- The explicit dma_async_device_unregister() in the
  of_dma_controller_register error path (devres unwind runs it
  after omap_dma_free() has emptied the channels list, making the
  iteration a safe no-op).
- The explicit dma_async_device_unregister() and the redundant
  devm_free_irq() call in the remove path (devres handles both in
  the correct order after the remove callback returns).

Assisted-by: Opencode:Big-Pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/ti/omap-dma.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 8c32b7ab50f6..4bf34569d82b 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1813,7 +1813,7 @@ static int omap_dma_probe(struct platform_device *pdev)
 		}
 	}
 
-	rc = dma_async_device_register(&od->ddev);
+	rc = dmaenginem_async_device_register(&od->ddev);
 	if (rc) {
 		pr_warn("OMAP-DMA: failed to register slave DMA engine device: %d\n",
 			rc);
@@ -1838,7 +1838,6 @@ static int omap_dma_probe(struct platform_device *pdev)
 				of_dma_simple_xlate, &omap_dma_info);
 		if (rc) {
 			pr_warn("OMAP-DMA: failed to register DMA controller\n");
-			dma_async_device_unregister(&od->ddev);
 			spin_lock_irq(&od->irq_lock);
 			od->irq_enable_mask = 0;
 			omap_dma_glbl_write(od, IRQENABLE_L1, 0);
@@ -1870,7 +1869,6 @@ static int omap_dma_probe(struct platform_device *pdev)
 static void omap_dma_remove(struct platform_device *pdev)
 {
 	struct omap_dmadev *od = platform_get_drvdata(pdev);
-	int irq;
 
 	if (od->cfg->needs_busy_check || od->cfg->may_lose_context)
 		cpu_pm_unregister_notifier(&od->nb);
@@ -1878,8 +1876,6 @@ static void omap_dma_remove(struct platform_device *pdev)
 	if (pdev->dev.of_node)
 		of_dma_controller_free(pdev->dev.of_node);
 
-	dma_async_device_unregister(&od->ddev);
-
 	if (!omap_dma_legacy(od)) {
 		spin_lock_irq(&od->irq_lock);
 		od->irq_enable_mask = 0;
@@ -1888,10 +1884,6 @@ static void omap_dma_remove(struct platform_device *pdev)
 		omap_dma_glbl_read(od, IRQENABLE_L1);
 	}
 
-	irq = platform_get_irq(pdev, 1);
-	if (irq > 0)
-		devm_free_irq(&pdev->dev, irq, od);
-
 	omap_dma_free(od);
 
 	if (od->ll123_supported)
-- 
2.54.0


