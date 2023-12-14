Return-Path: <dmaengine+bounces-519-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F33812EE0
	for <lists+dmaengine@lfdr.de>; Thu, 14 Dec 2023 12:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B01471F214DC
	for <lists+dmaengine@lfdr.de>; Thu, 14 Dec 2023 11:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D6E405E4;
	Thu, 14 Dec 2023 11:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lACWhxlK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64210B7;
	Thu, 14 Dec 2023 03:42:56 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BEADBjF015116;
	Thu, 14 Dec 2023 11:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=y0D31ed
	XmB+E37bAtXqUJO+PGNvHnhVnBEIXqoqETCA=; b=lACWhxlKgLVaAH3EJM61Rd/
	N4DC0jPTifvpLdZEeIWlDgPGZc/YBaso6ZgInbMJFG/j5GqT0JYuQB0UvCJ/srI5
	WOBPhX+MDLIpa5hTziNuEgxpsshk48eu/JdUCz/xwZE0TMuObVsC6h9Kw8BEEgBJ
	Y4ALVHjCOQAoUjHB1uh3fsNjUfEPjsTHjfth12U7I2XpRMF/QqETeXzGaY8ZukbC
	/gHfHGGDXQvc1zJSWXADN31df4FUZ/+qN28WYBzk+r3O6jn/7Vs07EHYZj45zKSl
	0skaF0DVy3Udv0OYaYHnXydl4yRC+8rqbWWppBf+hdY+cBEQp4K9KTaymZC6y6w=
	=
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uysrprxb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 11:42:48 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BEBgiA3003251;
	Thu, 14 Dec 2023 11:42:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3uvhaktche-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 11:42:44 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BEBghRe002912;
	Thu, 14 Dec 2023 11:42:44 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3BEBginI003208
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 11:42:44 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
	id 91CCE41646; Thu, 14 Dec 2023 17:12:42 +0530 (+0530)
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: thara.gopinath@gmail.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, linux-crypto@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, quic_srichara@quicinc.com,
        quic_varada@quicinc.com
Cc: quic_mdalam@quicinc.com
Subject: [PATCH 05/11] crypto: qce - Convert register r/w for aead via BAM/DMA
Date: Thu, 14 Dec 2023 17:12:33 +0530
Message-Id: <20231214114239.2635325-6-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214114239.2635325-1-quic_mdalam@quicinc.com>
References: <20231214114239.2635325-1-quic_mdalam@quicinc.com>
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
X-Proofpoint-ORIG-GUID: AOWRyAJvxh4aNb3xVzM1U-I77a601KoS
X-Proofpoint-GUID: AOWRyAJvxh4aNb3xVzM1U-I77a601KoS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312140080

Convert register read/write for skcipher via BAM/DMA.
with this change all the crypto register configuration
will be done via BAM/DMA. This change will prepare command
descriptor for all register and write it once.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
 drivers/crypto/qce/aead.c   | 12 ++++++++++++
 drivers/crypto/qce/common.c | 38 ++++++++++++++++++++++---------------
 2 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/qce/aead.c b/drivers/crypto/qce/aead.c
index 7d811728f047..c03600f396be 100644
--- a/drivers/crypto/qce/aead.c
+++ b/drivers/crypto/qce/aead.c
@@ -29,6 +29,7 @@ static void qce_aead_done(void *data)
 	struct qce_alg_template *tmpl = to_aead_tmpl(crypto_aead_reqtfm(req));
 	struct qce_device *qce = tmpl->qce;
 	struct qce_result_dump *result_buf = qce->dma.result_buf;
+	struct qce_bam_transaction *qce_bam_txn = qce->dma.qce_bam_txn;
 	enum dma_data_direction dir_src, dir_dst;
 	bool diff_dst;
 	int error;
@@ -50,6 +51,17 @@ static void qce_aead_done(void *data)
 
 	dma_unmap_sg(qce->dev, rctx->dst_sg, rctx->dst_nents, dir_dst);
 
+	if (qce_bam_txn->qce_read_sgl_cnt)
+		dma_unmap_sg(qce->dev,
+			     qce_bam_txn->qce_reg_read_sgl,
+			qce_bam_txn->qce_read_sgl_cnt,
+			DMA_DEV_TO_MEM);
+	if (qce_bam_txn->qce_write_sgl_cnt)
+		dma_unmap_sg(qce->dev,
+			     qce_bam_txn->qce_reg_write_sgl,
+			qce_bam_txn->qce_write_sgl_cnt,
+			DMA_MEM_TO_DEV);
+
 	if (IS_CCM(rctx->flags)) {
 		if (req->assoclen) {
 			sg_free_table(&rctx->src_tbl);
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


