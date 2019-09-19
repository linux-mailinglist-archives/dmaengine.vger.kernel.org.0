Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF693B76D0
	for <lists+dmaengine@lfdr.de>; Thu, 19 Sep 2019 11:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389041AbfISJ7U (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 Sep 2019 05:59:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46165 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388956AbfISJ7T (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 Sep 2019 05:59:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id o18so2363047wrv.13;
        Thu, 19 Sep 2019 02:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6YboXs4mQIylOrMolQVGgl1HM0og05CGlsxjYW+iH7k=;
        b=qTu9xgntVL5lvm8X1qZsU5crk286GN6BEL/GGXbnJf64rW/GM+EUt0Bu8yDv8CmWWY
         xf0qCzH/cdoopyoFtP/Nv/TeXDYeGJxg0hymnHWeAaLlbsdi9PxQqls0t0Ek9aHE6ckI
         Z2nVvxM8HFr6f/UQnaS98vIMA6blz3OI/WrfnjnqmMSLgissuunGJuxSX6gYsOncqqYV
         2jnlCNy1rNjflyG2FVCfGJoO94M7K49xiCoQqGZAIQrjjbOQTNxEBaLMv50mhDFDVXFu
         d8OwtzzZxwiBCV6Njl4tkOyRZCJlIZpC2MEZc4ROjPr3vEy8WmweZfDpx80RBJT3ZyID
         64Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6YboXs4mQIylOrMolQVGgl1HM0og05CGlsxjYW+iH7k=;
        b=FG27jgilOJ7yuR10XVZ8DJQQjXrMOiyh5IT+Y/YTEg/KQwi8IDfvNb12UvsOFvnbMp
         clYFRl89LAnYXKZmZJq0h8+dvH6Q9AzUNG+S1+jbklPyn7TtMIiSXq4QeGOSeMPtU9BL
         w2KfVWdZQ30AXWwtuAjl5h4NkIO6gPqUwkl6qZ9oRsaKL6+76/KNWi78sgk2IwbJHCdB
         YsGkOVKecpYH5A7U/TPnuQyBy0pmX83IyFD76JkxMi+mcPj/iU/ZF70AZjjAYnJi1kvX
         MZrFkbO14JRuk0U2INOwyI4g9RK3Mwo161jztbAVWNdfREIgYod8pzQNGOq9wDl5qext
         Vu3g==
X-Gm-Message-State: APjAAAUE4jXvOwdmKrt2su86uHvmuiad2pqIMW5XgvjLhQIlQx3dExgE
        uAGUsj2AO1FFQjm5e+1KZ/TsTtKT
X-Google-Smtp-Source: APXvYqwkccDuJHbaNPpKriH1ct1LstdVeisfChkzu85ct1d5VdtuJTBELwZtNELGqXp7JiqyE7uhWA==
X-Received: by 2002:a5d:4745:: with SMTP id o5mr6250925wrs.125.1568887156690;
        Thu, 19 Sep 2019 02:59:16 -0700 (PDT)
Received: from localhost.localdomain ([213.86.25.14])
        by smtp.googlemail.com with ESMTPSA id y186sm10037704wmb.41.2019.09.19.02.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 02:59:15 -0700 (PDT)
From:   Alexander Gordeev <a.gordeev.box@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Gordeev <a.gordeev.box@gmail.com>,
        Michael Chen <micchen@altera.com>, devel@driverdev.osuosl.org,
        dmaengine@vger.kernel.org
Subject: [PATCH RFC 0/2] staging: Support Avalon-MM DMA Interface for PCIe
Date:   Thu, 19 Sep 2019 11:59:11 +0200
Message-Id: <cover.1568817357.git.a.gordeev.box@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The Avalon-MM DMA Interface for PCIe is a design found in hard IPs for
Intel Arria, Cyclone or Stratix FPGAs. It transfers data between on-chip
memory and system memory. This RFC is an attempt to provide a generic API:

	typedef void (*avalon_dma_xfer_callback)(void *dma_async_param);
 
	int avalon_dma_submit_xfer(
		struct avalon_dma *avalon_dma,
		enum dma_data_direction direction,
		dma_addr_t dev_addr, dma_addr_t host_addr,
		unsigned int size,
		avalon_dma_xfer_callback callback,
		void *callback_param);
 
	int avalon_dma_submit_xfer_sg(struct avalon_dma *avalon_dma,
		enum dma_data_direction direction,
		dma_addr_t dev_addr,
		struct sg_table *sg_table,
		avalon_dma_xfer_callback callback,
		void *callback_param);
 
	int avalon_dma_issue_pending(struct avalon_dma *avalon_dma);

Patch 1 introduces "avalon-dma" driver that provides the above-mentioned
generic interface.

Patch 2 adds "avalon-drv" driver using "avalon-dma" to transfer user-
provided data. This driver was used to debug and stress "avalon-dma"
and could be used as a code base for other implementations. Strictly
speaking, it does not need to be part of the kernel tree.
A companion tool using "avalon-drv" to DMA files (not part of this
patchset) is located at git@github.com:a-gordeev/avalon-drv-tool.git

The suggested interface is developed with the standard "dmaengine"
in mind and could be reworked to suit it. I would appreciate, however
gathering some feedback on the implemenation first - as the hardware-
specific code would persist. It is also a call for testing - I only
have access to a single Arria 10 device to try on.

This series is against v5.3 and could be found at
git@github.com:a-gordeev/linux.git avalon-dma-engine


CC: Michael Chen <micchen@altera.com>
CC: devel@driverdev.osuosl.org
CC: dmaengine@vger.kernel.org

Alexander Gordeev (2):
  staging: avalon-dma: Avalon DMA engine
  staging: avalon-drv: Avalon DMA driver

 drivers/staging/Kconfig                       |   4 +
 drivers/staging/Makefile                      |   2 +
 drivers/staging/avalon-dma/Kconfig            |  45 ++
 drivers/staging/avalon-dma/Makefile           |  11 +
 drivers/staging/avalon-dma/avalon-dma-core.c  | 515 ++++++++++++++
 drivers/staging/avalon-dma/avalon-dma-core.h  |  52 ++
 .../staging/avalon-dma/avalon-dma-interrupt.c | 118 ++++
 .../staging/avalon-dma/avalon-dma-interrupt.h |  13 +
 drivers/staging/avalon-dma/avalon-dma-util.c  | 196 ++++++
 drivers/staging/avalon-dma/avalon-dma-util.h  |  25 +
 drivers/staging/avalon-drv/Kconfig            |  34 +
 drivers/staging/avalon-drv/Makefile           |  14 +
 drivers/staging/avalon-drv/avalon-drv-dev.c   | 193 ++++++
 drivers/staging/avalon-drv/avalon-drv-ioctl.c | 137 ++++
 drivers/staging/avalon-drv/avalon-drv-ioctl.h |  12 +
 drivers/staging/avalon-drv/avalon-drv-mmap.c  |  93 +++
 drivers/staging/avalon-drv/avalon-drv-mmap.h  |  12 +
 .../staging/avalon-drv/avalon-drv-sg-buf.c    | 132 ++++
 .../staging/avalon-drv/avalon-drv-sg-buf.h    |  26 +
 drivers/staging/avalon-drv/avalon-drv-util.c  |  54 ++
 drivers/staging/avalon-drv/avalon-drv-util.h  |  12 +
 drivers/staging/avalon-drv/avalon-drv-xfer.c  | 655 ++++++++++++++++++
 drivers/staging/avalon-drv/avalon-drv-xfer.h  |  24 +
 drivers/staging/avalon-drv/avalon-drv.h       |  22 +
 include/linux/avalon-dma-hw.h                 |  72 ++
 include/linux/avalon-dma.h                    |  68 ++
 include/uapi/linux/avalon-drv-ioctl.h         |  30 +
 27 files changed, 2571 insertions(+)
 create mode 100644 drivers/staging/avalon-dma/Kconfig
 create mode 100644 drivers/staging/avalon-dma/Makefile
 create mode 100644 drivers/staging/avalon-dma/avalon-dma-core.c
 create mode 100644 drivers/staging/avalon-dma/avalon-dma-core.h
 create mode 100644 drivers/staging/avalon-dma/avalon-dma-interrupt.c
 create mode 100644 drivers/staging/avalon-dma/avalon-dma-interrupt.h
 create mode 100644 drivers/staging/avalon-dma/avalon-dma-util.c
 create mode 100644 drivers/staging/avalon-dma/avalon-dma-util.h
 create mode 100644 drivers/staging/avalon-drv/Kconfig
 create mode 100644 drivers/staging/avalon-drv/Makefile
 create mode 100644 drivers/staging/avalon-drv/avalon-drv-dev.c
 create mode 100644 drivers/staging/avalon-drv/avalon-drv-ioctl.c
 create mode 100644 drivers/staging/avalon-drv/avalon-drv-ioctl.h
 create mode 100644 drivers/staging/avalon-drv/avalon-drv-mmap.c
 create mode 100644 drivers/staging/avalon-drv/avalon-drv-mmap.h
 create mode 100644 drivers/staging/avalon-drv/avalon-drv-sg-buf.c
 create mode 100644 drivers/staging/avalon-drv/avalon-drv-sg-buf.h
 create mode 100644 drivers/staging/avalon-drv/avalon-drv-util.c
 create mode 100644 drivers/staging/avalon-drv/avalon-drv-util.h
 create mode 100644 drivers/staging/avalon-drv/avalon-drv-xfer.c
 create mode 100644 drivers/staging/avalon-drv/avalon-drv-xfer.h
 create mode 100644 drivers/staging/avalon-drv/avalon-drv.h
 create mode 100644 include/linux/avalon-dma-hw.h
 create mode 100644 include/linux/avalon-dma.h
 create mode 100644 include/uapi/linux/avalon-drv-ioctl.h

-- 
2.22.0

