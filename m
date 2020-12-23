Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132F62E1A89
	for <lists+dmaengine@lfdr.de>; Wed, 23 Dec 2020 10:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgLWJbw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Dec 2020 04:31:52 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:34095 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727678AbgLWJbv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Dec 2020 04:31:51 -0500
X-UUID: 6f3a65009743422da671283679c5808b-20201223
X-UUID: 6f3a65009743422da671283679c5808b-20201223
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1900666744; Wed, 23 Dec 2020 17:31:09 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 23 Dec 2020 17:31:05 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Dec 2020 17:31:06 +0800
From:   EastL Lee <EastL.Lee@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
CC:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <cc.hwang@mediatek.com>,
        EastL Lee <EastL.Lee@mediatek.com>
Subject: [PATCH v8 4/4] dmaengine: mediatek-cqdma: fix compatible
Date:   Wed, 23 Dec 2020 17:30:47 +0800
Message-ID: <1608715847-28956-5-git-send-email-EastL.Lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1608715847-28956-1-git-send-email-EastL.Lee@mediatek.com>
References: <1608715847-28956-1-git-send-email-EastL.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: AB5F3E4F3B23590E4D2AA6A9CEEF542C12AA43FC13FAE86D027D8A63160E284B2000:8
X-MTK:  N
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch adds common compatible & platform compatiable.

Signed-off-by: EastL Lee <EastL.Lee@mediatek.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/dma/mediatek/mtk-cqdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
index 1610632..17b3ab9 100644
--- a/drivers/dma/mediatek/mtk-cqdma.c
+++ b/drivers/dma/mediatek/mtk-cqdma.c
@@ -547,6 +547,7 @@ static void mtk_cqdma_hw_deinit(struct mtk_cqdma_device *cqdma)
 
 static const struct of_device_id mtk_cqdma_match[] = {
 	{ .compatible = "mediatek,mt6765-cqdma" },
+	{ .compatible = "mediatek,mt6779-cqdma" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mtk_cqdma_match);
-- 
1.9.1

