Return-Path: <dmaengine+bounces-3368-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFC199E97A
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2024 14:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE272815E4
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2024 12:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D15E1F7096;
	Tue, 15 Oct 2024 12:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ka+qkpDN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B61C1F472C;
	Tue, 15 Oct 2024 12:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994603; cv=none; b=YDoQJY+hVuarrokp3+Fuil2AUDq3yl7W+RopbDJ7IyUlOPOeW2lEyqXmkLwDfWDXY/EKTndsm014ViHLMLdl8sFL0UTy+N3r8Qc8jxUu9X1rfg7EmJw6+Tc0xvZ3F3gsLxmYdG3pZUC/GhOip7TrSwkXmwhvrva25671cwJHbjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994603; c=relaxed/simple;
	bh=QfRpg1N8HJzqb7kAsca7fbXNPL8IEO435EsP2C0HVx8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=ajS5uw4Qru3vVBhtszoFFe4tvZWy2tPy9Hoqjn+k1rz0Vg424JRt76qI2MjBVwwd6RhTJJ+8SBgSf97CSORBGNYMprImkWNRG5jFeyp5P4unz8GlIhELIbJwdPaXbgivEMYpn6zzzi1PwoLv/yHMrjhvlMj2zSdnsmD31WYij+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ka+qkpDN; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FBubZs011450;
	Tue, 15 Oct 2024 14:16:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=g6kvc2we0FTaSO5rALzSDf
	YvQSPTjQnFDifCa35kdNc=; b=ka+qkpDNQop3eTUFZg3WZDEisQj/xi0BzS/6hC
	kvlanPFQRyO8/Jt1gzxo0tVjL72cBIQrSI0STBKwdaLXaiUGHG2r28++kIXzHE6X
	h2TNoHjzfeZxNb1bv9+n33y+QpzGJ/t7byYfDE/DniwAP6uDt6vuEpJLzo88r7ZW
	sIvx/8iQ7SSs+uvPdY8U9ZadzPd85xNXwI6jlfE0P+T64nHdxzc2UuCicfp3bGsa
	hEMWcn0fj4xhJQM/xjXfuR+xdY87ZKu/qA8mVhNIUUOPmAP2jhDx+c3J+NRh0P3r
	Hv+ILoAMXDmQeWadGmSiPYK4iviQWvW4lsjF2a27u86qBl2Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 429qyb835n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 14:16:16 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1095F40046;
	Tue, 15 Oct 2024 14:15:24 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9587E222331;
	Tue, 15 Oct 2024 14:14:46 +0200 (CEST)
Received: from localhost (10.48.87.35) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 15 Oct
 2024 14:14:46 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH v2 0/9] STM32 DMA3 updates for STM32MP25
Date: Tue, 15 Oct 2024 14:14:36 +0200
Message-ID: <20241015-dma3-mp25-updates-v2-0-b63e21556ec8@foss.st.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKxcDmcC/22Nyw6CMBBFf4XM2iF9CKgr/8OwqMxUuoCSDhIN4
 d+tJO5cnpPcc1cQToEFLsUKiZcgIY4ZzKGArnfjgzFQZjDKHLXSFdLgLA6TqfA5kZtZkBpv6qa
 yd0UEeTcl9uG1N29t5j7IHNN7v1j01/5q6k9t0ajQkVe1teeTZnf1UaSUueziAO22bR/A/uoBt
 AAAAA==
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


