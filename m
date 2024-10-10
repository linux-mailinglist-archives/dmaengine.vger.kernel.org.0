Return-Path: <dmaengine+bounces-3323-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AAC998A0D
	for <lists+dmaengine@lfdr.de>; Thu, 10 Oct 2024 16:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410FD1F270D9
	for <lists+dmaengine@lfdr.de>; Thu, 10 Oct 2024 14:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA611F8F0F;
	Thu, 10 Oct 2024 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="pVhB0R01"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993A81F892A;
	Thu, 10 Oct 2024 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570710; cv=none; b=bw2st9MZhiAbgHd+cVmo7PVKm0YHRD0lQIHWe4cZQ/bV76T6clIiYetaouqpFqCqjv4v8CDz33cKsFzVQXaYC6dI2tgHcvxjTWzF2mNF4xykpbnmDaDe669Z3LxtvHf/eJsiHCfKmXBN92OaZzAVkU2eyGu0Q6Z2jVp5vCvl8Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570710; c=relaxed/simple;
	bh=5b5rfrygcx7Qo9y6A9GF0vdCRsrnMPdtDmlEDViOX1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=AVPNqLMeYr24YRHqmOR0awO/1xUpmCfHFaWpTC5dlqjcAlZ+zBzWcaFROtVGs4Kelvy6gdJIQwE0Y7IL4KcEewGhrk1VCCG+tVqQ+6XSkLQVrexqXACFVp/0LHgL/CaA7a+r3T+TVacVVuEr7cLd+/AEXmAgcct/ojCo+zmEwe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=pVhB0R01; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AEMAQA014760;
	Thu, 10 Oct 2024 16:31:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	8zvSJPaOxFyx6iKmFarEMp7/qdMh7rTZXLJBCgsAQ4g=; b=pVhB0R01g1VunsM7
	vmZThmKunyzqYZk7aV16FlLXg4imz4TEuz0xxLJ7s2+FeN2uDyQWhA1rW7c8YkrO
	6t3sxtH96U5OhtHWFK8OXhIPoJ40VkZuBz9I6W1lXxhNCODOga6PvP2G8qxHzkbm
	VIo7rSPsRY1u8EEPvfJkMQii2WP6TLi0FXPazeY4zntqkxyNVn6KbybjMz3q8wLA
	8W2G15DzxX6LxQeJWmn3XiEubR1Y2Q/2eYSgQ0HMvZtwjBKbuNnWGblvspJ9RwD1
	GmRqj28CflRGlTka8FT5jY3i7HLB8ZUT9tdw+wp4OuoiTEqvs8C5jJ298RlAGVO7
	suXOWA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 425q97xxb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 16:31:33 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5486940069;
	Thu, 10 Oct 2024 16:30:21 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2464D2954A5;
	Thu, 10 Oct 2024 16:28:07 +0200 (CEST)
Received: from localhost (10.252.31.182) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 10 Oct
 2024 16:28:06 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Thu, 10 Oct 2024 16:27:51 +0200
Subject: [PATCH 01/11] dt-bindings: dma: stm32-dma3: prevent
 packing/unpacking mode
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241010-dma3-mp25-updates-v1-1-adf0633981ea@foss.st.com>
References: <20241010-dma3-mp25-updates-v1-0-adf0633981ea@foss.st.com>
In-Reply-To: <20241010-dma3-mp25-updates-v1-0-adf0633981ea@foss.st.com>
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

When source data width/burst and destination data width/burst are
different, data are packed or unpacked in DMA3 channel FIFO.
Data are pushed out from DMA3 channel FIFO when the destination burst
length (= data width * burst) is reached.
If the channel is stopped before the transfer end, and if some bytes are
packed/unpacked in the DMA3 channel FIFO, these bytes are lost.
Indeed, DMA3 channel FIFO has no flush capability, only reset.
To avoid potential bytes lost, pack/unpack must be prevented by setting
memory data width/burst equal to peripheral data width/burst.
Memory accesses will be penalized. But it is the only way to avoid bytes
lost.

Some devices (e.g. cyclic RX like UART) need this, so add the possibility
to prevent pack/unpack feature, by setting bit 16 of the 'DMA transfer
requirements' bit mask.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
index 7fdc44b2e6467928622a5bb25d9e0c74bb1790ae..5484848735f8ac3d2050104bbab1d986e82ba6a7 100644
--- a/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
+++ b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
@@ -96,6 +96,9 @@ properties:
                including the update of the LLI if any
           0x3: at channel level, the transfer complete event is generated at the
                end of the last LLI
+        -bit 16: Prevent packing/unpacking mode
+          0x0: pack/unpack enabled when source data width/burst != destination data width/burst
+          0x1: memory data width/burst forced to peripheral data width/burst to prevent pack/unpack
 
 required:
   - compatible

-- 
2.25.1


