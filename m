Return-Path: <dmaengine+bounces-4828-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB2CA7BC95
	for <lists+dmaengine@lfdr.de>; Fri,  4 Apr 2025 14:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AAF8189FACD
	for <lists+dmaengine@lfdr.de>; Fri,  4 Apr 2025 12:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A841EFF90;
	Fri,  4 Apr 2025 12:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W2e7IiXC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FBA1E51EC
	for <dmaengine@vger.kernel.org>; Fri,  4 Apr 2025 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743769285; cv=none; b=e0pGY90U+NqKqYkuxPXN/kGk4F8jGZSEg8Tlj6uZp4xDv8KwjCFzpIz69a6UBCX/yFd0elK9VFzYgHZkKc8PCeyqZu7swrP1c3OSuCX1cnSo5oiGjKC5bco/qPgDgaHT8nsPH8OeOWz8weKXfv2R2gOC1Y++IM2ZMpQK7+s2MlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743769285; c=relaxed/simple;
	bh=5PptzN+O4dMipDdNH3CCDo5Nu5+4qV4mMTDC3UC7oNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SZhivuHUkSO29q9SyvS3Uo8EsdRpHWAyCJbomltmToIbyyB1Rfvgv8BgrMtl4tu3MRx9jOqc4e4RaVxLSTvSEUzO0Rkf++XjQix8kpcz0IQwc0LaNR9zfuNRjm0gQCzdtX8v6iKVYWuwTEkLqrDkSvVyBJOu/9qGcIJKX7rGNQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W2e7IiXC; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-391295490c8so163445f8f.3
        for <dmaengine@vger.kernel.org>; Fri, 04 Apr 2025 05:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743769278; x=1744374078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QOKOdMC80B9ZgR2kKa4A3uKCR6IYOVE6PeV1L1gst64=;
        b=W2e7IiXCk48RdXCPDtShLWS9Lf+jB37Qhe7ivmR7tIJIU0NqUT80iUkAy8KFS+ojId
         f0A8csIP3zxAoQkt4oJYnxjWlN+930bY9bDapqlgPPWAWqTMPbS9cnu2A6eZlGuOJ48g
         0hfoEEBSdZ9qjGRNsh3gIsimb/G1ycQbpFS5l+72y/bmHwjJG1A43I8FIBH82ilaQoda
         +pFOG+fzmK8/ZjEUE3Rxl8lfVDSYz3/aq21ryQG5vPrfBSLtf3JDQzl+mDUC/5qieTQj
         KlLLsdTbuqQJtN/lN+e+Q5IqmyIHN9aqJGk5yzwzrTrSI1euIAj7MgpraTvbuJQqzkXz
         nTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743769278; x=1744374078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QOKOdMC80B9ZgR2kKa4A3uKCR6IYOVE6PeV1L1gst64=;
        b=u2JlokvVPIxzccxD26RsnV+d18eCy0hUldYDgvnCwcm3YjLA1ks9VO0GpDq6KxKKb6
         0JuRplI8NVv9r6GTyU2gcYg/16iXO/U3AMIJr7g5xTzSW3hbNjw/kW3IzH7hlWGB1oJI
         72VAIcXGUQj1/FNxFpZQToQCOTrfPp0I6SfeqSWN9IxwxzEcw+smt5E2ayMVwTKCB6cr
         yWx6bQAT1OCTvItlFqqVmeT+TOXF3nF9nMSc+pnHFs2Wdr9mvTNfO30UOLWYeijISy7s
         YSjPWvuwAFFnyRgVgInJjBHucf+KpeoS08GwErUhS0OSZNDRADLfwjTOUoDoK7kRN3Mg
         NSuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSDhTuk+7stgl+7nEqdoyqxMwIpsHZeQpo0tiSf0IjlicxiinLIe7r3uBhNE2ZP9QTgMivugul9UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3+3+YlYBdxdnNWK+9M55fT9jzVHDqEZwOvcoNUxhsXle2XXLp
	prvIFbIG6Y3xZ01jITVEBF5X0DYU9v/n8WEHPGmmUX79VmRhyyp9AZDllMda43g=
X-Gm-Gg: ASbGncviSlkpg4Aj7lcvAdUldv2GSoF9CqUTzYW22mWIsdTPE+ATmhRjeOOVj0sXdie
	cwXAR1G8YCQpfWsHd2To3e5dSlUwAnRqAJ4xrr2XlBSm0QZ+6c81A/PxRdnbD6jmysNcvUCnWPE
	GDyR12Lvwg6bNdpVySelhrmvJf95mdpiK2aE5Ijd89uDwsYXnFlsD9Bc+mpyDd1G4j5fKUymFkN
	ghALUp4gVKLSnGC/C20mxt0NyvElG+tP0H8Qaxip9OppqQOLAW1D0hbgTHtszbC9SEGQebskyAg
	72TrisYYhIgLHxVAAeiSLpNcQkI8t7q9VIKe7e8iijcxozyM7vmtpg==
X-Google-Smtp-Source: AGHT+IFK5JnOLqYkjMnRXzO913j6er0HGEDwkEB73eYTE/X5Rh0zki0MaFEoC1XvaQYeqZ2DlmoXNQ==
X-Received: by 2002:a05:6000:40c8:b0:39c:1efb:ee87 with SMTP id ffacd0b85a97d-39cba934e63mr852165f8f.12.1743769277821;
        Fri, 04 Apr 2025 05:21:17 -0700 (PDT)
Received: from shite.. ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a6c89sm4183439f8f.28.2025.04.04.05.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 05:21:17 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Vinod Koul <vkoul@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dmaengine: sh: Do not enable SH_DMAE_BASE by default during compile testing
Date: Fri,  4 Apr 2025 14:21:13 +0200
Message-ID: <20250404122114.359087-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling the compile test should not cause automatic enabling of all
drivers.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/dma/sh/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
index 6ea5a880b433..8184d475a49a 100644
--- a/drivers/dma/sh/Kconfig
+++ b/drivers/dma/sh/Kconfig
@@ -16,7 +16,7 @@ config SH_DMAE_BASE
 	depends on SUPERH || COMPILE_TEST
 	depends on !SUPERH || SH_DMA
 	depends on !SH_DMA_API
-	default y
+	default SUPERH || SH_DMA
 	select RENESAS_DMA
 	help
 	  Enable support for the Renesas SuperH DMA controllers.
-- 
2.45.2


