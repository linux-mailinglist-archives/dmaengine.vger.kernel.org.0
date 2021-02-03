Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE0830E5A5
	for <lists+dmaengine@lfdr.de>; Wed,  3 Feb 2021 23:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbhBCWGr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Feb 2021 17:06:47 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:52540 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232982AbhBCWEm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Feb 2021 17:04:42 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7859EC0111;
        Wed,  3 Feb 2021 22:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612389821; bh=jSQ7gPD0eg5i7tdOXR7I0dbZcd3MOQ43M0ZUh6bw2F0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=dLwXHLKnr+KQ+SC3PPXz1ScjIqeMVUmaxm42uQKk1xts7s2kqvoTUAyOslH/FppPP
         QKlnHqirO7cD0xhbN1jvI2OFgNz8kcJieOpldAkYUgQstHk8tlro1aFXrrr1ZB4YXN
         4PGn+fiT1jOqcy70OJuP1LiE3Ux8tSPIpPLCmWMd9Ow5S3K/1lSTnHU2ELQfg2GNeY
         YJSMdQZOfRdyjgFrw4b11DeB8Qtbu5pIvNJyKfhm26zVQaN6QjbqndFiSLZHcdtINq
         u394YOGN+Q0DQfsxobFE4jk4FuZ0iBfpeDrOYt3n0rawdnw3PFfAXCeRxJqXRYHulB
         ykFe6PwSFKG4A==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3B5EBA024D;
        Wed,  3 Feb 2021 22:03:40 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v4 2/6] misc: Add Synopsys DesignWare xData IP driver to Makefile
Date:   Wed,  3 Feb 2021 23:03:26 +0100
Message-Id: <1a1b9d4893fe4ef1ff906a5813a0b18895da90ed.1612389746.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1612389746.git.gustavo.pimentel@synopsys.com>
References: <cover.1612389746.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1612389746.git.gustavo.pimentel@synopsys.com>
References: <cover.1612389746.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add Synopsys DesignWare xData IP driver to Makefile.

This driver enables/disables the PCIe traffic generator module
pertain to the Synopsys DesignWare prototype.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/misc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index d23231e..bf22021 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_SRAM_EXEC)		+= sram-exec.o
 obj-$(CONFIG_GENWQE)		+= genwqe/
 obj-$(CONFIG_ECHO)		+= echo/
 obj-$(CONFIG_CXL_BASE)		+= cxl/
+obj-$(CONFIG_DW_XDATA_PCIE)	+= dw-xdata-pcie.o
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
 obj-$(CONFIG_OCXL)		+= ocxl/
 obj-y				+= cardreader/
-- 
2.7.4

