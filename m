Return-Path: <dmaengine+bounces-3113-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF469713DE
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 11:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2C91C22C6D
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 09:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5611B3F0A;
	Mon,  9 Sep 2024 09:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f12KhoeI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091E01B14F4;
	Mon,  9 Sep 2024 09:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874374; cv=none; b=nmnlWw/NyoEufU2GWx0l5dbs6Z8fv/iIWUAiKkTvybjt8C/ys+XpJOl+WTuU4Rp+ILGoU7rw05dIE+odnquvfGg8apym+8dDtqgTq84nQ0geaNZ+PPMf4mDri9KfqSB3BfmUZHf/VC0PqIdV2MY6isZoXePUlWr0S73wRAKBtjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874374; c=relaxed/simple;
	bh=buGd5xwNZloPD1F8N4Pqy2xO596COTWRko3aIJToFV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d087Q9mv3Y/141SyGtKLJ276bmBA8XCL88GG30rBvyt96BgEUQTxBmC/EyFSKBW7hIILsVOuqOVq4ttIRkKIqFfDMbX5oVZSHLLOTFkLB8AtdZ9RSVx1Ef1v/xMEDLz+rEAH83+wXVD0B5eMN8NqIswvcDUFQAJncUcc2DBSpVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f12KhoeI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4899JvFX013790;
	Mon, 9 Sep 2024 09:27:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OQsyerOaepdV1mglSrbYRyv0cQwILL/OXjdz38mwZEg=; b=f12KhoeIBR+sxn2f
	/mB+hOPGKr5lhqdCoBdq2a65ibP2/8Zah9yPT/vwSS6G0vg8C6/P0XlR1emB5Kbq
	lbJYOn4qWwhe5EVSYfvjl0VIF5I2j5a1lxb6CnZqSFPpRgI74jH56P8WYbIOLhi1
	q0bK0HtvfVkcxYrxTDMeWmpUQpn9YD5gOduiFlFRvgueA9tFAtNdjw+icv0oCcJx
	+TwJ5BzuxeRjCG8TM/qdYuW9GqyQcphfvfiQqHJCJteRFjlZKvJm70dsKXGXxLgH
	41wh5Z9kMlYHby68j0AT2RXmzEAQL++UAotSawu5p1mFA4nXKbRx1TlG0Tqd9K+u
	gNHlTA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy5njc3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 09:27:40 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4899Rd3B001195
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Sep 2024 09:27:39 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 9 Sep 2024 02:27:34 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <thara.gopinath@gmail.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <vkoul@kernel.org>, <kees@kernel.org>,
        <robin.murphy@arm.com>, <fenghua.yu@intel.com>, <av2082000@gmail.com>,
        <u.kleine-koenig@pengutronix.d>, <linux-crypto@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <quic_varada@quicinc.com>,
        <quic_srichara@quicinc.com>
CC: <quic_mdalam@quicinc.com>
Subject: [PATCH v4 06/11] crypto: qce - Convert register r/w for sha via BAM/DMA
Date: Mon, 9 Sep 2024 14:56:27 +0530
Message-ID: <20240909092632.2776160-7-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: _REYzLiVFofkIzyz4lB-lZdAzpjrP8oj
X-Proofpoint-ORIG-GUID: _REYzLiVFofkIzyz4lB-lZdAzpjrP8oj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409090074

Convert register read/write for sha via BAM/DMA.
with this change all the crypto register configuration
will be done via BAM/DMA. This change will prepare command
descriptor for all register and write it once.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v4]

* No change 
 
Change in [v3]

* No change

Change in [v2]

* Added initial support to read/write crypto
  register via BAM for SHA

Change in [v1]

* This patch was not included in [v1]

 drivers/crypto/qce/common.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
index d1da6b1938f3..d485762a3fdc 100644
--- a/drivers/crypto/qce/common.c
+++ b/drivers/crypto/qce/common.c
@@ -157,17 +157,19 @@ static int qce_setup_regs_ahash(struct crypto_async_request *async_req)
 	__be32 mackey[QCE_SHA_HMAC_KEY_SIZE / sizeof(__be32)] = {0};
 	u32 auth_cfg = 0, config;
 	unsigned int iv_words;
+	int ret;
 
 	/* if not the last, the size has to be on the block boundary */
 	if (!rctx->last_blk && req->nbytes % blocksize)
 		return -EINVAL;
 
+	qce_clear_bam_transaction(qce);
 	qce_setup_config(qce);
 
 	if (IS_CMAC(rctx->flags)) {
-		qce_write(qce, REG_AUTH_SEG_CFG, 0);
-		qce_write(qce, REG_ENCR_SEG_CFG, 0);
-		qce_write(qce, REG_ENCR_SEG_SIZE, 0);
+		qce_write_reg_dma(qce, REG_AUTH_SEG_CFG, 0, 1);
+		qce_write_reg_dma(qce, REG_ENCR_SEG_CFG, 0, 1);
+		qce_write_reg_dma(qce, REG_ENCR_SEG_SIZE, 0, 1);
 		qce_clear_array(qce, REG_AUTH_IV0, 16);
 		qce_clear_array(qce, REG_AUTH_KEY0, 16);
 		qce_clear_array(qce, REG_AUTH_BYTECNT0, 4);
@@ -213,18 +215,24 @@ static int qce_setup_regs_ahash(struct crypto_async_request *async_req)
 		auth_cfg &= ~BIT(AUTH_FIRST_SHIFT);
 
 go_proc:
-	qce_write(qce, REG_AUTH_SEG_CFG, auth_cfg);
-	qce_write(qce, REG_AUTH_SEG_SIZE, req->nbytes);
-	qce_write(qce, REG_AUTH_SEG_START, 0);
-	qce_write(qce, REG_ENCR_SEG_CFG, 0);
-	qce_write(qce, REG_SEG_SIZE, req->nbytes);
+	qce_write_reg_dma(qce, REG_AUTH_SEG_CFG, auth_cfg, 1);
+	qce_write_reg_dma(qce, REG_AUTH_SEG_SIZE, req->nbytes, 1);
+	qce_write_reg_dma(qce, REG_AUTH_SEG_START, 0, 1);
+	qce_write_reg_dma(qce, REG_ENCR_SEG_CFG, 0, 1);
+	qce_write_reg_dma(qce, REG_SEG_SIZE, req->nbytes, 1);
 
 	/* get little endianness */
 	config = qce_config_reg(qce, 1);
-	qce_write(qce, REG_CONFIG, config);
+	qce_write_reg_dma(qce, REG_CONFIG, config, 1);
 
 	qce_crypto_go(qce, true);
 
+	ret = qce_submit_cmd_desc(qce, 0);
+	if (ret) {
+		dev_err(qce->dev, "Error in sha cmd descriptor\n");
+		return ret;
+	}
+
 	return 0;
 }
 #endif
-- 
2.34.1


