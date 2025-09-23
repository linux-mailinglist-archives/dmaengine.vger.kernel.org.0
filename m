Return-Path: <dmaengine+bounces-6694-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33871B94F9A
	for <lists+dmaengine@lfdr.de>; Tue, 23 Sep 2025 10:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B50D77A96F6
	for <lists+dmaengine@lfdr.de>; Tue, 23 Sep 2025 08:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82FE3195F5;
	Tue, 23 Sep 2025 08:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezFa9o7j"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E082E11D2
	for <dmaengine@vger.kernel.org>; Tue, 23 Sep 2025 08:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758615788; cv=none; b=NwJaXWe72siS5/LwXbMd38KE4aq++DZjgVmboTnRRZwblDjpdWuM7CWkfGMh33DYxFLASzFlUF5fXfheGmIVQgqYyfYGW3m5fdNHLw3bVwutJe8nEyh8UC4Zi2N0Mhgb4GOscdUBHKyzExtbmGlD46eqlcm5t3VX/rhxQsHsbno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758615788; c=relaxed/simple;
	bh=Ojg302LjjrjyeKM57SZiT2oHotJm5xiKOP4QkJMIGWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BeUzu0s2Ktt3H0v/GZq8KP0bp/HcL0XOgyjrVct4y8h/lq1JEF36H4MxI0+q4px5YEILOWAkH3QkqjdPrZNAHaecIpneEqXbwBRX0MkHErw3LsfEKz0Vs5VHFeCm32zKZ6aVAnE57Kk/7n7MUKzQroKtHjMcv3JiLPgpefaLoo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezFa9o7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D010C19422;
	Tue, 23 Sep 2025 08:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758615788;
	bh=Ojg302LjjrjyeKM57SZiT2oHotJm5xiKOP4QkJMIGWg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ezFa9o7jdbgAgiJlzuT+z6ZTEs9vYDjVX2rcxslvSieQpBMwxNtq9gWqLDVipAbqa
	 ssoPSh3VfWuWJiZUArvJzVc8eYRYSlQg0XYfjModKAeKUK9a4Wv2QuFZMvqq8ijPTg
	 uE+0cpUlECY+jm5KPrUOYJPsAo9yh/YIaQAS0oGf/MBkORKkjR6z3F7ByO33JeSqHV
	 yHXG/+HwFp3798d8YgCZcElgRdjGTHMYE19EA7JPJEyQOBCu0qepqJCfnj+guKoONz
	 efN0VkRHMH/gw38/41gqe66wJmYq4+RqtKFg/imuW4n0mj10px6wLdDrICUM/65wQd
	 p7H+k3sFh4h/Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A0CCAC5B1;
	Tue, 23 Sep 2025 08:23:08 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 23 Sep 2025 09:23:38 +0100
Subject: [PATCH RESEND 4/4] dma: dma-axi-dmac: simplify axi_dmac_parse_dt()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250923-b4-dev-axi-dmac-fixes-v1-4-5896dcbbd909@analog.com>
References: <20250923-b4-dev-axi-dmac-fixes-v1-0-5896dcbbd909@analog.com>
In-Reply-To: <20250923-b4-dev-axi-dmac-fixes-v1-0-5896dcbbd909@analog.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Paul Cercueil <paul@crapouillou.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758615815; l=1551;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=hayjasLpAzSq1oaB+SvL2m79XKZRO2+rkHfQN8vJhbc=;
 b=4KiTy5skybaGEWX43S32z18MNp+wOpIqF8trWBBVvNISWPM/6Wmn9Ss5A905dkNh8NwUHkBq3
 vbfn/tfC2DODkzmEwIBLejLwtpMSN36gQ8cbhRlzMVqCaFkM29dIJ30
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Simplify axi_dmac_parse_dt() by using the cleanup device_node class for
automatically releasing the of_node reference when going out of scope.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 15c569449a28493bd00e9b320ed83aa2a13144e2..045e9b9a90df562073c078835584a23f26d47350 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -8,6 +8,7 @@
 
 #include <linux/adi-axi-common.h>
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
@@ -927,22 +928,18 @@ static int axi_dmac_parse_chan_dt(struct device_node *of_chan,
 
 static int axi_dmac_parse_dt(struct device *dev, struct axi_dmac *dmac)
 {
-	struct device_node *of_channels, *of_chan;
 	int ret;
 
-	of_channels = of_get_child_by_name(dev->of_node, "adi,channels");
+	struct device_node *of_channels __free(device_node) = of_get_child_by_name(dev->of_node,
+										   "adi,channels");
 	if (of_channels == NULL)
 		return -ENODEV;
 
-	for_each_child_of_node(of_channels, of_chan) {
+	for_each_child_of_node_scoped(of_channels, of_chan) {
 		ret = axi_dmac_parse_chan_dt(of_chan, &dmac->chan);
-		if (ret) {
-			of_node_put(of_chan);
-			of_node_put(of_channels);
+		if (ret)
 			return -EINVAL;
-		}
 	}
-	of_node_put(of_channels);
 
 	return 0;
 }

-- 
2.51.0



