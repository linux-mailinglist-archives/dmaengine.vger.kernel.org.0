Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04A92ABE9D
	for <lists+dmaengine@lfdr.de>; Mon,  9 Nov 2020 15:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbgKIO0L (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Nov 2020 09:26:11 -0500
Received: from mga09.intel.com ([134.134.136.24]:24094 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729454AbgKIO0L (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 9 Nov 2020 09:26:11 -0500
IronPort-SDR: pnVJxMcNCmI737Ts7Be5z1q0Tj6mwlDJTGYDoUxOFfyvpk+kDDbC1GxwZ1XZYoumcFXsTGGQEH
 1JX7ihTZ63Ig==
X-IronPort-AV: E=McAfee;i="6000,8403,9799"; a="169961952"
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="169961952"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 06:26:10 -0800
IronPort-SDR: mY2wdeebCZqKgDBEWwCXA6FJna9yWrJw4ckiD4ryWpIwFa7VLUq/25o6Fq+lb8ekm8xXZMLLyS
 6gnvrDRS8Iug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="354142722"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga008.jf.intel.com with ESMTP; 09 Nov 2020 06:26:07 -0800
From:   Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
To:     dmaengine@vger.kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        chuanhua.lei@linux.intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, mallikarjunax.reddy@linux.intel.com,
        malliamireddy009@gmail.com, peter.ujfalusi@ti.com
Subject: [PATCH v8 0/2] Add Intel LGM SoC DMA support
Date:   Mon,  9 Nov 2020 22:26:03 +0800
Message-Id: <cover.1604931666.git.mallikarjunax.reddy@linux.intel.com>
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
LGM SoC also supports Hardware Memory Copy engine.
The role of the HW Memory copy engine is to offload memory copy operations
from the CPU.

Amireddy Mallikarjuna reddy (2):
  dt-bindings: dma: Add bindings for Intel LGM SoC
  Add Intel LGM SoC DMA support.

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

