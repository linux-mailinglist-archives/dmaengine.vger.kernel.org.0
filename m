Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A242DE9C55
	for <lists+dmaengine@lfdr.de>; Wed, 30 Oct 2019 14:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfJ3NcR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Oct 2019 09:32:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43354 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfJ3NcR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Oct 2019 09:32:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id n1so2306648wra.10;
        Wed, 30 Oct 2019 06:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3HZERdm7BZ8clCndeKtqfcy+2+1oIs54ICHJ06N+jdQ=;
        b=cUR1Z62KueOCDejIz0Y81htfQsUut66l8tRt6bQJ0l0BfnFvcyTmqmYVrPgeKE71PL
         47y+oAFlUVa+lIWviCS+snkpvEzSYQZmIF4e35cPY7JG3K4kIPokN5T0gADgZ5KLvrRo
         nzvrar5B8NdbbcSAZYFzACC+Ikh6fXbng2N9FNHExd1nnoGWtPeR9E3uG4h25x0x3lG+
         65XRdnnLj7StPCDn70M4uUF+tzC2nJN29xITRWjOHZ/HnKZCahgjWhCKvI1+ahsynWaA
         6mc6+Xccnm0lwP/Xz6hCuQWv+EjrupVHZTanPBSB9mmdLtA0F5JLxF6tpTWkjFMnlSBp
         oqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3HZERdm7BZ8clCndeKtqfcy+2+1oIs54ICHJ06N+jdQ=;
        b=Nt/beZNsazvG5XVE/6VO9f2V7CkCQSpKNFID/Q4Y/POh67Mf8rXauJCvfYmMXrKvo9
         Dha6IxUWgMtohGgseJlHtEjaS5BJHmG8xeAMYYwqznUSKEPsB5R5aqPxBEKUs84J0kdl
         fdpxlPzJRZz5RBwxRY1QMX2R+NYx+GN2DxWurtFep7HFgl5PXVUdUo/77wm1F4y91PJk
         Jhym1LDjEWBSvzKrnTxXwlA1ciADZtlZBrfNOA/YiBr+BYGJmBnQGB3sphbDC9lLbzPE
         QJO9Htgu37d8b3Gn1yoSxAP21DcCNxDnzMDfqiGewJPLEMCg0/2WzQ9qOI/4SbvQvHVR
         1Ebw==
X-Gm-Message-State: APjAAAVOxByGb66WQYniirRB8Gkl4AOGIbyHr6JV61AgGLJcnvxv+UNN
        cSJnWv1s6S+ejTaomdkI4a+K+TK4om8=
X-Google-Smtp-Source: APXvYqyxRqVo2c8misQDddv0sdlp6UKDBfU/iH++7ub9ySSXo1brmewqO0k08m331pNoTIfMHUt2Xw==
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr23532107wrv.99.1572442334456;
        Wed, 30 Oct 2019 06:32:14 -0700 (PDT)
Received: from localhost.localdomain ([213.86.25.14])
        by smtp.googlemail.com with ESMTPSA id r3sm357348wre.29.2019.10.30.06.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 06:32:13 -0700 (PDT)
From:   Alexander Gordeev <a.gordeev.box@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Gordeev <a.gordeev.box@gmail.com>,
        dmaengine@vger.kernel.org
Subject: [PATCH v4 0/2] dmaengine: avalon: Intel Avalon-MM DMA Interface for PCIe
Date:   Wed, 30 Oct 2019 14:32:08 +0100
Message-Id: <cover.1572441900.git.a.gordeev.box@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This series is against v5.4-rc5

Patch 1. Introduces "avalon-dma" driver that conforms to the standard
"dmaengine" model;

Patch 2. The existing "dmatest" is not meant for DMA_SLAVE type of
transfers needed by "avalon-dma" driver. Instead, custom "avalon-test"
was used to debug and stress "avalon-dma". In fact, the methology used
for testing is pretty much generic:

  - DMA to/from the remote device (memory) - oneshot or multiple times;
  - continuously run cuncurrent threads DMAing to/from the remote device;
  - using IOCTL to DMA data to/from user level;

Such functionality could be very useful for bringing up custom embedded
devices, i.e sensors, displays etc.

With some effort "avalon-test" could even be merged into the existing
"dmatest" or turned into a tool for testing any "dmaengine" compatible
driver that does not need any custom hardware specifics to initiate DMA
transfers.

I am not certain that "avalon-test" in its current form is the best way
to proceed and thus marking patch 2 as RFC. It depends on "avalon-dma",
but the two drivers are not needed to be accepted together.


Changes since v3 ("avalon-test" only):
- BUG_ONs, WARN_ONs, dev_dbgs removed goto labels renamed;
- kernel configuration options removed in favour of module parameters;
- fail paths reworked to avoid resource leaks uninitialized data crashes;
- invalid parameter checks reworked;

Changes since v2 ("avalon-dma" only):
- avalon_dma_register() return value bug fixed;
- device_prep_slave_sg() does not crash dmaengine_prep_slave_single();
- kernel configuration options removed in favour of module parameters;
- BUG_ONs, WARN_ONs, dev_dbgs removed goto labels renamed;
- polling loop in interrupt handler commented;
- cpu_relax() added to polling loop in interrupt handler;

Changes since v1:
- "avalon-dma" converted to "dmaengine" model;
- "avalon-drv" renamed to "avalon-test";

The Avalon-MM DMA Interface for PCIe is a design used in hard IPs for
Intel Arria, Cyclone or Stratix FPGAs. It transfers data between on-chip
memory and system memory.

Testing was done using a custom FPGA build with Arria 10 FPGA streaming
data to target device RAM:

  +----------+    +----------+    +----------+        +----------+
  | NIOS CPU |<-->|   RAM    |<-->|  Avalon  |<-PCIe->| Host CPU |
  +----------+    +----------+    +----------+        +----------+

The data integrity was ensured by examining target device RAM contents
(a) from host CPU (indirectly - checking data DMAed to/from the system)
and (b) from NIOS CPU that has direct access to the device RAM.

A companion tool using "avalon-test" IOCTL commands was used to DMA files:
https://github.com/a-gordeev/avalon-tool.git


CC: dmaengine@vger.kernel.org

Alexander Gordeev (2):
  dmaengine: avalon: Intel Avalon-MM DMA Interface for PCIe
  dmaengine: avalon-test: Intel Avalon-MM DMA Interface for PCIe test

 drivers/dma/Kconfig                     |   3 +
 drivers/dma/Makefile                    |   2 +
 drivers/dma/avalon-test/Kconfig         |  12 +
 drivers/dma/avalon-test/Makefile        |  14 +
 drivers/dma/avalon-test/avalon-dev.c    | 108 +++++
 drivers/dma/avalon-test/avalon-dev.h    |  33 ++
 drivers/dma/avalon-test/avalon-ioctl.c  | 100 +++++
 drivers/dma/avalon-test/avalon-ioctl.h  |  13 +
 drivers/dma/avalon-test/avalon-mmap.c   |  75 ++++
 drivers/dma/avalon-test/avalon-mmap.h   |  13 +
 drivers/dma/avalon-test/avalon-sg-buf.c | 131 ++++++
 drivers/dma/avalon-test/avalon-sg-buf.h |  27 ++
 drivers/dma/avalon-test/avalon-xfer.c   | 559 ++++++++++++++++++++++++
 drivers/dma/avalon-test/avalon-xfer.h   |  29 ++
 drivers/dma/avalon/Kconfig              |  15 +
 drivers/dma/avalon/Makefile             |  12 +
 drivers/dma/avalon/avalon-core.c        | 477 ++++++++++++++++++++
 drivers/dma/avalon/avalon-core.h        |  93 ++++
 drivers/dma/avalon/avalon-hw.c          | 187 ++++++++
 drivers/dma/avalon/avalon-hw.h          |  86 ++++
 drivers/dma/avalon/avalon-pci.c         | 145 ++++++
 include/uapi/linux/avalon-ioctl.h       |  32 ++
 22 files changed, 2166 insertions(+)
 create mode 100644 drivers/dma/avalon-test/Kconfig
 create mode 100644 drivers/dma/avalon-test/Makefile
 create mode 100644 drivers/dma/avalon-test/avalon-dev.c
 create mode 100644 drivers/dma/avalon-test/avalon-dev.h
 create mode 100644 drivers/dma/avalon-test/avalon-ioctl.c
 create mode 100644 drivers/dma/avalon-test/avalon-ioctl.h
 create mode 100644 drivers/dma/avalon-test/avalon-mmap.c
 create mode 100644 drivers/dma/avalon-test/avalon-mmap.h
 create mode 100644 drivers/dma/avalon-test/avalon-sg-buf.c
 create mode 100644 drivers/dma/avalon-test/avalon-sg-buf.h
 create mode 100644 drivers/dma/avalon-test/avalon-xfer.c
 create mode 100644 drivers/dma/avalon-test/avalon-xfer.h
 create mode 100644 drivers/dma/avalon/Kconfig
 create mode 100644 drivers/dma/avalon/Makefile
 create mode 100644 drivers/dma/avalon/avalon-core.c
 create mode 100644 drivers/dma/avalon/avalon-core.h
 create mode 100644 drivers/dma/avalon/avalon-hw.c
 create mode 100644 drivers/dma/avalon/avalon-hw.h
 create mode 100644 drivers/dma/avalon/avalon-pci.c
 create mode 100644 include/uapi/linux/avalon-ioctl.h

-- 
2.23.0

