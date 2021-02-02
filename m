Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8ECF30C6EE
	for <lists+dmaengine@lfdr.de>; Tue,  2 Feb 2021 18:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237169AbhBBREd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Feb 2021 12:04:33 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:37826 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237029AbhBBQ5u (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Feb 2021 11:57:50 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 65E7FC00BA;
        Tue,  2 Feb 2021 16:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612285008; bh=jSQ7gPD0eg5i7tdOXR7I0dbZcd3MOQ43M0ZUh6bw2F0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ltFaExBi5SoZXkLuhjrd8/KIg2kkE5HZJpX7w0nLSFSPjZw8Z8EmMrjsPW2gMyEYt
         hmQTwrrqnpeSh8gQ0QZkqsV+4fjMXIzGqy9ARUgr5aLFZU6zLoUV5mdWS4R3t9VfyA
         C6L8t0+ibXqKrOD8SlyBi7jRVFzw1jsqTfiulmhG4QNMbDGRWpm/uz2s/06sIRiKeG
         z2XOaKW/eTH01vNFN8+IrZz/l+1m8oFv9/j+IgTvioQkfBJr92ea/G4yBESISs23Pq
         BKmrSBjsx+pfDqTYbvbceD/zK6B1rD2PJxu+y7KjIPb03ZCJLy0LuoUXi8AnXeeBP1
         j7ZmKhI7ROCxA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 824D3A005F;
        Tue,  2 Feb 2021 16:56:46 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [RESEND PATCH v3 2/5] misc: Add Synopsys DesignWare xData IP driver to Makefile
Date:   Tue,  2 Feb 2021 17:56:35 +0100
Message-Id: <978462554997e50683e78a69493c0e169de6ef18.1612284945.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1612284945.git.gustavo.pimentel@synopsys.com>
References: <cover.1612284945.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1612284945.git.gustavo.pimentel@synopsys.com>
References: <cover.1612284945.git.gustavo.pimentel@synopsys.com>
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

