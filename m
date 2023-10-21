Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43027D1C23
	for <lists+dmaengine@lfdr.de>; Sat, 21 Oct 2023 11:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjJUJiA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 21 Oct 2023 05:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJUJh7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 21 Oct 2023 05:37:59 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF10219E;
        Sat, 21 Oct 2023 02:37:56 -0700 (PDT)
Received: from kwepemm000013.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SCGWr1tSCzrSYy;
        Sat, 21 Oct 2023 17:35:04 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sat, 21 Oct
 2023 17:37:50 +0800
From:   Guo Mengqi <guomengqi3@huawei.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <xuqiang36@huawei.com>, <chenweilong@huawei.com>,
        <guomengqi3@huawei.com>
Subject: [PATCH v5 0/2] Add dma controller driver for HiSilicon Ascend310/910
Date:   Sat, 21 Oct 2023 17:34:51 +0800
Message-ID: <20231021093454.39822-1-guomengqi3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000013.china.huawei.com (7.193.23.81)
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
on HiSilicon Ascend310/910 platform.

Changes v4 to v5:
	- Remove the export symbol set_sdma_channel_info(),
		use current->mm->pasid for instead.
	- Reorganize the code and fix some indentations.
	- "dma-can-stall" now is not a required option in dts-binding
	
Changes v3 to v4:
	- dts-binding
		* filename changed to hisilicon,ascend-sdma.yaml
		* use common property "dma-channel-mask"
		* make a clearer description of property "pasid-num-bits"

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

 .../bindings/dma/hisilicon,ascend-sdma.yaml   |  73 ++
 drivers/dma/Kconfig                           |  10 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/hisi-ascend-sdma.c                | 788 ++++++++++++++++++
 4 files changed, 872 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/hisilicon,ascend-sdma.yaml
 create mode 100644 drivers/dma/hisi-ascend-sdma.c

-- 
2.17.1

