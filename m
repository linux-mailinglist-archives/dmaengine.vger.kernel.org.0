Return-Path: <dmaengine+bounces-6166-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A08DBB32A0D
	for <lists+dmaengine@lfdr.de>; Sat, 23 Aug 2025 17:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5207C7BD751
	for <lists+dmaengine@lfdr.de>; Sat, 23 Aug 2025 15:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E05F2EA47C;
	Sat, 23 Aug 2025 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLx3ZixC"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135872EA473;
	Sat, 23 Aug 2025 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964666; cv=none; b=UnGHz1Nc3fU85rbDNIZVXxcSE66OOX2vhVtcrJquByKlML0mylYSGu7pmxl0M1AgEN3Fbsrp70LHNTRRwnlW0FaJNCf71jIQZLvk/0Sv3Tl9j907K3ahcG5/dJ9/kamkt83vxfQTr4o+BYQOunsAS+Yq0UZIe8850LHniL753tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964666; c=relaxed/simple;
	bh=KWbtZGmR1vxk04Y7G5CXe1Skc7vZRzVxtl2PKtoxGyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7jFLWWd9ZwgUah94tmKPktwT3/q2dAGwVSCaouWIzhnzl2F9B11X1a946XQbsOGIv0zx+7rBRKutCluZgJOTvduWJMiujIGVYd+Wb8KRq5AwwIWaFgmsh7YXPn46rXV3+QE2Mc+psBTZ8jPDUvVt8iNH1JPy91A6Tag9789iIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLx3ZixC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4589C4CEF4;
	Sat, 23 Aug 2025 15:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755964665;
	bh=KWbtZGmR1vxk04Y7G5CXe1Skc7vZRzVxtl2PKtoxGyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PLx3ZixC5rCj5/eVezg1t0UYlvV5cDEBwQ3KALN4OfBsNOpaiYgUkPhVFwcCYXMn4
	 C0/N2wRGJktQVl3BUuI/i03IoCiElCoxfvGSMUKoD4aPJl+iaTNhDe2GF0voPK55JM
	 DYyEf/xDjGw7N77PITP7rTNS9KF4L31OAJwJivt/DFibuiqgHGDXqO3F2TRrqbcvF/
	 w6Iv6lWo1mVn1zT5wiy7KxbkCGL7u3KCnBY+FoeC4kny2DmlePZhafN3iwMuUKTPeH
	 FXx51RwVPNE/EOzHdMz70t2+jYa3fGz7dcLdZ/wfkq289ZKrzf2nS++gzHqiA0lFRG
	 58hmAKxwT+WaA==
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
Subject: [PATCH 05/14] dmaengine: dma350: Register the DMA controller to DT DMA helpers
Date: Sat, 23 Aug 2025 23:40:00 +0800
Message-ID: <20250823154009.25992-6-jszhang@kernel.org>
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

Register the DMA controller to DT DMA helpers so that we convert a DT
phandle to a dma_chan structure.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/dma/arm-dma350.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
index 17af9bb2a18f..6a9f81f941b0 100644
--- a/drivers/dma/arm-dma350.c
+++ b/drivers/dma/arm-dma350.c
@@ -7,6 +7,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_dma.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
@@ -635,7 +636,7 @@ static int d350_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to register DMA device\n");
 
-	return 0;
+	return of_dma_controller_register(dev->of_node, of_dma_xlate_by_chan_id, &dmac->dma);
 }
 
 static void d350_remove(struct platform_device *pdev)
@@ -643,6 +644,7 @@ static void d350_remove(struct platform_device *pdev)
 	struct d350 *dmac = platform_get_drvdata(pdev);
 
 	dma_async_device_unregister(&dmac->dma);
+	of_dma_controller_free(pdev->dev.of_node);
 }
 
 static const struct of_device_id d350_of_match[] __maybe_unused = {
-- 
2.50.0


