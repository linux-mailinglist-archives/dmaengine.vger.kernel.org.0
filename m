Return-Path: <dmaengine+bounces-7221-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD635C6513D
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 17:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 357B04EE612
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 16:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E0A2D192B;
	Mon, 17 Nov 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHPMA0X1"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0702D0616;
	Mon, 17 Nov 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396005; cv=none; b=CdBdOV17pXhECeDLF8NI5tZJ3SNa9lDiimjQPztCc+LwvF/4zAMKwfR2oouN2BO/e32058OhZX7S4kUUYQtjvxlaj6AKNAcK2+WRHWSXFFNKdFsE4XJol2+MknxgONgGyYf6kRgTdqVdO55OhhLo+h3shMp7oSNDIesfiRfsA+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396005; c=relaxed/simple;
	bh=a/z8oiJ1emaOdi37ui+TS+tLvLimlhxJjpEUmOHOftw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LP2YBwEGXGMEWUT5O91kDx4hnX/Xh7kKtFVUV+WSq0JjPkSNu4bi1pnPWJx2iNKiN1CI0ZBttzABTezJNi8zBMFRs/9Vu3Y0cYQJa7TLMVG4WlracFSC4S0kAzZ5aCMXs7YFYCThbau404ENGQipFkzikRlO58ntqGLXk6T1Y/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHPMA0X1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42927C2BCB3;
	Mon, 17 Nov 2025 16:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763396005;
	bh=a/z8oiJ1emaOdi37ui+TS+tLvLimlhxJjpEUmOHOftw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jHPMA0X1ANaCFuJeKjxmU3tWhGqJ7obpUxJjBttqM/CPJvhOL1lkOywb1invE8fbF
	 K/9OLZAfIz1lxZDANrcw7yGpvDoW8OhZECYt+nB5xUIpqlQ7/C0n62wfinBBpdeaSG
	 xYYfqOJ7zmDDFl7bdpMUmq5EKqmjuVSwSf4OG9cbTtxz6ytxj/FPSC9p/d7prNxNpQ
	 u5tGxPSFTd5ZksmQ+Dk3LciDbhWC4FF+zFOKXXyTbhl9J01etFv9RwLzC2DK8TQV0K
	 Iti36CDYqHoGJdj/1IGYy9dfZjwarlLeWr7vGpXQ/p6FKJwkcnmqyrzqOZNrMq7okp
	 GJwXiZ5zSw2SQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vL1r1-000000002o8-1Gcc;
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
Subject: [PATCH 11/15] dmaengine: stm32: dmamux: clean up route allocation error labels
Date: Mon, 17 Nov 2025 17:12:54 +0100
Message-ID: <20251117161258.10679-13-johan@kernel.org>
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

Error labels should be named after what they do (and not after wherefrom
they are jumped to).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/dma/stm32/stm32-dmamux.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/stm32/stm32-dmamux.c b/drivers/dma/stm32/stm32-dmamux.c
index 2bd218dbabbb..db13498b9c9f 100644
--- a/drivers/dma/stm32/stm32-dmamux.c
+++ b/drivers/dma/stm32/stm32-dmamux.c
@@ -118,7 +118,7 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 		spin_unlock_irqrestore(&dmamux->lock, flags);
 		dev_err(&pdev->dev, "Run out of free DMA requests\n");
 		ret = -ENOMEM;
-		goto error_chan_id;
+		goto err_free_mux;
 	}
 	set_bit(mux->chan_id, dmamux->dma_inuse);
 	spin_unlock_irqrestore(&dmamux->lock, flags);
@@ -135,7 +135,7 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", i - 1);
 	if (!dma_spec->np) {
 		dev_err(&pdev->dev, "can't get dma master\n");
-		goto error;
+		goto err_clear_inuse;
 	}
 
 	/* Set dma request */
@@ -167,10 +167,9 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 
 err_put_dma_spec_np:
 	of_node_put(dma_spec->np);
-error:
+err_clear_inuse:
 	clear_bit(mux->chan_id, dmamux->dma_inuse);
-
-error_chan_id:
+err_free_mux:
 	kfree(mux);
 err_put_pdev:
 	put_device(&pdev->dev);
-- 
2.51.0


