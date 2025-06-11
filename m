Return-Path: <dmaengine+bounces-5381-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B083AD5BD0
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 18:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9698C17E539
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 16:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83626BFCE;
	Wed, 11 Jun 2025 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fx3M4z3T"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CF9188587
	for <dmaengine@vger.kernel.org>; Wed, 11 Jun 2025 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749658613; cv=none; b=IaPhguqA5Sf0/1ptIm8QFpMI/6VxMxYaDDyVQiI2De3KykaHQ5deniNTvJwR9z/LYupJjHqaHhCk4tKziPDAjs1hm7fnedWUrtj/aMMiH819WDctuFY3ZPVbnsABMwPhPko+iiCZ67wLHcHB0S6+Ur0SBHYo3ee+dQk7ZzengPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749658613; c=relaxed/simple;
	bh=kiMLD24nbhQ2c7z1BH8VGCJ87iZfdGhW+mxk6hvCkcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V5vTUQJeGfpttw2jwsnNuKiJoJ/unb2j6jNybqhUMgYawCsUdlomOojECECcMwV4EQuF3SlLqCH7USGqvzetdtY3fxSBFXMVZS+zfeH87q6gWH+tRRIdCDyNJDuF1aSkDDWdIWiPoYfZ7HlPvrxgN7uKp2Blpu1wEBR/7R4klFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fx3M4z3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F684C4CEF6;
	Wed, 11 Jun 2025 16:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749658613;
	bh=kiMLD24nbhQ2c7z1BH8VGCJ87iZfdGhW+mxk6hvCkcY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Fx3M4z3TZ1zub9ghw0szHUDw7hdIpOVQgFKeUmCpfFvqNo4wMdcovs5jg3X84Vx01
	 m6ACchYSxV8+UrCg4ys4hOSeyg+RLQxQKzxC+BE/J6HQ2c+pHTySJ3YnAlylfdnUPY
	 c9YmrwYwnozhehPFNIBZfS8zSmAMVdbZHnrCI7xG13gsbrlKjR5eOQTlbGzRvIL/V0
	 lyBergRrky9cmrHYg4QZ6Dc/nsYZ9CghUHmCOgiAP+apkOP4J0Pz9gThUJqz2hQgNO
	 Qlgsb5jVks2cs0OesxCn5Klwp342jnw3Vz412eigu5hZChLrAdtJ74QHDlfrcFHXbr
	 UJnhOMJORRYwg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D4BC7113E;
	Wed, 11 Jun 2025 16:16:53 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 11 Jun 2025 17:16:58 +0100
Subject: [PATCH RESEND 4/4] dma: dma-axi-dmac: simplify axi_dmac_parse_dt()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-dev-axi-dmac-fixes-v1-4-d30af52a2af5@analog.com>
References: <20250611-dev-axi-dmac-fixes-v1-0-d30af52a2af5@analog.com>
In-Reply-To: <20250611-dev-axi-dmac-fixes-v1-0-d30af52a2af5@analog.com>
To: dmaengine@vger.kernel.org
Cc: Paul Cercueil <paul@crapouillou.net>, 
 Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749658620; l=1521;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=dIUKoGAAnK7SSnlSFeEcmY/rlMpKq1hPjDfYUQ18lCk=;
 b=z2ZShpxiwI5dwmb0KXv8nPbvPPuTKlxAf7AAj6A7JQOCkfImGrVgg1OvXkwr3T63/5fjIOru2
 EKl3LQQpfIZBfj4m6BXatNQ0ZWjeGLcuWHtqjdHIsUVduv4dHMci42U
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
index 25717a6ea9848b6c591a3ab6adb27c6f21f002b9..035fc703506977ad59fd0b6ee8a8e5858d2c120e 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -7,6 +7,7 @@
  */
 
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
2.49.0



