Return-Path: <dmaengine+bounces-4144-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF282A14E40
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jan 2025 12:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC484168154
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jan 2025 11:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8761FDE0E;
	Fri, 17 Jan 2025 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gufkFryW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AC31FCFF0;
	Fri, 17 Jan 2025 11:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737112408; cv=none; b=KxuH7qbD487r4W3Qbj57ppixMnxrwfP1GPG1NgaGX/SlyNNgNzvyvS8w9EtXNN9pE7fQTxO6/xGci03g2q8mg+5pRuELePt3h8J/R/b2t1xmLoZx8C7XsMMIcJiTwlgYcZm2DpFyAzp4hR9/G3XPOwLn4ZbfndS670mZ8a6rjps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737112408; c=relaxed/simple;
	bh=kHFAtMX0Uf7TDFFibjM/zk7WkMPgu9fObhHCWjiV1bg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q/qeMJiHMvrUG4MoP/UWu87MoVDgWT3EG1+7G0Kmow4SMCfip19i2ndtFEi9kAgtVkXGkHGDGSvVta2jaGRkn2Rp2aNr72ID+f5d6/oN6zCGJ+LPnBvQ4wJz46Od8iY/vK1qkX7oMxUkT3mAm0ozKvtpBsFujdNJxb8c1JfHfuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gufkFryW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H97eqe017860;
	Fri, 17 Jan 2025 11:13:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=SuIh9CME4aGdVYvwpSyo0C
	w8LBKKhohmzJmuWmIBr/U=; b=gufkFryWgkLkvQZYA3sDMWVxoo/EyZNqhZIflF
	y1tjBuQtEU0LT7OYkQaLen4uSvpYpGSUaiCHnyvFX7BcrJ3vjtBUY0SC/MCdRNNE
	7ACxhmGMxuDcFl8Sggw++AABVa1gQMQpvdsXLd0LtZT74tJ2SU1AlFn+Ok5+EDHM
	euUix4FveJtP+u2QvY5tvUBgWButw1gTMvhBnj0e8/i6pymc27HAkYFqoLBBaHuE
	K1UwHkv+MGNHnQZYwraHNzpdO0nMeXgXzjmEy+JoUv+QP52lTNf6hlYGAk1MFmNw
	4F5yXtxMIj0pmBXcLo9q9o8Jfrtpmq0/TJvJxT6h5Yv9fKBw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 447ma50av8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 11:13:22 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50HBDLM8001917
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 11:13:21 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 17 Jan 2025 03:13:18 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <vkoul@kernel.org>, <robin.murphy@arm.com>,
        <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <quic_mdalam@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_srichara@quicinc.com>
Subject: [PATCH v2] dmaengine: qcom: bam_dma: Fix BAM_RIVISON register handling
Date: Fri, 17 Jan 2025 16:43:02 +0530
Message-ID: <20250117111302.2073993-1-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: C4aBfbeDE9po_ZoOvNJ4wsAXZVD1iJ97
X-Proofpoint-ORIG-GUID: C4aBfbeDE9po_ZoOvNJ4wsAXZVD1iJ97
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_04,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501170089

This patch resolves a bug from the previous commit where the
BAM_DESC_CNT_TRSHLD register was conditionally written based on BAM-NDP
mode. It also fixes an issue where reading the BAM_REVISION register
would hang if num-ees was not zero, which occurs when the SoCs power on
BAM remotely. The BAM_REVISION register read has been moved to inside if
condition.

Cc: stable@vger.kernel.org
Fixes: 57a7138d0627 ("dmaengine: qcom: bam_dma: Avoid writing unavailable register")
Reported-by: Georgi Djakov <djakov@kernel.org>
Link: https://lore.kernel.org/lkml/9ef3daa8-cdb1-49f2-8d19-a72d6210ff3a@kernel.org/
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v2]

* Removed unnecessary if checks.
* Relocated the BAM_REVISION register read within the if condition.

Change in [v1]

* https://lore.kernel.org/lkml/1a5fc7e9-39fe-e527-efc3-1ea990bbb53b@quicinc.com/
* Posted initial fixup for BAM revision register read handling

 drivers/dma/qcom/bam_dma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index c14557efd577..d227b4f5b6b9 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1199,11 +1199,11 @@ static int bam_init(struct bam_device *bdev)
 	u32 val;
 
 	/* read revision and configuration information */
-	val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
-	if (!bdev->num_ees)
+	if (!bdev->num_ees) {
+		val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
 		bdev->num_ees = (val >> NUM_EES_SHIFT) & NUM_EES_MASK;
-
-	bdev->bam_revision = val & REVISION_MASK;
+		bdev->bam_revision = val & REVISION_MASK;
+	}
 
 	/* check that configured EE is within range */
 	if (bdev->ee >= bdev->num_ees)
-- 
2.34.1


