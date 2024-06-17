Return-Path: <dmaengine+bounces-2376-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C9390A104
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 02:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79FE21C20D3C
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 00:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF55623B1;
	Mon, 17 Jun 2024 00:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pYPWEmHR"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271F51FDA;
	Mon, 17 Jun 2024 00:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718585927; cv=none; b=VT+bq8/tfQ2yFKdcj+cr9Y+AIABApxxFQHtMPpPM7QIqZkOQqCLB01YcDy1v6hUJsw/kwwx7uMJcFW7GU5JI4YxP3TVdMfLMcu77g90XzBbhFYEfjwP8wYzP5pQ3sBpkCH7OCJT1caIVc2ne4b1BezmKj7dglFHcBFG4y/oZs+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718585927; c=relaxed/simple;
	bh=djTxp1Ej1KaNJ/XiqjjyP38jAsXNqHvO4Bq+AD+sey8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Vm4RFIzNWn1KQV+NZZSIBiWOxwmUyYAF2SK/OWFocHJxYOikBhB3ueVh/3PqGvOcd/O5su/2aUwaEvmi6RGyWwsMVDHHjinc+bTLkLm5o3PKbZh3lhj7dAMPj6C6iYLQHyF56xIS3/cfajnusqypLD2GDpjGHDNupnpUmD78czI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pYPWEmHR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45H0QXom003923;
	Mon, 17 Jun 2024 00:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=JvyRp8B6jzZGU+jg5kkTTH
	ULwuSJCVLpqAXz7xIAq/w=; b=pYPWEmHRSNEIFfJ/DjB3HmRFGZMUza7iB8dY4H
	mfv7XMBLugqHKPDtOcqlL74IIECKrZlzvrhC9n/bEWRnrVuzXZeRdEcOdoDtYHE3
	RMl2KGSDkWVRoJ9Too4pXO4Z/Jvilb6aEZK/9QsFonscyO229S7QP2Nl2fZWL8eL
	neGLKRUK6duLC1B/womt+qKkK2mD128sX/DQNn2ouWHNL4a1fJPgbK27DGvFjnRf
	J8osQrxIWZUB73nKVGuxj8wKbqEMVqbbR9+GZV7I10Wcmgb9W7hXN9YDPmFaTcdI
	XVljYNFa0UEpRHG5n57a9GwMY8Zd8pwyeTzhtF6S3rYIXj1A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys3qf2cqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 00:58:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45H0waC9026911
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 00:58:36 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 16 Jun
 2024 17:58:35 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sun, 16 Jun 2024 17:58:33 -0700
Subject: [PATCH] dmaengine: virt-dma: add missing MODULE_DESCRIPTION()
 macro
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240616-md-loongarch-drivers-dma-virt-dma-v1-1-70ed3dcbf8aa@quicinc.com>
X-B4-Tracking: v=1; b=H4sIADiKb2YC/x3NQQrCMBCF4auUWTuQ1lDFq4iLSTM2A00ikxoKp
 Xc3dve+zf92KKzCBR7dDspViuTU0F86mAKlmVF8MwxmsGbsR4wel5zTTDoF9CqVtaCPhFV0PYd
 1xt5Gf/dkr9A6H+W3bOfH89XsqDA6pTSFf3mR9N0wUllZ4Th+iGShXZIAAAA=
To: Vinod Koul <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: W91mFGmpUd3La5QX-k6JHEdvkzw48PWM
X-Proofpoint-ORIG-GUID: W91mFGmpUd3La5QX-k6JHEdvkzw48PWM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-16_12,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170006

With ARCH=loongarch, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/virt-dma.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/dma/virt-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
index a6f4265be0c9..7961172a780d 100644
--- a/drivers/dma/virt-dma.c
+++ b/drivers/dma/virt-dma.c
@@ -139,4 +139,5 @@ void vchan_init(struct virt_dma_chan *vc, struct dma_device *dmadev)
 EXPORT_SYMBOL_GPL(vchan_init);
 
 MODULE_AUTHOR("Russell King");
+MODULE_DESCRIPTION("Virtual DMA channel support for DMAengine");
 MODULE_LICENSE("GPL");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240616-md-loongarch-drivers-dma-virt-dma-4b0476d8da43


