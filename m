Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1B3E12A5
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2019 09:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389570AbfJWHDO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Oct 2019 03:03:14 -0400
Received: from sender4-pp-o94.zoho.com ([136.143.188.94]:25473 "EHLO
        sender4-pp-o94.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfJWHDO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Oct 2019 03:03:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571814174; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=oDqiQMTGm70gnqQYG9/BrBb1wCzvr+2281o13ylKptWnc4EoWjMdQgisWyVC/7p9EIQoV456XDtxjIIEF4rv/OyQONGeZHmhtfduJQ3629UDHaNhs5ecQpVCmrX316tn+2eLa9cSlEP7rD6bUQLSmiNFpfKNWafuAj3+QhrsUbY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1571814174; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To; 
        bh=Di8V3CBB4Wm1a2j2vP6dQGcqZopjJWn+fHh0H9hPQ8A=; 
        b=Uj3mge6WLTjDQcKPS++ChSa/fJ4GPkMGVLB+TJx8MDnB6EI2/FFD2u8FPe1Y9A02saDLyQh6OXuRxx7FW1PP0TAG8O2Ki/l9cTnMVaffA6CsV90v3vMdMaPW7170bT69wrq+xNgVU946eXiOi7ieXWzt/mD0OTL/pBH4nAhegZc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=H0WoeZTpY42Jn6ptUQmrmqtJz8H6jkfq56oetzUCw4tMv4hNUry5xxa6EYEpf6SJyPeaEzv6h9kb
    1AOukpfj4Szol3wV/2O17Rys+Q6DN8g36ePUypbB3Jxaev8gu4If  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1571814174;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=1210; bh=Di8V3CBB4Wm1a2j2vP6dQGcqZopjJWn+fHh0H9hPQ8A=;
        b=GgQhLN+WODaSYgHpMD+Eipjeq5fV5bKfgATgT+hFKpMtGiYLa8s1/K/qwrwUNszz
        zu/v2TGYzROa3JcwWng7d+6xYBP187EI4BSzYGZKHYTK6KZAw+CeCJ9TthlHKv5OQ7Y
        kTSdgTdl9HQp1jb1GdCw42Ck2dH3hxcpqQg7B4qU=
Received: from zhouyanjie-virtual-machine.localdomain (125.71.5.36 [125.71.5.36]) by mx.zohomail.com
        with SMTPS id 1571814172029893.5936204313408; Wed, 23 Oct 2019 00:02:52 -0700 (PDT)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        paul.burton@mips.com, vkoul@kernel.org, paul@crapouillou.net,
        mark.rutland@arm.com, Zubair.Kakakhel@imgtec.com,
        dan.j.williams@intel.com
Subject: [PATCH RESEND 2/2] dmaengine: JZ4780: Add support for the X1000.
Date:   Wed, 23 Oct 2019 15:02:17 +0800
Message-Id: <1571814137-46002-3-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571814137-46002-1-git-send-email-zhouyanjie@zoho.com>
References: <1571799903-44561-1-git-send-email-zhouyanjie@zoho.com>
 <1571814137-46002-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for probing the dma-jz4780 driver on the X1000 Soc.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---
 drivers/dma/dma-jz4780.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index cafb1cc0..f809a6e 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -1019,11 +1019,18 @@ static const struct jz4780_dma_soc_data jz4780_dma_soc_data = {
 	.flags = JZ_SOC_DATA_ALLOW_LEGACY_DT | JZ_SOC_DATA_PROGRAMMABLE_DMA,
 };
 
+static const struct jz4780_dma_soc_data x1000_dma_soc_data = {
+	.nb_channels = 8,
+	.transfer_ord_max = 7,
+	.flags = JZ_SOC_DATA_ALLOW_LEGACY_DT | JZ_SOC_DATA_PROGRAMMABLE_DMA,
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


