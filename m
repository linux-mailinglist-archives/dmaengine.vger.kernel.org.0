Return-Path: <dmaengine+bounces-1554-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 873D888DAD4
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 10:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8ADF1C26C83
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 09:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4984C600;
	Wed, 27 Mar 2024 09:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FbC8p5/A"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BA93BBE5;
	Wed, 27 Mar 2024 09:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711533555; cv=none; b=rraLIE6L+d85qc2fnSNogaC03ycMfONbQ+dJknBEbHa/mwp5WQALY3yc9+Y3kCaVBJcHH15IaC/7t44Z/zOgPOd0jF28XD03+Evh1JKOu2Jev9ljhBj0FS1VVsSgj30MNOIyEV179qQ8wrr60vEin2DLNdgzmwoU9lTGPRz8T2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711533555; c=relaxed/simple;
	bh=O0oknYQk5az9YCtIwYXgCgTNcoCSEGY/4TTLust/ZZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=poh1iVfUyX61chweiKj3GULhEB/WbhTXcwB0RykGxpgbMqmw1l1jrs1eVrTVmCYQGomTQUgmPfe7lrZl9vv/osmNEqvP4TizO2hj6gPwgjTmiDo3SBoBKo75v0fM+Msw9ON38nEoBUTv2vU1pzxEtaeDTGiocGSb1Lm4avv+DnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FbC8p5/A; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E94EC2000E;
	Wed, 27 Mar 2024 09:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711533551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XLH57fwLTXfBUc6BX3tfnkCCcKVQ9c7Io2++9VEubdw=;
	b=FbC8p5/A/zJBAFi+obVk3JTmtO4K7jIoBH0kTghWLEuZbxxDWAj2x6wN/4wacUDPLnbgSY
	aIUmK6op2nt7cnMn9weKSjOhIi+djnoSpiIG7Pdbsd2bo87fqx4AskZ26h/zS9yA6t1SVw
	2+2OU5rjVPqpQ7ucpvLOC55GxGewEeaEWUaWRm4swpVkAlVLOB4Prsk6ycZpAOxOPgqVI3
	VtdnlageoRViWIeGnxHOd0dNVmAmXeScIvVSF3zti0wioj6/xicMPEHofk/aHF9hNTXfV0
	msIC7VnF93VvOubQATG3rvnS1BIqAugodDZ4PHIpPSLBEWaAllIvVLMQ5rOxjA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 27 Mar 2024 10:58:50 +0100
Subject: [PATCH 3/3] dmaengine: xilinx: xdma: Clarify kdoc in XDMA driver
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-digigram-xdma-fixes-v1-3-45f4a52c0283@bootlin.com>
References: <20240327-digigram-xdma-fixes-v1-0-45f4a52c0283@bootlin.com>
In-Reply-To: <20240327-digigram-xdma-fixes-v1-0-45f4a52c0283@bootlin.com>
To: Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>, 
 Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>, 
 Vinod Koul <vkoul@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Jan Kuliga <jankul@alatek.krakow.pl>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1602;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=Qu3N1kH//gP+Zhn4r+vc3YZmGiId+GfbdTx9l1LnfhA=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmA+3sS9HVQIWiFg2uWF+TzbykBXZyV4P4JePFYOSL
 GqiUWc+JAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZgPt7AAKCRAgrS7GWxAs4tV+EA
 C5S9ZpDRclxOf6wzOsIvQV1M1IfOGbnVbBQvAn0EXG0QvS+XLMQTvQ/tzMEhc/xJw+dbLBCBRRT7yr
 fjLCiLUUMsMJU/fU91gpORTSHZ82xttwR2AYCmvEi4VQmDZkZFMAgpQHXxHatc9Sge0wpL3LB0y6WS
 2zdY+gdaFguTg8zBza1SKMs/lsJ4y6pq2fytp7rr3hIOkfrNZH76BC6WV+9kbNIRgbdImB+HZlSopE
 6rgCgBY4ZB1ciu8/Buo0WDMy7RE96+PmgNsy7vhUFvoyBxuyDVojuXtTuWg9zSpnQXgAM23Avrey5g
 xE9YFROL7cuqPWAQyYovPgj8nwueaePCZcQebWSUtga1DYikKxKb2oghPZw1Gz8Zh9O1nsMtQmNCk5
 oDT7vnSlVE4DNUoLpGPHcB6DveeDvP2fM7j+b3wwf1zc+HQAy7lgcChqm1w1L9mwrhCsZWvIEXw/b+
 8t71rwvDB74V9Ihw2spnKDwiRcaV2DT7FCYouXSzDyF2VEnBGBA/ujyOtsL010kNZIat7xr6f1qwE2
 0QHEJwimgaoiBzXRqPD6mtpoxLxkbKe+XOGqsRDSXN/hl+EIPvH5m8mGoW4jnTqEt17wOsVU5MVzrD
 tKoOox28Mis4O8s4pzjvdTvwoOPmTCd6655l5wfHyhzd4v9wqc0nOI+ipCHQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

From: Miquel Raynal <miquel.raynal@bootlin.com>

Clarify the kernel doc of xdma_fill_descs(), especially how big chunks
will be handled.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/dma/xilinx/xdma.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 5a3a3293b21b..313b217388fe 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -554,12 +554,14 @@ static void xdma_synchronize(struct dma_chan *chan)
 }
 
 /**
- * xdma_fill_descs - Fill hardware descriptors with contiguous memory block addresses
- * @sw_desc: tx descriptor state container
- * @src_addr: Value for a ->src_addr field of a first descriptor
- * @dst_addr: Value for a ->dst_addr field of a first descriptor
- * @size: Total size of a contiguous memory block
- * @filled_descs_num: Number of filled hardware descriptors for corresponding sw_desc
+ * xdma_fill_descs() - Fill hardware descriptors for one contiguous memory chunk.
+ *		       More than one descriptor will be used if the size is bigger
+ *		       than XDMA_DESC_BLEN_MAX.
+ * @sw_desc: Descriptor container
+ * @src_addr: First value for the ->src_addr field
+ * @dst_addr: First value for the ->dst_addr field
+ * @size: Size of the contiguous memory block
+ * @filled_descs_num: Index of the first descriptor to take care of in @sw_desc
  */
 static inline u32 xdma_fill_descs(struct xdma_desc *sw_desc, u64 src_addr,
 				  u64 dst_addr, u32 size, u32 filled_descs_num)

-- 
2.43.0


