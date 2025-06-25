Return-Path: <dmaengine+bounces-5624-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E75CAE7D4B
	for <lists+dmaengine@lfdr.de>; Wed, 25 Jun 2025 11:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 387741885111
	for <lists+dmaengine@lfdr.de>; Wed, 25 Jun 2025 09:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F1F2F235E;
	Wed, 25 Jun 2025 09:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="TYWShlci"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8DE2EF647
	for <dmaengine@vger.kernel.org>; Wed, 25 Jun 2025 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843408; cv=none; b=IxzkCQwsFZsa9v3G9Pig05YMWUUhe255mygH6xhLC8HBEER19JNVgYbwGpde6UAUN0fsY3J+DejGmElxosChc5WgpyjjSDII8XGhZ+DjbBlxP27E6D/fVHXFFlJhdsYRsVIYeLOkmgGCdlAXvVQR4yeIyP2kwbnREs3BoVd/75g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843408; c=relaxed/simple;
	bh=jj4FXpnaY2L8qRW5W5/06pfPaCeBVQY5CbMDnnBtNOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fxmQQsj6PRwYKRpPX0S7LoeDT7bL0rrs3rrlFXGnCG8LRRi23G2ZJuWqHTOjL40A0ji6sh1HL8XyG+SpMyUm9VmoVjXxtitdYdbsEphc57Kxa2xueM/2rMAzq3fmOkgVZzxuBinZ6KHRbM2HzrBbeVU5wE7OaX3atxdqmtUarZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=TYWShlci; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-acb5ec407b1so1057117166b.1
        for <dmaengine@vger.kernel.org>; Wed, 25 Jun 2025 02:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750843400; x=1751448200; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PueVIxrY0Lhx5OoYalpVzj7TJ+cyHwt+DTi/ni2FBMg=;
        b=TYWShlci2W5Vwl3f0oDuA0g1jKsPVsnAaplQ6wJo0q1upNo7DmpauwIWLYQWJybV1e
         MP3HQsU4RR+e+fV2MeWLKo14TBHoNVcCqw6nypUZJ9Cd4OyvYuRjV6hg046cDcCoOTNJ
         Q/Leh3Sx7qGqljcXbzOmTAWIhkUAe0vkzORj58R3RuK0OoAMVJ+97djUq9NiiVtvnfa7
         3Ecc8Em4E4DW7vERFkRl5Etwnovx12CB9z2pF3Q2JgoVTyuc9U50fcRBiS1rjFHk30F8
         otXqmlPtDZ4HqfC5rupSp75N7Oc9Npz5fAeW16UBNxeWoIMv1lWfnm8j0A9hrWE1QtTw
         zfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843400; x=1751448200;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PueVIxrY0Lhx5OoYalpVzj7TJ+cyHwt+DTi/ni2FBMg=;
        b=MUDCqI5lBYuoCUrQYvEIAOyefrKmn6qUixyU5MxOxkPnyn8EIm1e1u4ushoXQCgi1w
         eyrKWxWcBFXGB9z+XO/imzdtZQNRbaGV52sxhn24oPu7G7Z68yCBhYHmQ7kiCsOjFO+a
         1rdjmXZHBQQtATDSow3gwTaOsfXKt+/SWtm+uXiLwxIOaB+5vMcDxyhO5f38CZOjZCkH
         6U0qVKa6B2v7otIUqfylW300pXVE3ZfEEm6w9fXwkjqxH+BJ4bm++xD5rfb7+QwN/nt/
         5V73N2FalmpapVLe2jxe0RPNry27YnpE05XG56cRNG4D4aSqRD4EmaTPvzrUGqOB1+8/
         GICw==
X-Forwarded-Encrypted: i=1; AJvYcCUPrC7sv8zVPvbf0KPOXRZf76yK+Yxz+qbJOdzPlCpwvogLXg25mzTWRYm2XC+51HtiJKjF9P71G60=@vger.kernel.org
X-Gm-Message-State: AOJu0YzejBzgdALjguz0FP/fcBr/21ezewdfJIP3sERKmv1JRpQ2AGy2
	ujRaj9L+CXhq4ntCoi7yoPOdDBZmqjtHvaxP3wh9C9r/ES5qLXqa9pZGNwgavxF/jKc=
X-Gm-Gg: ASbGncvoPeIiw58TrBXE0b8TDnsbWgZLoEN4dGb70mx2TCh3tPVFEvQM8aK1aJP84Hi
	OHqlCDMUPPxei4ML5OymDqn0O0UVbuZJ4aSZNKf7xqXLAzRNXQuHTjNdfHEOMS89ik4cs3g0Z/9
	4S0e85+f6/48SCBBE2RhvDaSpiQi0NSEhjgMD7UY/EM6IxIWsroNzuiAN7gFNePQa0BELThgD74
	Sz3/QYJ+ncqTUjxJVr9ykmlitk7FfiuntD5ZLyniIAZ7wBsoHxnaWFjbPUMBc8BlHt+d14mkKcA
	kJSBMQTIDEmiw5fodrnMfk2J4OI/7YKRh6yr+R4Bgq+xH5ORWlIY4XubzdHWATZto9uiT53dwPq
	u6SXFKkNMaR8S59KfR1wArQ06vHJoRPmR
X-Google-Smtp-Source: AGHT+IFufR/i6s8bQEjNP+fAneYyap2WFk8eT5JzaxB2nRH9U0X06huQYHvxc1UIF4P5JtCVtPmAUw==
X-Received: by 2002:a17:906:6a12:b0:ad8:8529:4f77 with SMTP id a640c23a62f3a-ae0bea790d5mr233626966b.38.1750843400340;
        Wed, 25 Jun 2025 02:23:20 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0aaa0a854sm270277766b.68.2025.06.25.02.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:23:19 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:23:06 +0200
Subject: [PATCH 11/14] dt-bindings: soc: qcom: qcom,pmic-glink: document
 SM7635 compatible
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-fp6-initial-v1-11-d9cd322eac1b@fairphone.com>
References: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
In-Reply-To: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Das Srinagesh <quic_gurus@quicinc.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750843387; l=920;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=jj4FXpnaY2L8qRW5W5/06pfPaCeBVQY5CbMDnnBtNOA=;
 b=QKOjYfcAGy5ZXnCmFyoCw5qgS3UKBJcYTNOrXIfiYw6DV7itFoCGZHGaadZiBNtQHiCfzjhFV
 Na8qSuO8OQ1DyaQjIxXMBvzPUgOVhYUCHVfApprHUM0Cz5utU9EaZ19
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the SM7635 compatible used to describe the pmic glink on this
platform.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
index 4c9e78f29523e3d77aacb4299f64ab96f9b1a831..2b77021b278dd9dca604cf31e39d9eca98f2aa7d 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
@@ -37,6 +37,7 @@ properties:
           - const: qcom,pmic-glink
       - items:
           - enum:
+              - qcom,sm7635-pmic-glink
               - qcom,sm8650-pmic-glink
               - qcom,sm8750-pmic-glink
               - qcom,x1e80100-pmic-glink

-- 
2.50.0


