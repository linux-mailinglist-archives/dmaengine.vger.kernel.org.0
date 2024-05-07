Return-Path: <dmaengine+bounces-1991-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5E08BE2A1
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2024 14:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E918A2824E8
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2024 12:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587D215D5CB;
	Tue,  7 May 2024 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="BPenHDmB"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B4415B979;
	Tue,  7 May 2024 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715086570; cv=none; b=E6KIFZMEnKzFPRqOMB883CGYfGtPtKIpvsIFRe5AKGAvEcfRX/zSrssuSMxlLI4TVZf/dCyJUrXT8fF7b8AOaY0meZ0/DYmF1/8uJAjJUwq6DVKXlDFfI/4ARmcI9xyqz0/ufMMAsMPQehJfVWu+J01g0f5rv0Tgko+/bCvPqRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715086570; c=relaxed/simple;
	bh=cEi1PlhDqdJFIXNSbPSlR2z8gDcsO0GtAxgoHW5zjW0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L8UAJ0T0I82aBbGDfCLS1Yfm10ZG2e1rA/eYi+kBUXDgODnKvuWyx/KAYxEz0xDE0Sbc2nFpteDYSvqEK3CkNmXFH2G02JYI9/Xcac3WA8pdBg56DyinzRLsa31EUbqBvh7hCQtI6tNIG2NYU7yLceKX4X7h0h9B9FePbSQNhBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=BPenHDmB; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447AWM7P003739;
	Tue, 7 May 2024 14:55:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=B71LdPH
	LX0EpUal4IZpX8dJNEPs8HDjVe69ayFWF9c0=; b=BPenHDmBlzpto+bdI/BvHeQ
	aXwxkksh3O4G2/3elYr/nUt2ld8QM8Y2HotfN/qUpV5BfxxasV0OcfXEzxqmMP47
	twxbgUPQyOaNtiTE56NFPTcFDazVyFolqWwBiXbKAy+SvclmuyBVdVzfKU2XnQB0
	QdnndU+/fsX/qZ3gc9h0v4f6Cpf6KGIaBtH26f3CFCBy5xNTbSuREArVYGsqKkCr
	i80aepOXYGiguPurzVecNUL5uZ1SLr4OHlOKeXJCUQtLJI0XNhjeWymvDkvK2PDl
	AIIb8SOinGpHOZlBgCRBGLG76IPLUpyecqdVM4+eO4/3zgGx2CyoTv4x9zcYm+Q=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xwxk1hx9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 14:55:51 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6522F40046;
	Tue,  7 May 2024 14:55:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7B5DE2171E5;
	Tue,  7 May 2024 14:55:01 +0200 (CEST)
Received: from localhost (10.48.86.143) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 7 May
 2024 14:55:01 +0200
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
Subject: [PATCH v2 00/12] Introduce STM32 DMA3 support
Date: Tue, 7 May 2024 14:54:30 +0200
Message-ID: <20240507125442.3989284-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_06,2024-05-06_02,2023-05-22_02

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
 .../bindings/dma/stm32/st,stm32-dma3.yaml     |  129 ++
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
 drivers/dma/stm32/stm32-dma3.c                | 1838 +++++++++++++++++
 drivers/dma/{ => stm32}/stm32-dmamux.c        |    0
 drivers/dma/{ => stm32}/stm32-mdma.c          |    2 +-
 include/linux/dmaengine.h                     |    3 +-
 18 files changed, 2122 insertions(+), 52 deletions(-)
 rename Documentation/devicetree/bindings/dma/{ => stm32}/st,stm32-dma.yaml (97%)
 create mode 100644 Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
 rename Documentation/devicetree/bindings/dma/{ => stm32}/st,stm32-dmamux.yaml (89%)
 rename Documentation/devicetree/bindings/dma/{ => stm32}/st,stm32-mdma.yaml (96%)
 create mode 100644 drivers/dma/stm32/Kconfig
 create mode 100644 drivers/dma/stm32/Makefile
 rename drivers/dma/{ => stm32}/stm32-dma.c (99%)
 create mode 100644 drivers/dma/stm32/stm32-dma3.c
 rename drivers/dma/{ => stm32}/stm32-dmamux.c (100%)
 rename drivers/dma/{ => stm32}/stm32-mdma.c (99%)

-- 
2.25.1


