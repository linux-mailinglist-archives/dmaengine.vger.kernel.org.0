Return-Path: <dmaengine+bounces-1924-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B31EB8AE631
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 14:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BAB21F25778
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 12:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2825127E12;
	Tue, 23 Apr 2024 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Ve2srZ8Z"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5748662E;
	Tue, 23 Apr 2024 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875732; cv=none; b=PLGaa2LT7cIrPq43amt6eEXTzbC1bBTINpCabXGVWPFAmEE7L3ouiGk1/z8dhIJmDDTXgE0gS0XygYgltwOdHXMxvWn02HuYRLQfZkONmbJELgrRMgG7dfDzXqxsgnFl97iL2T9E6XBhLDg1xBkNhTMEJo8cRSTpCKaqtj2zXcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875732; c=relaxed/simple;
	bh=KUMjCLwyexGHehdITk2osDVTjluDSc2/d0GeWnJvpSM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/IIatsfP86SeNjmMkosHg7IkT2xADQMPU4jFXiqnrZONEqS6e/2D8eujzDvRN1dzMbv9PgRObyLzkpuGK4WTo6Eej99iG0N1IJkK3u+uSyvN7CwfZ1/XEgAa1EVhfXKZzUssvqqAYMnNH54gC/JegGs0lZrRS93MU/0Tglvr30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Ve2srZ8Z; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43NC6KsN010851;
	Tue, 23 Apr 2024 14:35:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=0lRkuvSdl6Mlk2dshvBI3b/EuEs0Up49ERtTgNfVIko=; b=Ve
	2srZ8ZVfWjqUZwDN6YcdSRE8qIiAnyBsbP7mODYk9bBv7X2fI7sXIfStzGny6VKg
	DCXy6ABlYP2v4ji6Sive6NMWJvV0QXB1D1gmF0bh3qRNxuRI1aUq4VX7cSW0O23H
	RyBys7WdYXo8Sz411BlCOO844ju+STdqqSWblsnMWBjfrUbpA6j6oZGortZzZmOE
	pHtzI4kWdRkY8Bw69hRvMmjGP3YRRcAtvKzscJbb4WeQoaGp1emPJ8N67OV9u/7/
	swTKX5FKHnMGdrgNPoc2CGbCBydCMp4uz+A8X/75WHO9bieyfUf+RifzWsZNafTV
	0CcvjYRp2w8NwAdFHpNg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm4edudu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 14:35:18 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id EA68440045;
	Tue, 23 Apr 2024 14:35:14 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1DE6021A23C;
	Tue, 23 Apr 2024 14:34:30 +0200 (CEST)
Received: from localhost (10.48.86.143) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 14:34:29 +0200
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
Subject: [PATCH 08/12] dmaengine: stm32-dma3: add device_pause and device_resume ops
Date: Tue, 23 Apr 2024 14:32:58 +0200
Message-ID: <20240423123302.1550592-9-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240423123302.1550592-1-amelie.delaunay@foss.st.com>
References: <20240423123302.1550592-1-amelie.delaunay@foss.st.com>
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

STM32 DMA3 controller is able to suspend an ongoing transfer (the transfer
is suspended after the ongoing burst is flushed to the destination) and
resume it from the point it was suspended. No need to reconfigure any
register.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32/stm32-dma3.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index 73e856a5aeab..3d827c33150e 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -1240,6 +1240,35 @@ static int stm32_dma3_config(struct dma_chan *c, struct dma_slave_config *config
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
@@ -1476,6 +1505,8 @@ static int stm32_dma3_probe(struct platform_device *pdev)
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


