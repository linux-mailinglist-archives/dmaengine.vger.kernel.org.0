Return-Path: <dmaengine+bounces-7223-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 35209C6516A
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 17:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B03435A4A7
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 16:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DAA29B78D;
	Mon, 17 Nov 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjS8KJPJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A089C2D0C90;
	Mon, 17 Nov 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396005; cv=none; b=Na8WVomDrkjc9+6NCndrTP2EJcxsM54gRtkcSi19LXGTzsRDGQ4HHaXapkJAJmgXZFWrOMWJbL8BMp6nwMZi8KZK7mpYl33bvx8r5zQEovkgSoCSexTjXSaC+K9uQ92+q03ZnAOrc+Fzjb4HiMXzcaQtA6IwSKQAUFAFcV4UoWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396005; c=relaxed/simple;
	bh=d7H3wTk9NdknnpBJr/9afEsXCffQd73eDOt2Nt3ybZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLMxMXmXwjhELd8SxbpCTPwfUljaIgbHs0IYaASDvRoRFuRw8MhQvkUaOG7bvFZs0c3ZLTVq+rG0fVKl5QcvMc9EvE0hKNSs/+/qE1CgOkA8MgXxILtTkFJxkTzXgenMJLNQgcmByrMc/J2tdEReWVmD6a9lScbDJQnza6IEznQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjS8KJPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7C8C19423;
	Mon, 17 Nov 2025 16:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763396005;
	bh=d7H3wTk9NdknnpBJr/9afEsXCffQd73eDOt2Nt3ybZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CjS8KJPJCByvMHTF4347x3gr8PW4ITg0Gu5RrU3h6d2rkE1NDRc0DJDew1jGM8ncU
	 UvpoTBZf4S2iJSPunnodDJO1HDyvcgNqFdjWxB7I+6qTGZe0fW3bolp1FpkPnOga1X
	 y3MeRd9i/tIDDBH0n/qzhakhFTqIVum7wMhXdTWBZwsAQ9NFz0ob+NtqFblDEjlEl1
	 Sz/lWHdpnxihVwKRJluxNqPpx8C0tp7GRhc0+mm6jo/bE3OLtlkVAsNg+EUj9Hxvdf
	 FaYGF10oHsRUr0pOAIYJjMLeGj2XTwJ0kSAZ6SwmZzOQAjK3GJvJqktipjSohsDMFN
	 VQvd2XUbmXsYg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vL1r1-000000002oH-2QU9;
	Mon, 17 Nov 2025 17:13:23 +0100
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
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 14/15] dmaengine: ti: dma-crossbar: clean up dra7x route allocation error paths
Date: Mon, 17 Nov 2025 17:12:57 +0100
Message-ID: <20251117161258.10679-16-johan@kernel.org>
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

Use a common exit path to drop the cross platform device reference on
errors for consistency with am335x.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/dma/ti/dma-crossbar.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/ti/dma-crossbar.c b/drivers/dma/ti/dma-crossbar.c
index ff05b150ad37..e04077d542d2 100644
--- a/drivers/dma/ti/dma-crossbar.c
+++ b/drivers/dma/ti/dma-crossbar.c
@@ -245,28 +245,26 @@ static void *ti_dra7_xbar_route_allocate(struct of_phandle_args *dma_spec,
 {
 	struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
 	struct ti_dra7_xbar_data *xbar = platform_get_drvdata(pdev);
-	struct ti_dra7_xbar_map *map;
+	struct ti_dra7_xbar_map *map = ERR_PTR(-EINVAL);
 
 	if (dma_spec->args[0] >= xbar->xbar_requests) {
 		dev_err(&pdev->dev, "Invalid XBAR request number: %d\n",
 			dma_spec->args[0]);
-		put_device(&pdev->dev);
-		return ERR_PTR(-EINVAL);
+		goto out_put_pdev;
 	}
 
 	/* The of_node_put() will be done in the core for the node */
 	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", 0);
 	if (!dma_spec->np) {
 		dev_err(&pdev->dev, "Can't get DMA master\n");
-		put_device(&pdev->dev);
-		return ERR_PTR(-EINVAL);
+		goto out_put_pdev;
 	}
 
 	map = kzalloc(sizeof(*map), GFP_KERNEL);
 	if (!map) {
 		of_node_put(dma_spec->np);
-		put_device(&pdev->dev);
-		return ERR_PTR(-ENOMEM);
+		map = ERR_PTR(-ENOMEM);
+		goto out_put_pdev;
 	}
 
 	mutex_lock(&xbar->mutex);
@@ -277,8 +275,8 @@ static void *ti_dra7_xbar_route_allocate(struct of_phandle_args *dma_spec,
 		dev_err(&pdev->dev, "Run out of free DMA requests\n");
 		kfree(map);
 		of_node_put(dma_spec->np);
-		put_device(&pdev->dev);
-		return ERR_PTR(-ENOMEM);
+		map = ERR_PTR(-ENOMEM);
+		goto out_put_pdev;
 	}
 	set_bit(map->xbar_out, xbar->dma_inuse);
 	mutex_unlock(&xbar->mutex);
@@ -292,6 +290,7 @@ static void *ti_dra7_xbar_route_allocate(struct of_phandle_args *dma_spec,
 
 	ti_dra7_xbar_write(xbar->iomem, map->xbar_out, map->xbar_in);
 
+out_put_pdev:
 	put_device(&pdev->dev);
 
 	return map;
-- 
2.51.0


