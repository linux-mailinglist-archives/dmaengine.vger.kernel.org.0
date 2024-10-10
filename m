Return-Path: <dmaengine+bounces-3322-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46693998A0A
	for <lists+dmaengine@lfdr.de>; Thu, 10 Oct 2024 16:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06911F26DAF
	for <lists+dmaengine@lfdr.de>; Thu, 10 Oct 2024 14:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CFB1F8EF2;
	Thu, 10 Oct 2024 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="m5qs6jeh"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623CE1F7069;
	Thu, 10 Oct 2024 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570709; cv=none; b=a+Ikfh3eSeosKCaNDmK9DZv3Hc+ZWMIth+BG3Mj8fhh42LbuF9RIzaGbm277qvugZDRTuOJdFixs+tdzVQS2WqtvEczqjDaSCoM6hJk6mom1s7syWaYB44me3hi6FRb/BOoR4KuBu/CRx7lFCya1Di34xdQOSlw0BobK7uXVJF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570709; c=relaxed/simple;
	bh=M+OwuR2L3A1nuRrWpdlwUD5uHBzx8kDYo55SfadjvxE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=K0DMNzZ0+KNpwR5UPt3hkUN5fUfFB0wZxMeLBstfsDWP33kYgASFjU1/Hi3LRvGS0S2ysqqETnkeWClfY+QM7hPbwt7TXUl12ucPHBDQQ5POg7psA1cUjh/4m28mCvh01SCD+JMoy1o2YBY97OVCi+z2zNeuctDoYjuMBkbPDPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=m5qs6jeh; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AE78eZ014745;
	Thu, 10 Oct 2024 16:31:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	cB08zjQih/Ih6h2EceQOGpBZJJTkTNDk33t9blGD3t4=; b=m5qs6jehLgxPnCWR
	DkX+TkDcMnZsJhxMwsEwTYZuQND33toHLNPWRbBmb66SqUyuhJwsS1s0YIo9K9LY
	ivirtQsGbb8+rGvQA7dFwJHTRoc8nVJDFwjzZX8sPkGA1yu8Ehsa9HkW4ZefCWnX
	W6aCVShpaAPYyFR/sNOV/fjHu3wrpxxQh8Ikt/wKUb4FFIfg4sTpY0ps+pCbHqDL
	3wcJA+eoj8iDVWHpK8EYa1QkW/u7Rwed4WbsHTrLN23/D5KyuC3VLefxNbUGlGfX
	rRjg7uX9YtS5gkqANrzC3sXKh7G/0MkTnbgGeZ8mXBiF9LEHCyJDqLj7lKgUZapz
	NUgk6A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 425w9xcvk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 16:31:33 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6EEA64008E;
	Thu, 10 Oct 2024 16:30:22 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E6D6B2954B9;
	Thu, 10 Oct 2024 16:28:07 +0200 (CEST)
Received: from localhost (10.252.31.182) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 10 Oct
 2024 16:28:07 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Thu, 10 Oct 2024 16:27:52 +0200
Subject: [PATCH 02/11] dmaengine: stm32-dma3: prevent pack/unpack thanks to
 DT configuration
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241010-dma3-mp25-updates-v1-2-adf0633981ea@foss.st.com>
References: <20241010-dma3-mp25-updates-v1-0-adf0633981ea@foss.st.com>
In-Reply-To: <20241010-dma3-mp25-updates-v1-0-adf0633981ea@foss.st.com>
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
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
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
index 0be6e944df6fd5d2a02974085251549d9389a37e..2b4cc479e1a1206fef7fd2808d1342048d81e07b 100644
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


