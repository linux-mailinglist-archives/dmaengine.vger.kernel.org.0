Return-Path: <dmaengine+bounces-3253-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE0098BC78
	for <lists+dmaengine@lfdr.de>; Tue,  1 Oct 2024 14:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3993B23EB8
	for <lists+dmaengine@lfdr.de>; Tue,  1 Oct 2024 12:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DD51C32EE;
	Tue,  1 Oct 2024 12:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="R1y1Z7ag"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E821C32E8
	for <dmaengine@vger.kernel.org>; Tue,  1 Oct 2024 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727786608; cv=none; b=X39MUfJz4Ic6sA1jeJ8g87OXy/uaTL3xEtgKFPDh/gVDLZ9wVjZYUtL/GMR3mMhWWIXihixRaQP48oXx0oIjOoHMSOQGgwHoFVvWvoV0tmkaLDt7VRTi9v7TGSLf8IDyMCQukSdDWh59QWDnDbLxBSZ5LNAxmuGIM6j259oq5Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727786608; c=relaxed/simple;
	bh=l2t1dqk+r23+R9nbRYF7KoGiQg78YPEB9rKlGp2Gc7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3R9GRMjj/qG2tg0+zRAVp2pjh+J3i1z6kBCZJH5Al3oR1ik6yUAOrnPPwYkL0JBaEaSzUG2G3h/NHhAKMaNFLVZpl0R3ZIkNI/KUYHhTGiWqCrIz2GrNV/zTdgi8ToZjeRaNR9Adx69n93xuMByGk2e/hpTsJ+27cqu1LAxR3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=R1y1Z7ag; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=K9wz5JtX7GBLWOESuR7JRupPXPlzqUViFNdyqc0HSR8=; b=R1y1Z7
	agldavc2hi4mg7ZG3v7C2jqi6YAnaAT96cl7s+wwVhd3mis6spdMZ6nk3t+wAFHO
	7kLcayoolLgWo9BTBxehyOzIXDcusrtUVUvy8fQj1bHma83RdZtV46oS6GT23SkI
	6YE5Fh8GzYF+MwzKnnUgblJ/T1Z8EQfDu2JOq/GVu6UZsGoV9+8A84eYovCOfKwU
	Dydj79iRwiV608y2i5vnTUVkfYN0eRfejr5VmCbPgeUhJYGqnryLe1yLOj8a8HX4
	SLNErM+YO4SfTD7PB0hwSFJWlfejSdWZmBfRKK7CY/MU9D9yFaGt4MBCcJ/AZE2Y
	neyY/bHVvbNxIPFQ==
Received: (qmail 2523696 invoked from network); 1 Oct 2024 14:43:15 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Oct 2024 14:43:15 +0200
X-UD-Smtp-Session: l3s3148p1@4DtEqmkjwtoujnuV
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org
Subject: [PATCH v2 3/3] dmaengine: sh: rz-dmac: add r7s72100 support
Date: Tue,  1 Oct 2024 14:43:09 +0200
Message-ID: <20241001124310.2336-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001124310.2336-1-wsa+renesas@sang-engineering.com>
References: <20241001124310.2336-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This SoC needs to make getting resets optional. Descriptions are
reworded to be more generic.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/dma/sh/Kconfig   | 8 ++++----
 drivers/dma/sh/rz-dmac.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
index c0b2997ab7fd..6ea5a880b433 100644
--- a/drivers/dma/sh/Kconfig
+++ b/drivers/dma/sh/Kconfig
@@ -49,10 +49,10 @@ config RENESAS_USB_DMAC
 	  SoCs.
 
 config RZ_DMAC
-	tristate "Renesas RZ/{G2L,V2L} DMA Controller"
-	depends on ARCH_RZG2L || COMPILE_TEST
+	tristate "Renesas RZ DMA Controller"
+	depends on ARCH_R7S72100 || ARCH_RZG2L || COMPILE_TEST
 	select RENESAS_DMA
 	select DMA_VIRTUAL_CHANNELS
 	help
-	  This driver supports the general purpose DMA controller found in the
-	  Renesas RZ/{G2L,V2L} SoC variants.
+	  This driver supports the general purpose DMA controller typically
+	  found in the Renesas RZ SoC variants.
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


