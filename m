Return-Path: <dmaengine+bounces-4772-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD52A6EA02
	for <lists+dmaengine@lfdr.de>; Tue, 25 Mar 2025 08:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFCED3AB19C
	for <lists+dmaengine@lfdr.de>; Tue, 25 Mar 2025 07:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED1313AA2E;
	Tue, 25 Mar 2025 07:00:18 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09C779F5;
	Tue, 25 Mar 2025 07:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742886018; cv=none; b=N/Kd72cJzzfI+4Yq9hrzQLJRlfaa2Qe9s7ve+muHO3YU9mYfX9nhb4IUshF0Uk0Iwe/bjuIx4qjZY+ehPwboCE2VLVL/yAWwcDYMEnlHCaOmPK1Yu86CFksfKoJXOTUXZU3XyW0r9INr0Yz1JUTj+HGEYF1OPqCnwA/iATWf/uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742886018; c=relaxed/simple;
	bh=43bSVtdXS1DSzsQg5uKbqcbGwMVpdey2FYyFVUdZmps=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gZmPIVmai8ofkx+befsaC2/VDT3ER7xdyeGicKVqKYSncEMrMZlwp4hwRTD7NtS0O3BtTKWYLvFqJlbaHmF12PaNlUFnkShVClO5S9PmbYUMo51vXv1HVrGRQd3x/RhJFKwkfUghEJUm4pfBvetTzG8BtSj9awMNqxyzkhY1ZSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201616.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202503251458590977;
        Tue, 25 Mar 2025 14:58:59 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 Jtjnmail201616.home.langchao.com (10.100.2.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Mar 2025 14:58:58 +0800
Received: from locahost.localdomain.com (10.94.16.22) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Mar 2025 14:58:58 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <Eugeniy.Paltsev@synopsys.com>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Charles Han
	<hanchunchao@inspur.com>
Subject: [PATCH] dmaengine: dw-axi-dmac: fix inconsistent indenting warning
Date: Tue, 25 Mar 2025 14:58:54 +0800
Message-ID: <20250325065855.2717-1-hanchunchao@inspur.com>
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
tUid: 20253251458599c0d0019f829bbc6c755a53cc67155ac
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


