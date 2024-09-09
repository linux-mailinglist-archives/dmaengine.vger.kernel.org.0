Return-Path: <dmaengine+bounces-3112-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 489EC9713D9
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 11:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01BF6285B5B
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 09:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDFB1B2EFA;
	Mon,  9 Sep 2024 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Mjl3piMY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FE71B142F;
	Mon,  9 Sep 2024 09:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874350; cv=none; b=JFqXWdO4RyrrsmWRD/ENzKh9PYbITS1tunnBUaXrO853aGsV63YUBS7oydTFnYw60waz8aFvqxvbpdhQqt+tn9WvdIqbQrzBMfSvVwRSSojR4vNG218i3pFJ32I1GCCYciLptMoNNmwXb17MXSz8M9b5PA7h7ED1NqgTVOCj5Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874350; c=relaxed/simple;
	bh=hKCQYKKvrT0BTjC1HdEelx0g32L60/TI+ek06m8hv3o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NI/ysuLcYf33+Anglw7mEc6cXOgUMWmGxVWsf4rnCUt+UMPwWnOe0gEA+4jhCzYWRaBodo3NtI+rhL/D4wcImmc4L8EKaptr+NER0XL1j/mFvD/mWU3+U02vwF1iSQecA6+lZq2OZ21xrtNa4EJ8ofrRGWX5FqU+O0T2gfWhIUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Mjl3piMY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4899KOfl030931;
	Mon, 9 Sep 2024 09:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kIxJpoKToWHEk37OVZzpMmSUqmveUzu6daAQAhHwmcA=; b=Mjl3piMYQCeMESDD
	WbV4/qyKG9aY+mtum86gNRS6FdvJNVyMX3CZf1rH5hU5aznDeRK+SBo2A1W3qb4d
	rN4L92lKTwujrhgjf4q21sEI0SQN39NoAJljtt6iZzcVRAg9tegEgGps3WgBEy1H
	unYFmYPwzVNbM8Gfzr/QFXmdzo7h7kO261bQSOjtzv2uti2FoBVatB2uAiW9318r
	Hy9nVmnprr2TH3XVO7KY+klHY4va629JJV90bfXYqMBTygCxdJbRYagNrusORz+Z
	GdlKQX6hNbQiObt3urW/yGHLJObBK7wiO8o+oNZFGLWjS1C479PuZFIJ69Aowe+G
	Bmm0Sg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy59tchc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 09:27:15 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4899RFWI002765
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Sep 2024 09:27:15 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 9 Sep 2024 02:27:09 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <thara.gopinath@gmail.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <vkoul@kernel.org>, <kees@kernel.org>,
        <robin.murphy@arm.com>, <fenghua.yu@intel.com>, <av2082000@gmail.com>,
        <u.kleine-koenig@pengutronix.d>, <linux-crypto@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <quic_varada@quicinc.com>,
        <quic_srichara@quicinc.com>
CC: <quic_mdalam@quicinc.com>
Subject: [PATCH v4 01/11] dmaengine: qcom: bam_dma: Add bam_sw_version register read
Date: Mon, 9 Sep 2024 14:56:22 +0530
Message-ID: <20240909092632.2776160-2-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240909092632.2776160-1-quic_mdalam@quicinc.com>
References: <20240909092632.2776160-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pfoZM60noFcL-rk-T8BV_qFo2r_4aOMX
X-Proofpoint-ORIG-GUID: pfoZM60noFcL-rk-T8BV_qFo2r_4aOMX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409090074

Add bam_sw_version register read. This will help to
differentiate b/w some new BAM features across multiple
BAM IP, feature like LOCK/UNLOCK of BAM pipe.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

change in [v4]

* Added BAM_SW_VERSION register read

change in [v3]

* This patch was not included in [v3]

change in [v2]

* This patch was not included in [v2]

change in [v1]

* This patch was not included in [v1]

 drivers/dma/qcom/bam_dma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index d43a881e43b9..3a2965939531 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -80,6 +80,7 @@ struct bam_async_desc {
 enum bam_reg {
 	BAM_CTRL,
 	BAM_REVISION,
+	BAM_SW_VERSION,
 	BAM_NUM_PIPES,
 	BAM_DESC_CNT_TRSHLD,
 	BAM_IRQ_SRCS,
@@ -114,6 +115,7 @@ struct reg_offset_data {
 static const struct reg_offset_data bam_v1_3_reg_info[] = {
 	[BAM_CTRL]		= { 0x0F80, 0x00, 0x00, 0x00 },
 	[BAM_REVISION]		= { 0x0F84, 0x00, 0x00, 0x00 },
+	[BAM_SW_VERSION]	= { 0x0F88, 0x00, 0x00, 0x00 },
 	[BAM_NUM_PIPES]		= { 0x0FBC, 0x00, 0x00, 0x00 },
 	[BAM_DESC_CNT_TRSHLD]	= { 0x0F88, 0x00, 0x00, 0x00 },
 	[BAM_IRQ_SRCS]		= { 0x0F8C, 0x00, 0x00, 0x00 },
@@ -143,6 +145,7 @@ static const struct reg_offset_data bam_v1_3_reg_info[] = {
 static const struct reg_offset_data bam_v1_4_reg_info[] = {
 	[BAM_CTRL]		= { 0x0000, 0x00, 0x00, 0x00 },
 	[BAM_REVISION]		= { 0x0004, 0x00, 0x00, 0x00 },
+	[BAM_SW_VERSION]	= { 0x0008, 0x00, 0x00, 0x00 },
 	[BAM_NUM_PIPES]		= { 0x003C, 0x00, 0x00, 0x00 },
 	[BAM_DESC_CNT_TRSHLD]	= { 0x0008, 0x00, 0x00, 0x00 },
 	[BAM_IRQ_SRCS]		= { 0x000C, 0x00, 0x00, 0x00 },
@@ -172,6 +175,7 @@ static const struct reg_offset_data bam_v1_4_reg_info[] = {
 static const struct reg_offset_data bam_v1_7_reg_info[] = {
 	[BAM_CTRL]		= { 0x00000, 0x00, 0x00, 0x00 },
 	[BAM_REVISION]		= { 0x01000, 0x00, 0x00, 0x00 },
+	[BAM_SW_VERSION]	= { 0x01004, 0x00, 0x00, 0x00 },
 	[BAM_NUM_PIPES]		= { 0x01008, 0x00, 0x00, 0x00 },
 	[BAM_DESC_CNT_TRSHLD]	= { 0x00008, 0x00, 0x00, 0x00 },
 	[BAM_IRQ_SRCS]		= { 0x03010, 0x00, 0x00, 0x00 },
@@ -390,6 +394,7 @@ struct bam_device {
 	bool controlled_remotely;
 	bool powered_remotely;
 	u32 active_channels;
+	u32 bam_sw_version;
 
 	const struct reg_offset_data *layout;
 
@@ -1298,6 +1303,9 @@ static int bam_dma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	bdev->bam_sw_version = readl_relaxed(bam_addr(bdev, 0, BAM_SW_VERSION));
+	dev_info(bdev->dev, "BAM software version:0x%08x\n", bdev->bam_sw_version);
+
 	ret = bam_init(bdev);
 	if (ret)
 		goto err_disable_clk;
-- 
2.34.1


