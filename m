Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06DB786677
	for <lists+dmaengine@lfdr.de>; Thu, 24 Aug 2023 06:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbjHXEI5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Aug 2023 00:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236381AbjHXEI4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Aug 2023 00:08:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FCCA1;
        Wed, 23 Aug 2023 21:08:53 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RWTzY6q8kzVkNB;
        Thu, 24 Aug 2023 12:06:33 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 24 Aug
 2023 12:08:50 +0800
From:   Guo Mengqi <guomengqi3@huawei.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <guomengqi3@huawei.com>, <xuqiang36@huawei.com>,
        <chenweilong@huawei.com>
Subject: [PATCH v3 0/2] Add dma controller for hisilicon ascend310/910
Date:   Thu, 24 Aug 2023 12:00:05 +0800
Message-ID: <20230824040007.1476-1-guomengqi3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The patch set add driver and device-tree bindings for a dma controller
on hisilicon ascend310/910 platform.

Changes v2 to v3:
	- Fix dts-binding error: 
		* Use "hisilicon" as a unified vendor prefix.

Changes v1 to v2:
	- Fix dts-binding error:
		* change "compatible" to two exact models: ascend310/ascend910.
		* add vendor prefix for customized channel-map property.
		* add $ref for customized channel-map property.
		* remove unnecessary label in example.
	- Logic change in probe function:
		* If iommu sva feature is disabled, probe will not lead to failure
	- Use common driver apis: dev_xxx() devm_xxx()

V2: https://lore.kernel.org/dmaengine/53729f0f-2341-4329-8b2d-95dd377752d7@linaro.org/T/#t
V1: https://lore.kernel.org/dmaengine/20230811034822.107229-1-guomengqi3@huawei.com/T/#t

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

