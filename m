Return-Path: <dmaengine+bounces-7216-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 248E1C65134
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 17:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D728C4EDF59
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 16:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DE82D027E;
	Mon, 17 Nov 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cu1DHYUV"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CC02C3252;
	Mon, 17 Nov 2025 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396005; cv=none; b=XSCM05R+eaybC6PJ5x0ykYhYU9i/Nslxi8dkydccd5CXWGLP4uXIF000//PZo8LtWpOYlrlgO/xc/GjpRd0rbeGq4G01WBeRgXkCLW3jwHn64CG5PiAkgsukorF9srvV3/Ml4SVpyxmkzNBG1y8SHH/y76gNJRGilt2Yf8C6pDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396005; c=relaxed/simple;
	bh=oJuF1iY88Mpi7VOqHbnjYrJMJU1Agh3Lfe9Wxf7yHvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/mT9nscgC3RVtOKKDsXuK7cEaou4rJv4bkhNX3nUGR7CAXX/OIJi1F6DKsyNKK7bT2FOZNykdU0pjxbD6jpudNXk547roW5JCXZ89/RoJgK0VwlpjN3CpABfeeXikUm2OeXUic6shqm8S0UHZzxPa79sMVRVLk9+1QkMIHRTZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cu1DHYUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7BAC2BC87;
	Mon, 17 Nov 2025 16:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763396004;
	bh=oJuF1iY88Mpi7VOqHbnjYrJMJU1Agh3Lfe9Wxf7yHvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cu1DHYUVgtEm205Jb5mmzJC/SVEFZKltYM/QvaPgYkZXi5dZRxJuosZ+HRoQQLQzD
	 g8BAIo1qP9bIMCIQ8eRoA8lPB5QVB8LJP9sRCX7o3zQsUP8FrGbA3EKL6GG8pfcCOQ
	 98wjO4qYy/ahSzpc+N3H2a6q9LwgENkrfDb7iQARH5sOMau6WMjgpKKo6EX6TlKd9B
	 bU4DHzAIpJW7YkSa9ccJ9WN+OjFjnltcSPUmWLZNws9DSbDmOiIhit5rlSa2H5r4p/
	 OptEh5av8tplwBjFQr4XwqqG/XSaCuasYL4QNhXfrfILl53r354PReAiIKwqsE6EHg
	 uoYez+6nZWcMg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vL1r0-000000002ns-3UOf;
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
	stable@vger.kernel.org
Subject: [PATCH 06/15] dmaengine: lpc18xx-dmamux: fix device leak on route allocation
Date: Mon, 17 Nov 2025 17:12:49 +0100
Message-ID: <20251117161258.10679-8-johan@kernel.org>
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

Fixes: e5f4ae84be74 ("dmaengine: add driver for lpc18xx dmamux")
Cc: stable@vger.kernel.org	# 4.3
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/dma/lpc18xx-dmamux.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/lpc18xx-dmamux.c b/drivers/dma/lpc18xx-dmamux.c
index 2b6436f4b193..d3ff521951b8 100644
--- a/drivers/dma/lpc18xx-dmamux.c
+++ b/drivers/dma/lpc18xx-dmamux.c
@@ -57,30 +57,31 @@ static void *lpc18xx_dmamux_reserve(struct of_phandle_args *dma_spec,
 	struct lpc18xx_dmamux_data *dmamux = platform_get_drvdata(pdev);
 	unsigned long flags;
 	unsigned mux;
+	int ret = -EINVAL;
 
 	if (dma_spec->args_count != 3) {
 		dev_err(&pdev->dev, "invalid number of dma mux args\n");
-		return ERR_PTR(-EINVAL);
+		goto err_put_pdev;
 	}
 
 	mux = dma_spec->args[0];
 	if (mux >= dmamux->dma_master_requests) {
 		dev_err(&pdev->dev, "invalid mux number: %d\n",
 			dma_spec->args[0]);
-		return ERR_PTR(-EINVAL);
+		goto err_put_pdev;
 	}
 
 	if (dma_spec->args[1] > LPC18XX_DMAMUX_MAX_VAL) {
 		dev_err(&pdev->dev, "invalid dma mux value: %d\n",
 			dma_spec->args[1]);
-		return ERR_PTR(-EINVAL);
+		goto err_put_pdev;
 	}
 
 	/* The of_node_put() will be done in the core for the node */
 	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", 0);
 	if (!dma_spec->np) {
 		dev_err(&pdev->dev, "can't get dma master\n");
-		return ERR_PTR(-EINVAL);
+		goto err_put_pdev;
 	}
 
 	spin_lock_irqsave(&dmamux->lock, flags);
@@ -89,7 +90,8 @@ static void *lpc18xx_dmamux_reserve(struct of_phandle_args *dma_spec,
 		dev_err(&pdev->dev, "dma request %u busy with %u.%u\n",
 			mux, mux, dmamux->muxes[mux].value);
 		of_node_put(dma_spec->np);
-		return ERR_PTR(-EBUSY);
+		ret = -EBUSY;
+		goto err_put_pdev;
 	}
 
 	dmamux->muxes[mux].busy = true;
@@ -106,7 +108,14 @@ static void *lpc18xx_dmamux_reserve(struct of_phandle_args *dma_spec,
 	dev_dbg(&pdev->dev, "mapping dmamux %u.%u to dma request %u\n", mux,
 		dmamux->muxes[mux].value, mux);
 
+	put_device(&pdev->dev);
+
 	return &dmamux->muxes[mux];
+
+err_put_pdev:
+	put_device(&pdev->dev);
+
+	return ERR_PTR(ret);
 }
 
 static int lpc18xx_dmamux_probe(struct platform_device *pdev)
-- 
2.51.0


