Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C635295FB3
	for <lists+dmaengine@lfdr.de>; Tue, 20 Aug 2019 15:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbfHTNPu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Aug 2019 09:15:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:49868 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728771AbfHTNPu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Aug 2019 09:15:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 06:15:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="178185133"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 20 Aug 2019 06:15:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0BAF8128; Tue, 20 Aug 2019 16:15:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 00/10] dmaengine: dw: Enable for Intel Elkhart Lake
Date:   Tue, 20 Aug 2019 16:15:36 +0300
Message-Id: <20190820131546.75744-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Intel Elkhart Lake the DMA controllers can be provided by Intel® PSE
(Programmable Services Engine) and exposed either as PCI or ACPI devices.

To support both schemes here is a patch series.

First two patches fixes minor issues in DMA ACPI layer, patches 3-5 enables
Intel Elkhart Lake DMA controllers that exposed as ACPI devices, patch 6 is
clean up, patch 7 is fix for possible race on ->remove() stage, patch 8 is
follow up clean up and patches 9-10 is a split for better maintenance.

Changelog v2:
- spell correctly Intel® PSE in the code and commit messages (Jarkko)
- drop couple of not needed right now patches against DMA ACPI layer

Andy Shevchenko (10):
  dmaengine: acpi: Set up DMA mask based on CSRT
  dmaengine: acpi: Add kernel doc parameter descriptions
  dmaengine: dw: Export struct dw_dma_chip_pdata for wider use
  dmaengine: dw: platform: Use struct dw_dma_chip_pdata
  dmaengine: dw: platform: Enable iDMA 32-bit on Intel Elkhart Lake
  dmaengine: dw: platform: Use devm_platform_ioremap_resource()
  dmaengine: dw: platform: Switch to acpi_dma_controller_register()
  dmaengine: dw: platform: Move handle check to
    dw_dma_acpi_controller_register()
  dmaengine: dw: platform: Split ACPI helpers to separate module
  dmaengine: dw: platform: Split OF helpers to separate module

 drivers/dma/acpi-dma.c    |  12 ++-
 drivers/dma/dw/Makefile   |   4 +-
 drivers/dma/dw/acpi.c     |  53 +++++++++
 drivers/dma/dw/internal.h |  51 +++++++++
 drivers/dma/dw/of.c       | 131 ++++++++++++++++++++++
 drivers/dma/dw/pci.c      |  60 +++--------
 drivers/dma/dw/platform.c | 221 +++++++++-----------------------------
 7 files changed, 312 insertions(+), 220 deletions(-)
 create mode 100644 drivers/dma/dw/acpi.c
 create mode 100644 drivers/dma/dw/of.c

-- 
2.23.0.rc1

