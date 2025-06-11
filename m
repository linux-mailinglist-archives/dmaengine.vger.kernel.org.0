Return-Path: <dmaengine+bounces-5353-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A742EAD5630
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 14:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992A43A484D
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 12:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E6828315D;
	Wed, 11 Jun 2025 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="M9GyxUvn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3968D286413
	for <dmaengine@vger.kernel.org>; Wed, 11 Jun 2025 12:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749646747; cv=none; b=YeJu2eOkvI6W2fHBgewm9lujG2l+e3ghVLt3XdPAN1UX+y/zSCFvHhke10f6QPdaWw3qnOwUWV+Nr8wVZ8o0s89iueTh+sMuu23B972vtKJPCL2aOq+TZKHlF2blrMgIFjvtWvY+KymK3anonX95B6+PeWq4r6ac/Viww4FPeHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749646747; c=relaxed/simple;
	bh=c4q9hKJ0GfSD4cmrQLce0PPykLtXw5caieViAR29pPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C0CQLIvZQv00xZ3pM8TfZ3z7vDOhh9kYA26Y2sjSv1kv5KS5qdbNVa5NfG2FslDHQoFNSVoYYX55b2ivF0ynQpvye9r+Bu3lI+u9S3T+Vbyg/a3+hVAHkBjsIGsCwb1g2t/rjbsEfHyeRpAXEWAvpU0xVKOqQNcMT0BbFVkdZbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=M9GyxUvn; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23649faf69fso1007025ad.0
        for <dmaengine@vger.kernel.org>; Wed, 11 Jun 2025 05:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1749646744; x=1750251544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x4QOx+b/QncvHLv/sLMwOKnuymoyk68+Yx3qOBYw2f8=;
        b=M9GyxUvn1UMaCwbbFLIX7weFVaLwLVo3/2bEe5sFY+FoeCLkX80ke1SKw4DpS0PMyG
         etjxkmuPj4popWwpxtXxs9KIUgPNNfSeEQPaDIIkOIUKEmIAFnK24D4YgXCw5zrTmKHZ
         zXqBS8FxrTpvdAK2PkchX4UrndepKANf2TNLtJuynfd3c+/t5QxGseMNaMKM7MJbA9+6
         UG5M71JceK9nIqvWHzgBIg/J79IGYtPap6ohC883x1wZyH3jSg2BOywipySBRi04bX8U
         BvMNCEleXtYG/3pipPlk9WmITlUq+0Vk+ER/dU2PthLLrEdGM/8KWO1Sw2DXDOHvF9C3
         jsgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749646744; x=1750251544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x4QOx+b/QncvHLv/sLMwOKnuymoyk68+Yx3qOBYw2f8=;
        b=rsQ29bIapPVWS2ZZY+dqEQtVU09OeVmG2d8X5DxsrEqr/+xKZxtyt7c57uj05dzwqN
         94DMAJvFs4iZ/bAgLQiYdJsLb6+ZuYU1FiX3dPtu2nVzg3oEGxrc7r5z9NBxNp+SRJP7
         CyeWtbc16ykbpkByF9+ala8k5Yf2cJdmsKQW1XgKQFb92ERAZs54U//q7j7EqErPCgvn
         vn4kvoPsCIr2FEgxtNmZNOTnmWzMtFMg7pmjglMJ+EYB5X7ic8WL2R1V/vg2wxhTrR7+
         eUH7/gLSHmJaHvQUfLnNJrSBnQJHOrp+fMqepfEE8uq+EP4/36bl1oH5vAr/pMhwX/Kh
         WbiQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/wGRThLdgE6XfTwRSG7Q0c7twGEfOhig12CTnmcA7LJ372Wk7bp5K2EzyHfo7DbFqTUGGZ5QGIu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvQxUdivj7AAd96ivWaeMVUH/ASRNqJnwaOH2LD9qPLCjqEVlK
	HFozSTqos9H4PE2Vks4ade5qpjQN7BJIau63j53JOOusWmQMMPFfFqE0cOcU8cGBYWw=
X-Gm-Gg: ASbGncur8O1IfdiiSFPer5M2HD2q2I+SYbNTEgXPO9BXfzXGQEf6PaAOJfCG4SZHaKf
	1PP1I4jv3dBXfwDmRTOBDVLwBRxMdX26EebhODLHR+jCAhRYRvsSvHtJznv8fxq07+Csb16zgOy
	RfQAw28JsM6e5VOa4b0HrUkAoIff+Pxv1XHC4gbntEYtsoTsmxiUkrah3S38AUfxtGtriLUMZq1
	hIOS5H0DSbmPc8feRKdImECce6YxTNI+2O1lSc69SgqWLUERkOPnvmcpKSP09Xn6T3UuFBM9eJ1
	0VqH4P0jEioUFr4x/5Zgi0HXQUnhQueP4GRb7Q/hoMj49tVguZxxA4PR8ZDgYvOXwxf46XHWIWc
	KKWElyG5fIG76WOpBFBHPzw==
X-Google-Smtp-Source: AGHT+IHeeQKbfAGNGeX62nkTUoAIUb+/0YEOPG1s+np4s8lIc4gcrO2OCn3QlplFdVVleQo4sYhIgw==
X-Received: by 2002:a17:902:e74b:b0:234:f182:a759 with SMTP id d9443c01a7336-23641af07efmr51079475ad.28.1749646744203;
        Wed, 11 Jun 2025 05:59:04 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a00:31a4:6520:3d67:ceb1:7c60:9098])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030925e3sm86984115ad.53.2025.06.11.05.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 05:59:03 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
To: vkoul@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlan@gentoo.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	drew@pdp7.com,
	emil.renner.berthing@canonical.com,
	inochiama@gmail.com,
	geert+renesas@glider.be,
	tglx@linutronix.de,
	hal.feng@starfivetech.com,
	joel@jms.id.au,
	duje.mihanovic@skole.hr
Cc: guodong@riscstar.com,
	elder@riscstar.com,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Subject: [PATCH 0/8] dma: mmp_pdma: Add SpacemiT K1 SoC support with 64-bit addressing
Date: Wed, 11 Jun 2025 20:57:15 +0800
Message-ID: <20250611125723.181711-1-guodong@riscstar.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series extends the existing MMP PDMA driver to support SpacemiT PDMA
controllers with 64-bit addressing capabilities, as used in the K1 SoC.

The SpacemiT K1 SoC contains a PDMA controller that is largely compatible
with the existing Marvell MMP PDMA, but adds support for 64-bit physical
addressing through Long Physical Address Extension (LPAE) mode. This
requires programming additional high address registers (DDADRH, DSADRH,
DTADRH) and enabling the DCSR_LPAEEN control bit.

The implementation maintains full backward compatibility with existing
32-bit Marvell platforms while adding the necessary infrastructure for
64-bit address handling through a flexible configuration-based approach.

Key features added:
- 64-bit DMA address support via LPAE mode
- Platform-specific operation abstractions (mmp_pdma_ops)
- Optional clock and reset controller support for modern SoCs
- Device tree integration for SpacemiT K1 SoC and Banana Pi F3 board

Testing:
This patchset has been tested on SpacemiT K1-based Banana Pi F3 hardware
to ensure the PDMA controller operates correctly with 64-bit addressing.
Existing functionality on 32-bit platforms remains unchanged.

This patchset is based on [spacemit/for-next]
  base: https://github.com/spacemit-com/linux for-next
Plus the reset controller driver, posted by Alex Elder (v10):
https://lore.kernel.org/all/20250513215345.3631593-1-elder@riscstar.com/

Guodong Xu (8):
  dt-bindings: dma: marvell,mmp-dma: Add SpacemiT PDMA compatibility
  dma: mmp_pdma: Add optional clock support
  dma: mmp_pdma: Add optional reset controller support
  dma: mmp_pdma: Add SpacemiT PDMA support with 64-bit addressing
  riscv: dts: spacemit: Add dma bus and PDMA node for K1 SoC
  riscv: dts: spacemit: Enable PDMA0 controller on Banana Pi F3
  dma: Kconfig: MMP_PDMA: Add support for ARCH_SPACEMIT
  riscv: defconfig: Enable MMP_PDMA support for SpacemiT K1 SoC

 .../bindings/dma/marvell,mmp-dma.yaml         |  17 ++
 .../boot/dts/spacemit/k1-bananapi-f3.dts      |   4 +
 arch/riscv/boot/dts/spacemit/k1.dtsi          | 234 ++++++++--------
 arch/riscv/configs/defconfig                  |   3 +-
 drivers/dma/Kconfig                           |   2 +-
 drivers/dma/mmp_pdma.c                        | 249 +++++++++++++++---
 6 files changed, 370 insertions(+), 139 deletions(-)

-- 
2.43.0


