Return-Path: <dmaengine+bounces-3949-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FE09EDE21
	for <lists+dmaengine@lfdr.de>; Thu, 12 Dec 2024 05:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6FF28333B
	for <lists+dmaengine@lfdr.de>; Thu, 12 Dec 2024 04:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C725977F11;
	Thu, 12 Dec 2024 04:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NqkVlm5j"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62892905;
	Thu, 12 Dec 2024 04:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733977033; cv=none; b=cZKH9sjhbAkhrTwK8ur+FRIP0SEP5QVkZIXYPrVx3lI8lvkE0ghPft8mLSx0fsJCkefwONn9hvgAOGc+R1yAWpwbhg6Z0Z5ELWHkfJjAr/HHvpyMfi0JCdscdlsZdK/p3VOYntYA9sFVfCYdXK9VNVMUOHmpyfLhQIvZToQpU2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733977033; c=relaxed/simple;
	bh=MxIViu8R+BODZ1fTSnXOnUYQzBpVG12EM+mLiSTMncE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRAuCotpo/9Ko2oaWyDdq28UjC2ogTjWX2rpu2Dy4phZSEyw5FzulZYAeN62b61ZY5/6qF9ZZgMwVv3Kcg5VAbMVfg/7inYE0a4XP2c/i5pt8/j93Ncq0FYLtIrqbzksOjon37RLXZdDv9sqvFXs/aY+BzYm5gJnJeWf5+Chgsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NqkVlm5j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBLWoYH006448;
	Thu, 12 Dec 2024 04:17:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lvFuDsLPuKbV2eKOfvKU+wg4I7Q+hte2XgtVTBMZn6U=; b=NqkVlm5jh8cfhaqE
	o+mIOFmabu2ikAX2P1jdTUNzksB3oYKxd64EQgKVmtBT7HIFylRlskRi3duXoFZf
	EY/DAYksPWrkbvm3FczqYB26ZfezvNJMQAwpZRQf4pmkI9R2u9jGioDYn83Ek4vb
	gCUjz/Vafz1rOG3SJ/aPQ4waa/ix6jn5BfY0CmUMPy22O590/TjVfNa6ioVuZbB8
	TC/rzS8+57SINS9FZcQUsr0vrgY+V2yvjpjguSi6tFmM3ifXrML+iYpWlsHO8zM/
	8mjslg1F/hnJFZiK1zUvc31rnMCv4EXmbHDybGIXD4ED4LA0Pc2doqCSvcIalR8l
	gHcHZA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43f6tfaxah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 04:17:04 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BC4H3Gt020643
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 04:17:03 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 11 Dec 2024 20:16:58 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <vkoul@kernel.org>, <corbet@lwn.net>, <thara.gopinath@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <kees@kernel.org>, <dave.jiang@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_mdalam@quicinc.com>, <quic_utiwari@quicinc.com>
Subject: [PATCH v5 01/12] dmaengine: qcom: bam_dma: Add bam_sw_version register read
Date: Thu, 12 Dec 2024 09:46:28 +0530
Message-ID: <20241212041639.4109039-2-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212041639.4109039-1-quic_mdalam@quicinc.com>
References: <20241212041639.4109039-1-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: IfbsXRzpwLxQwe1N4tGT55G-zGRIMde6
X-Proofpoint-ORIG-GUID: IfbsXRzpwLxQwe1N4tGT55G-zGRIMde6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120028

Add bam_sw_version register read. This will help to
differentiate b/w some new BAM features across multiple
BAM IP, feature like LOCK/UNLOCK of BAM pipe.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

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
index bbc3276992bb..3980c9d501c3 100644
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


