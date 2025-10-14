Return-Path: <dmaengine+bounces-6833-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBDEBD8E31
	for <lists+dmaengine@lfdr.de>; Tue, 14 Oct 2025 13:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB66B3E4801
	for <lists+dmaengine@lfdr.de>; Tue, 14 Oct 2025 11:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7382FF145;
	Tue, 14 Oct 2025 11:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XCFDe5+K"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080012F60BC;
	Tue, 14 Oct 2025 11:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760439962; cv=none; b=Dl3VYnf9ZmPcHDfUGoerH3VP9OcIzKRs+pdZTayITlHI/3K32baNTmHo7YFcAtGN+s5pktmXh0JdtuwTII1TF9H77Iifv0QjLZeBw/5v7Q/AQBAJ/FPKXtr0ZTePSrzKDdqdXplh+yuETJlEM2sYrfaoDn1Cg+McuAw+9Q2zHSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760439962; c=relaxed/simple;
	bh=HJSqaeccc25qC6N9mn5hncbcJQm61jJiA2fCvyq7LA8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a7tSCgQ0bV2g0/YMzZtS2YW7/WDqu2uONOmlyxEvGjc3zJ63nnFA1QvMJrJbHDt3d+g3gU0cOCJTm/sTz122R34kAcB8RrOkUhoXz0/5c48Jdkukk+0oYAFvXZzCDouwOATkNzMZlsdYbz3AIQgsmiV0/Xq/9i9TsVBZcAADdz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XCFDe5+K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87JDk025638;
	Tue, 14 Oct 2025 11:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=unwFSMDnJsGbLxamntRKA7
	XjJ5KWfmnYaSsDYUrlRc0=; b=XCFDe5+KrlzBbgvf0S4r4YUXOEs8+qYO4lpngA
	fNXCGIJFKeAaAfQZlgN82+y9erRCKw5Os39aEwnxx+Qy9hqedj3RfuqX77Ga3fWM
	qVIQcBpWd3SJjutJ8nwjeKJZ8DP+X6WMmRpy+l7dEJGFjQhAXHdRpV8EUxmJolWI
	6wsvIxAxRpXdOqLptMjyg/qmS0V0in4XcvQNY2qSNMpgLXYbcsBpkY2Z7wrTyjgT
	H/kH4iqvkfD5h3totCjmUfcDVPdkcVGppjcqZBJ7QMRBLP4UvxQRcazvhzzbp+Zf
	Ybtd5krWhrktlKkmtvvZo6LIvIjByP5LRdQygHjTQRaIo9tQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qgdg0260-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 11:05:56 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59EB5t6x032150
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 11:05:55 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Tue, 14 Oct 2025 04:05:51 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_varada@quicinc.com>, <quic_mdalam@quicinc.com>
Subject: [PATCH v3 0/9] Add QPIC SPI NAND support for IPQ5424 and IPQ5332 platforms
Date: Tue, 14 Oct 2025 16:35:25 +0530
Message-ID: <20251014110534.480518-1-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyNSBTYWx0ZWRfX5Uwg/GXkQw8m
 yPnjBKFelt5vzkBKZ++BrDAA651l0TcYHoblyJRZA5tl+2SLvq+H+nFYBv9ua9BxitwPe1ey2A7
 a1U1GxQV6r6IEBG2A0+jBh4NpD1Ksb1UCvcAgleh0QQTCbfMb8duvGzcnvnrXj8dbIYW94KMgUK
 yNHsycbHHpllZxFE7oMyDzjzPAMEWzGoFkFj+2gITfZrSpxH6d9xHXxw6FoOZZYmaK/sBXRHNO7
 Q+/xKzFjsPntas7Si3iZQUydYJk2/zzGogrmI0lnk/k5QWnJLvFu7luRQRMOmrvtzHIIf1coDEF
 BQh1l6h/HW7XPfAE8eyaErZlPGTOLof1TBeHoOesZxdcVojGQyttl4Xtm0puk903kQPwtAdo6Fw
 AAlz1isaT01Qu+L/ZyfI8+LVd1DfDA==
X-Proofpoint-GUID: Wbk5SddEwNUhJfiUYNuIHENQ-kxQuDCK
X-Proofpoint-ORIG-GUID: Wbk5SddEwNUhJfiUYNuIHENQ-kxQuDCK
X-Authority-Analysis: v=2.4 cv=J4ynLQnS c=1 sm=1 tr=0 ts=68ee2e94 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=TQ69iSlqDmPYr9GvtBUA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110025

v3:
 * Added Tested-by tag
 * Added Reviewed-by tag
 * Reformatted clocks, clock-names, dmas, and dma-names properties
   to one entry per line
 * Rename ipq5332 to ipq5332-rdp-common

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
  arm64: dts: qcom: pq5332-rdp-common: Enable QPIC SPI NAND support
  arm64: dts: qcom: ipq5424-rdp466: Remove eMMC support
  arm64: dts: qcom: ipq5332-rdp442: Remove eMMC support

 .../bindings/spi/qcom,spi-qpic-snand.yaml     |  2 +
 .../boot/dts/qcom/ipq5332-rdp-common.dtsi     | 44 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts   | 34 --------------
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         | 33 ++++++++++++++
 arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts   | 44 ++++++++++++-------
 arch/arm64/boot/dts/qcom/ipq5424.dtsi         | 33 ++++++++++++++
 include/linux/dma/qcom_bam_dma.h              | 21 ++++++---
 7 files changed, 157 insertions(+), 54 deletions(-)

-- 
2.34.1


