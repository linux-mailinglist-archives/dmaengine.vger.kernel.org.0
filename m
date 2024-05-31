Return-Path: <dmaengine+bounces-2229-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A94568D6542
	for <lists+dmaengine@lfdr.de>; Fri, 31 May 2024 17:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6067F1F24694
	for <lists+dmaengine@lfdr.de>; Fri, 31 May 2024 15:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DC57580D;
	Fri, 31 May 2024 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="tHCPvq/T"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E352974E3D;
	Fri, 31 May 2024 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717168163; cv=none; b=LupfhJKD2HAlPXDAjCSSsfpcbOk7bAV4VJDLmdF2tTk21hIHLcffb+KVCMMOhaSIvoCN8HHRHSsR8/NDmSU0D9+zvZL+C1BhqQ1rh5/epRZEqZpoK14ZXqoMSVA7jGtrARBaxVpFMLRMorFs2/Acw8jQCXzRC4GMheoDlnz5gGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717168163; c=relaxed/simple;
	bh=oW2t5ag0ZkozlerNKcl0RbY79P6OzHDZCz9xIY+kkqA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWWe3FK7g4lOKHy7MVHlDduMDczJSfXFgibk20oqmm8e3e7GepKpAtk4zsO4H97lIbG9klmRfjTW3MAsZUy4MhP5TbkoEYiZ+LImwj17bOGox3gNhnyFQpJ7geXE/13n4LxF3jGE3BZ1YWCzjk/ujgsEeEHTPSknzK4sLSXHFD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=tHCPvq/T; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VBgIaT017539;
	Fri, 31 May 2024 17:09:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	d/41qmVRGtCEJSSQ0gxUanK9zaOsFRj77dN7gb5e9uY=; b=tHCPvq/Tt0gf6ck/
	TgOdLcNqzgXPjuzkKqN9kLtZ+3xSskSbhr9sWiJdTJS/y/ahfX0oUqapRpOMz8Fe
	WrydgMUcqvPS/dvC3SScC8QLs8WEvuEczrVWQYs0mFbsao4ZpG9CJ+o+OYcoCfFE
	DojYQ04PTiIn7t+oNEBtpRmVgACnpJxcZIfwnNVQheLJYJZJqJESHAm7QK5oyqUd
	OeqyoJrMX2yaDFntiCFra+ozS+eSM98s3zf9zwmNCjhzzUE4UaSw5yMHxADqN4q1
	ihI1rcoa8R06kTfdcpyZQuFADUHBH5/4KrdCT9lqAgzOfIjrOIvaRDsAQhfglZZL
	6u4Rtw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ybsj1357g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 17:09:11 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C2F8940049;
	Fri, 31 May 2024 17:09:06 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 95B75220B60;
	Fri, 31 May 2024 17:08:22 +0200 (CEST)
Received: from localhost (10.252.27.179) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 17:08:22 +0200
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
Subject: [PATCH v4 08/12] dmaengine: stm32-dma3: add device_pause and device_resume ops
Date: Fri, 31 May 2024 17:07:08 +0200
Message-ID: <20240531150712.2503554-9-amelie.delaunay@foss.st.com>
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

STM32 DMA3 controller is able to suspend an ongoing transfer (the transfer
is suspended after the ongoing burst is flushed to the destination) and
resume it from the point it was suspended. No need to reconfigure any
register.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32/stm32-dma3.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index 31c5b0e3fd18..5032d74d6288 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -1249,6 +1249,35 @@ static int stm32_dma3_config(struct dma_chan *c, struct dma_slave_config *config
 	return 0;
 }
 
+static int stm32_dma3_pause(struct dma_chan *c)
+{
+	struct stm32_dma3_chan *chan = to_stm32_dma3_chan(c);
+	int ret;
+
+	ret = stm32_dma3_chan_suspend(chan, true);
+	if (ret)
+		return ret;
+
+	chan->dma_status = DMA_PAUSED;
+
+	dev_dbg(chan2dev(chan), "vchan %pK: paused\n", &chan->vchan);
+
+	return 0;
+}
+
+static int stm32_dma3_resume(struct dma_chan *c)
+{
+	struct stm32_dma3_chan *chan = to_stm32_dma3_chan(c);
+
+	stm32_dma3_chan_suspend(chan, false);
+
+	chan->dma_status = DMA_IN_PROGRESS;
+
+	dev_dbg(chan2dev(chan), "vchan %pK: resumed\n", &chan->vchan);
+
+	return 0;
+}
+
 static int stm32_dma3_terminate_all(struct dma_chan *c)
 {
 	struct stm32_dma3_chan *chan = to_stm32_dma3_chan(c);
@@ -1485,6 +1514,8 @@ static int stm32_dma3_probe(struct platform_device *pdev)
 	dma_dev->device_prep_dma_cyclic = stm32_dma3_prep_dma_cyclic;
 	dma_dev->device_caps = stm32_dma3_caps;
 	dma_dev->device_config = stm32_dma3_config;
+	dma_dev->device_pause = stm32_dma3_pause;
+	dma_dev->device_resume = stm32_dma3_resume;
 	dma_dev->device_terminate_all = stm32_dma3_terminate_all;
 	dma_dev->device_synchronize = stm32_dma3_synchronize;
 	dma_dev->device_tx_status = dma_cookie_status;
-- 
2.25.1


