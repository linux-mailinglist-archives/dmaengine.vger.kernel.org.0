Return-Path: <dmaengine+bounces-6776-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39718BC4129
	for <lists+dmaengine@lfdr.de>; Wed, 08 Oct 2025 11:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B853A569F
	for <lists+dmaengine@lfdr.de>; Wed,  8 Oct 2025 09:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B50258CE2;
	Wed,  8 Oct 2025 09:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P/5hSsVD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDB215278E;
	Wed,  8 Oct 2025 09:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759914280; cv=none; b=F401OK8uISJ3cU48Hdb0xBeR7AY07+ltqjSNy6fcmXAxscmjAIc82SGfN/dAPCShW04tmbYHU0MT4hpAMQz14CnPq/xTA9iMLU3shTZ9TnCKRgCFOsr92CXxVl9A3m5hQs3MU6XMEgztrQk5kvu9RvpckQWmxO8a9Edkos5JSc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759914280; c=relaxed/simple;
	bh=SdvTlXMKJvyPb3w46Jgj04UcW3a9z7MDoWTznDZvu1U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b1GPXpMaf4hwJHpMwctFwrbtrac/5xgUxulEjzxlVnh1CytHXTj/CQEP+05BKHpgzpLIxJj/ghOSxdBc2ZI7+s4S/RLsJ849kiEGMgvtqa29IsklpeMvicwwy1XCOrmeYDWs6wRM1IYFxGbcVQJkmfBDzCKk6WHdw1DCEd4pA9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=P/5hSsVD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890ege010088;
	Wed, 8 Oct 2025 09:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6sCbMgejXco/pdMQUUsUKP
	TBooMiMHR2wg23BmGSnGA=; b=P/5hSsVDdHiariFcyILuxtFlYHQEjPjOl+RlV7
	nlv0WjGbz2Bpwy5mbUGHsbqnQNVI4bSLPXplbnSBXPUa0D4d3zhbMCELgKP73tOy
	jXzmXnfQDePs/ZyFAJ1hXxLh9/zTzBLEQj6Dh/KkxQnmVZ8BqbbQqT6acQMgfa8o
	5RDpvbbbhMyyP5+VhPjtroqupdAuBwJyTLohlWIUuZCytREOV2ltanGBVwYwGOj9
	8CgWfK4Is+bSLi1+aW5bgp7zd6yeApbasayFipBNnYulqlQQL5JLfMNgacRZWw34
	X9kJZL+2B4Wtupcq5elY8DiDNbGpLu47MtOV2TDcV49Irm7g==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49junu9vwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 09:04:35 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59894Yts028553
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Oct 2025 09:04:34 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Wed, 8 Oct 2025 02:04:29 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_varada@quicinc.com>, <quic_mdalam@quicinc.com>
Subject: [PATCH v2 0/9] Add QPIC SPI NAND support for IPQ5424 and IPQ5332 platforms
Date: Wed, 8 Oct 2025 14:34:04 +0530
Message-ID: <20251008090413.458791-1-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: O3pWC-BqnCKpTxeY4SqgQ9LkbNDNtiLV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMyBTYWx0ZWRfX7MjHqXdmszv2
 BA2F/WrEPJykdt/GzC9yeDFk8jVPldsiJS63Ql1jjriq+zVe1S0cPSzj/o3lHNV233gutlBMIbl
 hEti7Hqt/m+y+VploTTy5K+bUVtrF/jzCXhLVVbVIjUsbf66O/Y9KSYHC5hlQybrrKoDI5/SiB5
 woLGjcwVjXMCnCJs1h5c1Xew8B0sRA8gQpBYIWyZFl+mnbs93NKcqcEllRhPpAPDlOR2m9CjOZT
 pwCe1C06H8dRN2Jpa4fIG4moONfGIoxYthLyv750otyr8uUq3G3RskCWXp4iREPpQ6jFkdE9uFg
 JSRv/RQCkNL9pD+nFiqEYQDbHAMduI5v377B/2R3bOxBta3dB8JS/zZGUrleaYPRpiivqYEbv8Q
 AfnN25dno+H0x0C/tVCKE7LSTfWxwg==
X-Authority-Analysis: v=2.4 cv=CbIFJbrl c=1 sm=1 tr=0 ts=68e62923 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=bg76ppHvD6wD7w3OU-AA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: O3pWC-BqnCKpTxeY4SqgQ9LkbNDNtiLV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040023

v2:
 * Added Reviewed-by tag
 * Added Acked-by tag
 * Updated board name in commit message header
 * Added \n before status

v1:
 * Added support for spi nand for IPQ5424 and IPQ5332
 * Updated bam_prep_ce_le32() to set the mask field conditionally based
   on command
 * Removed eMMC node for IPQ5424 and IPQ5332

Md Sadre Alam (9):
  spi: dt-bindings: spi-qpic-snand: Add IPQ5424 compatible
  spi: dt-bindings: spi-qpic-snand: Add IPQ5332 compatible
  dma: qcom: bam_dma: Fix command element mask field for BAM v1.6.0+
  arm64: dts: qcom: ipq5424: Add QPIC SPI NAND controller support
  arm64: dts: qcom: ipq5332: Add QPIC SPI NAND controller support
  arm64: dts: qcom: ipq5424-rdp466: Enable QPIC SPI NAND support
  arm64: dts: qcom: ipq5332: Enable QPIC SPI NAND support
  arm64: dts: qcom: ipq5424-rdp466: Remove eMMC support
  arm64: dts: qcom: ipq5332-rdp442: Remove eMMC support

 .../bindings/spi/qcom,spi-qpic-snand.yaml     |  2 +
 .../boot/dts/qcom/ipq5332-rdp-common.dtsi     | 44 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts   | 34 --------------
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         | 27 ++++++++++++
 arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts   | 44 ++++++++++++-------
 arch/arm64/boot/dts/qcom/ipq5424.dtsi         | 27 ++++++++++++
 include/linux/dma/qcom_bam_dma.h              | 21 ++++++---
 7 files changed, 145 insertions(+), 54 deletions(-)

-- 
2.34.1


