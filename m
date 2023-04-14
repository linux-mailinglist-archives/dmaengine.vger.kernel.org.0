Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F6E6E1A22
	for <lists+dmaengine@lfdr.de>; Fri, 14 Apr 2023 04:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjDNCTU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Apr 2023 22:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjDNCTR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Apr 2023 22:19:17 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A672255AB;
        Thu, 13 Apr 2023 19:19:01 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id B8419E0EAF;
        Fri, 14 Apr 2023 05:19:00 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=xGDsTPT86T4LuRJWjhR70wGw0i95sKl3YEXw9Ee0IO4=; b=cUhvZebe468F
        Jf2vRzGfYBU3uNZG3bttbamT1MusaVLHVDlwtbYi0oglNIIMkrZWtIcN9pkTYkza
        ovkw6jxyinDeZt/Utw/UrsYTvrNKNVp61UffKA5gbveB1LpCC9Hl8zdPyhoiwQDl
        IvQDrC8i1cm3Sl2BHv7C3OfIGJY/Nko=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id A211AE0E1D;
        Fri, 14 Apr 2023 05:19:00 +0300 (MSK)
Received: from localhost (10.8.30.14) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Fri, 14 Apr 2023 05:19:00 +0300
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
Subject: [PATCH v4 04/14] PCI: bt1: Fix printing false error message
Date:   Fri, 14 Apr 2023 05:18:22 +0300
Message-ID: <20230414021832.13167-5-Sergey.Semin@baikalelectronics.ru>
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

The dev_err_probe() method is supposed to be invoked only if any error is
happened. It was definitely wrong to call it unconditionally. Due to that
the DWC PCIe host initialization error-message is printed all the time the
Baikal-T1 PCIe controller is probed even if no error actually happened.

Fixes: ba6ed462dcf4 ("PCI: dwc: Add Baikal-T1 PCIe controller support")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-bt1.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-bt1.c b/drivers/pci/controller/dwc/pcie-bt1.c
index e36a20bf82cf..6557141873ad 100644
--- a/drivers/pci/controller/dwc/pcie-bt1.c
+++ b/drivers/pci/controller/dwc/pcie-bt1.c
@@ -597,8 +597,10 @@ static int bt1_pcie_add_port(struct bt1_pcie *btpci)
 	dw_pcie_cap_set(&btpci->dw, REQ_RES);
 
 	ret = dw_pcie_host_init(&btpci->dw.pp);
+	if (ret)
+		dev_err_probe(dev, ret, "Failed to initialize DWC PCIe host\n");
 
-	return dev_err_probe(dev, ret, "Failed to initialize DWC PCIe host\n");
+	return ret;
 }
 
 static void bt1_pcie_del_port(struct bt1_pcie *btpci)
-- 
2.40.0


