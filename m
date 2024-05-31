Return-Path: <dmaengine+bounces-2236-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9829D8D659B
	for <lists+dmaengine@lfdr.de>; Fri, 31 May 2024 17:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F169B2F0D7
	for <lists+dmaengine@lfdr.de>; Fri, 31 May 2024 15:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA84116F0C3;
	Fri, 31 May 2024 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="onmQnlaV"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8CB75817;
	Fri, 31 May 2024 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717168234; cv=none; b=iOxmmWbq75UFxywmjePKKzdJOIlPtZfG3gR10Kt4OH17MnEZIRm7g0nplsWjLj1UCfV+GguOlUI5oSFKFKmnJqg49mPnzVqChpUoT3gCv0QCvpebNHr8rxisAPHWXlQwXARLG3iaptY9OL6yiUYsRoX8hwfpdZ9U7m7p20oDr8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717168234; c=relaxed/simple;
	bh=qad6qskwZYQn+D5N1xzwJq/c78GJYvm0C1sRMaB+DyM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m89rtY5dhnqBR57OSLaIl2HooI4flgba5lXO2LpHFlKNoNHpg49mlKDOamJ2m3BgLTYmaXDDszW1i0K/FtnFZBaa13X139RKJxkXWULG1IN+u1Dti05fS6xuQxU9YJC9zuKxOWPJtFhs1aXG8zUdWysNSAzG5e2kUp2jScfaKWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=onmQnlaV; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VBkMSi027110;
	Fri, 31 May 2024 17:10:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	IOYWpx+7FTJlYFtMjUGlHKbBuJPgpevIoZcXKDKHnVE=; b=onmQnlaVOJU3cTev
	SQ2YOdm96SqIeOoosQIZkkwgz4xUAR751SnY3iblj5aCKhH3+tQb2WxEEpEErGhA
	V6Vq1u9NfROTK7ct/d7QvJWcdeuQ1ArAGIEiWfjsZKaBwvzr5Q4K5Z2mdfGwoPvk
	1MkUWUjtJhnDc2GNkoDF90oBh8N978bpK+NGOlq4O7e8pWNJYeWyWaDZzg0cM0p5
	F/nYZQvqMf/nuxhLsJ4sb6fQwNY2R8oHrgUwVsH/omewp2ow8fyzBkKX1444NaU1
	5h+m7MCBF0YuhKvh2y4n8Yz/WsfVdOLDcxLjf+feGddJKTmISqAnf76zYNc1/UuI
	DjCh0g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ybtxhtw5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 17:10:14 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0B9AF40047;
	Fri, 31 May 2024 17:10:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 43364207FE4;
	Fri, 31 May 2024 17:09:24 +0200 (CEST)
Received: from localhost (10.252.27.179) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 17:09:23 +0200
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
Subject: [PATCH v4 10/12] dmaengine: add channel device name to channel registration
Date: Fri, 31 May 2024 17:07:10 +0200
Message-ID: <20240531150712.2503554-11-amelie.delaunay@foss.st.com>
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

Channel device name is used for sysfs, but also by dmatest filter function.

With dynamic channel registration, channels can be registered after dma
controller registration. Users may want to have specific channel names.

If name is NULL, the channel name relies on previous implementation,
dma<controller_device_id>chan<channel_device_id>.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/dmaengine.c   | 16 ++++++++++------
 drivers/dma/idxd/dma.c    |  2 +-
 include/linux/dmaengine.h |  3 ++-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 491b22240221..c380a4dda77a 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1037,7 +1037,8 @@ static int get_dma_id(struct dma_device *device)
 }
 
 static int __dma_async_device_channel_register(struct dma_device *device,
-					       struct dma_chan *chan)
+					       struct dma_chan *chan,
+					       const char *name)
 {
 	int rc;
 
@@ -1066,8 +1067,10 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 	chan->dev->device.parent = device->dev;
 	chan->dev->chan = chan;
 	chan->dev->dev_id = device->dev_id;
-	dev_set_name(&chan->dev->device, "dma%dchan%d",
-		     device->dev_id, chan->chan_id);
+	if (!name)
+		dev_set_name(&chan->dev->device, "dma%dchan%d", device->dev_id, chan->chan_id);
+	else
+		dev_set_name(&chan->dev->device, name);
 	rc = device_register(&chan->dev->device);
 	if (rc)
 		goto err_out_ida;
@@ -1087,11 +1090,12 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 }
 
 int dma_async_device_channel_register(struct dma_device *device,
-				      struct dma_chan *chan)
+				      struct dma_chan *chan,
+				      const char *name)
 {
 	int rc;
 
-	rc = __dma_async_device_channel_register(device, chan);
+	rc = __dma_async_device_channel_register(device, chan, name);
 	if (rc < 0)
 		return rc;
 
@@ -1203,7 +1207,7 @@ int dma_async_device_register(struct dma_device *device)
 
 	/* represent channels in sysfs. Probably want devs too */
 	list_for_each_entry(chan, &device->channels, device_node) {
-		rc = __dma_async_device_channel_register(device, chan);
+		rc = __dma_async_device_channel_register(device, chan, NULL);
 		if (rc < 0)
 			goto err_out;
 	}
diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index cd835eabd31b..dbecd699237e 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -269,7 +269,7 @@ static int idxd_register_dma_channel(struct idxd_wq *wq)
 		desc->txd.tx_submit = idxd_dma_tx_submit;
 	}
 
-	rc = dma_async_device_channel_register(dma, chan);
+	rc = dma_async_device_channel_register(dma, chan, NULL);
 	if (rc < 0) {
 		kfree(idxd_chan);
 		return rc;
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 752dbde4cec1..73537fddbb52 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1575,7 +1575,8 @@ int dma_async_device_register(struct dma_device *device);
 int dmaenginem_async_device_register(struct dma_device *device);
 void dma_async_device_unregister(struct dma_device *device);
 int dma_async_device_channel_register(struct dma_device *device,
-				      struct dma_chan *chan);
+				      struct dma_chan *chan,
+				      const char *name);
 void dma_async_device_channel_unregister(struct dma_device *device,
 					 struct dma_chan *chan);
 void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
-- 
2.25.1


