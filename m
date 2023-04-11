Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289C66DD058
	for <lists+dmaengine@lfdr.de>; Tue, 11 Apr 2023 05:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjDKDj4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Apr 2023 23:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjDKDjw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Apr 2023 23:39:52 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD6CF1BFB;
        Mon, 10 Apr 2023 20:39:47 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 14308E0EAB;
        Tue, 11 Apr 2023 06:39:46 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=Z20A0fWpICPtjOF2M8t4WS6WhRAMGG+yFlsPVf4hP00=; b=RhBh/E8fNq1I
        iCmkSr+PFGO505/LkKkqlWszBvWTq7tT8rfk24qv29WQ20D+L8V4oOTNJFuXxYHA
        1sangwpvTwH3yk1nHcxBVtMy0COkYmTtlm9RxdEyWb8ypDQUVl92V8I59Atl5fHR
        z7tHrmAk7cGaKW7/0KbPOkKTwL9Nlcg=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 038AAE0E6A;
        Tue, 11 Apr 2023 06:39:46 +0300 (MSK)
Received: from localhost (10.8.30.38) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Tue, 11 Apr 2023 06:39:45 +0300
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
        Serge Semin <fancer.lancer@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v3 02/10] PCI: dwc: Fix inbound iATU entries out-of-bounds warning message
Date:   Tue, 11 Apr 2023 06:39:20 +0300
Message-ID: <20230411033928.30397-3-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230411033928.30397-1-Sergey.Semin@baikalelectronics.ru>
References: <20230411033928.30397-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.8.30.38]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The message is printed if the number of requested inbound iATU windows
exceed the device capability. In that case the message should either refer
to the "dma-ranges" DT property or to the DMA-ranges mapping. We suggest
to use the later version as a counterpart to the just CPU-ranges mapping.
In any case the current "Dma-ranges" phrase seems incorrect.

Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9952057c8819..5718b4bb67f0 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -723,7 +723,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 	}
 
 	if (pci->num_ib_windows <= i)
-		dev_warn(pci->dev, "Dma-ranges exceed inbound iATU size (%u)\n",
+		dev_warn(pci->dev, "DMA-ranges exceed inbound iATU size (%u)\n",
 			 pci->num_ib_windows);
 
 	return 0;
-- 
2.40.0


