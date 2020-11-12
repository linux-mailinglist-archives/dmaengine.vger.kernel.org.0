Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E4A2AFEE9
	for <lists+dmaengine@lfdr.de>; Thu, 12 Nov 2020 06:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgKLFlr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 Nov 2020 00:41:47 -0500
Received: from mga14.intel.com ([192.55.52.115]:12042 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728841AbgKLFix (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 12 Nov 2020 00:38:53 -0500
IronPort-SDR: ePwsw66m86wR0LMrqw7WJf9tmF7PUl82u6u2acexrIIdY0DZzjZeGOCHsisAWcgtqVW3dzeWm7
 H2CLHGJMvuFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="169476996"
X-IronPort-AV: E=Sophos;i="5.77,471,1596524400"; 
   d="scan'208";a="169476996"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 21:38:52 -0800
IronPort-SDR: 05XFbaySl5a4zsaNS3HMfc863Hhss8abiz3A15lD5OLNY/XPqbuiOPX/fTTZCo160+BC/UZ6GC
 3Ej2Vg1tkaHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,471,1596524400"; 
   d="scan'208";a="308742085"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga008.fm.intel.com with ESMTP; 11 Nov 2020 21:38:49 -0800
From:   Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
To:     dmaengine@vger.kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        chuanhua.lei@linux.intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, mallikarjunax.reddy@linux.intel.com,
        malliamireddy009@gmail.com, peter.ujfalusi@ti.com
Subject: [PATCH v9 0/2] Add Intel LGM SoC DMA support
Date:   Thu, 12 Nov 2020 13:38:44 +0800
Message-Id: <cover.1605158930.git.mallikarjunax.reddy@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add DMA controller driver for Lightning Mountain (LGM) family of SoCs.

The main function of the DMA controller is the transfer of data from/to any
peripheral to/from the memory. A memory to memory copy capability can also
be configured. This ldma driver is used for configure the device and channnels
for data and control paths.

These controllers provide DMA capabilities for a variety of on-chip
devices such as SSC, HSNAND and GSWIP.

-------------
Future Plans:
-------------
LGM SOC also supports Hardware Memory Copy engine.
The role of the HW Memory copy engine is to offload memory copy operations
from the CPU.

Amireddy Mallikarjuna reddy (2):
  dt-bindings: dma: Add bindings for Intel LGM SoC
  Add Intel LGM SoC DMA support.

 .../devicetree/bindings/dma/intel,ldma.yaml        |  130 ++
 drivers/dma/Kconfig                                |    2 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/lgm/Kconfig                            |    9 +
 drivers/dma/lgm/Makefile                           |    2 +
 drivers/dma/lgm/lgm-dma.c                          | 1742 ++++++++++++++++++++
 include/linux/dma/lgm_dma.h                        |   27 +
 7 files changed, 1913 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/intel,ldma.yaml
 create mode 100644 drivers/dma/lgm/Kconfig
 create mode 100644 drivers/dma/lgm/Makefile
 create mode 100644 drivers/dma/lgm/lgm-dma.c
 create mode 100644 include/linux/dma/lgm_dma.h

-- 
2.11.0

