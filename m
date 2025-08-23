Return-Path: <dmaengine+bounces-6167-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F57B32A0F
	for <lists+dmaengine@lfdr.de>; Sat, 23 Aug 2025 17:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB25A2024A
	for <lists+dmaengine@lfdr.de>; Sat, 23 Aug 2025 15:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC792EAB68;
	Sat, 23 Aug 2025 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bhvde1O2"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5276B2E92CF;
	Sat, 23 Aug 2025 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964669; cv=none; b=pC6Rgu6LdnysxPM7TQyJAdepCeeuJtr1iWdmu8njf04csnZPOqtvjneDI8sqiIidhNZ3KMVNDFVV5D9vns2YTe1WfE4zI1TymtOpCJJDrRicU/xy2xGyi0KM/XeCChp9X0CSnmil12Phrfg0byKEa/HAlMDX1z94ylWzPZSUs2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964669; c=relaxed/simple;
	bh=s7oD37zLo4PNqPj/0q6kfWR1oTy0TLuV58NqZ0ga9Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWMD4zJPONv3kJCl3fHepkLAA7DyUj8NAeKkcpeq9wWg5HgDUYB+SYP3PNokQ/zdMH09UNnp+hRzuUoxRKwOUeSUacU626q6VPwXKNfyBrbodkY+66GElibOvfygSBF1tj2Iu6GfZvv+QH8sBwznLS22jYLqgFPbecAnxiBShSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bhvde1O2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C842FC4CEF4;
	Sat, 23 Aug 2025 15:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755964668;
	bh=s7oD37zLo4PNqPj/0q6kfWR1oTy0TLuV58NqZ0ga9Qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bhvde1O2ygcrGguXmvnmR07UkPAS0Jvm3rZz84Is0xnvwI6mvKjfBDnIPWH697qQ2
	 8jPg4ZpiZ9tQVhZZNAJKf47REOJoPYA7zFwUGoeRdPHHPDpg474Fn1fosF4QLqqdTx
	 lWLtYrfHzjBKgvfx6ZUENfB/Hgm5L7ROOtQ5i1TLh+pMjF69hYS937v2u68xPHWdnP
	 izlL1nucTRV7hYyMuRj+dL7tE8YUSQ70Vrc/9kqXuBloZxNaKb+x0fG5MLdHRPCIAS
	 n9M6fV+OrJaNkDvwq2C3oIxC8se9pgBXiB3NAJZ1pbsVaBWHtVvCDnKQFgwqj50V+r
	 0UMzEBhIYa+JA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/14] dmaengine: dma350: Use dmaenginem_async_device_register
Date: Sat, 23 Aug 2025 23:40:01 +0800
Message-ID: <20250823154009.25992-7-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250823154009.25992-1-jszhang@kernel.org>
References: <20250823154009.25992-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use managed API dmaenginem_async_device_register() to simplify code
path.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/dma/arm-dma350.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
index 6a9f81f941b0..36c8bfa67d70 100644
--- a/drivers/dma/arm-dma350.c
+++ b/drivers/dma/arm-dma350.c
@@ -632,7 +632,7 @@ static int d350_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, dmac);
 
-	ret = dma_async_device_register(&dmac->dma);
+	ret = dmaenginem_async_device_register(&dmac->dma);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to register DMA device\n");
 
@@ -641,9 +641,6 @@ static int d350_probe(struct platform_device *pdev)
 
 static void d350_remove(struct platform_device *pdev)
 {
-	struct d350 *dmac = platform_get_drvdata(pdev);
-
-	dma_async_device_unregister(&dmac->dma);
 	of_dma_controller_free(pdev->dev.of_node);
 }
 
-- 
2.50.0


