Return-Path: <dmaengine+bounces-3377-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9049C9A0406
	for <lists+dmaengine@lfdr.de>; Wed, 16 Oct 2024 10:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5293628179E
	for <lists+dmaengine@lfdr.de>; Wed, 16 Oct 2024 08:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FAB1D1F7B;
	Wed, 16 Oct 2024 08:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PeZO7kSb"
X-Original-To: dmaengine@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22F018B473;
	Wed, 16 Oct 2024 08:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066691; cv=none; b=q53zOX/Z5fxj4q8Gbuatj7Daahtw09qxwGLlseNFL75jGcWEpfZSbBq8n6G8t9dOuFrOU305QEkjPFKkvKc+eyZbPjAMJx1Tb4JNjvES0b8mE4LhgbJd5lcJRij4QQgaFVzDuDisBnUJKwSMJ+JciqmlvOx37hkt9Jwu1vVbDb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066691; c=relaxed/simple;
	bh=xI48V4uaf7WNRnRroeQxnAc8CSneyiagKYO7a9v3N6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RhVqNIR5TG0FJMswdfSK1zbMgVMUbvLl9UpffZMKlm3jVL4qjdoez2CFCB78SmyWFrhGuQf0+wF/YMxjuXgLAzJxl38Q7iKOfKVL0LSoD66dACCmSVyVS5BNQE84xgU3lqz61QFIRc/Cm8NZRtBw22FdqKkEC6zfaHppL05DYDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PeZO7kSb; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=eBbmj
	21XgonUcOT4wp+Yah0im4baIQBv4z8A+lspO1s=; b=PeZO7kSb90vG5FgSA0sF/
	QhMCxXYjnk4MP2atpGco6ofvlnYStjK4D2KWJX/Hb/0dyrE7jCQB+JhU5hYzk3Xx
	Wa1N48iOniWYiTfIIbGxafCGyLtvacrc/uyG8b71bhfNQgYZTGd+OCEeqboMxljf
	VlV1GS0V/1s/rtZGaXbKe8=
Received: from tcy.localdomain (unknown [120.136.174.178])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3H4+Ydg9nyVWiBQ--.45712S2;
	Wed, 16 Oct 2024 16:17:33 +0800 (CST)
From: ChunyouTang <tangchunyou@163.com>
To: manivannan.sadhasivam@linaro.org,
	fancer.lancer@gmail.com,
	vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tangchunyou@163.com
Subject: [PATCH] dma/dw-edma: chip regs base should add the offset
Date: Wed, 16 Oct 2024 16:17:25 +0800
Message-Id: <20241016081725.4810-1-tangchunyou@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H4+Ydg9nyVWiBQ--.45712S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrW3trykKrW7Wr1DCFW5GFg_yoWfuFb_C3
	s8XrWxWrZ8tFnxCF9rCrs8Zr9xuwn7Zr4xuF1UtF9Fqr45XFn09r48Zrn7Zr1jgw17GF9x
	AFs8Zr48Zr4UKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRAcTm3UUUUU==
X-CM-SenderInfo: 5wdqwu5kxq50rx6rljoofrz/1tbiYwl6UWcPb6OnqQAAsr

From: tangchunyou <tangchunyou@163.com>

1. the regs base in the bar havd en offset rg.off
	.rg.bar		= BAR0,
	.rg.off		= 0x00001000,	/* 4 Kbytes */
	.rg.sz		= 0x00002000,	/* 8 Kbytes */

2. add the rg.off to obtain the real regs base.

Signed-off-by: tangchunyou <tangchunyou@163.com>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 1c6043751dc9..2918b64708f9 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -234,6 +234,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	if (!chip->reg_base)
 		return -ENOMEM;
 
+	chip->reg_base += vsec_data.rg.off;
+
 	for (i = 0; i < chip->ll_wr_cnt; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
 		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
-- 
2.25.1


