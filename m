Return-Path: <dmaengine+bounces-2227-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9168D653A
	for <lists+dmaengine@lfdr.de>; Fri, 31 May 2024 17:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C873A28D1C7
	for <lists+dmaengine@lfdr.de>; Fri, 31 May 2024 15:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B12C15666B;
	Fri, 31 May 2024 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="GILMG8zW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D094155C9C;
	Fri, 31 May 2024 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717168127; cv=none; b=AC3pO3dwpPa/BaREYDwsqPvLEBSrQDAT0+hPHOODYX4aRJ7Gnzr5McQvvovl/9Q4dZUQDYRZZ8FYD72O3kVIZC2RUOZPZLAA58OkNmaP6WSJ5KZ5RIZ7LRvxwt0uX7YgVXiGWYo1y3Pc4S7oVDXlWgBx/09zb1ssj3TvoqVX1Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717168127; c=relaxed/simple;
	bh=S/2HgYDcsPgUIHZNPE1o7C4K8GYl+f7zW1+VqrCj6R0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bcN41DTDGgS4CjwapaR+eDdcDL5kxuEkDcpZmOmoozBA8jGFiC5clBeX57Ti+Q0SYHT8Q5iI8gY9tkz+o5ZYyeJdh4sCZUtKB4bMUWjcXuuWp4JUFifM2CYhJcPvdMvMW0tsE9fF6FtzDpx8XT/b/mgg/e1gz3ez/Zs5dA9L7tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=GILMG8zW; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VEYxTk002355;
	Fri, 31 May 2024 17:08:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=6USuD96uu4MM6nbAWJ3YVs
	bwLkvBfK0BxbUwgRQnTLg=; b=GILMG8zWvp3xQvmGvyPa1P0njrIyTGrb7ubnO8
	4H5hhJwSN45rPz3yQge07ErB5lXVkyDR/IUtg8NfCYUqfgrwKqKeWjYqHNg5ai0F
	znoT1yQgNVeZB+1+yhWWkzClVjTjjcqQtQTVxGb0JAd8tUT1vn7hZpj4UZ3WkpKq
	8OmsSbdhPFVSgQ04w6bNNKwuortvO3Q45PDUdS3J8C60yyI6/9mlcLeKpAmmBK2w
	amrstuDAqJryzStBzLYQkr3upJnpPytnnKF/AxpSqIRu1oyFm+1boag9Z2AesgrR
	fU1an2+21aCKkSpl0b30IfC9lwQ6dj3Ev8tMt68i1rUwZgEw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yb9yymj96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 17:08:15 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2FBC940047;
	Fri, 31 May 2024 17:08:02 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2C2FB22364C;
	Fri, 31 May 2024 17:07:16 +0200 (CEST)
Received: from localhost (10.252.27.179) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 17:07:15 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        Amelie Delaunay
	<amelie.delaunay@foss.st.com>
Subject: [PATCH v4 00/12] Introduce STM32 DMA3 support
Date: Fri, 31 May 2024 17:07:00 +0200
Message-ID: <20240531150712.2503554-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_11,2024-05-30_01,2024-05-17_01

STM32 DMA3 is a direct memory access controller with different features
depending on its hardware configuration. It is either called LPDMA (Low
Power), GPDMA (General Purpose) or HPDMA (High Performance), and it can
be found in new STM32 MCUs and MPUs.

In STM32MP25 SoC [1], 3 HPDMAs and 1 LPDMA are embedded. Only HPDMAs are
used by Linux.

Before adding this new driver, this series gathers existing STM32 DMA
drivers and bindings under stm32/ subdirectory and adds an entry in
MAINTAINERS file.

To ease review, the initial "dmaengine: Add STM32 DMA3 support" has been
split into functionnalities.
Patches 6 to 9 can be squashed into patch 5.

Patch 10 has already been proposed [2], the API is now used in stm32-dma3
driver. Indeed, STM32 DMA3 channels can be individually reserved either
because they are secure, or dedicated to another CPU. These channels are
not registered in dmaengine, so id is not incremented, but, using the new
API to specify the channel name, channel name matches the name in the
Reference Manual and ease requesting a channel thanks to its name.

[1] https://www.st.com/resource/en/reference_manual/rm0457-stm32mp25xx-advanced-armbased-3264bit-mpus-stmicroelectronics.pdf
[2] https://lore.kernel.org/lkml/20231213174021.3074759-1-amelie.delaunay@foss.st.com/

v4:
- address Frank's remarks about patch 5: comments alignment, use __packed
  for stm32_dma3_hwdesc structure, use dma_wmb() instead of __iowmb();
  about patch 6: remove wrong MEM_TO_MEM comment

v3:
- address Rob's remarks about st,stm32-dma3.yaml
  (wrap at 80, remove useless '|')
- address Frank's remarks about patch 5: improve commit message and
  ensure descriptors availability before starting the channel

v2:
- fix reference in spi/st,stm32-spi.yaml with an updated description of the
  dmas property to reflect the new path of STM32 DMA controllers bindings.
- address Rob's remarks about st,stm32-dma3.yaml
- address Vinod's remarks about stm32-dma3.c

Amelie Delaunay (12):
  dt-bindings: dma: New directory for STM32 DMA controllers bindings
  dmaengine: stm32: New directory for STM32 DMA controllers drivers
  MAINTAINERS: Add entry for STM32 DMA controllers drivers and
    documentation
  dt-bindings: dma: Document STM32 DMA3 controller bindings
  dmaengine: Add STM32 DMA3 support
  dmaengine: stm32-dma3: add DMA_CYCLIC capability
  dmaengine: stm32-dma3: add DMA_MEMCPY capability
  dmaengine: stm32-dma3: add device_pause and device_resume ops
  dmaengine: stm32-dma3: improve residue granularity
  dmaengine: add channel device name to channel registration
  dmaengine: stm32-dma3: defer channel registration to specify channel
    name
  arm64: dts: st: add HPDMA nodes on stm32mp251

 .../dma/{ => stm32}/st,stm32-dma.yaml         |    4 +-
 .../bindings/dma/stm32/st,stm32-dma3.yaml     |  135 ++
 .../dma/{ => stm32}/st,stm32-dmamux.yaml      |    4 +-
 .../dma/{ => stm32}/st,stm32-mdma.yaml        |    4 +-
 .../devicetree/bindings/spi/st,stm32-spi.yaml |    2 +-
 MAINTAINERS                                   |    9 +
 arch/arm64/boot/dts/st/stm32mp251.dtsi        |   69 +
 drivers/dma/Kconfig                           |   34 +-
 drivers/dma/Makefile                          |    4 +-
 drivers/dma/dmaengine.c                       |   16 +-
 drivers/dma/idxd/dma.c                        |    2 +-
 drivers/dma/stm32/Kconfig                     |   47 +
 drivers/dma/stm32/Makefile                    |    5 +
 drivers/dma/{ => stm32}/stm32-dma.c           |    2 +-
 drivers/dma/stm32/stm32-dma3.c                | 1847 +++++++++++++++++
 drivers/dma/{ => stm32}/stm32-dmamux.c        |    0
 drivers/dma/{ => stm32}/stm32-mdma.c          |    2 +-
 include/linux/dmaengine.h                     |    3 +-
 18 files changed, 2137 insertions(+), 52 deletions(-)
 rename Documentation/devicetree/bindings/dma/{ => stm32}/st,stm32-dma.yaml (97%)
 create mode 100644 Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
 rename Documentation/devicetree/bindings/dma/{ => stm32}/st,stm32-dmamux.yaml (90%)
 rename Documentation/devicetree/bindings/dma/{ => stm32}/st,stm32-mdma.yaml (96%)
 create mode 100644 drivers/dma/stm32/Kconfig
 create mode 100644 drivers/dma/stm32/Makefile
 rename drivers/dma/{ => stm32}/stm32-dma.c (99%)
 create mode 100644 drivers/dma/stm32/stm32-dma3.c
 rename drivers/dma/{ => stm32}/stm32-dmamux.c (100%)
 rename drivers/dma/{ => stm32}/stm32-mdma.c (99%)

-- 
2.25.1


