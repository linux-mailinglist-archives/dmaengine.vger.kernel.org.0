Return-Path: <dmaengine+bounces-5615-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4619DAE7D26
	for <lists+dmaengine@lfdr.de>; Wed, 25 Jun 2025 11:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60CD4188F8EA
	for <lists+dmaengine@lfdr.de>; Wed, 25 Jun 2025 09:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FA32E0B55;
	Wed, 25 Jun 2025 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="qQimaYIy"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533A32DECDA
	for <dmaengine@vger.kernel.org>; Wed, 25 Jun 2025 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843395; cv=none; b=depdTcKki1KWz/VvERnK9t2KPeDjb85LCu8YPWaM01ssLNiMSFiwIRU21NQTDIBe4Q7Rluhhm5QBYRfh8cmmhIaiHD4uQoerlbSIz8U/sjeLeYY5QqlEA8VMExjjp3h/GnKuZ9+DfUKFtwiFwv+VcNkfiVhCbAG4T/YZcZqziro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843395; c=relaxed/simple;
	bh=cHqszQuBCaVtspU1t7iOjEc+5vwmG2p0Bi0y4m/DFOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bvFXTiAw6RjhL8lqrQugVZ1frEw/LW/zqRL/xub5c4XLE/U4Gu/oq6xZuKzZnAxjl5gaqnlRxjsLOZXJEd433enWEVXS+uVTau4f8UR79/6EYOhCVzhbsYPwI5r9Czs9FT3/COgVyaoocHOQHurv37KizaZB/QoeLKr5ZiMN+To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=qQimaYIy; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ade4679fba7so240807966b.2
        for <dmaengine@vger.kernel.org>; Wed, 25 Jun 2025 02:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750843390; x=1751448190; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFtr36P+rCcWPRSy5N2MbhYZaAtcWKoXHXQTaJufVVw=;
        b=qQimaYIyKlpWXgEyXsJfceYSlAiWv445eBYouhKZTk7GRDZF9NDZI+OORDr2FZoiMG
         QK3B2iBxgNv1QEToOJK2HOSn6ultvfEnrA+AwHWhxmvE4PR/DC3iR2Q8ucbzR/yvxV0k
         X+I9erIbTIcoq20/bkchLLRiou+5tx1VLUrqGHwseFFH7AoXYnRQ5tqtp3mHH+9aweno
         dz7ibgia4pGRS+EV74ziqinpRJObnfXvyY3z43I+b9vIowcrNIXnQbF33k0rYiKA5aPS
         znj2Dux9yYKnUw4R399gnDhvl41G0C1z62gkeXrkEknJsdMaF4BaViziEs9mkvJmFglV
         SgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843390; x=1751448190;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFtr36P+rCcWPRSy5N2MbhYZaAtcWKoXHXQTaJufVVw=;
        b=wlnJLe+88FuOVuyo5ADTjtreST0f/cy0teamM17cjNz5eAKFyLoV9NWpGvr40H0G6B
         X9M0x3u7IljL1JfLsJPwHVe37ziGMPpNvBMvfYkNkaMoEA8d9PV/qo6zbR28t3yNOven
         a+sdrGtXNZYLzcx92AWKETZusb6XfmC5mYPUymV3x5nkARlaA82dGUW5T3rFrrItMVVF
         Y02QIUexBoCZKQZ/x8cXGOb1/xXcR7hdF6pu2RgCAhOiuMqn64zF3BLp8uCWKgFsgg/u
         IqHvMvJz6r0U3CZ8069Qs/C3hLmVZxnrts81K9dQlHJz4S1vMzfLdQsl96zdgddivFaj
         YqCw==
X-Forwarded-Encrypted: i=1; AJvYcCU2HMJ3ktvmHTUTl/xhf5qb9pbU0az4FY2fkd9HteUDAj1jsE0gMMPh4bzkATh/PdMRirreyRCGxTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy9kXh4mvuzNEAohgOZx4g+5aen2sQPOa0NvKeskVSeTg/6Cys
	H/9LHl9p7aM/bSU0OD7QDyDoIyVpveaKGL31MFKNj/2pgSRCwz2DwkWvrSBP45VPyVY=
X-Gm-Gg: ASbGncubs9WbfZB/OPaIZU8h1hYo3hpYwKoebDjqbTz5jYB3q62QoGJswqdDL+ikTfR
	d13ZSiCcHE22MNJEd8pMMHnx9ZA6de1CO6ditJw1sxWkhwnBvODKGhYHiFTYrlut2z38UsoM+Un
	o7AQQO5kEI1HNTVmxc1dWed9myKIIPYqhG3EBu+CRnzMHug6udjX+SKp/vGYXPY9qRDBx0uiCAc
	9FzD3Srt2azMYrLTfq3QVV9z7lnfOcYxssCkV3gb2TJDXmvy01MfoKx57sRS+HpYJIw+9eH5shj
	TVQ/SxRFDmnUF0ZlWq0kXOINA+neQOxtWQ7uLwElmh4av0z1NTjWoQjy0vJvWyZlYkMLTAQnLlb
	gHWzlmm+151uls93VaCttmaNsidGAwBmv
X-Google-Smtp-Source: AGHT+IFJ9o4JWl7lIDkFxyVHQOH8cM1/pOAHHQWQqVQ98/eGA7Vc8alvEQuTG6jNWUZwYJgy53sTvw==
X-Received: by 2002:a17:906:ae88:b0:ad5:3a97:8438 with SMTP id a640c23a62f3a-ae0bf1b4c54mr195255066b.41.1750843390328;
        Wed, 25 Jun 2025 02:23:10 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0aaa0a854sm270277766b.68.2025.06.25.02.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:23:09 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:22:57 +0200
Subject: [PATCH 02/14] dt-bindings: cpufreq: qcom-hw: document SM7635
 CPUFREQ Hardware
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-fp6-initial-v1-2-d9cd322eac1b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750843387; l=1256;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=cHqszQuBCaVtspU1t7iOjEc+5vwmG2p0Bi0y4m/DFOg=;
 b=kCR5siUeapo7dxDWp4dWExqPF+lGnBc97GFA4dxfQD8XoZ1lE5aOP6CJT2iAzeOSwdIFhC4/p
 Z4uY5ayq4rUBb21sP5ZjkiYsj+KLEC4ZuYf4Q18vGbyiwI2d+IWW6Oq
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the CPUFREQ Hardware on the SM7635 Platform.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index e0242bed33420a39b8a8cff4229ba9eee994ca30..58a2222574e57a8f9c114f5fc3f0aa19d9794965 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -44,6 +44,7 @@ properties:
               - qcom,sdx75-cpufreq-epss
               - qcom,sm4450-cpufreq-epss
               - qcom,sm6375-cpufreq-epss
+              - qcom,sm7635-cpufreq-epss
               - qcom,sm8250-cpufreq-epss
               - qcom,sm8350-cpufreq-epss
               - qcom,sm8450-cpufreq-epss
@@ -169,6 +170,7 @@ allOf:
             enum:
               - qcom,qcs8300-cpufreq-epss
               - qcom,sc7280-cpufreq-epss
+              - qcom,sm7635-cpufreq-epss
               - qcom,sm8250-cpufreq-epss
               - qcom,sm8350-cpufreq-epss
               - qcom,sm8450-cpufreq-epss

-- 
2.50.0


