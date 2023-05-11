Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5520D6FF9CF
	for <lists+dmaengine@lfdr.de>; Thu, 11 May 2023 21:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239086AbjEKTJe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 11 May 2023 15:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238961AbjEKTJ0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 11 May 2023 15:09:26 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50A9E6E8C;
        Thu, 11 May 2023 12:09:24 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id A5937E0EC0;
        Thu, 11 May 2023 22:09:21 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=z1ajNxVuMALkKpCfppBKR7DxSLkoIP1cPgaO6m6/vIw=; b=I3IempSwe8aT
        6PxV8+XvJpO2VaUFnobx6Te01pEByp4Sb29JRGpBae90vt4FLvIeEm717AXw8H9V
        /Rqn2Ze63tPlm4hC9O4U1ciTFORXYECwfQkqBjxY0EbyYwb/Z44dLiY0DeckJWEn
        jC1gbhB3/oiP/A05cCnbolnSvJyZUQo=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 8A648E0EB1;
        Thu, 11 May 2023 22:09:21 +0300 (MSK)
Received: from localhost (10.8.30.6) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Thu, 11 May 2023 22:09:21 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v5 06/14] PCI: dwc: Drop empty line from dw_pcie_link_set_max_speed()
Date:   Thu, 11 May 2023 22:08:54 +0300
Message-ID: <20230511190902.28896-7-Sergey.Semin@baikalelectronics.ru>
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

Well, just drop a redundant empty line from the tail of the denoted
function which by mistake was added in commit 39bc5006501c ("PCI: dwc:
Centralize link gen setting").

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index e55b7b387eb6..ede166645289 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -729,7 +729,6 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
 
 	cap &= ~((u32)PCI_EXP_LNKCAP_SLS);
 	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, cap | link_speed);
-
 }
 
 void dw_pcie_iatu_detect(struct dw_pcie *pci)
-- 
2.40.0


