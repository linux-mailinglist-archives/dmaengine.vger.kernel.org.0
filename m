Return-Path: <dmaengine+bounces-3110-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4593A971396
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 11:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E334C1F2294A
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 09:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70231B5332;
	Mon,  9 Sep 2024 09:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V9msYzLN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2591B5315;
	Mon,  9 Sep 2024 09:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874103; cv=none; b=TVkwxOrKV4mPRyjQhN9vexD8CzxQIjuNO37PUPwMid1svRbflbgRoV9Txbzb4lWvWsJUWkwYSy9SnpyibDJD36ZPeCvTo447YAxJBRhoZXXNXqCeM5zZgh/tzpNkuaMKejzrxeDWtH7UZQgOI9tw4rL7AAnv5rbFzV2XoYhAwT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874103; c=relaxed/simple;
	bh=NzPiyH7keLz7uGhJMqS0nSkxw+5QlyN56+cwTbGwexk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F0zJbF1zf4K1uqbz97S0Ph8ERglDwHuCCmJwlewQ7XQJLUkJ4k7pfoBKMzpE/cGdkRRscAB/2y8zrIF6WYLPjpu4/BSGBPiTt26Fs+lr+yuc6hJbl6lhthEzBTmeDJEzwJMeKjz9b8frD5MVwOxjC5vo9CnTwk4uKNNViFYiZtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V9msYzLN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4899JrGg005060;
	Mon, 9 Sep 2024 09:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aneSeh2QGlsH0G08OUH3j3Kyla/ciBKmZOl1i4Z1CY8=; b=V9msYzLNDAgz+gc9
	16azCC+MzkNpvV0hg6XkNQwUsm2FVvb6KcIR48j+5Af2v8BO8P/WF0tgAinzj2dQ
	lGXXcIs0+fFHwrVUd+mBIeNGJfx5cvuifs3ZMr7g20d/0JgIR671ZE4oxWYyaRdy
	MXRMV4m+3K/vtZbfQniX6pcl3L7eh9gfkCLM5b83A4p0vUR0Q10kxMIqeVbHCBZi
	uGiHi5jtza5utgr41de8V1rI7jtX9sHR6oZDX/DI7Ibv4we6kTOxElEj41Bml7HX
	mAwZQJlDBK5pKvsJLvzlz8TcfPirwsmekumjhxSMvYmUxHQwfen7lkOZZ4Lnk+wv
	Wy2AFg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy512bec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 09:28:12 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4899RuhP031566
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Sep 2024 09:27:56 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 9 Sep 2024 02:27:50 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <thara.gopinath@gmail.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <vkoul@kernel.org>, <kees@kernel.org>,
        <robin.murphy@arm.com>, <fenghua.yu@intel.com>, <av2082000@gmail.com>,
        <u.kleine-koenig@pengutronix.d>, <linux-crypto@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <quic_varada@quicinc.com>,
        <quic_srichara@quicinc.com>
CC: <quic_mdalam@quicinc.com>
Subject: [PATCH v4 09/11] crypto: qce - Add support for lock/unlock in skcipher
Date: Mon, 9 Sep 2024 14:56:30 +0530
Message-ID: <20240909092632.2776160-10-quic_mdalam@quicinc.com>
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
X-Proofpoint-ORIG-GUID: LZWc3Wrawb4nGf4Rias4EuD47xlrLEka
X-Proofpoint-GUID: LZWc3Wrawb4nGf4Rias4EuD47xlrLEka
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409090075

Add support for lock/unlock on bam pipe in skcipher.
If multiple EE's(Execution Environment) try to access
the same crypto engine then before accessing the crypto
engine EE's has to lock the bam pipe and then submit the
request to crypto engine. Once request done then EE's has
to unlock the bam pipe so that others EE's can access the
crypto engine.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v4]

* No change
 
Change in [v3]

* Move qce_bam_release_lock() after qca_dma_terminate_all()
  api

Change in [v2]

* Added qce_bam_acquire_lock() and qce_bam_release_lock()
  api for skcipher

Change in [v1]

* This patch was not included in [v1]

 drivers/crypto/qce/skcipher.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index 5b493fdc1e74..a4e09562b5f4 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -52,6 +52,8 @@ static void qce_skcipher_done(void *data)
 
 	sg_free_table(&rctx->dst_tbl);
 
+	qce_bam_release_lock(qce);
+
 	error = qce_check_status(qce, &status);
 	if (error < 0)
 		dev_dbg(qce->dev, "skcipher operation error (%x)\n", status);
@@ -82,6 +84,8 @@ qce_skcipher_async_req_handle(struct crypto_async_request *async_req)
 	dir_src = diff_dst ? DMA_TO_DEVICE : DMA_BIDIRECTIONAL;
 	dir_dst = diff_dst ? DMA_FROM_DEVICE : DMA_BIDIRECTIONAL;
 
+	qce_bam_acquire_lock(qce);
+
 	rctx->src_nents = sg_nents_for_len(req->src, req->cryptlen);
 	if (diff_dst)
 		rctx->dst_nents = sg_nents_for_len(req->dst, req->cryptlen);
-- 
2.34.1


