Return-Path: <dmaengine+bounces-3928-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8919E8C31
	for <lists+dmaengine@lfdr.de>; Mon,  9 Dec 2024 08:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC48188619F
	for <lists+dmaengine@lfdr.de>; Mon,  9 Dec 2024 07:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9432147EF;
	Mon,  9 Dec 2024 07:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KowAMxse"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CFD155751;
	Mon,  9 Dec 2024 07:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733729530; cv=none; b=JWq9bnenMlDG/0xx5Md9mxKuCyOdf+E68+I97KsE9A1Pjqrshql8jN/fsAVpcnSI8cYK7cdCDKcQitRBDN1MSlkYZCpyyH5Tw57AbmaTAgsB3M+o1+u8NvOzZGfwHnxe/70RAz0hx7A5yREDEG36JtRB3P69d5894qy2zebowTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733729530; c=relaxed/simple;
	bh=64Nt/EKDpKv3h+ScLXYg+esUX5yXpwZo3YoIS3YvFUc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jw2MtdpZ/CVIkdBLXyrvTtsPFd/v2uydqxbj6Ntj8Q8TvtIQa9q5HdpNaEwLOAlfH99ila+yh3ZlMsIesR5JwUk5kRtOFNNkcrjnPtsQLWYKiIb4vHyM046NBvgM3ZsBtCvLeiL0bQUusIjOVXqO50Gnfk5jsQWzBhz1p6rRAhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KowAMxse; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8NQgTN005177;
	Mon, 9 Dec 2024 07:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=cUQ50lwmYhvXWnneukU2aE
	UXJJ0s/KcuuNUa7W/c03I=; b=KowAMxsePZVpzJL8526ffQVR0ggj2nnJHXicC5
	pVFPXW7hNOe7w8IVEmslqobJ6MQiWPihPr5azTM2ye1u6ucnQbCwVAcsBLfAQLM9
	59fSRZK2jirT9HHLNaLrgaqciosQildVR09kuHCVSnjMpT9LL5gzMylKbAFxXGne
	GRRAhAfoQHqpZidVzKM8sdnjuNTMxssr5iJOUY6MuUAodscolOCp+g6jC0tK8Qd0
	P4cAimdplSAXBiVs9ymK5f8NXTjXJ3YKRSRfgf2ivaOnDmjPzqVGP4Ekwq13nYo1
	egyPmEQrbf8mYaY7O4XCc8g5CWzhP/HGdsm+xrZEmCOsUfAg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cdpgkt2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 07:32:02 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B97W17O020614
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 07:32:01 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 8 Dec 2024 23:31:58 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <vkoul@kernel.org>, <martin.petersen@oracle.com>, <ulf.hansson@linaro.org>,
        <av2082000@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <uic_mdalam@quicinc.com>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>
Subject: [PATCH v3] dmaengine: qcom: bam_dma: Avoid writing unavailable register
Date: Mon, 9 Dec 2024 13:01:43 +0530
Message-ID: <20241209073143.3413552-1-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: qWTXuQbAZjq2_6X0EnqmBGP5grXcY6Hx
X-Proofpoint-ORIG-GUID: qWTXuQbAZjq2_6X0EnqmBGP5grXcY6Hx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 suspectscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090058

Avoid writing unavailable register in BAM-Lite mode.
BAM_DESC_CNT_TRSHLD register is unavailable in BAM-Lite
mode. Its only available in BAM-NDP mode. So only write
this register for clients who is using BAM-NDP.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v3]

* Removed BAM_LITE macro

* Updated commit message

* Adjusted if condition check

* Renamed BAM-NDP macro to BAM_NDP_REVISION_START and 
  BAM_NDP_REVISION_END

Change in [v2]

* Replace 0xff with REVISION_MASK in the statement
  bdev->bam_revision = val & REVISION_MASK

Change in [v1]

* Added initial patch

 drivers/dma/qcom/bam_dma.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index d43a881e43b9..a00dd0331ff5 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -59,6 +59,9 @@ struct bam_desc_hw {
 #define DESC_FLAG_NWD BIT(12)
 #define DESC_FLAG_CMD BIT(11)
 
+#define BAM_NDP_REVISION_START	0x20
+#define BAM_NDP_REVISION_END	0x27
+
 struct bam_async_desc {
 	struct virt_dma_desc vd;
 
@@ -398,6 +401,7 @@ struct bam_device {
 
 	/* dma start transaction tasklet */
 	struct tasklet_struct task;
+	u32 bam_revision;
 };
 
 /**
@@ -441,8 +445,10 @@ static void bam_reset(struct bam_device *bdev)
 	writel_relaxed(val, bam_addr(bdev, 0, BAM_CTRL));
 
 	/* set descriptor threshold, start with 4 bytes */
-	writel_relaxed(DEFAULT_CNT_THRSHLD,
-			bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
+	if (bdev->bam_revision >= BAM_NDP_REVISION_START &&
+	    bdev->bam_revision <= BAM_NDP_REVISION_END)
+		writel_relaxed(DEFAULT_CNT_THRSHLD,
+			       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
 
 	/* Enable default set of h/w workarounds, ie all except BAM_FULL_PIPE */
 	writel_relaxed(BAM_CNFG_BITS_DEFAULT, bam_addr(bdev, 0, BAM_CNFG_BITS));
@@ -1000,9 +1006,10 @@ static void bam_apply_new_config(struct bam_chan *bchan,
 			maxburst = bchan->slave.src_maxburst;
 		else
 			maxburst = bchan->slave.dst_maxburst;
-
-		writel_relaxed(maxburst,
-			       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
+		if (bdev->bam_revision >= BAM_NDP_REVISION_START &&
+		    bdev->bam_revision <= BAM_NDP_REVISION_END)
+			writel_relaxed(maxburst,
+				       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
 	}
 
 	bchan->reconfigure = 0;
@@ -1192,10 +1199,11 @@ static int bam_init(struct bam_device *bdev)
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


