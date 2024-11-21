Return-Path: <dmaengine+bounces-3752-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5634D9D4C46
	for <lists+dmaengine@lfdr.de>; Thu, 21 Nov 2024 12:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DEC41F219A3
	for <lists+dmaengine@lfdr.de>; Thu, 21 Nov 2024 11:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575EB1D173F;
	Thu, 21 Nov 2024 11:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AkIwMhHw"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6871C728F;
	Thu, 21 Nov 2024 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732189945; cv=none; b=E3xJ4LiXRWlNgvNsqEpafKwL/8pOC9jWvGwfe+FYI3WTMeF/GI8OOdCDRb62J3veSSvlt9TL+ftIzjJYyRb09h66lZVrbvGLOkWuFjCpQLWkHSLA4K7ZFy+V/IIUT0DGVCUI9cvXWghOn9Nl5MuzqkNHc2maCYJep2tJcvydEn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732189945; c=relaxed/simple;
	bh=TtFwO5nvC1CV1vzYzPGD9fp+JZW1DS9qinQDsXCKHeY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r5RXNGO60xdAjTMoPi5vmdqQuGEaiyA7E5+UQlBnty7JwXgDjY6o8K6EEN7OsX0mrIaiUuWpinzDMeOD9l73nSc5Royg2Bi/8p/jVQgvdHPyOEd/vTKf4J/EnOXqmAmtZ/qRlLAb8X0MOsqm0rlQnkoyEcuYBcL3ndlypWOwr3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AkIwMhHw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL8rmWh025914;
	Thu, 21 Nov 2024 11:52:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=KYG/1y47n/aZuEYR8VkXo3MghMJwMawIer5RSHUyT4E=; b=Ak
	IwMhHwOfbHftLKodJnegCtnES4T9yzwl8rLhc3d0m7wZqGCFvwu2s6IssmzT0QhB
	9BQN/shuc4xQxRl5HIJkhLfiXPUYFkCsxRrYHpNEME3+zD3vS3bYKjmeRzwaIivx
	6uyra/v1acUuHH6XxQ4mQW0BrScFsMZAgJfeJGi0x7eomnUx8UlGSgxpsVkHOKzO
	Bptc49UUDNUi+Bs/50tDdXER41PFuSZ0z1uhX91aW+mrg8CQOw/ot0NusCGkzPAd
	NV9FihFM0+rkRGtmN4ouGlx7ikN3zGSrWBTIQkLlF2x6NnY4mYliONfID7r+1j6S
	maG7qiAW3kfEjuh+XANw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431byjm0fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 11:52:20 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ALBqJLH001010
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 11:52:19 GMT
Received: from hu-jseerapu-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 21 Nov 2024 03:52:16 -0800
From: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
To: Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>
Subject: [PATCH v1 0/1] Add immediate DMA support
Date: Thu, 21 Nov 2024 17:22:00 +0530
Message-ID: <20241121115201.2191-1-quic_jseerapu@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iMooJ3F5V7cNcWPk6dT7iy5TP-PmSOdF
X-Proofpoint-ORIG-GUID: iMooJ3F5V7cNcWPk6dT7iy5TP-PmSOdF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=849
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411210093

The DMA TRE(Transfer ring element) buffer contains the DMA
buffer address. Accessing data from this address can cause
significant delays in SPI transfers, which can be mitigated to
some extent by utilizing immediate DMA support.

QCOM GPI DMA hardware supports an immediate DMA feature for data
up to 8 bytes, storing the data directly in the DMA TRE buffer
instead of the DMA buffer address. This enhancement enables faster
SPI data transfers.

This optimization reduces the average transfer time from 25 us to
16 us for a single SPI transfer of 8 bytes length, with a clock
frequency of 50 MHz.


Jyothi Kumar Seerapu (1):
  spi: spi-geni-qcom: Add immediate DMA support

 drivers/dma/qcom/gpi.c           | 32 +++++++++++++++++++++++++++-----
 drivers/spi/spi-geni-qcom.c      |  7 +++++++
 include/linux/dma/qcom-gpi-dma.h |  7 +++++++
 3 files changed, 41 insertions(+), 5 deletions(-)

-- 
2.17.1


