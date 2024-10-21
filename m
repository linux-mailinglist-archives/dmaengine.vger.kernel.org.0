Return-Path: <dmaengine+bounces-3398-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D51F99A93DB
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2024 01:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811411F22E8A
	for <lists+dmaengine@lfdr.de>; Mon, 21 Oct 2024 23:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B4E200106;
	Mon, 21 Oct 2024 23:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Xo6QkeBa"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811E11FF7B3;
	Mon, 21 Oct 2024 23:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729551918; cv=none; b=Uusrlf8z8TA+1wUeLg6pFy/L6ufWmZKbUvZKZs6CwLDTaPpWI/M/vNVamVw0GAqKuzqFqwVS2rsbJDCHRpfZ8JZ5HfX6GTMaym9A3pZxknQ6k9Ph+9Po/oEZSd8b7b+5tIPcTsSCtEt0MjTAegvcFYakF3Q3gcIkcko5eed4/k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729551918; c=relaxed/simple;
	bh=Ry3WUN3LG5eL4oFmyCb0NZcrQ9pC4gCHRWQqqSrX224=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AvNcskxwqTZ2joax/XFDRPfJQzJ8f6WMnUaoG3K6Kt0lE7dSbAQ8/P1O049oqkWMwwEnffD53HmcRxdEnKhZ+nCwvIVfPumR7DxE8TK0GdKR6vM5zB5W7dS1Y8sgml3cDNxWug+K9r8CZNNWY4BMVr634Gw3JAL2U3R+70Z0jC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Xo6QkeBa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LKEq0C027437;
	Mon, 21 Oct 2024 23:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=W8tqoSpjt5HxO4OU4uTdGA
	RBsOukaeBY7gsBo99jR+0=; b=Xo6QkeBaxFc/OaQV4LSRKHvE6blP/vwX6cT8jQ
	qlsZRGAuXs3mRC4i2szYYwOBxw2p2siFsCkaD6wJN63G+CnErMk2Az7hx1DSsybn
	MTQq1gDrdyXoJ1uIiy67s21NGGT4XBYARwB7Dg8B7Blpt3CwpKXU8893ZZ9WBhi3
	opOwwniid7Q2e1PenOnfabFTyoJBVtWS42SWhOGB7ygUebT0zT4m4LEwHwqWWzNo
	46IUfUKgJrHyMZIzLNoJdgC1dhdenOjdmlVojzbLZKk34MdZlkUJGTG/9lrhW7ti
	uG5X+Ecu6NKsAkb6bT7VQRM2B+zR1aoCHy/ZVAHoLYd3iAYg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6vux8pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 23:05:13 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49LN5C2D010540
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 23:05:12 GMT
Received: from hu-molvera-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 21 Oct 2024 16:05:11 -0700
From: Melody Olvera <quic_molvera@quicinc.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Trilok
 Soni" <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala
	<quic_satyap@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Melody Olvera
	<quic_molvera@quicinc.com>
Subject: [PATCH] dt-bindings: dma: qcom,gpi: Document the sm8750 GPI DMA engine
Date: Mon, 21 Oct 2024 16:05:00 -0700
Message-ID: <20241021230500.2632527-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Lz8tv7s9WBYPmwbX5sjoBB261K7ag_Us
X-Proofpoint-GUID: Lz8tv7s9WBYPmwbX5sjoBB261K7ag_Us
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=892 bulkscore=0 spamscore=0 mlxscore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210163

Document the GPI DMA engine on the sm8750 platform.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 4df4e61895d2..637bf3456c7a 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -34,6 +34,7 @@ properties:
               - qcom,sm8450-gpi-dma
               - qcom,sm8550-gpi-dma
               - qcom,sm8650-gpi-dma
+              - qcom,sm8750-gpi-dma
               - qcom,x1e80100-gpi-dma
           - const: qcom,sm6350-gpi-dma
       - items:

base-commit: 63b3ff03d91ae8f875fe8747c781a521f78cde17
-- 
2.46.1


