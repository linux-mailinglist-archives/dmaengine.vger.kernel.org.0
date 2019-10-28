Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C689E6DA0
	for <lists+dmaengine@lfdr.de>; Mon, 28 Oct 2019 08:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731143AbfJ1H5k (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Oct 2019 03:57:40 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:37561 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730552AbfJ1H5k (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Oct 2019 03:57:40 -0400
Received: by mail-pg1-f176.google.com with SMTP id p1so6365864pgi.4
        for <dmaengine@vger.kernel.org>; Mon, 28 Oct 2019 00:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0tOD6xTgafBMzD/bQT7mA2BK+hDrqf70u3fKrnf/Mq8=;
        b=VRinFB+OJkAI+0T8PjMCYoRQof4sh3mxSQmc2bhFFpv5fQnmTVGIpuPnVScat+4NDl
         ZfRqSL4DtLJ9PjAZwFTE/XRKr4Bk1fpmj9A9em4QCzb4LfkN5SdZoXeOGc3DLup8wy/H
         IF7JO+Bh9BZmkQ5Pm0SqNPbOxgL3IJGtRmuPB/z3oWOEJp0ycpzuH64hWYIPpWd+spaC
         x7+S+69A4ONXZxmM5bQnJFxLEtv+K8ExMnoogG3mcYRaEsRDXB4hYOE53bNQCmiZHvVn
         9ladJtnMbBlAT+rQYn/+3maNCNUOUCEMApRmhSl/25xXFr+LpUW3gmtshzX79xsMhb3Y
         b0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0tOD6xTgafBMzD/bQT7mA2BK+hDrqf70u3fKrnf/Mq8=;
        b=bnAqLdqOTB7mwGOpIfqf/TyeeQlZYwafDykcogK+sFhN/vX13iGDJujDqaQ2xp4BPX
         UOntjcgMzG4v8pf7huUqb8vHs/hZkMj+5ejOysZZRI49Veu0mO0NKzPUeVlgzbNNwdUn
         8CD4mPiKb2K1bSLkkwUqBtTH827xhzv/hTpCXL/rvWC5LKUvE97d3DSdpFq6Eldjw7TA
         gJxDA7eZvI1NDnbt2IBnqD4XZaKQ7iLsBmfpcvtaSGFXY5PQtg8jS0ofb8QEeuSWJMat
         iMjQIkb31uMHiLut17Zim9/+jeNN6QJuSI/H0a/xkXYs/+vOqYwBCeul/YKqQxkLGytd
         64KQ==
X-Gm-Message-State: APjAAAWiSLXPFrlFEf+6Rzfb2vHyNQL4rsKE8NfZSylMbI58EQ8ZhHPg
        ZqKdiVYBcdVTayO7bXe/bpUK9w==
X-Google-Smtp-Source: APXvYqz+AAFzlNhGkv597kxEls8SCGWc37dH13XlmSzuhKJPPkYP/vWnh+D92sxsTEH0WNQUaCTWjA==
X-Received: by 2002:a63:4b54:: with SMTP id k20mr19750139pgl.70.1572249459319;
        Mon, 28 Oct 2019 00:57:39 -0700 (PDT)
Received: from localhost.localdomain (111-241-170-106.dynamic-ip.hinet.net. [111.241.170.106])
        by smtp.gmail.com with ESMTPSA id y36sm9504752pgk.66.2019.10.28.00.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 00:57:38 -0700 (PDT)
From:   Green Wan <green.wan@sifive.com>
Cc:     Green Wan <green.wan@sifive.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
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
Subject: [PATCH v5 0/4] dmaengine: sf-pdma: Add platform dma driver
Date:   Mon, 28 Oct 2019 15:56:19 +0800
Message-Id: <20191028075658.12143-1-green.wan@sifive.com>
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
 drivers/dma/sf-pdma/sf-pdma.c                 | 602 ++++++++++++++++++
 drivers/dma/sf-pdma/sf-pdma.h                 | 123 ++++
 9 files changed, 803 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
 create mode 100644 drivers/dma/sf-pdma/Kconfig
 create mode 100644 drivers/dma/sf-pdma/Makefile
 create mode 100644 drivers/dma/sf-pdma/sf-pdma.c
 create mode 100644 drivers/dma/sf-pdma/sf-pdma.h


base-commit: d6d5df1db6e9d7f8f76d2911707f7d5877251b02
-- 
2.17.1

