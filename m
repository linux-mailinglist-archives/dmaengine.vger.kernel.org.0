Return-Path: <dmaengine+bounces-698-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8674B8263AE
	for <lists+dmaengine@lfdr.de>; Sun,  7 Jan 2024 11:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29448B2193E
	for <lists+dmaengine@lfdr.de>; Sun,  7 Jan 2024 10:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5BF12B92;
	Sun,  7 Jan 2024 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Nc0LOoB1"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CED134A6
	for <dmaengine@vger.kernel.org>; Sun,  7 Jan 2024 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id MPysrRwtE9WXyMPz5rZ58k; Sun, 07 Jan 2024 11:02:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1704621743;
	bh=guYrmHlQaEIHvMVuPCB9rU52mx7/3tAlTfVlX+gCQPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nc0LOoB13e1Vp9mhdupgtFzzwr/c6ClTvOLRElyJK8sw2al1sVCU51swf35Nd7DP3
	 FPi5/N89KAt5lMcBZgNlCur5gjUts6yJRB5+pwWlVVf3Y7BO5sRXPkHFE+JyviyPs1
	 1Mz67yh96ZIqXVYJTW1I9Y0XQuqjwbCd1RgJdoeBZbiww2xsw78yBwnfWgNhn1rNDR
	 P6LXNjRAzAMCTXmcRycl00hvHtO3POtc26EJWmV4P6mhBfLRtnFltKoYbrKa12Ae+i
	 0EqUdH87+0wSk44ootj5AMcCMTR7qU98i81pc69HKcNsXxJugIBB+Jt8FATsjuA01+
	 tOk4F1KFo2qnQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 07 Jan 2024 11:02:23 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: vkoul@kernel.org,
	jiaheng.fan@nxp.com,
	peng.ma@nxp.com,
	wen.he_1@nxp.com
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 3/3] dmaengine: fsl-qdma: Remove a useless devm_kfree()
Date: Sun,  7 Jan 2024 11:02:05 +0100
Message-Id: <6b7f60aa2b92f73b35c586886daffc1a5ac58697.1704621515.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1704621515.git.christophe.jaillet@wanadoo.fr>
References: <cover.1704621515.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'status_head' is a managed resource. It will be freed automatically if
fsl_qdma_prep_status_queue(), and so fsl_qdma_probe(), fails.

Remove the redundant (and harmless) devm_kfree() call.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/dma/fsl-qdma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index 3a5595a1d442..f167c96f3fe8 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -568,10 +568,9 @@ static struct fsl_qdma_queue
 					      status_size,
 					      &status_head->bus_addr,
 					      GFP_KERNEL);
-	if (!status_head->cq) {
-		devm_kfree(&pdev->dev, status_head);
+	if (!status_head->cq)
 		return NULL;
-	}
+
 	status_head->n_cq = status_size;
 	status_head->virt_head = status_head->cq;
 	status_head->virt_tail = status_head->cq;
-- 
2.34.1


