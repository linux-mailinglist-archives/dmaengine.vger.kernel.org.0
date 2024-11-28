Return-Path: <dmaengine+bounces-3809-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 424169DB8C9
	for <lists+dmaengine@lfdr.de>; Thu, 28 Nov 2024 14:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04DB7281219
	for <lists+dmaengine@lfdr.de>; Thu, 28 Nov 2024 13:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9801A9B35;
	Thu, 28 Nov 2024 13:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AlPQkGFQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4296F1A29A;
	Thu, 28 Nov 2024 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732800856; cv=none; b=SE59JJ8UjIeA4vQxEKbjBZBpDlz+PDgtlGz7YOAo8+QONreViny/b2V7lmJUjk3RV7/dJiffiD9U5F3VItg9wYxNCJ7efQQQfigWBhdPuXrVfrWN3Thpnrje02ZsTXrkH7kPh0rjyGiZYRPvTzyeMUe+6uolqRMC2VqnJ+2QH8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732800856; c=relaxed/simple;
	bh=ZvTd00fnco11E4EWIweRrAc8AjwbJP784CxZOEfdGJY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jlb/YpY7aKWtN+xoYQkFKXrfeF0LpB03Cv9b1XKxta+wGOMt/HG/FVCwoTkuE07prR0pTahS+IPZpeYW/dInAs3toHi9QwqZi2G4yZrIWb5tEHcGcDnuFH8/mTtDmt/KgbCjfiFPu7zMWtE76BsIJcXR2y9K9OkaSMRqQlw/V4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AlPQkGFQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AS8hX4c012287;
	Thu, 28 Nov 2024 13:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=ujC9rX20xzmXBX7Z0EPm7uXpVSxDFoT6gE0DgYc0xSE=; b=Al
	PQkGFQNLp4vGIG/gy80xRoqoDpofWWKVF2RTM3iYsLbQiMm7PNQz5BaxKzMcTzwG
	9DvamylZ6BygZqUF+JA1LUlY0WW6HdZz7Xc92aDLoSBV40zr1H6ggUuqDmcb4egz
	x15r7j9YbL/vH7mXpAqbzBXIzUxXhq9kacayilzw3hrl7haq54pSl63ywjfk9xy4
	j5J8pD1fPRlcDiT3CvKwxNW+uqD2GXVNta2PkiPln69KK4w2sm4fDwfjf60jT+Qj
	scgkHDl1F6AOJYCmNbT042auQpepcD+IS7RqlhlvC8afXWmHk0C67t7W+mnpNzCy
	CFR3PYFMrdvZF7TAHXJA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4366xy2t54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 13:34:11 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ASDYAKL030161
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 13:34:10 GMT
Received: from hu-jseerapu-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 28 Nov 2024 05:34:08 -0800
From: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
To: Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>
Subject: [PATCH v2 0/2] Add GPI immediate DMA support for SPI 
Date: Thu, 28 Nov 2024 19:03:49 +0530
Message-ID: <20241128133351.24593-1-quic_jseerapu@quicinc.com>
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
X-Proofpoint-GUID: 8FYvQU7At5hPqwUGVP5MqXtwdjrFTKa-
X-Proofpoint-ORIG-GUID: 8FYvQU7At5hPqwUGVP5MqXtwdjrFTKa-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2411280106

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

v1 -> v2:
   - Separated the patches to dmaengine and spi subsystems
   - Removed the type conversions used in gpi_create_spi_tre of gpi.c.
   - Removed the changes which are not required for this feature from
     qcom-gpi-dma.h file. 

Jyothi Kumar Seerapu (2):
  dmaengine: qcom: gpi: Add GPI immediate DMA support
  spi: spi-geni-qcom: Add immediate DMA support

 drivers/dma/qcom/gpi.c           | 32 +++++++++++++++++++++++++++-----
 drivers/spi/spi-geni-qcom.c      |  7 +++++++
 include/linux/dma/qcom-gpi-dma.h |  6 ++++++
 3 files changed, 40 insertions(+), 5 deletions(-)


base-commit: ceab669fdf7b7510b4e4997b33d6f66e433a96db
-- 
2.17.1


