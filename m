Return-Path: <dmaengine+bounces-4168-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F97A179E7
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jan 2025 10:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED54516711E
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jan 2025 09:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD73D1B6CF3;
	Tue, 21 Jan 2025 09:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ULlHYIDd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7D41B4220;
	Tue, 21 Jan 2025 09:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737450787; cv=none; b=OxXvgw5Kka3wNUcCqQIEd/KRHcDhamKbnad7ey5Lza/SxS1olgjKnL3YVDafq7A7Ervxap2xxLm7V9yZ6akbxanuo5FKaryJrZLl603oA1e9MeUWQESNyjWtcYRMcfSNPxxu5S3Z4nB/a21dp7UabknSu6Xw+YPJ1ueYSeK5AcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737450787; c=relaxed/simple;
	bh=W+QpOlafnZtqhVNemIRkSmGvcSYiLVd2/+oe+0n2F4U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rjlhuQ+82W/SlU7X0k4SrlBuwbVIbWwjPTTZGOzut74d41bhxdwWDN3WaXQ2zAwNIVOSDZAjgLvWlMx+rxKm6oGWdxnR3jYcZNUJ++m8ZjJa5YoKwUYHcDTYp8KfvoqDs0gdfY2TnbXDbc/mhTv5SCIVyL4uODcKZb7Ryyps99E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ULlHYIDd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50L8ZABl020646;
	Tue, 21 Jan 2025 09:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=94M70Hf9P1AsIAT1974roz
	NzRVeN4v8DAPIEZwsDnEs=; b=ULlHYIDd8I7ATgjfo870xsPgdn41RYMHY/SPyI
	8BrekgESUjyqJPTqVFtVKPlJ114Fz3nIOhd6fjDXbK1qzlRNp4y8gNrurOF7cOgU
	qxkPnE1v3HyO+e+wCWeEh3Jt3K29NVZzdFJq88g0x07UocV7YC+TyNCacPzl4gUY
	2MsW85RixT4TdHvqPScQr/SkPoruo0R+rc2nQ1ENptVEwaUD3CLnBG6k9p+Sk43m
	GhLQXWsKv7R0AIE90ML7FkZg2PXZuKihhucDdXKfsO2+XdCCt6w9hNIMToif2b/0
	JEFEd1xBqat+O3iOlErq6wz6SgeFX1D1oWwmXcAKBf2YvPMg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44a8658424-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 09:13:01 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50L9D0e4029038
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 09:13:00 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 21 Jan 2025 01:12:57 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <vkoul@kernel.org>, <kees@kernel.org>, <fenghua.yu@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <djakov@kernel.org>, <quic_mdalam@quicinc.com>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v3] dmaengine: qcom: bam_dma: Fix BAM_RIVISON register handling
Date: Tue, 21 Jan 2025 14:42:41 +0530
Message-ID: <20250121091241.2646532-1-quic_mdalam@quicinc.com>
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
X-Proofpoint-ORIG-GUID: HxXoWQ4hu56LsWS4o6moX7-nC_JOv9gx
X-Proofpoint-GUID: HxXoWQ4hu56LsWS4o6moX7-nC_JOv9gx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_04,2025-01-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501210075

This patch resolves a bug from the previous commit where the
BAM_DESC_CNT_TRSHLD register was conditionally written based on BAM-NDP
mode. The issue was reading the BAM_REVISION register hanging if num-ees
was not zero, which occurs when the SoCs power on BAM remotely. So the
BAM_REVISION register read has been moved to inside if condition.

Fixes: 57a7138d0627 ("dmaengine: qcom: bam_dma: Avoid writing unavailable register")
Reported-by: Georgi Djakov <djakov@kernel.org>
Link: https://lore.kernel.org/lkml/9ef3daa8-cdb1-49f2-8d19-a72d6210ff3a@kernel.org/
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v3]

* Revised commit details

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


