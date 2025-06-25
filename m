Return-Path: <dmaengine+bounces-5622-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEFBAE7D0A
	for <lists+dmaengine@lfdr.de>; Wed, 25 Jun 2025 11:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76297178218
	for <lists+dmaengine@lfdr.de>; Wed, 25 Jun 2025 09:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C966C2F0C50;
	Wed, 25 Jun 2025 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="A3D2e6Wz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B548C2E2EF7
	for <dmaengine@vger.kernel.org>; Wed, 25 Jun 2025 09:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843405; cv=none; b=K0iFsHSPaJ2Gb/ogr9z3N6rdGKYAxzmWFCY4HIXuvlqlfkUG819GkuWlEdLmVONaqMlWo4TQRGHBSOTUcvcgMxZpbdZ0Rk53ueYtOHpebEzOgjn/Kprk1m7G8Fa1E9FaV2ZkXl7qur145tcN96SPTe8ALBYflS8rM833QJJaQ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843405; c=relaxed/simple;
	bh=YagMwxq7U7yWw9QLdcfac7nNwnvk1Yv3KEQc1uEZcGo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NVY0E1Hwk8nVKn742lUqGSfcDX7wb23g+kvWHs0JVa3nlEwuROh9RDxNLwkOc+2yvmf8U5DU0dcznlwGlVrz6KcgBNE+3RZTsdKPh8tlrNAsQlK+B/N7ZC88i/9HbGzxp/MzrfwFokwiI7XvxqtjCH1FTm/HtUkY/2t8gK1rTOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=A3D2e6Wz; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae0b2ead33cso136835266b.0
        for <dmaengine@vger.kernel.org>; Wed, 25 Jun 2025 02:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750843397; x=1751448197; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KpVu8A0fOF6COL52SrecDnHkcknnFYzJmrqkhyu0QC8=;
        b=A3D2e6WztMmy4jEZ3O6D1dgczvWWyyjAzEZFNOu2sSsJCYqOlr2kePhIDgigvRMElY
         +lFaLBiLHVk4ZD8KnA19OGBYvrjljoHonQwlRAOQFvI+ku+NfGt5DXsDffQTdR8vOIbm
         orwyEvv+AKaLDURSy+uaok56/Xf4sNkrAVEHGZU3uGlwVsdl0wuttxMC13S8Eg8SoYzU
         Gsx6lTpDF+XGS/6gUubDowRK6rcT5BVfFNgMidaVlaQf0LnajYRXUfZ8FlEeWBfyFidy
         Tl1j+tw2BKTSzMK9C1P657kaKxYxNRXi9yHJQN8eBAOsuoa6vAgOWbQWzOG+m67LIACj
         fllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843397; x=1751448197;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KpVu8A0fOF6COL52SrecDnHkcknnFYzJmrqkhyu0QC8=;
        b=Is/0dlu/1sth8KdyfccHS4NdnlG0wjm8OQeLuTtZaO6njd7u1NFmYPaNWKX/tXUp38
         TUsSqW2M4N0qPdtZu7Ybv61yAUYWPSPRjpQ4BJUMNGfJvIkpMR912ebzvYrHJRDzufq/
         ulo3g8cpJsqxyRBQsbYjvvOsTJq1CDBoPaBscMpQ6weh8hFKhueVcSo7WIuJjLBHr5JK
         yr1JLjTP+cv0vCmMFV0RKCDNIzCsSvmdEFFgxyVf/bZns1UcfHWI7JqEBzzsOn5acCie
         HazTiu90U2fDXiK7z9Ao8pdvbd6w43x3XFqQ038wgnE06c/RuTlsqLVXOM1hWnaspevA
         +JlA==
X-Forwarded-Encrypted: i=1; AJvYcCUAlE9pSLJaIAvfAac/A1isoAa7LPA5ulZ2mibNjBaI/khnFWV2rw4NranLPtesaMKia/uh6JFkROw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzckrkgYwyPKJbEi0u16I1hAXJl4sWnKuvGtoLSYxYhahKif9Uo
	8+eNgozAVE0f3tJJg3/jz671DMVxRv0MEBPsgYGkqr+EKU2exYgeKYdht6Aw5gczlP8=
X-Gm-Gg: ASbGncsd3EpeBm8sukBbAB08Q6luC6V3u6JL8cx/XQjTPZEhcTVv+ekzwb/Bz45TcNV
	du+Va+s9bpFnyOny7iHxxvcqAAuf6KCaX1HJfZUbML8AIeN+6wHCrUREWMgoxbjYL/+Yf8xLSfl
	4ejlt/O7J77iIrAMO2m9g/WgaS5YhhtJneqNYcMqytTg41EjPchGtlRX0qNjPUrkzsgxA9y5Tve
	DGwOcGT+xa2W9nEdY9Xs+tq8ATJkkO92AGmUk072fyJ0QzwwoqzzRHQmZDap9z/+PeHkN5Wpe4k
	DFHgO27V1PCNZhiE+1VXw9M6NLnUjXd2vG1bh/k8J2Oyut5t4D+Kk4k4CXTJwD3jJ5AkUmsd7r1
	C6Ao5HGNCtBIuhYwmutyJNMhjdQ8K2Qoj
X-Google-Smtp-Source: AGHT+IGs0JOq47ozJxO/VRAvUrQrVeV04oDsRGncO0FlhvJG+pk9vEPKTSD0ngky9ofslW8b5sJSPg==
X-Received: by 2002:a17:907:9715:b0:adb:2f9b:e16f with SMTP id a640c23a62f3a-ae0c07dfb11mr197384066b.16.1750843397407;
        Wed, 25 Jun 2025 02:23:17 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0aaa0a854sm270277766b.68.2025.06.25.02.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:23:17 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:23:04 +0200
Subject: [PATCH 09/14] dt-bindings: dma: qcom,gpi: document the SM7635 GPI
 DMA Engine
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-fp6-initial-v1-9-d9cd322eac1b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750843387; l=855;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=YagMwxq7U7yWw9QLdcfac7nNwnvk1Yv3KEQc1uEZcGo=;
 b=tKVOirX/O5H1uxQ7HfeyAyYM5D3We6xzlJ6UXlJXIztsBOvAfenyp7TbfJ/uAqV/GmjIz7RGD
 07DUBwDoCwrCGr+c0KI+9cEHz1aYwkDjfvuOUxmsPxCvypnlcx1nV7q
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the GPI DMA Engine on the SM7635 Platform.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 7052468b15c87430bb98fd10bc972cbe6307a866..051b90e57d5ff42f82cd803521c48498ce6af35b 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -33,6 +33,7 @@ properties:
               - qcom,sdx75-gpi-dma
               - qcom,sm6115-gpi-dma
               - qcom,sm6375-gpi-dma
+              - qcom,sm7635-gpi-dma
               - qcom,sm8350-gpi-dma
               - qcom,sm8450-gpi-dma
               - qcom,sm8550-gpi-dma

-- 
2.50.0


