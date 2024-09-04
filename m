Return-Path: <dmaengine+bounces-3068-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F29C96ADFF
	for <lists+dmaengine@lfdr.de>; Wed,  4 Sep 2024 03:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFBAB2867AB
	for <lists+dmaengine@lfdr.de>; Wed,  4 Sep 2024 01:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FA58479;
	Wed,  4 Sep 2024 01:39:37 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA888F9D6;
	Wed,  4 Sep 2024 01:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725413977; cv=none; b=LFADtbbtARMohx1oK+GhDbs/6+aMCd96lopbJJGbbEcWB+xl9btwMpIfUKgBpme4ry31FDu15vGmRT1nakzWddobanBvhYCaQp0uA0iL4l5BQeog/IPiCRVWiJxQOz4YivlkZDKFsmumLtaZUMKo4lNIyD4crHr7l7EPL++o840=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725413977; c=relaxed/simple;
	bh=Vl2Jueui8WuuV+afnam8Z9S1LDufVv4JxtLtkZA8wBc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oFkE/iltL156QF8xn45p3GDH0oIvLqHjqNo6nbhozq7RS3bFat4FmNs+cnb+M76zyn2kGMb1Fy3FP3fKtr7Hr08vpTUMN+2HuO6VM/YY5cZsUG11S1kzV3YcmZynUdXvjgL54h7xSg+lUnw+/P3Cq/MwIU88xl8CdhVtq3AWrRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Wz4rp3GPVz1P7qM;
	Wed,  4 Sep 2024 09:38:34 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 344F71800A0;
	Wed,  4 Sep 2024 09:39:31 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 4 Sep
 2024 09:39:30 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <keguang.zhang@gmail.com>, <vkoul@kernel.org>, <kees@kernel.org>,
	<gustavoars@kernel.org>
CC: <linux-mips@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH -next] dmaengine: Loongson1: Annotate struct ls1x_dma_chan with __counted_by()
Date: Wed, 4 Sep 2024 09:48:03 +0800
Message-ID: <20240904014803.2034939-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Add the __counted_by compiler attribute to the flexible array member
entries to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 drivers/dma/loongson1-apb-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/loongson1-apb-dma.c b/drivers/dma/loongson1-apb-dma.c
index ca43c67a8203..be0dbda84dd2 100644
--- a/drivers/dma/loongson1-apb-dma.c
+++ b/drivers/dma/loongson1-apb-dma.c
@@ -78,7 +78,7 @@ struct ls1x_dma_chan {
 struct ls1x_dma {
 	struct dma_device ddev;
 	unsigned int nr_chans;
-	struct ls1x_dma_chan chan[];
+	struct ls1x_dma_chan chan[] __counted_by(nr_chans);
 };
 
 static irqreturn_t ls1x_dma_irq_handler(int irq, void *data);
-- 
2.34.1


