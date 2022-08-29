Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E675A507E
	for <lists+dmaengine@lfdr.de>; Mon, 29 Aug 2022 17:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiH2PrZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Aug 2022 11:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiH2PrY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Aug 2022 11:47:24 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0967888DE6;
        Mon, 29 Aug 2022 08:47:22 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TCsEJ6020472;
        Mon, 29 Aug 2022 17:46:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=3n0u8OuXWBG3+4BzlaE46m0ze27f4cpqVKOPJ0Maivc=;
 b=lJyrZAxeUbHHlQ22Gq0EhEPRJ8ntt9t3haU05pfeScLLuBTqaVp/ld4dvvz+rV6lR5jx
 NPjmkD4IRHzFxUgEmojtzjbP0TzC03O/Ivt8lalNvu+MyWunSKhkjTEJnCB8N2sLwInG
 MHKiDYVVmUTekJ1qEBFnNIz1iL8ggs8toh5q/BBtLbFOiVXBK2LFWAAvLQn8ci8ZYzeb
 iDqhE4sEacAzGhRx1+xxCx9jYikNfefVW/32Rc6qNzT0Sx3HjglvOWlnEloBaGwn0qDd
 Qz3ix0tli9+N2uQQDxwrCQ/ZcaMHdP4HlclA0+TPqdTXmpRLYjJirDifkpVXapIjQSux 4w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3j7am0tcfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 17:46:58 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 65E2110002A;
        Mon, 29 Aug 2022 17:46:57 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 454C7236927;
        Mon, 29 Aug 2022 17:46:57 +0200 (CEST)
Received: from localhost (10.75.127.117) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.7; Mon, 29 Aug
 2022 17:46:57 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Jonathan Corbet <corbet@lwn.net>, Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-doc@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Marek Vasut <marex@denx.de>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [RESEND PATCH v3 0/6] STM32 DMA-MDMA chaining feature
Date:   Mon, 29 Aug 2022 17:46:40 +0200
Message-ID: <20220829154646.29867-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.117]
X-ClientProxiedBy: GPXDAG2NODE5.st.com (10.75.127.69) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_07,2022-08-25_01,2022-06-22_01
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

Changes in v3:
- introduce two prior patches to help readibility
- fix stm32-dma struct stm32_dma_mdma_config documentation

Changes in v2:
- wrap to 80-column limit for documentation
- add an entry for this documentation in index.rst
- use simple table instead of csv-table in documentation

Amelie Delaunay (6):
  dmaengine: stm32-dma: introduce 3 helpers to address channel flags
  dmaengine: stm32-dma: use bitfield helpers
  docs: arm: stm32: introduce STM32 DMA-MDMA chaining feature
  dmaengine: stm32-dmamux: set dmamux channel id in dma features
    bitfield
  dmaengine: stm32-dma: add support to trigger STM32 MDMA
  dmaengine: stm32-mdma: add support to be triggered by STM32 DMA

 Documentation/arm/index.rst                   |   1 +
 .../arm/stm32/stm32-dma-mdma-chaining.rst     | 415 ++++++++++++++++++
 drivers/dma/stm32-dma.c                       | 136 +++---
 drivers/dma/stm32-dmamux.c                    |   2 +-
 drivers/dma/stm32-mdma.c                      |  70 ++-
 5 files changed, 569 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/arm/stm32/stm32-dma-mdma-chaining.rst

-- 
2.25.1

