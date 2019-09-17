Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 365C9B4758
	for <lists+dmaengine@lfdr.de>; Tue, 17 Sep 2019 08:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403789AbfIQGVw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Sep 2019 02:21:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37669 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403770AbfIQGVw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Sep 2019 02:21:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id y5so1519515pfo.4
        for <dmaengine@vger.kernel.org>; Mon, 16 Sep 2019 23:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TEwv74xGLonyUSKE60jjZa5xk8QOk2YknSg9pzIDLUg=;
        b=hqtP5Y5Yq0jTC+rzc24KLymUET1TvjR5Y0h0InG8LyO11aFL6tcFT4iNkH7I8UE0cG
         BkL+UFsADnhEeTHQVVAFR/CIbBedh/b99DDqdbtI95cPJFVOg52P+hHJ5fttXtZMAV47
         Bg2l9DukDANYWyHYtsQ+dhUxhshOXh8Ovl9FufVg6Xwzh/Q/mI9wNqhwApTqY2yTvuUm
         pV1Lnm0ODH7TzRPdyw7wz8WEvymt0Y/5SnZR7ZNHZ64hkwUux3oVuUDYtLLfeHq4akZ2
         1vko4JDd//qfnAiZNtrQ12E2waVNv7BvHpJNqf6m1yVqOiufEw+fkvPJaaBHIo6pH17M
         oa2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TEwv74xGLonyUSKE60jjZa5xk8QOk2YknSg9pzIDLUg=;
        b=QQSCLECzR1p9ooEYYnR8meN55B+953gdCNC84SZi0D/XMNnf9rp6sQ/M/D5pSfEebg
         695apKzLV/gJ2H3fNYVUwmuJavwZ1eXDQwo69ESAwiJktXI6xyYmt90/mEBGPZXMJpWI
         gr34kvk9YSZDamp4dD55Rc+h7GSL3UpEvPU2htKCRb0nBV4Cn2GeEwTgjVRWn8bgFHhH
         +LrP3QdkSPtpzXrShq4fs1qkEQ7hT8n3ZEuYAh8oIVn5wXPO4G9lUKo5ajAno2pLdFr0
         NZ3aAUgXAi75j3GVN7tTSecjNNZT+Pth4njuLLAFEtCMAnhQIiLj4cPM62pQsLw+fWwU
         HGrg==
X-Gm-Message-State: APjAAAXxVma2w9Gd27EKJqkHlYi9q0oieTOHOeoINUglUWI7cqAlT8Nl
        4MqLBBgHfOqQR3tzH39zfxg9Hg==
X-Google-Smtp-Source: APXvYqwNofpu/24HvPIr7zem7L9ISS92QBaKN3qeRCbMyGyJm5Y2QMYLHzoNduJ2Ml4wyt2+Tr/SoQ==
X-Received: by 2002:a65:6802:: with SMTP id l2mr1831103pgt.33.1568701311473;
        Mon, 16 Sep 2019 23:21:51 -0700 (PDT)
Received: from localhost.localdomain (111-241-124-228.dynamic-ip.hinet.net. [111.241.124.228])
        by smtp.gmail.com with ESMTPSA id 127sm931089pgi.46.2019.09.16.23.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 23:21:49 -0700 (PDT)
From:   Green Wan <green.wan@sifive.com>
Cc:     linux-hackers@sifive.com, Green Wan <green.wan@sifive.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3]  dmaengine: sf-pdma: Add platform dma driver
Date:   Tue, 17 Sep 2019 14:20:46 +0800
Message-Id: <20190917062119.693-1-green.wan@sifive.com>
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

Green Wan (3):
  dt-bindings: dmaengine: sf-pdma: add bindins for SiFive PDMA
  riscv: dts: add support for PDMA device of HiFive Unleashed Rev A00
  dmaengine: sf-pdma: add platform DMA support for HiFive Unleashed A00

 .../bindings/dma/sifive,fu540-c000-pdma.yaml  |  63 ++
 MAINTAINERS                                   |   6 +
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi    |   7 +
 drivers/dma/Kconfig                           |   2 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/sf-pdma/Kconfig                   |   6 +
 drivers/dma/sf-pdma/Makefile                  |   1 +
 drivers/dma/sf-pdma/sf-pdma.c                 | 609 ++++++++++++++++++
 drivers/dma/sf-pdma/sf-pdma.h                 | 124 ++++
 9 files changed, 819 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
 create mode 100644 drivers/dma/sf-pdma/Kconfig
 create mode 100644 drivers/dma/sf-pdma/Makefile
 create mode 100644 drivers/dma/sf-pdma/sf-pdma.c
 create mode 100644 drivers/dma/sf-pdma/sf-pdma.h

-- 
2.17.1

