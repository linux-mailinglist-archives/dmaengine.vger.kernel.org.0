Return-Path: <dmaengine+bounces-5266-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D661AC3681
	for <lists+dmaengine@lfdr.de>; Sun, 25 May 2025 21:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA14E173C98
	for <lists+dmaengine@lfdr.de>; Sun, 25 May 2025 19:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010E5269CEB;
	Sun, 25 May 2025 19:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wrcDgDdl"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE011F582B
	for <dmaengine@vger.kernel.org>; Sun, 25 May 2025 19:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748201182; cv=none; b=NwxVgNFHa1plJC4M6ZfeUArWRkhwccVxI73V7aqsWzLkBeu59u6OCMtMOkWObE1j0bGJJig/NdpVbu3I8qDLoIlbR2xYzQ+LtMXkTKyflL9rwCodeg7MoKffKhd7JzHHlDuuKNmA3d6brxohwI5oVV0SumW/Z7U79P9weweFNfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748201182; c=relaxed/simple;
	bh=wf9mMF4piwylWLERQD6eu/HVFRIY7xIhB8VCk+ieFdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Iy8NkB3r/9dZpR2tQtTH1A7f6iW0zaWo96BCr/EDNfAS3Nmh5mWKcRQ8Ba2vrCEKMJyhnL+SUeDcHv9kRyYba9JNI/BdAKiB+jIDhuHy117jTGhoGwkTMKYIvGX1G3jT21HPqLWdnvpBIaHQNmDCHKs0mGcqgEdaMM0mm9lHA4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wrcDgDdl; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60462e6f227so163388a12.2
        for <dmaengine@vger.kernel.org>; Sun, 25 May 2025 12:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748201179; x=1748805979; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dB8Qgyau5a7VreD6df5S2eMKOiRWv79kx7XCROS4r/I=;
        b=wrcDgDdlB77/8sVADWbFbOueNOJpY8qiY9wKfUIUQE9NoFavXjWdOUwgMoNiJBvPkO
         z4h9OtgTl8ePEx26YoyUWKBz7o2+jSY0Uab/ZaQKF3ph1BoVatIHG6lMoI1s983uDVna
         gMnNYvFGP4puFStd8Tpy6vNf3+YuGEW5MloIh8tX7Y08BMyZui4anXbaXe/oJlQsNfk6
         MSqcEA9b4orMXeWaGEk2YLCRRWVhNk2GMNfN83gONhMThdzG2NzB+KXxwejg4t9LHwPT
         aw2s2/pID65qzl/yXRZS+Y4cobkUsngQq3xn2x5xqlTPLGMJyBQovbq6Y3sGrqiMOxzZ
         jpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748201179; x=1748805979;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dB8Qgyau5a7VreD6df5S2eMKOiRWv79kx7XCROS4r/I=;
        b=Kd3REZ4yzaOgbCJdweH57hFWnJgiMMu9f+k/FROdYZGouCXdgwPriKyQStnZDbgVTz
         Al4jTMix1GEbkWsZHKwELJoYxK9rPv11tCZbWfRJBzES+MYoaRiTQk9ijJVoLHo59RXz
         pcniI71jcJb3J0/qk86tpKW4Wt08kliXqlddOsQy7L12nyYjP8c51L87Lc2/CLncYdOu
         MD0fYh7ZQavNATygScrWqgSLXdeh+bKQz+C/vzxUxB6kMB1th35lRFs0AFZshWXFhsJX
         4yKe7xvDo5XlRieN+eLTCEqpymVc8pClJ5ZcxNaStkdde85+fPRMlLgPDL+45eqpnvsx
         0vyA==
X-Gm-Message-State: AOJu0YxA7Q1x+VWJ94Z1IZ91kUMkPWsVDVgJN39dRUSgwm8l7ltitRuL
	5GtQizC934MukmKYv9pJhK6fIY2y/gYLA+qf+YvjCCc6BjHetagPGTwd0k9T+ayJW3Q=
X-Gm-Gg: ASbGncvDMle2n7ED7izEzEGzhewmjL8Dd6LcV44zsh1yW15/5EiC4CFb/hbNhEXKaY2
	nfiom4md5a5CsqXlTUU36mAKTND3XF+DWdC6jjC0CJMns8I8VSaJvLk1PngXtcqzT/eV1JaOjYZ
	iyZFTIA6CnVubHPzD4Oiz68JxymrqsgRweBNI1Nmcz0xKbQJ5rndEAjbAfxwdGmkyYeZo2V54OI
	S8Yd0JpDZN3HORwmKqdCDT+02vu492JqLqDbv4eQC0cjb3+aH7GorvLD60TGbyNWGKnAc+JJcVB
	iV3Mk7Q0fhxLqeAtzE1wQy1f21UNar/R4r0QpT5ZoiVNlNQSXvW6Brctm94JHfvZUxPJvxo=
X-Google-Smtp-Source: AGHT+IFU6iw0nh+JfwxngddrMbaAdOgnyTVpsEnCYJPukcl1HAYkzxRla7dTLdaaFau0zKRt4TXHew==
X-Received: by 2002:a17:906:8470:b0:ac7:4397:4345 with SMTP id a640c23a62f3a-ad85b11378bmr178652266b.6.1748201179389;
        Sun, 25 May 2025 12:26:19 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d047738sm1578899866b.19.2025.05.25.12.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 12:26:17 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 25 May 2025 21:26:05 +0200
Subject: [PATCH 5/5] dmaengine: mmp: Fix again Wvoid-pointer-to-enum-cast
 warning
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250525-dma-fixes-v1-5-89d06dac9bcb@linaro.org>
References: <20250525-dma-fixes-v1-0-89d06dac9bcb@linaro.org>
In-Reply-To: <20250525-dma-fixes-v1-0-89d06dac9bcb@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1089;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=wf9mMF4piwylWLERQD6eu/HVFRIY7xIhB8VCk+ieFdQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoM27QVOIFby5xrQ2vikjmTQ7sy/m4A+Dgt9+tq
 viv3z7R1WGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaDNu0AAKCRDBN2bmhouD
 13XnEACJx5d0HBGfD5BYrQ/0oD8C7EAM3yTiKzycRx0rnOvdsj40fPEbcAEVzJWDBnzOojfNm6D
 lnrDDw49hqQIGOukFQsiJv/gZDfBaUJw7+Dmtv57AjMZ585U2DErn1tA2ts/l8KZ4G2m23X/eFK
 BBND/wfdmH4dlObFa99BwZ/25oozbvMPTm4vX/w99ss1IfuHu5ccWWTWWPRT7UhGKKEjaP0DKn9
 52jsFGQqXwGXeXQlOeOhVZ/sRVW8qTABHRgDoNS8jnUAZc1JyimVR16JQTQYc+FhBXPvT+HC4Ds
 JTTxgv2cB8/KJSg3TD1yXecjPEC14rrhX9hLg7MwERfca5VtUOgATV/iRGO/6Yam/XNwHeCGm3a
 HWsKhm5Jor2ZFKDzphxNICY4Hlfn05hfbPz8CictbHrcbLFLQhvujVChlYOA+yzUUDcU8ZHuHuL
 wq9KcgowFM3M1pBICip1f6FPIIJ+1rvfFNIX+bWNvcsHECHzL7gStOswCNa/BGQS3OdLj9rTgOg
 hCJxryLHK7x3BkTmWdJkqhVkc+p0/4jjmtrZeYLpMo10JtVV8ocEAFD4b4sGYK6HIsWpXH0LHrf
 OD1yWyRuahfwIM4pACg81vcfiesVeEOYgsWaUrFbe34fn1tNlGZIA4rvem0fMjGYuiwCcc2wXaJ
 6MtXrUj2ocfKrEQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

This was fixed and re-introduced.  'type' is an enum, thus cast of
pointer on 64-bit compile test with W=1 causes:

  mmp_tdma.c:644:9: error: cast to smaller integer type 'enum mmp_tdma_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Fixes: a67ba97dfb30 ("dmaengine: Use device_get_match_data()")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/dma/mmp_tdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index c8dc504510f1e325017ba4fa5e7aa72b019e3be4..b7fb843c67a6f247395296fc726f7b6cab7d223f 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -641,7 +641,7 @@ static int mmp_tdma_probe(struct platform_device *pdev)
 	int chan_num = TDMA_CHANNEL_NUM;
 	struct gen_pool *pool = NULL;
 
-	type = (enum mmp_tdma_type)device_get_match_data(&pdev->dev);
+	type = (kernel_ulong_t)device_get_match_data(&pdev->dev);
 
 	/* always have couple channels */
 	tdev = devm_kzalloc(&pdev->dev, sizeof(*tdev), GFP_KERNEL);

-- 
2.45.2


