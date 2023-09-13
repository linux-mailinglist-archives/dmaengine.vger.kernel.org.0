Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7276979E242
	for <lists+dmaengine@lfdr.de>; Wed, 13 Sep 2023 10:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238966AbjIMIh6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Sep 2023 04:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236752AbjIMIh5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Sep 2023 04:37:57 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C954196;
        Wed, 13 Sep 2023 01:37:53 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rltyc3dCvztSWY;
        Wed, 13 Sep 2023 16:33:44 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 13 Sep
 2023 16:37:50 +0800
From:   Guo Mengqi <guomengqi3@huawei.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <guomengqi3@huawei.com>, <xuqiang36@huawei.com>,
        <chenweilong@huawei.com>
Subject: [PATCH v4 0/2] Add dma controller driver for HiSilicon Ascend310/910
Date:   Wed, 13 Sep 2023 16:28:23 +0800
Message-ID: <20230913082825.3180-1-guomengqi3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The patch set add driver and device-tree bindings for a dma controller
on HiSilicon Ascend310/910 platform.

Changes v3 to v4:
	- dts-binding
		- filename changed to hisilicon,ascend-sdma.yaml
		- use common property "dma-channel-mask"
		- make a clearer description of property "pasid-num-bits"

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

Guo Mengqi (2):
  dmaengine: Add HiSilicon Ascend SDMA engine support
  dt-bindings: dma: HiSilicon: Add bindings for HiSilicon Ascend sdma

 .../bindings/dma/hisilicon,ascend-sdma.yaml   |  74 ++
 drivers/dma/Kconfig                           |   9 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/hisi-ascend-sdma.c                | 810 ++++++++++++++++++
 4 files changed, 894 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/hisilicon,ascend-sdma.yaml
 create mode 100644 drivers/dma/hisi-ascend-sdma.c

-- 
2.17.1

