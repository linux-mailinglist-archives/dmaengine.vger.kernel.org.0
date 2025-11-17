Return-Path: <dmaengine+bounces-7218-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CD1C650F7
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 17:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id F15C828C7A
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 16:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A352D0620;
	Mon, 17 Nov 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXx6BYgO"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3816F2C3255;
	Mon, 17 Nov 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396005; cv=none; b=QvUFW7R8Mu/Hzt2IjlCdHoL6SgAY3loGU/Fc8bclpdfT56aTY2n6/bsDbpm15SWqEqszl1EEHHu2lIWCOO+/3D763AMO8nrWTBnbNag70b/wnkyGNpjJQPjSukTcckdJd95oSGhfhfLRwu3wT8oAr/yIeawQRvFkhY1slUjiJLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396005; c=relaxed/simple;
	bh=VBdlt/U82+VSKcAFX8Y5c0YN3goi7irfhq7BlBASkaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1HYESuQjQeynOy31aTwRKZpHGCIZXEoO9PmxyWhtiD1IcHdx0gN/A1DZG8O9bCjvBcNDsCjgP2T0LeDsMzojUB5ncs3ueDlSkgTaXmNPhIclt9fF5C27Q4icz3eNH4LSjgcRTSCAwz118McOONiIBvaYD1XukRUu1P9hTVI5FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXx6BYgO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7ABAC19425;
	Mon, 17 Nov 2025 16:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763396005;
	bh=VBdlt/U82+VSKcAFX8Y5c0YN3goi7irfhq7BlBASkaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sXx6BYgO8wlWV+HuayrfP9NQyPgF1ynggGKCfEPzsPa0uMlExf8FO1qMTvriuNC3X
	 Mou9CC8QbfBGNx7NnnlBaNaa059D6ktxowiGOMhY9HQ631O38fnhGm2LbDqBffyrSs
	 b7VdUZY3wijCqcBcsbULbhQs6MPHylANLXn6X2iCpmD5K6TeNMO+zJlMAIyosYkstc
	 4vJaCRVlUGZSDnaf8cJ75nxpPMOKMZWXJ9rfcdmGB3eF19WETT+gJ2wV0wPVe74lXM
	 PkiWKsDNtSYuW4fcrAoFL9ZTTM810lxVFARAbckj8RIJsBLgI/5avfWp9T2QlrMXk1
	 fmvHBCibiUQdA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vL1r0-000000002nv-3ukB;
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
Subject: [PATCH 07/15] dmaengine: lpc32xx-dmamux: fix device leak on route allocation
Date: Mon, 17 Nov 2025 17:12:50 +0100
Message-ID: <20251117161258.10679-9-johan@kernel.org>
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

Fixes: 5d318b595982 ("dmaengine: Add dma router for pl08x in LPC32XX SoC")
Cc: stable@vger.kernel.org	# 6.12
Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/dma/lpc32xx-dmamux.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/lpc32xx-dmamux.c b/drivers/dma/lpc32xx-dmamux.c
index 351d7e23e615..33be714740dd 100644
--- a/drivers/dma/lpc32xx-dmamux.c
+++ b/drivers/dma/lpc32xx-dmamux.c
@@ -95,11 +95,12 @@ static void *lpc32xx_dmamux_reserve(struct of_phandle_args *dma_spec,
 	struct lpc32xx_dmamux_data *dmamux = platform_get_drvdata(pdev);
 	unsigned long flags;
 	struct lpc32xx_dmamux *mux = NULL;
+	int ret = -EINVAL;
 	int i;
 
 	if (dma_spec->args_count != 3) {
 		dev_err(&pdev->dev, "invalid number of dma mux args\n");
-		return ERR_PTR(-EINVAL);
+		goto err_put_pdev;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(lpc32xx_muxes); i++) {
@@ -111,20 +112,20 @@ static void *lpc32xx_dmamux_reserve(struct of_phandle_args *dma_spec,
 	if (!mux) {
 		dev_err(&pdev->dev, "invalid mux request number: %d\n",
 			dma_spec->args[0]);
-		return ERR_PTR(-EINVAL);
+		goto err_put_pdev;
 	}
 
 	if (dma_spec->args[2] > 1) {
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
@@ -133,7 +134,8 @@ static void *lpc32xx_dmamux_reserve(struct of_phandle_args *dma_spec,
 		dev_err(dev, "dma request signal %d busy, routed to %s\n",
 			mux->signal, mux->muxval ? mux->name_sel1 : mux->name_sel1);
 		of_node_put(dma_spec->np);
-		return ERR_PTR(-EBUSY);
+		ret = -EBUSY;
+		goto err_put_pdev;
 	}
 
 	mux->busy = true;
@@ -148,7 +150,14 @@ static void *lpc32xx_dmamux_reserve(struct of_phandle_args *dma_spec,
 	dev_dbg(dev, "dma request signal %d routed to %s\n",
 		mux->signal, mux->muxval ? mux->name_sel1 : mux->name_sel1);
 
+	put_device(&pdev->dev);
+
 	return mux;
+
+err_put_pdev:
+	put_device(&pdev->dev);
+
+	return ERR_PTR(ret);
 }
 
 static int lpc32xx_dmamux_probe(struct platform_device *pdev)
-- 
2.51.0


