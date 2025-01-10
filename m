Return-Path: <dmaengine+bounces-4091-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEC4A08667
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2025 06:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29283A6DDC
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2025 05:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F7B1E32CD;
	Fri, 10 Jan 2025 05:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WcnOJDzY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8731779B8;
	Fri, 10 Jan 2025 05:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736486077; cv=none; b=PGCtaEcqhS37VuqYx5ECAMLTUIyuRCN9bHzlKd805/FgGEg0e9X1s+utbWVe+fRkqxT/qJtdvcO7BK4rsEtQZ7/9Ach1L2UbVLVHJtgw2p4+uLdojXmew8eSbTuCTb2ZDxjc4LJXQVZrl9npa5w55RXSGkhZMlTxE7W++mtOT+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736486077; c=relaxed/simple;
	bh=F+Wr36cBQdZXvuqsi5PWVCo9OUJMHv88U3bwAomtQ2I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cr01c+RUWvFApYgoSkKJPdYWRy1xH8L5Lqeo0nlKtplvnd+BZ6fhEd50FzbaC6zqKb8rHpgAtMwwVvCUuEvGleqH7lCe3j5kY+DR0iNyrJquo6EdD29fKAprcYCXZeRAF53fI1VYdrtivhqsuVJfj5FDIHI++gt9Q/nk8k6+M3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WcnOJDzY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A2hXns016209;
	Fri, 10 Jan 2025 05:14:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=AXROfEKwsawrQMOPazIGwg
	E2803cid/sTU2pojxecf0=; b=WcnOJDzYVa8XgHyukQ4ge2amkgl2yymG0aN4WV
	d31VUWqpfrkJGQSObOLgrokNnqN5aKJhv4jb5peG4ff20A4qwURWvSkWv1PKpQjw
	JyhBZU0q8YY2NvDJMqr12aHiAubHbtBceDkeOYcZiLnc6y2ITRqvS4+Le+bnZ55s
	jOkhtcelPQgKImGyMDLtZwNtDBM5h4rZcVEeS86AT3dsesrzP7wR/dy6isQLn1Y3
	yPFTp/LMjZHRtlgffU7ELwovixlp0RfciS54Gr/58WN1CvDvWZvhO1dQ+aJ7j4px
	Cz80E71k9pm50roaqPyIBi9nMPFkmIm93ACU4amUuKpH9/dA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442u14g971-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 05:14:29 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50A5ESAK003898
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 05:14:28 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 9 Jan 2025 21:14:24 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <vkoul@kernel.org>, <ulf.hansson@linaro.org>, <robin.murphy@arm.com>,
        <kees@kernel.org>, <u.kleine-koenig@baylibre.com>,
        <linux-arm-msm@vger.kernel.org>, <av2082000@gmail.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <djakov@kernel.org>, <quic_mdalam@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_srichara@quicinc.com>
Subject: [PATCH] dmaengine: qcom: bam_dma: Fix BAM_RIVISON register handling
Date: Fri, 10 Jan 2025 10:44:09 +0530
Message-ID: <20250110051409.4099727-1-quic_mdalam@quicinc.com>
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
X-Proofpoint-ORIG-GUID: UD5LKxM1sc_Yby05jVzIekfWnAe8VX5l
X-Proofpoint-GUID: UD5LKxM1sc_Yby05jVzIekfWnAe8VX5l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100041

This patch fixes a bug introduced in the previous commit where the
BAM_DESC_CNT_TRSHLD register was conditionally written based on BAM-NDP
mode. Additionally, it addresses an issue where reading the BAM_REVISION
register hangs if num-ees is not zero. A check has been added to prevent
this.

Cc: stable@vger.kernel.org
Fixes: 57a7138d0627 ("dmaengine: qcom: bam_dma: Avoid writing unavailable register")
Reported-by: Georgi Djakov <djakov@kernel.org>
Link: https://lore.kernel.org/lkml/9ef3daa8-cdb1-49f2-8d19-a72d6210ff3a@kernel.org/
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
 drivers/dma/qcom/bam_dma.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index c14557efd577..2b88b27f2f91 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -445,11 +445,15 @@ static void bam_reset(struct bam_device *bdev)
 	writel_relaxed(val, bam_addr(bdev, 0, BAM_CTRL));
 
 	/* set descriptor threshold, start with 4 bytes */
-	if (in_range(bdev->bam_revision, BAM_NDP_REVISION_START,
-		     BAM_NDP_REVISION_END))
+	if (!bdev->num_ees && in_range(bdev->bam_revision, BAM_NDP_REVISION_START,
+				       BAM_NDP_REVISION_END))
 		writel_relaxed(DEFAULT_CNT_THRSHLD,
 			       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
 
+	if (bdev->num_ees && !bdev->bam_revision)
+		writel_relaxed(DEFAULT_CNT_THRSHLD, bam_addr(bdev, 0,
+							     BAM_DESC_CNT_TRSHLD));
+
 	/* Enable default set of h/w workarounds, ie all except BAM_FULL_PIPE */
 	writel_relaxed(BAM_CNFG_BITS_DEFAULT, bam_addr(bdev, 0, BAM_CNFG_BITS));
 
@@ -1006,10 +1010,14 @@ static void bam_apply_new_config(struct bam_chan *bchan,
 			maxburst = bchan->slave.src_maxburst;
 		else
 			maxburst = bchan->slave.dst_maxburst;
-		if (in_range(bdev->bam_revision, BAM_NDP_REVISION_START,
-			     BAM_NDP_REVISION_END))
+		if (!bdev->num_ees && in_range(bdev->bam_revision, BAM_NDP_REVISION_START,
+					       BAM_NDP_REVISION_END))
 			writel_relaxed(maxburst,
 				       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
+
+		if (bdev->num_ees && !bdev->bam_revision)
+			writel_relaxed(DEFAULT_CNT_THRSHLD, bam_addr(bdev, 0,
+								     BAM_DESC_CNT_TRSHLD));
 	}
 
 	bchan->reconfigure = 0;
@@ -1196,12 +1204,13 @@ static struct dma_chan *bam_dma_xlate(struct of_phandle_args *dma_spec,
  */
 static int bam_init(struct bam_device *bdev)
 {
-	u32 val;
+	u32 val = 0;
 
 	/* read revision and configuration information */
-	val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
-	if (!bdev->num_ees)
+	if (!bdev->num_ees) {
+		val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
 		bdev->num_ees = (val >> NUM_EES_SHIFT) & NUM_EES_MASK;
+	}
 
 	bdev->bam_revision = val & REVISION_MASK;
 
-- 
2.34.1


