Return-Path: <dmaengine+bounces-2234-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B85918D655E
	for <lists+dmaengine@lfdr.de>; Fri, 31 May 2024 17:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C262B1C258D0
	for <lists+dmaengine@lfdr.de>; Fri, 31 May 2024 15:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF03762E8;
	Fri, 31 May 2024 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="kZPcKcj5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7207580D;
	Fri, 31 May 2024 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717168234; cv=none; b=GmCkg3JUi4vU8v45fSI4em7JUg+EWOEa0Tu2bSZCxhsPbRDYGuBrtS49mF+HT7jS1JohLAviF5JtWWKqu+3q3jw25h6dB3DCpd+e5lWWcHacDJNOsNMGa9P5/DMx5t/SyLCOTQC4wFErD+C8OeSMC0YbnYIF+r5tJhbVBJGZP1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717168234; c=relaxed/simple;
	bh=LIsP3X2XqQ9KjJgQNKXDGbnTzcEjsXl+faeoX/w+qT8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Asc2IXefKohqxo3zJN0L5jnP81MjdFnEmG3kr4HDuYRtIB2U/gHiT14Dhnay2v3IFSjv40ZnuAqYz+rlj7XZikRQLOh67n1hWhDbs4l7aqOrLenKIhUxxB7LjIJZ1+kUo0gGH4HOaGEzm8u4UlciqL/1b5OIP8xuT6nPJRE3Srs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=kZPcKcj5; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VDnIcl015872;
	Fri, 31 May 2024 17:10:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	64wt0pzZ2kSRPpOSzALQl3R/464mRk7ij9nfrGdQFww=; b=kZPcKcj5E94ulSWg
	4XQYKORgCPyuDzJ9S818wavq/eIAdCOpqkcRtQBbABps+NVHdEbrfO+p44Zlo7dH
	yxrB9O2HD2JOBjnjGAwUiezb/SZaOr5moSz7MQs+ROI2KWEmny7gNedFM7r9u5gr
	Suq1PbutAml0ot/ZnemsxjD37iwANtZhi4sSsbAoKYyRPSXKsW6Zlm4SwHhRiTkw
	AlZPEHzvSpRML4qXirzuKvcMhkIK54W9kJ/4Y9HnVyD9UU8XlashGosyWPzEd16R
	Jx1emC+6JkVCUACFTMmD+SrBIVKM15tQ0Zvz7sSmtxPS8kUpRiDtvUqppKrhQhjf
	1tytmw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yba52ceqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 17:10:14 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D3D9840048;
	Fri, 31 May 2024 17:10:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0EAF5207FF0;
	Fri, 31 May 2024 17:09:25 +0200 (CEST)
Received: from localhost (10.252.27.179) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 17:09:24 +0200
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
Subject: [PATCH v4 11/12] dmaengine: stm32-dma3: defer channel registration to specify channel name
Date: Fri, 31 May 2024 17:07:11 +0200
Message-ID: <20240531150712.2503554-12-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240531150712.2503554-1-amelie.delaunay@foss.st.com>
References: <20240531150712.2503554-1-amelie.delaunay@foss.st.com>
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
index 9249b64a4455..4e932c2931dc 100644
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


