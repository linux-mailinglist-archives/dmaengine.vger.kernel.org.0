Return-Path: <dmaengine+bounces-4111-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB281A104B9
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jan 2025 11:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7541D7A2EF0
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jan 2025 10:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07D428EC81;
	Tue, 14 Jan 2025 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fNJFTcWA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071B522DC3A
	for <dmaengine@vger.kernel.org>; Tue, 14 Jan 2025 10:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736852148; cv=none; b=WZTR3DFgNUly1a2949dI2hhw9v849dzlb/FworuXuaNWw49SmSSbYI+qWWP98Hj20EZmibb/DczRn5RiCusts8YFxLqOqcU+Lz6PvYLz5St7PjaJn/HhbU2ES52tFTUy6biKoc/FU3eXQaxaZQOq6FJfkerNCelu04ZwyVfq2oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736852148; c=relaxed/simple;
	bh=aSeZfaDwSFJIY4/vsKGZDV/+UPdIWOSQQL1Wnz64dx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbmFhg/LigQB32ntCY/BNvNl48Zai8Nw1OIiv54lN2TGnvQaVLtEOpgvIRw8F80kbFwXM6Ji/HNFfuqt95l/Cnn5KfN53nHq3SZhwvXKcLHMsrrA/g3IcJSBgTf8HhhGOqbpvuSX2R2xD4otDXKPwUha308j2BCNc58QeO802lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fNJFTcWA; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa6965ad2a5so76535766b.3
        for <dmaengine@vger.kernel.org>; Tue, 14 Jan 2025 02:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736852144; x=1737456944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3rqPuNp/XAiHwmx1Pu2LDapqHlVBx3ScWZfxCOYmYA=;
        b=fNJFTcWAWry1xuKMZLheBZCJCm+T8kpQwTQ0hfSUFiw3tTKHGq5pFnIAS018JQx9uw
         0jR1rVCHdeSRCtCV+3oOtaXEt4eEF5NVYPuYwOtvsr9HHOhBqu7l6Q4s3D7rF8HoPJeu
         Kyw+l1y/lPiS/hKGxK4KvZWgSC+uOmXnw0A5Ktv+4Ma4i2EnWdcXN9ShugzQHxvsu+SE
         YutjoqIGHTOdesbCRPvWHir2pFt7TNr8Xep2BlCtLK6HrsyIQtHkpyU3cVawWsVBjFfY
         i1NDagrVpnWYJD5Py5pJN4ElOJ2WQNIMrBfskVf+VbtZjDeqJU+7DP48h/LZyIFei+x5
         SntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736852144; x=1737456944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3rqPuNp/XAiHwmx1Pu2LDapqHlVBx3ScWZfxCOYmYA=;
        b=ugP4lr/q+K3hEdfOy6xdkVs5UhGdVd9s/IwbUeKTD8hT5zSlXFklGckwnnjCwVPVgh
         bOKX41q6YR5v85EAaem+q2D0BRZKv/uGH8EuI4bwzAYP0VRORzuidJLSUsJspOWxhrVI
         nT91mq91E8TzP6WBvKMt7w89N2GSumVA4jL95yhy3CQaYgW5qjA6Xh3WGjyI6niB7/+u
         PwAigxG9dY4ZsFLKhI2zPBQFfALOJTj8dOrNQdlEFqltNJ/aWI157LuZmpxfxjxh1993
         EePRRszFsoxH7KV2qFjvuhm9I0kteA7VTaAEf2YNRmOfoZXNOhJNeRpObE3WZk7tLLco
         zljQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYizePjhHfilXPQdZJpuRFaqduHqmxKj0qFj+eaS6QkX/+ZjzX3n3E5EKyQifNqW1TYtUdShw/NyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSuvduSTb7LSxkuux1djkCn+j4CEqpClddoAzA+LSzlIJvv9zE
	B5CKlFeAcvdlBRmhaxC7CtlJ89r/VP0xUmu+4JMeq/+ig0UqB4+o/b2BC42cb+M=
X-Gm-Gg: ASbGnctuC94ASl39Lh+sR7xf7w4dPZnUfxQI436wcvk6OWFc66M5p6y156Ku9yxI4Wa
	RLGV8C5AaKt7apC3sm4tJjrR4weHdraiT+ojilN0Ta1DNbvlKdAo8dd0koBrT6zgsvOpGyB5GK2
	6WJQdTLZlweZyKxjNBT7o28KkeDf4C/CkTnsYErg1zezgoGZ6odF1H8BiQspxS3n79bNNgMitxo
	AltCvLnY9xRMFkevgxJGIxUooO4Rujq0lpQLja8b2ffK+4toJK27rBFOR8W8Z/xp/Es77U=
X-Google-Smtp-Source: AGHT+IGGLNOo3Y6rZ9xm8aucjHmK0akRyTENMu3IpG6BrZjgAqoEyoZP/GxppQhWGAt606k5yDTcpQ==
X-Received: by 2002:a17:907:2d8f:b0:aa6:6386:44de with SMTP id a640c23a62f3a-ab2ab73b693mr726196966b.8.1736852144389;
        Tue, 14 Jan 2025 02:55:44 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95624e8sm611169266b.127.2025.01.14.02.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 02:55:43 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Vinod Koul <vkoul@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] dmaengine: pxa: Enavle compile test
Date: Tue, 14 Jan 2025 11:55:38 +0100
Message-ID: <20250114105538.272963-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250114105538.272963-1-krzysztof.kozlowski@linaro.org>
References: <20250114105538.272963-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PXA_DMA driver does not include any asm/mach headers, so it can be
compile tested for build coverage.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 8afea2e23360..cd856c990d17 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -546,7 +546,7 @@ config PL330_DMA
 
 config PXA_DMA
 	bool "PXA DMA support"
-	depends on (ARCH_MMP || ARCH_PXA)
+	depends on (ARCH_MMP || ARCH_PXA) || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.43.0


