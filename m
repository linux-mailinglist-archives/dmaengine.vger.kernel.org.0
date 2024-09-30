Return-Path: <dmaengine+bounces-3239-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC5398A80B
	for <lists+dmaengine@lfdr.de>; Mon, 30 Sep 2024 17:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B064E1C233D6
	for <lists+dmaengine@lfdr.de>; Mon, 30 Sep 2024 15:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426BF126C07;
	Mon, 30 Sep 2024 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="DgyRxzxK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F3019259E
	for <dmaengine@vger.kernel.org>; Mon, 30 Sep 2024 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727708405; cv=none; b=R2Wo7T4SAVH22qU01aSgXHHXDzv7MolvtT3EFRcmQCD531qwPLETIwFzJmY3Tt4v3lajSOGgg3xa34RwAi5aq3oAa4cuZALagO1r6efVcGT9bhoHOWvDRmKpuUzNubFOyNjyyvkmuiEzTUSRa4SIEzdXtpOCBQ6r+AC3ltPYBWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727708405; c=relaxed/simple;
	bh=uDkerb6KGipRUZ7UYAb411KLuQ1UEZb6wnjIEHvrh/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VkMyxdJHi8TRGwtanqjc6jtSqCiDhzcxak9YBVigE5lYbeRT+VG9atuC4vNjoIz0PoPQJ2oQGg8B/uq7v1V5KT99Bb4pIKBn2E/Jp564EX8crBaTNkaICi4tq1HElWklAG0+cMPxZo+Dm9K10JVLKuKMC6n/mqmw82IpV5wI068=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=DgyRxzxK; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=Curcrtbkv6miXmdKoCuAek1GcGgbfQ6RkuxTtIFbBwc=; b=DgyRxz
	xKLL5NJZJYLV8YCRd8PJJ0+gWqa0dol1ytrvBGR0QxrgZhCMW6S9Q598WEq0f71Y
	0utpiYu9/ryKLJG+J05x5Tn8nt4Thn3+Xd7i3P40OvzuDVy7sma4mEj0zN77wYg6
	ImbOLr2wZsPvseYSWnDvX7BjeD7giR1PdzdA2E7ewuxSoLVcGYi9VbmZN4ij4xAV
	02QkQkTec9PiFaBwxVpJiioTHMdAeLNYifpb3EhKCP3pCg5megfBvIRUMjP1rYWI
	x5yEYZO5KrhytbJ8LAJStmOZwdwavXRdAyYuSO901jMVPA+RsB44a5q27YPL+Kvg
	TjSg/sdlCKDc8G6g==
Received: (qmail 2222706 invoked from network); 30 Sep 2024 16:59:59 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Sep 2024 16:59:59 +0200
X-UD-Smtp-Session: l3s3148p1@qvFmdVcj6uYujnsJ
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Vinod Koul <vkoul@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	dmaengine@vger.kernel.org
Subject: [PATCH 3/3] dmaengine: sh: rz-dmac: add r7s72100 support
Date: Mon, 30 Sep 2024 16:59:54 +0200
Message-ID: <20240930145955.4248-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930145955.4248-1-wsa+renesas@sang-engineering.com>
References: <20240930145955.4248-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update descriptions and make getting resets optional.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/dma/sh/Kconfig   | 6 +++---
 drivers/dma/sh/rz-dmac.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
index c0b2997ab7fd..2b2e8ca257f5 100644
--- a/drivers/dma/sh/Kconfig
+++ b/drivers/dma/sh/Kconfig
@@ -49,10 +49,10 @@ config RENESAS_USB_DMAC
 	  SoCs.
 
 config RZ_DMAC
-	tristate "Renesas RZ/{G2L,V2L} DMA Controller"
-	depends on ARCH_RZG2L || COMPILE_TEST
+	tristate "Renesas RZ/{A1,G2L,V2L} DMA Controller"
+	depends on ARCH_R7S72100 || ARCH_RZG2L || COMPILE_TEST
 	select RENESAS_DMA
 	select DMA_VIRTUAL_CHANNELS
 	help
 	  This driver supports the general purpose DMA controller found in the
-	  Renesas RZ/{G2L,V2L} SoC variants.
+	  Renesas RZ/{A1,G2L,V2L} SoC variants.
diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 811389fc9cb8..03f3f99f0f4a 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -893,7 +893,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	/* Initialize the channels. */
 	INIT_LIST_HEAD(&dmac->engine.channels);
 
-	dmac->rstc = devm_reset_control_array_get_exclusive(&pdev->dev);
+	dmac->rstc = devm_reset_control_array_get_optional_exclusive(&pdev->dev);
 	if (IS_ERR(dmac->rstc))
 		return dev_err_probe(&pdev->dev, PTR_ERR(dmac->rstc),
 				     "failed to get resets\n");
-- 
2.45.2


