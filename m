Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B47382650
	for <lists+dmaengine@lfdr.de>; Mon, 17 May 2021 10:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhEQIMR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 May 2021 04:12:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3001 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhEQIMR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 May 2021 04:12:17 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FkBbd5QMbzmWvc;
        Mon, 17 May 2021 16:08:45 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 16:11:00 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 17
 May 2021 16:10:59 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <vkoul@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <michal.simek@xilinx.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH 0/3] cleanup patches for PM reference leak
Date:   Mon, 17 May 2021 16:18:23 +0800
Message-ID: <20210517081826.1564698-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Yu Kuai (3):
  dmaengine: stm32-mdma: fix PM reference leak in
    stm32_mdma_alloc_chan_resourc()
  dmaengine: usb-dmac: Fix PM reference leak in usb_dmac_probe()
  dmaengine: zynqmp_dma: Fix PM reference leak in
    zynqmp_dma_alloc_chan_resourc()

 drivers/dma/sh/usb-dmac.c       | 2 +-
 drivers/dma/stm32-mdma.c        | 4 ++--
 drivers/dma/xilinx/zynqmp_dma.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.25.4

