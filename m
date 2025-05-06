Return-Path: <dmaengine+bounces-5076-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BA5AAC1E8
	for <lists+dmaengine@lfdr.de>; Tue,  6 May 2025 13:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66AB1C2082D
	for <lists+dmaengine@lfdr.de>; Tue,  6 May 2025 11:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEDE2777F2;
	Tue,  6 May 2025 11:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXaIorai"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D1122ACD6;
	Tue,  6 May 2025 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529424; cv=none; b=IuZqT1n5wj15QHJBYQkVHUBMbaAMIW/wCR9u/7HJvC8cox8WVKXMhewI8RikkFZCaEHKEolbOX6LFGqSZppTC+OsMbbUz2UUP8gRTYSj5uM8oXolhrhLyfTQMT+1135PCJaW1M3J087LsGz3UUAYl9qYrE7M531B31GD86Uh9ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529424; c=relaxed/simple;
	bh=Mxo+sKtgJ+VAHG8khhRCMm4VG2e2s/imH0lQcEoCUVM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hv4Qj6EN3hxKEd24wc/a1s7Zyg8+JcGxVfOmoY6aXZ99va4kZl8rQ1mDpyoOoBS3bxd75I7ySe4W7w4lO+xoUOdYpGAAWd8ll++rz0iD99YurMKKzL5uFa/aNyy5YSqacgUbB3f7dSDpeofnXaYBMt4TrlBJJGKMcCctRHZS8EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXaIorai; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-736b0c68092so4764109b3a.0;
        Tue, 06 May 2025 04:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746529423; x=1747134223; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ymiy8zab3UNB6IEzIJOcgrjjmb0CNxFMt5LrXEAva38=;
        b=ZXaIorai/qX0O1qw7wD4rbL1phVIs7n3uuohjbSpsazyXgD3jxhK6on+HfkKFW3pft
         LfywFATmSfx1Cex2n4kxZdMQyfwYGUB2kwcReMvj1+vcn6ni2WqGPHWApEFZnQJeVeJz
         XyjglK6y/F1YWNJ4vYHMfL+yy+aOECu3g5baVe+e44Nt6fiaLJtO3k10dgBQ2f9fn0bU
         ckSlDRsOO0bYxQoARyx3lY6sC6+cD0L2AJMG/Guv1ZPYyxf/YW6Ksttlc5lLYRiueMBv
         Cc5vbua46/G2vU34gwa0iNGYbSXIUsU4ucpiAT7IehqXuKtldmVaV1wsTpPwIUIYRugf
         GwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746529423; x=1747134223;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ymiy8zab3UNB6IEzIJOcgrjjmb0CNxFMt5LrXEAva38=;
        b=mzi/6BWFH73fnw6chKE2ARJF2L2yrc2adOiZvi+sq7o56jJLg9UOOdWShhq337g2OJ
         h//aWeFf2C+JGgsr00UwarPeXUOFCimmqXUn76QcNvAijb3cdyVKyOD5FhKGWWM2mRAy
         mqDLco4oSrnCRfaPwdGDancJwVugRQDsb7IdydtSoowXj+nPFanUju7Ha2UGGYWKaCFF
         yC3Ts8rqL5UNR5mV/h15SNcHxgOYihOQfaVg3Z1CkcPxmKeaoiQqsXZFMG6Eean1lEFy
         YvrFaX7UTrDQGZ0/oNxfD8BtI0O9I57Ujtq7kEO1wgYs3Ldmb+USAWOr/46P1p6jc8Ag
         SyCA==
X-Forwarded-Encrypted: i=1; AJvYcCV/szflZD3ivSKD80FCJOflkijGgELf7jfmBXOykSbOGNFE9uuM3X/SgKPzZqqLExfllHeygzpJ5CP37QB2@vger.kernel.org, AJvYcCWAZYokLShhgbE72P/n64/U/BpkXGjs/X6oUe1srWVXo+4aSO7GRe8cunscnX4A1wucg18vGAvJXahy@vger.kernel.org, AJvYcCWcKhPYlvt1sd6LGo1P67BOjq6/Qi4QfK6M2CJ7KQ7G7gIdLffQSiDbLbeVOkRbmyPRJBPj3sRl5E6BVb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/cOMBf4LPDJ7whX1OTQYxj9eEDSipp8l4k5R8sR816YJGPKqT
	IIhaaUxd1NXxxFeR0XATsMxgD5DpWGvu8blgPtx7k+C/oCyUP97F
X-Gm-Gg: ASbGncuE+P6QTFPadeRQDd7Jxf4Kkmb4d2HLop2oELr7B1/WGENGO3XJ03X+RsEi99y
	puKVOCeAhFxTmiZ/jl/R8X2ZAQKCRJ0LKfyEqP2VpeEgoWjMACOhxVHdanyNSlMXy/yHtpJI3+6
	HagF37eEl/8H5xVyE2AVryMXhwa+QMzoRobQ4PjgMtwOWLU/wJ1bNOSK/QTVts7DoBRcKEgIbHM
	btwvDEFYoL52XAXclIvlDFzKf0oAyhYlWWNxDyw1MWdnAeAq1LUOVnrp93ubFYctYnioVE63n2j
	WEACr8xBdZRqsUhno1DriF+rSfY6PWT9vmcg063V5qY6aQ/DqQ==
X-Google-Smtp-Source: AGHT+IHRis9S8YF6fBA7WGW047ImXE54/4S7Eyd92Z7QGrUQds8DW/h28IO5dVmuRh14Ob603sftew==
X-Received: by 2002:a05:6a00:8d8d:b0:736:51ab:7ae1 with SMTP id d2e1a72fcca58-74058ae6607mr21847565b3a.16.1746529422662;
        Tue, 06 May 2025 04:03:42 -0700 (PDT)
Received: from Black-Pearl. ([122.174.61.156])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-74058d7a3bdsm8613778b3a.9.2025.05.06.04.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 04:03:42 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Subject: [PATCH v3 0/2] dt-bindings: dma: nvidia,tegra20-apbdma: Add json
 schema for text binding
Date: Tue, 06 May 2025 11:02:23 +0000
Message-Id: <20250506-nvidea-dma-v3-0-3add38d49c03@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD/sGWgC/1WMwQ6CMBAFf4X07Jp2aSl48j+Mh1Ja2ETAtKbRE
 P7dghc8vMO8ZGZh0QVykV2KhQWXKNI8ZShPBbODmXoH1GVmyFFxWXKYEnXOQDfm2VpLg75SXrM
 sPIPz9N5jt3vmgeJrDp+9ncT2/jKKi2MmCRBgsBG19krL1lz70dDjbOeRbZmER7X6UxE4oEQtV
 GOlle1RXdf1C9NOdZHfAAAA
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
 .../bindings/dma/nvidia,tegra20-apbdma.yaml        | 89 ++++++++++++++++++++++
 arch/arm/boot/dts/nvidia/tegra20.dtsi              |  2 +-
 arch/arm/boot/dts/nvidia/tegra30.dtsi              |  2 +-
 4 files changed, 91 insertions(+), 46 deletions(-)
---
base-commit: 9d9096722447b77662d4237a09909bde7774f22e
change-id: 20250430-nvidea-dma-dc874a2f65f7

Best regards,
-- 
Charan Pedumuru <charan.pedumuru@gmail.com>


