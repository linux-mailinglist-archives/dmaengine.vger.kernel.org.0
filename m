Return-Path: <dmaengine+bounces-587-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4715A8190F1
	for <lists+dmaengine@lfdr.de>; Tue, 19 Dec 2023 20:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7D51B2551A
	for <lists+dmaengine@lfdr.de>; Tue, 19 Dec 2023 19:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E406F39AC6;
	Tue, 19 Dec 2023 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="URI7oMNT"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE7340BEB
	for <dmaengine@vger.kernel.org>; Tue, 19 Dec 2023 19:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id FfqmrwJWBO9apFfqmrMy24; Tue, 19 Dec 2023 20:33:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1703014439;
	bh=7M2CUQpwgjxF1irpAVXAbKH37iRCkSgrRaBNR4Uhpg4=;
	h=From:To:Cc:Subject:Date;
	b=URI7oMNTP6dtjUHuREZTiAp0OXCfjCKk/WxX8Z/5LWVRXDE6iNQ8sZd5ELg062+Ed
	 X26VgA/780AmEnGx6WzjoWPYTAxGCH7BGp7Vc3liOwUs5ETw5dtP78U1/0uCU0DIKa
	 nQ876NuA0/sNogK10tU83cGBjnfgqdYz2DLPDwKmY82QIZoy3hz4I/1XGDrPMOlzx4
	 bIL4uyOzTcgX5s+eGsk9gz7c8FDA6zYn9p9E79MPdPzcuACPg0mFHeBVJALAtPX0V+
	 9q9CwQCgqCJN0GL82AlnXvnn4N0iOYDPjunx4xtwVP7IDnPTusJvKKh1yxAj+xgBId
	 IGu30uiXGzy4g==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 19 Dec 2023 20:33:59 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	dmaengine@vger.kernel.org
Subject: [PATCH v2] dmaengine: idxd: Remove usage of the deprecated ida_simple_xx() API
Date: Tue, 19 Dec 2023 20:33:50 +0100
Message-Id: <ac991f5f42112fa782a881d391d447529cbc4a23.1702967302.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

This is less verbose.

Note that the upper limit of ida_simple_get() is exclusive, but the one of
ida_alloc_range() is inclusive. Sothis change allows one more device.

MINORMASK is ((1U << MINORBITS) - 1), so allowing MINORMASK as a maximum value
makes sense. It is also consistent with other "ida_.*MINORMASK" and
"ida_*MINOR()" usages.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Changes v2:
  - remove note about compile tested only, now tested on hw by Fenghua Yu
  - fix some wording in the commit description   [Fenghua Yu]
  
v1: https://lore.kernel.org/all/a899125f42c12fa782a881d341d147519cbb4a23.1702967302.git.christophe.jaillet@wanadoo.fr/
---
 drivers/dma/idxd/cdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 0423655f5a88..b00926abc69a 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -165,7 +165,7 @@ static void idxd_cdev_dev_release(struct device *dev)
 	struct idxd_wq *wq = idxd_cdev->wq;
 
 	cdev_ctx = &ictx[wq->idxd->data->type];
-	ida_simple_remove(&cdev_ctx->minor_ida, idxd_cdev->minor);
+	ida_free(&cdev_ctx->minor_ida, idxd_cdev->minor);
 	kfree(idxd_cdev);
 }
 
@@ -463,7 +463,7 @@ int idxd_wq_add_cdev(struct idxd_wq *wq)
 	cdev = &idxd_cdev->cdev;
 	dev = cdev_dev(idxd_cdev);
 	cdev_ctx = &ictx[wq->idxd->data->type];
-	minor = ida_simple_get(&cdev_ctx->minor_ida, 0, MINORMASK, GFP_KERNEL);
+	minor = ida_alloc_max(&cdev_ctx->minor_ida, MINORMASK, GFP_KERNEL);
 	if (minor < 0) {
 		kfree(idxd_cdev);
 		return minor;
-- 
2.34.1


