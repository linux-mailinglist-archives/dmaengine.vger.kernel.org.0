Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705127D7D9F
	for <lists+dmaengine@lfdr.de>; Thu, 26 Oct 2023 09:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjJZH3D (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Oct 2023 03:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjJZH3C (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 26 Oct 2023 03:29:02 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BCA19D;
        Thu, 26 Oct 2023 00:28:59 -0700 (PDT)
Received: from kwepemm000013.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SGHNM4RHBzpWcT;
        Thu, 26 Oct 2023 15:24:03 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 26 Oct
 2023 15:28:56 +0800
From:   Guo Mengqi <guomengqi3@huawei.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <xuqiang36@huawei.com>, <chenweilong@huawei.com>,
        <guomengqi3@huawei.com>
Subject: [PATCH v6 0/2] Add dma controller driver for HiSilicon Ascend310/910
Date:   Thu, 26 Oct 2023 15:25:47 +0800
Message-ID: <20231026072549.103102-1-guomengqi3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Changes v5 to v6:
	- Use "depends on IOMMU_SVA" rather than "selects IOMMU_SVA" in Kconfig,
		the latter will cause build errors

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
 drivers/dma/Kconfig                           |   9 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/hisi-ascend-sdma.c                | 788 ++++++++++++++++++
 4 files changed, 871 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/hisilicon,ascend-sdma.yaml
 create mode 100644 drivers/dma/hisi-ascend-sdma.c

-- 
2.17.1

