Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD23274EE7
	for <lists+dmaengine@lfdr.de>; Wed, 23 Sep 2020 04:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgIWCTA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Sep 2020 22:19:00 -0400
Received: from mga05.intel.com ([192.55.52.43]:35873 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbgIWCTA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 22 Sep 2020 22:19:00 -0400
IronPort-SDR: AvQELZt6Pqboxlg3fCSkjJ9qI7PTEt5t+aCUepr/+GdhWNE7KvSCeYkDuOcysCrW/ng4NFNhrF
 yNWPaNP2Pxsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="245592619"
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; 
   d="scan'208";a="245592619"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 19:18:59 -0700
IronPort-SDR: X/LPQXKVl1RCBoj+7HpbXxnvDLRkutEO5WLKtk7OmldHkKfUpUW2F41eLgRAvP9VYfaF6cEYu4
 l3DdlIPU+eQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; 
   d="scan'208";a="511453312"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga005.fm.intel.com with ESMTP; 22 Sep 2020 19:18:56 -0700
From:   Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
To:     dmaengine@vger.kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        chuanhua.lei@linux.intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, peter.ujfalusi@ti.com,
        mallikarjunax.reddy@linux.intel.com, malliamireddy009@gmail.com
Subject: [PATCH v7 0/2] Add Intel LGM soc DMA support
Date:   Wed, 23 Sep 2020 10:18:43 +0800
Message-Id: <cover.1600827061.git.mallikarjunax.reddy@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add DMA controller driver for Lightning Mountain(LGM) family of SoCs.

The main function of the DMA controller is the transfer of data from/to any
DPlus compliant peripheral to/from the memory. A memory to memory copy
capability can also be configured.
This ldma driver is used for configure the device and channnels for data
and control paths.

These controllers provide DMA capabilities for a variety of on-chip
devices such as SSC, HSNAND and GSWIP.

-------------
Future Plans:
-------------
LGM SOC also supports Hardware Memory Copy engine.
The role of the HW Memory copy engine is to offload memory copy operations
from the CPU.

Amireddy Mallikarjuna reddy (2):
  dt-bindings: dma: Add bindings for intel LGM SOC
  Add Intel LGM soc DMA support.

 .../devicetree/bindings/dma/intel,ldma.yaml        |  135 ++
 drivers/dma/Kconfig                                |    2 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/lgm/Kconfig                            |    9 +
 drivers/dma/lgm/Makefile                           |    2 +
 drivers/dma/lgm/lgm-dma.c                          | 1765 ++++++++++++++++++++
 include/linux/dma/lgm_dma.h                        |   27 +
 7 files changed, 1941 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/intel,ldma.yaml
 create mode 100644 drivers/dma/lgm/Kconfig
 create mode 100644 drivers/dma/lgm/Makefile
 create mode 100644 drivers/dma/lgm/lgm-dma.c
 create mode 100644 include/linux/dma/lgm_dma.h

-- 
2.11.0

