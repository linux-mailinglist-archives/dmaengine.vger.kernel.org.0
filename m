Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85787809BA
	for <lists+dmaengine@lfdr.de>; Fri, 18 Aug 2023 12:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359740AbjHRKMK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Aug 2023 06:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359771AbjHRKLm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Aug 2023 06:11:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2720630E6;
        Fri, 18 Aug 2023 03:11:15 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RRyFS5rFdztRwB;
        Fri, 18 Aug 2023 18:06:20 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 18 Aug
 2023 18:09:58 +0800
From:   Guo Mengqi <guomengqi3@huawei.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <guomengqi3@huawei.com>, <xuqiang36@huawei.com>,
        <chenweilong@huawei.com>
Subject: [PATCH v2 0/2] Add dma controller for hisi ascend310/910 
Date:   Fri, 18 Aug 2023 18:01:26 +0800
Message-ID: <20230818100128.112491-1-guomengqi3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The patch set add driver and device-tree bindings for a dma controller
on hisi ascend310/910 platform.

Changes in v2:
	- Use common driver apis: dev_xxx() devm_xxx()
	- Fix dts-binding properties, based on feedbacks
	- If iommu sva feature is disabled, probe will not lead to failure

Guo Mengqi (2):
  dmaengine: Add HiSilicon Ascend SDMA engine support
  dt-bindings: dma: hisi: Add bindings for Hisi Ascend sdma

 .../bindings/dma/hisi,ascend-sdma.yaml        |  75 ++
 drivers/dma/Kconfig                           |   9 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/ascend_sdma.c                     | 817 ++++++++++++++++++
 4 files changed, 902 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/hisi,ascend-sdma.yaml
 create mode 100644 drivers/dma/ascend_sdma.c

-- 
2.17.1

