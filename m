Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82B6DE39CC
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2019 19:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440038AbfJXRXC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Oct 2019 13:23:02 -0400
Received: from sender4-pp-o94.zoho.com ([136.143.188.94]:25442 "EHLO
        sender4-pp-o94.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389384AbfJXRXC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Oct 2019 13:23:02 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571937775; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=X/RbDHeP6dJCNtZcSeOTfQ0Ys48We0cjcNPbrxbaT+HuNyqTyf02W2/W83UHGjXcLp7uyqghwZRv+iomOF+0UCIT+VchmwRdlYMTtzdP9ria73hH0ZKYC0eMUaSpWVA66qqIZ2g811z960dZsHk3kNmNyEtYVo9BumXPx91nqPA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1571937775; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To; 
        bh=4E+Rpg5l5lwQv4Fs+9WoNkjj0J33QSsoc+dKM2jzHQw=; 
        b=jY0J4W42g7/gT5MVAVg2QkmarVk3DeBcK9umeiN04D7zT7pAT0Sw6SU68aT+2mnqZ/6JVtC3eb3EcZaG9bcWNSPXOlk/suiO1aB7LfhCDZS06n25WYEIbgO+vEPy0p6itl/vO+clvinSFRdBZfUdnbkJ3EnV4UBZh86DJB0K6dg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=JXj9iOjOYcqi2t/rG7odkldOG2QdvmfXhvIesGZXSIJ9dL0WzKfyz7yK2I2gLQjZDDtHGFBLZz+i
    dOIrUz3ukQ0YIXqm+ridoxMuT/GKq+AGqYu8Sp1wNR7MzAOCcKnK  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1571937775;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=1231; bh=4E+Rpg5l5lwQv4Fs+9WoNkjj0J33QSsoc+dKM2jzHQw=;
        b=A4y/omKw2ab7vGPKPtYPW9TB7hWrRSema0DX7z6N8N04UC13ai9ls+e/yu7ajm+5
        +ds6jwlLU2W3XL3h9JeqrUY3Qx/1Cu8Vr/C15+cUBpsYMVx/3Tn+g6cuIeM3XScES65
        vQsMSR8/czHTkXWFtsFVIaxFayohNXuCGmedpKcQ=
Received: from zhouyanjie-virtual-machine.localdomain (171.221.113.49 [171.221.113.49]) by mx.zohomail.com
        with SMTPS id 1571937774306831.6615968475469; Thu, 24 Oct 2019 10:22:54 -0700 (PDT)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        paul.burton@mips.com, vkoul@kernel.org, paul@crapouillou.net,
        mark.rutland@arm.com, Zubair.Kakakhel@imgtec.com,
        dan.j.williams@intel.com
Subject: [PATCH 2/2 v2] dmaengine: JZ4780: Add support for the X1000.
Date:   Fri, 25 Oct 2019 01:21:10 +0800
Message-Id: <1571937670-30828-3-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571937670-30828-1-git-send-email-zhouyanjie@zoho.com>
References: <1571799903-44561-1-git-send-email-zhouyanjie@zoho.com>
 <1571937670-30828-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for probing the dma-jz4780 driver on the X1000 Soc.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/dma/dma-jz4780.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index cafb1cc0..5e3af48 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -1019,11 +1019,18 @@ static const struct jz4780_dma_soc_data jz4780_dma_soc_data = {
 	.flags = JZ_SOC_DATA_ALLOW_LEGACY_DT | JZ_SOC_DATA_PROGRAMMABLE_DMA,
 };
 
+static const struct jz4780_dma_soc_data x1000_dma_soc_data = {
+	.nb_channels = 8,
+	.transfer_ord_max = 7,
+	.flags = JZ_SOC_DATA_PROGRAMMABLE_DMA,
+};
+
 static const struct of_device_id jz4780_dma_dt_match[] = {
 	{ .compatible = "ingenic,jz4740-dma", .data = &jz4740_dma_soc_data },
 	{ .compatible = "ingenic,jz4725b-dma", .data = &jz4725b_dma_soc_data },
 	{ .compatible = "ingenic,jz4770-dma", .data = &jz4770_dma_soc_data },
 	{ .compatible = "ingenic,jz4780-dma", .data = &jz4780_dma_soc_data },
+	{ .compatible = "ingenic,x1000-dma", .data = &x1000_dma_soc_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, jz4780_dma_dt_match);
-- 
2.7.4


