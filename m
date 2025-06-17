Return-Path: <dmaengine+bounces-5508-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57D4ADC58C
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 11:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82D83167FAE
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 09:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B153B28A714;
	Tue, 17 Jun 2025 09:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiFgmcGL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A171E32D6;
	Tue, 17 Jun 2025 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750150859; cv=none; b=JwnsxcURf6DwlGD5Oy9W6ysYS0RC86THfVxi78Dn0ZQeumpGfJkB34+GSKi5LPcnlxln1YAr4xhtbIhxRyJSRgNiHoT9nwvLZFcy2IvslQ/elgC1niLqWuyFj1pg/8XZItvrklbCMIzYFRUMkwPaHJI0/poOxBAEwEk2Dc58T4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750150859; c=relaxed/simple;
	bh=WqFZ4qPX6+58lvGJRiRvwH+8LiwngNF+eBXegR5pMOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KMQOXvjcLAuTw9kY0OHT13rKNbhE4kfaobZMqp73+2gS+kjemOxpAO/5/ypVYXJ6nQ6CgsI2I9C7YedRFXwXeskaRMPhmJ4UnPoMTGOFYjPTya2FJXzNk87qd6YKUjpWKKcK01dvmXpJUf9nqHwKwwj4bMWMOvVULt5u0JhTebE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiFgmcGL; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23636167afeso53019195ad.3;
        Tue, 17 Jun 2025 02:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750150857; x=1750755657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tsCHQ2dp31/BppABmVZtNlJK9iJUdzdnw38kvS3lSts=;
        b=EiFgmcGLB/BBVxXdNxtW9/A6HdEEIMBD2JyLczhinKT1oN1Y7nfoi+Wz10v0cmR9C9
         6iNPZsNCCaRySgDKau7j/uW2PLR5h4nV9q6CqLEo9LxBMZ7QYBp5L67N2m3ECgAzzYAl
         vOEjTKPhG9w5FQxbPCOUKEa/+aUIm9rcgta5KwJsRG0vWi69xauBh/WzZwmMwqO4HsCU
         n+A8ikq/8L4uNAvs4lVrBlx075RWth6TgNnebb+Ga8uEcEVDm/Jr6/pSqqYjlSnLgRs/
         7RaCm/RWCBdE2dAtO4ein8D5FtXXoo0Py0AIMBNbwqtcxHrwRFH5txwnBvb//BlC+myI
         CeBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750150857; x=1750755657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tsCHQ2dp31/BppABmVZtNlJK9iJUdzdnw38kvS3lSts=;
        b=IBThgJHRUtuUMJ49qBa7okrOPRYww0naxrU05vtZ9P3DPaDWLpa5EbpTst6/jOGiWN
         O7l5dv+68oB9mIGquyEyatWxMHkgeZqKJcOsU3poajqPGyqei0i1L7KUGTFFZiPs1heQ
         kyzjzcO6EV2U6W7SnOsaXA8NRF+2DFvhY9MOfjGPb9NjWBW1pGMjkmK+xLmktPFcyb7P
         1/PORhpjwdpj+5PLm8VtQBR19b9Eo+vTY+YqYZI8Drzw2QiR5/KDhZUpIinlTltiUXw3
         ekVCtsA4W7YXsIEh97LLCiUV5P9Uop5qHMboURE2BDK4C+bF9ie5GV0WdSsdofsib6fV
         aROw==
X-Forwarded-Encrypted: i=1; AJvYcCULHqQrJJLm78WqRdCdgg/RROUVf1sJn039VPSubtybnn3Wge+pgMfA7NPzQynlSrB/9FIfSDphXm3X@vger.kernel.org, AJvYcCWnX/BtcAssebDbtiec0gHWmjan8bSnMmR6qhv32u1/ZHNeEXp8Hg+IcrbWg1MKKvS/xfmiQ/KB5RjX@vger.kernel.org, AJvYcCXx+fN8FYoLdKz7Ht4QDqkcv8Hu8PyayPJFmhT0UQoCwwIOgsQwNgPDvWq6C0ta6Jm+G1GLDI+YkbtRFZvy@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2xe4RyqgZfTropxPMNdZxDND+luiX+gz4mYDiEBesjvZ1Hroa
	8zuWGxhdLeKr55b+yzs/hgDcIx1jeJBswRqtcdto9GlUsCSShZUGy2hs
X-Gm-Gg: ASbGncuoqt1PFeN6bb3ZHtjfniwDPA5mU5K3e2Mme5Pu3vOszU5BVRU5m06eQp2LGly
	Vyy3RBVXvtpZ5LWuVE7Bq2Mz+oZ35AtDWiOG3GkJQ0KyJCXF1nSQvgQ4KDB+PM/UQ9o1Lj3iDfM
	eIO5KlVyRgTd7/baSDV+VdPyOEctlzZ3wWSxYGMvRSAORlOwd7dGCmJlA5fS2mcwKVtKAp8p/lw
	ff7boLl80RSri+aHUAwDLAS57LRtqXa8TFEtfuLCdr8DPNugaAKDLREKX18apNKXh+rmOpJ71QH
	GVXiudnhjvKTl9G0we2pMcfSrIMVgEVXqcSyRWyhSlL/c84K8rb6j3MRRNYJtKRfhPWEg2E=
X-Google-Smtp-Source: AGHT+IFo6pwFfp0nD/MjfEOs5NJ2XQGul02qjgqtb5pXSskMOp8VnJYA4dVQiii1giXc6oFonfI29A==
X-Received: by 2002:a17:903:2301:b0:231:c9bb:60fd with SMTP id d9443c01a7336-2366b3ad4d8mr169155625ad.33.1750150857331;
        Tue, 17 Jun 2025 02:00:57 -0700 (PDT)
Received: from nuvole.. ([144.202.86.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1680c5fsm8301764a12.49.2025.06.17.02.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 02:00:56 -0700 (PDT)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH v3 0/2] arm64: dts: qcom: Add GPI DMA support for sc8280xp
Date: Tue, 17 Jun 2025 17:00:30 +0800
Message-ID: <20250617090032.1487382-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds GPI DMA support for the sc8280xp platform. This option is
required only on devices where the touch panel is connected over SPI.

base-commit: 176e917e010cb7dcc605f11d2bc33f304292482b

Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---
Changes in v3:
- fix shifted dma channels
- do not enable this on devices without connected SPI slave devices.
- Link to v2: https://lore.kernel.org/linux-arm-msm/20250612075724.707457-1-mitltlatltl@gmail.com

Changes in v2:
- document dt-bindings (Dmitry)
- use describe in commit message (Eugen)
- enable it for sc8280xp based devices
- Link to v1: https://lore.kernel.org/linux-arm-msm/20250605054208.402581-1-mitltlatltl@gmail.com

Pengyu Luo (2):
  dt-bindings: dma: qcom,gpi: Document the sc8280xp GPI DMA engine
  arm64: dts: qcom: sc8280xp: Describe GPI DMA controller nodes

 .../devicetree/bindings/dma/qcom,gpi.yaml     |   1 +
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 368 ++++++++++++++++++
 2 files changed, 369 insertions(+)

-- 
2.49.0


