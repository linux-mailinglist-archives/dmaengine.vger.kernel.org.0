Return-Path: <dmaengine+bounces-1530-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A9388CE9D
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 21:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 534D7327D91
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 20:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D2813FD82;
	Tue, 26 Mar 2024 20:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y+7VMJav"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128F713F448
	for <dmaengine@vger.kernel.org>; Tue, 26 Mar 2024 20:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484668; cv=none; b=Accu0tkSAZz87cVWOJF451Ww1rz4mx9pB3Dk2tE+Vs5MNIbTTE/HvjW7836LrZo4oohttqbHZSMiGgYAbNFEVurwM3p0dA3LZOgEOa/TgGpw5v8d/6yW7LuqaX8XqQYCTGv8kfLPIteGHUeNWwp6NINSh/A9xFzNhcnJ1DMjeW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484668; c=relaxed/simple;
	bh=WaOdPxQDLRUP1i4wGsr9OiyCK6VXAW85SV74ALGfvjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B3+xt+dlVVTpb96ZvZ7AiETXGr945YsGE+VvVkvy1RejT4zXg7zWVjJ8yNAqkOGB/G1Qz5GWPblfmoU3rRQCXkrYzKu3dDRcrbLYgEXqJvCuaSFToPRLdbdF81cz60+GrTPLwin+vWeoafuPX/EGYA6VQRYvkryzTSlWoVZ7puE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y+7VMJav; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a4715991c32so724299366b.1
        for <dmaengine@vger.kernel.org>; Tue, 26 Mar 2024 13:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711484664; x=1712089464; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0+KofsDX7b8B7he35yQ05XHUdu1qHb7C3AOSdJZ0YF4=;
        b=Y+7VMJavFCDbWDyhXvQQPsmH+Xtzuw1zONvgfCcupI05Xv5SbXLYcHfbw41MGdyRe8
         ozg1K5Cy5AR9scqcv6RQ5FUcvRhs/JU9VGKNpAOasJUfNm3frjYKcKPnG0yGBFo2YbEz
         /GnRI0peHLgV7BGjjXPBR6/ktZLHswBZkqvqwe4rSsOxGS0TB8Eu7e4ke4osYunSCXR2
         9EfxCMMK2SHc2HKNsFUdqiaWu0vwqcB2qIKpiOxuPO65tyMwVZYkSzo5YK//VgvqsWVY
         zP9B/TDzuaMa3/5CkBKJWkfNUS9IfyVMgjiNBEwZlcDTtgxSTrxLA7u47lVEiUrrjsud
         ngBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711484664; x=1712089464;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+KofsDX7b8B7he35yQ05XHUdu1qHb7C3AOSdJZ0YF4=;
        b=A6ouqAmevmq3782v0SeUbDQKC+f1oMx1JMT5v0HZ6qMiFrWdZyVvOP+ZO7bLQxiDgH
         miu3oW5Gpblf3PW7rdj8qHXctk7rUc5MbkqGHyMQPIiT+5PppXuhJcuRxAYqIHwFByrl
         sQctPNmgBMHT0yI0KnIuhpqs2NhuBBCSSkIheG/JcdRvCYXP5SfC2IAzCeatNEwS1w6o
         PZLAL9dCHXlEq1To+k6YOXBjwd5MavY8ZCSM7dhfA2kojzDqZTOCce6gsIem5jwnGGXu
         L0X+oP99olBtlwooUb/M0HCLyTKs3GHOVRnqRWq1LGYR5942rvbo2MmmNeQ0BBoD1hNF
         MWeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyPL96JQxHHixtV3kNiDF2URe8STYptYCQIAtew6u+1czK4TSoil5lK0TZJNcENweiypDtJbvhuN6tHBSOohP0g76cxDqdj+xK
X-Gm-Message-State: AOJu0YyIEJ6uAuf6sIxtrb9kIPw9Bg3CzkPPWCk0BAlIyCgpjseFEqQK
	3rBtk1u+jgdxTU5LGqAPAqoM/dhlHlmAnOOY+kf1jlKF9sGTQasIbArP8MhqV98=
X-Google-Smtp-Source: AGHT+IFm8CFi29yR95ZJLmtNPItA91IHSPbKKy14cjzd8kPq+ryRNulw1lIA4wR1RkRJVc0q7PGSoQ==
X-Received: by 2002:a17:906:304e:b0:a49:56d4:d643 with SMTP id d14-20020a170906304e00b00a4956d4d643mr539291ejd.36.1711484664359;
        Tue, 26 Mar 2024 13:24:24 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id b2-20020a1709062b4200b00a4725e4f53asm4584492ejg.40.2024.03.26.13.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 13:24:23 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 26 Mar 2024 21:23:42 +0100
Subject: [PATCH 12/19] coresight: tpdm: drop owner assignment
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-module-owner-amba-v1-12-4517b091385b@linaro.org>
References: <20240326-module-owner-amba-v1-0-4517b091385b@linaro.org>
In-Reply-To: <20240326-module-owner-amba-v1-0-4517b091385b@linaro.org>
To: Russell King <linux@armlinux.org.uk>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Olivia Mackall <olivia@selenic.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, Vinod Koul <vkoul@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>, 
 Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-i2c@vger.kernel.org, 
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-input@vger.kernel.org, kvm@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=738;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=WaOdPxQDLRUP1i4wGsr9OiyCK6VXAW85SV74ALGfvjU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmAy7VRj7R1J4HzEG/Gqt70vwCECGo9q1EyZWXt
 w1kKN5twZGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgMu1QAKCRDBN2bmhouD
 11sAEACIpsCGKurOsdyhjt6Sh3nUouIrbZZk0aR8BhRFTpdJTwryo1ef40TZZrvrMOMfwvapB5M
 ghzPBFB5vOzAV2o/BNkPJepUzhRojqMIvm+JOay+U272jYuPKfgP3BimNdADbVHy5gSo0JcFz1q
 bBJLmPf1Gwly+2vyygEz2L3Pe2+xIAgCJ4z0S6rv03z+wLXdQYKXd5KzrlCYMyb9GWFYFJM/wJ3
 t1QlO82WYHJ9RJjxlEHO6qI9+9UknzKa4BxAF3PQnX4wWwU9fSqZUUkryO4fJOcnZW/fvbi73S0
 8Jk9MApU5+XARrgatq504SjsVK00ZEcIYNEJK5Xsy8IY1zFUiW0uzeLs/E5hT7GmX82aAZHh3DV
 4CkyGRxfTEeYqbcSx7/y5mKrFiQMGnrlx3A1JWMcXP1muz3qF4iA5TdHC+Vl/sbNEUeXSlN9PAg
 2wNC09dWLimreHgexDrI92RYIlcoQbVLnDzE7g9slTwk3cqK5jr6g2oiuEakApm39rCVXymjmpC
 u9vui5Q7j7sx+Sql9cUAdkFNzz9QX0tV5jtQgMEN1YjrZ/2gJZ7AR+L/Z+92T0/CroN/L1TMQiP
 7K3Wm8uSpe85UYUvEws4GDRefaeLlj4txksJZM4wbeNW03VPat7Cknbv0NN2cRfsbBLyxvjLnPl
 y6NGCqzOagwzZ3w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Amba bus core already sets owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tpdm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index a9708ab0d488..0726f8842552 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -1310,7 +1310,6 @@ static struct amba_id tpdm_ids[] = {
 static struct amba_driver tpdm_driver = {
 	.drv = {
 		.name   = "coresight-tpdm",
-		.owner	= THIS_MODULE,
 		.suppress_bind_attrs = true,
 	},
 	.probe          = tpdm_probe,

-- 
2.34.1


