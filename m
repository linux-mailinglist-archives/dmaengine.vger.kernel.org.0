Return-Path: <dmaengine+bounces-1995-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3105E8BE2C1
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2024 14:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB3782814B5
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2024 12:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA9A15E217;
	Tue,  7 May 2024 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="xPMayQSH"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2B915E1E8;
	Tue,  7 May 2024 12:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715086636; cv=none; b=iQLSHYYREGCgL5ZQ0WeX5xc+GroJ6NfVnNjUMCD9TfoI81kHety4yRd8MRzNicqTAZBQoI4I4CyqC996I2GcAklbZgXjsxKYiTblprbxRN1vI52UqPlcwurUWkMjitmHNbqALxhozc6HPfkJaftZzpl3VwMclCfF9KzAD2hnizw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715086636; c=relaxed/simple;
	bh=kykdTLD6GyuwR1lrBR7FvBVi1Ca7wkXL8Cxo8Mx0p+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T1+dAVqcFUoznHVCoXtGLe+mYgSnREKCkC2JwVa6LOO6xjO2RECFilQ5aKI+f4Zb6rLybPg/0VRgjmnMticb0lJiBnDDYluMgKJCLlCCvjL5eU5e/phxXR93EPxVeWtzI1LmIkkIIoQ4YVrAamqt4bmk7lgmMpzRe0qUAZtSobk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=xPMayQSH; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447Ag3IP009953;
	Tue, 7 May 2024 14:57:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=DJhhNPqjD+GWnDokMHmSRxmvL0BhYrxXJRadIzTOPx8=; b=xP
	MayQSHaIu2V3MSTaaiP8LiXiBdbvDVlI+EAnglqORe57YbKrPMJCXr/KgA/LI1Gd
	fF73JZf72SH1gqw5r9O88R0phW/Y1zA2m1xElbKd0gmbWYJT5zRNlZP+yj6ro4ck
	HKMhBLaPfVQzUB44WZbwXJoHZFkirceMAlkRqaKmHdmfW8qdFlU3iuUqElGVUQHz
	RhXpe4kg2/nppBmB/SKZwAQfb7OUEZN4T+lgbwTqCyVkEBiFg5QxwdgrpPyGjB9t
	NHxRSEkwhRmecFvVRXPDXt4H4ZeIEUpQSxLoOa7nPP3p6eg1d6VD6CRCcNnDTk6W
	AhFZgABVjnRKtL/T5zmA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xwcbxbsh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 14:57:01 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5E00140047;
	Tue,  7 May 2024 14:56:57 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E37A4216ECE;
	Tue,  7 May 2024 14:56:07 +0200 (CEST)
Received: from localhost (10.48.86.143) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 7 May
 2024 14:56:07 +0200
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
Subject: [PATCH v2 08/12] dmaengine: stm32-dma3: add device_pause and device_resume ops
Date: Tue, 7 May 2024 14:54:38 +0200
Message-ID: <20240507125442.3989284-9-amelie.delaunay@foss.st.com>
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

STM32 DMA3 controller is able to suspend an ongoing transfer (the transfer
is suspended after the ongoing burst is flushed to the destination) and
resume it from the point it was suspended. No need to reconfigure any
register.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32/stm32-dma3.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index 49e9695357e7..ca0d1a1c0393 100644
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


