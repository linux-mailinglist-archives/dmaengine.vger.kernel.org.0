Return-Path: <dmaengine+bounces-6777-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BE3BC413B
	for <lists+dmaengine@lfdr.de>; Wed, 08 Oct 2025 11:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2216D4F7D1F
	for <lists+dmaengine@lfdr.de>; Wed,  8 Oct 2025 09:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1302F5329;
	Wed,  8 Oct 2025 09:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O0ZvM3gG"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDDC2F5321;
	Wed,  8 Oct 2025 09:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759914284; cv=none; b=bRCjl3Vrddrn4K2mPyfoYoFnzEqGdmP+jjYOjD4Dc9FStOAL7V80KtmLVn4EAkbY0bZ7Wo1DLEK2FfRqBVYmYuLOOjxwjLbd8LG2jrsEsEwhVsXmwy1IAPm/+g6jv87SLV5xyiGcTuhRDNbbEzUWFs9mKS5E9sqlOJX+cSsREmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759914284; c=relaxed/simple;
	bh=EihMAilU7w/KW91cGi27EaozAX7nPOKU2KwccFXC65k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LpwA6P02L6uCKl9YCU6VypgVdCUHtl04JyMoMXky02T56tQ0OPYK8HkzZEIu/1ZcJ4RClaoFA8/6BoJpB3+u8/3ijnb8HCPOyq678qTeF5ja2AP5vlCpllvEl2MEShMYU8eey7XQtW8n2yacoUF18ikyHsTlQoOBdVf2FHUibBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O0ZvM3gG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890Pra014221;
	Wed, 8 Oct 2025 09:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Aw+X2jFSH/ufI3pQZuNQzO/M5mLMO0FNTGMZWUNrxd0=; b=O0ZvM3gGaXY4WQtW
	JldznmklTYbEYEgS80STXTYsbYmvmw5pBNLDZqOaHxOMMXB1/5dwNvYHQnw1vdT5
	LiCp16lWIjDfvWYrxyTxM0RIURD71/yJcVS/sbGNcPe3sJRmerAL5UzkfQWU30WI
	8daC5pdt2KC/cGS3CZuKdGBT1fLxtJuwuCHGocfa7rOTtcZJKxE9DP2jgtc0rO0Z
	VeiGjFJA6EOm7ixRWC867hdOL3687ADIvt9HIlHCPL3Aej2jWvcn+eSlWP9v64Vk
	xzXWNxNTC3nNiFbt8IhjMNaP8cLjMt0RDp/fH38xDpJw2z5YjdKNwqNE64sYA3wV
	sq4eWA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49mgd0nm6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 09:04:39 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59894cUC010445
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Oct 2025 09:04:38 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Wed, 8 Oct 2025 02:04:34 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_varada@quicinc.com>, <quic_mdalam@quicinc.com>
Subject: [PATCH v2 1/9] spi: dt-bindings: spi-qpic-snand: Add IPQ5424 compatible
Date: Wed, 8 Oct 2025 14:34:05 +0530
Message-ID: <20251008090413.458791-2-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251008090413.458791-1-quic_mdalam@quicinc.com>
References: <20251008090413.458791-1-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: luth_KKOJsnbc_MhB9_5X0Kxwsn0uCGv
X-Authority-Analysis: v=2.4 cv=T8aBjvKQ c=1 sm=1 tr=0 ts=68e62927 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=3fGssgp5lnXtaUVRsVgA:9 a=TjNXssC_j7lpFel5tvFf:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: luth_KKOJsnbc_MhB9_5X0Kxwsn0uCGv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDEyMyBTYWx0ZWRfX0vA5U8jkcsLC
 lFXZMg1JOmc5rvGCsmomzyrUsknCvTrM5RzlFthlGv14QB5eJxVEwVecoqPOR42txetwaMt6h7E
 1tqDCzQOIrIkgLQHMGM6MEx4iVs9O/eLE1ZtALkOEreNXb0dEE4pQw4TrgC5TSSX1trBi3Et48g
 7vH9fzRA5147WuATWFxwGVkOkZANYZtdzEuehWCmdV0sQ/ZBbwXLp3xY1q3B/bZdMpdB7c+BOfR
 drBygnlG8jAoJz2gPzKXNzl0B7QahNN/SjW9vA1meSHjfUpKWz1FboSDGOHw2S6ATveUdfwB45n
 wQoBSsEFMyL+aNjdAeHtLDwitPUsFc2hyRQ4GCLFAWyG9QPYPrbkKXtZqnxE0+opWuFnFie1wiB
 J//OMI0k8ogEqEK3mMZt3DA5aQgrzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510060123

IPQ5424 contains the QPIC-SPI-NAND flash controller which is the same as
the one found in IPQ9574. So let's document the IPQ5424 compatible and
use IPQ9574 as the fallback.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v2]

* Added Acked-by tag

Change in [v1]

* Added support for qcom,ipq5424-snand compatible string to the device
  tree bindings.

 Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
index cb1f15224b45..39e086ced891 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
@@ -25,6 +25,7 @@ properties:
       - items:
           - enum:
               - qcom,ipq5018-snand
+              - qcom,ipq5424-snand
           - const: qcom,ipq9574-snand
       - const: qcom,ipq9574-snand
 
-- 
2.34.1


