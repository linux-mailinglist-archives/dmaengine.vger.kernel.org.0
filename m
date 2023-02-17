Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F8169A867
	for <lists+dmaengine@lfdr.de>; Fri, 17 Feb 2023 10:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjBQJkV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Feb 2023 04:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjBQJkP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Feb 2023 04:40:15 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D68C53ECD;
        Fri, 17 Feb 2023 01:40:14 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id EC69DE0EAF;
        Fri, 17 Feb 2023 12:40:13 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=qWhduFNraxXVSwHvFaj3lriL4UhJFHDZLswqJP/jCIc=; b=czm3WADQeMOY
        ZCa5qUwx+vFK8AXIVke0MEMbKzy3GoWtOUKyQfFyzGsDYmJf54qsbpHZgY0yQSoF
        EFPGLFczzcX3iKD8H2UytfJqqglyTQ4KpeXqZSBLG9EncxwoHn6en9Gbauao8aka
        ibbs5/7h9d5tLrRqV47eFEF0DebcTRU=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id DA1A0E0E6A;
        Fri, 17 Feb 2023 12:40:13 +0300 (MSK)
Received: from localhost (10.8.30.14) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Fri, 17 Feb 2023 12:40:13 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 11/11] MAINTAINERS: Add myself as the DW eDMA driver reviewer
Date:   Fri, 17 Feb 2023 12:39:56 +0300
Message-ID: <20230217093956.27126-12-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230217093956.27126-1-Sergey.Semin@baikalelectronics.ru>
References: <20230217093956.27126-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.8.30.14]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The driver maintainer has been inactive for almost two years now. It
doesn't positively affect the new patches tests and reviews process. Since
the DW eDMA engine has been embedded into the PCIe controllers in several
our SoCs we will be interested in helping with the updates review.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bc3d6a55e19c..2e866f61d983 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5985,6 +5985,7 @@ F:	drivers/mtd/nand/raw/denali*
 
 DESIGNWARE EDMA CORE IP DRIVER
 M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+R:	Serge Semin <fancer.lancer@gmail.com>
 L:	dmaengine@vger.kernel.org
 S:	Maintained
 F:	drivers/dma/dw-edma/
-- 
2.39.0


