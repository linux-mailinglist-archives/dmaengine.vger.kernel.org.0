Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E600A348A4
	for <lists+dmaengine@lfdr.de>; Tue,  4 Jun 2019 15:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfFDN3c (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Jun 2019 09:29:32 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:53124 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727470AbfFDN3b (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Jun 2019 09:29:31 -0400
Received: from mailhost.synopsys.com (unknown [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E8AA0C1E9B;
        Tue,  4 Jun 2019 13:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1559654981; bh=tJ5U5V5ukKoh37DG0nUj49vWOPDvxzuXMRZdBJAy5Lw=;
        h=From:To:Cc:Subject:Date:From;
        b=Af8cLjj9mV9A0c0VDl9mdEMudOGWMGPlHTJzNT4v3LVGv3gU9Eeu2xQcrkSsBy+W/
         nOU0hdOhvvXZ/3KF3GVywh/7XVE8rLfqjuBF0QSDdeImfmQ/tKvIhDnpV5z5MCQKIE
         GTFxyVNgCr9GYe+p0dXysNXTRhu5N6kD6MrgNzykgeQzZLFUhi2hkbrWbSbRk3cgU7
         aB0ePY405tzUY5MWSh4Ar5jDTzC+rja+4Ssw4LCtBa2Q+HuBFQMH4KbWpdZF+7kw/P
         +TyYf6f9xmDUXuvhEO4zO1zb2LwxL1Tt1i+Aht/rqwALaa/46J1SbsVVNY2rd68fgj
         qo5ASBryUHOPw==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 326F2A0234;
        Tue,  4 Jun 2019 13:29:28 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id D609D3FAC7;
        Tue,  4 Jun 2019 15:29:28 +0200 (CEST)
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v2 0/6] dmaengine: Add Synopsys eDMA IP driver (version 0)
Date:   Tue,  4 Jun 2019 15:29:21 +0200
Message-Id: <cover.1559654565.git.gustavo.pimentel@synopsys.com>
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

