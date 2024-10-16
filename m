Return-Path: <dmaengine+bounces-3381-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE679A0A89
	for <lists+dmaengine@lfdr.de>; Wed, 16 Oct 2024 14:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1AF280DFE
	for <lists+dmaengine@lfdr.de>; Wed, 16 Oct 2024 12:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5B220C002;
	Wed, 16 Oct 2024 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="yuoH5bdq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F16208D70;
	Wed, 16 Oct 2024 12:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082596; cv=none; b=sALvtRQZpDx7cHBoC0WBwBtJHmgX7QeWek866cuVLEK32E9qED9dlvjKz6xUQusFkvvk0EAhrxvXd+5TKZt+KlYnwdrwnucj73Rwav35yVRN+cEIapGBTAUClNEsdhhHBvL8WbV9UynpK3P5qEJ2sUG76pxZoxb9MbKTGXsuZWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082596; c=relaxed/simple;
	bh=l4OrAmMpwbvLwv+70endaoP2HeIZT7Q8/l4hfY1SdTo=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=myPQwCfBHGu2oudQMFxMN3Ueh1NNaXK6OBa2ckjGfRxoiZKl59m+2GOg0GbFx+WzfbZ6ahtOjDChCPf0SbYPQ2DYo3mqhbNZg/Szr8QdMKDWXgdLaPTOn2cJ9JxtDhOPO5urhmwjcTVdosF9K9/98I3TL/yyZlQrxELjN+HLpcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=yuoH5bdq; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GAv7RR018446;
	Wed, 16 Oct 2024 14:42:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=FXtu/QHGpXfhegm33yGhz2
	xtymGMtBPYcZnOTLNw6kA=; b=yuoH5bdq6hLAyMsnWVkdV0Goz14wUJfaVZVplk
	942M2Qm5eOX5JSbY5txCtxwxtyjotKKYKvV9oIsaidZlJ6APvESXi9qJy6cCcIyg
	GHqx1HlfMnXi9qH0KWwyRdoLoH0D0ftJWUzyDUF4Inh7nKWCgWyPQNcR9ETMJc9B
	TRZx+kNLj6r2xN32Zz52fgVmy+SyUR6xMzqGs50Id+MgMhdtOL52z/zKnSFY/CjR
	rsGVAW5g++zh7pARjqae0pnyZYTpNtYSAAp67gLtMjT/fJqUkzgOXr8sjy7tbD2/
	9BsiN+uGejTsgUcL6HU9jwy7ebVy+Dp848KXpKzREFR/fNnA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42a8mv9uwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 14:42:52 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3922D40050;
	Wed, 16 Oct 2024 14:41:23 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2F19E237A40;
	Wed, 16 Oct 2024 14:40:20 +0200 (CEST)
Received: from localhost (10.252.17.239) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 16 Oct
 2024 14:40:19 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH v3 0/9] STM32 DMA3 updates for STM32MP25
Date: Wed, 16 Oct 2024 14:39:52 +0200
Message-ID: <20241016-dma3-mp25-updates-v3-0-8311fe6f228d@foss.st.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABi0D2cC/23OSwqDMBCA4atI1o3k0UTrqvcoXUQzqVloJGNDi
 3j3RqHQgst/YL6ZhSBED0iaYiERkkcfxhzyVJCuN+MDqLe5iWDizBlX1A5G0mESij4na2ZAais
 ndKVky6wleW+K4PxrN2/33L3HOcT3fiLxbfrV2IGWOGXUWMe0lJeag7m6gFjiXHZhIJuXxK9x9
 FES2Wi1BMGV0tDV/8a6rh/Ppn3H+AAAAA==
X-Change-ID: 20241015-dma3-mp25-updates-d7f26753b0dd
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime
 Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <dmaengine@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

The HW version of STM32 DMA3 inside STM32MP25 requires some tunings to
meet the needs of the interconnect. This series adds the linked list
refactoring feature to have optimal performance when addressing the
memory, and it adds the use of two new bits in the third cell specifying
the DMA transfer requirements:
- bit[16] to prevent packing/unpacking mode to avoid bytes loss in case
of interrupting an ongoing transfer (e.g. UART RX),
- bit[17] to prevent linked-list refactoring because some peripherals
(e.g. FMC ECC) require a one-shot transfer, they trigger the DMA only
once.
It also adds platform data to clamp the burst length on AXI port,
especially when it is interconnected to AXI3 bus, such as on STM32MP25.
Finally this series also contains STM32MP25 device tree updates, to add
DMA support on SPI, I2C, UART and apply the tunings introduced.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
Changes in v3:
- Refine commit description of patch 4 about preventing
  additionnal transfers, as per Rob's suggestion.
- Link to v2: https://lore.kernel.org/r/20241015-dma3-mp25-updates-v2-0-b63e21556ec8@foss.st.com

Changes in v2:
- Reword commit title/message/content of patch 4 about preventing
  additionnal transfers, as per Rob's suggestion
- Rework AXI maximum burst length management using SoC specific
  compatible, as pointed out by Rob
- Drop former patches 6 and 8, which are no longer relevant
- Link to v1: https://lore.kernel.org/r/20241010-dma3-mp25-updates-v1-0-adf0633981ea@foss.st.com

---
Amelie Delaunay (9):
      dt-bindings: dma: stm32-dma3: prevent packing/unpacking mode
      dmaengine: stm32-dma3: prevent pack/unpack thanks to DT configuration
      dmaengine: stm32-dma3: refactor HW linked-list to optimize memory accesses
      dt-bindings: dma: stm32-dma3: prevent additional transfers
      dmaengine: stm32-dma3: prevent LL refactoring thanks to DT configuration
      dmaengine: stm32-dma3: clamp AXI burst using match data
      arm64: dts: st: add DMA support on U(S)ART instances of stm32mp25
      arm64: dts: st: add DMA support on I2C instances of stm32mp25
      arm64: dts: st: add DMA support on SPI instances of stm32mp25

 .../bindings/dma/stm32/st,stm32-dma3.yaml          |   6 ++
 arch/arm64/boot/dts/st/stm32mp251.dtsi             |  75 +++++++++++++
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts         |   2 +
 drivers/dma/stm32/stm32-dma3.c                     | 119 +++++++++++++++++----
 4 files changed, 182 insertions(+), 20 deletions(-)
---
base-commit: 76355c25e4f71ee4667ebaadd9faf8ec29d18f23
change-id: 20241015-dma3-mp25-updates-d7f26753b0dd

Best regards,
-- 
Amelie Delaunay <amelie.delaunay@foss.st.com>


