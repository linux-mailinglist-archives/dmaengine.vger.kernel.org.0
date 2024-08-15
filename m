Return-Path: <dmaengine+bounces-2865-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C31B952B91
	for <lists+dmaengine@lfdr.de>; Thu, 15 Aug 2024 12:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EE3F1C2101B
	for <lists+dmaengine@lfdr.de>; Thu, 15 Aug 2024 10:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7138C1D2F4D;
	Thu, 15 Aug 2024 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M7hcheU3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4051C9EC7;
	Thu, 15 Aug 2024 08:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723712280; cv=none; b=OpYzwMWEyxVbWUKI11chnNu3x/I9BkV1r+556kn6YrFIPiL+2LQCEN0eWPPHLJ2FEIgQhdDp+SUApz9A7TcGfH0ryjn0ApNlc949Uj5Mjt4p4N6fB/ECShYVv2QE+FO9YdiaN1pNWRmgzjo5nW4xls8csy8o6eN5zFsLC4d2Kuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723712280; c=relaxed/simple;
	bh=PMBdwWpShU/A5ZOAX8dAKLMI0UzcJy7yhxaoz7Be0Qg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UCs8oJZYu5vZovt/nW9K1ZEWPo5chzzKNzxchWy+gJUQ402i/iHsYbadC0PzcRxd/aOITY1D3wYLnsJJJetps91D4MyArPhrfLgwSlz62O86fpxXPDiATlRF9CgoaD0brhNygHMj/RM5CuaZXZgVXi4Vl6z7fZpfP0Ec+f686lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M7hcheU3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47ENiTuH028638;
	Thu, 15 Aug 2024 08:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=GJJJbe9B6gM
	ITc/LED6jtZrU3M/SQ5WwSA2Eqv3weoc=; b=M7hcheU3yE8g5qeNwxCXUz96MTG
	bGZZzI5pk9zS7KLkIYIMAFVgWqp1abxJ385UineOqtr7asdCI8rUSkJIPVpGD781
	HpQ5WR9VVDNd5d5l8VqzKs9zTHxzZlo3mEqkvkg+XHwfzdzVUojCxvr1dGH3qsrQ
	TgCG4YGWoJnTh6E/Ku3QRl1T/tFZqQ5mjoN0VfNFz3HwOHUshe2uupYyA+e71uNT
	A3KVfnwxeu9Jzl0WTztblJbu8JZUUGwr6KMx9c73EQLTjnQhifH/Wv4rrpmJ36zL
	oGmbvHGdySNE6iCwqzQsGVCVjLq2nUsxi3NkeYLN8zJ40iLleNGtSn/OAuA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4116h5ryn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 08:57:33 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 47F8sTNT025255;
	Thu, 15 Aug 2024 08:57:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 40xkmhennk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 08:57:30 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47F8vSVw029647;
	Thu, 15 Aug 2024 08:57:30 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 47F8vTZG029701
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 08:57:30 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
	id B6086417FA; Thu, 15 Aug 2024 14:27:27 +0530 (+0530)
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
Subject: [PATCH v2 12/16] crypto: qce - Add support for lock/unlock in sha
Date: Thu, 15 Aug 2024 14:27:21 +0530
Message-Id: <20240815085725.2740390-13-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: BBnqXgs44Wym-yaUwwDjtO__iV4-c6Gd
X-Proofpoint-ORIG-GUID: BBnqXgs44Wym-yaUwwDjtO__iV4-c6Gd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_01,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408150064

Add support for lock/unlock on bam pipe in sha.
If multiple EE's(Execution Environment) try to access
the same crypto engine then before accessing the crypto
engine EE's has to lock the bam pipe and then submit the
request to crypto engine. Once request done then EE's has
to unlock the bam pipe so that others EE's can access the
crypto engine.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v2]

* Removed unmap_sg() from crypto done api

Change in [v1]

* Added qce_bam_acquire_lock and qce_bam_release_lock
  api in sha

 drivers/crypto/qce/sha.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/crypto/qce/sha.c b/drivers/crypto/qce/sha.c
index fc72af8aa9a7..abfa63ff18d7 100644
--- a/drivers/crypto/qce/sha.c
+++ b/drivers/crypto/qce/sha.c
@@ -60,6 +60,8 @@ static void qce_ahash_done(void *data)
 	rctx->byte_count[0] = cpu_to_be32(result->auth_byte_count[0]);
 	rctx->byte_count[1] = cpu_to_be32(result->auth_byte_count[1]);
 
+	qce_bam_release_lock(qce);
+
 	error = qce_check_status(qce, &status);
 	if (error < 0)
 		dev_dbg(qce->dev, "ahash operation error (%x)\n", status);
@@ -90,6 +92,8 @@ static int qce_ahash_async_req_handle(struct crypto_async_request *async_req)
 		rctx->authklen = AES_KEYSIZE_128;
 	}
 
+	qce_bam_acquire_lock(qce);
+
 	rctx->src_nents = sg_nents_for_len(req->src, req->nbytes);
 	if (rctx->src_nents < 0) {
 		dev_err(qce->dev, "Invalid numbers of src SG.\n");
-- 
2.34.1


