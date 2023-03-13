Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA446B8258
	for <lists+dmaengine@lfdr.de>; Mon, 13 Mar 2023 21:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjCMUJf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 16:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjCMUJO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 16:09:14 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2EFE88892;
        Mon, 13 Mar 2023 13:09:03 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 54E5CE0EB3;
        Mon, 13 Mar 2023 23:09:03 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=IQpM/gQmfG5V0FqGZp4LIqmQ4dMPNQfyFZHmMDOx9RY=; b=P2Z2+Zn9n1Mk
        pC9iNCNWo93aJOvY0neDRd/U1MzqiylBvFt9LpfmA3JskGke0SDn5CJhuzOahX88
        vU/AsOp+BHQPelXmwL1hck9KPvd5Ub+xsbFETrSp+gVieyIPdBytL+ULk6r3aCGx
        Dh0POxND4OthdKZnwnN/2Gt2oNqX9B0=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 40519E0E1C;
        Mon, 13 Mar 2023 23:09:03 +0300 (MSK)
Received: from localhost (10.8.30.10) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Mon, 13 Mar 2023 23:09:02 +0300
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
Subject: [PATCH RESEND v2 10/11] MAINTAINERS: Add myself as the DW PCIe core reviewer
Date:   Mon, 13 Mar 2023 23:08:14 +0300
Message-ID: <20230313200816.30105-11-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313200816.30105-1-Sergey.Semin@baikalelectronics.ru>
References: <20230313200816.30105-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.8.30.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

No actions have been spotted from the driver maintainers for almost two
years now. It significantly delays the review process of the relatively
often incoming updates. Since that IP-core has been used in several our
SoCs adding myself to the list of reviewers will help in the evolving the
driver faster and in catching any potential problem as early as possible.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 489fd4b4c7ae..51adcafa0f0c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16061,6 +16061,7 @@ F:	drivers/pci/controller/dwc/pci-exynos.c
 PCI DRIVER FOR SYNOPSYS DESIGNWARE
 M:	Jingoo Han <jingoohan1@gmail.com>
 M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+R:	Serge Semin <fancer.lancer@gmail.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/snps,dw-pcie*.yaml
-- 
2.39.2


