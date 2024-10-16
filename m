Return-Path: <dmaengine+bounces-3384-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FBC9A0A94
	for <lists+dmaengine@lfdr.de>; Wed, 16 Oct 2024 14:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CAB31C28509
	for <lists+dmaengine@lfdr.de>; Wed, 16 Oct 2024 12:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7240420CCEA;
	Wed, 16 Oct 2024 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="0mYb0Qtp"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE64208D74;
	Wed, 16 Oct 2024 12:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082598; cv=none; b=okatoObOB/ancUTcLqKxgJnHvGX6Im582B32RiQijz4NrmX4l9Jag2I+/9/3z6zKgXi3fUEWuTfCchwZMRD/nhHGvrjO2svYw26ueqrNKvgb49UNDQjVYJy77ixh7v2YmaZ3850HD35ih7u86k9yFEKAgP2VbqguscXXhSkeuO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082598; c=relaxed/simple;
	bh=wdD98dh8hUdD7Br13Zty15YgoaLIF2Za0M8sk3rkhD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Q8Hm7fAVsAeG8Bh6VXWmR3fO7gQHj6gFIEMxn9kYgxoUOBRnzwcWfnh3tNR41LSiRPRlwBOUi/lzCwnufylgBNziqhANhkFm4SMoCO9Dhq7DqdnOG+yhI/YlvjTyHbkd9+NfYmEKiRnHshFc7E1PbvIpWz9nBgJFOxUWDWLbGf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=0mYb0Qtp; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G8W7qS018082;
	Wed, 16 Oct 2024 14:42:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	20xEPx4JtIHJKB3XkmoT5ueiiLey/iQq4U2NsvYq/Ns=; b=0mYb0Qtp89eYZsjS
	8P9hLaKhDEYW6x5m0TvkST/9fO7MremyFIvzU0TdWf2VvF7wEoqGnfXf3YdK0MZv
	NceTNJ3obTsNrfTz6D/eQLwrlLxljt9p1cmfzqGpK0bIXSuUb6cZVdJX8D0AG4jC
	SQnqImfwLXAJpkUY4VYh+M+IYd05Oh3ROWSgfg8fg3KacTfQDqRBpFrjbpySCgC9
	mhfEV4OpuJM++5NkPH4/rnYefltYECBJEDD8Me7CK+6//cUUYv0bG16Sh1Kk6hVW
	NPptV0WrKNcpG3aX1y96Soy/cxv8ErMt5F+peQATPfnsJYtktrGP7KkSSnJrS4AC
	CgY6Fg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42842jfv50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 14:42:43 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 353D540048;
	Wed, 16 Oct 2024 14:41:23 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BFF2D23AA4B;
	Wed, 16 Oct 2024 14:40:21 +0200 (CEST)
Received: from localhost (10.252.17.239) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 16 Oct
 2024 14:40:21 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Wed, 16 Oct 2024 14:39:54 +0200
Subject: [PATCH v3 2/9] dmaengine: stm32-dma3: prevent pack/unpack thanks
 to DT configuration
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241016-dma3-mp25-updates-v3-2-8311fe6f228d@foss.st.com>
References: <20241016-dma3-mp25-updates-v3-0-8311fe6f228d@foss.st.com>
In-Reply-To: <20241016-dma3-mp25-updates-v3-0-8311fe6f228d@foss.st.com>
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
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

When source data width/burst and destination data width/burst are
different, data are packed or unpacked in DMA3 channel FIFO, using
CxTR1.PAM.
Data are pushed out from DMA3 channel FIFO when the destination burst
length (= data width * burst) is reached.
If the transfer is stopped before CxBR1.BNDT = 0, and if some bytes are
packed/unpacked in the DMA3 channel FIFO, these bytes are lost.
Indeed, DMA3 channel FIFO has no flush capability, only reset.
To avoid potential bytes lost, pack/unpack must be prevented by setting
memory data width/burst equal to peripheral data width/burst.
Memory accesses will be penalized. But it is the only way to avoid bytes
lost.

Prevent pack/unpack feature can be activated by setting bit 16 of DMA3
Transfer requirements bitfield (tr_conf) in device tree.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32/stm32-dma3.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index b9470f783f98940a99addaeef6d0a8bc07b5c54b..f793eecd2c27ca17cedd5cabbaa1b1beca202039 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -221,6 +221,7 @@ enum stm32_dma3_port_data_width {
 #define STM32_DMA3_DT_BREQ		BIT(8) /* CTR2_BREQ */
 #define STM32_DMA3_DT_PFREQ		BIT(9) /* CTR2_PFREQ */
 #define STM32_DMA3_DT_TCEM		GENMASK(13, 12) /* CTR2_TCEM */
+#define STM32_DMA3_DT_NOPACK		BIT(16) /* CTR1_PAM */
 
 /* struct stm32_dma3_chan .config_set bitfield */
 #define STM32_DMA3_CFG_SET_DT		BIT(0)
@@ -622,6 +623,10 @@ static int stm32_dma3_chan_prep_hw(struct stm32_dma3_chan *chan, enum dma_transf
 		/* Set source (memory) data width and burst */
 		sdw = stm32_dma3_get_max_dw(chan->max_burst, sap_max_dw, len, src_addr);
 		sbl_max = stm32_dma3_get_max_burst(len, sdw, chan->max_burst);
+		if (!!FIELD_GET(STM32_DMA3_DT_NOPACK, tr_conf)) {
+			sdw = ddw;
+			sbl_max = dbl_max;
+		}
 
 		_ctr1 |= FIELD_PREP(CTR1_SDW_LOG2, ilog2(sdw));
 		_ctr1 |= FIELD_PREP(CTR1_SBL_1, sbl_max - 1);
@@ -652,6 +657,11 @@ static int stm32_dma3_chan_prep_hw(struct stm32_dma3_chan *chan, enum dma_transf
 		/* Set destination (memory) data width and burst */
 		ddw = stm32_dma3_get_max_dw(chan->max_burst, dap_max_dw, len, dst_addr);
 		dbl_max = stm32_dma3_get_max_burst(len, ddw, chan->max_burst);
+		if (!!FIELD_GET(STM32_DMA3_DT_NOPACK, tr_conf) ||
+		    ((_ctr2 & CTR2_PFREQ) && ddw > sdw)) { /* Packing to wider ddw not supported */
+			ddw = sdw;
+			dbl_max = sbl_max;
+		}
 
 		_ctr1 |= FIELD_PREP(CTR1_SDW_LOG2, ilog2(sdw));
 		_ctr1 |= FIELD_PREP(CTR1_SBL_1, sbl_max - 1);

-- 
2.25.1


