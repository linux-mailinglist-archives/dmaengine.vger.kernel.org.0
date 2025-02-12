Return-Path: <dmaengine+bounces-4439-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5AEA32CD8
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 18:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C763AB4F4
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 17:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D150260A33;
	Wed, 12 Feb 2025 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PGxUY2on"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580D225EF8C
	for <dmaengine@vger.kernel.org>; Wed, 12 Feb 2025 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379864; cv=none; b=Tbhka/ReSk3SAt4cwey3wo6Y2IHICVXjoPEWCJa+P9bqM6aqnIP5v3p6gbvLSM6XgcyxJn3PBmLiwdupWw7HM1N8C5Ppo/Pg3AawQ+19E0E38lhayEXd0gAMrkSp3DFoEyGNPmoyxuo96sbFiqyThqUug4tjnnotN9+ju6vrlxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379864; c=relaxed/simple;
	bh=/NYZuVJ5CW8Pc7756jGUtf0Lv3irVG+gP3QhGB2cFMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X0sCh2YLMhH/aeEkuSp/vSGFnRiE3a6PTbsplpLbXaiwg+J6zx7pakbkBjv/KbNkhgiQt0p3wfUuG09S4s4m+KZG80uwWqhN57B8iyX+090lL11VsckgXxudESb38JcX+k6ytYT+RhUBEfcMeN032vilClCQRZHepaChlNf7HgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PGxUY2on; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so2111379a12.0
        for <dmaengine@vger.kernel.org>; Wed, 12 Feb 2025 09:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739379860; x=1739984660; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zYw0tG/nuWEvSbLScJnWGG2Q11zXbK7g2BHQcn5xcy0=;
        b=PGxUY2onQ7l/ynhXzdODhL+LJ84b/njUlAb0Qfc2wsoNq/3YrhAzm4R5yaGIUY7TOD
         J7mYNxdYBqbpL9kYY3Cw9M5Dt38OTiJdmuliWGbVGKFDoifnvU2MfyYj1qHDL2xR97TX
         Xtz0Zt8a94ML64LhZndC88WcnG4JFnO3RgnDroNATRZ/xzYFUKdKJyiy2M/aSsnQCbkc
         gaqEoab8HNblxbUHGmHGSVdH3tkwDiBQ3Fvxnh/L5T+FF9KGzJiEPahghjjQYFd/ChPI
         lRq8a8kLFlYNmI58PhtjUqt23Nh4jnoHHx/3z/ZOfsDBKfQMrkNsHxnIF2PRgllzSGQy
         INkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739379860; x=1739984660;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYw0tG/nuWEvSbLScJnWGG2Q11zXbK7g2BHQcn5xcy0=;
        b=YwkWQm9ey0HF9LXWbTX8ZSRrDbaDxkE23pPqsg04IHdn9rYPyCPylFwPM31fFVxMIr
         f9OLnndTrXguJytlgXfiLlLlrK80Ye9l/F6SkDk/ht5nbqSDRaXIxHG41iy3Gapuk+YE
         FxGxymXRXe7157KsclIUid7qV7rTUXOVanaLGMaWBx/sB/Al+B+6DONE+jkSr5xX2S9F
         SxS65cTYQknGeb/23pfnoNpCpSIwDFNvvR736IpvagVMTdEKvciAX+GlSRBWGIWjQfhx
         uzhZnDGEbj+qqTcA1YjU/UezVa6t+Q8Qh2STnKoxBhdUCltyAtoAnziSy/NBMLDYj/fw
         KCKw==
X-Forwarded-Encrypted: i=1; AJvYcCV/K3TtTPgnQuBFhY8S01PLU4/REKrYuynDxszx1q46+HMC34v7rbiiufUx1ApkrQlusv2rUapJ6ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPtH2KBM1PiyYwr0FoYPRGjwm43BucMXWSvgf5DT0ME2KPUJtn
	qimYGx0QDDw/WbUkH7G/FMFJAYCoGvrESYQmtehQDmeZCmNDj26e2C1T6UY1WdQ=
X-Gm-Gg: ASbGncsJlmRoTpPM6w1zmy0hD99GWPAK6vYMnCSqyVIsmGo5qHqcSiXvoxyDJwz8Qn5
	nd1niI7W72LFE/IblRcJdzF2e/9Qc26mLcdEjb3Z78n36hKXRIxPRwg6+2HM6bOFhY11j8k/PD/
	4r5QjxJSQQdTtrAeXZZ0k/B6rOo2ECLs1na8Y+DSRHPQrtxmfEhk0RObz0z2FMA8Li+EBGQjjHT
	diR4TBMmuopjZYY5eXOaLylJJjsH03HLiFReBn3EUlNJ7DZmWSXFi3I4MJVnlObsIrTdg7+7nzd
	+A+leVlCj7ki0/WiUj7fQ+rO/L/P
X-Google-Smtp-Source: AGHT+IGwS9pGhWIrn8y879zF3bgF1bakf9yBm5N5I3DRe/DsDY25Qv96woF2RY7pM8YiIFh7fSb+cg==
X-Received: by 2002:a05:6402:27c9:b0:5dc:80ba:ddb1 with SMTP id 4fb4d7f45d1cf-5dec992221bmr34314a12.14.1739379860196;
        Wed, 12 Feb 2025 09:04:20 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:52e8:f77:3aca:520e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5deb9f6e46bsm819230a12.71.2025.02.12.09.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:04:19 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 12 Feb 2025 18:03:50 +0100
Subject: [PATCH 4/8] arm64: dts: qcom: sm8650: Add missing properties for
 cryptobam
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-bam-dma-fixes-v1-4-f560889e65d8@linaro.org>
References: <20250212-bam-dma-fixes-v1-0-f560889e65d8@linaro.org>
In-Reply-To: <20250212-bam-dma-fixes-v1-0-f560889e65d8@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Yuvaraj Ranganathan <quic_yrangana@quicinc.com>, 
 Anusha Rao <quic_anusha@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2

num-channels and qcom,num-ees are required for BAM nodes without clock,
because the driver cannot ensure the hardware is powered on when trying to
obtain the information from the hardware registers. Specifying the node
without these properties is unsafe and has caused early boot crashes for
other SoCs before [1, 2].

Add the missing information from the hardware registers to ensure the
driver can probe successfully without causing crashes.

[1]: https://lore.kernel.org/r/CY01EKQVWE36.B9X5TDXAREPF@fairphone.com/
[2]: https://lore.kernel.org/r/20230626145959.646747-1-krzysztof.kozlowski@linaro.org/

Cc: stable@vger.kernel.org
Fixes: 10e024671295 ("arm64: dts: qcom: sm8650: add interconnect dependent device nodes")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 86684cb9a9325618ddb74458621cf4bbdc1cc0d1..c8a2a76a98f000610f33cd1ada82eebd6ae95343 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -2533,6 +2533,8 @@ cryptobam: dma-controller@1dc4000 {
 				 <&apps_smmu 0x481 0>;
 
 			qcom,ee = <0>;
+			qcom,num-ees = <4>;
+			num-channels = <20>;
 			qcom,controlled-remotely;
 		};
 

-- 
2.47.2


