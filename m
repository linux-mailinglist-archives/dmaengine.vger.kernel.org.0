Return-Path: <dmaengine+bounces-4649-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3453A4F8A4
	for <lists+dmaengine@lfdr.de>; Wed,  5 Mar 2025 09:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD81E1891929
	for <lists+dmaengine@lfdr.de>; Wed,  5 Mar 2025 08:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1140F1FDA7A;
	Wed,  5 Mar 2025 08:21:14 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D331F7089;
	Wed,  5 Mar 2025 08:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162874; cv=none; b=U1JRIRoE5DvfPoSddurhqSVrHIVcf84Qos05cS4wTvNXwR6Xm/XvW2P9FiezG1cDRhW+wI0cTG6hKOGEVur0ZduINzWkJffg4mpGUwaxqUzIcwzqQO207NcgGLzOtSGVO8qeDmGgrGc0msti1Xfo9Hbpru9GPUb+8M7e4rge6vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162874; c=relaxed/simple;
	bh=43bSVtdXS1DSzsQg5uKbqcbGwMVpdey2FYyFVUdZmps=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DHo+DsrFUsp7DYlvGLUCSu9DPnsuZZPqNG5wbo0qRRGVHAvETVar4CJe7/sGquLUXsE72a3EVB8m+FzabijF0PfPpZ5pLe2iW/1HdoYwo286Cbkoi/ExFKg2rqjUi2A1ELnsu4kHfDOkg0OYQSf08I5sJOvJ5z+9ZcFhd4Xybs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201615.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202503051621029180;
        Wed, 05 Mar 2025 16:21:02 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 Jtjnmail201615.home.langchao.com (10.100.2.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Mar 2025 16:21:03 +0800
Received: from locahost.localdomain (10.94.3.63) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Mar 2025 16:21:03 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <Eugeniy.Paltsev@synopsys.com>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Charles Han
	<hanchunchao@inspur.com>
Subject: [PATCH] dmaengine: dw-axi-dmac: fix inconsistent indenting warning
Date: Wed, 5 Mar 2025 16:21:01 +0800
Message-ID: <20250305082101.5334-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201613.home.langchao.com (10.100.2.13) To
 jtjnmail201607.home.langchao.com (10.100.2.7)
tUid: 2025305162102452ca2a1086c9acc543d113c9c690474
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Fix below inconsistent indenting smatch warning.
smatch warnings:
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:1237 dma_chan_pause() warn: inconsistent indenting
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:1284 axi_chan_resume() warn: inconsistent indenting

Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index b23536645ff7..97e7f0659810 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1233,8 +1233,8 @@ static int dma_chan_pause(struct dma_chan *dchan)
 		} else {
 			val |= BIT(chan->id) << DMAC_CHAN_SUSP2_SHIFT |
 			       BIT(chan->id) << DMAC_CHAN_SUSP2_WE_SHIFT;
-			}
-			axi_dma_iowrite64(chan->chip, DMAC_CHSUSPREG, val);
+		}
+		axi_dma_iowrite64(chan->chip, DMAC_CHSUSPREG, val);
 	} else {
 		if (chan->chip->dw->hdata->reg_map_8_channels) {
 			val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
@@ -1281,7 +1281,7 @@ static inline void axi_chan_resume(struct axi_dma_chan *chan)
 			val &= ~(BIT(chan->id) << DMAC_CHAN_SUSP2_SHIFT);
 			val |=  (BIT(chan->id) << DMAC_CHAN_SUSP2_WE_SHIFT);
 		}
-			axi_dma_iowrite64(chan->chip, DMAC_CHSUSPREG, val);
+		axi_dma_iowrite64(chan->chip, DMAC_CHSUSPREG, val);
 	} else {
 		if (chan->chip->dw->hdata->reg_map_8_channels) {
 			val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
-- 
2.43.0


