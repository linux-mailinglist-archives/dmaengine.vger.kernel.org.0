Return-Path: <dmaengine+bounces-4153-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7915AA15DC0
	for <lists+dmaengine@lfdr.de>; Sat, 18 Jan 2025 16:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 145823A6A28
	for <lists+dmaengine@lfdr.de>; Sat, 18 Jan 2025 15:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034A619D08F;
	Sat, 18 Jan 2025 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="n/lSAdsl"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-69.smtpout.orange.fr [80.12.242.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A72273F9;
	Sat, 18 Jan 2025 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737215484; cv=none; b=u1UQ4Oam1xEtBYoaW68WvJAccgGh9f0iuDrCTa3zt1JHGeNazmuHBNdC2m0qwvMYXzxuDl2uRlUKbik3hZQKCqhz22FO9rjoZ12nuQRCar+/DAOcYhqto01uGdN8pWtm0la8SXpMOyBLS3EHG3vWQjc8tEZYKgthwRxbzcfzRqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737215484; c=relaxed/simple;
	bh=/lyRBA3Zy7BHX9j5/Yd+fA4f0AbOSlx3mF5PTWtDtjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R37sZrdOgjzUtajU4d5XTnacl283ZTtD9aMt2vPdzFGlpoS09sRTc3/C2+JRxYm//AllhBh4MxdxejE0ZiAG/N2Ltbgvu46tklzWsRZ7VyK7DtXWUoCew25I6xNRPg6sLeACAB1Bl9P5leUjulAMQlc6DYonybUcPSKpKHPvF6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=n/lSAdsl; arc=none smtp.client-ip=80.12.242.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id ZB6MtxSpjzpxCZB6QtMswE; Sat, 18 Jan 2025 16:51:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1737215474;
	bh=FyWZR02z5B82iDwG7bL2VhnFmSHoovMQD3DXVbQ6qZ4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=n/lSAdslvDLa8YGCFWvMBFTWTPKhqk6i5rTQhjjXJ5/zzjfF+WJjFaohHmkEFNXi6
	 qNMuoSNm+V7ualri+WrbDJlps2iHiCNAnGx7an5EY6zvw/JBoxdB3HfgYIZ+CAK4SJ
	 wVjp8xMJ/0kLXdfjYeLdrKTAZI/k8sKrvnGFCBU+3XgqtY8lPTYRwKeaWRr0olHaSo
	 rUhto9Hzh7VuIrETyBPvMT99HkKm/jDEg7i8rF2iamOfXICTdymf/2hLxnbJNHP4WL
	 iLq4eXd7PVlSyPlnWcJ7PCW6+/nsCTJOMdR+AbqDhGtATsaCSKfy37jGs7YyixZ1y8
	 OkSGhkXBuSgdg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 18 Jan 2025 16:51:14 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sanjay R Mehta <sanju.mehta@amd.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	dmaengine@vger.kernel.org
Subject: [PATCH 1/3] dmaengine: ptdma: Fix an error handling parth in pt_pci_probe()
Date: Sat, 18 Jan 2025 16:51:01 +0100
Message-ID: <ae19d76a10773d6ebee0e08cef49786eb20fd052.1737215423.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an error occurs after a successful pt_get_irqs() call, it should be
undone by a corresponding pt_free_irqs(), as already done in the remove
function.

Fixes: fa5d823b16a9 ("dmaengine: ptdma: Initial driver for the AMD PTDMA")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/dma/amd/ptdma/ptdma-pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/amd/ptdma/ptdma-pci.c b/drivers/dma/amd/ptdma/ptdma-pci.c
index 22739ff0c3c5..7f12474bd39f 100644
--- a/drivers/dma/amd/ptdma/ptdma-pci.c
+++ b/drivers/dma/amd/ptdma/ptdma-pci.c
@@ -182,7 +182,7 @@ static int pt_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		if (ret) {
 			dev_err(dev, "dma_set_mask_and_coherent failed (%d)\n",
 				ret);
-			goto e_err;
+			goto e_free_irqs;
 		}
 	}
 
@@ -192,10 +192,12 @@ static int pt_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		ret = pt_core_init(pt);
 
 	if (ret)
-		goto e_err;
+		goto e_free_irqs;
 
 	return 0;
 
+e_free_irqs:
+	pt_free_irqs(pt);
 e_err:
 	dev_err(dev, "initialization failed ret = %d\n", ret);
 
-- 
2.48.1


