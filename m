Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E3029A610
	for <lists+dmaengine@lfdr.de>; Tue, 27 Oct 2020 09:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508665AbgJ0ID2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Oct 2020 04:03:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:17255 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2508650AbgJ0IDZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 27 Oct 2020 04:03:25 -0400
IronPort-SDR: y8us5Kr0AMyKmw/hO8MSKyNSCJdwy6HSOLRED0ZfQ7NLd3Jz5UWq+unliSjRDbn3/T8pntL9WX
 Kk1hKN97MMvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="147326439"
X-IronPort-AV: E=Sophos;i="5.77,423,1596524400"; 
   d="scan'208";a="147326439"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 01:03:14 -0700
IronPort-SDR: UeI2iedu7Fd5nuOVyuRMymVdn/z3xtknrkFAfN28wuqWiF51G7EQO9WKYbUXGtvvxei+gIgvIY
 ySc+njmMFMVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,423,1596524400"; 
   d="scan'208";a="360665036"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Oct 2020 01:03:11 -0700
From:   Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
To:     dmaengine@vger.kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        chuanhua.lei@linux.intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, mallikarjunax.reddy@linux.intel.com,
        malliamireddy009@gmail.com, peter.ujfalusi@ti.com
Subject: [PATCH v7 0/2] Add Intel LGM soc DMA support
Date:   Tue, 27 Oct 2020 16:03:05 +0800
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

