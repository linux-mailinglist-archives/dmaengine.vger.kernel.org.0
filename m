Return-Path: <dmaengine+bounces-4436-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3B6A32CCF
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 18:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3A6169BDF
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 17:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2315E25A353;
	Wed, 12 Feb 2025 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UgwFRpdV"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2671E250BF1
	for <dmaengine@vger.kernel.org>; Wed, 12 Feb 2025 17:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379858; cv=none; b=dKNLUVeABhMbArC7JaG2F5ZY73DheZ44BCs3ZtAs3H+WEs7abho9e3xK1nQppfnsH0exlVRi7vzIstUUtvj7I1aPcObkVCGgmLJ/399uxd5usJRzpTax3w6vk+iy4eh1iBUg7PQ6xjaczdn+uETUZhnPeqNhDyIAKKiOtcmp/0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379858; c=relaxed/simple;
	bh=dZLTyL5Jo0WkWOgkozlRifcSGo0Fs8OvFcrqWNfJV38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=InCglb/nj/25o/11tZ4brz605JFEQgSzJSNxH6HPMMT1ZL/2rO7DlwS0+cJjKOPg7Vwk+CVxqiFtpeTn6PLRTSIPEz0bmzbxYlgspZeWlT6euT2pUnxAcveAqXOXcvNkM3JelEWFm0umx5HdBt7i6DSOim51rcWzBPTmjLrqvtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UgwFRpdV; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5de849a0b6cso6564586a12.2
        for <dmaengine@vger.kernel.org>; Wed, 12 Feb 2025 09:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739379853; x=1739984653; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ETufHHcSLBOiDs8I75mjKcj7p1SMnmX1pv07/8BkWg=;
        b=UgwFRpdVKXzwykkCaLhWewusSn8fdYBELWyhwcRhDY5nIn9PvPSlK/zhOqRo4oU9iR
         iyPqEQLgttcojQbcAjWRDFgfaBh9+R954FNkfK3mNzSOcQDs0MzHctj9jq6990hEb1mB
         cq6xOF9W9kKdXk5wHPQaz+Guizt937aG4m7fx21/4jS+Vg30tYm+wTYSzhPFhXo56Hsp
         nt5hJQdjFAGjMo8EziIzgni4dDaox/5yM+xMnRWVp95QNRgws/7P/XjeI8qvDFDI0vzU
         DyYQJhC2QVnBXcQ3DUtX0mcPEtqYyB8t2Hi8niMfoo4SKDOeJhLPO8SMvGHxPPZjX4TY
         HDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739379853; x=1739984653;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ETufHHcSLBOiDs8I75mjKcj7p1SMnmX1pv07/8BkWg=;
        b=LRJQNiCsup+j/tiPZKB5/IjYHDDvBkNRXsu5Gln0oyDeuM/M8/pPklUPGQgLQLJJpR
         Ck+wGZZAYre/wK4ZnkfJirJQfeFsPDw6X0kWkqcQctPnjHlUdwCrGo8PvjPb9FTuIRfp
         3pquIIQd5+nd7P0OvAvK0EsDwJ7E1OY7uPvmaAKU3/tDuwWpEjKO9adZu3zBdnUIwcAn
         orhQumPej6O7r9aKKtHmc0P4TA1+lEDviIKvlNx00lDAG3o8KI46AuPvm1CqTt199ezm
         YCHQ5epZ3m8a+3Vp2dM+Lq7SIBfwrU2Z2b2NjtpB5Fmy7ogycsj6LoVT2SjeuHFTpKs+
         m+9A==
X-Forwarded-Encrypted: i=1; AJvYcCX7Vz9/LKMawbly4BcWQL+kHjLH/hxS0zDlk1tfetDWrP9oyW+VhycxSTk5dG8oZ25tds8TqqrN4bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXaiLanz/Jx0ujgVShPz7SYdxRy/bW+zpAMVUea32cuvETQfMD
	UmoG4hgZhAqlI1t7LB5Jd5PKUvyYjk1UQ4A3QgmV9MzIeLHZW0DC3Sh9z0KAZek=
X-Gm-Gg: ASbGnctk0P6/6NAnay0L9V4QGFDqeOu63+gvZ6OtnqAYpQ4l86RS+eIBQBb4a06tdYF
	uYlajlMzIYSeCHfaWkU+kfOqtbi3UHYD0mRovMvOW2cYg7ypGEfF4v5g8sFyzCXh+lr2tALKLA0
	gdLBNaMDvY42uEe1Z/Uvj6c+XvZll4Z4a87jCkrPV06+/YKMFmK06LHr2Y9TwhZXDgp/hCRRiCK
	jBb2RD4c9EVy3ZeTYsB5x/9M8v7pHFMcgEtyCP4qC6hVp151jhOJLA8QjRpyUKGQaJBKtiF+wnA
	tzJX1txm9A9KcAGP8z264lJ9bJI0
X-Google-Smtp-Source: AGHT+IFgv3L3zsor+TgyfP78cIeIu8na03bo/tdai+ppenHCk0PSZruKWml8PrAfOHPg+AysJiSwag==
X-Received: by 2002:a05:6402:2089:b0:5dc:88fe:dcd1 with SMTP id 4fb4d7f45d1cf-5deadd7fdbbmr3639946a12.12.1739379853331;
        Wed, 12 Feb 2025 09:04:13 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:52e8:f77:3aca:520e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5deb9f6e46bsm819230a12.71.2025.02.12.09.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:04:12 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 12 Feb 2025 18:03:47 +0100
Subject: [PATCH 1/8] arm64: dts: qcom: sm8350: Reenable crypto & cryptobam
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-bam-dma-fixes-v1-1-f560889e65d8@linaro.org>
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

From: Luca Weiss <luca.weiss@fairphone.com>

When num-channels and qcom,num-ees is not provided in devicetree, the
driver will try to read these values from the registers during probe but
this fails if the interconnect is not on and then crashes the system.

So we can provide these properties in devicetree (queried after patching
BAM driver to enable the necessary interconnect) so we can probe
cryptobam without reading registers and then also use the QCE as
expected.

Fixes: 4d29db204361 ("arm64: dts: qcom: sm8350: fix BAM DMA crash and reboot")
Fixes: f1040a7fe8f0 ("arm64: dts: qcom: sm8350: Add Crypto Engine support")
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
Luca sent this patch before, but it was never applied:
https://lore.kernel.org/linux-arm-msm/20240108-sm8350-qce-v1-1-b7d586ff38af@fairphone.com/
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 69da30f35baaab67e51afcbca3486fb89c14f281..5f93cae01b060cf99c0de56f603e860aeebc5f67 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1806,11 +1806,11 @@ cryptobam: dma-controller@1dc4000 {
 			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
 			qcom,ee = <0>;
+			qcom,num-ees = <4>;
+			num-channels = <16>;
 			qcom,controlled-remotely;
 			iommus = <&apps_smmu 0x594 0x0011>,
 				 <&apps_smmu 0x596 0x0011>;
-			/* FIXME: Probing BAM DMA causes some abort and system hang */
-			status = "fail";
 		};
 
 		crypto: crypto@1dfa000 {
@@ -1822,8 +1822,6 @@ crypto: crypto@1dfa000 {
 				 <&apps_smmu 0x596 0x0011>;
 			interconnects = <&aggre2_noc MASTER_CRYPTO 0 &mc_virt SLAVE_EBI1 0>;
 			interconnect-names = "memory";
-			/* FIXME: dependency BAM DMA is disabled */
-			status = "disabled";
 		};
 
 		ipa: ipa@1e40000 {

-- 
2.47.2


