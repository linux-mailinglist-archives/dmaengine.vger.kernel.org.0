Return-Path: <dmaengine+bounces-3954-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FC79EDE3A
	for <lists+dmaengine@lfdr.de>; Thu, 12 Dec 2024 05:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE61628336C
	for <lists+dmaengine@lfdr.de>; Thu, 12 Dec 2024 04:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6203A175D48;
	Thu, 12 Dec 2024 04:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GaFcUupV"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950561E4A9;
	Thu, 12 Dec 2024 04:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733977066; cv=none; b=oQ86HvupVHCWP7BocsdgP2spifuZhb14dSi5awZQnVvTLNY84pA1DJYKj6oEU6JQzeriVS2o4N2VN+BqxG6QyMQa3CWxJ3CZWRB597+0bwulIwO9dO/qAAnBk9J8XqiDbo+rWcCjUfakhsIVrTKywwZ9blZ+8LaHXm46B/grXsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733977066; c=relaxed/simple;
	bh=CGhmMnYmzJ20O/WLmDCVkBQ8E6Dee3MLg+1o5R/V5vE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yhnj2kiHFZ/f7pZVe7mIeDBCB6bppgqaNFB6AaUcwmpFyvEVzkGct3NgzxcniscbF35q0b+HPqcrjtgMeUqh2Zl+MAvsZJMC7+/499123eFN4Rx34Vy07F2Y04A5nt55BGmRvB9k2KQ0lcChBehrMJW390dHC+6UBDYoPeck8FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GaFcUupV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBHDYG9002529;
	Thu, 12 Dec 2024 04:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ueyQytLc1WeXvdeLbkQoUV7bDiUFgrIJsD6MMEGlXhc=; b=GaFcUupVD6lfUIH9
	W0K06Y7NAbGgasqszzvp+kXx5b/Vay8bNeMTQ0iYMD3CGZnfFTomS5wHv8hXIlI/
	JqI9ZEVeHp9RbW82+Qq3RllfV5aoGsCdnIfvnwGPmDwfmJ4Xbc5X+UqBrfGn09Xp
	/DBk8flQSUwZ4Eg3pp8zWKWApsoGlbPK6QTY7S2g2wbLBYWL3FkBmwWS0ufrMMN0
	x4YQcfcRsdVEa5frRfGfFg4vKL39TXY4hNSwzwtPfkC3Ri/pumy1XeqEKN4Y9nG6
	49tbpRF5UbTIq1f8AAJzUdzuRVMfRNiyp7/rzD8ECEbrqFQYfaJJiLgG/6jUBXXH
	booK8w==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43eyg646gq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 04:17:34 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BC4HXAu021398
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 04:17:33 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 11 Dec 2024 20:17:28 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <vkoul@kernel.org>, <corbet@lwn.net>, <thara.gopinath@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <kees@kernel.org>, <dave.jiang@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_mdalam@quicinc.com>, <quic_utiwari@quicinc.com>
Subject: [PATCH v5 07/12] crypto: qce - Convert register r/w for sha via BAM/DMA
Date: Thu, 12 Dec 2024 09:46:34 +0530
Message-ID: <20241212041639.4109039-8-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: C3yDwSooDX4WE5i5AHC1eZ5GdzXunOdD
X-Proofpoint-ORIG-GUID: C3yDwSooDX4WE5i5AHC1eZ5GdzXunOdD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120028

Convert register read/write for sha via BAM/DMA.
with this change all the crypto register configuration
will be done via BAM/DMA. This change will prepare command
descriptor for all register and write it once.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v5]

* No change

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


