Return-Path: <dmaengine+bounces-4124-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57692A11FAA
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2025 11:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995DE188E82E
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2025 10:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C282451C1;
	Wed, 15 Jan 2025 10:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fFTLLhq3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA6E28EC98;
	Wed, 15 Jan 2025 10:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937084; cv=none; b=dA+Q8+3/J70hwAjt17HYoGWG1LBhGESK4SCg+FEpWLOUzQz40hLXcPQU5AKG1HK/JfeQCyectlWNIN+IhGn5iGKIXUrC+3Su27NARIinCNzq0efmg8zIq+d64InkU9kdF9Dqr8Yp/iOpkVmNBiVo/BDuzccyWiI+YhI1Ft6j4Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937084; c=relaxed/simple;
	bh=nq1HgipksDL4aD7ksuDrn25tiG816vshBN8bm0BD08w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZFsZqHKtcjsr8ZQOBIY8j76VnLRlkD1xuF/oRw5zTOBTAgbbJ5vNe7jpThucNCpiZz9dj3TJBl1hoM/gym82PzVj3qh2dVjEr9YO9vq8MUNckLXD33Jt87StiQKfAaAA1kUiktjZw3SRzwDSmo3ZbMXf0N159bFg0o7qTIpMu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fFTLLhq3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F2rfmN019819;
	Wed, 15 Jan 2025 10:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jDgzPSTwB73lt0+eQE2O+e/84/tlHIYTXQbuxWap6yI=; b=fFTLLhq33WZmGoIY
	5i7TcGQOZeJP8sbszyYHGzGejEvBtgPQj5+3uWTn2eRIcK7s7rOOwkRPhO8elqjj
	kqIFKgImrKiG+eAbPwYf960X8bL01SLrCnzroy0xHl0yAWq3OpDoN0bHe8U7/wfQ
	vAOvOLbVZBcvWbiUqBGt0FmZ4vZQ5VyMaYVLVOs82lGGISu3MbDRN71rtGxgnz7/
	wR54BtVfPkY6W9fXMzO/ozCHes5yhGlLn9cixhzlicgMTRbZleHzj8D/lGC7OKnz
	cfmLPzsWuUQCbi2vbeaMhQLoW1Guqa7uZi86H6wJgn71jN1FVBi64jEn+rDJhzZB
	isOCGg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4464mts117-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 10:31:12 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50FAVBIU006864
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 10:31:11 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 15 Jan 2025 02:31:06 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <vkoul@kernel.org>, <corbet@lwn.net>, <thara.gopinath@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <martin.petersen@oracle.com>, <enghua.yu@intel.com>,
        <u.kleine-koenig@baylibre.com>, <dmaengine@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
CC: <quic_mdalam@quicinc.com>, <quic_utiwari@quicinc.com>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v6 08/12] crypto: qce - Convert register r/w for aead via BAM/DMA
Date: Wed, 15 Jan 2025 16:00:00 +0530
Message-ID: <20250115103004.3350561-9-quic_mdalam@quicinc.com>
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
X-Proofpoint-ORIG-GUID: cReSt7emhfbY1G5JCzVK0BhWZ2tVDagx
X-Proofpoint-GUID: cReSt7emhfbY1G5JCzVK0BhWZ2tVDagx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_04,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150079

Convert register read/write for aead via BAM/DMA.
with this change all the crypto register configuration
will be done via BAM/DMA. This change will prepare command
descriptor for all register and write it once.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v6]

* No change

Change in [v5]

* No change

Change in [v4]

* No change 
 
Change in [v3]

* No change

Change in [v2]

* Added initial support to read/write crypto
  register via BAM for aead

Change in [v1]

* This patch was not included in [v1]

 drivers/crypto/qce/common.c | 38 ++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
index d485762a3fdc..ff96f6ba1fc5 100644
--- a/drivers/crypto/qce/common.c
+++ b/drivers/crypto/qce/common.c
@@ -454,7 +454,9 @@ static int qce_setup_regs_aead(struct crypto_async_request *async_req)
 	unsigned long flags = rctx->flags;
 	u32 encr_cfg, auth_cfg, config, totallen;
 	u32 iv_last_word;
+	int ret;
 
+	qce_clear_bam_transaction(qce);
 	qce_setup_config(qce);
 
 	/* Write encryption key */
@@ -467,12 +469,12 @@ static int qce_setup_regs_aead(struct crypto_async_request *async_req)
 
 	if (IS_CCM(rctx->flags)) {
 		iv_last_word = enciv[enciv_words - 1];
-		qce_write(qce, REG_CNTR3_IV3, iv_last_word + 1);
+		qce_write_reg_dma(qce, REG_CNTR3_IV3, iv_last_word + 1, 1);
 		qce_write_array(qce, REG_ENCR_CCM_INT_CNTR0, (u32 *)enciv, enciv_words);
-		qce_write(qce, REG_CNTR_MASK, ~0);
-		qce_write(qce, REG_CNTR_MASK0, ~0);
-		qce_write(qce, REG_CNTR_MASK1, ~0);
-		qce_write(qce, REG_CNTR_MASK2, ~0);
+		qce_write_reg_dma(qce, REG_CNTR_MASK, ~0, 1);
+		qce_write_reg_dma(qce, REG_CNTR_MASK0, ~0, 1);
+		qce_write_reg_dma(qce, REG_CNTR_MASK1, ~0, 1);
+		qce_write_reg_dma(qce, REG_CNTR_MASK2, ~0, 1);
 	}
 
 	/* Clear authentication IV and KEY registers of previous values */
@@ -508,7 +510,7 @@ static int qce_setup_regs_aead(struct crypto_async_request *async_req)
 	encr_cfg = qce_encr_cfg(flags, enc_keylen);
 	if (IS_ENCRYPT(flags))
 		encr_cfg |= BIT(ENCODE_SHIFT);
-	qce_write(qce, REG_ENCR_SEG_CFG, encr_cfg);
+	qce_write_reg_dma(qce, REG_ENCR_SEG_CFG, encr_cfg, 1);
 
 	/* Set up AUTH_SEG_CFG */
 	auth_cfg = qce_auth_cfg(rctx->flags, auth_keylen, ctx->authsize);
@@ -525,34 +527,40 @@ static int qce_setup_regs_aead(struct crypto_async_request *async_req)
 		else
 			auth_cfg |= AUTH_POS_BEFORE << AUTH_POS_SHIFT;
 	}
-	qce_write(qce, REG_AUTH_SEG_CFG, auth_cfg);
+	qce_write_reg_dma(qce, REG_AUTH_SEG_CFG, auth_cfg, 1);
 
 	totallen = rctx->cryptlen + rctx->assoclen;
 
 	/* Set the encryption size and start offset */
 	if (IS_CCM(rctx->flags) && IS_DECRYPT(rctx->flags))
-		qce_write(qce, REG_ENCR_SEG_SIZE, rctx->cryptlen + ctx->authsize);
+		qce_write_reg_dma(qce, REG_ENCR_SEG_SIZE, rctx->cryptlen + ctx->authsize, 1);
 	else
-		qce_write(qce, REG_ENCR_SEG_SIZE, rctx->cryptlen);
-	qce_write(qce, REG_ENCR_SEG_START, rctx->assoclen & 0xffff);
+		qce_write_reg_dma(qce, REG_ENCR_SEG_SIZE, rctx->cryptlen, 1);
+	qce_write_reg_dma(qce, REG_ENCR_SEG_START, rctx->assoclen & 0xffff, 1);
 
 	/* Set the authentication size and start offset */
-	qce_write(qce, REG_AUTH_SEG_SIZE, totallen);
-	qce_write(qce, REG_AUTH_SEG_START, 0);
+	qce_write_reg_dma(qce, REG_AUTH_SEG_SIZE, totallen, 1);
+	qce_write_reg_dma(qce, REG_AUTH_SEG_START, 0, 1);
 
 	/* Write total length */
 	if (IS_CCM(rctx->flags) && IS_DECRYPT(rctx->flags))
-		qce_write(qce, REG_SEG_SIZE, totallen + ctx->authsize);
+		qce_write_reg_dma(qce, REG_SEG_SIZE, totallen + ctx->authsize, 1);
 	else
-		qce_write(qce, REG_SEG_SIZE, totallen);
+		qce_write_reg_dma(qce, REG_SEG_SIZE, totallen, 1);
 
 	/* get little endianness */
 	config = qce_config_reg(qce, 1);
-	qce_write(qce, REG_CONFIG, config);
+	qce_write_reg_dma(qce, REG_CONFIG, config, 1);
 
 	/* Start the process */
 	qce_crypto_go(qce, !IS_CCM(flags));
 
+	ret = qce_submit_cmd_desc(qce, 0);
+	if (ret) {
+		dev_err(qce->dev, "Error in aead cmd descriptor\n");
+		return ret;
+	}
+
 	return 0;
 }
 #endif
-- 
2.34.1


