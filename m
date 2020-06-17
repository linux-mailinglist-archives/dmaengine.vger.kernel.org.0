Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8988B1FC884
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2020 10:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgFQI0R (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 Jun 2020 04:26:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:62189 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgFQI0R (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 17 Jun 2020 04:26:17 -0400
IronPort-SDR: b03ebYzJCKEwVtyUb5q0ZLgQ5xsZNGE+oWUptTa1kaGdN+dyxk/RX5LbpMXC9arnu69fM1t/xV
 c6jny6L4o4gA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 01:26:16 -0700
IronPort-SDR: ClAgj9I4E/Zpn+F9GR6itX/rnw6INr5SQdLLl1eQalKV6+L1d4WJy+w7M8rd56H1uEBstktx0G
 GHpO3Hj9hGIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,522,1583222400"; 
   d="scan'208";a="421061631"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga004.jf.intel.com with ESMTP; 17 Jun 2020 01:26:13 -0700
From:   Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
To:     dmaengine@vger.kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        chuanhua.lei@linux.intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, malliamireddy009@gmail.com,
        Amireddy Mallikarjuna reddy 
        <mallikarjunax.reddy@linux.intel.com>
Subject: [PATCH v2 0/2] Add Intel LGM soc DMA support
Date:   Wed, 17 Jun 2020 16:24:28 +0800
Message-Id: <cover.1592381244.git.mallikarjunax.reddy@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: dmaengine-owner@vger.kernel.org
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

 .../devicetree/bindings/dma/intel,ldma.yaml        |  428 +++++
 drivers/dma/Kconfig                                |    2 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/lgm/Kconfig                            |    9 +
 drivers/dma/lgm/Makefile                           |    2 +
 drivers/dma/lgm/lgm-dma.c                          | 1956 ++++++++++++++++++++
 include/linux/dma/lgm_dma.h                        |   27 +
 7 files changed, 2425 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/intel,ldma.yaml
 create mode 100644 drivers/dma/lgm/Kconfig
 create mode 100644 drivers/dma/lgm/Makefile
 create mode 100644 drivers/dma/lgm/lgm-dma.c
 create mode 100644 include/linux/dma/lgm_dma.h


base-commit: b3a9e3b9622ae10064826dccb4f7a52bd88c7407
-- 
2.11.0

