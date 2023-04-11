Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5796DD05A
	for <lists+dmaengine@lfdr.de>; Tue, 11 Apr 2023 05:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjDKDj5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Apr 2023 23:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjDKDjw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Apr 2023 23:39:52 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD7CF1BFC;
        Mon, 10 Apr 2023 20:39:47 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 60DE4E0EAA;
        Tue, 11 Apr 2023 06:39:45 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=dhe5fI/NAb096CUtikyh7zdL7QAzlkNeqQb7gzpNoGQ=; b=jO5/qNV/XUsm
        qyc3iswjovf49leh7tHcz8t63Bucd+qBaKNJoB6MOSTsslARXmR+cK8Dw8TcE5k1
        rKJ/pbe4tUViJZZZRwbiCWdbsmoBC4nq5yHqWoZmydJcZXpSXWjs5A/S0ObLVrTQ
        qn/LFoKvM/Eq+Nl+HIXmwCSNWHOW2so=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 4B7B5E0E6A;
        Tue, 11 Apr 2023 06:39:45 +0300 (MSK)
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
Subject: [PATCH RESEND v3 01/10] PCI: dwc: Fix erroneous version type test helper
Date:   Tue, 11 Apr 2023 06:39:19 +0300
Message-ID: <20230411033928.30397-2-Sergey.Semin@baikalelectronics.ru>
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
index 79713ce075cc..adad0ea61799 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -37,17 +37,20 @@
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
2.40.0


