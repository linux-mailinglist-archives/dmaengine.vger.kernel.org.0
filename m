Return-Path: <dmaengine+bounces-7219-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E2DC65155
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 17:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 31BB93568F9
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 16:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1672D0634;
	Mon, 17 Nov 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfCIpUhl"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9A92C3259;
	Mon, 17 Nov 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396005; cv=none; b=da/Bd1sZhmrJlTTzG8qNpK9bJhzpmgb0MCgESR8Q0YPlnc7cLIxv5YeCIHVmliXUufsQYlAWLB0wA1GO3Ujtep3YWF65G1ewiuomylqSouzEPSjsct6ZuVlo20annbVzpYN5WVi9Bn9aC27EnLd1NWy9Evkks9nbrNBy8rfyv0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396005; c=relaxed/simple;
	bh=5jhp2qvO0rHVrq0HKmOWaRqTDSDSkNCr3jjIIuXsGzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PqSkBBbjPLkoiPbagUdSsUvawqTWDabNOIRRiPUUsqbp2oGfm2lCPkWG1dMmmeY7R50lXwdVGtf9gEo/ZK27TSx1TiTVQzm1RLD7oKB/HM5v5HzELgJLetRabd2zcDpe4bvH1IJVIl5JH93LohRUGcPk86ryNPcvaD1M7OeiBpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfCIpUhl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120A9C2BCB1;
	Mon, 17 Nov 2025 16:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763396005;
	bh=5jhp2qvO0rHVrq0HKmOWaRqTDSDSkNCr3jjIIuXsGzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OfCIpUhld0WTnUFtatmt7+0DZ7alHoRi4w1T/9y/nJCOqhH2F3dIxyoAFK1IaJ/i6
	 xdWTmgkNi90QwTx3LEorB8OiMETlsOw3Jo8yPP7WcfKk/mJ6i9MG6MbL/2Lg+bBP+B
	 f2o4HxZTmySciGOMfKEC5ZnDF5YYJQx1ZbuAiufsMPpBKiSEKxTm7YyOzW2fJ2x9IP
	 qacT39tDHvlK4BnB3SlNSYUhIZSiq1fF3FJOem5fGjKlcOHtBfIasClivrE0f27EH3
	 j6E3FL/cUaeDTY1RO5PTXewJTO9FUinkOPWi4z8wWuIo3y72XFrawWmwvDFuxuviWU
	 RVddu56CzTyRw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vL1r1-000000002o3-0Y6X;
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
	Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>
Subject: [PATCH 09/15] dmaengine: stm32: dmamux: fix device leak on route allocation
Date: Mon, 17 Nov 2025 17:12:52 +0100
Message-ID: <20251117161258.10679-11-johan@kernel.org>
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

Fixes: df7e762db5f6 ("dmaengine: Add STM32 DMAMUX driver")
Cc: stable@vger.kernel.org	# 4.15
Cc: Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/dma/stm32/stm32-dmamux.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/stm32/stm32-dmamux.c b/drivers/dma/stm32/stm32-dmamux.c
index 8d77e2a7939a..791179760782 100644
--- a/drivers/dma/stm32/stm32-dmamux.c
+++ b/drivers/dma/stm32/stm32-dmamux.c
@@ -90,23 +90,25 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 	struct stm32_dmamux_data *dmamux = platform_get_drvdata(pdev);
 	struct stm32_dmamux *mux;
 	u32 i, min, max;
-	int ret;
+	int ret = -EINVAL;
 	unsigned long flags;
 
 	if (dma_spec->args_count != 3) {
 		dev_err(&pdev->dev, "invalid number of dma mux args\n");
-		return ERR_PTR(-EINVAL);
+		goto err_put_pdev;
 	}
 
 	if (dma_spec->args[0] > dmamux->dmamux_requests) {
 		dev_err(&pdev->dev, "invalid mux request number: %d\n",
 			dma_spec->args[0]);
-		return ERR_PTR(-EINVAL);
+		goto err_put_pdev;
 	}
 
 	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
-	if (!mux)
-		return ERR_PTR(-ENOMEM);
+	if (!mux) {
+		ret = -ENOMEM;
+		goto err_put_pdev;
+	}
 
 	spin_lock_irqsave(&dmamux->lock, flags);
 	mux->chan_id = find_first_zero_bit(dmamux->dma_inuse,
@@ -133,7 +135,6 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", i - 1);
 	if (!dma_spec->np) {
 		dev_err(&pdev->dev, "can't get dma master\n");
-		ret = -EINVAL;
 		goto error;
 	}
 
@@ -160,6 +161,8 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 	dev_dbg(&pdev->dev, "Mapping DMAMUX(%u) to DMA%u(%u)\n",
 		mux->request, mux->master, mux->chan_id);
 
+	put_device(&pdev->dev);
+
 	return mux;
 
 error:
@@ -167,6 +170,9 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 
 error_chan_id:
 	kfree(mux);
+err_put_pdev:
+	put_device(&pdev->dev);
+
 	return ERR_PTR(ret);
 }
 
-- 
2.51.0


