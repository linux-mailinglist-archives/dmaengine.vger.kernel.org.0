Return-Path: <dmaengine+bounces-3107-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC412971383
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 11:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84BD12829FD
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 09:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAE61B3750;
	Mon,  9 Sep 2024 09:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n7Eva7GX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775CD1B3734;
	Mon,  9 Sep 2024 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874079; cv=none; b=eEEMrB/DVkB68KhkRk3J5v4BSHWCSv5om6omH7XRNTw5F0jIPBrD0GdyjX0YAch/JzIZSEz9qvbavS8Ao8QrQbQyI8xKOi9tU4obS8wwEutCb3aXKZkG2WPBmwhgT78RYzYnD8Hcgwloc1bLJKUqt4YXYIiXnwDvPAeVdEJKY8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874079; c=relaxed/simple;
	bh=h06Q7rwWFDpRQLLY8ck/07/lLv2K22lhQZLOleoG8sA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EGuYhe05UW/VRNRD5mvSHPb0KeKwqXQ3VPaykR7iW1fw7PrQ8pPqwTly+sgReIDnDMehp/aD9EdoPCpmiIWax2gPyG85/m78V9FQapKPD41ogTO2FR4p5kDJNXuQlW+nfCTQNLHnfZmIgE/jauWfUm9Ub1jqDT9Jyc4doKe1ud0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n7Eva7GX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4899JqHl005055;
	Mon, 9 Sep 2024 09:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/ptwepQOkAeS7Aui0F7frhA1z/XmLDBEbUpH+ZL2jxM=; b=n7Eva7GXw2IFMyjN
	V8Ravk6RfEXxtK+AuZhmy+xybMG6jpvL3LBXFd2+G+WoFTWYjEtcoGzCMVWHLSfF
	dkxzzoYhu3JVCiCNs6P27Fn9LW6mGGORt2gi/rlfWFKlFw8qnHti1zDlrE6LaApp
	yNVQMxphMZogMq2tncGT0az+qtpnEmRYTu0f7lJGT2fDBk2alw7a8gcoSJRGEclO
	KSLNUI6tPbEPqd6H000OU5tqHiTmmYA9KSSNXsdSRiCfa+OvbNU9Dom1NePgYn7d
	w4WZEAqIda+ep2+bhGQGodIGmmTh8kXYZgHjqn+BwgZ8q+FGJfs1Awpo86JwJof/
	RtrJBw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy512bds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 09:27:47 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4899Rk4i001260
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Sep 2024 09:27:46 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 9 Sep 2024 02:27:39 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <thara.gopinath@gmail.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <vkoul@kernel.org>, <kees@kernel.org>,
        <robin.murphy@arm.com>, <fenghua.yu@intel.com>, <av2082000@gmail.com>,
        <u.kleine-koenig@pengutronix.d>, <linux-crypto@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <quic_varada@quicinc.com>,
        <quic_srichara@quicinc.com>
CC: <quic_mdalam@quicinc.com>
Subject: [PATCH v4 07/11] crypto: qce - Convert register r/w for aead via BAM/DMA
Date: Mon, 9 Sep 2024 14:56:28 +0530
Message-ID: <20240909092632.2776160-8-quic_mdalam@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Nb9PerytlbQDASk0IgaEfMhDQmFdUklY
X-Proofpoint-GUID: Nb9PerytlbQDASk0IgaEfMhDQmFdUklY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409090074

Convert register read/write for aead via BAM/DMA.
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


