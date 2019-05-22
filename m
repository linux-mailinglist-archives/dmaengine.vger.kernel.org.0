Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B842626686
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2019 17:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbfEVPEK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 May 2019 11:04:10 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:40802 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728674AbfEVPEK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 May 2019 11:04:10 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6471EC0C7C;
        Wed, 22 May 2019 15:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1558537436; bh=tJ5U5V5ukKoh37DG0nUj49vWOPDvxzuXMRZdBJAy5Lw=;
        h=From:To:Cc:Subject:Date:From;
        b=b6Hh4aRYoU3do7kP8CvRl41mtMen3Dib3DQyjdapUbauUXajx5+wy9iHcFtOy/OiR
         pQa2yGRG3AjW4eP99liENZwRoB6aqRQCxwZaFEY3H9DHP5lRMIY31mMi2W+c96UDLJ
         5J+qqJ1AxZ8CG5zJX/WShJ9S8Bg+b7auN1VuilitpWE90KOuQeq3GMX3Y5Y9Pz5xgD
         uRC0GRZ9tOSZeQUFjPZ7zsawHvJrgKb8VVQmdrwhcCl/GILjW5+9mEsAPuHAMcC46k
         SIBd0e7EWTly8/0bOCxWg8EGgxNNASx44rPpvsJ5Wt3BISh3gukjMvIOl3XcpvVQjZ
         KJ78rvZjYEK4A==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 838EFA0093;
        Wed, 22 May 2019 15:04:09 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 7F6003F057;
        Wed, 22 May 2019 17:04:08 +0200 (CEST)
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH 0/6] dmaengine: Add Synopsys eDMA IP driver (version 0)
Date:   Wed, 22 May 2019 17:03:59 +0200
Message-Id: <cover.1558536991.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add Synopsys eDMA IP driver (version 0 and for EP side only) to Linux
kernel. This IP is generally distributed with Synopsys PCIe EndPoint IP
(depends of the use and licensing agreement), which supports:
 - legacy and unroll modes
 - 16 independent and concurrent channels (8 write + 8 read)
 - supports linked list (scatter-gather) transfer
 - each linked list descriptor can transfer from 1 byte to 4 Gbytes
 - supports cyclic transfer
 - PCIe EndPoint glue-logic

This patch series contains:
 - eDMA core + eDMA core v0 driver (implements the interface with
 DMAengine controller APIs and interfaces with eDMA HW block)
 - eDMA PCIe glue-logic reference driver (attaches to Synopsys EP and
 provides memory access to eDMA core driver)

Gustavo Pimentel (6):
  dmaengine: Add Synopsys eDMA IP core driver
  dmaengine: Add Synopsys eDMA IP version 0 support
  dmaengine: Add Synopsys eDMA IP version 0 debugfs support
  PCI: Add Synopsys endpoint EDDA Device ID
  dmaengine: Add Synopsys eDMA IP PCIe glue-logic
  MAINTAINERS: Add Synopsys eDMA IP driver maintainer

 MAINTAINERS                              |   7 +
 drivers/dma/Kconfig                      |   2 +
 drivers/dma/Makefile                     |   1 +
 drivers/dma/dw-edma/Kconfig              |  18 +
 drivers/dma/dw-edma/Makefile             |   7 +
 drivers/dma/dw-edma/dw-edma-core.c       | 937 +++++++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-core.h       | 165 ++++++
 drivers/dma/dw-edma/dw-edma-pcie.c       | 229 ++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c    | 354 ++++++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.h    |  28 +
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 310 ++++++++++
 drivers/dma/dw-edma/dw-edma-v0-debugfs.h |  27 +
 drivers/dma/dw-edma/dw-edma-v0-regs.h    | 158 ++++++
 drivers/misc/pci_endpoint_test.c         |   2 +-
 include/linux/dma/edma.h                 |  47 ++
 include/linux/pci_ids.h                  |   1 +
 16 files changed, 2292 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/dw-edma/Kconfig
 create mode 100644 drivers/dma/dw-edma/Makefile
 create mode 100644 drivers/dma/dw-edma/dw-edma-core.c
 create mode 100644 drivers/dma/dw-edma/dw-edma-core.h
 create mode 100644 drivers/dma/dw-edma/dw-edma-pcie.c
 create mode 100644 drivers/dma/dw-edma/dw-edma-v0-core.c
 create mode 100644 drivers/dma/dw-edma/dw-edma-v0-core.h
 create mode 100644 drivers/dma/dw-edma/dw-edma-v0-debugfs.c
 create mode 100644 drivers/dma/dw-edma/dw-edma-v0-debugfs.h
 create mode 100644 drivers/dma/dw-edma/dw-edma-v0-regs.h
 create mode 100644 include/linux/dma/edma.h

-- 
2.7.4

