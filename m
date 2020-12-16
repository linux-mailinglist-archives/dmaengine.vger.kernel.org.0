Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F1C2DB9E7
	for <lists+dmaengine@lfdr.de>; Wed, 16 Dec 2020 05:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbgLPEKa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Dec 2020 23:10:30 -0500
Received: from mga14.intel.com ([192.55.52.115]:35424 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725274AbgLPEKa (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Dec 2020 23:10:30 -0500
IronPort-SDR: OHNbDl7sRfgs44z3s8nzRd1pEpzYvSDBYuDCnBb4SxM5vFnlZIObVyliGnVmvuvUJsoGBwEINR
 8KwRH11rAvaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="174227979"
X-IronPort-AV: E=Sophos;i="5.78,423,1599548400"; 
   d="scan'208";a="174227979"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 20:08:44 -0800
IronPort-SDR: jk3Nl9CetlgKdEPSGcVk9zQdB7R7Ii+0F6Wisu9OTK+7GhvqeDvHdCnhoh9hgRmGot95OqW3/M
 7sxDzWwVCdaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,423,1599548400"; 
   d="scan'208";a="368661602"
Received: from sgsxdev004.isng.phoenix.local (HELO localhost) ([10.226.81.179])
  by orsmga008.jf.intel.com with ESMTP; 15 Dec 2020 20:08:40 -0800
From:   Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
To:     dmaengine@vger.kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        chuanhua.lei@linux.intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, mallikarjunax.reddy@linux.intel.com,
        malliamireddy009@gmail.com, peter.ujfalusi@ti.com
Subject: [RESEND PATCH v10 0/2] Add Intel LGM SoC DMA support
Date:   Wed, 16 Dec 2020 12:08:34 +0800
Message-Id: <cover.1608090736.git.mallikarjunax.reddy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add DMA controller driver for Lightning Mountain (LGM) family of SoCs.

The main function of the DMA controller is the transfer of data from/to any
peripheral to/from the memory. A memory to memory copy capability can also
be configured. This ldma driver is used for configure the device and channnels
for data and control paths.

These controllers provide DMA capabilities for a variety of on-chip
devices such as SSC, HSNAND and GSWIP (Gigabit Switch IP).

-------------
Future Plans:
-------------
LGM SOC also supports Hardware Memory Copy engine.
The role of the HW Memory copy engine is to offload memory copy operations
from the CPU.

Amireddy Mallikarjuna reddy (2):
  dt-bindings: dma: Add bindings for Intel LGM SoC
  Add Intel LGM SoC DMA support.

 .../devicetree/bindings/dma/intel,ldma.yaml   |  116 ++
 drivers/dma/Kconfig                           |    2 +
 drivers/dma/Makefile                          |    1 +
 drivers/dma/lgm/Kconfig                       |    9 +
 drivers/dma/lgm/Makefile                      |    2 +
 drivers/dma/lgm/lgm-dma.c                     | 1739 +++++++++++++++++
 6 files changed, 1869 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/intel,ldma.yaml
 create mode 100644 drivers/dma/lgm/Kconfig
 create mode 100644 drivers/dma/lgm/Makefile
 create mode 100644 drivers/dma/lgm/lgm-dma.c
---
v1:
- Initial version.

v2:
- Fix device tree bot issues, correspondign driver changes done.
- Fix kerntel test robot warnings.
  --------------------------------------------------------
  >> drivers/dma/lgm/lgm-dma.c:729:5: warning: no previous prototype for function 'intel_dma_chan_desc_cfg' [-Wmissing-prototypes]
  int intel_dma_chan_desc_cfg(struct dma_chan *chan, dma_addr_t desc_base,
  ^
  drivers/dma/lgm/lgm-dma.c:729:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
  int intel_dma_chan_desc_cfg(struct dma_chan *chan, dma_addr_t desc_base,
  ^
  static
  1 warning generated.

  vim +/intel_dma_chan_desc_cfg +729 drivers/dma/lgm/lgm-dma.c

    728
  > 729 int intel_dma_chan_desc_cfg(struct dma_chan *chan, dma_addr_t desc_base,
    730                             int desc_num)
    731 {
    732         return ldma_chan_desc_cfg(to_ldma_chan(chan), desc_base, desc_num);
    733 }
    734 EXPORT_SYMBOL_GPL(intel_dma_chan_desc_cfg);
    735

   Reported-by: kernel test robot <lkp@intel.com>
   ---------------------------------------------------------------

v3:
- Fix smatch warning.
  ----------------------------------------------------------------
  smatch warnings:
  drivers/dma/lgm/lgm-dma.c:1306 ldma_cfg_init() error: uninitialized symbol 'ret'.

  Reported-by: kernel test robot <lkp@intel.com>
  Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
  ----------------------------------------------------------------

v4:
- Address Thomas Langer comments in dtbinding and corresponding driver side changes.
- Driver side changes to corresponding device tree changes.

v5:
- Add changes to read 'dmas' properties and update the config properties driver side.
- Add virt_dma_desc utilizes virt-dma API.

v6:
- Driver changes corresponding to the device tree changes.
- Restructure things to have less activity with the spinlock.
- Save the slave config in dma_slave_config() and used in prepare time.
- Addressed & fixed issues related to desc_free callback _free_ up the memory.
- Addressed peter review comments.

v7:
- Change bool to tristate in Kconfig
- Explained the _initcall()
- change of_property*() to device_property_*()
- split the code to functions at version checks
- Remove the dma caller capability restrictions
- used for_each_set_bit()
- Addressed minor comments and fine tune the code.

v7-resend:
- rebase to 5.10-rc1
- No change.

v8:
- rebase to 5.10-rc3
- Addressed structural things and fine tune the code.

v9:
- No change.

v10:
- rebase to 5.10-rc6
- Used helpers in bitfield.h (FIELD_PREP ()) instead of bit fields to set the descriptor fields.
- Removed local copy of dmaengine ops.
- Removed custom API and used dmaengine callback & remove include/linux/dma/lgm_dma.h file
- Moved dt properties to driver data.
- Fine tune the code.

v10-resend:
- rebased to 5.10
- No change.
-- 
2.17.1

