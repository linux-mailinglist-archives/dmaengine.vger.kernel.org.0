Return-Path: <dmaengine+bounces-4441-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC93A32CE0
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 18:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14C0188A193
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 17:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C54261587;
	Wed, 12 Feb 2025 17:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AK/CMOyD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D08261364
	for <dmaengine@vger.kernel.org>; Wed, 12 Feb 2025 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379867; cv=none; b=QoIak4SYS20wKiLRHMjmOJv5g5vjkOYCXFLYCa0iVw8fYubKZRwYCGXwvO0u4kRqEQYB4vWxJKyMPF6QnqzOvn1A3uV31M+e7DrOufhnX5fwYKNGjjLx+QEWm4zGJDYeDli1GYO2YE+SonqhVY7zsd7IHo9oh4KNrO4FIQHB8sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379867; c=relaxed/simple;
	bh=75avUCDFzU7VeEjRm5mXzklFEoM13F5FbLiujKtYn8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WPwZJpe/ymSj4/p2+dwEvk8w7yFMOPYossZN9+IbxUJVLoH7Ze2EdIj5b7uY07ehPd1zYSne3Uza7VWubHvJMPty+i1z2BK8nhxMG1mXdYnsU7wE/8HN426ZjHPIqPkvJnPZSBUIOG9sii04pw6CT1QXwLW/XfWa8HqI8RscWaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AK/CMOyD; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5deb956aa5eso762052a12.2
        for <dmaengine@vger.kernel.org>; Wed, 12 Feb 2025 09:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739379863; x=1739984663; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EdKs3PqjzG7VzXlZTliJiBHpYVpLmHoLigdOAH1jHUA=;
        b=AK/CMOyDspRGKpErBhsx0x9jrTAGA3yTTLt7nv3f+Fx2CyIPJ8DHxEoqmLc5K1hGKZ
         7xM5cV+T1dpMq+lEh3xbbIJDdeBsBw98IBI7YElHf08W/M/gTDDBcZwPRZfCGPMqgwKS
         5RWMre8Xn6+4kv6HflxGMaHOzPQAZdr+ZFOjVIarO1+dsjl2eT/KrMBwUfvNbXM8bhYp
         f5532u0xDJZrRL2tFFzo0qaTgT4tn381+/zK3aBfc1QTsRJzfxK6uhQLiTFZ9TRHV4Ge
         UTRpH41YuCwEiFoaHMdB3Hao8rfmhuzp7697rEOeP8LuVkiX0Q/6gC7DItrxry0BAnV1
         QLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739379863; x=1739984663;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdKs3PqjzG7VzXlZTliJiBHpYVpLmHoLigdOAH1jHUA=;
        b=w/fOuNqsNHCNPEWPIPFtRMoGbSKyxLEgY7CBeyRnr2C46PT2MupDRhL09WNbAx9jGI
         0w/vQG/Ea2fVYDKwOzCcQ1GfjhhjgFdZWYse/hKGrbNS4Og72O2FZYtJcHs4V+nSwyQT
         kMD7I8V+VU6RZ0pXD0GtWNizlhPMbPl3TM5acDtLOSg8dvcL//r5Kpwmr2YlYOC2XbPj
         kGiJh6XTpkxQg5liAZzU4xCx/g9R7I2jdmHnFzBe7QrkZ4DuR+Sl8eOYhaPV5hrZzCaS
         +FhPmVv35qZahlZ690HSiL65K4H+MltSyIXyhaxpo+joWIK2xTGR6hXLUZNDlmvYeTCT
         A+yQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5O85nj0N7AZ39p0kADLugBztuMLfSmNvSTi+krBXE1PqCyr9oXUjtuGNp9rjY/nOuR2vAoucZ0b0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp2TaEBbFzBHJZjVa8zZBEtKoU7afC9ZV+wBCwb3a+Q8WztZNP
	QTR78FD2eVC3Mr32321OtS4Vp5biCMMVBPg4/o9oX/UR6i9LZtJxhSdGgyCtQMY=
X-Gm-Gg: ASbGncs7rm6ftkD9TzYGNRH2j953f2urvDpcjJtE2VHT8xc+rrBIdPQ50i1P38Ac9Td
	IWSw/dEx8XjaTAma7WqLNr8PtnwvIiFD6l8y4Fw+WMDMrcEHL2o8CEGmjT2/ut3WxzLaA+rjU4Z
	1VzwCH5Gr+ByE9Vv1FBOkgD7boajfXrRxwylshF2Y3IKbrbrhF1zroL0nXhERBiZqPqULUBkPQP
	SxYQp8//nco5nSeMxgh9/9tjU6zZRipoeOc3zC1UxaU030H3xwGEAVH8CXiU4K/RLrWLbkvmf+w
	dFdDXTxabkCA7u0D8bLs3HOZdM5g
X-Google-Smtp-Source: AGHT+IEbKqXhYNAGULvZAeRYgXuqy5Tc0W6a9RU0CYtO1rrnjvygarfucO6BvycCtWQunp05lZe0WQ==
X-Received: by 2002:a05:6402:518c:b0:5dc:d8d2:e38f with SMTP id 4fb4d7f45d1cf-5deadde71e1mr9275663a12.31.1739379863190;
        Wed, 12 Feb 2025 09:04:23 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:52e8:f77:3aca:520e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5deb9f6e46bsm819230a12.71.2025.02.12.09.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:04:22 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 12 Feb 2025 18:03:52 +0100
Subject: [PATCH 6/8] arm64: dts: qcom: ipq9574: Add missing properties for
 cryptobam
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-bam-dma-fixes-v1-6-f560889e65d8@linaro.org>
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
Tested-by: Md Sadre Alam <quic_mdalam@quicinc.com>
Fixes: ffadc79ed99f ("arm64: dts: qcom: ipq9574: Enable crypto nodes")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 9422900289725774da8cfea9848529891038e57a..3c02351fbb156a314b7911def3caeff0c14b92e4 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -378,6 +378,8 @@ cryptobam: dma-controller@704000 {
 			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
 			qcom,ee = <1>;
+			qcom,num-ees = <4>;
+			num-channels = <16>;
 			qcom,controlled-remotely;
 		};
 

-- 
2.47.2


