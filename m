Return-Path: <dmaengine+bounces-5094-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B11AAD4B0
	for <lists+dmaengine@lfdr.de>; Wed,  7 May 2025 06:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D955D5032A1
	for <lists+dmaengine@lfdr.de>; Wed,  7 May 2025 04:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3A21DE4F1;
	Wed,  7 May 2025 04:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KinZQKJk"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16FC1DE2CF;
	Wed,  7 May 2025 04:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746593900; cv=none; b=bBNOujCeicjka8wlc2Pn2xzRktv9lLjRWQ7CzSm1hn84d5241gT/yCj4b/jUnb6VEOcBkJyCjqbQxmZ6SCoNDXqh1k89sMCQtZHXYEQUpU+976+zpr+KiR/uNGKCixYJ3i1KfMGBrJFcfPRIjoKcjhyJBJvCuvQ6KC8Ssr/W3dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746593900; c=relaxed/simple;
	bh=7XsJOQPup8e+ZG8bqUkN0whaKI0XEfX1cgodPpJreq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=koKqqiVL+NwO4wNX5uVEnljy56awyLjJ/roF75sO/VBUDgKQAFs5OlCXiLGJIUw7ZdT1Zh5wdDkW5Sqgi38aUe8p5kPBL5jBfeOCq1nlT5wBdNwVoNuJiQC8NvsS8JQdlR7BNERQHchqoM8hpg5F/3D4rYzDhCMzSe2ae6k7iLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KinZQKJk; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b1f7f239b31so533790a12.0;
        Tue, 06 May 2025 21:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746593898; x=1747198698; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JqNrCD4w2UOFQjLaLK7IWUb2YYR/VpnmuOsefV6Wh7s=;
        b=KinZQKJkNQ+0y3LGbksubLk3RJaTu4J5uL/C4VVFc1BmINHua1gaFPILJbDs75X7D0
         tWgqbETcG2e75btE5nte+sRPmLMkmweSzf8R0wWxir6C9xE8Fycl+B8AFz9qNOBTRewz
         9GZeHHvtoN+5PKkNTw9HsD/LCv0Co1hUQTLTgHqKHdOlUu7U/IIhS6hpc6riZU8yVbRm
         6wc+hW5+vSNyRTO+NFallJYzrfNgVDW1nUbQUglmyVrpFtQ0g5xAcolLx28flqStlVmi
         cGQYGBUFQCiAr9sTSo2Sx1YusPGrzK2261ZFnN4h2mpZcLtCA0emMTFNYsgX/6/BrYZ5
         FBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746593898; x=1747198698;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqNrCD4w2UOFQjLaLK7IWUb2YYR/VpnmuOsefV6Wh7s=;
        b=DWq03flmrn6f2W3OqzU8mp1QD4MY85vml0cAazXXAzb6vHP+2mRAPiL0O58JkvaCNj
         KyTwuy5nI2L+5TYyrz2JOeOPhvM9jTlmuCKdiqjyKNeKCgSgq7cLGI+ZwIpvUkSLTEwB
         AVus2If2zrJGJmdZAgXh/bSNYkqqHRnpFkhvjK7E5+9XoH9+yhK4D9XEAeJ+BYwUb0x9
         IiiEbu3FcWAgbqEhNwNjH2agfNbk+eFtBQmLBdjvrrHOhwSKWYhEzKmsT9UqAOzWPa5q
         CideMwOSFsrlmoX7JzqQJVUmebL3sehDuMnJ4l1GVfFqqhwnSNTvHH2gb/muAOafp8N3
         BrZw==
X-Forwarded-Encrypted: i=1; AJvYcCVEQip+oaFoHIBnl1ah0FYDEVzvJZKWa33T75peKf++JoL2BqWke803Hv5whDqFaaNgJGAHEA3/b/HWSAk=@vger.kernel.org, AJvYcCX8WEZwkizNKy/YE/fN90P/Ijk+BEXuhbqdwlhPu5UHNxyU9ET71wPuVmIm5ghXgVwTKAc+XJ8/YjzZ8Bb5@vger.kernel.org, AJvYcCXEGLocKPaWkxAsFwZXiFSh1la9t17EqD1jDpt4GhCQD8r1NoluEMm34DNTsM4ujJnZHznlgIbx8bxw@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl4oD/MdgGXntBVfuXTuCgx5hmyRUO8U9zhDepjiVlP4ItAbJL
	qBIt9OpKAAiAbm33Z7T017WdTKASVL5SNfn315rYDoc8mXty/cc4
X-Gm-Gg: ASbGncsghwTX3CLL9qyKmKTKrVtABUT+I/2V/6EQBJh8KEGwsG6nkBIFl5eRFNvNAvZ
	nkQ8Nmm0K2ejI4WApVebJp48JM78P2i/n564dXr65tAnE+z3Qv03yG6erOOtk1O4lSEo4X6AFe5
	nHX/9j2+FESrwD6/X0GbsNj3r2QmfOj5gzONszA0fk4USa8N5u+vINw/FZn5opK7SHmrBO0+mCZ
	+rxErz16kFWx5IGOE82n3q6Rjvw8aDfTYWOmwo8q+rVEKxkbJ6kC0IRpm5R/ErirZXPmgoWXaNf
	FPoTWBNEcPqZxnUex9x3SyRBJ7osyLdzv8exknn8RIaXwc6IWmaxu7UNYp01Dg==
X-Google-Smtp-Source: AGHT+IEeRTfVcdAqTrgcGmjnsysM2uCYYbEzoggcX50DIYpbyUgOw//Uj3jrx7qTm/bJ1386a+AapQ==
X-Received: by 2002:a17:902:f708:b0:21f:6ce8:29df with SMTP id d9443c01a7336-22e5d00fb96mr32939785ad.3.1746593897794;
        Tue, 06 May 2025 21:58:17 -0700 (PDT)
Received: from Black-Pearl. ([122.162.204.119])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22e1521fd12sm84261505ad.127.2025.05.06.21.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 21:58:17 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Wed, 07 May 2025 04:57:33 +0000
Subject: [PATCH v4 1/2] arm: dts: nvidia: tegra20,30: Rename the apbdma
 nodename to match with common dma-controller binding
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-nvidea-dma-v4-1-6161a8de376f@gmail.com>
References: <20250507-nvidea-dma-v4-0-6161a8de376f@gmail.com>
In-Reply-To: <20250507-nvidea-dma-v4-0-6161a8de376f@gmail.com>
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


