Return-Path: <dmaengine+bounces-4437-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47454A32CDA
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 18:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A05BC16A680
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 17:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A1C25D52F;
	Wed, 12 Feb 2025 17:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fplOecLa"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD00225A333
	for <dmaengine@vger.kernel.org>; Wed, 12 Feb 2025 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379859; cv=none; b=mPmrE31ju8+wOm6cwWS0CrrtNwHHHlqKpXPDtJoAcA2TArlO8uuH+DtJ6HJDcoQ0LTAVH/ei7c7jTM5SN4pVgqgRq3+d+b8KL4mVMTz87XbPC1C7mNUk23NMb0r/4Q3v/4xmM2GYGSXRhD1RzVBOF07Ni9ja6Lkf3OgYjMl0u00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379859; c=relaxed/simple;
	bh=sItJi983hvl01AxWCTmMFX7g70a0Fg4QZpXz/Tz/yyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C1bformVZHJh6uAHa6E7Ow3vsEk8Nex/FlUrnD+QAL2no+TovFaTCcs6WXaHTKgq95wFiI6CYwx8BoDxsfFNO9UXLRc5HNH2ZZwuEQ8nH5pQ/pCxoyEuPYvf+QjrhHBrNQiS1h8bB38JTdCXCwY7EPnTnj8SUO+dx8ks+oii6bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fplOecLa; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5de51a735acso10279544a12.0
        for <dmaengine@vger.kernel.org>; Wed, 12 Feb 2025 09:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739379856; x=1739984656; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S6w5okXU2Yu7jFnBUo43BoM84SGqbG4jaCw++xQVChE=;
        b=fplOecLazFKo5bPFXcwrIqQPAKwTv/hZFpxZ3qpbztC1+19mMbHK2yFc9WbbDYe6ET
         nVv2e+6D9DuF8iYMYSAxCSn/+K7FkrhohfbI8R1ZB09JmdhREq+uNQG6asRfeB5jYh/R
         J+/O33zB22fnrkfnKzU0nYNvaA4t5FsRiE7uN6r2KtUFu6E5ep0JGhidgUksXKaX3ooF
         +6HzAoeAOFLQ0qAFQ8YyuRiHkQTRm496czah6qCk9eTAO8m8wW1gI4sW4WJr1RwIP3Gx
         Sd3sHqk/+hdVd6wIigKkkemT2eCMZZfsWf5jPlJ6LBsfXRPK/k3/hJMUk3yD2IN/i7aP
         HHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739379856; x=1739984656;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6w5okXU2Yu7jFnBUo43BoM84SGqbG4jaCw++xQVChE=;
        b=WUOdmFNpmMzdPaDiIXBFcd0tQaavWazCo4sb6pj0XFIxabppGam6+KmGnifULY3r2z
         TpzTGEnbqYTZEeNomEt9rOQrAtcCnukaMamZP3jgxCXZA0NXG/3nzqLPm3bwIqg7fRKU
         eie0ipD4orzLCSBTf0ot59xL+hEGa2WrcH/SW//f8ao+z2BT74Mnrk2O1cLDFbcsMdhy
         TU8zCfHcdFUvmPX69E26uPCxyfMtZJQS/gNj7uwYUwbdbR/IDTe8/uHcJCnfn0nh4B6A
         WAcunkfvBxsZ4Tp31Qa9aJquPt/Bb3Jzso3GD1um8mppa+h7C96+8xVxYTabjd+BYiL9
         hOrw==
X-Forwarded-Encrypted: i=1; AJvYcCWloYZawVYiS0t0yFCWYXjynrrGUAPf1VdYQUU/+Dg1+CltwgtLUvcw4Dpf1mG/UP+5d4wc+Lx5NoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwILGNvhDzT0AdikXy0p+Kg93jqfPPthnu4jh8t8A0OWmnVj7q8
	B9i5xH2lUDbpYQ2clgN4pmAtvu8D7DohhmFGRlanEAt4oiugfrfdG6lFRDP56AE=
X-Gm-Gg: ASbGnctiWfIyVc9IrwOCT2JkLahkKd7GiazP++T9nYDi/wzQh2OiIrLf+znp/3z83bN
	gSwMwtudoqNe+HDWu/iJwfDw6Y1PObafEj95LpTv1QMYv0sv66p+mNngrBUopkXIAYtgGiVXITJ
	SDejE9W00A6WhUbYoOBc7/8nMRWQUAFtWMRwQjCk6H8YEXQMKD8/MOhUH2i+U4QhSCyaqYI3s4E
	uYFDzQslRVr86TOErv4+x3YHoxngO93893Oa5FOZEmRQFm4UVkwr3hZj7+SHUkRfnzLWkxMNRpu
	ofxzQev28ol8GaA7HAwewtd8deQC
X-Google-Smtp-Source: AGHT+IEABcOOIELXz+JFdeOSsPBTKQScoxzR7QmtBueg1gF7h6+a32NeKWZuRnmzY2n57dt66bqjMQ==
X-Received: by 2002:a05:6402:26cf:b0:5de:42f5:817b with SMTP id 4fb4d7f45d1cf-5deade15403mr3357122a12.31.1739379854662;
        Wed, 12 Feb 2025 09:04:14 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:52e8:f77:3aca:520e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5deb9f6e46bsm819230a12.71.2025.02.12.09.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:04:14 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 12 Feb 2025 18:03:48 +0100
Subject: [PATCH 2/8] arm64: dts: qcom: sm8450: Add missing properties for
 cryptobam
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-bam-dma-fixes-v1-2-f560889e65d8@linaro.org>
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
Fixes: b92b0d2f7582 ("arm64: dts: qcom: sm8450: add crypto nodes")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 9c809fc5fa45a98ff5441a0b6809931588897243..419df72cd04b0c328756fdc484f4e46b6c325412 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -5283,6 +5283,8 @@ cryptobam: dma-controller@1dc4000 {
 			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
 			qcom,ee = <0>;
+			qcom,num-ees = <4>;
+			num-channels = <16>;
 			qcom,controlled-remotely;
 			iommus = <&apps_smmu 0x584 0x11>,
 				 <&apps_smmu 0x588 0x0>,

-- 
2.47.2


