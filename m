Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7C969A856
	for <lists+dmaengine@lfdr.de>; Fri, 17 Feb 2023 10:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjBQJkO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Feb 2023 04:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjBQJkM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Feb 2023 04:40:12 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A15162FC4;
        Fri, 17 Feb 2023 01:40:10 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id EF648E0EB1;
        Fri, 17 Feb 2023 12:40:05 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=h8ZIQkAkmsk8Sq+0FVklTiFjRYhjzEGYwZkUfKAAjwc=; b=vbTyxYCznMEB
        cw21xpv2Urs2d6rAuR2y7JuuQUk8+3kWPk2qQ05Oe6l++GhjC+T8Ixj3be0d9cDz
        qoXq0w/Kk52BL4jcpO8Zphq5B3WNV537xTBUeIEKRX9dMYVpo71oeaQ0WioGHY7J
        Cmc0lXQO3UGYpsLWgOMdvx0PQu8lIgE=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id D8AD1E0E6A;
        Fri, 17 Feb 2023 12:40:05 +0300 (MSK)
Received: from localhost (10.8.30.14) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Fri, 17 Feb 2023 12:40:05 +0300
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
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 05/11] PCI: bt1: Fix printing false error message
Date:   Fri, 17 Feb 2023 12:39:50 +0300
Message-ID: <20230217093956.27126-6-Sergey.Semin@baikalelectronics.ru>
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

The dev_err_probe() method is supposed to be invoked only if any error is
happened. It was definitely wrong to call it unconditionally. Due to that
the DWC PCIe host initialization error-message is printed all the time the
Baikal-T1 PCIe controller is probed even if no error actually happened.

Fixes: ba6ed462dcf4 ("PCI: dwc: Add Baikal-T1 PCIe controller support")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/pci/controller/dwc/pcie-bt1.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-bt1.c b/drivers/pci/controller/dwc/pcie-bt1.c
index 036a22886d17..055ed6ae321f 100644
--- a/drivers/pci/controller/dwc/pcie-bt1.c
+++ b/drivers/pci/controller/dwc/pcie-bt1.c
@@ -593,8 +593,10 @@ static int bt1_pcie_add_port(struct bt1_pcie *btpci)
 	dw_pcie_cap_set(&btpci->dw, REQ_RES);
 
 	ret = dw_pcie_host_init(&btpci->dw.pp);
+	if (ret)
+		dev_err_probe(dev, ret, "Failed to initialize DWC PCIe host\n");
 
-	return dev_err_probe(dev, ret, "Failed to initialize DWC PCIe host\n");
+	return ret;
 }
 
 static void bt1_pcie_del_port(struct bt1_pcie *btpci)
-- 
2.39.0


