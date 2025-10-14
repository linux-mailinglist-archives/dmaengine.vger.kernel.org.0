Return-Path: <dmaengine+bounces-6834-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ED3BD8E37
	for <lists+dmaengine@lfdr.de>; Tue, 14 Oct 2025 13:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CB6D4ECCF3
	for <lists+dmaengine@lfdr.de>; Tue, 14 Oct 2025 11:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6FD2F60BC;
	Tue, 14 Oct 2025 11:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O90fveBO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E413A303A35;
	Tue, 14 Oct 2025 11:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760439966; cv=none; b=ZOSKhdLP1lXenZgbp04smrHHO0o6VFitPTQo67k9LjY5Y1Bep828cdhnQ6CHybx5IYVl2S6FPv0rSodsCNC5POgxHqgpnXUIVNo7WcT2vfF9ORIQMAa3bkTyFd+ozRBozyEciPbcuYTw02mN3evP7DGraGfhlA3Yk6ams80iCQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760439966; c=relaxed/simple;
	bh=2dz4+yoSw7RiBm2jIsukiBFnwMjyFScT81Za4eyHfg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tOTvI8T2TJpToYbNH1GzYAkRkXcCBi8e/m3gWP76ZFH9bb1iSosmPJWFpDs0G9MKGoZcRXX1pusRQPVXlTd9s1tcOwA9mCoq4PcKn7Y/GUJVKPAES+deIZ2RwB5WjuSXZuLq69WPCrJQwd2ZriZ3a60UX8CpVlSho9QfKVookYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O90fveBO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87KPo020009;
	Tue, 14 Oct 2025 11:06:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KYNVQPiYJz8GRiP3j8OcVBYp+11c3E61BnVOwzr42Bo=; b=O90fveBOl/YhUMfh
	sffdXmHjOy1tUlVA9P0JJ6Fp0AUBBFuRhzvXIURV5NEV4lamsitR1VhcbM+F0/Nq
	GVeieWHzD5lEI4qy4bQzMKXkjACpBu/wdJV2hmJ/0g+8UmqY7IviOtowNwPPVu7o
	xdbaGOLkhoFO/GwMEdvdSeM2x3q2UeFUgM7+hXByJRDOvr2WK00wMz3AlIpYdIBs
	9YT8VgXleH/sdjQ4KL09iI4UuBbIMV5ujLC+CLBmDv7zAAPl688DH5SYUhU1Qnd7
	HXpedtiC7+C1ACbr1mT9VmZbDdJWOEVEPHliD8tglPs7cVMZfoIcYXCjSOV7xJ2X
	xmfdxg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qg0c05ka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 11:06:00 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59EB60cA032245
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 11:06:00 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Tue, 14 Oct 2025 04:05:55 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_varada@quicinc.com>, <quic_mdalam@quicinc.com>
Subject: [PATCH v3 1/9] spi: dt-bindings: spi-qpic-snand: Add IPQ5424 compatible
Date: Tue, 14 Oct 2025 16:35:26 +0530
Message-ID: <20251014110534.480518-2-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014110534.480518-1-quic_mdalam@quicinc.com>
References: <20251014110534.480518-1-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: CBJw_NZETIVqnTO-Db3zuSzjG1kekCZh
X-Proofpoint-ORIG-GUID: CBJw_NZETIVqnTO-Db3zuSzjG1kekCZh
X-Authority-Analysis: v=2.4 cv=eaIwvrEH c=1 sm=1 tr=0 ts=68ee2e98 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=3fGssgp5lnXtaUVRsVgA:9
 a=TjNXssC_j7lpFel5tvFf:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMiBTYWx0ZWRfXw4hxxv22hvXd
 nvHD6CJlVEN+NHErzevlRHlyv2bsSTiEcCFYHjdBVN6zmDhV5gxEo4B4SrIDA9Pd5Y8DC43ii2n
 30IqBUsGBOnb+xKZdCT/c2teaGx8zH54H65kYQMNEGB+Sqb3WBEPI0aMomzMNCsyEMblQg+jz59
 pu8g19XgaHdErw0WFM7oOXuIc8MZo5A0sK8CdbOzI2ytSaXqRq0xsvLbQDU5mUqxi4HMi2gX2xg
 7NB3WSfJCH1apWm/zges5kZQowCu6W+JrYsEb0PknloFFj0Z+VBLKdnVmpIZoTV+b2BgxXsRmo4
 SnSV2zeO4Z0qSh7yS+LpbKkRDzuU/7hbXNbOWeZ+9MVre/pggLiV4GljGnSrGybgUhSTLqpUUaf
 qmhljfY86J47H5Qc+9OMUXtjnD3rgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110022

IPQ5424 contains the QPIC-SPI-NAND flash controller which is the same as
the one found in IPQ9574. So let's document the IPQ5424 compatible and
use IPQ9574 as the fallback.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v3]

* No Change

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


