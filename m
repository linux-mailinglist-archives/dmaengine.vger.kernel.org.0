Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0D439D4F2
	for <lists+dmaengine@lfdr.de>; Mon,  7 Jun 2021 08:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbhFGGeg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Jun 2021 02:34:36 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:4331 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhFGGef (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Jun 2021 02:34:35 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Fz3MZ0y6mz1BJhT;
        Mon,  7 Jun 2021 14:27:54 +0800 (CST)
Received: from dggema755-chm.china.huawei.com (10.1.198.197) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 14:32:43 +0800
Received: from huawei.com (10.90.53.225) by dggema755-chm.china.huawei.com
 (10.1.198.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 7 Jun
 2021 14:32:42 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <vkoul@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <pierre-yves.mordret@st.com>
CC:     <amelie.delaunay@st.com>, <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH -next 0/3] Fix PM usage counter imblance and clear code
Date:   Mon, 7 Jun 2021 14:46:37 +0800
Message-ID: <20210607064640.121394-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema755-chm.china.huawei.com (10.1.198.197)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The first two patches fix PM disable depth imbalance and
the last clear pm_runtime_get_sync calls.

Zhang Qilong (3):
  dmaengine: stm32-dma: Fix PM usage counter imbalance in stm32 dma ops
  dmaengine: stm32-dmamux: Fix PM usage counter unbalance in stm32
    dmamux ops
  dmaengine: tegra210-adma: Using pm_runtime_resume_and_get to replace
    open coding

 drivers/dma/stm32-dma.c     | 4 ++--
 drivers/dma/stm32-dmamux.c  | 6 +++---
 drivers/dma/tegra210-adma.c | 7 ++-----
 3 files changed, 7 insertions(+), 10 deletions(-)

-- 
2.31.1

