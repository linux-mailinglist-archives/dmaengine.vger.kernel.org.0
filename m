Return-Path: <dmaengine+bounces-5264-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5927AC3679
	for <lists+dmaengine@lfdr.de>; Sun, 25 May 2025 21:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D649173BDF
	for <lists+dmaengine@lfdr.de>; Sun, 25 May 2025 19:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2180D263F54;
	Sun, 25 May 2025 19:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nmslgisW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C9825C6EC
	for <dmaengine@vger.kernel.org>; Sun, 25 May 2025 19:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748201178; cv=none; b=LEPVMZI93dzVHuLX412OBfbIUwvixEwAKveudPajks3bVnTmfzXMO0XcuH0R/l1Bhalf+XwI6xFTSGcv6SYS/qRyRbkw/MUexAxhS1GqbZ64KJzwnI1+kksf53oZ2aWpQ1OiVE65c6r0fHPpZbhne7QTp1xe4/LY5w1mNeBIBeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748201178; c=relaxed/simple;
	bh=V5AH1+nhHA1LXlQxV222W1Oi2wXG1C/M3RrgcoV+nLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mtreLs88GWvNJWLF9xH4qURp86VDtk08+nW6uTMZfYsd94+e/+VTdKbVwSPe7zWqy53OtrCYeg/2uj5AlMMJYAHTBB5jiMfsR7Ko6jnilf/s4oM9XIb/MFMrZ9OsvSa5RyBJIPByqOV4HzqE2Mg11rO0Y8uLvDglT4DCYjIi+bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nmslgisW; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-602b5b4c125so345739a12.3
        for <dmaengine@vger.kernel.org>; Sun, 25 May 2025 12:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748201173; x=1748805973; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTrpcq7cmo63iuo9rAA8cr+KotFFnq0ybXZqmfTvIsQ=;
        b=nmslgisWbgyRtvMKobtfs1QbKS/zg2um3IJH289eLmI+6Tk5wzQuO6zjPWJaBWMZ10
         iYH7OR5Q4O0Csz7KTH8LJZgRcZt+5LJccgGcPdpKmQpszI2k1jxFP8u3ZEDRzY/GoCHf
         tTJha09yocmKVKB1+co1DwJGMwAmYJ1bvK0Uw3ooh+Lri1D9ZQTJ1Eh+kHe7r4EsH3ih
         J/Lp3oYzUJLyGhdrLdYD8HzumM7iJSvQO3o5bkMjB81+6vNESPZfDViG7R6PcdiXrnUX
         VwsgaHnjPYZ9OMjQZN7xCjvBUstU3XBBrwbEVCKgvZurg1vd9Oh7SHzMEifgNQqvhb3Q
         KOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748201173; x=1748805973;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTrpcq7cmo63iuo9rAA8cr+KotFFnq0ybXZqmfTvIsQ=;
        b=lHNfGOo+sZFJkXusIIN17E4FAe8ekTTUbpdVfC+5cjM1hljlzp2sK0rQIyh3aOyKak
         eF0cgbMX36F4yEr/vAG43qP+RfffSLfMXfqz5SIwwi2HDx2U8IyqgiR3OiiThkD40olN
         8T3AaXcgluK512fw03QECpmlKvyVlffsDZsATlZefR1lTCESetU7UHBmIi34xFy8BJxL
         5QxNf4lF6632drhnCxilePJRU7cvMmWgrQ66vTiwsMUBpB66lvXRAglt0XEytVsQvZjc
         dn2uuBK4ARkE7YLFvWK/3OlDLAqOq3467Li4n74TAw/niwc4+Duyv50DJJKny7rWvQg8
         2tdA==
X-Gm-Message-State: AOJu0YxyXuDsJ0PHS9sF8dC427VKS4Z+DImxqCzO/uf4ixS92cM86PjQ
	U0L737oq+TCQrFjg4uDwfrXrXK5EFQxdQGRl1KL2iOYezIfBFDpPtVIdWhblU0O6EXg=
X-Gm-Gg: ASbGncutv5OdDNIWdQUUGreMouU5P5jtigvKsG6UClxbBuNsbzyHdpy3vqVp3eQqxxg
	z6FRWvDVP434GSfe7qsA+iCIqYAzDP6CNcyjOVS014SkoJl6063BY4Tmjv+BXWTkxsaUMjMmQBe
	pAmsPwCaLCDt4AdoXr3iwXGztssY2U7y9G3COxHxyumLCHYqNAllUnUfUMRZqzG2BEESXHse9mw
	X8BLOcuLIr/ig9bpSgRq/+6D6ZZDoCORkLDtWT8D6BcxO+KvcMlyz6GcQsDWOAfsLvIj5MOAf1x
	UzE5JPOnazk28ECEosGe391DPHl1kXZy4Soct5nhVPi8Hz3gPE5j13QOSUE0WCkulLsUyvM=
X-Google-Smtp-Source: AGHT+IFcKFEOMGLwUjvK3bIRa/MPx7xN0XsUDmctMG7i78lOXpjk0BJDZCo2Nb+2SEYCt5kQwz8jCQ==
X-Received: by 2002:a17:907:271b:b0:ac7:2aa0:309b with SMTP id a640c23a62f3a-ad85b0d0e08mr165946266b.1.1748201173483;
        Sun, 25 May 2025 12:26:13 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d047738sm1578899866b.19.2025.05.25.12.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 12:26:12 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 25 May 2025 21:26:02 +0200
Subject: [PATCH 2/5] dmaengine: fsl-dpaa2-qdma: Drop unused mc_enc()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250525-dma-fixes-v1-2-89d06dac9bcb@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=998;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=V5AH1+nhHA1LXlQxV222W1Oi2wXG1C/M3RrgcoV+nLo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoM27OEey0LczVps+OxFOAl856Ds5aHOmo4NuS+
 rrXvpmn2x6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaDNuzgAKCRDBN2bmhouD
 10QVD/4uuQe56wtdCAZhy726ZVOK83OScgqANziTt+S5vXw6wLzt4U/mXopIEylvxlnmy27H6fC
 b51C9RUACLqYDMK/URZ1KnvZv0FbjCtNWGg1ifY22RcsS/Tql2sWm2vD9JY7YX+yAoSwrCmv8Yb
 A66KFmiXSDUlZiRpnDfEXoSp+25TyN9Wj1E93v1+9UgHd8sweaWj21+G8baEsdBN2Lm3HYxE58b
 /VGnRqcU+zik3huqI2HfmQq0gmJq+qOm3Ifif+/47HYefz5xD7WbI6WVp1PaOhF+WbVW+lhnXUg
 Zv3w1+EovSBzetv00Yyy+UYv/qRKS2+FYLkudclS1/qSYj5lqTPjWmadbZzT8dhv8mJd3K6mV8E
 N4kdeUrbyMCl/uyMau4ijFt3wYGVULZMEtWZTduF580qHO9ttzSGCzcrIcgG8u7H7gAmoXOJOmi
 iuuZwrWoYRDC3X1ztHnpWs9MzngJbl68Pzz+RC9ZiKDhzSig2fWfWqOV5iBY41H3783bIAsZnr7
 b+FZEqgYhqwOJnVZub3xy2cyaCx9NBeFgxHH6EFDZt+VUZ7I9IaA6+ddegsiZEpvGOM83vDmCZZ
 uHF3wiOOwo7ZQ2y6BhzHMyilI+GhoO+rKAwOHqaFUJezi4BBdAMPzYIev3/FuZDsIZpgelRdPtx
 cQACIXQXw5m0KWQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Static function mc_enc() is not used, W=1 build:

  dpdmai.c:51:19: error: unused function 'mc_enc' [-Werror,-Wunused-function]

Fixes: 26a4d2aedac2 ("dmaengine: fsl-dpaa2-qdma: Remove unused function dpdmai_create()")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/dma/fsl-dpaa2-qdma/dpdmai.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/dma/fsl-dpaa2-qdma/dpdmai.c b/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
index b4323d243d6de8a1ec77436ce45579914230b9b6..4be81db24a1945fde62d9d7a00b9809a65271101 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
+++ b/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
@@ -48,11 +48,6 @@ struct dpdmai_cmd_destroy {
 	__le32 dpdmai_id;
 } __packed;
 
-static inline u64 mc_enc(int lsoffset, int width, u64 val)
-{
-	return (val & MAKE_UMASK64(width)) << lsoffset;
-}
-
 /**
  * dpdmai_open() - Open a control session for the specified object
  * @mc_io:	Pointer to MC portal's I/O object

-- 
2.45.2


