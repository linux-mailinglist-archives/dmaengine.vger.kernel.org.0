Return-Path: <dmaengine+bounces-5304-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A84ACEB44
	for <lists+dmaengine@lfdr.de>; Thu,  5 Jun 2025 09:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B54F7A6515
	for <lists+dmaengine@lfdr.de>; Thu,  5 Jun 2025 07:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DDA1FFC45;
	Thu,  5 Jun 2025 07:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvQqNmGz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B461FCFFB;
	Thu,  5 Jun 2025 07:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749110129; cv=none; b=PYVdVCuaeCTWZdWEDODPfhtgYnvrLEQ8Hck1d6Wnk110To1H/jradU3hN8cLiXStbMd0jrKh+VZOAlh8Y6l3sr5sZXC7M6b+YXAFfaXGNjHr+wjwBx0Bt9bF2pzfgPuNYvkzf37nw1BD/exgnXOaNYDuxFRIFfdlSBdsznIy+Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749110129; c=relaxed/simple;
	bh=GpoQ+3Ee8T8lm6I9aP2enWwTg2qztQbdsDSevWYvSxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kNVsUtPgtbiOBTbET5Wb+H261e02crYSnJ/O0NMU160pboo7Xz6IRVMzvBA3Q3LUsxK6sC2DTeXGwsrCP42ZoMeauKOtfacQfTispf1QMqg5Xf8j3MaPE66SqD6IxoC98ZhIF6qyymi+1B1fOUWDd7JX+/syQqvbYh1oaIqgmro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvQqNmGz; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b2c384b2945so512890a12.0;
        Thu, 05 Jun 2025 00:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749110127; x=1749714927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MN1EThQK7jwsdU6684ZQQdUH0BeblPeQioulBRCACxM=;
        b=gvQqNmGziK4xqVoM2fV+Gg0QUbXnHfLc/HTYKRtIg3nRUfxd7hyOYo244n5z7xLUHR
         xhaHAtZMczyI4UCGJuk2BLKGGHTknOyB8/DovFKGFcOGPQtrd9wRCCDjb+OJbfSKdnUd
         g3yNnI7srNHRp047aYtX05jOtfdGzCQEwNNDe3o1coqBK9k167fypI9km6lzXccw7rEu
         MI4SFlvvIZ2BRuf0Vb4spFf6eSDExcQc2EOW3HshSVPNkczp7ey4m4O7eQhhQ/G587uw
         ZJEJzI5KI7opLFZTtDvPUx/R3jtTRB3o1TRV4NPwT5BMw/gnwiBHhB8ECoOUfeuGkmeo
         84zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749110127; x=1749714927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MN1EThQK7jwsdU6684ZQQdUH0BeblPeQioulBRCACxM=;
        b=kwNTw2k8QmMrppSAMDojeIkEiM8feyyIvuRS6DypozZab74xuEcjBFh3jhZ5byyTEI
         AH/igCOqvhhHdiv0JmB/Q7ugNs6h1D+9iK6sYU2AcYhik8C6rP25Y/XE0+lYU1Li+Cja
         2SM70I3rfB/Hjs5w2ic3P2LU7plyoSrXW40CCK17Lv+iD9zV6fsg+CwhNlkzfXCMbshC
         Xe7MISV4qkXc4AQQoGiwFgWXsQW8xUCemvQoIDuDmu+TZOJQnecGGi88+G4Cx9dYzI7N
         rj41dVfaSgh86eQ1bqxtbvlySL75NV4iuhCPsYIRIyNpa1fqc+mHvZJe6i2lVcd+bijr
         AVug==
X-Forwarded-Encrypted: i=1; AJvYcCUKYqhEy4YeYbH6NOgjVg6f1W2m5Qp9BHpvF2DLIQYdfjfoyI7UNM5pGb3DdPHKqcqjhA2KEwQDKuTTeN8c@vger.kernel.org, AJvYcCUm2xEUUSHH2fbfsfz6HE0kWSYCwyn7Q8+Uaw5UgVinTmPjkg4SIBOGU3OPa1N1OvPueqTqRI7UfsX0@vger.kernel.org, AJvYcCXiFEFzaGpwIl0AW2khz6MFPejexoGDutTkwGfg7fEV7BBWoPwULuOJxXl/ogDYpdFxFIRPhxtSn664@vger.kernel.org
X-Gm-Message-State: AOJu0YzsXAJhwGPIfiBCsWumb6tPzYN/X6QmfnjOaS2rhCVPbPsB6u5Y
	6h9WdOmXthYciViGzzVOG689yj36b4edsHRtyYMy+KW17lZvSIKJZss6/fNwtJYt
X-Gm-Gg: ASbGnctF2/Qq0cHl7QTAqH+EubugO66NLKCqzxjVKLEz6F2Ou2sI//rWK1eZDbn/Fdi
	JUnlo00rjX9P7Sd2pNmxH7u9LkjNXxfG8ws2Q6b42Zlj4W4zXOdZAyNSBbGtjMhUb2ZGmmyX9LW
	mrxLQiqg5DI3WAh96pzkJFN0bzMM1Dccl+doTSjeQv+evrD3Idl6ud1JBCEQJknJczYadJvGUCI
	4KX2UbmYhZ/QQO/yVwyKVSSaPjFWlyzYeIieAGvM8tEkO4qH+2dXnWnwSE3szfXEPot5CKfcIrm
	TCTzkYp2LoTJcI3kJSJLJsvIL4GySObUM9hHPZi70Eml60WwSHocgvaHtPPG
X-Google-Smtp-Source: AGHT+IHh4IlR4kSwzddiIXdouQOY+AA/MICiWnCJd0UnK8DHLokqCrXMf2Tek4xlqGOD+8rK78ijtw==
X-Received: by 2002:a17:90b:268f:b0:311:9c9a:58ca with SMTP id 98e67ed59e1d1-3130cd12d80mr8263145a91.8.1749110126595;
        Thu, 05 Jun 2025 00:55:26 -0700 (PDT)
Received: from nuvole.. ([144.202.86.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bc86cdsm115201015ad.8.2025.06.05.00.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 00:55:26 -0700 (PDT)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@foundries.io>
Cc: linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH RESEND 0/3] arm64: dts: qcom: Enable GPI DMA for sc8280xp
Date: Thu,  5 Jun 2025 15:54:31 +0800
Message-ID: <20250605075434.412580-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds GPI DMA support for sc8280xp platform and related devices.

Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---
Changes in resend:
- document dt-bindings (Dmitry)
- enable it for sc8280xp based devices
- Link to v1: https://lore.kernel.org/linux-arm-msm/20250605054208.402581-1-mitltlatltl@gmail.com

---
Pengyu Luo (3):
  dt-bindings: dma: qcom,gpi: Document the sc8280xp GPI DMA engine
  arm64: dts: qcom: sc8280xp: Add GPI DMA configuration
  arm64: dts: qcom: sc8280xp: Enable GPI DMA

 .../devicetree/bindings/dma/qcom,gpi.yaml     |   1 +
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     |  12 +
 .../boot/dts/qcom/sc8280xp-huawei-gaokun3.dts |  12 +
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |  12 +
 .../dts/qcom/sc8280xp-microsoft-arcata.dts    |  12 +
 .../dts/qcom/sc8280xp-microsoft-blackrock.dts |  12 +
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 368 ++++++++++++++++++
 7 files changed, 429 insertions(+)

-- 
2.49.0


