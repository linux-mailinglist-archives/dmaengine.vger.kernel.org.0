Return-Path: <dmaengine+bounces-7224-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D374C650FD
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 17:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id CF66429005
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 16:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9242D29C2;
	Mon, 17 Nov 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPk9IpdM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9B82D238A;
	Mon, 17 Nov 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396005; cv=none; b=VrykFwJ5+pOzAwJ/IKrnfZoczxjDPocVaaqOpnQ/AX0LIR9jaSYNKzBlj0MR8VUR5tGdr473aLeQiqB0sgBjbhao2vO/lE9nkOh1oIbAcqh3rXXiC6HMEsyNmOhxc18bUUk8KGDbzlwITg5sBrFzpEDfV9KnwVWvYVBSCgQ36cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396005; c=relaxed/simple;
	bh=Z8NqhFEf8Fvku86AUBmfERbhqkjUKqdlmIojfDTnDYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPwmn4p0A0oXe0H9DDOMGEfF147vHDVrGbYF93AVMrLe0LJiHgtUMP4IVx/EP0QtrchWoNCG8ZheWjeWHt8m4W6I9zlIM6byPr0doaZXcZvKsWSFuZT2kzPBaCWf8cQGeJ6X8gdLKoc2q5xIMLY+KiHJxwkCA71y1hNIhQLobF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPk9IpdM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9572BC116B1;
	Mon, 17 Nov 2025 16:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763396005;
	bh=Z8NqhFEf8Fvku86AUBmfERbhqkjUKqdlmIojfDTnDYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HPk9IpdMlLa6wmBnftfH+GgxTDFPHUV5Zr5zGHqUl++tUFPjYGk4T67AWyonAPVut
	 wCj85L0v7BLOs/4K0RjQN+6S3png9QVoaRHQ+JHfY+o2/SZcoZ0qqKwDQDZLSdFxc3
	 ostT9nRbAY+5YrTgPE2SrB7XZJtJLerrE3hCuOuvhSN/MNPvn9e0ChLHe+8LWQbaTU
	 S4FnoU+e/rZexxP4fXpSp93G0W5oEyMsVVajvjskI/cl9hsFZ5KybsOZ6gdNjv7y4+
	 zmkNv7TdmXg/WetF2Uvw9gUeoeGbs5OZ2FLcNAoHRnyyGsGwymx+axNWmgfg8XjflO
	 bMPPKOFJhncKQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vL1r1-000000002oE-21g6;
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
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 13/15] dmaengine: ti: dma-crossbar: fix device leak on am335x route allocation
Date: Mon, 17 Nov 2025 17:12:56 +0100
Message-ID: <20251117161258.10679-15-johan@kernel.org>
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

Make sure to drop the reference taken when looking up the crossbar
platform device during am335x route allocation.

Fixes: 42dbdcc6bf96 ("dmaengine: ti-dma-crossbar: Add support for crossbar on AM33xx/AM43xx")
Cc: stable@vger.kernel.org	# 4.4
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/dma/ti/dma-crossbar.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/ti/dma-crossbar.c b/drivers/dma/ti/dma-crossbar.c
index e52b0e139900..ff05b150ad37 100644
--- a/drivers/dma/ti/dma-crossbar.c
+++ b/drivers/dma/ti/dma-crossbar.c
@@ -79,34 +79,35 @@ static void *ti_am335x_xbar_route_allocate(struct of_phandle_args *dma_spec,
 {
 	struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
 	struct ti_am335x_xbar_data *xbar = platform_get_drvdata(pdev);
-	struct ti_am335x_xbar_map *map;
+	struct ti_am335x_xbar_map *map = ERR_PTR(-EINVAL);
 
 	if (dma_spec->args_count != 3)
-		return ERR_PTR(-EINVAL);
+		goto out_put_pdev;
 
 	if (dma_spec->args[2] >= xbar->xbar_events) {
 		dev_err(&pdev->dev, "Invalid XBAR event number: %d\n",
 			dma_spec->args[2]);
-		return ERR_PTR(-EINVAL);
+		goto out_put_pdev;
 	}
 
 	if (dma_spec->args[0] >= xbar->dma_requests) {
 		dev_err(&pdev->dev, "Invalid DMA request line number: %d\n",
 			dma_spec->args[0]);
-		return ERR_PTR(-EINVAL);
+		goto out_put_pdev;
 	}
 
 	/* The of_node_put() will be done in the core for the node */
 	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", 0);
 	if (!dma_spec->np) {
 		dev_err(&pdev->dev, "Can't get DMA master\n");
-		return ERR_PTR(-EINVAL);
+		goto out_put_pdev;
 	}
 
 	map = kzalloc(sizeof(*map), GFP_KERNEL);
 	if (!map) {
 		of_node_put(dma_spec->np);
-		return ERR_PTR(-ENOMEM);
+		map = ERR_PTR(-ENOMEM);
+		goto out_put_pdev;
 	}
 
 	map->dma_line = (u16)dma_spec->args[0];
@@ -120,6 +121,9 @@ static void *ti_am335x_xbar_route_allocate(struct of_phandle_args *dma_spec,
 
 	ti_am335x_xbar_write(xbar->iomem, map->dma_line, map->mux_val);
 
+out_put_pdev:
+	put_device(&pdev->dev);
+
 	return map;
 }
 
-- 
2.51.0


