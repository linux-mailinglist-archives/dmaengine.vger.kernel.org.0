Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBEFD5CC7
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2019 09:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfJNHzf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Oct 2019 03:55:35 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:36726 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728900AbfJNHzf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Oct 2019 03:55:35 -0400
Received: by mail-pg1-f176.google.com with SMTP id 23so9624856pgk.3
        for <dmaengine@vger.kernel.org>; Mon, 14 Oct 2019 00:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MNI5mn/r/9PEydTyYbiuaqnRTU24OX4PsHrUiRu8H1E=;
        b=XjAHdaytuN27WH+qMN1Na/Sgfty15Gq3pXeDtv7UFpL81s6ZtkFfeO0KjOh3WUkY79
         sUj8Ee/viGjKBeLPGQXAGXB4GlpXIEVqBTlC26OlXDppd6hQX5QvLbA+6mF1xtZRhQWe
         NsIGAp+t2mrThJhYbXYPlD8T01d/KURE0l7NVvvUPU75RWEi/xKU/L15mJtODActLRtF
         NReuM+P21xepmbaAC2XnD4jqORJHpW7vB5UZc5iRv0c3ylYtqnnFsRWQ/7PPRrUBDd3W
         Dhu77b2z3sSC3OplJ4XBYa5Uz0JRt7VZJ0F9DKWyanlFrS/VlEV0qjF5Y/tuQxlkaQLj
         pO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MNI5mn/r/9PEydTyYbiuaqnRTU24OX4PsHrUiRu8H1E=;
        b=VViPZ607d8dxDDfhgJt3IVC9BBHVvy0KkZRMmdVtTuxnb4P2kpSl2ehV5bkPwiWCfD
         NyrlxWlGc948T2jkShr9CXrEOCZBiZrKdpEjOp6Mr72EmdtD6wG4Oek+hhs8BaPytVHJ
         6LHbWOcCUKdiRF4H2eVkvj3sBuemNtQcMRH9qnvf5pWSeWmaS3JfTMTbJlKD2346bZF+
         JmcDKGBKDED+Y2QD+Jp50jMzPUo9cfx+fxhQRU7T3WijytAPpEQCGeTbAHpf36JnbAdh
         gmlvWoTywkoeeW36fk81au2WehBTLsfmBOXz0K7jAeHB9LVjGEBXKH2lNvCSx+9i+wmH
         Vmvg==
X-Gm-Message-State: APjAAAUZOJNDPqH/toNOjsaioilqZmY3DNSiu24W2eO9oFSw69TKZp1k
        ot026ketpagIm66Hn82En+d+BA==
X-Google-Smtp-Source: APXvYqzjZQsECmJcjeJL+Kb/fahhGk640iRkKNvonQHNJJ4VgDDn32GAg0181aKdTuVxeQDLgKWDVg==
X-Received: by 2002:a17:90a:b391:: with SMTP id e17mr35586164pjr.132.1571039734974;
        Mon, 14 Oct 2019 00:55:34 -0700 (PDT)
Received: from localhost.localdomain (111-241-168-233.dynamic-ip.hinet.net. [111.241.168.233])
        by smtp.gmail.com with ESMTPSA id j126sm16583137pfb.186.2019.10.14.00.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 00:55:33 -0700 (PDT)
From:   Green Wan <green.wan@sifive.com>
Cc:     linux-hackers@sifive.com, Green Wan <green.wan@sifive.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Yash Shah <yash.shah@sifive.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC v2 0/4] dmaengine: sf-pdma: Add platform dma driver
Date:   Mon, 14 Oct 2019 15:54:23 +0800
Message-Id: <20191014075502.15105-1-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add PDMA driver support for SiFive HiFive Unleashed RevA00 board. Mainly follows
DMAengine controller doc[1] to implement and take other DMA drivers as reference.
Such as

  - drivers/dma/fsl-edma.c
  - drivers/dma/dw-edma/
  - drivers/dma/pxa-dma.c

Using DMA test client[2] to test. Detailed datasheet is doc[3]. Driver supports:

 - 4 physical DMA channels, share same DONE and error interrupt handler. 
 - Support MEM_TO_MEM
 - Tested by DMA test client
 - patches include DT Bindgins document and dts for fu450-c000 SoC. Separate dts
   patch for easier review and apply to different branch or SoC platform.
 - retry 1 time if DMA error occurs.

[Reference Doc]
 [1] ./Documentation/driver-api/dmaengine/provider.rst
 [2] ./Documentation/driver-api/dmaengine/dmatest.rst
 [3] https://static.dev.sifive.com/FU540-C000-v1.0.pdf 

[Simple steps to test of DMA Test client]
 $ echo 1 > /sys/module/dmatest/parameters/iterations
 $ echo dma0chan0 > /sys/module/dmatest/parameters/channel
 $ echo dma0chan1 > /sys/module/dmatest/parameters/channel
 $ echo dma0chan2 > /sys/module/dmatest/parameters/channel
 $ echo dma0chan3 > /sys/module/dmatest/parameters/channel
 $ echo 1 > /sys/module/dmatest/parameters/run

[Expected test result]
[  267.563323] dmatest: dma0chan0-copy0: summary 45629 tests, 0 failures 38769.01 iops 309661 KB/s (0)
[  267.572427] dmatest: dma0chan1-copy0: summary 45863 tests, 0 failures 40286.85 iops 321643 KB/s (0)
[  267.581392] dmatest: dma0chan2-copy0: summary 45975 tests, 0 failures 41178.48 iops 328740 KB/s (0)
[  267.590542] dmatest: dma0chan3-copy0: summary 44768 tests, 0 failures 38560.29 iops 307726 KB/s (0)

Green Wan (4):
  dt-bindings: dmaengine: sf-pdma: add bindins for SiFive PDMA
  riscv: dts: add support for PDMA device of HiFive Unleashed Rev A00
  dmaengine: sf-pdma: add platform DMA support for HiFive Unleashed A00
  MAINTAINERS: Add Green as SiFive PDMA driver maintainer

 .../bindings/dma/sifive,fu540-c000-pdma.yaml  |  55 ++
 MAINTAINERS                                   |   6 +
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi    |   7 +
 drivers/dma/Kconfig                           |   2 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/sf-pdma/Kconfig                   |   6 +
 drivers/dma/sf-pdma/Makefile                  |   1 +
 drivers/dma/sf-pdma/sf-pdma.c                 | 601 ++++++++++++++++++
 drivers/dma/sf-pdma/sf-pdma.h                 | 124 ++++
 9 files changed, 803 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
 create mode 100644 drivers/dma/sf-pdma/Kconfig
 create mode 100644 drivers/dma/sf-pdma/Makefile
 create mode 100644 drivers/dma/sf-pdma/sf-pdma.c
 create mode 100644 drivers/dma/sf-pdma/sf-pdma.h


base-commit: 4f5cafb5cb8471e54afdc9054d973535614f7675
-- 
2.17.1

