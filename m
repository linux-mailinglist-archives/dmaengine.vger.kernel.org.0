Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652786E1A38
	for <lists+dmaengine@lfdr.de>; Fri, 14 Apr 2023 04:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjDNCTi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Apr 2023 22:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjDNCT2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Apr 2023 22:19:28 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DF634ED0;
        Thu, 13 Apr 2023 19:19:17 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 92022E0EB7;
        Fri, 14 Apr 2023 05:19:06 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=IQN6qrKq/E9j5sKFGckYuyaVhOAeof+dWeHxPxlB85o=; b=boMzYu6BFCdX
        mexTqIfbq1YMgxqU/Eg8R9dL7HhnKsGCZcGcxAtuHn4TOcr5xWTTJn2KO5d6Sojf
        pMzrhTkmuwwL3KFciD7zcyaO7+SgppPDj21FlcwbSN0dXpKgVmloS7qyeyN8OoBp
        JYLez08NsLWq8Dc4zKad4kQnaWghZiQ=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 7950DE0E1D;
        Fri, 14 Apr 2023 05:19:06 +0300 (MSK)
Received: from localhost (10.8.30.14) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Fri, 14 Apr 2023 05:19:06 +0300
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
Subject: [PATCH v4 12/14] MAINTAINERS: Demote Gustavo Pimentel to DW EDMA driver reviewer
Date:   Fri, 14 Apr 2023 05:18:30 +0300
Message-ID: <20230414021832.13167-13-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230414021832.13167-1-Sergey.Semin@baikalelectronics.ru>
References: <20230414021832.13167-1-Sergey.Semin@baikalelectronics.ru>
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

No maintaining actions from Gustavo have been noticed for over a year.
Demote him to being the DW eDMA driver reviewer for now.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index dcdfe43ee383..b9d22e0a72be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5861,7 +5861,7 @@ S:	Orphan
 F:	drivers/mtd/nand/raw/denali*
 
 DESIGNWARE EDMA CORE IP DRIVER
-M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+R:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
 L:	dmaengine@vger.kernel.org
 S:	Maintained
 F:	drivers/dma/dw-edma/
-- 
2.40.0


