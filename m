Return-Path: <dmaengine+bounces-2789-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F9F946834
	for <lists+dmaengine@lfdr.de>; Sat,  3 Aug 2024 08:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E952B2139B
	for <lists+dmaengine@lfdr.de>; Sat,  3 Aug 2024 06:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A705136350;
	Sat,  3 Aug 2024 06:34:21 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1E114C5BA
	for <dmaengine@vger.kernel.org>; Sat,  3 Aug 2024 06:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722666861; cv=none; b=OppocR/mlFwxxUBs/Hijjfor+xu2tfM9q0cklQHhthaHlLjb91xGjwAFhQEfFOqlGs/5S7OfHonpG8xVMKIaelZDsCE2nZV1GJmckjNyynbdoPCKsxu7EkNk2LA9V6BvJ20bmo7aaRsMv/v/dYcLSlvdXhSDLFaSWqYSdEqgQEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722666861; c=relaxed/simple;
	bh=nqq4TEed36d1+641wuL3zHGkaQsEzAVNc3ndJnLLcMA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VU2AYbywXGzsGRUxLj2AR3mCg0yM9RKeH5KrEYr7vjm1ZDS/92GDe7zIagouHRqXTi77pX91OlIhhdQ3fI/3nBtBO8Zo+2e7ajtZYIMlnkauFK1EhqoaC9REKLGrvVXf7KHZvSRD5mnfA8c9yYnD5PyF7szcfha82L816w4KApA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WbXvX3G9SzndJp;
	Sat,  3 Aug 2024 14:33:12 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id 363251800A4;
	Sat,  3 Aug 2024 14:34:16 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sat, 3 Aug 2024 14:34:15 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <Eugeniy.Paltsev@synopsys.com>, <vkoul@kernel.org>,
	<cuigaosheng1@huawei.com>
CC: <dmaengine@vger.kernel.org>
Subject: [PATCH -next] dmaengine: dw-axi-dmac: Add missing clk_disable_unprepare in axi_dma_resume
Date: Sat, 3 Aug 2024 14:34:15 +0800
Message-ID: <20240803063415.319565-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200011.china.huawei.com (7.221.188.251)

Add the missing clk_disable_unprepare() before return in
axi_dma_resume().

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index fffafa86d964..8bada153bfed 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1334,8 +1334,10 @@ static int axi_dma_resume(struct axi_dma_chip *chip)
 		return ret;
 
 	ret = clk_prepare_enable(chip->core_clk);
-	if (ret < 0)
+	if (ret < 0) {
+		clk_disable_unprepare(chip->cfgr_clk);
 		return ret;
+	}
 
 	axi_dma_enable(chip);
 	axi_dma_irq_enable(chip);
-- 
2.25.1


