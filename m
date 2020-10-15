Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9898528FBD5
	for <lists+dmaengine@lfdr.de>; Fri, 16 Oct 2020 02:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgJPACw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Oct 2020 20:02:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15222 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727314AbgJPACw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 15 Oct 2020 20:02:52 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1DAEF6F5B3382C4589B0;
        Fri, 16 Oct 2020 08:02:50 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.203.187) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Fri, 16 Oct 2020 08:02:48 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     baohua <x@1.com>
Subject: [PATCH 00/10] dmaengine: a bundle of cleanup on spin_lock_irqsave/irqrestore
Date:   Fri, 16 Oct 2020 12:59:11 +1300
Message-ID: <20201015235921.21224-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.203.187]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: baohua <x@1.com>

In hardIRQ context, it is redundant to disable and restore irq status.

Barry Song (10):
  dmaengine: ipu_idmac: remove redundant irqsave and restore in hardIRQ
  dmaengine: k3-udma: remove redundant irqsave and irqrestore in hardIRQ
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

