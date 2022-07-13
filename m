Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9324E5738A5
	for <lists+dmaengine@lfdr.de>; Wed, 13 Jul 2022 16:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbiGMOWU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Jul 2022 10:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiGMOWS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Jul 2022 10:22:18 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57FC32ED2;
        Wed, 13 Jul 2022 07:22:15 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DCwFt2023204;
        Wed, 13 Jul 2022 16:21:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=8StrFdxqKvIx4QP9Pz3BRbHaQVEul95a7IIOW+3FDyE=;
 b=mbd8/DRWSAHB9fs2osy45tUAP9aL1EgVM8p4JRWkOHnMse5S8fPVRE+mEBZDnozs/4Hk
 2ZTjabVz4IC6PX3in8W4UJF0wXXrcebeeU8wCTjEaDr0d661vcY5zSXdcMLQ/L4bePDL
 Rir995zjFoUrIkZ0GOZxdkr2E6V8sJFBe98QCj401h5+kc/QyrWL5w4J8R5xBGmbXYQx
 qCKNSDgZUuZ1UfizPzbImlpKO5D7kwAgcZbV5z7G0hxYH8homz4W72ZCohXmKMfd1yng
 mgdj/Ah8dMv7U59G0hQu7bY1LztQlM8DkhW02WJL7D7dJAveqPHIK9IhnhvjvR6k0M0j GA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3h94guhnam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 16:21:56 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CEF9410002A;
        Wed, 13 Jul 2022 16:21:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C1BD3226FC5;
        Wed, 13 Jul 2022 16:21:55 +0200 (CEST)
Received: from localhost (10.75.127.45) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Wed, 13 Jul
 2022 16:21:54 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Jonathan Corbet <corbet@lwn.net>, Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-doc@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Marek Vasut <marex@denx.de>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH v2 0/4] STM32 DMA-MDMA chaining feature
Date:   Wed, 13 Jul 2022 16:21:44 +0200
Message-ID: <20220713142148.239253-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-13_03,2022-07-13_03,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patchset (re)introduces STM32 DMA-MDMA chaining feature.

As the DMA is not able to generate convenient burst transfer on the DDR,
it penalises the AXI bus when accessing the DDR. While it accesses
optimally the SRAM. The DMA-MDMA chaining then consists in having an SRAM
buffer between DMA and MDMA, so the DMA deals with peripheral and SRAM,
and the MDMA with SRAM and DDR.

The feature relies on the fact that DMA channel Transfer Complete signal
can trigger a MDMA channel transfer and MDMA can clear the DMA request by
writing to DMA Interrupt Clear register.

A deeper introduction can be found in patch 1.

Previous implementation [1] has been dropped as nacked.
Unlike this previous implementation (where all the stuff was embedded in
stm32-dma driver), the user (in peripheral drivers using dma) has now to
configure the MDMA channel.

[1] https://lore.kernel.org/lkml/1538139715-24406-1-git-send-email-pierre-yves.mordret@st.com/

Changes in v2:
- wrap to 80-column limit for documentation
- add an entry for this documentation in index.rst
- use simple table instead of csv-table in documentation

Amelie Delaunay (4):
  docs: arm: stm32: introduce STM32 DMA-MDMA chaining feature
  dmaengine: stm32-dmamux: set dmamux channel id in dma features
    bitfield
  dmaengine: stm32-dma: add support to trigger STM32 MDMA
  dmaengine: stm32-mdma: add support to be triggered by STM32 DMA

 Documentation/arm/index.rst                   |   1 +
 .../arm/stm32/stm32-dma-mdma-chaining.rst     | 415 ++++++++++++++++++
 drivers/dma/stm32-dma.c                       |  56 ++-
 drivers/dma/stm32-dmamux.c                    |   2 +-
 drivers/dma/stm32-mdma.c                      |  70 ++-
 5 files changed, 541 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/arm/stm32/stm32-dma-mdma-chaining.rst

-- 
2.25.1

