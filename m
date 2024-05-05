Return-Path: <dmaengine+bounces-1987-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A5C8BC338
	for <lists+dmaengine@lfdr.de>; Sun,  5 May 2024 21:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7F51F21009
	for <lists+dmaengine@lfdr.de>; Sun,  5 May 2024 19:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D66F6DCF5;
	Sun,  5 May 2024 19:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mD+RUxaM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BEE6D1B5;
	Sun,  5 May 2024 19:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714937564; cv=none; b=CtW5i/1p+06pjLb5nR3P6CexHLaMdnRqfU/RnoeHR2/Bd7WE55U7VSDM0AFTUcXC5R6aphQDNDW/qtzE8KjttTWnW17pgtiATXi/pR9k0hU6rI+vzwobJ5UsXKfjqazToPdtwq/h9ASCxKGrj3avhS48tP4tPlM2Die2gQD+3Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714937564; c=relaxed/simple;
	bh=Lpq+LX5JLZxxETWe0FBuP2CqguytIjkBt1vjtoYQDZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=b/KsE3GWRftUyTH8nTiZk10/tPl1Q9TysMvL+Y/V3kM5lB3ZVuhnlwiI035qUVBDLdkmC9TY+3ztoOCgqzD4XmO8SYe6bW5/8TGFxD9vWy3y8xS9vQqJzn4077330KSq4BiZghgsVYUAc1PzBsVw225iKk9KGo7A/mQXS3pyqi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mD+RUxaM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 445JWE5R017354;
	Sun, 5 May 2024 19:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=Ljt
	1/ZyWs9w6kIyMNglv/210K3hZUYkvO9vHBc3CBwA=; b=mD+RUxaMhBXZa0khXc2
	iwcv6iHldsu8i0CQB2ILq11Yk/n/hsM5VZvls8KXp5P/jhZ4QaKclxwYdrpmNSU8
	CR4BPbO/5YRhMkRk8HY28F0A8l9YNd5pTFtnf+zlbJDvFD0ZqqqNp8WRV1H7UIbY
	wSHBJ1KlsqbqGG/bcCgX6eSjbrxvC0codB2xN4vFp91iFKVUe7mAaFtncBw2YiFH
	CgXGkmDOt8Fh3n6IK3BYYnVTeaS6Uu1jPuweOPS1zJNp3BTko1zz9TlwtOKiemGQ
	vZN/6kz7WaYIlGtxIqzV9J05nJaUgpGvWKXS920CLtE/jHL4+dOdZ06QJasli2mF
	/3Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xwcbpj47b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 May 2024 19:32:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 445JWDcH021687
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 5 May 2024 19:32:13 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 5 May 2024
 12:32:12 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sun, 5 May 2024 12:32:12 -0700
Subject: [PATCH] dmaengine: xilinx: xdma: fix struct xdma_chan kernel-doc
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240505-xdma_chan-kdoc-v1-1-18cefca3f168@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALveN2YC/x3M0QrCMAyF4VcZuTZQ44bDVxGRtM1ckHWSiAzG3
 n2dlx+H86/gYioOt2YFk5+6zqXifGogjVxegpqrgQK1oQsdLnni5zHhO88J49ATX3q6ZmKop4/
 JoMs/eH9UR3bBaFzSeGQm9q8YbNsOrN9HaXkAAAA=
To: Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
        "Raj Kumar
 Rampelli" <raj.kumar.rampelli@amd.com>,
        Vinod Koul <vkoul@kernel.org>, "Michal Simek" <michal.simek@amd.com>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: f-anGE996OxrQQ3cImWDGjGMf8vKpESt
X-Proofpoint-GUID: f-anGE996OxrQQ3cImWDGjGMf8vKpESt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-05_13,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 mlxlogscore=606 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405050083

make C=1 reports:

warning: Function parameter or struct member 'last_interrupt' not described in 'xdma_chan'
warning: Function parameter or struct member 'stop_requested' not described in 'xdma_chan'

So add missing documentation for these members.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/dma/xilinx/xdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 313b217388fe..43488678ef9e 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -61,6 +61,8 @@ struct xdma_desc_block {
  * @dir: Transferring direction of the channel
  * @cfg: Transferring config of the channel
  * @irq: IRQ assigned to the channel
+ * @last_interrupt: Completion variable to signal the last interrupt
+ * @stop_requested: Stop Requested flag of the channel
  */
 struct xdma_chan {
 	struct virt_dma_chan		vchan;

---
base-commit: 2c4d8e19cf060744a9db466ffbaea13ab37f25ca
change-id: 20240505-xdma_chan-kdoc-bf82a3827d2a


