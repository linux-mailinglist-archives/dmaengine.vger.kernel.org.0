Return-Path: <dmaengine+bounces-3315-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6949989F8
	for <lists+dmaengine@lfdr.de>; Thu, 10 Oct 2024 16:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E8C41C24491
	for <lists+dmaengine@lfdr.de>; Thu, 10 Oct 2024 14:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D961E5034;
	Thu, 10 Oct 2024 14:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="169sq+2K"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0EB1E5019;
	Thu, 10 Oct 2024 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570698; cv=none; b=oKdWoLeEl0RZfjtOhrMldTMiaE/ZNDsQocTehN/vwM6eZVlp8D125KvL/KU2a4QxA4nzg0ygEPoy16l0eEzmm8pAzwqrGqUC2NXO4EkB+MpsVsXIZA0fMSYn50dK6aBUET/k/orWvO714ddti9h2RJJiqFkxp1ecDj0Y565xTVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570698; c=relaxed/simple;
	bh=zX/y3KjVM7XZ1/fA2LM2GqE67loJgY+qwscuZ4oeK4A=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=NOI3SpSNvYgMhtvHKhapkvVqLvlkTODX4pbfMnwRxaoIyqRhVHJ/OLacguSuvEcV3LD9pJTKkgvTm3uLi1u+17Uboy+pxUTFsbf2vENiQs9eALFNpcHpOSIbBjSlaFLVcSkC2nvM71fFyE6BFv5lmOBGnC7Ss5yxwCK7s/iJGVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=169sq+2K; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AE3d0V028646;
	Thu, 10 Oct 2024 16:31:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=5Wa1hO62y0JRJXVgsIkzCN
	ugxFg4hqAuzrDxJki9j+0=; b=169sq+2KQR2Av+gIn5Gdd0QA5BEmV9yU+Sdf+T
	ecVwlqDvfTFn5R8URk+SKvcOr6beiHs5vQSzcws6sQGTpUHOam3xhWx/qccAsbix
	VA77RN6lVJqMpN104yjjzadlq1oTnaRu8NtYSmmDgHJkXG4JKizd2uW4jCVrARTQ
	YGODFe0TcbeN76mOYoSGQhaSRv3+eia26KglJTTEicqyZRI62wG0Hsq1v73eDaNt
	ssmvrdybv+H60B28OO1xGYkQ1uO/Nj1W6dO/TWylTztrxz/cyffm/1hu+ST2U2Ry
	Jh7IpGM93+yjjScSgInYztjHBabRl1mJ1LxlYAnXpucZKLdw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4263434121-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 16:31:16 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C9B0B4008A;
	Thu, 10 Oct 2024 16:30:17 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 514BF289A51;
	Thu, 10 Oct 2024 16:28:06 +0200 (CEST)
Received: from localhost (10.252.31.182) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 10 Oct
 2024 16:28:06 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH 00/11] STM32 DMA3 updates for STM32MP25
Date: Thu, 10 Oct 2024 16:27:50 +0200
Message-ID: <20241010-dma3-mp25-updates-v1-0-adf0633981ea@foss.st.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGbkB2cC/x2MywqAIBAAfyX23ILai/qV6KC51R4s0YpA+vek4
 8DMJIgUmCIMRYJAN0c+9gyyLGDe9L4Sss0MSqhaCinQOl2h86rBy1t9UsS6NT11WeiFgdz5QAs
 //3Oc3vcDzqPYRGMAAAA=
X-Change-ID: 20241010-dma3-mp25-updates-46b9e720290b
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
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
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
of interrupting an ongoing transfer (e.g. UART RX)i,
- bit[17] to prevent linked-list refactoring because some peripherals
(e.g. FMC ECC) require a one-shot transfer, they trigger the DMA only
once.
It also adds a new property, st,axi-max-burst-len, to clamp the burst
length when AXI port is used.
Finally this series also contains STM32MP25 device tree updates, to add
DMA support on SPI, I2C, UART and apply the tunings introduced.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
Amelie Delaunay (11):
      dt-bindings: dma: stm32-dma3: prevent packing/unpacking mode
      dmaengine: stm32-dma3: prevent pack/unpack thanks to DT configuration
      dmaengine: stm32-dma3: refactor HW linked-list to optimize memory accesses
      dt-bindings: dma: stm32-dma3: prevent linked-list refactoring
      dmaengine: stm32-dma3: prevent LL refactoring thanks to DT configuration
      dt-bindings: dma: stm32-dma3: introduce st,axi-max-burst-len property
      dmaengine: stm32-dma3: clamp AXI burst using st,axi-max-burst-len
      arm64: dts: st: limit axi burst length in dma nodes of stm32mp25
      arm64: dts: st: add DMA support on U(S)ART instances of stm32mp25
      arm64: dts: st: add DMA support on I2C instances of stm32mp25
      arm64: dts: st: add DMA support on SPI instances of stm32mp25

 .../bindings/dma/stm32/st,stm32-dma3.yaml          |  17 ++++
 arch/arm64/boot/dts/st/stm32mp251.dtsi             |  78 +++++++++++++++
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts         |   2 +
 drivers/dma/stm32/stm32-dma3.c                     | 107 +++++++++++++++++----
 4 files changed, 185 insertions(+), 19 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241010-dma3-mp25-updates-46b9e720290b

Best regards,
-- 
Amelie Delaunay <amelie.delaunay@foss.st.com>


