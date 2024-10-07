Return-Path: <dmaengine+bounces-3277-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5786D9929D7
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 13:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAF11B24A0E
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 11:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3821C9DC8;
	Mon,  7 Oct 2024 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ZqGrLKZt"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC811D0E26
	for <dmaengine@vger.kernel.org>; Mon,  7 Oct 2024 11:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298947; cv=none; b=oeqzfKop/zj0jzNJadN42WVteib6ISYjR7znkWSa7GN0z7slo5W/DQkvvY3TBqKrtzB+yEVAvKII6uES2uJsMebwGZsQrVJDam3uPSnUXZf2hb1+SOw6UVFQrhm/iFnYG6LNgpPgdECteSpNavZgf9Q/lt5J7ZFF9vJZRAWO65M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298947; c=relaxed/simple;
	bh=tsSefAG1drJ9MherB0rybZ+s6dNlPF6B8TGhA1WjoDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+SfZipC6JKISrsGEUEx1vEfY/9NeXNfzo7PFL6nJ5MuB5kDbyv2S7HLXzlMldYjDWX5g/6LqBoVQvfopf8ATxa0WDPkqwrki56FA2hggQpNWUvJuZICy8oSJ0IFj90/xgfbJCyr+zM0OS5xGXUlUbFLqpNocfPnsTYnubq/B1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ZqGrLKZt; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=92I6PtsU//avEIYhvLLIyKwYwxt7ynmhANlRB9S+qYU=; b=ZqGrLK
	ZtUXKSBJhvUwUo/DpKmxdO7RRdAfqA2qSLgIar8S3btVOCVACSPFvxMNYgA8mxD4
	vWnDPTJBIlnGp9AFjG8Y8eZeljtzots9HDd6evoZ6MTpxAbuT6vUG8nQIoKY/fj9
	0HxNT/RUlKxr11nDViuYv6W3xsO9Cqf+H4j6Yj881KDhlB6FMjFYBNa8Cuk+1xiq
	DI5ZshGXchtO6xghnNDHwWIDwcyU/sxpvrKE1rzd93curGrCXHQlkvBaXOvdYF0J
	8moIA0ge+P4dL/dpS1p7A2O/1vp7sx2t2GYAcD/0p9IU4PBpkY3B+yNNSGB2rIEf
	PY3CGPoDhDho3oOw==
Received: (qmail 100865 invoked from network); 7 Oct 2024 13:02:18 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Oct 2024 13:02:18 +0200
X-UD-Smtp-Session: l3s3148p1@q0xG9OAjxI0gAwDPXxi/APzxl2QXB/xr
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org
Subject: [PATCH v3 3/3] dmaengine: sh: rz-dmac: add r7s72100 support
Date: Mon,  7 Oct 2024 13:02:03 +0200
Message-ID: <20241007110200.43166-8-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241007110200.43166-5-wsa+renesas@sang-engineering.com>
References: <20241007110200.43166-5-wsa+renesas@sang-engineering.com>
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
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


