Return-Path: <dmaengine+bounces-6387-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 549B7B44099
	for <lists+dmaengine@lfdr.de>; Thu,  4 Sep 2025 17:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A26C1670CB
	for <lists+dmaengine@lfdr.de>; Thu,  4 Sep 2025 15:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B681A2367C9;
	Thu,  4 Sep 2025 15:28:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E73B1CEAB2
	for <dmaengine@vger.kernel.org>; Thu,  4 Sep 2025 15:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756999723; cv=none; b=P57Pms5/M3mdvr3x1w1lvr/fgQQL39fOUNGk0BjrT05qAgjtEPrF/yhf9pOwqrBD3xiPNPpADCjFEQ/dMcDgKJG4lISZ63xuDEOARGiaxga7BXtYC2ezzZ6Rc+5BnkiboAkEhvJsa7RiGNiIc1L07f824CI1Rkmw60C8uzzDboE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756999723; c=relaxed/simple;
	bh=qldgwB0kTxg2f+wtbgd+X7evM/wow5zJb7oIkWbgxmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kXwrht/VL+TJozgjGjBf+Np8aLxX2gFp1OrG8oBWorOKfCFanZpPy0WPfYFQL0v1LhkCFAmvWABsaQpKQW/1RBYNCfjvT5ngpvjgq4sApKF6RJHN27dndq09FQhv3Z39nPPq6IS4yyCO/KQrNFrVjOaMHRcLReLnnpcH9SExIog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CC3C4CEF0;
	Thu,  4 Sep 2025 15:28:42 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Vinod Koul <vkoul@kernel.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: dmaengine@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dmaengine: nbpfaxi: Convert to RUNTIME_PM_OPS()
Date: Thu,  4 Sep 2025 17:28:37 +0200
Message-ID: <02d3145b37348bd48e7b63a544ecaaac64b061b0.1756999580.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Renesas Type-AXI NBPF DMA driver from SET_RUNTIME_PM_OPS()
to RUNTIME_PM_OPS(), and pm_ptr().  This lets us drop the check for
CONFIG_PM, and reduces kernel size in case CONFIG_PM is disabled, while
increasing build coverage.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dma/nbpfaxi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
index 765462303de098c0..334425faac00bf8a 100644
--- a/drivers/dma/nbpfaxi.c
+++ b/drivers/dma/nbpfaxi.c
@@ -1500,7 +1500,6 @@ static const struct platform_device_id nbpf_ids[] = {
 };
 MODULE_DEVICE_TABLE(platform, nbpf_ids);
 
-#ifdef CONFIG_PM
 static int nbpf_runtime_suspend(struct device *dev)
 {
 	struct nbpf_device *nbpf = dev_get_drvdata(dev);
@@ -1513,17 +1512,16 @@ static int nbpf_runtime_resume(struct device *dev)
 	struct nbpf_device *nbpf = dev_get_drvdata(dev);
 	return clk_prepare_enable(nbpf->clk);
 }
-#endif
 
 static const struct dev_pm_ops nbpf_pm_ops = {
-	SET_RUNTIME_PM_OPS(nbpf_runtime_suspend, nbpf_runtime_resume, NULL)
+	RUNTIME_PM_OPS(nbpf_runtime_suspend, nbpf_runtime_resume, NULL)
 };
 
 static struct platform_driver nbpf_driver = {
 	.driver = {
 		.name = "dma-nbpf",
 		.of_match_table = nbpf_match,
-		.pm = &nbpf_pm_ops,
+		.pm = pm_ptr(&nbpf_pm_ops),
 	},
 	.id_table = nbpf_ids,
 	.probe = nbpf_probe,
-- 
2.43.0


