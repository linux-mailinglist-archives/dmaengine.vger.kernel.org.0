Return-Path: <dmaengine+bounces-2363-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61306907BD2
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jun 2024 20:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7208E1C23F45
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jun 2024 18:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62F814AD22;
	Thu, 13 Jun 2024 18:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TWTylQ82"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7BD84A48;
	Thu, 13 Jun 2024 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718305042; cv=none; b=caHUItubC/ogHtFhSZN+JiNllO5icJKDZweX8HMhXnO7remb6T1F1VJB3LzYely9LMQPjgmhuSe/Y8X/7M8ZtDhvjUTCb4FuSc97HtMTASUcrp0mkUJBOt9qDrgfFAG0D6CjoKPsRN6E3gJFsJ0Vz4VsHF/4UHUKWpZ4AZB5Zpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718305042; c=relaxed/simple;
	bh=P+m1t5xHvMIr3fsmh88GE/n8OkuO/B9/k7oOyAh8rho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=epZP867SUKcn0RGYpsjyt5P8G3UjzxUi/jlHB+zFWJ7oiDrtF+3Xq/Qj3uWOj6oNjaoFV8Z0s2gDaOShcwY/pdLCZxK0QxINVCNOVyFnHO22Yw9pHE8wts0h1AxPLwLd+STGHjeY4sy9eO0vwuWG0bZS9xkeQYyi5Bkaa0dMVlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TWTylQ82; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DItMOb025340;
	Thu, 13 Jun 2024 18:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=viNaj7mF1w8XPWkPxnYdqR
	wOXEPjbFp19wKj6++NNc8=; b=TWTylQ8287387TU2hcOnqKISKdlZi2ggrPjvEF
	ZajMPQZVBGxWHzi8Jy+xtjAA13wfWTnUTfv3S6Oh6fwWImBTWDRZgyz0swJNq6rq
	bGQd/SKBdLSEVrVENtsxJqLAHOgpyuu/Zzt8ZlHqC8YmyArGdLseEUMZuPYvc+er
	pTsDizxYjHz1Ao+pMS1TkIXBE+KK5mlT9+bIu7NH2rbYsu2LlL95k1Utck6UmXgI
	rKyj7k/B8InHv2C1v6SPebr0BcHzo3vAHaxajh5ZqgTy4BT4btm80S+ti0jtyf1s
	kYRaz/+dDUYfDiHmSRBjI0jijmMgix9qUwixvt4rJYEoUfqA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yr6fc007w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 18:57:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45DIvGll001891
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 18:57:16 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 13 Jun
 2024 11:57:16 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 13 Jun 2024 11:57:14 -0700
Subject: [PATCH] dmaengine: fsl-dpaa2-qdma: add missing
 MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240613-md-arm64-drivers-dma-fsl-dpaa2-qdma-v1-1-815d148740e6@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAApBa2YC/x3NTQ6CQAxA4auQrm0y/GSiXsW4KExHmjAjtkhIC
 Hd3cPlt3tvBWIUN7tUOyquYvHNBfalgGCm/GCUUQ+Oazvm6xRSQNPkOg8rKahgSYbQJw0zU4Oc
 kX2NovWtvniOU0qwcZftfHs/inoyxV8rDeLYnyd8NE9nCCsfxA2JndWuUAAAA
To: Vinod Koul <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aqG4T4zqVCsGGekInVM5wzIzHXv-g2UY
X-Proofpoint-GUID: aqG4T4zqVCsGGekInVM5wzIzHXv-g2UY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_11,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=866
 priorityscore=1501 mlxscore=0 spamscore=0 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130135

With ARCH=arm64, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/fsl-dpaa2-qdma/dpdmai.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/dma/fsl-dpaa2-qdma/dpdmai.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/fsl-dpaa2-qdma/dpdmai.c b/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
index 36897b41ee7e..b4323d243d6d 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
+++ b/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
@@ -367,4 +367,5 @@ int dpdmai_get_tx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags,
 }
 EXPORT_SYMBOL_GPL(dpdmai_get_tx_queue);
 
+MODULE_DESCRIPTION("NXP DPAA2 QDMA driver");
 MODULE_LICENSE("GPL v2");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240613-md-arm64-drivers-dma-fsl-dpaa2-qdma-e8fd360396ef


