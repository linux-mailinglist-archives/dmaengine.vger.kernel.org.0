Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20FF2E6DD8
	for <lists+dmaengine@lfdr.de>; Tue, 29 Dec 2020 06:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgL2FEu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 29 Dec 2020 00:04:50 -0500
Received: from mga03.intel.com ([134.134.136.65]:37338 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgL2FEu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 29 Dec 2020 00:04:50 -0500
IronPort-SDR: MOeomMJWICtRF4leNCZRK1cbeu0XznJq2RW7geVOjMHOZ+X2H3LFJ9Jt44Cmcq18dVu/+nUiMk
 PnaphOSivk6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="176554682"
X-IronPort-AV: E=Sophos;i="5.78,457,1599548400"; 
   d="scan'208";a="176554682"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 21:04:09 -0800
IronPort-SDR: o0jlk6iAQFAxS2D0gZJB0+KjVfAbV7c96SroTyH4DGqdjhE+NZ72k8jV7Kx41f6LKMwFlzq28s
 HRPRF1RhUKIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,457,1599548400"; 
   d="scan'208";a="347249673"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by fmsmga008.fm.intel.com with ESMTP; 28 Dec 2020 21:04:07 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v8 00/16] dmaengine: dw-axi-dmac: support Intel KeemBay AxiDMA
Date:   Tue, 29 Dec 2020 12:46:57 +0800
Message-Id: <20201229044713.28464-1-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The below patch series are to support AxiDMA running on Intel KeemBay SoC.
The base driver is dw-axi-dmac. This driver only support DMA memory copy
transfers. Code refactoring is needed so that additional features can be
supported.
The features added in this patch series are:
- Replacing Linked List with virtual descriptor management.
- Remove unrelated hw desc stuff from dma memory pool.
- Manage dma memory pool alloc/destroy based on channel activity.
- Support dmaengine device_sync() callback.
- Support dmaengine device_config().
- Support dmaengine device_prep_slave_sg().
- Support dmaengine device_prep_dma_cyclic().
- Support of_dma_controller_register().
- Support burst residue granularity.
- Support Intel KeemBay AxiDMA registers.
- Support Intel KeemBay AxiDMA device handshake.
- Support Intel KeemBay AxiDMA BYTE and HALFWORD device operation.
- Add constraint to Max segment size.
- Virtually split the linked-list.

This patch series are tested on Intel KeemBay platform.

v8:
- Rebased to kernel v5.11-rc1.
- Added reviewed-by tag from Rob.

v7:
- Added 'allOf' and '$ref:dma-controller.yaml#' in DT binding.
- Removed the dma-channels common description in DT binding.
- Removed the default fields in DT binding.

v6:
- Removed 'allOf' cases in DT binding.
- Added '>' at the end of the email address.
- Removed additional '|' at the start of description.
- Fixed space indent.
- Added proper constraint in DT binding.
- Removed second example in DT binding.

v5:
- Added comment to the Apb registers used by Intel KeemBay Soc.
- Renamed "hs_num" to "handshake_num".
- Conditional check for the compatible property and return error
  instead of printing warning.
- Added patch 16th to virtually split the linked-list as per
  request from ALSA team.

v4:
- Fixed bot found errors running make_dt_binding_check.
- Added minItems: 1 to the YAML schemas DT binding.
- Updated "reg" field to the YAML schemas DT binding.

v3:
- Added additionalProperties: false to the YAML schemas DT binding.
- Reordered patch sequence for patch 10th, 11th and 12th so that
  DT binding come first, follow by adding Intel KeemBay SoC registers
  and update .compatible field.
- Checked txstate NULL condition.
- Created helper function dw_axi_dma_set_hw_desc() to handle common code.

v2:
- Rebased to v5.10-rc1 kernel.
- Added support for dmaengine device_config().
- Added support for dmaengine device_prep_slave_sg().
- Added support for dmaengine device_prep_dma_cyclic().
- Added support for of_dma_controller_register().
- Added support for burst residue granularity.
- Added support for Intel KeemBay AxiDMA registers.
- Added support for Intel KeemBay AxiDMA device handshake.
- Added support for Intel KeemBay AxiDMA BYTE and HALFWORD device operation.
- Added constraint to Max segment size.

v1:
- Initial version. Patch on top of dw-axi-dma driver. This version improve
  the descriptor management by replacing Linked List Item (LLI) with
  virtual descriptor management, only allocate hardware LLI memories from
  DMA memory pool, manage DMA memory pool alloc/destroy based on channel
  activity and to support device_sync callback.

Sia Jee Heng (16):
  dt-bindings: dma: Add YAML schemas for dw-axi-dmac
  dmaengine: dw-axi-dmac: simplify descriptor management
  dmaengine: dw-axi-dmac: move dma_pool_create() to
    alloc_chan_resources()
  dmaengine: dw-axi-dmac: Add device_synchronize() callback
  dmaengine: dw-axi-dmac: Add device_config operation
  dmaengine: dw-axi-dmac: Support device_prep_slave_sg
  dmaegine: dw-axi-dmac: Support device_prep_dma_cyclic()
  dmaengine: dw-axi-dmac: Support of_dma_controller_register()
  dmaengine: dw-axi-dmac: Support burst residue granularity
  dt-binding: dma: dw-axi-dmac: Add support for Intel KeemBay AxiDMA
  dmaengine: dw-axi-dmac: Add Intel KeemBay DMA register fields
  dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA support
  dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA handshake
  dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA BYTE and HALFWORD
    registers
  dmaengine: dw-axi-dmac: Set constraint to the Max segment size
  dmaengine: dw-axi-dmac: Virtually split the linked-list

 .../bindings/dma/snps,dw-axi-dmac.txt         |  39 -
 .../bindings/dma/snps,dw-axi-dmac.yaml        | 126 ++++
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 710 +++++++++++++++---
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  34 +-
 4 files changed, 775 insertions(+), 134 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
 create mode 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml


base-commit: dea8dcf2a9fa8cc540136a6cd885c3beece16ec3
-- 
2.18.0

