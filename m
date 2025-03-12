Return-Path: <dmaengine+bounces-4719-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC52BA5E3BA
	for <lists+dmaengine@lfdr.de>; Wed, 12 Mar 2025 19:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88774189F6BB
	for <lists+dmaengine@lfdr.de>; Wed, 12 Mar 2025 18:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E4A1CD20D;
	Wed, 12 Mar 2025 18:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="IHs3ILwn"
X-Original-To: dmaengine@vger.kernel.org
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409022528E3;
	Wed, 12 Mar 2025 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741804578; cv=none; b=UDrspqS6nVgwZAvLuukaAh+i3nKR6WbIz6JmbMeXtW4Jin0yovX6qoxgOloZNLfLutPO50t5mqG5WVjm6evd9B3L0QGVeC9FeXbUyRHcyHtgHD3X9BSZz54CSgjjsM1J7RhHJ7R7ECcNMo2O7AyzohhPh3DTMxHOykNiZq7jpVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741804578; c=relaxed/simple;
	bh=USQyrSayfOtqTw7Yn797LuXa1nzYIEzNYb2576ydQlo=;
	h=In-Reply-To:Message-Id:Cc:To:From:Date:Subject; b=Q2E83wj/M+pdC54MthKrjEeV8svgrhkp9XMxDGKSfYqrYsW8hg+96htki9915f/U5EPEqcFD4MzuGiAaAOvVeQxgZCS2I7Nm6e+vsoAW8yji5Npe5qf4MCeRf3NvdgC8bXkA/07RKaVKqBJqqv+AOXiuEbjX0Bdxr8olDKfWHCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=IHs3ILwn; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=Subject:Date:From:To:Cc:Message-Id:
	In-Reply-To:Sender:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References;
	bh=PvD8g/iHmVDM+dWVh5jAN+ccAMhC2v2ZHCMkMzBxqQU=; b=IHs3ILwnUjRJjDXQPTt0DSuIJA
	ehk51ivm59UhUeZGijZUyxHQzKNS6g/KsrrBX8lVKSg9ogW0z52d07amM8pCic4YPjfRwsYoMV03p
	Fbha6ZgF4YEbyfusLWQOD+IjPx8aTfSawc/+mdm/HnB5gRPHRmcDqZKGt0Aw+Fj4m2FEw4VEET0aE
	QvO3+SqYCg2sZ7QkfSXeLja/vfq3StgeVsHVCbJ0ku4JatolvVVyJ/X+z9ubPgr/0R/ONNh0WWNW/
	3lcnoLqLD4KpDujU6pvH26sOjWYz4Omg1D3CTjyWfoGRMxMwqbGudyEgV64Sc/ZXNPDO50wp/TR8e
	mfTqwMeA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1tsQw8-000IGQ-1y;
	Wed, 12 Mar 2025 19:36:12 +0100
Received: from [185.209.196.170] (helo=localhost)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1tsQw8-000JzK-29;
	Wed, 12 Mar 2025 19:36:12 +0100
In-Reply-To: <D8EI6SI5E4PE.3GOBCNHV38K03@folker-schwesinger.de>
Message-Id: <D8EI6SI5EIUY.2JD240P96ZZSS@folker-schwesinger.de>
Cc: "Kedareswara rao Appana" <appanad@xilinx.com>,
 <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
To: "Vinod Koul" <vkoul@kernel.org>, "Michal Simek" <michal.simek@amd.com>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Manivannan Sadhasivam"
 <manivannan.sadhasivam@linaro.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@linaro.org>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, "Marek Vasut" <marex@denx.de>
From: "Folker Schwesinger" <dev@folker-schwesinger.de>
Date: Wed, 12 Mar 2025 19:23:49 +0100
Subject: [PATCH 1/1] dmaengine: xilinx_dma: Set dma_device.directions
X-Authenticated-Sender: dev@folker-schwesinger.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27575/Wed Mar 12 09:37:42 2025)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

When using the dma_get_slave_caps() API, it checks the directions fields of
the dma_device structure. Currently, the Xilinx DMA driver does not set
this, which causes dma_get_slave_caps() to return -ENXIO.

Fix this issue by setting the directions field of the dma_device
structure during DMA channel probe.

Signed-off-by: Folker Schwesinger <dev@folker-schwesinger.de>
---
 drivers/dma/xilinx/xilinx_dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 3ad44afd0e74..63c308f2ae81 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2864,6 +2864,7 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 	    of_device_is_compatible(node, "xlnx,axi-dma-mm2s-channel") ||
 	    of_device_is_compatible(node, "xlnx,axi-cdma-channel")) {
 		chan->direction = DMA_MEM_TO_DEV;
+		xdev->common.directions |= BIT(DMA_MEM_TO_DEV);
 		chan->id = xdev->mm2s_chan_id++;
 		chan->tdest = chan->id;
 
@@ -2881,6 +2882,7 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 		   of_device_is_compatible(node,
 					   "xlnx,axi-dma-s2mm-channel")) {
 		chan->direction = DMA_DEV_TO_MEM;
+		xdev->common.directions |= BIT(DMA_DEV_TO_MEM);
 		chan->id = xdev->s2mm_chan_id++;
 		chan->tdest = chan->id - xdev->dma_config->max_channels / 2;
 		chan->has_vflip = of_property_read_bool(node,
-- 
2.48.1

