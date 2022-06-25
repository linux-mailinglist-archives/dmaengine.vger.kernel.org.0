Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B76155A7D7
	for <lists+dmaengine@lfdr.de>; Sat, 25 Jun 2022 09:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbiFYHo7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 25 Jun 2022 03:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbiFYHo5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 25 Jun 2022 03:44:57 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C19473B0;
        Sat, 25 Jun 2022 00:44:54 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LVQwv4Yt1zDsSB;
        Sat, 25 Jun 2022 15:44:15 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (7.193.23.208) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 25 Jun 2022 15:44:51 +0800
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 25 Jun 2022 15:44:51 +0800
From:   Jie Hai <haijie1@huawei.com>
To:     <vkoul@kernel.org>, <wangzhou1@hisilicon.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/8] Documentation: Add debugfs doc for hisi_dma
Date:   Sat, 25 Jun 2022 15:44:21 +0800
Message-ID: <20220625074422.3479591-8-haijie1@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20220625074422.3479591-1-haijie1@huawei.com>
References: <20220625074422.3479591-1-haijie1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add debugfs descriptions for HiSilicon DMA driver.

Signed-off-by: Jie Hai <haijie1@huawei.com>
---
 Documentation/ABI/testing/debugfs-hisi-dma | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-hisi-dma

diff --git a/Documentation/ABI/testing/debugfs-hisi-dma b/Documentation/ABI/testing/debugfs-hisi-dma
new file mode 100644
index 000000000000..162c97945748
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-hisi-dma
@@ -0,0 +1,9 @@
+What:           /sys/kernel/debug/hisi_dma/<bdf>/regs
+Date:           Mar 2022
+Contact:        dmaengine@vger.kernel.org
+Description:    Dump the debug registers from the hisi dma.
+
+What:           /sys/kernel/debug/hisi_dma/<bdf>/channel[id]/regs
+Date:           Mar 2022
+Contact:        dmaengine@vger.kernel.org
+Description:    Dump the channel related debug registers from the hisi dma.
-- 
2.33.0

