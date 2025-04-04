Return-Path: <dmaengine+bounces-4827-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26957A7BC94
	for <lists+dmaengine@lfdr.de>; Fri,  4 Apr 2025 14:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EC9E189F8BF
	for <lists+dmaengine@lfdr.de>; Fri,  4 Apr 2025 12:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBA41EBA1C;
	Fri,  4 Apr 2025 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s1bbu8Gr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40F91DACA1
	for <dmaengine@vger.kernel.org>; Fri,  4 Apr 2025 12:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743769283; cv=none; b=Yqt+HK8JRFZMOsU9QPw1ZLac/fv7+lSZh+aztMKbL6xzL2/nk4fmLxF7DiEuCqnXYXSZGoZfUCCkcPnhOVaIoL2ErFrYEJ+wy55c++FXaHMq47CBPJ9zXczS5mezdJWtK/w3N9YBgYBpJ0AEVXUGeeeQzz85zM7LjdgRHLo8l2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743769283; c=relaxed/simple;
	bh=lkeUwkkv2l20qMI8/MMYwTQQP/7YT3AVpqsQN2tYwNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDMyssVGAeSrWTcp4wtltgqCPPDloQqGP0DgKJeoA9fHbHH36JeCSf5ZqrMSvUtdxOTLyLCc+z7uASjQ62DW4r8/waeus6MmyQd9LQc/YraKy9MgytvqR8xCuuvrAZ6JMIxGoqYN/W7eeC+9kuo2v7K7sx1xbm+wH/0NunbTufA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s1bbu8Gr; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3912b75c0f2so187179f8f.0
        for <dmaengine@vger.kernel.org>; Fri, 04 Apr 2025 05:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743769279; x=1744374079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Tb6uHTtWsK1kFyxyPD5qpzEiabvnAv7+kW+ub5TJjs=;
        b=s1bbu8GrTqMbP6pXVoITX0SE5usnyyZZqM2eFufdpnq07uJ4hYCTgR+90Cugr5Cx9R
         mzGf6VfNvka39JV6KQYzGdJyvrulq3ZGPrOXS9EGkPuiA7I8v8klnMBbYI2GkjUcNyqI
         x3wD+08/v0ccKjxyl+MSHN45SA64NJoBy8bYQaMq++pXVl3dK+4ubjeyy8BfqCr7AoID
         zQmzIsbJmE83RbYQxEN8pWXbUpDWfcmN5KAiMxL+ZOyL5xyczhCJtzaM32ym9V/dpMt1
         OK+Pom4Huq6eQ7jIVJNO/3LqbRpRXqH29lb5ay9/kNkpU89ftS101ciGCFF2IP8UKvdI
         BpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743769279; x=1744374079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Tb6uHTtWsK1kFyxyPD5qpzEiabvnAv7+kW+ub5TJjs=;
        b=pl3IoPzCOBEd+fATi5TtGjzkdVbQFKis2TH+OHpL3f8kti0XzzafqV56T2wfEAIFie
         wg4PNz/FcsKCUPxhU2+E4/Uz8Z3g97HfqfSCC62WasBcifxokGnB25CBqaTGwPxj/0dt
         iOvPiCnjXedh+p0cv//eVDMzGtlF1tP9ZJt1acFPHu0qlUwnRsDh3DS5FDeaDFndLMCD
         1Cud9oUjXm6MQzvO/tpMiXOds1+7bWRZ/gEji3gGF8TfDEsAkjV44ZCuMv7ngi6u86T0
         ebasGNNQkMBTEheAlYZ5DLu2iDlnPzCjHFLW9TCZP26E0z7+7oNi9nNR2FKs7FDUjBmT
         az/w==
X-Forwarded-Encrypted: i=1; AJvYcCW5nd++56ZV5fraApRhxseKGgrtChSUbEuK1RS56ESUFhfqlDly0pDlU0uR/cX/77EJLMebg7di4pY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Je5ypZO40O0z13LTniFoWD40QcMEw/tUYZtmU5Yo53/WZlrX
	A5XXZGO4fEJPyusLlpGXCEyOJlu/AelEK1uyMv1mgUs/yV9EMI2iJIQXtLT9wUY=
X-Gm-Gg: ASbGncucQR91hOXeqThIDdzoZxpG9KE5bftXemfdXbFfYAP3n2L3/dIzUuQ6VySSn8M
	7OJq/SVUO1eofDZBNBMxw+6qUFZVgtRnOE6AUKH8R9Nx/8hZ/TUH5GR7zo0/0V3KvXvew5nSMtv
	59quK9hqtU+78GXc4WtYUShhM4W19kXDYdHHjkohi33tix4TbUuf89WTYhPDPAf+oL1NbDNiuRZ
	inWKn0ELhGmwjLQhkcQ8Dkfnmet32y+qVBpmwA2mnL292TwiGhjuWNOsMBlg0idhU7jURIlFcOb
	KQgL1MmEeHF9DVO8aIe5P/PuwZx54R2VQ7r2Ks8mtrGNg12XXmUAIw==
X-Google-Smtp-Source: AGHT+IGOy3L1QjCpnMqGZsFw79UEPXtqI6aUxy7enKUtc7JINUL+ImbH8sjMP1fP+pTjtUkMn+AvpA==
X-Received: by 2002:a5d:6da2:0:b0:39c:1258:b36 with SMTP id ffacd0b85a97d-39cba93d1c8mr1014525f8f.14.1743769278978;
        Fri, 04 Apr 2025 05:21:18 -0700 (PDT)
Received: from shite.. ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a6c89sm4183439f8f.28.2025.04.04.05.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 05:21:18 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Vinod Koul <vkoul@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] dmaengine: ti: Do not enable by default during compile testing
Date: Fri,  4 Apr 2025 14:21:14 +0200
Message-ID: <20250404122114.359087-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250404122114.359087-1-krzysztof.kozlowski@linaro.org>
References: <20250404122114.359087-1-krzysztof.kozlowski@linaro.org>
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
 drivers/dma/ti/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/Kconfig b/drivers/dma/ti/Kconfig
index 2adc2cca10e9..dbf168146d35 100644
--- a/drivers/dma/ti/Kconfig
+++ b/drivers/dma/ti/Kconfig
@@ -17,7 +17,7 @@ config TI_EDMA
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	select TI_DMA_CROSSBAR if (ARCH_OMAP || COMPILE_TEST)
-	default y
+	default ARCH_DAVINCI || ARCH_OMAP || ARCH_KEYSTONE
 	help
 	  Enable support for the TI EDMA (Enhanced DMA) controller. This DMA
 	  engine is found on TI DaVinci, AM33xx, AM43xx, DRA7xx and Keystone 2
@@ -29,7 +29,7 @@ config DMA_OMAP
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	select TI_DMA_CROSSBAR if (SOC_DRA7XX || COMPILE_TEST)
-	default y
+	default ARCH_OMAP
 	help
 	  Enable support for the TI sDMA (System DMA or DMA4) controller. This
 	  DMA engine is found on OMAP and DRA7xx parts.
-- 
2.45.2


