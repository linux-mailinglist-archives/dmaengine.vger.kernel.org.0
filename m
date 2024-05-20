Return-Path: <dmaengine+bounces-2097-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5638CA047
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 17:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ECF31F21AE4
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 15:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F3813776F;
	Mon, 20 May 2024 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="GuUQz0F9"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E1B13774A;
	Mon, 20 May 2024 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716220395; cv=none; b=fLaTLZ7AWgHVnkaoOEeESQgqIfinPE+cp2D958lbWhWC7ojCC/Y3Yg8zgNfmavTc9FEQGoxFG253lBRGfBJ43B4s3V4mZrTa6yrHXcTV/oOFJVU4S/FnPmVjJVCKaHv+SfhxrrzupUDUpUGPPZy77kjeMw+OdXFWyra0spK2hqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716220395; c=relaxed/simple;
	bh=ILnwymi621lPlpoFkRDskqkkRvuQmz00E/3h92nd6IQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F2Wn9qVPd/QCLi2p72XYafuxLGv25Ghk3KQuW/Rbxcov/XSW3/TL8YQR5AHx5IPi3AsWnGwvBZEx+0lJWAtO059CkSWdlxz5o48aoekyq+RU3Fu0Q1oyMl4w6ginV6D0EOqdOQTkepsKe5Fl9szhfsYGeSpFhFs1bv72aucXXbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=GuUQz0F9; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44KE1sG3030566;
	Mon, 20 May 2024 17:52:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=YlEnxM7tvw/Wu4CrLzxpl5NjdYT0HOvuosZQESY5Y2g=; b=Gu
	UQz0F9RM5NbkdlulK69deGpQizyuP0hf3FpabVYQXjhB1uA/q7f0EKiGZY0ClD5H
	cRdMTO5ZY1XDShu+JhtJafZFbAzaBNkICt1WpNqkpffxR/F+LZTE/3F+dzOxZ4xN
	j7C9KoLNQcdhXuWPn8EBJQzUwE+qiSdprbyiL9UJyHd9nrH6yWXBHfD9t2VMsLdD
	lN9zKe1V7QU2jwjGRFMA0k9QDsQdVh7qYvSWoXn7MDu2N7s8Vy4cAC4pL2qG4vFa
	0rhVJg0f8cNdoaDTm1g+nf6jYL/ItKoe63feXzj9wQ7ygfogN05WRtLWNSpWG2mx
	NhJdTgFJSNp/HGTPfWyQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3y6n337q5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 17:52:52 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3D0EC40044;
	Mon, 20 May 2024 17:52:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 743D5226FBF;
	Mon, 20 May 2024 17:52:01 +0200 (CEST)
Received: from localhost (10.252.8.132) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 May
 2024 17:52:01 +0200
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
Subject: [PATCH v3 11/12] dmaengine: stm32-dma3: defer channel registration to specify channel name
Date: Mon, 20 May 2024 17:49:47 +0200
Message-ID: <20240520154948.690697-12-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240520154948.690697-1-amelie.delaunay@foss.st.com>
References: <20240520154948.690697-1-amelie.delaunay@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_09,2024-05-17_03,2024-05-17_01

On STM32 DMA3, channels can be reserved, so they are non available for
Linux. This non-availability creates a mismatch between dma_chan id and
DMA3 channel id.

Use dma_async_device_channel_register() to register the channels
after controller registration and change the default channel name, so that
it can match the name in the Reference Manual and ease requesting a channel
thanks to its name.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32/stm32-dma3.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index b0e917d52f59..43a0f02a74e0 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -1732,9 +1732,6 @@ static int stm32_dma3_probe(struct platform_device *pdev)
 		chan->fifo_size = get_chan_hwcfg(i, G_FIFO_SIZE(i), hwcfgr);
 		/* If chan->fifo_size > 0 then half of the fifo size, else no burst when no FIFO */
 		chan->max_burst = (chan->fifo_size) ? (1 << (chan->fifo_size + 1)) / 2 : 0;
-		chan->vchan.desc_free = stm32_dma3_chan_vdesc_free;
-
-		vchan_init(&chan->vchan, dma_dev);
 	}
 
 	ret = dmaenginem_async_device_register(dma_dev);
@@ -1742,14 +1739,26 @@ static int stm32_dma3_probe(struct platform_device *pdev)
 		goto err_clk_disable;
 
 	for (i = 0; i < ddata->dma_channels; i++) {
+		char name[12];
+
 		if (chan_reserved & BIT(i))
 			continue;
 
+		chan = &ddata->chans[i];
+		snprintf(name, sizeof(name), "dma%dchan%d", ddata->dma_dev.dev_id, chan->id);
+
+		chan->vchan.desc_free = stm32_dma3_chan_vdesc_free;
+		vchan_init(&chan->vchan, dma_dev);
+
+		ret = dma_async_device_channel_register(&ddata->dma_dev, &chan->vchan.chan, name);
+		if (ret) {
+			dev_err_probe(&pdev->dev, ret, "Failed to register channel %s\n", name);
+			goto err_clk_disable;
+		}
+
 		ret = platform_get_irq(pdev, i);
 		if (ret < 0)
 			goto err_clk_disable;
-
-		chan = &ddata->chans[i];
 		chan->irq = ret;
 
 		ret = devm_request_irq(&pdev->dev, chan->irq, stm32_dma3_chan_irq, 0,
-- 
2.25.1


