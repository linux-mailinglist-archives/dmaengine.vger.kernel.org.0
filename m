Return-Path: <dmaengine+bounces-5069-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7AAAABB53
	for <lists+dmaengine@lfdr.de>; Tue,  6 May 2025 09:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446F91C436C8
	for <lists+dmaengine@lfdr.de>; Tue,  6 May 2025 07:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47EF205E02;
	Tue,  6 May 2025 07:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/tL8ktS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2864ABE6C;
	Tue,  6 May 2025 07:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746515358; cv=none; b=D6WSrvwBEqSlvNsYHcdXg1LShsE3TD6jwQU/kgvbtCEuNOxNfRdSsZkKYyNcPbw9HOepR4KyucYmWlk8gK6BvILcPL5MNr0GElU66ZBCfofmWqSoOflxkkW+S8EN+G+tIBbW4bsaDzD4T3jV2Zx1u7fHlA2arOB1kYiwTD91JBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746515358; c=relaxed/simple;
	bh=h1DwMsQAu3LPMQydkl2vzI+AVDKUk9nG+DDA1A3WYqw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fWMDLG2rczvSt9mpM28PVASK2WVqwlAwCcjNVMGiMLCmUtasUjbcKdiydP0QkakuBklQwKgQNFwuRYch0vXLZWjqS7r4gRtiny/p9OKDcKT5Jh2T/yRTYuO+km4VHKJulkMxg/vcDxPVeRB+WISDctAv77LITBuoHQ64BcFT4pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/tL8ktS; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7398d65476eso4208445b3a.1;
        Tue, 06 May 2025 00:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746515356; x=1747120156; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KqQLyDD1ZGmBuz+UWLMucUCSHekzj0B9M6ea4trM1iQ=;
        b=d/tL8ktSFLUkX95g3lIultrCCYeGy1OXWm+wexEZ2OM9988sQvDgSqva59jTqNEVJJ
         OgrZq4Tf0ai83Cv5JccrYpFBhG3yiSPMffcozjPzB7cpyy61bftS7Eg6p/4L9Q2vxi9C
         IL7K7nhodfyVoXBdmIgk5fQvA10mu8CjpLrJGU0InXR/dF8dQNMnELNL4ptrHJ5IcBZ7
         n8Qir/ncp4WXEj+xTmxB/mo65A0pdRLH8HottQu5yKlHJZaC5Uzzw/AMDURnLzYujveV
         N4YYp+YT2YpVR36Eq/QVgfAEplCRdoaBcI0Fjpfd9sHmPpFatxNmPiQGEyNQP9egXnwj
         pxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746515356; x=1747120156;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqQLyDD1ZGmBuz+UWLMucUCSHekzj0B9M6ea4trM1iQ=;
        b=QoyEy5xfLqfDByEzSYeDvyk8DxUU57i64dRD3xKE4f4py9gigYJvTlPkag2huECJBm
         En33S0WVRJgqy6vVqIUVatSsoqW3vBsUex4qlL9FeDapt7m479kOwbVnUlGfShEBXrvp
         eJjZmorK5OiB3Ncdchvft4CPyGnxW9u7ynY/PMTr9h8R+Aoyfkpg3z0aIgZhN/6s6pka
         H+QK5YBYZP7dMH1q/Bv5mA8PWBBuiarxMUUS6wxpsujWejQqmMUvRqTBOBLLYkXfNagQ
         IXfUz1Y9Jw+N//JTNTv+B7950PS7sC0QBipwSvRVy8sQQuo2TDtLvpxYWPiuuIT+X5j9
         rQOA==
X-Forwarded-Encrypted: i=1; AJvYcCUBsgVWDKLG5/YU9PO8tN5/SrW2l94pD3SAoabAYoSOYVrhiAvEXLaDoG3HH9Xdx2aTxukzVSMA1sAz6TRF@vger.kernel.org, AJvYcCVnfhzvlHpA+/KLNUU+VW53VpoM+4IHbN+40yrKVhTarlrdT8wWVFKFULY3L1SHAHC6ClJaf/Kr/7MwYos=@vger.kernel.org, AJvYcCXYuC1GCcjYaHYaE5tFkup3zGXxZpVXVldD7Wepa1YctYOUtAZr0HK87Q/JVpbYD3QHedWdssCyHrIz@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8H5GZxlLnY8W2/76NcXSerbwJZ9TOlhzn1ZLRz4+sd9MTEj+m
	jvgkk2mOKTAqQUaWbNsBF2v6QeJJh/eVydQPtufA7Vk2KGEDA4bI3u6GipBPc+k=
X-Gm-Gg: ASbGncskwafezRyqEqurAGmGNZK2IWGwJ3sjEaL/8wdWrBCJbVQ/U+TdkF3sEeLyIp8
	EyWqTxt2ubNQBpQ3f6fqmG0QPU9hU9AyrXuHGskmxNdhd/Ad+8Fxev9WwP8jMopyxKKsIu9RVeV
	q7UNRHTwEXx5tMertBNL5zguBF3VgYnz17BqoPUCKphELVMH/VzyX42Ocm9PPvLK7j+62dE3RQ+
	X2zpDEWyQfX7f7TukFh2RUO8k1FeBnLxOhyX48ZoGXC6xENr5M+yrrTdU2W9eB41xwRSH77Wr01
	KDASl+fQ4xlPgn0J90Kz7WSRF1B2BO/AcQu+UFIgSMK5nFU7aQ==
X-Google-Smtp-Source: AGHT+IH3Zyy6u6RpzY5KgHoKsJ7EHKQAisxvMvebphzk4gRHaTm5ZR6ohOlHMtmi8WWzlDM6UTas2Q==
X-Received: by 2002:a05:6a00:ad07:b0:740:58d3:71a8 with SMTP id d2e1a72fcca58-74090e0dffbmr3425657b3a.1.1746515356229;
        Tue, 06 May 2025 00:09:16 -0700 (PDT)
Received: from Black-Pearl. ([122.174.61.156])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-74058dc768dsm8124025b3a.72.2025.05.06.00.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 00:09:15 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Subject: [PATCH v2 0/2] dt-bindings: dma: nvidia,tegra20-apbdma: Add json
 schema for text binding
Date: Tue, 06 May 2025 07:07:26 +0000
Message-Id: <20250506-nvidea-dma-v2-0-2427159c4c4b@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC61GWgC/03MTQ7CIBCG4as0sxYDCFJdeQ/TBfLTTiJgwBBNw
 93FunExi3eS71mhuIyuwHlYIbuKBVPswXcDmEXH2RG0vYFTLqk4UBIrWqeJDf3MqITm/ii9gj5
 4ZOfxtWHXqfeC5Znye7Mr+35/jKTsn6mMMKL5iY3KSyVu+jIHjfe9SQGm1toHEtFNoaQAAAA=
X-Change-ID: 20250430-nvidea-dma-dc874a2f65f7
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.14.2

Create a YAML binding for nvidia,tegra20-apbdma and modify the apbdma
nodename in dts to match with the common dma-controller binding.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
Changes in v2:
- Modified the subject to add subject prefix to the binding patch.
- Changed the alignment of properties and required in the binding.
- Removed description for "dma-cells" and included allOf to dma-controller.
- Changed the include statement to use irq.h instead of arm-gic.h.
- Created a new patch to rename apbdma node to match with common dma-controller binding.
- Link to v1: https://lore.kernel.org/r/20250501-nvidea-dma-v1-1-a29187f574ba@gmail.com

---
Charan Pedumuru (2):
      arch: arm: dts: nvidia: tegra20,30: Rename the apbdma nodename to match with common dma-controller binding
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


