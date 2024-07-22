Return-Path: <dmaengine+bounces-2723-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C24FE93879B
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jul 2024 05:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 330ABB20CEC
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jul 2024 03:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C948101E6;
	Mon, 22 Jul 2024 03:05:55 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.77.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF081396;
	Mon, 22 Jul 2024 03:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.77.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721617555; cv=none; b=NUpOnxvlETQ0p2lrJKtopk6ynQZRBfriZ4c/JSfUWYAKwA+S9Gtv64bQxLIPHJj23AVP8JDniktWIiuf/duSWnCpKqZF6VdtmRrUfTOz8ePbWnNQozz2kotSg2GY08/pgsHt3uOLWt4zKoWJrf/5p9AJZf3nHeJ5wm1YbktxenY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721617555; c=relaxed/simple;
	bh=fjD5rSVN+4EWc0Dnk+tVtxxRmPHbGYVcwdZdROXDyXg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HqnU2iGAiQDlty04IfVoeMMmWsFOT4QjdYcPuCA6cCTgyHCmXz73GvppIDjnA+HEOxhyzyTjl+LRHoKs7qE4lYYYRpVQKH7lPAQkO9lc81VdqjxP6VZqVcwjpBuCXFP31bZsyJJmwMsckkLbj1khZScTwu5o008C+hl4uFXsDFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gxmicro.cn; spf=none smtp.mailfrom=gxmicro.cn; arc=none smtp.client-ip=114.132.77.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gxmicro.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=gxmicro.cn
X-QQ-mid: bizesmtp91t1721617474tn9cv7hw
X-QQ-Originating-IP: HgxVm+2+8nwJZnYfeP9Iei5wgzhKIo3qjDg1wSprtPc=
Received: from zhengdongxiong.. ( [210.22.143.226])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Jul 2024 11:04:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8639400719520395088
From: dongxiong zheng <zhengdongxiong@gxmicro.cn>
To: manivannan.sadhasivam@linaro.org,
	fancer.lancer@gmail.com,
	vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dongxiong zheng <zhengdongxiong@gxmicro.cn>
Subject: [PATCH v2] dmaengine: dw-edma: Move "Set consumer cycle" into first condition in dw_hdma_v0_core_start()
Date: Mon, 22 Jul 2024 11:04:05 +0800
Message-Id: <20240722030405.3385-1-zhengdongxiong@gxmicro.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:gxmicro.cn:qybglogicsvrgz:qybglogicsvrgz8a-0

Reference: Chapter 6.4.9.1 LL Operation Overview:
"Figure 6-23 Linked List Flow for Producer and Consumer" in
DesignWare Cores PCI Express Controller Databook (Version 6.00a June 2022)

Signed-off-by: dongxiong zheng <zhengdongxiong@gxmicro.cn>
---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 10e8f0715..d77051d1e 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -262,10 +262,10 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 			  lower_32_bits(chunk->ll_region.paddr));
 		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
 			  upper_32_bits(chunk->ll_region.paddr));
+		/* Set consumer cycle */
+		SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
+			HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
 	}
-	/* Set consumer cycle */
-	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
-		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
 
 	dw_hdma_v0_sync_ll_data(chunk);
 
-- 
2.34.1


