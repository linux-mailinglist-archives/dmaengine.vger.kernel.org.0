Return-Path: <dmaengine+bounces-6625-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B188B83DB0
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 11:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1FBA1BC3AF8
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 09:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44542F9DB8;
	Thu, 18 Sep 2025 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PnP1LUSZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4692E9743;
	Thu, 18 Sep 2025 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758188478; cv=none; b=m7+Qlf4TyrFTUJtC9zd9jptWvak3+0Kr7kEVqds8un+1xauXneVnKXyCWqCUUhFBpJPPkOnoo0ttoF52Un5l9sn72jaKnQNJ5mLZwIUORX+MSyk520DO15k+EiztlzlikjNsCV7YsXtyfAxSBtAuPWFd2dXKvGoGCWBu8j/yUcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758188478; c=relaxed/simple;
	bh=qOzNqGcSG0GDuk6HKAGNwFesVft70V3Ii7rBIssDkTQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DKJd4oS6PUjnx2ETm9JjI+jfKZ75xoaR/8tq4lOIVZEwoaZ1FKnIZGpuTCaC7obO9TvcEWAdCHiBXRYw2Fw+HCGZngsX7L8ExR7neJmmka84w8gYD/JI5ppDOVkYyD2nubmB7v4vlzTAfdjWJ8RnvCOrRnuTdm8ZlMPgryEndsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PnP1LUSZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I3P7b8018228;
	Thu, 18 Sep 2025 09:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UXE3prCps91uHM+QYKiKxjYTOs8jEg+6/Y3TtqoVPu0=; b=PnP1LUSZ039GzBKW
	DaBoDCNr5dH4Ej9uCBgkF/pBj9avBG3n5xg8+3X/IRLnU4WdnuXmU/n2sl6Tak1V
	u6X7d9QSoitQaamLBDhxelHlYynTdod4A1rbu7v2QltH1o+NvnxcIyM1TsBOgNNU
	X5FTyfJflIkCH5gWBe40Hgqju6jKfwqfrM1eFiDDJq9xRQtENTxq4hoLGBqXGSAB
	xttVmVyrdFUzX4V/1Dd15jI+UYUWWPG9W9nBuwSWiEywoDuHJ9qWXBsGTLA7eOKX
	r4YoTmHgPUtKzaqfizpRZ4ok28yRCoFl9pRe6HN9AcYPx81+9o2srMDKcy7pXUIb
	lcJ/vA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxwds3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 09:41:09 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58I9f8gh029124
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 09:41:08 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 18 Sep 2025 02:40:43 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_varada@quicinc.com>, <quic_mdalam@quicinc.com>
Subject: [PATCH 2/9] spi: dt-bindings: spi-qpic-snand: Add IPQ5332 compatible
Date: Thu, 18 Sep 2025 15:10:10 +0530
Message-ID: <20250918094017.3844338-3-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918094017.3844338-1-quic_mdalam@quicinc.com>
References: <20250918094017.3844338-1-quic_mdalam@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=HbIUTjE8 c=1 sm=1 tr=0 ts=68cbd3b5 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=xHbhbzFCDHVFC9Sw49wA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX2KcN/mVmmjHs
 0/ybZbCnLdq4JqstijM3ugDfYSfHLttlVz/oDXcSN/dC8moxYk9NzPc5wHR3anj7aI37+v4g6jP
 qk2/oNXnjiBXbvtEL5cNbWLMcDVOjawVBBCuFEGPw8kMCcAJb+qTBD8I3F0fEYDB8wpMZ5698X7
 YCxOuPWDDjKjpRfxRW1+utHzOoprlr3L5ze+kz7A5FQU9NgqivcNAfEjZdGu8ZorF/so4sqxPe4
 /udw4VmCQBryd19aWUenwhQZC/8Crx0FLfiN+nnsV4ibG6tkB0h8qiOfIL9WiQtAy9w0T1igVhc
 IJfFoDeOL1vG1Q2dkTJYEEHtx5GgQ1tONsLjSXtMTdbn62fVlyt8ZGmZrMvbHqGOfQrl3Gw5BDK
 y6bV3RzZ
X-Proofpoint-GUID: e7CZBJn4jccV4zWWVQ9NkulhGqrKwl5d
X-Proofpoint-ORIG-GUID: e7CZBJn4jccV4zWWVQ9NkulhGqrKwl5d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1011
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

IPQ5332 contains the QPIC-SPI-NAND flash controller which is the same as
the one found in IPQ9574. So let's document the IPQ5332 compatible and
use IPQ9574 as the fallback.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
 Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
index 39e086ced891..7d0571feb46d 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
@@ -25,6 +25,7 @@ properties:
       - items:
           - enum:
               - qcom,ipq5018-snand
+              - qcom,ipq5332-snand
               - qcom,ipq5424-snand
           - const: qcom,ipq9574-snand
       - const: qcom,ipq9574-snand
-- 
2.34.1


