Return-Path: <dmaengine+bounces-3678-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E259B9F7C
	for <lists+dmaengine@lfdr.de>; Sat,  2 Nov 2024 12:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C00A21C20C8F
	for <lists+dmaengine@lfdr.de>; Sat,  2 Nov 2024 11:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0321B15A85E;
	Sat,  2 Nov 2024 11:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ZndRLKwS"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E02C7F6;
	Sat,  2 Nov 2024 11:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730547987; cv=none; b=lciJr9Z6oMiQUPzAifAaz7aJ1KEjPkruJUmpAn6KstIW0yOmxmXl0GLwXUxrSm1W9LjEIvkqXKYW/3QIrLExYOBAx+W0pjWfYE0RVQnYaUz1ubszwALRUvuY53T+qa/S27yMslGwNVqi7CGrh30RCwun2neJiarZpjFgHM35jBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730547987; c=relaxed/simple;
	bh=2Ch3mP6U6sjfW2K87+WL0YUv5Re7tuO/62D8H6hhe30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LGn9xf5ZaErWwbtOhrn5jP5YcAG1QgRHooPswJSTFUSnEdJ3IzxqVLiR29BNRWka3msZg3Bq8aVm0CW7J0GPdQq5AKfjX0F9rukkLyqayO8Y0kxv0JKVYQcIJpr5WY30wMsbkrf2g7YsUYT+pTDk8hOOKYXtttKpKERwvt9KaME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ZndRLKwS; arc=none smtp.client-ip=80.12.242.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 7Ca5tfi7F2ppn7Ca5tOdOL; Sat, 02 Nov 2024 12:46:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1730547977;
	bh=GmDq1W3IPmHPr4pL6L0e60EmGNxPvUXw6zQ0gx+le0I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ZndRLKwSv8qUNLQDZlLTcJ3yU6wpBzMHRlcRX6QZCNfPQDHqvSEzpcbQ+DErFQj53
	 nmiQ6ZepqfXYRRkWTUxTkFPxA0OPFqJJ5kA1OhpOUCKiyLsoT4sEoHQCZMAzr85VKj
	 YzXf1TaOdxGVACM5cwWrQM8TCcD26M4hymSB8Pur5yDvFduHoCV+g0xa4hGZEmyNM/
	 EeUeg94r6rVfSQm2DJuDiXt3tSwiu7DGGWpjJ+yGQDJzzdBShsGFM2729prx2/VKVu
	 2UPrhzM3u0gDke04gdbOIYTLJN3r6rkjjp5j5SNIRrNRdB/vmbDCjI1e2Q/IxBQItO
	 xgxlOhhXEiT3Q==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 02 Nov 2024 12:46:17 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	dmaengine@vger.kernel.org
Subject: [PATCH] dmaengine: idxd: Remove a useless mutex
Date: Sat,  2 Nov 2024 12:46:04 +0100
Message-ID: <e08df764e7046178ada4ec066852c0ce65410373.1730547933.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc()/ida_free() don't need any mutex, so remove this one.

It was introduced by commit e6fd6d7e5f0f ("dmaengine: idxd: add a device to
represent the file opened").

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
See:
https://elixir.bootlin.com/linux/v6.11.2/source/lib/idr.c#L375
https://elixir.bootlin.com/linux/v6.11.2/source/lib/idr.c#L484
---
 drivers/dma/idxd/cdev.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 57f1bf2ab20b..ff94ee892339 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -28,7 +28,6 @@ struct idxd_cdev_context {
  * global to avoid conflict file names.
  */
 static DEFINE_IDA(file_ida);
-static DEFINE_MUTEX(ida_lock);
 
 /*
  * ictx is an array based off of accelerator types. enum idxd_type
@@ -123,9 +122,7 @@ static void idxd_file_dev_release(struct device *dev)
 	struct idxd_device *idxd = wq->idxd;
 	int rc;
 
-	mutex_lock(&ida_lock);
 	ida_free(&file_ida, ctx->id);
-	mutex_unlock(&ida_lock);
 
 	/* Wait for in-flight operations to complete. */
 	if (wq_shared(wq)) {
@@ -284,9 +281,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	}
 
 	idxd_cdev = wq->idxd_cdev;
-	mutex_lock(&ida_lock);
 	ctx->id = ida_alloc(&file_ida, GFP_KERNEL);
-	mutex_unlock(&ida_lock);
 	if (ctx->id < 0) {
 		dev_warn(dev, "ida alloc failure\n");
 		goto failed_ida;
-- 
2.47.0


