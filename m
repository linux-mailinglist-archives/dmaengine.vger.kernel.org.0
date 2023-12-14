Return-Path: <dmaengine+bounces-522-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA6F812EE8
	for <lists+dmaengine@lfdr.de>; Thu, 14 Dec 2023 12:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE0BB1F21B40
	for <lists+dmaengine@lfdr.de>; Thu, 14 Dec 2023 11:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A103B41226;
	Thu, 14 Dec 2023 11:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fZY/Xbfb"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FB9BD;
	Thu, 14 Dec 2023 03:42:56 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE4lxEH018140;
	Thu, 14 Dec 2023 11:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=LW/eUHK
	cp5SItn9ipZXnM+q0lw3s/mGAIYFkMJWPNSk=; b=fZY/XbfbMWzh8XuMGcmnuTI
	UWCvgiBeYyvoOSFXsft8oBZxK9yldHrXDyHKa0jkVDqJ7J4kMu1NCu19u2wXBs7e
	k1OeCVZttCSnHfr5v/Pk07o+YRK8zWAwj5UAxHeN+kz8g2Hhv9sGmUZNzESWZhaw
	1rjrWiVAhq234wr5zfdqRXdbLGxhE1cjDuz3BP8cG18DVvzLMY/wKFjLqoeHjGWf
	zdMPtYXs0Zef9widn32xQumjQD3LinW9JQM3VokSm8wc8q1+9SIBbWeUh6Gv8wIK
	wIIAznBBmvBLVCozpMjBFZ5bC9zMU48t76IHktdOfXiTWaWlcf+Ny0ysUWDPZaQ=
	=
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uynre19yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 11:42:48 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BEBghuY003051;
	Thu, 14 Dec 2023 11:42:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3uvhaktchc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 11:42:44 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BEBghQL002911;
	Thu, 14 Dec 2023 11:42:44 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3BEBgi2i003205
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 11:42:44 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
	id 950694164F; Thu, 14 Dec 2023 17:12:42 +0530 (+0530)
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: thara.gopinath@gmail.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, linux-crypto@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, quic_srichara@quicinc.com,
        quic_varada@quicinc.com
Cc: quic_mdalam@quicinc.com
Subject: [PATCH 06/11] drivers: bam_dma: Add LOCK & UNLOCK flag support
Date: Thu, 14 Dec 2023 17:12:34 +0530
Message-Id: <20231214114239.2635325-7-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214114239.2635325-1-quic_mdalam@quicinc.com>
References: <20231214114239.2635325-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YIXJ8KItBimNmfeAEIZzGk5wvmEGLDB5
X-Proofpoint-GUID: YIXJ8KItBimNmfeAEIZzGk5wvmEGLDB5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312140080

Add lock and unlock flag support on command descriptor.
Once lock set in requester pipe, then the bam controller
will lock all others pipe and process the request only
from requester pipe. Unlocking only can be performed from
the same pipe.

If DMA_PREP_LOCK flag passed in command descriptor then requester
of this transaction wanted to lock the BAM controller for this
transaction so BAM driver should set LOCK bit for the HW descriptor.

If DMA_PREP_UNLOCK flag passed in command descriptor then requester
of this transaction wanted to unlock the BAM controller.so BAM driver
should set UNLOCK bit for the HW descriptor.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
 drivers/dma/qcom/bam_dma.c       | 10 ++++++++++
 include/linux/dma/qcom_bam_dma.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 5e7d332731e0..146d78af3731 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -41,6 +41,7 @@
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
 #include <linux/pm_runtime.h>
+#include <linux/dma/qcom_bam_dma.h>
 
 #include "../dmaengine.h"
 #include "../virt-dma.h"
@@ -58,6 +59,8 @@ struct bam_desc_hw {
 #define DESC_FLAG_EOB BIT(13)
 #define DESC_FLAG_NWD BIT(12)
 #define DESC_FLAG_CMD BIT(11)
+#define DESC_FLAG_LOCK BIT(10)
+#define DESC_FLAG_UNLOCK BIT(9)
 
 struct bam_async_desc {
 	struct virt_dma_desc vd;
@@ -686,6 +689,13 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
 
 	/* fill in temporary descriptors */
 	desc = async_desc->desc;
+	if (flags & DMA_PREP_CMD) {
+		if (flags & DMA_PREP_LOCK)
+			desc->flags |= cpu_to_le16(DESC_FLAG_LOCK);
+		if (flags & DMA_PREP_UNLOCK)
+			desc->flags |= cpu_to_le16(DESC_FLAG_UNLOCK);
+	}
+
 	for_each_sg(sgl, sg, sg_len, i) {
 		unsigned int remainder = sg_dma_len(sg);
 		unsigned int curr_offset = 0;
diff --git a/include/linux/dma/qcom_bam_dma.h b/include/linux/dma/qcom_bam_dma.h
index 68fc0e643b1b..bc619c44ce82 100644
--- a/include/linux/dma/qcom_bam_dma.h
+++ b/include/linux/dma/qcom_bam_dma.h
@@ -8,6 +8,8 @@
 
 #include <asm/byteorder.h>
 
+#define DMA_PREP_LOCK	BIT(0)
+#define DMA_PREP_UNLOCK	BIT(1)
 /*
  * This data type corresponds to the native Command Element
  * supported by BAM DMA Engine.
-- 
2.34.1


