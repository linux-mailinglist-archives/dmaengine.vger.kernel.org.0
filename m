Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867872ABE51
	for <lists+dmaengine@lfdr.de>; Mon,  9 Nov 2020 15:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbgKIOOc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Nov 2020 09:14:32 -0500
Received: from mga09.intel.com ([134.134.136.24]:23208 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730204AbgKIOOc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 9 Nov 2020 09:14:32 -0500
IronPort-SDR: U0JkdkLxc4kS0lHe2YyrL6ua0S4avkF32euQW81caRTMZ6dhCBov9FNbTefiKwgvnVOJWgNQea
 AZkxKZoIBZ2g==
X-IronPort-AV: E=McAfee;i="6000,8403,9799"; a="169960529"
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="169960529"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 06:14:31 -0800
IronPort-SDR: /2AUkUFFIHye50qeOb/wwWUcErayFXr0rCRMXb5iJ1IACz/U5c+aiNUo+FpCckFq4Jy8bipb9Q
 Ew0sV3MozvXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="307661594"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga008.fm.intel.com with ESMTP; 09 Nov 2020 06:14:28 -0800
From:   Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
To:     dmaengine@vger.kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        chuanhua.lei@linux.intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, mallikarjunax.reddy@linux.intel.com,
        malliamireddy009@gmail.com, peter.ujfalusi@ti.com
Subject: [PATCH v8 0/2] Add Intel LGM SoC DMA support
Date:   Mon,  9 Nov 2020 22:14:23 +0800
Message-Id: <cover.1604930089.git.mallikarjunax.reddy@linux.intel.com>
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
  dt-bindings: dma: Add bindings for intel LGM SOC
  Add Intel LGM soc DMA support.

 .../devicetree/bindings/dma/intel,ldma.yaml        |  134 ++
 drivers/dma/Kconfig                                |    2 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/lgm/Kconfig                            |    9 +
 drivers/dma/lgm/Makefile                           |    2 +
 drivers/dma/lgm/lgm-dma.c                          | 1742 ++++++++++++++++++++
 include/linux/dma/lgm_dma.h                        |   27 +
 7 files changed, 1917 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/intel,ldma.yaml
 create mode 100644 drivers/dma/lgm/Kconfig
 create mode 100644 drivers/dma/lgm/Makefile
 create mode 100644 drivers/dma/lgm/lgm-dma.c
 create mode 100644 include/linux/dma/lgm_dma.h

-- 
2.11.0

