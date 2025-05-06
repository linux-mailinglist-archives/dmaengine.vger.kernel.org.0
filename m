Return-Path: <dmaengine+bounces-5077-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BB1AAC1ED
	for <lists+dmaengine@lfdr.de>; Tue,  6 May 2025 13:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E375817D5A8
	for <lists+dmaengine@lfdr.de>; Tue,  6 May 2025 11:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D212798E1;
	Tue,  6 May 2025 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6Kdq9hv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AFB2797B0;
	Tue,  6 May 2025 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529428; cv=none; b=DIuuMl541x26mnDk2xtbhQZ4+zR2WgFUImsXTm4/LtQg/ZvRRqy2OlJgM2SZZm3/iFMOxx0Zk+dFMzIiEe1JhycwLHbD3yt4V1U2sRDfxYrVhJg2/dFr/TuCEr6rmCQU9Y+uYzMufIBrFbxGO9LS6/Xw0px6pkQtTPR1l23EQKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529428; c=relaxed/simple;
	bh=7XsJOQPup8e+ZG8bqUkN0whaKI0XEfX1cgodPpJreq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NGq775D+ROIKEVxcepl7UCzOmax/mU6MaYEbLQdwMboaxVYLzqk/pCt702EZSa3fRuHNskUAFt7Y2NyANoEui05Gz5dy2LJ7wgrkFrwXfNBBxW9vzoMt4vlGTvsRLtBFU9Kl9uYUFlNrls6BR/oLm1LowuweM55eVRQ3nhWONGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6Kdq9hv; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-736ad42dfd6so4436414b3a.3;
        Tue, 06 May 2025 04:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746529427; x=1747134227; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JqNrCD4w2UOFQjLaLK7IWUb2YYR/VpnmuOsefV6Wh7s=;
        b=b6Kdq9hvzEtqAyAZeu3++0XA+qse8yUYQCKqyB7PNUKKqRBSpRfQ4Xv6tcpaPbid2V
         7QTqMaejxXDAX9PTyMEKUowLUACE6Lt0n3jH8kraEdtT68uZOmfnOAbEYP6dY/5/h6O2
         vlOB6aiWHzpdvYxcHAgIaL7LnOLPwh0Dp/gXxMrgBuKmjOv9798r13Gvr25iHqxmTHZf
         /FqKLMB3P5//BJKPg2PmFVbJmyxIHEtJSOYDAE8UufLNyvKPdarjAzhZKcM/h672nZe4
         UjV5IyQ8uVgogdIGteAGDQcqx4E2bhKnXKDt5ntdX01VT59WVZhEQo8fN+g0k6xI2OWp
         jmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746529427; x=1747134227;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqNrCD4w2UOFQjLaLK7IWUb2YYR/VpnmuOsefV6Wh7s=;
        b=P9H/ZEHy6q6r+bUWUYO1kfurmOvrrbWcYKvK3klVWZiXn95EuOJj+rZWiQ0y8FEnwN
         joPhh/IpaAbir/0zqtHdGbSw7MnMAIB4E4LyDKNub0/63pAD5gaXUsXN47XrjduW4eIN
         sUXr8gNTM8PqCaclAtJB5z7301+eEv26ol4RKPxvLDbwsCzxhacwFXGabCwFY95UbHKK
         QwnokE9OR1WYVWmt1vNYXBFYGCXmrbH6+FIh6e4aZ9n0nCC88f5l3rJlGsRaZQR90Mds
         5aqtTI3S0D8ESVS81J3oq7roCZGHeFMORLisniVd2b0D4dcDYyzOhFBqkX1ubWjHev9D
         Y+ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdr1FkYiKjRi1Eyb3hR9F2jW3gF/sif6IOkUEu+7w7E6NV1GmQeEidZE43zdw1ZZQLlKjvUYtSswBqylU=@vger.kernel.org, AJvYcCV0gL5Qw27rUgxtsaNdLidkDjgfAOpr6/eA59CuBwvu8haDaFiCMH6bD7qNljHS3737bY6p+5HArm8USnm2@vger.kernel.org, AJvYcCV7o114ebByAqZ+vlEm9b0iGLwuY6+Cdn1f4YQzlZh/EDkw7BZWk0UPFEOTbqeUABuzQfZcMqFh2fio@vger.kernel.org
X-Gm-Message-State: AOJu0YxV8an0BGO9IXaOLjmanb/ERjgQx4GkIZashDPa/vCnfcNboGn/
	bgTtATNhtchnyEEsE2vwZ4Y0PGZCVX8Gb4aYB+9OzrXMDnMeGDhE
X-Gm-Gg: ASbGnctANFfo8rMzbvBio1JuP6MVzLBFLPJrzdvwrxcE7a47DJ+GSpvdFz9uy7jlfbw
	KkDUTVhK4JJFW7ru9Z0N62Y5DP6n6qoePeTEpM1ctrz1KtvsBKRKE6HtI2GfSSR9k+cWbgWBWoq
	Lzg98xm58KTuR5rVbzmBCFm5TSrWC+JpLdtZWmTwnOFX7REJJ8zpb8GWlH9X0Dl4+d+TYp261tW
	LRx+wfHMcbOmVZXnLcI/1+arJiG+Kep0Cy1mgyqgogBOs0LyMGvNbuxCPkrChDrLFNQICinwYeC
	4O85Q3LiBFfaZUFLvL6qK86KhGXVRJ0o5bbGO6LzsxiWdo1XRA==
X-Google-Smtp-Source: AGHT+IEnOzYriH6IYe5+tR+ekT2lySNBwQBMB0g+i5fIIIF6B3u5alVKUaoyOQTorELphWhRrqRpwA==
X-Received: by 2002:a05:6a00:6314:b0:740:91e4:8107 with SMTP id d2e1a72fcca58-74091e481e1mr2498319b3a.0.1746529426578;
        Tue, 06 May 2025 04:03:46 -0700 (PDT)
Received: from Black-Pearl. ([122.174.61.156])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-74058d7a3bdsm8613778b3a.9.2025.05.06.04.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 04:03:46 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Tue, 06 May 2025 11:02:24 +0000
Subject: [PATCH v3 1/2] arm: dts: nvidia: tegra20,30: Rename the apbdma
 nodename to match with common dma-controller binding
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-nvidea-dma-v3-1-3add38d49c03@gmail.com>
References: <20250506-nvidea-dma-v3-0-3add38d49c03@gmail.com>
In-Reply-To: <20250506-nvidea-dma-v3-0-3add38d49c03@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Charan Pedumuru <charan.pedumuru@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2

Rename the apbdma nodename from "dma@" to "dma-controller@" to align with
linux common dma-controller binding.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/nvidia/tegra20.dtsi | 2 +-
 arch/arm/boot/dts/nvidia/tegra30.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nvidia/tegra20.dtsi b/arch/arm/boot/dts/nvidia/tegra20.dtsi
index 8da75ccc44025bf2978141082332b78bf94c38a9..882adb7f2f26392db2be386b0a936453fc839049 100644
--- a/arch/arm/boot/dts/nvidia/tegra20.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra20.dtsi
@@ -284,7 +284,7 @@ flow-controller@60007000 {
 		reg = <0x60007000 0x1000>;
 	};
 
-	apbdma: dma@6000a000 {
+	apbdma: dma-controller@6000a000 {
 		compatible = "nvidia,tegra20-apbdma";
 		reg = <0x6000a000 0x1200>;
 		interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm/boot/dts/nvidia/tegra30.dtsi b/arch/arm/boot/dts/nvidia/tegra30.dtsi
index f866fa7b55a509a0f66d3e49456565df0d74a678..2a4d93db81347e3e1dd942e6c10a1ff5683402e7 100644
--- a/arch/arm/boot/dts/nvidia/tegra30.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra30.dtsi
@@ -431,7 +431,7 @@ flow-controller@60007000 {
 		reg = <0x60007000 0x1000>;
 	};
 
-	apbdma: dma@6000a000 {
+	apbdma: dma-controller@6000a000 {
 		compatible = "nvidia,tegra30-apbdma", "nvidia,tegra20-apbdma";
 		reg = <0x6000a000 0x1400>;
 		interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,

-- 
2.43.0


