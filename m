Return-Path: <dmaengine+bounces-2001-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A72278BE2DA
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2024 14:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3834F282037
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2024 12:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525F815D5DF;
	Tue,  7 May 2024 12:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="MjAKuWHr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C18D15CD52;
	Tue,  7 May 2024 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715086703; cv=none; b=TB7/xY/HILCfu2+tzfWCy5D0kecWG5CieZRxQw1aniqHDpycyv8uu9uf+2OBkL+pVOiBwcTvZLKH0GeYG4cFLU9by5iB2NtohVAehfQnDAxr8IWxt6Z3/3KWw8QXciswDnWfghy7wlHVoGUpWxqB/6IU92QWThd0DuKBSpBzIg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715086703; c=relaxed/simple;
	bh=T8bslAKRqxJExlxgU1APuCZzGOWpiArPPHFegRwlIhU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iCcN3eux8hpv6F8xjiJFmbkw0P8rgExdF5AauqoyCN6gqy4OCD/aq499rHvcYz6kbujsMaqq2p4Cd6i54uPc7zU1N/CleyjjP5K7UrX1Y9RAnS+5887oPHNyYIadu2DB6jNBlhwQc1mFaKo6uthyFkKdr8GZIGO87DTeF4wGXTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=MjAKuWHr; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4479DQLK009471;
	Tue, 7 May 2024 14:57:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=3LWw0oi1+WnuQj6m27oXKk6NwtCESSjmCkn0shxu4NM=; b=Mj
	AKuWHrfqbR5hFyL9SKXrp/sMFJhrYe+cbe6nhUr3VXgluNZF3z0D66Edr8rM7pVi
	O/fLAoLTH/1/ceMNC59GlBmJ5W5m4NXJ5gbkRM6b4ooCIrkjrotUnCh6daK4l9Z/
	0R6Xvo0ykJHAPHoXyeb2T5NuyJ0aH0JGTaZk78EiEM3rPZQqKqaPnCFnemH18fDf
	WOJYlZnM+Ne8tsDFV4PI5i7DD9YaHHuxFbcp8uHWlBLIe7Sc/KFWShx7fllspq77
	28w/9Q75wzRjF8lq4sSGCxp/AzfhpgMkvVC0PXr/H2UUVAIvyA/QNX+0N7QLKoy9
	w2ybyxDVOXTeswfjYOtw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xwaegc64t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 14:57:59 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 18DE640045;
	Tue,  7 May 2024 14:57:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 41626217B79;
	Tue,  7 May 2024 14:57:10 +0200 (CEST)
Received: from localhost (10.48.86.143) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 7 May
 2024 14:57:09 +0200
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
Subject: [PATCH v2 11/12] dmaengine: stm32-dma3: defer channel registration to specify channel name
Date: Tue, 7 May 2024 14:54:41 +0200
Message-ID: <20240507125442.3989284-12-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507125442.3989284-1-amelie.delaunay@foss.st.com>
References: <20240507125442.3989284-1-amelie.delaunay@foss.st.com>
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
index c7df5d4d34d6..bc6fa7fdcb07 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -1723,9 +1723,6 @@ static int stm32_dma3_probe(struct platform_device *pdev)
 		chan->fifo_size = get_chan_hwcfg(i, G_FIFO_SIZE(i), hwcfgr);
 		/* If chan->fifo_size > 0 then half of the fifo size, else no burst when no FIFO */
 		chan->max_burst = (chan->fifo_size) ? (1 << (chan->fifo_size + 1)) / 2 : 0;
-		chan->vchan.desc_free = stm32_dma3_chan_vdesc_free;
-
-		vchan_init(&chan->vchan, dma_dev);
 	}
 
 	ret = dmaenginem_async_device_register(dma_dev);
@@ -1733,14 +1730,26 @@ static int stm32_dma3_probe(struct platform_device *pdev)
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


