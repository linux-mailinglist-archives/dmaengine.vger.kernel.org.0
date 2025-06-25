Return-Path: <dmaengine+bounces-5617-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31278AE7D0B
	for <lists+dmaengine@lfdr.de>; Wed, 25 Jun 2025 11:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E64226A2113
	for <lists+dmaengine@lfdr.de>; Wed, 25 Jun 2025 09:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465922E173D;
	Wed, 25 Jun 2025 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="O6GlR2UV"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99F52E06E5
	for <dmaengine@vger.kernel.org>; Wed, 25 Jun 2025 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843398; cv=none; b=t14qnmrSXzbjq7SUIVUm+R3YhSz0cfcUb+tjal/r33RWj4AfiDojDxni7E5BlZDtI7fatfmzyv20nqAhoY1cNl+Ln3DQ5fQTrvekniRMmXEoayLPeJ+w+3hP6DYDL0WNJJhJLu1lb7i/Qdqj+tRMfaw223GdU0KaAaW9bo74f/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843398; c=relaxed/simple;
	bh=uhtUa6TuWWOeZjd4JmW5ZGjrlr6PTEqwVAXpwJZmwlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dy+fU42KfIX4IhBETTycEUTfZ/9P/+QF8x446Ad1q8aYs7x790j7miUXildt6AG42CskCBSoLe391Iuft4VDeGPF6XB9mX91I7wDHJMgup3DclIZv/fmEZKvSD2zg55WR1bFYIfHoyp1mxKWWq3Kpz9EDmC0fh9Nmr6if99tFfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=O6GlR2UV; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0a0cd709bso145664366b.0
        for <dmaengine@vger.kernel.org>; Wed, 25 Jun 2025 02:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750843392; x=1751448192; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/iV2ZnPzTHx850i93QH2RHh5n0N52PnUpwC+aDpzRmE=;
        b=O6GlR2UVKmA+vRZ6sretyLcRkZH8+dnknTASGFtbFQ8CH32Vsxl9tlb17kWfAgHRfx
         wwnq0H/+GRLW7F6Q+4IGOZDQG+bPfDPY0Cj8YqWGCv84Lv8Wfw0+WSIiQO/8lXGh+ZpA
         M2zitDv40gMjsMe/6f1/hwUAwQEQk/c3m6StEJRB5qovZBcybrUanrcnAHjsJW94jL3H
         VUArGdbkMxHnJSsCCmIR1BPZdzGzHBxMz0JuGUfvDwYwdib8EzlmL/zVY7gXi2Q0XkfH
         3EcCJDszdoQhhUTXbJ0yFmxDMdjhagaStygqVmfZVifs4gmFBCPh5N+0zoUPr/VH9DA8
         U5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843392; x=1751448192;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/iV2ZnPzTHx850i93QH2RHh5n0N52PnUpwC+aDpzRmE=;
        b=LLoz86pvbNVBsi3Zj+WgOQ6DOA7ytS8NvqhnHDnPs2gypxNiOHIWXY91/SBg35xAhc
         aKZo+yeuKLV0GOKqL7FcFlRbtX8nXOgRGHAQrsZW3aAwAcJoDnCcsu5I2NpbuPYWV01N
         LUO5DDimnCQJIgjkhWCwYbaCR44qfEmm4OcJcoL8GigCIrzMWtJJ9XvHT3tqClEGXzft
         KL0bIPb0ZtwJyk58msFwVcOoa2rtjXNGWag5Jx8agKgTUazU4NHQ1mSbTkwps/qwnemm
         v96D1j87hwSyRlpUyO6h+SbHx0s2YfAMJYCJVh2/RAwdpZPoZ+ogXaj50mCshWsaXMFy
         ROeA==
X-Forwarded-Encrypted: i=1; AJvYcCVjSIh8uMHQC45jF2S+C048TPr4YfYPySYLqWhdpRA/dEs0nJ4gfeHcgfgPrkyXLLF482dpSc+E9vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC48dxgtijCNm3kuV0KkkoC0FRKdTeGqa8jWDSHuVtQPLyU20P
	i81WLODhwMKsfw4bKS3xMIW0wLhf/sNYI6B0//AO8Fvm5oAXSzKh/vZxiWj/Gdc3kfI=
X-Gm-Gg: ASbGncuibYTZH4xUayviTLguXNoGnMys3HDHWNOiaFoNslgupEq1Ot6r/p1/OD1aJWs
	WRC1hm3hnjSo9UtsbQvRvaa7dBAZJWCch0OkCfw6bObf5ZtybATpkDcm2wYokjSQSKc2rY7NgGf
	Petc0j2tk8Kigy7b5vXHGgxpomcNAOA5Bqz5u4UvrH0ZP6FCqYmig4yvIahD3O3I4x8OaG1G2Dy
	eyg4dI7tJQ3axzHa5Ss8ZEdB105askDP+oxSHLOrEDLlaT4y5R+ECAvym+B04FEChvrYSmJSQ29
	a3cx6kl5y//yElExY99/iexexuGjhTHp1709buJDJpPm4uB55eNTSPBUpYhqx9kAmdoHzymlnX5
	R74YZ8hOwI3c66hRNaJ/Z/4cOY/PMSyQV
X-Google-Smtp-Source: AGHT+IE1gc/uvw/ng78i+q8hHmGEhnihasoPg2pJuO7nZfnd78u9Q+SnvB0RXN8h+HquieGEdTPAUQ==
X-Received: by 2002:a17:907:c1c:b0:aca:95eb:12e with SMTP id a640c23a62f3a-ae0c082c6a9mr173270066b.24.1750843392378;
        Wed, 25 Jun 2025 02:23:12 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0aaa0a854sm270277766b.68.2025.06.25.02.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:23:12 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:22:59 +0200
Subject: [PATCH 04/14] dt-bindings: firmware: qcom,scm: document SM7635 SCM
 Firmware Interface
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-fp6-initial-v1-4-d9cd322eac1b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750843387; l=1077;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=uhtUa6TuWWOeZjd4JmW5ZGjrlr6PTEqwVAXpwJZmwlQ=;
 b=P52I7QLzFA0XxGiWQVSrZWCETXtQVh8QX/bEHmeiiACmOITY5bmcMCEU3Bv0O7QmN53S50sov
 SnkXYx/JOQTDQpqfdQvrqFD3cdiTSWKxRGwqgKDTvPdxi2Nq493mxam
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the SCM Firmware Interface on the SM7635 Platform.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 8cdaac8011ba499794ebc5b4291b7983c209821b..6ae7405aac658ed5c3524ffc394d845cd2f42798 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -63,6 +63,7 @@ properties:
           - qcom,scm-sm6350
           - qcom,scm-sm6375
           - qcom,scm-sm7150
+          - qcom,scm-sm7635
           - qcom,scm-sm8150
           - qcom,scm-sm8250
           - qcom,scm-sm8350
@@ -198,6 +199,7 @@ allOf:
           compatible:
             contains:
               enum:
+                - qcom,scm-sm7635
                 - qcom,scm-sm8450
                 - qcom,scm-sm8550
                 - qcom,scm-sm8650

-- 
2.50.0


