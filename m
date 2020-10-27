Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D6F29CB9B
	for <lists+dmaengine@lfdr.de>; Tue, 27 Oct 2020 22:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374667AbgJ0V4q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Oct 2020 17:56:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5579 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374668AbgJ0V4p (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Oct 2020 17:56:45 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CLQXH4D0nzhc1r;
        Wed, 28 Oct 2020 05:56:47 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.153) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Wed, 28 Oct 2020 05:56:34 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v2 00/10] dmaengine: a bundle of cleanup on spin_lock_irqsave/irqrestore
Date:   Wed, 28 Oct 2020 10:52:42 +1300
Message-ID: <20201027215252.25820-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.200.153]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Running in hardIRQ, disabling IRQ is redundant since hardIRQ has disabled
IRQ. This patch removes the irqsave and irqstore to save some instruction
cycles.

-v2:
  add acked-by;
  refine commit log;

Barry Song (10):
  dmaengine: ipu_idmac: remove redundant irqsave and restore in hardIRQ
  dmaengine: ti: k3-udma: remove redundant irqsave and irqrestore in
    hardIRQ
  dmaengine: sf-pdma: remove redundant irqsave and irqrestore in hardIRQ
  dmaengine: tegra210-adma: remove redundant irqsave and irqrestore in
    hardIRQ
  dmaengine: milbeaut-xdmac: remove redundant irqsave and irqrestore in
    hardIRQ
  dmaengine: k3dma: remove redundant irqsave and irqrestore in hardIRQ
  dmaengine: hisi_dma: remove redundant irqsave and irqrestore in
    hardIRQ
  dmaengine: moxart-dma: remove redundant irqsave and irqrestore in
    hardIRQ
  dmaengine: ste_dma40: remove redundant irqsave and irqrestore in
    hardIRQ
  dmaengine: pxa_dma: remove redundant irqsave and irqrestore in hardIRQ

 drivers/dma/hisi_dma.c        |  5 ++---
 drivers/dma/ipu/ipu_idmac.c   | 11 +++++------
 drivers/dma/k3dma.c           |  9 ++++-----
 drivers/dma/milbeaut-xdmac.c  |  5 ++---
 drivers/dma/moxart-dma.c      |  5 ++---
 drivers/dma/pxa_dma.c         |  5 ++---
 drivers/dma/sf-pdma/sf-pdma.c | 10 ++++------
 drivers/dma/ste_dma40.c       |  5 ++---
 drivers/dma/tegra210-adma.c   |  7 +++----
 drivers/dma/ti/k3-udma.c      | 10 ++++------
 10 files changed, 30 insertions(+), 42 deletions(-)

-- 
2.25.1

