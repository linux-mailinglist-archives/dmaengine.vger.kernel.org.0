Return-Path: <dmaengine+bounces-4117-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73400A11F81
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2025 11:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9C6F7A3266
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2025 10:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A75A2419FF;
	Wed, 15 Jan 2025 10:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fGkGx9L/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07612419F9;
	Wed, 15 Jan 2025 10:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937047; cv=none; b=uRQ6x+7BD+eBr+D4b1KvVJe9IPBjWpKuLEq3s88zkCrRFnUQcz5bft611y7MGLsiBhYNktlo9ucJ/q+xJ28wc/Et7oWwyvGzZ2BqvW5JXcw565LZdno4Yt5nawK/pgShU86pr6d/6KPOzYIpCit5WnpvdrnKNKqdDA613YtN00c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937047; c=relaxed/simple;
	bh=tyRH4hWgVkmwRkeJCMVYy/axiM2CfcoV0SLa3mJn/nM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2O6omIBLt47eZOEk+C05sFppFUuysRxRi2AOWtS+9ZGscxFUDqlivgUZb/dFOeNULLtXdCeRiu0afh4JqKmQUYcxAM+xMPICCwWr1dlNs49jHpZl4T0vUF8+QIcTeE47Z5piQNSOd7bnZvYUKyGk/L/AOvNNflzfo3FJ+cUkUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fGkGx9L/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F1YWTj007296;
	Wed, 15 Jan 2025 10:30:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CmLfZYu52St6C+4cOtaMOUaYGZlyQcFNWFGEW5J7rPk=; b=fGkGx9L/dd1G/qhv
	lyQR5GEIqJQQBPlKsEPeWo2k1oqu570Vf9CLkkc/HcUxSQJ8UjA8rru+Rc122z9y
	BEA/wglPGjNyhTjvZ7nwh0zgaRe9wkZ6WccAWXEA92mI6bw/iZX+SKU/8CtRlI4r
	eCTFlAbtgu05szDPs7B6VEDHHg9wkBwn1ENnPd1rJRc93I68EjrPLUvPF4nxOtTo
	goa5jxjo0HfTZf8vbC7Wv68r9bHQRaQEoD7D2g2v7XsjMoBoNednnNhDOa8C5YL7
	Uem/dAAAi+B38skZGDvBePnNILu1TNJqyUc+hlS7NlgrjvbRsnoAQtmU9ESGt5/D
	K9H9Dw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4463frs7f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 10:30:35 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50FAUY4R025210
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 10:30:34 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 15 Jan 2025 02:30:28 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <vkoul@kernel.org>, <corbet@lwn.net>, <thara.gopinath@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <martin.petersen@oracle.com>, <enghua.yu@intel.com>,
        <u.kleine-koenig@baylibre.com>, <dmaengine@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
CC: <quic_mdalam@quicinc.com>, <quic_utiwari@quicinc.com>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v6 01/12] dmaengine: qcom: bam_dma: Add bam_sw_version register read
Date: Wed, 15 Jan 2025 15:59:53 +0530
Message-ID: <20250115103004.3350561-2-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250115103004.3350561-1-quic_mdalam@quicinc.com>
References: <20250115103004.3350561-1-quic_mdalam@quicinc.com>
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
X-Proofpoint-ORIG-GUID: _Qh-hpnP_gsOjJRPEZDhJwXb0H-uUVCl
X-Proofpoint-GUID: _Qh-hpnP_gsOjJRPEZDhJwXb0H-uUVCl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_04,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150079

Add bam_sw_version register read. This will help to
differentiate b/w some new BAM features across multiple
BAM IP, feature like LOCK/UNLOCK of BAM pipe.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

change in [v6]

* No change

change in [v5]

* No change

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
index c14557efd577..daeacd5cb8e9 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -83,6 +83,7 @@ struct bam_async_desc {
 enum bam_reg {
 	BAM_CTRL,
 	BAM_REVISION,
+	BAM_SW_VERSION,
 	BAM_NUM_PIPES,
 	BAM_DESC_CNT_TRSHLD,
 	BAM_IRQ_SRCS,
@@ -117,6 +118,7 @@ struct reg_offset_data {
 static const struct reg_offset_data bam_v1_3_reg_info[] = {
 	[BAM_CTRL]		= { 0x0F80, 0x00, 0x00, 0x00 },
 	[BAM_REVISION]		= { 0x0F84, 0x00, 0x00, 0x00 },
+	[BAM_SW_VERSION]	= { 0x0F88, 0x00, 0x00, 0x00 },
 	[BAM_NUM_PIPES]		= { 0x0FBC, 0x00, 0x00, 0x00 },
 	[BAM_DESC_CNT_TRSHLD]	= { 0x0F88, 0x00, 0x00, 0x00 },
 	[BAM_IRQ_SRCS]		= { 0x0F8C, 0x00, 0x00, 0x00 },
@@ -146,6 +148,7 @@ static const struct reg_offset_data bam_v1_3_reg_info[] = {
 static const struct reg_offset_data bam_v1_4_reg_info[] = {
 	[BAM_CTRL]		= { 0x0000, 0x00, 0x00, 0x00 },
 	[BAM_REVISION]		= { 0x0004, 0x00, 0x00, 0x00 },
+	[BAM_SW_VERSION]	= { 0x0008, 0x00, 0x00, 0x00 },
 	[BAM_NUM_PIPES]		= { 0x003C, 0x00, 0x00, 0x00 },
 	[BAM_DESC_CNT_TRSHLD]	= { 0x0008, 0x00, 0x00, 0x00 },
 	[BAM_IRQ_SRCS]		= { 0x000C, 0x00, 0x00, 0x00 },
@@ -175,6 +178,7 @@ static const struct reg_offset_data bam_v1_4_reg_info[] = {
 static const struct reg_offset_data bam_v1_7_reg_info[] = {
 	[BAM_CTRL]		= { 0x00000, 0x00, 0x00, 0x00 },
 	[BAM_REVISION]		= { 0x01000, 0x00, 0x00, 0x00 },
+	[BAM_SW_VERSION]	= { 0x01004, 0x00, 0x00, 0x00 },
 	[BAM_NUM_PIPES]		= { 0x01008, 0x00, 0x00, 0x00 },
 	[BAM_DESC_CNT_TRSHLD]	= { 0x00008, 0x00, 0x00, 0x00 },
 	[BAM_IRQ_SRCS]		= { 0x03010, 0x00, 0x00, 0x00 },
@@ -393,6 +397,7 @@ struct bam_device {
 	bool controlled_remotely;
 	bool powered_remotely;
 	u32 active_channels;
+	u32 bam_sw_version;
 
 	const struct reg_offset_data *layout;
 
@@ -1306,6 +1311,9 @@ static int bam_dma_probe(struct platform_device *pdev)
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


