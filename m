Return-Path: <dmaengine+bounces-528-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F2A812F01
	for <lists+dmaengine@lfdr.de>; Thu, 14 Dec 2023 12:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B096282352
	for <lists+dmaengine@lfdr.de>; Thu, 14 Dec 2023 11:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989214AF71;
	Thu, 14 Dec 2023 11:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Bqjbd6Hj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE16B2;
	Thu, 14 Dec 2023 03:43:00 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE5tKH8000547;
	Thu, 14 Dec 2023 11:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=UaPkvFvrgs/7Kiutb4T2
	XzNFd/EKJ1AzPTC8kfhBZE4=; b=Bqjbd6HjqtgfwrN1X32fHLW4lG/+8MoxpPLR
	OAN2yEqCqRZ0maPPBtcLj9e5zDYXyWofXUs5y5L7YRVFtbAuQXSKXH/z7/gdZs1X
	rVH6hZMyPhoDv6hy1llB5vbhAjhhRttYuKUJt8EO4ybVOwJrSKOf1aKjz81ou/Ci
	4l+F/akw6y5+FELOnIo20+dly7fNQvMlYJr9c8gk+AHyOX6eDCBofok6w9anYUUI
	P6GaQfqECGrTYX18Nkbo0f8t1ZDHyYQ4ddwQ2PD5o8G9rV9sTfdhT5TXHWp5qgTC
	vkLs12idH3QSI8fEUWDiT7ygfHOQ6yCuMXKbFV5ni2F414Izag==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uyp0p9a38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 11:42:48 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BEBgh38003053;
	Thu, 14 Dec 2023 11:42:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3uvhaktcgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 11:42:43 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BEBghom002916;
	Thu, 14 Dec 2023 11:42:43 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3BEBghj5002826
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 11:42:43 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
	id 81C9D414B7; Thu, 14 Dec 2023 17:12:42 +0530 (+0530)
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: thara.gopinath@gmail.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, linux-crypto@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, quic_srichara@quicinc.com,
        quic_varada@quicinc.com
Cc: quic_mdalam@quicinc.com
Subject: [PATCH 00/11] Add cmd descriptor support
Date: Thu, 14 Dec 2023 17:12:28 +0530
Message-Id: <20231214114239.2635325-1-quic_mdalam@quicinc.com>
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
X-Proofpoint-ORIG-GUID: tqziVHUzaBsXNm0zfwIgwYP9Qqh9ElzM
X-Proofpoint-GUID: tqziVHUzaBsXNm0zfwIgwYP9Qqh9ElzM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=491 mlxscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312140080

This series of patches will add command descriptor
support to read/write crypto engine register via
BAM/DMA

We need this support because if there is multiple EE's
(Execution Environment) accessing the same CE even with
different BAM pipe , then there will be race condition.
To avoid this race condition BAM HW having LOCK/UNLOCK 
feature on BAM pipes and this LOCK/UNLOCK will be set
via command descriptor only.

Since each EE's having their dedicated BAM pipe, BAM allows
Locking and Unlocking on BAM pipe. So if one EE's requesting
for CE5 access then that EE's first has to LOCK the BAM pipe
while setting LOCK bit on command descriptor and then access
it. After finishing the request EE's has to UNLOCK the BAM pipe
so in this way we race condition will not happen.

Md Sadre Alam (11):
  crypto: qce - Add support for crypto address read
  crypto: qce - Add bam dma support for crypto register r/w
  crypto: qce - Convert register r/w for skcipher via BAM/DMA
  crypto: qce - Convert register r/w for sha via BAM/DMA
  crypto: qce - Convert register r/w for aead via BAM/DMA
  drivers: bam_dma: Add LOCK & UNLOCK flag support
  crypto: qce - Add LOCK and UNLOCK flag support
  crypto: qce - Add support for lock aquire,lock release api.
  crypto: qce - Add support for lock/unlock in skcipher
  crypto: qce - Add support for lock/unlock in sha
  crypto: qce - Add support for lock/unlock in aead

 drivers/crypto/qce/aead.c        |  16 +++
 drivers/crypto/qce/common.c      | 144 +++++++++++++------
 drivers/crypto/qce/core.c        |   9 ++
 drivers/crypto/qce/core.h        |  12 ++
 drivers/crypto/qce/dma.c         | 238 +++++++++++++++++++++++++++++++
 drivers/crypto/qce/dma.h         |  26 +++-
 drivers/crypto/qce/sha.c         |  16 +++
 drivers/crypto/qce/skcipher.c    |  16 +++
 drivers/dma/qcom/bam_dma.c       |  10 ++
 include/linux/dma/qcom_bam_dma.h |   2 +
 10 files changed, 447 insertions(+), 42 deletions(-)

-- 
2.34.1


