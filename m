Return-Path: <dmaengine+bounces-4152-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 220D9A15DBD
	for <lists+dmaengine@lfdr.de>; Sat, 18 Jan 2025 16:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398A1166473
	for <lists+dmaengine@lfdr.de>; Sat, 18 Jan 2025 15:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2721919C556;
	Sat, 18 Jan 2025 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="UVtcia/F"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-69.smtpout.orange.fr [80.12.242.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02FA127E18;
	Sat, 18 Jan 2025 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737215484; cv=none; b=i3ATkaH7Ph2xgPLawpVjtJP3yiK6O8sR1yaq2V858R6LPAJZNx2RMHApS4NdQkMG0lajljKUjz5TR5rMosa9C3Po7NCrgVQGbGrCcNxZPhY3UENAz4H5/xk+vd7cNfuNrfGTY3FuNgIylxusxJ9Bilf7LKu5tNbgYWxycngGGR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737215484; c=relaxed/simple;
	bh=kpDar05Z+8TDqXL0VdtmIGvXoPqyDSXE0TPyDExkCH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qdd/LH9oRF+iXNBDl+FNi04tQAaa6mQgnp83c7XATYSiwNWVoZCCWYkB8RYGmrsx87vyPx+Ca/49RYkg2bPGHvYJ6jBACPStPQCSuerHaiEOiO5/+5qkHuKmlB82vg4s5992vZQ9TdGhrfI5jMvUtAoyWG7OQSzIESj6q1k6S1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=UVtcia/F; arc=none smtp.client-ip=80.12.242.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id ZB6MtxSpjzpxCZB6WtMt45; Sat, 18 Jan 2025 16:51:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1737215480;
	bh=6OfKyfNh9kt18eqBJGlLtTA1zHGzp0LyAtBzM8XOuxE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=UVtcia/FM6H859pGKKDOELvyte6Ap/JOEx647LRfK/4K5ebmEZj52dlwo7MSOutLN
	 QupR5DXo0viX4/PCIJBamlxJx9uuhicfl9UeweUodQ+4YhAKQ/HWd9Bo+eG5IdGM7v
	 KEmnz2jiqN8DveiCHdrSCI8QgvyRhfREpetr5m+GST0WJ7GHDS5rFrT+TXOok6aMnZ
	 PsOR1boctIw+6pY3lRQvFayhi/fLuZlTMoY/yClOu/td4gfnU77EaohPEVP4yPdg0E
	 rne6aokkwQWgjLTzT+ZXt0q5CBmpLEOfC4WFodEJ4N1TnBOW1LfslZs6Z68Ook9/3C
	 C/MCMyfzVFRYQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 18 Jan 2025 16:51:20 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	dmaengine@vger.kernel.org
Subject: [PATCH 2/3] dmaengine: ptdma: Slightly simplify error handling in pt_pci_probe()
Date: Sat, 18 Jan 2025 16:51:02 +0100
Message-ID: <3285a03b9b3b6b6c8fa15f2bdc3a7d11386283af.1737215423.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <ae19d76a10773d6ebee0e08cef49786eb20fd052.1737215423.git.christophe.jaillet@wanadoo.fr>
References: <ae19d76a10773d6ebee0e08cef49786eb20fd052.1737215423.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'ret' can be non-zero, only if pt_core_init() was called a few lines above.
So move this test inside the same "if" to make things more obvious.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/dma/amd/ptdma/ptdma-pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/amd/ptdma/ptdma-pci.c b/drivers/dma/amd/ptdma/ptdma-pci.c
index 7f12474bd39f..b25b6f7618c3 100644
--- a/drivers/dma/amd/ptdma/ptdma-pci.c
+++ b/drivers/dma/amd/ptdma/ptdma-pci.c
@@ -188,11 +188,11 @@ static int pt_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	dev_set_drvdata(dev, pt);
 
-	if (pt->dev_vdata)
+	if (pt->dev_vdata) {
 		ret = pt_core_init(pt);
-
-	if (ret)
-		goto e_free_irqs;
+		if (ret)
+			goto e_free_irqs;
+	}
 
 	return 0;
 
-- 
2.48.1


