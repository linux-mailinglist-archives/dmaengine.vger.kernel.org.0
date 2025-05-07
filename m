Return-Path: <dmaengine+bounces-5093-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D69F5AAD4AA
	for <lists+dmaengine@lfdr.de>; Wed,  7 May 2025 06:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4120F503257
	for <lists+dmaengine@lfdr.de>; Wed,  7 May 2025 04:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AA21DC9B8;
	Wed,  7 May 2025 04:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnunYzK9"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1F119F120;
	Wed,  7 May 2025 04:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746593897; cv=none; b=gnfYfGcr3aIin3X47p/pOz2qZnhDY1jlSgYTv95mq4+ctlI00YzCyLLee5E1LqoF5zcq+SGSxXPpITR++eLV3hv3skclmz6IiLh3JWzlWFOqOICBfSHuKzg2DV6NbesxrjlhQoFLwd4rI1b96iv559b5F2SWAEGgA7LsL0qhFAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746593897; c=relaxed/simple;
	bh=xdjEQbp19q2s570tGrHn1bkVAJvFSkW+5g1YF6WUKgs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I0nsxufBpBdPzjOMSnQM/1QwtHrRnh/aM1o2rsLNkNl8RN4JHZL7uXeBYr04ABbEqN8ArvB8QyYOsUWWNdtjzv60Eb67tGAo8zp9DzEMN0RQiENYGwe7d0O+hbMRWKiUAMkWTZ2ZsO9OR1RWkBXSSHUuuJ7DgG44U5/naoVrIk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnunYzK9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22c33677183so76340295ad.2;
        Tue, 06 May 2025 21:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746593894; x=1747198694; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CF7PWDnQqg0uCZ3ZgAYaN8+U8QoDOtDNlNF6ydTzfG4=;
        b=VnunYzK9NQ7Wl3/SQqp6fSqcCaIYPGaRmi+98YdawHq37hQpdOPMFLV8dEjFIL5uBY
         /qp4hOrhmbiE6Cjbnk6vkxAn+FCl5HR6TTK536DuyyhpOE/3SQ+t49mpQjR7Xn0Sk4n1
         aytEzfKf9XPJvVp2xzmYjvQI1vpsPzfyXE3MNUM3YtA0zR1OhfnsioXrvIT4nF+vPfvk
         aXxrRnl75by22EqZByZydyFFU/ogolBLl72e9Cyy1KSxrt0IaIs3xdugXrYtU5IaEsme
         Wvza5qGUb25cXp8LokU6jwQkbuupOBttMV44faI06vCGWP7h2NRX6scsEVR7kCY7aOIS
         0WGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746593894; x=1747198694;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CF7PWDnQqg0uCZ3ZgAYaN8+U8QoDOtDNlNF6ydTzfG4=;
        b=QSwnQT6+cK6TpFNJBTFZWtAqVqiNCtUgLhUjkrFcoCM/IF/qX+cvgD70DCJJQufrjP
         zuQT4MiWUnI1BSLHjiYqsBrhgU3V8ELdeiSCey/OF7bW7tTOLLnHSnnDqGJDL1dKSLcY
         aHLRH+1J7vPOikvnOxhV9p9IJ4mVrvzlWgJEmsdof91lzl5stS2rJZdZDM8qi6LTF8+t
         9krMis4P1hnAxQxoSYdr/IZixqWil5Ri1Pu66CTgzomwRhKDFgBiJdHy954nr2daKip4
         yfyE+EpGZgjq9KqgsslohF5mXohWc4RH2ouGTUFpWWluFXTTyyGD3qPyqEQWxKo/keR9
         6fpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAFTOsFOVZR74J71551FSj3VsJe+mR8id0xHDUNwt88/vzNQ8REmdOdrO7MKsQ7n3UUGVUW1suz1Ngz2Al@vger.kernel.org, AJvYcCWdq50nkAAHvcrFqkShhTntvG7ChRIZpGCN74SQUZt/tkgEU2b7NkJvELU134RnRV4Aztrsy16sfD5GQvA=@vger.kernel.org, AJvYcCX4/Y053UJEHJH0+g9n1tBlUz8/GmX6xMrrzhVaEj/m8aRqYlyXWnl6TkqXSCnRJYJ3bjan23xuJdpI@vger.kernel.org
X-Gm-Message-State: AOJu0YyERRC/REwlWlHfzTttR+uCg7Q9V+jL4PfhgerfsAEJsPumSL3h
	loxG69W0WDNnlb9X3JhapsB9vHj5zcF9vsg37uhyHScig0jGt6Zh
X-Gm-Gg: ASbGncsAJ5SRinCrz7DW+uty51xuVbD0ospZEYjyP+OPSboUNYebKKkYw5Eg77A0Z75
	IVFCD0A9/RPhxlgXYdT3FzzJbLlUiB0ZgpYA4en/w3Xr5NoNccGHO3RKNtTGCBZ86t7J/x/fC79
	fs7/JfCsORbvceWolb8Oxu8qXTRG6XhCrHv2gDJ00/Zmowkl9Xp/0w1wBouHxk7ug0ALweamD9S
	o0dBVbEM1liovhsFBO0MS23tEz03ys4x59pmP4oDvRtsqJ1yr/18IyIPNbsiXLt7ZaqWlQ4J9SB
	NXrhXv0kXoybEtTQSL0tu/AyTGGOfiCCrvvXumu4aWXt8Sm8mQk=
X-Google-Smtp-Source: AGHT+IGmAoXw06X7J+s/eF8DCb1Uyh7QYcT4U4RWQqldPOWf7Q4GPeM4j9uV+T0maV5qPzp9UJuw4Q==
X-Received: by 2002:a17:903:478d:b0:220:e924:99dd with SMTP id d9443c01a7336-22e5ecc52a4mr31793175ad.34.1746593894097;
        Tue, 06 May 2025 21:58:14 -0700 (PDT)
Received: from Black-Pearl. ([122.162.204.119])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22e1521fd12sm84261505ad.127.2025.05.06.21.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 21:58:13 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Subject: [PATCH v4 0/2] dt-bindings: dma: nvidia,tegra20-apbdma: Add json
 schema for text binding
Date: Wed, 07 May 2025 04:57:32 +0000
Message-Id: <20250507-nvidea-dma-v4-0-6161a8de376f@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADzoGmgC/3XMTQ6CMBCG4auQrq3pz5SCK+9hXJS2wCQCpjWNh
 nB3C27QxMUsvkmedybRB/SRnIqZBJ8w4jTmAYeC2N6Mnafo8iaCCcVAMjomdN5QN+SzlQYj2lK
 1mmRwD77F5xa7XPPuMT6m8Nraia/fT0Yxvs8kTjk1ouaVbpWGxpy7weDtaKeBrJkk9rT8ooIyK
 kBormoLFppfKv9Tmak0zsnKQW2Z3NNlWd66DEOyGgEAAA==
X-Change-ID: 20250430-nvidea-dma-dc874a2f65f7
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Charan Pedumuru <charan.pedumuru@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2

Create a YAML binding for nvidia,tegra20-apbdma and modify the apbdma
nodename in dts to match with the common dma-controller binding.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
Changes in v4:
- Added header file for interrupt-controller under examples.
- Redefine the interrupts format following header instead of hard coding it under examples.
- Link to v3: https://lore.kernel.org/r/20250506-nvidea-dma-v3-0-3add38d49c03@gmail.com

Changes in v3:
- Dropped arch from subject line for dts patch.
- Removed include statement for interrupt-controller under examples.
- Link to v2: https://lore.kernel.org/r/20250506-nvidea-dma-v2-0-2427159c4c4b@gmail.com

Changes in v2:
- Modified the subject to add subject prefix to the binding patch.
- Changed the alignment of properties and required in the binding.
- Removed description for "dma-cells" and included allOf to dma-controller.
- Changed the include statement to use irq.h instead of arm-gic.h.
- Created a new patch to rename apbdma node to match with common dma-controller binding.
- Link to v1: https://lore.kernel.org/r/20250501-nvidea-dma-v1-1-a29187f574ba@gmail.com

---
Charan Pedumuru (2):
      arm: dts: nvidia: tegra20,30: Rename the apbdma nodename to match with common dma-controller binding
      dt-bindings: dma: nvidia,tegra20-apbdma: convert text based binding to json schema

 .../bindings/dma/nvidia,tegra20-apbdma.txt         | 44 -----------
 .../bindings/dma/nvidia,tegra20-apbdma.yaml        | 90 ++++++++++++++++++++++
 arch/arm/boot/dts/nvidia/tegra20.dtsi              |  2 +-
 arch/arm/boot/dts/nvidia/tegra30.dtsi              |  2 +-
 4 files changed, 92 insertions(+), 46 deletions(-)
---
base-commit: 9d9096722447b77662d4237a09909bde7774f22e
change-id: 20250430-nvidea-dma-dc874a2f65f7

Best regards,
-- 
Charan Pedumuru <charan.pedumuru@gmail.com>


