Return-Path: <dmaengine+bounces-2870-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1C1952BA6
	for <lists+dmaengine@lfdr.de>; Thu, 15 Aug 2024 12:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A5BCB2098A
	for <lists+dmaengine@lfdr.de>; Thu, 15 Aug 2024 10:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197B91D47B1;
	Thu, 15 Aug 2024 08:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ejQs7cZn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACA11D0DCC;
	Thu, 15 Aug 2024 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723712282; cv=none; b=TmbiqakWcL8A+ai++5770HLAssVD0oncH6wMtvhAgrxpyKXqPpH0xEXDvsaDTOQiMZxHVSTqh74vWrXr5jB9pggwsgXz3Xat8TUTF5Pc1PIOgfShvlTK1yjIs16tRgGPQPpgcXj+63tQS655JYaMU5n6Q/nkZHjK6qpNl1VHH00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723712282; c=relaxed/simple;
	bh=8yKbiZoSG5+2O1cL7KxT+nPMB24eJ5utceYaWXsXvRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iyApTAsxerpbsr8Al4V01AEja7zHWeMH00lvjhe1vNbXa2XMOlhZ1hMl5TakqYjAC/iwmCgMBfUTgZ/AuaW3i8hUovnxfVC6j+y39rGpjM0E4ysGNRwzoFHZMGumKe2na0gBMIEBgmEEWDa1A0gwatWfxirr6pkPNg2RNv/C4nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ejQs7cZn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47F7GhZa027049;
	Thu, 15 Aug 2024 08:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LrV6XUVSbqs
	7hBbne3RhDNRoz1u6Bydsa8+6oj0Smoc=; b=ejQs7cZnSaf9luyaNF4coPFlPX2
	84mWy6I7RglMtr7s/vFVMD7F5F8e6CXVUAVMrMDTVchCinal0aD8p6IzoU+UK7I8
	7wHbGz5MXxvwsT6oSA8uK2KMLk9tIahGGUWvBhZqD+qZARQe0JGqcFSbdeeUxl8o
	RUBoRq2GH4autHWM63Yx2BaLSTJ8Uj12XIFwK7DkDYSvjQ69H6J5T1OcrIb6HB1V
	BnoYwq4T1kwmbss64UeNqdr/ovizuN2aL65/aOzYrIu9Qahq2aXzCDklpz5D3Qpe
	xlUVJH1he5QB+qOIrOqygIBP7oSYMhy1U6MQkfHObIKEK7zXgM6xMtW7thw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 411d5688pf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 08:57:34 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 47F8vUko029776;
	Thu, 15 Aug 2024 08:57:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 40xkmhennu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 08:57:30 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47F8vUe7029710;
	Thu, 15 Aug 2024 08:57:30 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 47F8vTJh029695
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 08:57:30 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
	id A8E53417F2; Thu, 15 Aug 2024 14:27:27 +0530 (+0530)
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, thara.gopinath@gmail.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        gustavoars@kernel.org, u.kleine-koenig@pengutronix.de, kees@kernel.org,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com,
        quic_mdalam@quicinc.com, quic_utiwari@quicinc.com
Subject: [PATCH v2 08/16] crypto: qce - Convert register r/w for aead via BAM/DMA
Date: Thu, 15 Aug 2024 14:27:17 +0530
Message-Id: <20240815085725.2740390-9-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815085725.2740390-1-quic_mdalam@quicinc.com>
References: <20240815085725.2740390-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xlAxxxqmd5PHiw0roT84S5i9Xc_q8yBd
X-Proofpoint-ORIG-GUID: xlAxxxqmd5PHiw0roT84S5i9Xc_q8yBd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_01,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408150064

Convert register read/write for aead via BAM/DMA.
with this change all the crypto register configuration
will be done via BAM/DMA. This change will prepare command
descriptor for all register and write it once.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v2]

* updated commit message 

Change in [v1]

* Added initial support for reagister read/write via bam
  for aead

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


