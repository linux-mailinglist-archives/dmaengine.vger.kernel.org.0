Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85EE2B911E
	for <lists+dmaengine@lfdr.de>; Thu, 19 Nov 2020 12:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgKSLhJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 Nov 2020 06:37:09 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7558 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgKSLhJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 Nov 2020 06:37:09 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CcHhM12FHzhcqL;
        Thu, 19 Nov 2020 19:36:51 +0800 (CST)
Received: from huawei.com (10.151.151.249) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Thu, 19 Nov 2020
 19:36:58 +0800
From:   Dongjiu Geng <gengdongjiu@huawei.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <vkoul@kernel.org>,
        <dan.j.williams@intel.com>, <p.zabel@pengutronix.de>,
        <gengdongjiu@huawei.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
Subject: [PATCH v5 0/4] Enable Hi3559A SOC clock and HiSilicon Hiedma Controller
Date:   Thu, 19 Nov 2020 20:01:25 +0000
Message-ID: <20201119200129.28532-1-gengdongjiu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.151.151.249]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

v4->v5:
1. change the patch author mail name

v3->v4:
1. fix the 'make dt_binding_check' issues.
2. Combine the 'Enable HiSilicon Hiedma Controller' series patches to this series.
3. fix the 'make dt_binding_check' issues in 'Enable HiSilicon Hiedma Controller' patchset


v2->v3:
1. change dt-bindings documents from txt to yaml format.
2. Add SHUB clock to access the devices of m7

Dongjiu Geng (4):
  dt-bindings: Document the hi3559a clock bindings
  clk: hisilicon: Add clock driver for hi3559A SoC
  dt: bindings: dma: Add DT bindings for HiSilicon Hiedma Controller
  dmaengine: dma: Add Hiedma Controller v310 Device Driver

 .../clock/hisilicon,hi3559av100-clock.yaml    |   66 +
 .../bindings/dma/hisilicon,hiedmacv310.yaml   |  103 ++
 drivers/clk/hisilicon/Kconfig                 |    7 +
 drivers/clk/hisilicon/Makefile                |    1 +
 drivers/clk/hisilicon/clk-hi3559a.c           |  865 ++++++++++
 drivers/dma/Kconfig                           |   14 +
 drivers/dma/Makefile                          |    1 +
 drivers/dma/hiedmacv310.c                     | 1441 +++++++++++++++++
 drivers/dma/hiedmacv310.h                     |  136 ++
 include/dt-bindings/clock/hi3559av100-clock.h |  165 ++
 10 files changed, 2799 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/hisilicon,hiedmacv310.yaml
 create mode 100644 drivers/clk/hisilicon/clk-hi3559a.c
 create mode 100644 drivers/dma/hiedmacv310.c
 create mode 100644 drivers/dma/hiedmacv310.h
 create mode 100644 include/dt-bindings/clock/hi3559av100-clock.h

-- 
2.17.1

