Return-Path: <dmaengine+bounces-3765-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD59E9D59D3
	for <lists+dmaengine@lfdr.de>; Fri, 22 Nov 2024 08:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17AC4B22267
	for <lists+dmaengine@lfdr.de>; Fri, 22 Nov 2024 07:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2224170A03;
	Fri, 22 Nov 2024 07:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O5+jcSI+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466F81632CB;
	Fri, 22 Nov 2024 07:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732259838; cv=none; b=m6JJL84FiGREj92Wwo+zELifSFmOPT2eRNzQLhBTThU59msEVVVT093jU8N9uVGa9a45VIEXf22sR3tfWHzdQZoqvP0AAUy+pFbC/03kl6dqJMgh2o0qDCEtnF+OzZIy30emG0irMzcWxkRgRdHIeAslhdc8p/BbbU1Cidl6tzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732259838; c=relaxed/simple;
	bh=03q8x0T4YMfvc/y9zbKTatkjaIUa2oNwQs36cihLW9U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hSQGv0gL7KnvVfQoj5LZKi28A1wKRZigHHglzYfQy2O4s4O6Bu6yX3dFO+a4lyMA9mTg1jLAPPATDjFzPJd1eOvRa+D4eKHMwrX/tn9/a4B3vxE8m6+KwPZgRPp5nqytelGhlSrFREJVk/GHCG0WD7+jEjZIBqpJJvQtjqbaD7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O5+jcSI+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM4r26A019750;
	Fri, 22 Nov 2024 07:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1WSLi8/TexQOViF37dsphX
	xWgVVPRLEY8lsL7FaNLlA=; b=O5+jcSI+aWkFfEFRs7IGHV0kbwgzxXOLImkx6F
	mcDDqohBCeUmwWuK6RjpaDVOvTWG5M8t8EAHkE9HfFgDasCR5v932ZBPS9D0KXKb
	HLnQiFEpdxw5QwF0Qc3DRheruVKe1HZXiLmOzuuwWC0jpnHtg5XMgh7jM3tfaMiq
	TnibRRLofJT4y98RsIRoeZcmn2vGMm+VZxl0CijpmnD6C7hKoFK0IKXgS5GBWUDa
	DPmSaZTNP8GuaMXf1KtotxysX0+ldjEb1XPiokAWP0mbqpYFa7jW2iL7b0sNd65g
	lPGbnvjgQ+yZL6X1+koXPKBv1mXWEJymBbrAZtdRE/Cijmhg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4326ata8bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 07:17:08 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AM7H8Rv018108
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 07:17:08 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 21 Nov 2024 23:17:04 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <vkoul@kernel.org>, <ulf.hansson@linaro.org>, <martin.petersen@oracle.com>,
        <kees@kernel.org>, <dave.jiang@intel.com>, <av2082000@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <quic_mdalam@quicinc.com>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>
Subject: [PATCH] dmaengine: qcom: bam_dma: Avoid writing unavailable register
Date: Fri, 22 Nov 2024 12:46:49 +0530
Message-ID: <20241122071649.2618320-1-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3QQ_BYHg-4WVXikjik-i_HYpdRXT9GWr
X-Proofpoint-GUID: 3QQ_BYHg-4WVXikjik-i_HYpdRXT9GWr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1011 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220059

Avoid writing unavailable register in BAM-Lite mode.
BAM_DESC_CNT_TRSHLD register is unavailable in BAM-Lite
mode. Its only available in BAM-NDP mode. So avoid writing
this register for clients who is using BAM-Lite mode.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
 drivers/dma/qcom/bam_dma.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index d43a881e43b9..13a08c03746b 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -59,6 +59,9 @@ struct bam_desc_hw {
 #define DESC_FLAG_NWD BIT(12)
 #define DESC_FLAG_CMD BIT(11)
 
+#define BAM_LITE	0x13
+#define BAM_NDP		0x20
+
 struct bam_async_desc {
 	struct virt_dma_desc vd;
 
@@ -398,6 +401,7 @@ struct bam_device {
 
 	/* dma start transaction tasklet */
 	struct tasklet_struct task;
+	u32 bam_revision;
 };
 
 /**
@@ -441,8 +445,9 @@ static void bam_reset(struct bam_device *bdev)
 	writel_relaxed(val, bam_addr(bdev, 0, BAM_CTRL));
 
 	/* set descriptor threshold, start with 4 bytes */
-	writel_relaxed(DEFAULT_CNT_THRSHLD,
-			bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
+	if (bdev->bam_revision >= BAM_LITE && bdev->bam_revision < BAM_NDP)
+		writel_relaxed(DEFAULT_CNT_THRSHLD,
+			       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
 
 	/* Enable default set of h/w workarounds, ie all except BAM_FULL_PIPE */
 	writel_relaxed(BAM_CNFG_BITS_DEFAULT, bam_addr(bdev, 0, BAM_CNFG_BITS));
@@ -1000,9 +1005,9 @@ static void bam_apply_new_config(struct bam_chan *bchan,
 			maxburst = bchan->slave.src_maxburst;
 		else
 			maxburst = bchan->slave.dst_maxburst;
-
-		writel_relaxed(maxburst,
-			       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
+		if (bdev->bam_revision >= BAM_LITE && bdev->bam_revision < BAM_NDP)
+			writel_relaxed(maxburst,
+				       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
 	}
 
 	bchan->reconfigure = 0;
@@ -1192,10 +1197,11 @@ static int bam_init(struct bam_device *bdev)
 	u32 val;
 
 	/* read revision and configuration information */
-	if (!bdev->num_ees) {
-		val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
+	val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
+	if (!bdev->num_ees)
 		bdev->num_ees = (val >> NUM_EES_SHIFT) & NUM_EES_MASK;
-	}
+
+	bdev->bam_revision = val & 0xff;
 
 	/* check that configured EE is within range */
 	if (bdev->ee >= bdev->num_ees)
-- 
2.34.1


