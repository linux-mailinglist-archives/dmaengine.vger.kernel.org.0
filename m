Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 389AAB73FF
	for <lists+dmaengine@lfdr.de>; Thu, 19 Sep 2019 09:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732001AbfISH0p (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 Sep 2019 03:26:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39167 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731914AbfISH0p (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 Sep 2019 03:26:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so1362986pgi.6
        for <dmaengine@vger.kernel.org>; Thu, 19 Sep 2019 00:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LT2z44LmrD8QiD0ZavUH6kqFzDYzxRxS7Yx8XNbtmgg=;
        b=CtQFocnZL4WmYuwxWCYhyEntS5rlt+d1KJfZ+HqgKSog1hBrz8eBhoC7C/vROml3Oh
         AS++a3QV9CsqrBUzgONj0CPB5SzjdH18bMPKvGgPA/TopigokdBDKHJTdr2MO1vdwu9A
         oyCWz79UboRAvyHMV8QE2A7lSeDLGuy7FrLbe9azF3v/ppn5HSRegEli0MrxXI71FkLn
         7yfJlz4wFoUsQnY8gyFCjw+j4+J/lNhR4t6muGEMsg+gZJDjn/b2iBzpZqO4xYbYZDtE
         6QkI5t16FOK6ssoLnkapKTHBxwKZrINNCZ9xNk6K4eQVuS85UDsRcxDa4Ln//yQ10cn8
         PDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LT2z44LmrD8QiD0ZavUH6kqFzDYzxRxS7Yx8XNbtmgg=;
        b=Ha9QLjeT9/RSW+R9jvZI0jp76FpmNFP+SU1nl11ihXhO0EY/+bf//OeET7wpc79QXa
         PXLCi5gxTIDnjkbokvJgNSDlVOuvJ7wxO3dQNhHK6Y1Iso4SG5gSdDZ2KVfKrKH7vy5Y
         NLDoUMQknPSETfFI8JSh8rS6bud1IfJYnsQbN6SuFuAnaH++R3nKRml7V+S2MW1shCKb
         8fx2L/b1htCkEf6HWuOphoKhccj5Mrym9F100GRxMcxw3nd8sVJUg5glUl3uobhh0Uo2
         nJ1U4pRz5jnlYTIPg6JqFo7bhEW9PrOOoAXdHwMFbeXxw6roIPwiWxPU1ciIDwyUYho0
         szHw==
X-Gm-Message-State: APjAAAUSumRBlqTWoD3ZFRIvL+0bFZeplOoa7CDL9X2AqquqWVko2G6Z
        aj2TNSeI5ybXXcZ1mmXO2oIkRw==
X-Google-Smtp-Source: APXvYqzj/tUGOJg5wnHc5YqepfesJlG4rD39ze0qs4Fw4GBM+v3Y4zCzaZ44ydGQGaexDNA219KQ3A==
X-Received: by 2002:a63:3c46:: with SMTP id i6mr7623466pgn.18.1568878004335;
        Thu, 19 Sep 2019 00:26:44 -0700 (PDT)
Received: from localhost.localdomain (36-228-113-219.dynamic-ip.hinet.net. [36.228.113.219])
        by smtp.gmail.com with ESMTPSA id b2sm10453620pfd.81.2019.09.19.00.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 00:26:43 -0700 (PDT)
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
Subject: [PATCH v2 0/3] dmaengine: sf-pdma: Add platform dma driver
Date:   Thu, 19 Sep 2019 15:26:03 +0800
Message-Id: <20190919072634.1885-1-green.wan@sifive.com>
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
 drivers/dma/sf-pdma/sf-pdma.c                 | 623 ++++++++++++++++++
 drivers/dma/sf-pdma/sf-pdma.h                 | 124 ++++
 9 files changed, 833 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
 create mode 100644 drivers/dma/sf-pdma/Kconfig
 create mode 100644 drivers/dma/sf-pdma/Makefile
 create mode 100644 drivers/dma/sf-pdma/sf-pdma.c
 create mode 100644 drivers/dma/sf-pdma/sf-pdma.h

-- 
2.17.1

