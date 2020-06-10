Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A675D1F5469
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2020 14:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgFJMTf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 10 Jun 2020 08:19:35 -0400
Received: from mga07.intel.com ([134.134.136.100]:42305 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728540AbgFJMTf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 10 Jun 2020 08:19:35 -0400
IronPort-SDR: 3syKbqmVcKn19g8fhwDnbCBDjWXMLOZF8nQcVFYR9buNqI2TgWtAdmjBBDJ3T6l+dsMpQUFZl4
 YbWU8ScOLvoQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 05:19:34 -0700
IronPort-SDR: iQnS+2TeSpXWWy9Frd9LkLSM0b66DreyvmOvysbvmcLDc1I9YpoQAV3Sx6hGwjO1bkt3tENwlH
 3LP1GlgHJvUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,495,1583222400"; 
   d="scan'208";a="473405887"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jun 2020 05:19:31 -0700
From:   Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
To:     dmaengine@vger.kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        chuanhua.lei@linux.intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, malliamireddy009@gmail.com,
        Amireddy Mallikarjuna reddy 
        <mallikarjunax.reddy@linux.intel.com>
Subject: [PATCH 0/2] Add Intel LGM soc DMA support
Date:   Wed, 10 Jun 2020 20:17:54 +0800
Message-Id: <cover.1591790337.git.mallikarjunax.reddy@linux.intel.com>
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
 drivers/dma/lgm/lgm-dma.c                          | 1951 ++++++++++++++++++++
 6 files changed, 2393 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/intel,ldma.yaml
 create mode 100644 drivers/dma/lgm/Kconfig
 create mode 100644 drivers/dma/lgm/Makefile
 create mode 100644 drivers/dma/lgm/lgm-dma.c

-- 
2.11.0

