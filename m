Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 044874E8C6
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2019 15:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfFUNTS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Jun 2019 09:19:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:4442 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfFUNTS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 21 Jun 2019 09:19:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2019 06:19:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,400,1557212400"; 
   d="scan'208";a="165648716"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 21 Jun 2019 06:19:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6A0F3159; Fri, 21 Jun 2019 16:19:15 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Viresh Kumar <vireshk@kernel.org>, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] dmaengine: dw: Enable iDMA 32-bit on Intel Elkhart Lake
Date:   Fri, 21 Jun 2019 16:19:14 +0300
Message-Id: <20190621131914.38855-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Intel Elkhart Lake OSE (Offload Service Engine) provides few DMA controllers
to the host. Enable them in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dw/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma/dw/pci.c b/drivers/dma/dw/pci.c
index c69e80d97220..7a53c6a94957 100644
--- a/drivers/dma/dw/pci.c
+++ b/drivers/dma/dw/pci.c
@@ -143,6 +143,11 @@ static const struct pci_device_id dw_pci_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0x2286), (kernel_ulong_t)&dw_pci_data },
 	{ PCI_VDEVICE(INTEL, 0x22c0), (kernel_ulong_t)&dw_pci_data },
 
+	/* Elkhart Lake iDMA 32-bit (OSE DMA) */
+	{ PCI_VDEVICE(INTEL, 0x4bb4), (kernel_ulong_t)&idma32_pci_data },
+	{ PCI_VDEVICE(INTEL, 0x4bb5), (kernel_ulong_t)&idma32_pci_data },
+	{ PCI_VDEVICE(INTEL, 0x4bb6), (kernel_ulong_t)&idma32_pci_data },
+
 	/* Haswell */
 	{ PCI_VDEVICE(INTEL, 0x9c60), (kernel_ulong_t)&dw_pci_data },
 
-- 
2.20.1

