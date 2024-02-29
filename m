Return-Path: <dmaengine+bounces-1200-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2487286CF28
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 17:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E2D6B2B0DD
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 16:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9487829F;
	Thu, 29 Feb 2024 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FUr5V/iP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F057A131
	for <dmaengine@vger.kernel.org>; Thu, 29 Feb 2024 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223646; cv=none; b=RI/Ys+fFOADq6tZydXxJ9ZjuFn8QHiZYOhXajnrijM0Ti9tnCfkEdLfycqg+AhfXbZFT0DAfcabYTepfI0P77f38QBjIoRZpxqUvHJu+Xj9bHpkZTvy0hhV3SBle1fnoc09M+gPydsgC6ZjcHbf+yjTZJqejD3F+gJ5pAO2y63E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223646; c=relaxed/simple;
	bh=RwGYh78S1JORZNVlFUHaMay3ZOZvYL5wWjKog0nr+/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Xc/u/oO+aTfy8NmPh3RXTEGO0liOuCXYYpkfcI8WcoTM0t3qLW3MHlZOTPRMpkN9EeA9bzdD4qdqLsPaUNXQI+hgGPBkCLdbzWmpJLJQw036nJ1y6ewl2565PTGRJG+jWwAzS7PhuU60U0dgw0XyvMgSwWwBR4iRTncbNh7yr9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FUr5V/iP; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41TF6f99013749;
	Thu, 29 Feb 2024 11:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=9x/uc9BrjafhgeMO8bED2sAzXo5uqApxqvOT+nDh868=; b=
	FUr5V/iPyNFS8O+s+mGrKHiCL1BPNzp2ScYetSZXi0upG9d+cRuEYwCPZlWd7nNk
	ha+pCA7SoMkhGk3/pQEZpM0MF2HBFYBaqInaLPbjcp8hu80xyj/WyNcyQpVefXBp
	hZNg1aQiaRgeU3Y7N8J/2gprGbJ+GD2yNjHbXwrR9tgEVXP2G7fWdoTqxLZWpuoZ
	FmtpK5Ja41uhbwQh21dID/8En+aEdUPV08ZEE60f31FfA2cd2hz1La3kYQEKqEyc
	P99CCAAT+sxzXadjBoGzUC9VcRXmSjbqgSXJ4Rnx++HDYUFCuLtL7nLLEfifR23x
	GClHApgWSBfn1eb71xs6bQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3whyvepvux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 11:20:28 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 41TGKRRs026500
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Feb 2024 11:20:27 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 29 Feb
 2024 11:20:26 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 29 Feb 2024 11:20:26 -0500
Received: from [127.0.0.1] ([10.44.3.58])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41TGKHwa019308;
	Thu, 29 Feb 2024 11:20:22 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 29 Feb 2024 17:23:16 +0100
Subject: [PATCH RESEND v3 1/2] dmaengine: axi-dmac: fix possible race in
 remove()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240229-axi-dmac-devm-probe-v3-1-f0e78d2ab5b1@analog.com>
References: <20240229-axi-dmac-devm-probe-v3-0-f0e78d2ab5b1@analog.com>
In-Reply-To: <20240229-axi-dmac-devm-probe-v3-0-f0e78d2ab5b1@analog.com>
To: <dmaengine@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>,
        <stable@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709223821; l=1011;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=RwGYh78S1JORZNVlFUHaMay3ZOZvYL5wWjKog0nr+/Y=;
 b=sZ0Pvbp5SqfgCTloY5jAJErKWbk9i5fxzU5ngx7NwmgRx1RnDytT2V8v9UV+CUugToznZcU6c
 BdGz8LDN+g+B3aq4bm1Vfw46V888VdzNSfqyiZYU1xej01P9VQ0Lqhv
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: YEZEYxk2ueq46tFURAy7pf5-oa7Nx9TP
X-Proofpoint-GUID: YEZEYxk2ueq46tFURAy7pf5-oa7Nx9TP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=611 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290125

We need to first free the IRQ before calling of_dma_controller_free().
Otherwise we could get an interrupt and schedule a tasklet while
removing the DMA controller.

Fixes: 0e3b67b348b8 ("dmaengine: Add support for the Analog Devices AXI-DMAC DMA controller")
Cc: <stable@kernel.org>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 4e339c04fc1e..d5a33e4a91b1 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -1134,8 +1134,8 @@ static void axi_dmac_remove(struct platform_device *pdev)
 {
 	struct axi_dmac *dmac = platform_get_drvdata(pdev);
 
-	of_dma_controller_free(pdev->dev.of_node);
 	free_irq(dmac->irq, dmac);
+	of_dma_controller_free(pdev->dev.of_node);
 	tasklet_kill(&dmac->chan.vchan.task);
 	dma_async_device_unregister(&dmac->dma_dev);
 	clk_disable_unprepare(dmac->clk);

-- 
2.44.0


