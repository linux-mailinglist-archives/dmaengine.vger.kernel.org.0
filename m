Return-Path: <dmaengine+bounces-5070-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA30AABC3D
	for <lists+dmaengine@lfdr.de>; Tue,  6 May 2025 09:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5AC63AE41A
	for <lists+dmaengine@lfdr.de>; Tue,  6 May 2025 07:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B137B21FF26;
	Tue,  6 May 2025 07:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnSZ17/g"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F206021ABA4;
	Tue,  6 May 2025 07:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746515362; cv=none; b=VlZ1jYczOhDjUZktgjBJsoEJm2SyHgxiJnlM6YxI6KICdiQOFbPcQit8YSYbKXr1/7y5GRRxpUCApgAhdvGWCNT8HX95DKL6TSbeeFqMyao/fz3uS9IMQtb9rbWX4LCpX08uYEEiIco0/ZrP+Hb92KOurgDtt774DO/lZg/JK5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746515362; c=relaxed/simple;
	bh=QptzfwusksuZ38bQS8zZ5QIaaKw3Z3eoX5XU/YZt9E8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ToI3hZIIpZopfRc8dO+LzZFAwYr+DAeXdQ1wo7jKvG1ecxPYVg64itEdUt/9/zaePmsDitVO19uTmumMldBqcm0ZvNRHAidS6ctB9DR0aQ8EmzuN2BE3ohHuKgz55vv2B1TzNQ7f0hbryunk4BglJ9xQM3ltRtJUpy2UWQ27L4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnSZ17/g; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7370a2d1981so4374744b3a.2;
        Tue, 06 May 2025 00:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746515360; x=1747120160; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mgwl7nVbHdNiN8F8dDS9LOTI8xQyzUOwLM9a7A4broA=;
        b=FnSZ17/gHKaKitfMtxWh+5q20gGeDzaz7vsgp8RraWx5ZndsxAwyJYooSQghl2Wbw7
         EwJ3Q3g8fLmPep6kotJDajh5yv12LTbuOC/WL26ohcKgyNb6mvgYiG4XrYRW+0vh6p43
         pAlkAd7bKYcJRkfnv3sMtNZPz5JeGfyeLmpKjpZfD2qJAH+d35XAWrABym3ExptgDqGH
         mN1lzrorlwqLTRuQHBCjBew6q/egFtEouDBTl9NIqzjsY9mrQo0LpuqTUmua5zWAcScx
         qhyjXA/EQFPUHsqmxX3r+seEC5g6ibI5oS8I//bwork5qoReRZFBDxNXNKC12JopegbB
         1J+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746515360; x=1747120160;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgwl7nVbHdNiN8F8dDS9LOTI8xQyzUOwLM9a7A4broA=;
        b=LbgCR1qJceZobat+wzyMboLEchoaitH5zBtrbUjraoiV9V439prK3tJakHTxJdIzpQ
         YeEQXgkg6y8Y799wFCnQh0LLCP+wu0ZtD0cwUSqdgoQCxOSJa8jZztkrV9iSEnHn0Tn2
         KKUMMeHuRV5pkXTRyMSk/2v+wUbdjHyqa4rv2BNtj/iR/EuHjReAJP+Uv+v6ve+SyUpk
         Suw9vyzYvHvl2jGR+GBzGRv7IY7RqViK18FzRuouT0JYDu5MSvSCco8I5eB0qa/+UU+f
         dba6RzVgiWr1SE7FfBaBGMHe2XR140ex5dZENcQthAFpSQbqv1jVfvBm3wzyxEo+k9az
         2a8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/Sp2WERcNc0mOAHlk/59jnefRnfUxvb1w0Nrv3F3F03VihnbNXZBo1+EukzpHWxhzuhInCJutvXNmnON5@vger.kernel.org, AJvYcCU1NNJwMYIP+FzWcIgHR1SL4C6Mlcf1rOK4QWd0AmutVTsNECce6DIxZPdvctzd7No2TLY437jzDrng@vger.kernel.org, AJvYcCXHEHcNbjIN7Y2esq54g6I9N5/Vi/LFKJ360OwTlKeTyTJUXJSdBORsQ+xK9cGSoad7szRzWyaDDsyav00=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6lHZwgjB3oPcClu//UZmWzlbDu7SLAqVKZkDv1xtTNptuzYsT
	r46095JB42WXbV6Wm28iOeFWaw7+UrSS0tbYTrO2Q4KeE+4+YdYr7HDEBG5tkFQ=
X-Gm-Gg: ASbGncvj7oVu5NziZXjYCOlnSRFMry9KdhPe9PaCCoI5hCqdc7JFAUuVW+hPr2IGtP1
	o8sLPE+x8aIwRjcW8qOJNOmJ+jPRWim3DIQ+fvGYDmoGr+SNtWjLsqlixf4v4ceqPhyRwD+eavZ
	2aT8+qWEkq2fpbJpzCe3GEqSnz68w/3zuSGxX1eJy2iqIHlAcALLyZf2ZerwZmjjSpEVV/hiwAh
	5fnON0p3LPA/VGZgTZP3whZtIf+oTud0EpckELTgV6Gr1FrfPRgqDecT03YiulwScVNGISHWt9b
	bz9iYj1n7VbfdldCWOON5Bni8fBHR5/vijwVMlCGiS4F4FNgoA==
X-Google-Smtp-Source: AGHT+IEdXdkXF2qooJ6gY+oW9ZqmP/3uTomu3iRY1YuQO18tzpX8Ro14rnYYoz7RyMJ1ITiGhixc8A==
X-Received: by 2002:a05:6a00:2a08:b0:736:ff65:3fcc with SMTP id d2e1a72fcca58-7406f176b76mr14739749b3a.16.1746515359867;
        Tue, 06 May 2025 00:09:19 -0700 (PDT)
Received: from Black-Pearl. ([122.174.61.156])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-74058dc768dsm8124025b3a.72.2025.05.06.00.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 00:09:19 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Tue, 06 May 2025 07:07:27 +0000
Subject: [PATCH v2 1/2] arch: arm: dts: nvidia: tegra20,30: Rename the
 apbdma nodename to match with common dma-controller binding
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-nvidea-dma-v2-1-2427159c4c4b@gmail.com>
References: <20250506-nvidea-dma-v2-0-2427159c4c4b@gmail.com>
In-Reply-To: <20250506-nvidea-dma-v2-0-2427159c4c4b@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.14.2

Rename the apbdma nodename from "dma@" to "dma-controller@" to align with
linux common dma-controller binding.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
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


