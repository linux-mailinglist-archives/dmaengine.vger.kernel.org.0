Return-Path: <dmaengine+bounces-1919-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3588AE618
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 14:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4193E283D55
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 12:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E5E85C48;
	Tue, 23 Apr 2024 12:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="QnvQYAZ6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ED969D2F;
	Tue, 23 Apr 2024 12:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875687; cv=none; b=p5rB+p27JWN947vc/6jP/1FDUi0g/EZT2g5QBl/0iinnI9LKRXdGH/gDZv0wKSRgKGtv1ubTGGensySluiV1KxnG4rJWPfAq0HI1EbS9OXzuSdtu0wG4SqzrMo2RitGqpenSUPw6aQGXp6OjNRiWSNucG2ao5QpFNAGI0Gtd7Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875687; c=relaxed/simple;
	bh=zxXvNBPwPj/6Mlh0JbjvwNioLR0mjTXRLOUdc9MB2lQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mL/jnb3vLq2jpCflo5z6ygHssFThyj2mvGFV+U7L5DLKBCr+XcUgV2At3gOepRzs+nQTY2fNMd6NscEtkRknpG4tuH20A5uw0QP+EdSfvHfwIOT02ZOXtw80CuT9UMhTt/PBj5AFJJ7MoNHBUksWDJJkc2y5vtpobhgiosoHXJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=QnvQYAZ6; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N83BUv026708;
	Tue, 23 Apr 2024 14:34:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=cJK4T4B
	KxNcciX0FgHTB0TzdT0JpRtgRnyjJ33vQ2rM=; b=QnvQYAZ6oY4Hg60B3zoTLDS
	uGcHqIjKtcXmJzlHU/yKC++9fVQD7f6jCc3Wkzqmjn+o97YHE/lMx7dy1QquUD+w
	qCbRLLfL+tbvOPE4CfcRLA2yGgVGmbEQvwXsecObnw0rf+5FmtmHJNFtcPlHWQST
	44WDBUlpblr2aHWUfnoUSD4M8L7U8UTxwVoGelVsJe/08VunEc4JDc74mdWe1tm4
	fK/av9jV6mceYCSilN9/BtEOVxNmt3R+6oVqwWB9IMclQQklFc+Q7XhoehrWkRuD
	5l77VyNpG9Rna/JjTLgSiBXgzY3ZrXqsyw6BoRh4plE4QetLN7T7QBNcaT3iz2w=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm51w3qpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 14:34:14 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 43C5440045;
	Tue, 23 Apr 2024 14:34:09 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CBC70217B6B;
	Tue, 23 Apr 2024 14:33:23 +0200 (CEST)
Received: from localhost (10.48.86.143) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 14:33:23 +0200
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
Subject: [PATCH 00/12] Introduce STM32 DMA3 support
Date: Tue, 23 Apr 2024 14:32:50 +0200
Message-ID: <20240423123302.1550592-1-amelie.delaunay@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_11,2024-04-23_01,2023-05-22_02

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
 .../bindings/dma/stm32/st,stm32-dma3.yaml     |  125 ++
 .../dma/{ => stm32}/st,stm32-dmamux.yaml      |    4 +-
 .../dma/{ => stm32}/st,stm32-mdma.yaml        |    4 +-
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
 17 files changed, 2117 insertions(+), 51 deletions(-)
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


