Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029EC6FF9D1
	for <lists+dmaengine@lfdr.de>; Thu, 11 May 2023 21:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239095AbjEKTJf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 11 May 2023 15:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238960AbjEKTJ0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 11 May 2023 15:09:26 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F20AB6EBD;
        Thu, 11 May 2023 12:09:24 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 1A53DE0EC3;
        Thu, 11 May 2023 22:09:24 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=xBd+z4e5MXWvOcjFcTeyVJjVX2Efx8HIvckYUDSA3Xc=; b=VzyN1Ac0DUwB
        Ndb60Dizqjbt8KEWy+TmQGMF7fU4IslyVp6rqH8QmiCcwtQCSHzD3UutzT+XSKn+
        2NePkFBasGQ4fORDE8uuwuBX7DRWChDctZZLhITlOrZUWMSfzt1v0mo1B0z8MaEz
        Mwjz1E5w7nOU3Mgeok3HtS1Ays9hzio=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 0342EE0EB1;
        Thu, 11 May 2023 22:09:24 +0300 (MSK)
Received: from localhost (10.8.30.6) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Thu, 11 May 2023 22:09:23 +0300
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
Subject: [PATCH RESEND v5 09/14] MAINTAINERS: Demote Gustavo Pimentel to DW PCIe core reviewer
Date:   Thu, 11 May 2023 22:08:57 +0300
Message-ID: <20230511190902.28896-10-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230511190902.28896-1-Sergey.Semin@baikalelectronics.ru>
References: <20230511190902.28896-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.8.30.6]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

No maintaining actions from Gustavo have been noticed for over two years.
Demote him to being the DW PCIe RP/EP driver reviewer for now.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 817cd8f40e65..0d93e1e4e776 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16166,7 +16166,7 @@ F:	drivers/pci/controller/dwc/pci-exynos.c
 
 PCI DRIVER FOR SYNOPSYS DESIGNWARE
 M:	Jingoo Han <jingoohan1@gmail.com>
-M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+R:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/snps,dw-pcie*.yaml
-- 
2.40.0


