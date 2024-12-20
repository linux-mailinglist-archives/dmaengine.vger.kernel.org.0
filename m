Return-Path: <dmaengine+bounces-4046-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 252C19F8F37
	for <lists+dmaengine@lfdr.de>; Fri, 20 Dec 2024 10:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74F80169E99
	for <lists+dmaengine@lfdr.de>; Fri, 20 Dec 2024 09:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A891A83FE;
	Fri, 20 Dec 2024 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Kz0jSYBa"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103D11514F8;
	Fri, 20 Dec 2024 09:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734687832; cv=none; b=BzluYCJZ3/MAyj5EbEflJ+VTFIEvUu4/x31Bdln55XysgEIqW51Vh4Y/yFxEVy/xXiu0B16PLsFgvQsu76O3GdkRYAdhPa5Q5IfGUclFOx/X670i2HThDdyGi+Pmq+RX0Ji6hNApoyv745Iu1IBCasNYsOX7BIVyC8OcwnfWAkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734687832; c=relaxed/simple;
	bh=amthS/ZZdHAgOnI9mwtKjup7ZXYZEK7xfgEaA4/nzd8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bc9EL5l03XGpDs5FWQJ+nZiOCIJUHq3Py6SiVpyfOLVcwxhf2oo4GDtQ84vgm1b++Q5iVpdbbiPPX2BwY8KjUB/CMJ5HD+P/9B4uSCv82kqF5ylb2dLPkSRW8y6lao8KF1Apt7tiWSU7ozsahzGwf4sX7BrBVPRotTQSdLHCejA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Kz0jSYBa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK5fgU5006609;
	Fri, 20 Dec 2024 09:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=dcY1msBGgNuskSKzAcovGg
	BhF0T46kWtI/mO3ufaXEo=; b=Kz0jSYBamkyZ6xPXQWd8m1g8RCQQEU8IBhV9cc
	IOUUJA2FqujR848ZNRW9PvxI0JH48yt3d8zU8/HK3fUEVSlQ9myNpK+3fw0ZUzNq
	GpuAD8EHQhQvmWfuioKiHF9zTh7l4ZbIsR+GUfjbzRKaQILvHuDfg4hXNeUTnqaI
	g2YLI295K7zW+BUcw2zG/CEugB94oIN0DoEBVzdBJUoAUDpkGBYgc7cw29AQkqL+
	XOAjE2Tua+dWpFJNf6HfZGdnSg1Yjfd+3+FR3Fm/j/Q7m2zLIc+mOhQfPz7/0q/h
	rDmMLhte77Gdi1SG5CfTVSFulSJ3iuQ8B8XirmgfeA8ZldIA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43n2n5rmwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 09:43:40 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BK9heME014407
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 09:43:40 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 20 Dec 2024 01:43:35 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <vkoul@kernel.org>, <robin.murphy@arm.com>, <u.kleine-koenig@baylibre.com>,
        <martin.petersen@oracle.com>, <fenghua.yu@intel.com>,
        <av2082000@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <quic_mmanikan@quicinc.com>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>, <quic_mdalam@quicinc.com>
Subject: [PATCH v4] dmaengine: qcom: bam_dma: Avoid writing unavailable register
Date: Fri, 20 Dec 2024 15:12:03 +0530
Message-ID: <20241220094203.3510335-1-quic_mdalam@quicinc.com>
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
X-Proofpoint-ORIG-GUID: MNBD3vldTeqOL4lSqBESpUbOI1EpSLXR
X-Proofpoint-GUID: MNBD3vldTeqOL4lSqBESpUbOI1EpSLXR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200080

Avoid writing unavailable register in BAM-Lite mode.
BAM_DESC_CNT_TRSHLD register is unavailable in BAM-Lite
mode. Its only available in BAM-NDP mode. So only write
this register for clients who is using BAM-NDP.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
Change in [v4]

* Added in_range() macro

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
index bbc3276992bb..c14557efd577 100644
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
+	if (in_range(bdev->bam_revision, BAM_NDP_REVISION_START,
+		     BAM_NDP_REVISION_END))
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
+		if (in_range(bdev->bam_revision, BAM_NDP_REVISION_START,
+			     BAM_NDP_REVISION_END))
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


