Return-Path: <dmaengine+bounces-4442-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF8CA32CE5
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 18:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF383A1BF7
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 17:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7802627FD;
	Wed, 12 Feb 2025 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FfwEZOHQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E07726157C
	for <dmaengine@vger.kernel.org>; Wed, 12 Feb 2025 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379869; cv=none; b=XBYrWfERhWKVHn9IgYDPLlRuBBpkiAD7vXbgcd1uUHewq+FV2K+FOa62+S0kodFzrAhRvhlVje/Imc6NfH+OSoUB1IhLM7L40sBw++rOQCxpPtZZQuAsswqFgNNBgkNXLllozK2pHotlCzDZaFidFlnuMy/ChL1t1TW5A2AmOLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379869; c=relaxed/simple;
	bh=gm/du2YybA38W7YJqV/I0UhkP/ii9HBt6Lhq0K+G8zk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jkb4znKZOFnrXRmSartNZbZOC5gxgQffGOv9DQjfTptlBDPVvb3OYFN+EXHKhxwLZjJjmFQPvH8DI08clrVfsllSmsYU9mfWGW1vbGE6WbOd05y20jNQeTwxWWXOxPTQBieByncEP+WTcvN4HDLxFyJB6Rdvj1vde74vLOMEtcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FfwEZOHQ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5de6069ceb5so1862703a12.1
        for <dmaengine@vger.kernel.org>; Wed, 12 Feb 2025 09:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739379865; x=1739984665; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ImRVu3AddUI/G7N8wE6yWqCv2pDeO8zZgPLOwwAUrbQ=;
        b=FfwEZOHQ5WfoIzMz/vMtt3jhfvrybbKssShql2Z4raVq2oeUWvBNQSNgbwv8X2DRot
         d8rWvrXbZXXdae5XZ54YlP/7cDZ5EZZ0Nh9vgbPYmML7xL/qj4NXuwOWzzePKX5HAQpb
         RGgGN2JILGHceifqelmt5Z8K5wMthd5g12gW9HpyLScSkrUp2FnNoizA/fMAfh8eVQx6
         yeE4+bS9RsFDvYknZ9YB4lavp2FRqqWZvpABG4fWWUXMnn7IlfLGkkpiTV3kCL8y97Zn
         08GiqlY526PhhQAY4nwig49fb3smD83/shfIaKAaZMxznC+WCFJvy4SPXL4F5PR5XjOk
         N+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739379865; x=1739984665;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImRVu3AddUI/G7N8wE6yWqCv2pDeO8zZgPLOwwAUrbQ=;
        b=FGg0AqVvsTQiRp3+r/FyuYXtM18JdpvKww6bj3nor4CPaZe5mFIkZrJ6JsiOXceuNc
         /SYN3y94oC2qgzAIQHfaxqe0m45PR2yhfsLaTSakI/pfOB6oxiXHeIPzUsFIU6mWf0V/
         rlZ7xKsmzyhaPnAwhyJUEsGbB9ex80WKQfIijH+ZWTsdfr7zN1D3qZrPnixqvkIcXwmy
         XihuA3fg+PDMze7yYDxqU8uA473cSlvOSyVQ4hCTpmV3gRe7w0xJzy/15JNupwMcPACc
         XraLCC5ArEyiHg0Joyn3VV+oIFBR61qOlHIVxMzn0bN8nmpIkPMAN+0y7fFrZ3IXp0Ll
         nkHg==
X-Forwarded-Encrypted: i=1; AJvYcCWmx4xIwBoj3ElSJq4fAnNUVyOChCGsR9M3yMxM48slXMUaM12tXS4dQeXnygqcJ3b8irPw310FzDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHNXAsfS09Xslc8zLcWzD8StqM8iI4HWL1BRKRUyHW9zyDLYzV
	wdbQnETLunLXidkhDCUD15ELCRYIb7g86yJyrR4le+4qw4Vvp+3rqOTdIZ9fOl4=
X-Gm-Gg: ASbGnct7MM1puyPTPTaRn11BMaR392Se5gJekBchnL/TEq/muUBkRdX19JkNLfDgp4m
	0SDDuoqKWw7/BnabCaOty1UkQDlCWTXm/eNxqXYyfHohdLNZkHF5eRnBk2GI5A7mcvemX/3Z2t+
	+DFQOPsq1SZrkbYXPH4U8DZwSOLDcMy4iyA1BtdUWK5KwVgkl90rYSqmlDqi4Y3Nlm5+l4DKhWk
	X6LW02mvatXTgSO74VVIdWuLSOumIzozv+FdCVH8oiM/wNel0sXJrJK0KbJ2l3INltFBkikDi/8
	ansA8obHIAv1nzy7/y1rzh6kjQD7
X-Google-Smtp-Source: AGHT+IHcYXuecofg3yiMP0NUjYpDinedFykVXcImtUN6fTzgyJOzlkYtZX415Z33x8WimpPahFb58w==
X-Received: by 2002:a05:6402:2755:b0:5de:5939:6c34 with SMTP id 4fb4d7f45d1cf-5dec9950b77mr20409a12.15.1739379865117;
        Wed, 12 Feb 2025 09:04:25 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:52e8:f77:3aca:520e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5deb9f6e46bsm819230a12.71.2025.02.12.09.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:04:24 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 12 Feb 2025 18:03:53 +0100
Subject: [PATCH 7/8] dt-bindings: dma: qcom: bam-dma: Add missing required
 properties
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-bam-dma-fixes-v1-7-f560889e65d8@linaro.org>
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

num-channels and qcom,num-ees are required when there are no clocks
specified in the device tree, because we have no reliable way to read them
from the hardware registers if we cannot ensure the BAM hardware is up when
the device is being probed.

This has often been forgotten when adding new SoC device trees, so make
this clear by describing this requirement in the schema.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
index 3ad0d9b1fbc5e4f83dd316d1ad79773c288748ba..5f7e7763615578717651014cfd52745ea2132115 100644
--- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
@@ -90,8 +90,12 @@ required:
 anyOf:
   - required:
       - qcom,powered-remotely
+      - num-channels
+      - qcom,num-ees
   - required:
       - qcom,controlled-remotely
+      - num-channels
+      - qcom,num-ees
   - required:
       - clocks
       - clock-names

-- 
2.47.2


