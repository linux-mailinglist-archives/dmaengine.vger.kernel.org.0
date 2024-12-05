Return-Path: <dmaengine+bounces-3902-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC24F9E54C7
	for <lists+dmaengine@lfdr.de>; Thu,  5 Dec 2024 13:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7A41883843
	for <lists+dmaengine@lfdr.de>; Thu,  5 Dec 2024 12:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59BB217673;
	Thu,  5 Dec 2024 12:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F4UMYirt"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116FA217649;
	Thu,  5 Dec 2024 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400045; cv=none; b=HqSFFDy2FKimCDS2NB/702pk6WTR6PfxxW40K72WKTY62DJ0RYLxzVKJLi1bdGty0GrtDRxHpGHsiRyGlf1PqIu+sDOVyBUSj2EFk9wUCGvnX6Tzd+C+jCaXc0VpyzzQwpK4QkjolHKovO9Kk1MTLxNEKROhB+ktB1oJ288ZQ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400045; c=relaxed/simple;
	bh=wENGL2+tKFj2g36FEcjLIdH7PlNn8qxutB+84PPmxyg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ADmRw+5L/+1tylDMwaagEaZXNJjYjx75qzQjr5oZORnbhs0cSrl92P7n7sY6MWT9pYJpAS6dVp4OPWEPlfIXxcn6vExt+6PSGpIR4ZT7J1DoV2WHTsnK1Qsq1DYktQdOemIMA04EK5EaHLceNpfpfwzHH5kQbiHmWBZee+sjx84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F4UMYirt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5BomrG029397;
	Thu, 5 Dec 2024 12:00:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=T6JAKjEVtMlYzBixygCl0j
	wi/qQ4OMSQPTiERtHDNtU=; b=F4UMYirtwq1+65K3jjauePV0b0kabYI1Vne4JB
	zpyNB/b+XdeyESbauabzY/9efI99Mlc41oHsEkfIf4WS/fCdb4SjUzaufvclXjnd
	nLzmymchTcDZG3hnpy0LR6E4GgDpbUr43d6FlF4OzwKhnioEV7wOiOEiLqGI/CQR
	La0e0ray5X9S0F+Rwok7WpKMGJK5+iAnRBY4HAWkStx6BZccGCWpOxe9hN8NAVbe
	hsfW3riq9RUioRon+YKHyIs395wLelHz/l4CxhS0Rie8ljbXTLf+3SwLrprPIS38
	Dj/fTM1Lb26PLpdv8ALH118yH96Jj/nHcZr1DM/tfNXY3juQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43bbnj00pg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 12:00:36 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B5C0ZXU015791
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Dec 2024 12:00:35 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 5 Dec 2024 04:00:31 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <vkoul@kernel.org>, <martin.petersen@oracle.com>, <kees@kernel.org>,
        <av2082000@gmail.com>, <fenghua.yu@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <quic_mdalam@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_srichara@quicinc.com>
Subject: [PATCH v2] dmaengine: qcom: bam_dma: Avoid writing unavailable register
Date: Thu, 5 Dec 2024 17:30:16 +0530
Message-ID: <20241205120016.948960-1-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: R06QbIe8DXYg5_5aUFGC01q4XpFE3-ct
X-Proofpoint-ORIG-GUID: R06QbIe8DXYg5_5aUFGC01q4XpFE3-ct
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 phishscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412050086

Avoid writing unavailable register in BAM-Lite mode.
BAM_DESC_CNT_TRSHLD register is unavailable in BAM-Lite
mode. Its only available in BAM-NDP mode. So avoid writing
this register for clients who is using BAM-Lite mode.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v2]

* Replace 0xff with REVISION_MASK in the statement
  bdev->bam_revision = val & REVISION_MASK

Change in [v1]

* Added initial patch

 drivers/dma/qcom/bam_dma.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index d43a881e43b9..27c5b3b58f92 100644
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
+	bdev->bam_revision = val & REVISION_MASK;
 
 	/* check that configured EE is within range */
 	if (bdev->ee >= bdev->num_ees)
-- 
2.34.1


