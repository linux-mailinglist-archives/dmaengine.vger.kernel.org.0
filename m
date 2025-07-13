Return-Path: <dmaengine+bounces-5782-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AB9B02F9F
	for <lists+dmaengine@lfdr.de>; Sun, 13 Jul 2025 10:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35F117418B
	for <lists+dmaengine@lfdr.de>; Sun, 13 Jul 2025 08:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B911F30BB;
	Sun, 13 Jul 2025 08:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="rt+sHqQP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E56D1EB193
	for <dmaengine@vger.kernel.org>; Sun, 13 Jul 2025 08:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752394073; cv=none; b=utL6GQEjiyFOlUJITtt8rdkHQRE/HAIyIYDSwxKaKovWoLw7ZeiyY4fKluhH+0V6+qWnp/690ThVDBGswKaPwxczV/aB88x3AkXOZDDqYa8EAbmBOkSNhDaMRFdhsOAaJxr4oZW4JNxcaVWT6tC8/wKscF76lFjdZGf2StTw50k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752394073; c=relaxed/simple;
	bh=DMp52hjvQJeToXn5ideaGQ3795khbQZVtSdtbMOEerA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AIzXcJGUdbR/+BMzZyGoKzKIVByJawJdc54ryeklIKb6EmYK+cvvIwNHam0fS1MIF4eSEmWx1rMegSCbnma46sisL2W2mP7Wa1cNncnrd4g4waH+DRX1jAuKQTIZuUwqdhzcntuVivt1caSgUv3ZfWaWlLoouLvHms3DonGTl8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=rt+sHqQP; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a6d1369d4eso1914869f8f.2
        for <dmaengine@vger.kernel.org>; Sun, 13 Jul 2025 01:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752394069; x=1752998869; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4SQo06CwZZ+bZ2XWolSLrsJUXJrZwysl3KLdIVv7Q+Y=;
        b=rt+sHqQPbL7q5CG+qaoS+jJe3AhOvlQP1dx2b3qHEkebGRA0vIuvEkVEDiYde71sGu
         rSECSw2ILnHKlJVyCjpBj6jinCKACGppP1w93tov3veV+/FYN1pbeSOuQH7BFcW2WwE6
         PtA/PNu0oKmxRLY6YQRg+gw30J9Z4aupn9At/k6PevB+YXXwj6SkHz0ITYGS8DHo0MJJ
         JWbtF/ULKEjd6wTtekBZQ2WPti1g/fTFizbUZYayoBjT+jUeVwZQ4BuD1R45iI723l03
         tebeHQUGrdr1Zh+z5aDYZeLondo3smy18h1R4JWNW3nupMKIyHbxsoGiO1H+f0CPPnM4
         NuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752394069; x=1752998869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SQo06CwZZ+bZ2XWolSLrsJUXJrZwysl3KLdIVv7Q+Y=;
        b=NAG1wJcg9lalwQBAX6m6wTXLtoFvxU8AtFAcyzLhsdLxrVD4Cx/5FvXedA2dJ66U8z
         4UbIk6/t27qlyvGpo/g2PPW87LPdHqxMyzSHwc5RsN2drhhJXLQ5CeRvgmnaEnbNzVma
         JQBpZUvs6GbyWqgQWvUXa8VKVW9KbmOTuLznx7Qrz3cvktvW6eFEMdwac1I+raZhaxti
         p8ApggRtLnBLHhMO2ULnJcjd1OGNFwzrfwGE3CNtJ3rzeyH0ahz7PLeTfjM8ran56qXy
         8Q+2qAftjhsP5b1MsLzGDVLo7Bmo6/8QNRVdbp2rhn9SSo+PyCzOnJzZMZ1Fn2JTB8KU
         Pinw==
X-Forwarded-Encrypted: i=1; AJvYcCWLCT4jm6f8xAixgnjlRH7KuOtXGYOho7ySQoMT2CJcVU7wX/JitpgfM3TAE+E7rwKzju+ASEVNvyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJDiEqVvIR17TQu09G/8OXaintSzsn2ft6cIKmkRNLUiWwpz3t
	XHUPkEltSwEQ6NCcmPSivMPe4uYnX5RB5ctm9I/cBWrgDkOzXp/6nQWTd7aoVDdOZZ0=
X-Gm-Gg: ASbGnctxDdsLUsjVjB6NG5kud2Ludezo7llnXs3h1jxcvkDbxxRRh3gmaCjlbb8OPoJ
	bfxR1a9pf+FuzTG3LabEG7JVFV7iahnPGPTj2BkRX/6FYgKXcC1Cj9w32trfpJn0ZypxEs0gx/o
	tDbP+fJdcoLuu7FeC9DLUEzjKorhfE76iE3+QZEAVES/1DOJ5RhGhRAVPZuliE4y99bXIfkRNXl
	VGY+hogZe4kDgyWxUD2F/T1UcgvupLD6dqq2/8YeDpNYcgGLIREQBBWu4zk2agIQfagWspHxdmT
	fMvPw0rBhFqmzP8S3iAPu0Z+V1OHfEHgLmIBdJqZkGCKnzcuASxD07U70qBRxHiPrCgM7OyWDtj
	EB1I+PmbraU5IhzCaXEIrrJFAXESAMCw4PHKp
X-Google-Smtp-Source: AGHT+IHS2sHqpL2/eZHUmAy8MZC5zOfAiyOO2INQCZr8EwbUKzOMR7kfyYk7nmZApin+IuOyVWkYMw==
X-Received: by 2002:a05:6000:40cf:b0:3a6:f2da:7fe5 with SMTP id ffacd0b85a97d-3b5f359996cmr6132510f8f.55.1752394069433;
        Sun, 13 Jul 2025 01:07:49 -0700 (PDT)
Received: from [192.168.224.50] ([213.208.155.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc22a8sm9386608f8f.34.2025.07.13.01.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 01:07:49 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Sun, 13 Jul 2025 10:05:33 +0200
Subject: [PATCH v2 11/15] dt-bindings: soc: qcom: qcom,pmic-glink: document
 Milos compatible
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-sm7635-fp6-initial-v2-11-e8f9a789505b@fairphone.com>
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
In-Reply-To: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752393945; l=913;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=DMp52hjvQJeToXn5ideaGQ3795khbQZVtSdtbMOEerA=;
 b=2eut1D91kUWr+UGFcP8InACFwKyZfGSbIzuWVeP5xkcguaoH4DRmEvY3vHIxpLqdLQJKX+0r2
 KfHKbW+PBgpAlCoAY9hPuWiP349REQ62oa0RFzX6yRzG0QgrVbKKlFK
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the Milos compatible used to describe the pmic glink on this
SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
index 4c9e78f29523e3d77aacb4299f64ab96f9b1a831..48114bb0c9276c9326db3256401a3ecaa8b3b9fe 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
@@ -37,6 +37,7 @@ properties:
           - const: qcom,pmic-glink
       - items:
           - enum:
+              - qcom,milos-pmic-glink
               - qcom,sm8650-pmic-glink
               - qcom,sm8750-pmic-glink
               - qcom,x1e80100-pmic-glink

-- 
2.50.1


