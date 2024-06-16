Return-Path: <dmaengine+bounces-2375-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A61B909BAF
	for <lists+dmaengine@lfdr.de>; Sun, 16 Jun 2024 07:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4183C1F21D9B
	for <lists+dmaengine@lfdr.de>; Sun, 16 Jun 2024 05:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E3816D320;
	Sun, 16 Jun 2024 05:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SnfWZONA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F90C23AD;
	Sun, 16 Jun 2024 05:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718517121; cv=none; b=pR9D2koAqgOQpQbM1AjMBPsmgrnxUpHaGiKthz2/H2o52CAQRyeEB5XeqOuagIfuXaRwCc92/qDE2Bt1aRz55F7qY1Y9ImYVw8hvNXSApiXkJycjUBfkceVGNkcHIXRaEc+V4TdKmgLGaL6UK8RjXBderC3JzF9C1M/9Oh635EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718517121; c=relaxed/simple;
	bh=tgPYjaOy/t8azEBBTtBOffPw33kLkd81jhdAKpFm3eM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=RTZS1QGh1Bu1S7yNyLwCQm19Pm7ht9awXGLthUWUk7WQYt0QtCP0cGRgXpczGwjlV3egNjJp9tHyMt5WuvlYlYXKpl8VE1lo+kklobQq+wwKfePBKRzKqVVTvsQctvPVg7mG3vrmT3GZJ6zGu1xENOuiaS+Bl0qkqdoYy3YWIUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SnfWZONA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45G5AswJ017667;
	Sun, 16 Jun 2024 05:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=k7ZYZqagKVT+JHt+zQLq+d
	0cEw1/YGUvebGeSj+aHW0=; b=SnfWZONAMolwNEnVpm0We/Q6KJFwdfVcCq/MmK
	wnJRrMraWlr7BT57MDlahtltsNoFvneXYtJ978guN2we2fumHyt73+xJU/9vHVqj
	2h26lPd+Fj3a9gq9dpVEc+O+WvlrXUC0YFU/51EZrJnGm7nhEXC44V+hxGAmZPde
	HdkeXtPEE2OtdmQ+0C9Sk11XWfhUjCuPHPYAYzf4f+YDG7eyStHH82f2Dix4kxuu
	NenxsBE8YsCKIz0vBRfhqRU3y0869gX/vAui/RG/kBpqRN8vZ/p17q8xBfnKwwIE
	65M5GP5hZxjhfFASM5/CfHJtXi3gLWcDRT8rFh+gbMHequXA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys0nf9p26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Jun 2024 05:51:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45G5pofk008921
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Jun 2024 05:51:50 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 15 Jun
 2024 22:51:49 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 15 Jun 2024 22:51:47 -0700
Subject: [PATCH] dmaengine: ti: cppi41: add missing MODULE_DESCRIPTION()
 macro
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240615-md-arm-drivers-dma-ti-v1-1-496d243158dd@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAHJ9bmYC/x3MTQrCMBBA4auUWTuQBK0/V5EuJsnUDpgoM7UUS
 u9udPkt3tvAWIUNbt0GyouYvGqDP3SQJqoPRsnNEFw4ut6fsGQkLZhVFlbDXAhnQX/249WF0Md
 0gda+lUdZ/9/70BzJGKNSTdPv9pT6WbGQzayw719AERjYhgAAAA==
To: Vinod Koul <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JJ1I2_tG6ltFlLCoFQjpp-Vgt65vCaXk
X-Proofpoint-ORIG-GUID: JJ1I2_tG6ltFlLCoFQjpp-Vgt65vCaXk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-16_04,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406160044

With ARCH=arm, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/ti/cppi41.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/dma/ti/cppi41.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/ti/cppi41.c b/drivers/dma/ti/cppi41.c
index 7e0b06b5dff0..a8bb70c2d109 100644
--- a/drivers/dma/ti/cppi41.c
+++ b/drivers/dma/ti/cppi41.c
@@ -1252,5 +1252,6 @@ static struct platform_driver cpp41_dma_driver = {
 };
 
 module_platform_driver(cpp41_dma_driver);
+MODULE_DESCRIPTION("Texas Instruments CPPI 4.1 DMA support");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Sebastian Andrzej Siewior <bigeasy@linutronix.de>");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240615-md-arm-drivers-dma-ti-171f90226bc8


