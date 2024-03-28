Return-Path: <dmaengine+bounces-1617-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E4A8900F9
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 14:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53FFE1C2AE93
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 13:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6913B7FBA5;
	Thu, 28 Mar 2024 13:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clJiKIPM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DA157895
	for <dmaengine@vger.kernel.org>; Thu, 28 Mar 2024 13:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634332; cv=none; b=ux9V20AUwL4h3LydSE/fLTOpf+OylQk1NeMv7XyfsFlWXlZFnbZh/rm2H9fBzobCB3KL1RoRBVDa3scneXur4UGR95gfXcwyg/NW7oEthrFAJaxy2RUyqRrA3wpopXwGAzoQXMFEqe04JoozWMQ3Yixkrw/dibOo13hraq0e1Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634332; c=relaxed/simple;
	bh=yQbS7aWJnaWlm8XUGbxJroqEnni+qmEzKqt996F6Hho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AY+pGA/MPjHznlLKCcwHb3oM/re8d/awczP35YWv8wPNioPE/uK6D8SVuS6PcmNNDUMbQoj9ert9CDZk04VgAhoRmDxfvprZ1DQsrpVYKhDV7cVa727TNhyJpu9THzrCS229aU/PcmuAW0ltQ+SYS145KGAhJ+AMpEf4d8Ee2Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clJiKIPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC75DC433F1;
	Thu, 28 Mar 2024 13:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711634331;
	bh=yQbS7aWJnaWlm8XUGbxJroqEnni+qmEzKqt996F6Hho=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=clJiKIPM6mPcIgLmgV/OElxldXhmn8P0kIqEkzdMr5iMwnmQIhk7CLjkILNpXVb8N
	 Pq8A8XQleG4KCZGB6jXbNhTFz5YtVTeFV8YgNUzJcg9buJOPiEyTQQnj5/38eGhvK+
	 s5gLfPsmCPN9a/er7W/DxlfPjidAtDVwG4R8boqB4h6mKFfLK4TUcu4kURqdSZIdaJ
	 iQ7SZ79glgw0pNZTrHk4l/5qL5A37CzzRPWtXsFkBAz5vhISuAan0R3pEu1EPzCWg+
	 6Hn+cZnU5cV0ntkz62FE9S6Mn0qe4DMoflvg3FbzBpQf4tMLcgb5DdtdVLUyhq4jof
	 CuE7dbrZXx7Jw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA06C54E64;
	Thu, 28 Mar 2024 13:58:51 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 28 Mar 2024 14:58:50 +0100
Subject: [PATCH RESEND v3 1/2] dmaengine: axi-dmac: fix possible race in
 remove()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-axi-dmac-devm-probe-v3-1-523c0176df70@analog.com>
References: <20240328-axi-dmac-devm-probe-v3-0-523c0176df70@analog.com>
In-Reply-To: <20240328-axi-dmac-devm-probe-v3-0-523c0176df70@analog.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 stable@kernel.org, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711634330; l=1009;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=m/nVB/GHu63PsHeHmrvMcm3xYLKhYW2M+gPJ1lkwwxc=;
 b=fUST6TEWfOIHe8oSkiiusWOFv1fApQMemIL6ukXrAQcXQsFt82KSWhj6wsbAZ80FBz5XbhuZm
 hZT5QIXkHknBGq6M9zrn/8kz3CCFt2Ett72qdWRdzkcCpoieoGq9kVA
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

We need to first free the IRQ before calling of_dma_controller_free().
Otherwise we could get an interrupt and schedule a tasklet while
removing the DMA controller.

Fixes: 0e3b67b348b8 ("dmaengine: Add support for the Analog Devices AXI-DMAC DMA controller")
Cc: stable@kernel.org
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 4e339c04fc1e..d5a33e4a91b1 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -1134,8 +1134,8 @@ static void axi_dmac_remove(struct platform_device *pdev)
 {
 	struct axi_dmac *dmac = platform_get_drvdata(pdev);
 
-	of_dma_controller_free(pdev->dev.of_node);
 	free_irq(dmac->irq, dmac);
+	of_dma_controller_free(pdev->dev.of_node);
 	tasklet_kill(&dmac->chan.vchan.task);
 	dma_async_device_unregister(&dmac->dma_dev);
 	clk_disable_unprepare(dmac->clk);

-- 
2.44.0



