Return-Path: <dmaengine+bounces-4119-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC549A11F8B
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2025 11:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF103A9531
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2025 10:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D0D2442F3;
	Wed, 15 Jan 2025 10:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a8w+v85R"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E502442F9;
	Wed, 15 Jan 2025 10:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937057; cv=none; b=ZkQ6zUuF7O7WKkq/Azm4y17UJaYj2/VNsLPsnJuFNgvgQn5w6VauBVREJJbs6t7HstCvhJLC27QarUd6LNrdH2CK3LMTV8U8nKBoEdfGhoJzOc3fl42EoYniEwcKldm3rLAcbRK5PHAUgSkkOgBoIXjCh/Zm7Ue9JAjHE4ieyHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937057; c=relaxed/simple;
	bh=pkV9dtmaozB2PtJBn/sjT4+4YgXCKKY0Vu3AgXVdhco=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hw0OdnFkR5Hk/QWqTJu1SpXBXhQOiD6YMSYEeJFWI2C8y+toleZdKJ4Hp9SyTmdRSXbGrcQZe8ldHD2qHX5N2nGPkSJQm6egOtSMn/UrY4H0dPylu0/7JfclbQ7RiVLxOXQGOFdPvpGVpP29HxfplSbs9RwOfJ8WxzTH5Xq/Ohk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a8w+v85R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F1YdXd007926;
	Wed, 15 Jan 2025 10:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xzwwFdhSHu3AJ9b0LLrT0xzgiYDvQ7Y3FxoutXE6JLw=; b=a8w+v85Rmc11113W
	7mLLguN854RvMYS1Ukw2QW6jXKLSTJm+hMLEp+RiSVnzC8QiuG0dRth1HVatzYdB
	SCxcr8Im/IMctYYkk1zgqXB2maekmRXS5FEAJiRkXa/xFmFu61zaZ3sBBwWN9pul
	ywdAfkTlf9FMEPmNbQ3oYlJ1pai1F5xSaa1bss8/mLQeLDUuF4yicPJV8ZlPq9YC
	QaiZO0wH/MnYe8T2m9FEnjlIReZ4TB46XFzyAF+Wuzpff/59/ZJf846k9QqGGwrM
	S5s6DYCopHhWUCQZq5sIUIlsGWwCSLKlLWUlkvCs/kVkg+slWdzVb+nJazwlrHE4
	UbG0uA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4463frs7fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 10:30:45 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50FAUiV8006357
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 10:30:44 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 15 Jan 2025 02:30:39 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <vkoul@kernel.org>, <corbet@lwn.net>, <thara.gopinath@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <martin.petersen@oracle.com>, <enghua.yu@intel.com>,
        <u.kleine-koenig@baylibre.com>, <dmaengine@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
CC: <quic_mdalam@quicinc.com>, <quic_utiwari@quicinc.com>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v6 03/12] dmaengine: qcom: bam_dma: add bam_pipe_lock flag support
Date: Wed, 15 Jan 2025 15:59:55 +0530
Message-ID: <20250115103004.3350561-4-quic_mdalam@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Sn6sRyVutX4vQ6DSvz0AQGeAIleZ8zyL
X-Proofpoint-GUID: Sn6sRyVutX4vQ6DSvz0AQGeAIleZ8zyL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_04,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150079

BAM IP version 1.4.0 and above only supports this LOCK/UNLOCK
feature. So adding check for the same and setting bam_pipe_lock
based on BAM SW Version.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v6]

* No change

Change in [v5]

* Removed DMA_PREP_LOCK & DMA_PREP_UNLOCK flag

* Added FIELD_GET and GENMASK macro to extract major
  and minor version

Change in [v4]

* Added BAM_SW_VERSION read for major & minor
  version

* Added bam_pipe_lock flag 

Change in [v3]

* Moved lock/unlock bit set inside loop

Change in [v2]

* No change
 
Change in [v1]

* Added initial support for BAM pipe lock/unlock

 drivers/dma/qcom/bam_dma.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index daeacd5cb8e9..f50d88ad4f6d 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -53,11 +53,18 @@ struct bam_desc_hw {
 
 #define BAM_DMA_AUTOSUSPEND_DELAY 100
 
+#define SW_VERSION_MAJOR_MASK	GENMASK(31, 28)
+#define SW_VERSION_MINOR_MASK	GENMASK(27, 16)
+#define SW_MAJOR_1	0x1
+#define SW_VERSION_4	0x4
+
 #define DESC_FLAG_INT BIT(15)
 #define DESC_FLAG_EOT BIT(14)
 #define DESC_FLAG_EOB BIT(13)
 #define DESC_FLAG_NWD BIT(12)
 #define DESC_FLAG_CMD BIT(11)
+#define DESC_FLAG_LOCK BIT(10)
+#define DESC_FLAG_UNLOCK BIT(9)
 
 #define BAM_NDP_REVISION_START	0x20
 #define BAM_NDP_REVISION_END	0x27
@@ -396,6 +403,7 @@ struct bam_device {
 	u32 ee;
 	bool controlled_remotely;
 	bool powered_remotely;
+	bool bam_pipe_lock;
 	u32 active_channels;
 	u32 bam_sw_version;
 
@@ -702,8 +710,13 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
 		unsigned int curr_offset = 0;
 
 		do {
-			if (flags & DMA_PREP_CMD)
+			if (flags & DMA_PREP_CMD) {
 				desc->flags |= cpu_to_le16(DESC_FLAG_CMD);
+				if (bdev->bam_pipe_lock && flags & DMA_PREP_LOCK)
+					desc->flags |= cpu_to_le16(DESC_FLAG_LOCK);
+				else if (bdev->bam_pipe_lock && flags & DMA_PREP_UNLOCK)
+					desc->flags |= cpu_to_le16(DESC_FLAG_UNLOCK);
+			}
 
 			desc->addr = cpu_to_le32(sg_dma_address(sg) +
 						 curr_offset);
@@ -1250,6 +1263,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 {
 	struct bam_device *bdev;
 	const struct of_device_id *match;
+	u32 sw_major, sw_minor;
 	int ret, i;
 
 	bdev = devm_kzalloc(&pdev->dev, sizeof(*bdev), GFP_KERNEL);
@@ -1313,6 +1327,11 @@ static int bam_dma_probe(struct platform_device *pdev)
 
 	bdev->bam_sw_version = readl_relaxed(bam_addr(bdev, 0, BAM_SW_VERSION));
 	dev_info(bdev->dev, "BAM software version:0x%08x\n", bdev->bam_sw_version);
+	sw_major = FIELD_GET(SW_VERSION_MAJOR_MASK, bdev->bam_sw_version);
+	sw_minor = FIELD_GET(SW_VERSION_MINOR_MASK, bdev->bam_sw_version);
+
+	if (sw_major == SW_MAJOR_1 && sw_minor >= SW_VERSION_4)
+		bdev->bam_pipe_lock = true;
 
 	ret = bam_init(bdev);
 	if (ret)
-- 
2.34.1


