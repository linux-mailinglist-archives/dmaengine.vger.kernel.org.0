Return-Path: <dmaengine+bounces-4435-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7CEA32CBE
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 18:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398C03AB2D0
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 17:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA469256C70;
	Wed, 12 Feb 2025 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dDJ1sID2"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858C821148A
	for <dmaengine@vger.kernel.org>; Wed, 12 Feb 2025 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379855; cv=none; b=MGAaD6hUkLbQP91qmtNOXrGko3Lcymv394FXxYaiWgD8xcRfHc3QZkA4pRKWDVLBOE3N907Dh5BZBXAKM8IB6Aw9o24H7y2Mhb6mI5X5exSMRvOHf65kDbp8wcjim8JzNEzFrQCGDGkkdp6v7AHAUEAPwtKhLm/icNCG+pPivtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379855; c=relaxed/simple;
	bh=btRO2rOJup/wmjNa0o3QQGaXrKePyDSWMf40JjUiMBI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PDvoM1+M3i7O/vfmXuYfXFRGmrJYjHjxDTuW3X382ywvkAnEYpecO7OKpmGDHLGwfOz1pmKtsvbPEq0jRwy7etnrvfAFXj9oNTJY49jAqqNzc35lymk+gm5rxDjyq7b+6WoiWhO1yoQxzv/Z+LMIqZZtw4J6LRjocAnyanarvL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dDJ1sID2; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5deb0d6787cso1437257a12.0
        for <dmaengine@vger.kernel.org>; Wed, 12 Feb 2025 09:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739379852; x=1739984652; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lOdSsrVkTURNY/Q7FQn0+ahIqRzchEXyI5DDymGy/g0=;
        b=dDJ1sID2FdBD2F6vx8DMajuhzvKU4vW3GDohexS5/N1zL5cngjYqreHtAsOm2ptJQL
         pXfTyYsbZMi991ESNA1yGZcyRaKDcEnkpZhczFMtfQqvDbFVvx9KsoD96/7MA9rJT+bZ
         MFRs0Wuq/nS7Duiy+Li7cmwTPe6uz/jxglsmYI9LBQ+QTKO/pz2f2yMs+semI9cfnu4U
         j47UogTDVyIO8/RB7y3mCF2FcEbfvexaZJwMAZAFYu2TQuKnFdkOyzEX1axXDvur6bk9
         V/qisDy4C6oD0OgINrmORsGbAi/sbX4xmXkz/t+H0uOiXUaGIrK1hsBHZFU6YA090G+8
         P4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739379852; x=1739984652;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lOdSsrVkTURNY/Q7FQn0+ahIqRzchEXyI5DDymGy/g0=;
        b=EV8QgATIcfP+aN4gLnRb9Wnytf4/uijvUGggQAvp4ElusSdnJrsrFKNHWRNXnP3668
         ISCBQJTmJ+7Ok345cIvTMZ4X8QDXSeK9rVKZSRZgA3gvyHU2juddULXZxqjZtdPnsMK9
         oBW/ehOUC3vxEU03ZctOanhk86hVOF8lWzGrHXPjNsf2DIC1E+cNGzF7YfR7Oc/e9xOE
         uzoadF4DTsfdJwMRuBETklPIwqxA3yOCkp2CCsbQ08NEhwQOFHm6c5sH+EOA4DSj28Iq
         nPWPMppbeN0CcVRktL3YUWd2QcHD1RhwL149oY/2rLs2ZFicRnYzebeSdWG9/12YShwe
         Ejiw==
X-Forwarded-Encrypted: i=1; AJvYcCU2XrGeYXJa/WfLpg2k7I9HyjJHi3XOSgLkxTYFbO4iE0clYWUsnztuPX6CEit3RJYev2b2Awv/VcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnutyuXlR1pFUP5xmK/4wIwdpDQf22x7YMOBKJcq+bjs3Wv2FB
	+59gH/1IvRWeEz68nXwhAVykk4pu2r8K8kXcVJtBQQ4EuIldNCOwuKfAqL7ZaJI=
X-Gm-Gg: ASbGncuXYN5MQUcPyi6FbqpXs7tBG3K1m2M2Wz2ZAC71TMFf5oqnwlc2K5QcKWQwgbq
	tFk9lgjsuQXI5KI3zH6P8n78TgcfIdDuK9k+rRNCcLqtEL//8xPJKO+Ln4EoIx32YdVY96JHGHG
	DaLti2GB+dmOP46WTyUn6PoEQPuDPIoXqO6oEuvmPIWqJTC9oQ4uFxFVhX291/RWh6dZmjV92e4
	21B6+BHJ6vy6O8gk7jb9dhhCBfMpzUooI31uCuv6SSchl47TiI2jgT7MVq7rgjaM9mLxKeha2LQ
	da2rYP8m3Xc6Y5ZrNFmZw0pqwKlQ
X-Google-Smtp-Source: AGHT+IEQEtIiwT19pSZM69pmOEInJBgSECAuQB4A0NcaYOGmILP2pTTU6UgWdVc9CPww0WfLyZjaUQ==
X-Received: by 2002:a05:6402:4403:b0:5db:f4fc:8a0c with SMTP id 4fb4d7f45d1cf-5deade0fe18mr3056067a12.21.1739379851631;
        Wed, 12 Feb 2025 09:04:11 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:52e8:f77:3aca:520e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5deb9f6e46bsm819230a12.71.2025.02.12.09.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:04:10 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: [PATCH 0/8] dmaengine: qcom: bam_dma: Fix DT error handling for
 num-channels/ees
Date: Wed, 12 Feb 2025 18:03:46 +0100
Message-Id: <20250212-bam-dma-fixes-v1-0-f560889e65d8@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHLUrGcC/x3LQQqAIBBA0avIrBtQMYmuEi1Mx5qFFgoRSHdPW
 j4+v0GlwlRhFg0K3Vz5zB1qEOAPl3dCDt2gpR6llgY3lzAkh5EfqqhI2qid9UZN0J+r0B/6sqz
 v+wGlHPoaXwAAAA==
X-Change-ID: 20250204-bam-dma-fixes-1e06f2a6c418
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

The bam_dma driver has always printed an error to the kernel log in these
situations, but that was not enough to prevent people from upstreaming
patches without the required properties.

To prevent these situations in the future, enforce the presence of the
properties in both driver and schema and add the missing properties to the
affected platforms.

[1]: https://lore.kernel.org/r/CY01EKQVWE36.B9X5TDXAREPF@fairphone.com/
[2]: https://lore.kernel.org/r/20230626145959.646747-1-krzysztof.kozlowski@linaro.org/

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
Luca Weiss (1):
      arm64: dts: qcom: sm8350: Reenable crypto & cryptobam

Stephan Gerhold (7):
      arm64: dts: qcom: sm8450: Add missing properties for cryptobam
      arm64: dts: qcom: sm8550: Add missing properties for cryptobam
      arm64: dts: qcom: sm8650: Add missing properties for cryptobam
      arm64: dts: qcom: sa8775p: Add missing properties for cryptobam
      arm64: dts: qcom: ipq9574: Add missing properties for cryptobam
      dt-bindings: dma: qcom: bam-dma: Add missing required properties
      dmaengine: qcom: bam_dma: Fix DT error handling for num-channels/ees

 Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 4 ++++
 arch/arm64/boot/dts/qcom/ipq9574.dtsi                   | 2 ++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi                   | 2 ++
 arch/arm64/boot/dts/qcom/sm8350.dtsi                    | 6 ++----
 arch/arm64/boot/dts/qcom/sm8450.dtsi                    | 2 ++
 arch/arm64/boot/dts/qcom/sm8550.dtsi                    | 2 ++
 arch/arm64/boot/dts/qcom/sm8650.dtsi                    | 2 ++
 drivers/dma/qcom/bam_dma.c                              | 8 ++++++--
 8 files changed, 22 insertions(+), 6 deletions(-)
---
base-commit: c674aa7c289e51659e40dda0f954886ef7f80042
change-id: 20250204-bam-dma-fixes-1e06f2a6c418

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>


