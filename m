Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67EA2F1E9D
	for <lists+dmaengine@lfdr.de>; Wed,  6 Nov 2019 20:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732544AbfKFTW5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Nov 2019 14:22:57 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36320 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732094AbfKFTW4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Nov 2019 14:22:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so640541wrx.3;
        Wed, 06 Nov 2019 11:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DGeDnMBU3pmA8xp8mQbjU2EV0w9pcuMioJOd1zEXh9U=;
        b=FG11Ys0W/c4YpdGscjkZeHVHBT1HliODXsEp6mC3drmkjbxyCObfYMYiKUpatY9jhG
         BthStaWEXCLDP8OB6TAgUyh0V/vghR9+XVtVYAcDST1yG9EZlsy2dZKLy3SrPloFvlxi
         raN9cfPkxggtrw4c6UqoIKE59yHqjH7uJKFVVH7Z2r2OjaHa8klAi27DGQ8LHM/d3Gpc
         OkM7xjK2/PMpXRUtDqppvvcFsGHXzk6IYCFmbqXVslSLqZwLKyXrWqvoh3kD//iqm6si
         lCjSfYaEV4lzkhJPqUuo3NaODnWSuQvRKnKRnYmWIKL2RJIjbQxnE5WkJLBZJcjwXPax
         uM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DGeDnMBU3pmA8xp8mQbjU2EV0w9pcuMioJOd1zEXh9U=;
        b=MYRtWiJweMGkb/tRMhJwPOV1zbUHnwCd5n7kiY2z9+DUIGk3B0ik7zopDus6sTKT56
         SkD+buC1+KNvLbniJtHMfNfrxW7wHqR1Lepsrg6LyZYyOt6llqN+RKghcelfB7brop+b
         lubsLM+q/0w9mFV0PsZfMPx2kkFd2ZjoCl0CByByQqFU7lpOF+HD5sCgwQbHxvjjia8s
         PDqj43bQFKJyi6zRuOJPLB2WtS5HBFUbRjQPB0YD5Q+PV5uHVPQYDc7OLj08c3shh5Gm
         8KdGcsvHo2/G3ChD4+9CeyjfHKGHXndag1J25ezvsP/NdMxAxMMv1bLlutQRROFgjP79
         66Wg==
X-Gm-Message-State: APjAAAW4okSLjEETeHvQJ90QFJ635NXULd3I0e7gUBpM8bRKAbgNRFnk
        4Ku7MW3NndYWmkpCUkfQTdv/UK4SpKk=
X-Google-Smtp-Source: APXvYqwJ9NQZetR50im9dFL9Yv2sW7+90cx/v5irwTt+3oz21K0smKGGhqpGYm/c4ktemJWLGhSQAQ==
X-Received: by 2002:adf:c402:: with SMTP id v2mr4483761wrf.323.1573068173245;
        Wed, 06 Nov 2019 11:22:53 -0800 (PST)
Received: from localhost.localdomain ([213.86.25.46])
        by smtp.googlemail.com with ESMTPSA id h7sm2331175wmb.37.2019.11.06.11.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 11:22:52 -0800 (PST)
From:   Alexander Gordeev <a.gordeev.box@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Gordeev <a.gordeev.box@gmail.com>,
        dmaengine@vger.kernel.org
Subject: [PATCH v5 0/2] dmaengine: avalon: Intel Avalon-MM DMA Interface forPCIe
Date:   Wed,  6 Nov 2019 20:22:40 +0100
Message-Id: <cover.1573052725.git.a.gordeev.box@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This series is against v5.4-rc6

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
but the two drivers are not necessary to go along.


Changes since v4:
- kbuild test robot reported issues fixed;

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
  dmaengine: avalon-dma: Intel Avalon-MM DMA Interface for PCIe
  dmaengine: avalon-test: Intel Avalon-MM DMA Interface for PCIe test

 drivers/dma/Kconfig                     |   3 +
 drivers/dma/Makefile                    |   2 +
 drivers/dma/avalon-test/Kconfig         |  12 +
 drivers/dma/avalon-test/Makefile        |  14 +
 drivers/dma/avalon-test/avalon-dev.c    | 108 +++++
 drivers/dma/avalon-test/avalon-dev.h    |  33 ++
 drivers/dma/avalon-test/avalon-ioctl.c  | 101 +++++
 drivers/dma/avalon-test/avalon-ioctl.h  |  13 +
 drivers/dma/avalon-test/avalon-mmap.c   |  74 +++
 drivers/dma/avalon-test/avalon-mmap.h   |  13 +
 drivers/dma/avalon-test/avalon-sg-buf.c | 132 ++++++
 drivers/dma/avalon-test/avalon-sg-buf.h |  27 ++
 drivers/dma/avalon-test/avalon-xfer.c   | 575 ++++++++++++++++++++++++
 drivers/dma/avalon-test/avalon-xfer.h   |  29 ++
 drivers/dma/avalon/Kconfig              |  15 +
 drivers/dma/avalon/Makefile             |  12 +
 drivers/dma/avalon/avalon-core.c        | 477 ++++++++++++++++++++
 drivers/dma/avalon/avalon-core.h        |  92 ++++
 drivers/dma/avalon/avalon-hw.c          | 187 ++++++++
 drivers/dma/avalon/avalon-hw.h          |  86 ++++
 drivers/dma/avalon/avalon-pci.c         | 145 ++++++
 include/uapi/linux/avalon-ioctl.h       |  34 ++
 22 files changed, 2184 insertions(+)
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


base-commit: a99d8080aaf358d5d23581244e5da23b35e340b9
-- 
2.24.0

