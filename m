Return-Path: <dmaengine+bounces-7215-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DE547C65151
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 17:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2B8D9365D34
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 16:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DA62C3774;
	Mon, 17 Nov 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVcHPq8Z"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9EF2C3242;
	Mon, 17 Nov 2025 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396005; cv=none; b=R33rZI90fT/faRcxMlQPrSHXrA3VicTdtUEkD/f7hSJX5pCgij/o03HJXJJyC/vWO/8IgwpqMI33CCjvWsZ5nvN7M/zI3GG+nXodoR89VeODvVom85FaWpK9Yu9dNQDm6zehG8oIM39CojaDzN15QAK4gKmej1ZAaunix3AXA5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396005; c=relaxed/simple;
	bh=0DynXlE5pKQC4/xRzubob/eyJtg08UMyjLT5ZcH1k6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WfCAeaN9thtnURey/4vkVlyRJf4yOmTHbK2TT2rOP6KJVIgXSqm1QMF1XzAy0LahravG2syUgpm+MxpCLB4DpI7pPAY2SjJ3t1RJs6UMHoaSkHly6rfZSevwQ8anv/EhuQsI/fY08JQ3EYk6+LeTXGVjUwgozH6yrt8eu+2FseA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVcHPq8Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9ECC113D0;
	Mon, 17 Nov 2025 16:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763396004;
	bh=0DynXlE5pKQC4/xRzubob/eyJtg08UMyjLT5ZcH1k6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mVcHPq8ZTWz4uWDZWzVMMjJXFU/M86wxffulhTv2OQbHxP71Xol2t2Xch0HyGvpSt
	 u8+qnCeMIZf/d9YY3qvqzSwk1SKGv6GgayVFNQppif6bHWJ60Pz8nDdWueclC5ZLVA
	 tMwaCotSaGMJJNwMMiseBYNZfq98FMqoHA3jqUnAMwlVgzFMTKa28mE7QmbmAlYLme
	 eDeHKXC73vV9ZVEfrrTECVt8rjyZT1sUcD/lmsv/xnp4Ynt8OAyLW5rafuAnSnMrhH
	 pVaaweTRoyo0lGS1p8M24RP6+YU4+IEF8X1mtX3bCDlQrrP+nBXr/b4EmPmn2aBWuk
	 FnMLxvCknKK+A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vL1r0-000000002nb-2Lzy;
	Mon, 17 Nov 2025 17:13:22 +0100
From: Johan Hovold <johan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	=?UTF-8?q?Am=C3=A9lie=20Delaunay?= <amelie.delaunay@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Inochi Amaoto <inochiama@gmail.com>
Subject: [PATCH 03/15] dmaengine: cv1800b-dmamux: fix device leak on route allocation
Date: Mon, 17 Nov 2025 17:12:46 +0100
Message-ID: <20251117161258.10679-5-johan@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117161258.10679-1-johan@kernel.org>
References: <20251117161258.10679-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken when looking up the DMA mux
platform device during route allocation.

Note that holding a reference to a device does not prevent its driver
data from going away so there is no point in keeping the reference.

Fixes: db7d07b5add4 ("dmaengine: add driver for Sophgo CV18XX/SG200X dmamux")
Cc: stable@vger.kernel.org	# 6.17
Cc: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/dma/cv1800b-dmamux.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/cv1800b-dmamux.c b/drivers/dma/cv1800b-dmamux.c
index e900d6595617..f7a952fcbc7d 100644
--- a/drivers/dma/cv1800b-dmamux.c
+++ b/drivers/dma/cv1800b-dmamux.c
@@ -102,11 +102,11 @@ static void *cv1800_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 	struct llist_node *node;
 	unsigned long flags;
 	unsigned int chid, devid, cpuid;
-	int ret;
+	int ret = -EINVAL;
 
 	if (dma_spec->args_count != DMAMUX_NCELLS) {
 		dev_err(&pdev->dev, "invalid number of dma mux args\n");
-		return ERR_PTR(-EINVAL);
+		goto err_put_pdev;
 	}
 
 	devid = dma_spec->args[0];
@@ -115,18 +115,18 @@ static void *cv1800_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 
 	if (devid > MAX_DMA_MAPPING_ID) {
 		dev_err(&pdev->dev, "invalid device id: %u\n", devid);
-		return ERR_PTR(-EINVAL);
+		goto err_put_pdev;
 	}
 
 	if (cpuid > MAX_DMA_CPU_ID) {
 		dev_err(&pdev->dev, "invalid cpu id: %u\n", cpuid);
-		return ERR_PTR(-EINVAL);
+		goto err_put_pdev;
 	}
 
 	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", 0);
 	if (!dma_spec->np) {
 		dev_err(&pdev->dev, "can't get dma master\n");
-		return ERR_PTR(-EINVAL);
+		goto err_put_pdev;
 	}
 
 	spin_lock_irqsave(&dmamux->lock, flags);
@@ -136,8 +136,6 @@ static void *cv1800_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 			if (map->peripheral == devid && map->cpu == cpuid)
 				goto found;
 		}
-
-		ret = -EINVAL;
 		goto failed;
 	} else {
 		node = llist_del_first(&dmamux->free_maps);
@@ -171,12 +169,17 @@ static void *cv1800_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 	dev_dbg(&pdev->dev, "register channel %u for req %u (cpu %u)\n",
 		chid, devid, cpuid);
 
+	put_device(&pdev->dev);
+
 	return map;
 
 failed:
 	spin_unlock_irqrestore(&dmamux->lock, flags);
 	of_node_put(dma_spec->np);
 	dev_err(&pdev->dev, "errno %d\n", ret);
+err_put_pdev:
+	put_device(&pdev->dev);
+
 	return ERR_PTR(ret);
 }
 
-- 
2.51.0


