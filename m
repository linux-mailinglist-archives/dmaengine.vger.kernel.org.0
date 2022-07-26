Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287A058090F
	for <lists+dmaengine@lfdr.de>; Tue, 26 Jul 2022 03:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiGZBhs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Jul 2022 21:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiGZBhr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Jul 2022 21:37:47 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18141F2F7;
        Mon, 25 Jul 2022 18:37:46 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LsKJN1kkmz9stm;
        Tue, 26 Jul 2022 09:36:36 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (7.193.23.208) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 09:37:45 +0800
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 09:37:44 +0800
From:   Jie Hai <haijie1@huawei.com>
To:     <vkoul@kernel.org>, <wangzhou1@hisilicon.com>
CC:     <haijie1@huawei.com>, <liudongdong3@huawei.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/7] dmaengine: hisilicon: Add support for hisi dma driver
Date:   Tue, 26 Jul 2022 09:35:18 +0800
Message-ID: <20220726013525.13059-1-haijie1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220625074422.3479591-1-haijie1@huawei.com>
References: <20220625074422.3479591-1-haijie1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The HiSilicon IP08 and HiSilicon IP09 are DMA iEPs, they share the
same pci device id but different pci revision and register layouts.

The original version supports HiSilicon IP08 but not HiSilicon IP09.
This series support DMA driver for HIP08 and HIP09:
1. Fix bugs for HIP08 DMA driver
	- Disable hardware channels when driver detached
	- Update cq_head whenever accessed it
	- Support multi-thread for one DMA channel
2. Use macros instead of magic number
3. Add support for HIP09 DMA driver
4. Add debugfs for HIP08 and HIP09 DMA driver
5. Add myself as maintainer of hisi_dma.c

Changes since version 2:
 - fix unnecessary line breaks
 - fix register bit with BIT/GENMASK and adjust hisi_dma_update_bit to it
 - remove "Reported-by" in commit message
 - use dmaengine root instead of hisi_dma root
 - ignore errors for creating debugfs

Changes since version 1:
 - remove error changes casuse compile failure
 - remove reduldant "*" in comment
 - remove debugfs-hisi-dma doc and path in MAINTAINERS

Jie Hai (7):
  dmaengine: hisilicon: Disable channels when unregister hisi_dma
  dmaengine: hisilicon: Fix CQ head update
  dmaengine: hisilicon: Add multi-thread support for a DMA channel
  dmaengine: hisilicon: Use macros instead of magic number
  dmaengine: hisilicon: Adapt DMA driver to HiSilicon IP09
  dmaengine: hisilicon: dump regs to debugfs
  MAINTAINERS: Add myself as maintainer for hisi_dma

 MAINTAINERS            |   1 +
 drivers/dma/hisi_dma.c | 651 +++++++++++++++++++++++++++++++++++------
 2 files changed, 556 insertions(+), 96 deletions(-)

-- 
2.33.0

