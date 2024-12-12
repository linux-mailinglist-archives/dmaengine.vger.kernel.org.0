Return-Path: <dmaengine+bounces-3958-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDCC9EDE51
	for <lists+dmaengine@lfdr.de>; Thu, 12 Dec 2024 05:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CFB6283481
	for <lists+dmaengine@lfdr.de>; Thu, 12 Dec 2024 04:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66893199247;
	Thu, 12 Dec 2024 04:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eZOsptDE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5FB193094;
	Thu, 12 Dec 2024 04:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733977082; cv=none; b=AlqyXBIRsLp48Bn8iScQSu+niM61auo7UfMbq1A7WsHw7+J55v7Hf3n4T3hzRy47tTusmWHANsKDt9MQ7oZx4ZoB1mpfiGNP/1hjBoepkE9M+1FrS2dX1TGmygmGfKqUbARvWNIXwo2BcrgYcoErLm2LmpU7tdgeLPKUAfwdtng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733977082; c=relaxed/simple;
	bh=MGcRX4b+wxrBgAqakRtQqj4UCbk/AW7r7E0tZMpAQZU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmuUgBJfAgkkWWEynpaztIjm0J2dfWfeNQwDH6mQKL0zwSet47MGZyQFEzgDz2cjKsUShI5eKMebe7YNMO/eJplOs8L2kW3pKs7brdVypBxIHfgUIHJzd0XuNhZ25s6Y8rXZ5U48xx6Fw9FCaltQ9hNPaCEIrzwSRl4tEC/m+KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eZOsptDE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBHD4CH032195;
	Thu, 12 Dec 2024 04:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1IOmcn3hxztYQxjObnnA9U/IQjCF6WEM1HKXoLY1M9w=; b=eZOsptDEsL6Qz/2q
	LENMdP+IalIYAybWLpLam6187OACQ6SrM4SjER6NiLcPwnxmL2PrnuBz4mbxgDa0
	6VxUfaMmt2Ap1VXWu2huAqERO1Xjr/ON67OF4a5AsZ/fs2erT/2M6y4IiDeDkeh+
	VIph77LaepdsH59sYEmJsVSosWpCb7b5GZAj718hiimRcTHaEACEwKiVnfOKpcI9
	VukKExbb28uth6Ci0+ZiptK8QRq3C3jrPY8izHdSijrqzN2phPI9japZkYRr5HSE
	rxM9xfuXhkmpX+zjT34y3JDW1XQNmhmuTer0mCLAnHGKF1eLbUtr2Us869U1yi8p
	WaZENA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43f6tfaxch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 04:17:53 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BC4Hrvc021600
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 04:17:53 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 11 Dec 2024 20:17:48 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <vkoul@kernel.org>, <corbet@lwn.net>, <thara.gopinath@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <kees@kernel.org>, <dave.jiang@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_mdalam@quicinc.com>, <quic_utiwari@quicinc.com>
Subject: [PATCH v5 11/12] crypto: qce - Add support for lock/unlock in sha
Date: Thu, 12 Dec 2024 09:46:38 +0530
Message-ID: <20241212041639.4109039-12-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: D6Epg8tzUhgfmH_SCmXCRCuXC1wL5Hyv
X-Proofpoint-ORIG-GUID: D6Epg8tzUhgfmH_SCmXCRCuXC1wL5Hyv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120028

Add support for lock/unlock on bam pipe in sha.
If multiple EE's(Execution Environment) try to access
the same crypto engine then before accessing the crypto
engine EE's has to lock the bam pipe and then submit the
request to crypto engine. Once request done then EE's has
to unlock the bam pipe so that others EE's can access the
crypto engine.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v5]

* No change

Change in [v4]

* No change
 
Change in [v3]

* Move qce_bam_release_lock() after qca_dma_terminate_all()
  api

Change in [v2]

* Added qce_bam_acquire_lock() and qce_bam_release_lock()
  api for SHA

Change in [v1]

* This patch was not included in [v1]

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


