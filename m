Return-Path: <dmaengine+bounces-1073-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FF385FBFE
	for <lists+dmaengine@lfdr.de>; Thu, 22 Feb 2024 16:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5CED1C24295
	for <lists+dmaengine@lfdr.de>; Thu, 22 Feb 2024 15:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5711614A08E;
	Thu, 22 Feb 2024 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="LJR0UJm2"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A65134CDC
	for <dmaengine@vger.kernel.org>; Thu, 22 Feb 2024 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614787; cv=none; b=jeAHK7rXfDhMyeuaNu25BpZQ/c/MMLi1v3KyreKnaQqbYmVby+C3Yqf67iardDimNF6hB0eEYFRTvnPVDgXUoveDbyXEnyPhuZQzFEUQb24JN8Lu/WPSvRR9jtFKMUvZAeGqEJe01vB9GXceP+3yrbDW00qYXO9tcjwxBeHkgFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614787; c=relaxed/simple;
	bh=IqaZTUrMX2tYCpSL8GczWZo+4JMHB0T0+RhmFbYahpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cXihHFYntiPHuOLsRfqJGDrFGLQof1U1nqlu4p90ffY7lwc4o50aUd/x79hVitBCL8UiNN7BW1/MO+IRjLoUTAoeihZiP4TPzjIjlgJSUjt9KD2chrFEodsgVTRRu25mH7Sum9DuT4+hWw40l5/LtG9H6jvEblr9to23nhm1A6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=LJR0UJm2; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MExCXe031451;
	Thu, 22 Feb 2024 10:12:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=gXoMmKoTg5SHhvcph0HrcxlwYVfwpuLgRQ1ZnXR/Txc=; b=
	LJR0UJm2uHMUXPdiCJxjh0P1ZnmA+YXox93Ai7bTuiZ3RFYz1D2Wg+cQTL7mBjDd
	xWaDI5SiLvmXN9rleD6oBHbfDTbVA0Iu7CEY5/VtzgiGzEknvQtQ+vmJHq5s3CXU
	va06hzpq/lMyixTHr+lfOZgqmWaXrf29VI75XK8QaGGlhmCtGb/PJgRh/6zCx4eE
	4gKMtqOVJmpbtWZWoljGpxlQSx1HrlCXrREM2hfaAj+C/zVHp4TGb16kc7hTphjP
	fKVXEDah1FGb0KL+fU0iSDs+1bu4BWRNTrPaFpwfa7bXV7n2wMwx0Wf0yBXkSkJ9
	fDbPbA31lexc0/z39Dm8Sg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3we8gu82as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 10:12:52 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 41MFCpBh060154
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 10:12:51 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 22 Feb
 2024 10:12:50 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 22 Feb 2024 10:12:50 -0500
Received: from [127.0.0.1] ([10.44.3.55])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41MFCe41017151;
	Thu, 22 Feb 2024 10:12:45 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 22 Feb 2024 16:15:50 +0100
Subject: [PATCH v3 1/2] dmaengine: axi-dmac: fix possible race in remove()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-axi-dmac-devm-probe-v3-1-16bdca9e64d6@analog.com>
References: <20240222-axi-dmac-devm-probe-v3-0-16bdca9e64d6@analog.com>
In-Reply-To: <20240222-axi-dmac-devm-probe-v3-0-16bdca9e64d6@analog.com>
To: <dmaengine@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>,
        <stable@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708614963; l=1011;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=IqaZTUrMX2tYCpSL8GczWZo+4JMHB0T0+RhmFbYahpk=;
 b=gJq1v1Ro8TB9vllxWSv+WhWRR7nLp9zWGAHor0y76/FkVMv6hUdmpKBcnWVWPBIay1TKwwOvC
 9tzv7qrbD2eDHMkk5drC/58s/Z+ql/vnIDArkIgWDQrjv6pkl6EOoYv
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 7NIX9JzkJ4RPlqcu2G4K6SXABQsx5Gcu
X-Proofpoint-GUID: 7NIX9JzkJ4RPlqcu2G4K6SXABQsx5Gcu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_11,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=608 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220121

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
2.43.2


