Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635402173E0
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2020 18:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgGGQYw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Jul 2020 12:24:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:55127 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728172AbgGGQYw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 7 Jul 2020 12:24:52 -0400
IronPort-SDR: gvqFdf/11O3QNk81LNy7IM1i7eNO/M/8UytVengQ/nd3jG20AxHvuMoBPPv3pkZkSWkSV0nT+w
 2bfxUxVvkFsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="212598316"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="212598316"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 09:24:52 -0700
IronPort-SDR: PghGr2VUMaoLfhMuZg4bXdd8mvj0JVXvAzArqAACqIR535djSuiVQMjTPlpOf4Q6GkjNlVkQFs
 MDLIimbeV/zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="483115006"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jul 2020 09:24:52 -0700
Subject: [PATCH] dmaengine: idxd: fix missing symbol for pci_msi_mask_irq()
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Tue, 07 Jul 2020 09:24:52 -0700
Message-ID: <159413909204.59019.6521464735007914513.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

lkp report compile issue without CONFIG_PCI_MSI_IRQ_DOMAIN being set. Add
dependency to the driver to ensure symbol is valid.

   ld: drivers/dma/idxd/device.o: in function `idxd_mask_msix_vector':
>> drivers/dma/idxd/device.c:24: undefined reference to `pci_msi_mask_irq'
   ld: drivers/dma/idxd/device.o: in function `idxd_unmask_msix_vector':
>> drivers/dma/idxd/device.c:41: undefined reference to `pci_msi_unmask_irq'

Fixes: 3592633e52d2 ("dmaengine: idxd: move idxd interrupt handling to mask instead of ignore")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index b70e90765ad3..cd89fe38834b 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -286,6 +286,7 @@ config INTEL_IDXD
 	tristate "Intel Data Accelerators support"
 	depends on PCI && X86_64
 	depends on SBITMAP
+	depends on PCI_MSI_IRQ_DOMAIN
 	select DMA_ENGINE
 	help
 	  Enable support for the Intel(R) data accelerators present

