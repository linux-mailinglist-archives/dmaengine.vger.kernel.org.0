Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77F269A851
	for <lists+dmaengine@lfdr.de>; Fri, 17 Feb 2023 10:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjBQJkL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Feb 2023 04:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBQJkK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Feb 2023 04:40:10 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C782E62FCD;
        Fri, 17 Feb 2023 01:40:02 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id EAEA7E0EAE;
        Fri, 17 Feb 2023 12:40:01 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=nGH1eyeTZsaiGaUCtbAQ+K31eiBwSX9FFd2B6giUXIA=; b=CxHf8e3cIwtB
        ZY5fLrR1Kbr0CX5bkrAi9BCoeKgkbXYt7jAtvCbh9m9g5PmHxBSkXMnmWSdMIjoQ
        lVbVjjWdAZCK7BjF/V6rTr0pknE89/OsZ8OpHZ+EBJEcmDkcpuwtlNefoHxgdQAR
        sKjn6qBzCR8YtQZCgCiUck9pr+m7ENw=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id D38A9E0E6A;
        Fri, 17 Feb 2023 12:40:01 +0300 (MSK)
Received: from localhost (10.8.30.14) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Fri, 17 Feb 2023 12:40:01 +0300
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
Subject: [PATCH 02/11] PCI: dwc: Fix erroneous version type test helper
Date:   Fri, 17 Feb 2023 12:39:47 +0300
Message-ID: <20230217093956.27126-3-Sergey.Semin@baikalelectronics.ru>
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

Due to an unfortunate mistake the macro function actually checks the
IP-core version instead of the IP-core version type which isn't what
originally implied. Fix it by introducing a new helper
__dw_pcie_ver_type_cmp() with the same semantic as the __dw_pcie_ver_cmp()
counterpart except it refers to the dw_pcie.type field in order to perform
the passed comparison operation.

Fixes: 0b0a780d52ad ("PCI: dwc: Add macros to compare Synopsys IP core versions")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/pci/controller/dwc/pcie-designware.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 393dfb931df6..9ebe91cc11d8 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -35,17 +35,20 @@
 #define __dw_pcie_ver_cmp(_pci, _ver, _op) \
 	((_pci)->version _op DW_PCIE_VER_ ## _ver)
 
+#define __dw_pcie_ver_type_cmp(_pci, _type, _op) \
+	((_pci)->type _op DW_PCIE_VER_TYPE_ ## _type)
+
 #define dw_pcie_ver_is(_pci, _ver) __dw_pcie_ver_cmp(_pci, _ver, ==)
 
 #define dw_pcie_ver_is_ge(_pci, _ver) __dw_pcie_ver_cmp(_pci, _ver, >=)
 
 #define dw_pcie_ver_type_is(_pci, _ver, _type) \
 	(__dw_pcie_ver_cmp(_pci, _ver, ==) && \
-	 __dw_pcie_ver_cmp(_pci, TYPE_ ## _type, ==))
+	 __dw_pcie_ver_type_cmp(_pci, _type, ==))
 
 #define dw_pcie_ver_type_is_ge(_pci, _ver, _type) \
 	(__dw_pcie_ver_cmp(_pci, _ver, ==) && \
-	 __dw_pcie_ver_cmp(_pci, TYPE_ ## _type, >=))
+	 __dw_pcie_ver_type_cmp(_pci, _type, >=))
 
 /* DWC PCIe controller capabilities */
 #define DW_PCIE_CAP_REQ_RES		0
-- 
2.39.0


