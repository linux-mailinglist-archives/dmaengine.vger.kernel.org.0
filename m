Return-Path: <dmaengine+bounces-3951-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11499EDE2B
	for <lists+dmaengine@lfdr.de>; Thu, 12 Dec 2024 05:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7D11167DD3
	for <lists+dmaengine@lfdr.de>; Thu, 12 Dec 2024 04:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4B413B288;
	Thu, 12 Dec 2024 04:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cPdl37wr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F4417BB16;
	Thu, 12 Dec 2024 04:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733977041; cv=none; b=itMmCcdCezrhUrh610mOwZ85NuIwWk/YLAte7evvQkChOSsLaRfzmMUSuYQ9wB4WDUyHRRdHrufVC9jO699nd5FdMKdWXEHR16qYg/msplfyib+6sFQDLDuwJ5EUw5JMD4BPp548OwGdUjYFCBOYpzi1xWoOWHc0jzwvslI2t40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733977041; c=relaxed/simple;
	bh=0zUKSOpQEn38nun+f3rQcQgZHyBp+qBbCAN4OXzgNfU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j7ApKzM1pR0sk4IS0aq5dBK54hyYHzNB9WlS1LgxiRhcByJ09gQ55Xoi+1gvDnOC1olvKyWhD4mLn9edOJ/0e5E936EMxQL07+i9UFr6DqyB/0xJiVUzgDlNF+ryQ8sh9f8k9Tsqd7J1SwpBT+2kt3qisOg6YkLP1aXYjmgkORI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cPdl37wr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBHjn87019045;
	Thu, 12 Dec 2024 04:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LSEGvjG2AORHEGZpvG+Ds9ZmyJZqpEua6YDKLVtSiBY=; b=cPdl37wr1wjwuOn0
	tmaJfv3tBL1IJ/Arp3jarTuVEgnwJpgWr+6Kgve3ZdWQGePCHMPn8Y7h3JIrvvxI
	+es1ICiGQSZwp8GTj+mZ1+lAFXnnYwVw1Qxo4KoComoME7dJizOrKHAKrho1kAdW
	N07wxMAIJCklA5VDdYlmJb70qlkZ59yM4JFXKGVxT2tvmZ6JwdgYIqxti8KHrC64
	AJY3Xty6s6t6pni/TT4wYytue5oRqjCiM+AQ0uesKYOiVrJHOHJ5xNAMRYsdW3KK
	pvjHrjUeShLGEinbYvDqnkY1NT0v6beKITYWuJ+4HoyJTzfceulUGCw57zeVURUa
	Y6MMGg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ffdys876-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 04:17:14 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BC4HDfw011232
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 04:17:13 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 11 Dec 2024 20:17:08 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <vkoul@kernel.org>, <corbet@lwn.net>, <thara.gopinath@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <kees@kernel.org>, <dave.jiang@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_mdalam@quicinc.com>, <quic_utiwari@quicinc.com>
Subject: [PATCH v5 03/12] dmaengine: qcom: bam_dma: add bam_pipe_lock flag support
Date: Thu, 12 Dec 2024 09:46:30 +0530
Message-ID: <20241212041639.4109039-4-quic_mdalam@quicinc.com>
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
X-Proofpoint-ORIG-GUID: sQSKfqWIb9ReU3iQFDisabMXk7OLgdNY
X-Proofpoint-GUID: sQSKfqWIb9ReU3iQFDisabMXk7OLgdNY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412120027

BAM IP version 1.4.0 and above only supports this LOCK/UNLOCK
feature. So adding check for the same and setting bam_pipe_lock
based on BAM SW Version.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

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

 drivers/dma/qcom/bam_dma.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 3980c9d501c3..7a57cd84e7f1 100644
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
 
 struct bam_async_desc {
 	struct virt_dma_desc vd;
@@ -393,6 +400,7 @@ struct bam_device {
 	u32 ee;
 	bool controlled_remotely;
 	bool powered_remotely;
+	bool bam_pipe_lock;
 	u32 active_channels;
 	u32 bam_sw_version;
 
@@ -696,9 +704,15 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
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
+
 			desc->addr = cpu_to_le32(sg_dma_address(sg) +
 						 curr_offset);
 
@@ -1242,6 +1256,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 {
 	struct bam_device *bdev;
 	const struct of_device_id *match;
+	u32 sw_major, sw_minor;
 	int ret, i;
 
 	bdev = devm_kzalloc(&pdev->dev, sizeof(*bdev), GFP_KERNEL);
@@ -1306,6 +1321,13 @@ static int bam_dma_probe(struct platform_device *pdev)
 	bdev->bam_sw_version = readl_relaxed(bam_addr(bdev, 0, BAM_SW_VERSION));
 	dev_info(bdev->dev, "BAM software version:0x%08x\n", bdev->bam_sw_version);
 
+	sw_major = FIELD_GET(SW_VERSION_MAJOR_MASK, bdev->bam_sw_version);
+	sw_minor = FIELD_GET(SW_VERSION_MINOR_MASK, bdev->bam_sw_version);
+
+	if (sw_major == SW_MAJOR_1 && sw_minor >= SW_VERSION_4)
+		bdev->bam_pipe_lock = true;
+
+
 	ret = bam_init(bdev);
 	if (ret)
 		goto err_disable_clk;
-- 
2.34.1


