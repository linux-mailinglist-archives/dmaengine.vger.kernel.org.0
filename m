Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0CC2C61F6
	for <lists+dmaengine@lfdr.de>; Fri, 27 Nov 2020 10:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgK0JlS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Nov 2020 04:41:18 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:8435 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729051AbgK0JlR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 27 Nov 2020 04:41:17 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Cj8kz3KGnzhhmw;
        Fri, 27 Nov 2020 17:40:59 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Fri, 27 Nov 2020 17:41:08 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH 0/3] dmaengine: stm32: fix reference leak
Date:   Fri, 27 Nov 2020 17:45:22 +0800
Message-ID: <20201127094525.121388-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

pm_runtime_get_sync will increment pm usage counter even it
failed. Forgetting to putting operation will result in a
reference leak here. 

Use pm_runtime_resume_and_get to fix it.

Qinglang Miao (3):
  dmaengine: stm32-dma: fix reference leak in stm32_dma
  dmaengine: stm32-dmamux: fix reference leak in stm32_dmamux
  dmaengine: stm32-mdma: fix reference leak in stm32-mdma

 drivers/dma/stm32-dma.c    | 4 ++--
 drivers/dma/stm32-dmamux.c | 6 +++---
 drivers/dma/stm32-mdma.c   | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.23.0

