Return-Path: <dmaengine+bounces-3618-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A989B250C
	for <lists+dmaengine@lfdr.de>; Mon, 28 Oct 2024 07:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E9381F218CE
	for <lists+dmaengine@lfdr.de>; Mon, 28 Oct 2024 06:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6607D18DF83;
	Mon, 28 Oct 2024 06:06:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C450D18EFD2
	for <dmaengine@vger.kernel.org>; Mon, 28 Oct 2024 06:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730095604; cv=none; b=d4VFnaus0hW4Jx8IsZBbuDVJPVBsem+E+ZQPXmqiDB3QK3hSuxo5tTBIq1g0I2g10DsSm3gcQkZE2GY2a53xW+zwijBXStSJJOOfjtlaZgaw9xbfaQqjgByDeAtIxAEcWtn7xsPyiEg2VRMa8JPjM+PRhUznZPO9Pr69CjfeWt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730095604; c=relaxed/simple;
	bh=hjbmCVEgdYw13utb3ARrRH//Pq802INSHmN0uYbN4Cw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gOhfvhDjpvbVePGDgEck/teQldxFksmggn/ujZNWt6qVYQha8Ti3JOQEBCDF0P9I4rbeJAQp305QrkeqR8zzNjWU1Xo2jirkNohWrs0ReV5C7oIzx4W5YeGXYfAWIMm0qOU2uptTDLaT49huFhOjgUyAT3uzZxCp50e0Y5j07U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XcNCR0zxwz1jw1s;
	Mon, 28 Oct 2024 14:05:07 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 4333314022D;
	Mon, 28 Oct 2024 14:06:36 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 28 Oct
 2024 14:06:35 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>,
	<grygorii.strashko@ti.com>, <dmaengine@vger.kernel.org>
CC: <chenjun102@huawei.com>, <liuyongqiang13@huawei.com>,
	<zhangzekun11@huawei.com>
Subject: [PATCH] engine: ti: Fix potential NULL pointer dereference
Date: Mon, 28 Oct 2024 14:01:40 +0800
Message-ID: <20241028060140.5232-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf500003.china.huawei.com (7.202.181.241)

devm_kasprintf() could failed and return a NULL pointer, which
will then be used in the later code. Add check to prevent the potential
NULL pointer dereference.

Fixes: 25dcb5dd7b7c ("dmaengine: ti: New driver for K3 UDMA")
Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/dma/ti/k3-udma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 406ee199c2ac..fdaea8f72a9c 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -5534,6 +5534,8 @@ static int udma_probe(struct platform_device *pdev)
 		uc->config.dir = DMA_MEM_TO_MEM;
 		uc->name = devm_kasprintf(dev, GFP_KERNEL, "%s chan%d",
 					  dev_name(dev), i);
+		if (!uc->name)
+			return -ENOMEM;
 
 		vchan_init(&uc->vc, &ud->ddev);
 		/* Use custom vchan completion handling */
-- 
2.17.1


