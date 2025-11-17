Return-Path: <dmaengine+bounces-7229-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43503C651DF
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 17:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86CE54EF4D7
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 16:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFD32C3252;
	Mon, 17 Nov 2025 16:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1oxMhyd"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A442C235D;
	Mon, 17 Nov 2025 16:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396226; cv=none; b=M3F0ttwNBFpCehkPtwv9+CKaVF5jIEmbXKSVW6v8EpKoQyoVmrPZQAQFZTC6ce9IC3OyGsYfXAnsgsihFm8X45Ge2Poi2bDaOsml2SkX7hsrZ4mbfrGg57Q5jBvQSNHO+1OyjudUpxRW9kL2LNsZ5umhVXCsi3hh+qhp9G+22MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396226; c=relaxed/simple;
	bh=90DD1DsVZU0teMigiz/m/TS1fobnR8VtucNw1BrMhU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llUjYpH4vXBg31nELlYlKdglJFVD9gs2nX0CpTGLT+xIdKNSrbeMABDaMywjFO3L8qX4BrfyNs5nkEy9E6TEwXBc1EyrnPrgO3GE8//fKB+5YljE13C+w6XMErGw8Jo8BJN/W17S2Br488t7/xu/tWQk1ktcNZB5IElfvEtjTys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1oxMhyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47701C19424;
	Mon, 17 Nov 2025 16:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763396226;
	bh=90DD1DsVZU0teMigiz/m/TS1fobnR8VtucNw1BrMhU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p1oxMhydaNsRf2s814oO9gR98M7ObuU5ar57TbyM7aXZiOJbgVQxu541gyC9SWlWR
	 SYfV0G8ze/40MyhnIKeeMDHZ6TD7tHrakZLw2U8DegrivTtMm3sp5CTt/FexyodjWh
	 2vu8ve3Xpj7GLBHeo5lz1neFtdNuJ2nj6qG5IwPHlYgv+JAG1QGP/Y+PLnEFWBpl/l
	 wuZBN9pCHlqZHf/JEOgye+qiRfpBu5erkmo/zfOqbfB9lFFOxHudlmUWhZpXhQKFAk
	 7l3f3a4NlLylDw1H+wnHtfLP4ccKKfpXh1vouLyz3zfVCCEqCGItjonMt/ZlS2uw4N
	 hRaSIDK6GMC/Q==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vL1ua-000000002tH-1IK5;
	Mon, 17 Nov 2025 17:17:04 +0100
From: Johan Hovold <johan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] dmaengine: at_hdmac: enable compile testing
Date: Mon, 17 Nov 2025 17:16:57 +0100
Message-ID: <20251117161657.11083-3-johan@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117161657.11083-1-johan@kernel.org>
References: <20251117161657.11083-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There seems to be nothing preventing the driver from being compile
tested so enable that for wider build coverage.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index cb01e01a054a..115e7f2a9988 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -102,7 +102,7 @@ config ARM_DMA350
 
 config AT_HDMAC
 	tristate "Atmel AHB DMA support"
-	depends on ARCH_AT91
+	depends on ARCH_AT91 || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.51.0


