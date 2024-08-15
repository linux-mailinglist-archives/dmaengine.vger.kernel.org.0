Return-Path: <dmaengine+bounces-2871-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93B0952BC5
	for <lists+dmaengine@lfdr.de>; Thu, 15 Aug 2024 12:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6995281D5F
	for <lists+dmaengine@lfdr.de>; Thu, 15 Aug 2024 10:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FBF19AD87;
	Thu, 15 Aug 2024 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YeCrQwzQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEF21684AC;
	Thu, 15 Aug 2024 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723712566; cv=none; b=rGBBfQEWyjdQt2WlHBvW2OEY/dICfejAKl0aW3hik9Gw/0++LMaFwNeLaaq64U5ye0/dWcyjsv9Y5OLH2kAsF04GEljBlClswAuBXewZbEwie4dEmgQl3Y1XKzh8fJi1oBI1UeBDW3KmKWsRj/Z6spAo4QlIMbzlgG2wV2uC4sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723712566; c=relaxed/simple;
	bh=YjSqiA7/QVLf25LwcJfb9dB8HqlVkkV9IyQB9ZLnEGc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LM6vUmwBsqKTb8PF/NfTcQBbfaedc6lzBIOSggYtNE7XwyTVZoKcQcPTqzyqt4MAbLeLaUi5IkmPbogUPVIMLaMCAxcJaXFypxQu/LNDV8hGpuvna1nQoClSEV/vvJzJfQuY25uBA7hwXcMeQgW9Gy2IDDzPs34YuB2tAtepum8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YeCrQwzQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47ENHGbN001557;
	Thu, 15 Aug 2024 08:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=IjbkWi5kX00E+MSOryd9RKDwP/mZ52uqdmY
	550VUK4s=; b=YeCrQwzQuBbkaTD01WChDrtFoM166clfvjukRBaWAAso/CKRLOo
	vY9RgDYwup/bWd6/w+axGdpdvhjyJAaa2Qc0OqAXsxeUPOKi7H9NDo0+YM2R8rcH
	4Jm1EzdCv+bWGWRbq+dlvaIevCZh7peOkyqp5FI+H20LLs+rtHc1KjwMwxYo+q7n
	VVuEsQuqcxIzqzVPiT2zYljp2d75w6ulsXTBdHr0NutXQ7r23hmbUjEXr1pQZyrD
	BEiXwotc7Gr/ARK6yPNzjTFd52uZYvNHcO/QNUhUt73O3lO6IUeUuLMnY3hPV0tQ
	QgyT0K6QZ4/zxekImldpfLcGbLg8Tp3DlLg==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 410437xysa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 08:57:32 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 47F8sTNQ025255;
	Thu, 15 Aug 2024 08:57:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 40xkmhenmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 08:57:29 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47F8vSMr029648;
	Thu, 15 Aug 2024 08:57:28 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 47F8vSUK029642
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 08:57:28 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
	id 8BB644117A; Thu, 15 Aug 2024 14:27:27 +0530 (+0530)
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
Subject: [PATCH v2 00/16] Add cmd descriptor support
Date: Thu, 15 Aug 2024 14:27:09 +0530
Message-Id: <20240815085725.2740390-1-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: df4jEv_9SsajWUuB6skBt_37TqV9FpTa
X-Proofpoint-GUID: df4jEv_9SsajWUuB6skBt_37TqV9FpTa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_01,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxlogscore=850 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408150064

This series of patches will add command descriptor
support to read/write crypto engine register via
BAM/DMA

We need this support because if there is multiple EE's
(Execution Environment) accessing the same CE then there
will be race condition. To avoid this race condition
BAM HW hsving LOC/UNLOCK feature on BAM pipes and this
LOCK/UNLOCK will be set via command descriptor only.

Since each EE's having their dedicated BAM pipe, BAM allows
Locking and Unlocking on BAM pipe. So if one EE's requesting
for CE5 access then that EE's first has to LOCK the BAM pipe
while setting LOCK bit on command descriptor and then access
it. After finishing the request EE's has to UNLOCK the BAM pipe
so in this way we race condition will not happen.

tested with "tcrypt.ko" and "kcapi" tool.

Need help to test these all the patches on msm platform

v2:
 * Addressed all the comments from v1
 * Added the dt-binding
 * Added locking/unlocking mechanism in bam driver

v1:
 * https://lore.kernel.org/lkml/20231214114239.2635325-1-quic_mdalam@quicinc.com/
 * Initial set of patches for cmd descriptor support

Md Sadre Alam (16):
  dt-bindings: dma: qcom,bam: Add bam pipe lock
  dmaengine: qcom: bam_dma: add bam_pipe_lock dt property
  dmaengine: qcom: bam_dma: add LOCK & UNLOCK flag support
  crypto: qce - Add support for crypto address read
  crypto: qce - Add bam dma support for crypto register r/w
  crypto: qce - Convert register r/w for skcipher via BAM/DMA
  crypto: qce - Convert register r/w for sha via BAM/DMA
  crypto: qce - Convert register r/w for aead via BAM/DMA
  crypto: qce - Add LOCK and UNLOCK flag support
  crypto: qce - Add support for lock aquire,lock release api.
  crypto: qce - Add support for lock/unlock in skcipher
  crypto: qce - Add support for lock/unlock in sha
  crypto: qce - Add support for lock/unlock in aead
  arm64: dts: qcom: ipq9574: enable bam pipe locking/unlocking
  arm64: dts: qcom: ipq8074: enable bam pipe locking/unlocking
  arm64: dts: qcom: ipq6018: enable bam pipe locking/unlocking

 .../devicetree/bindings/dma/qcom,bam-dma.yaml |   8 +
 arch/arm64/boot/dts/qcom/ipq6018.dtsi         |   1 +
 arch/arm64/boot/dts/qcom/ipq8074.dtsi         |   1 +
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         |   1 +
 drivers/crypto/qce/aead.c                     |   4 +
 drivers/crypto/qce/common.c                   | 142 +++++++----
 drivers/crypto/qce/core.c                     |  13 +-
 drivers/crypto/qce/core.h                     |  12 +
 drivers/crypto/qce/dma.c                      | 232 ++++++++++++++++++
 drivers/crypto/qce/dma.h                      |  26 +-
 drivers/crypto/qce/sha.c                      |   4 +
 drivers/crypto/qce/skcipher.c                 |   4 +
 drivers/dma/qcom/bam_dma.c                    |  14 +-
 include/linux/dmaengine.h                     |   6 +
 14 files changed, 424 insertions(+), 44 deletions(-)

-- 
2.34.1


