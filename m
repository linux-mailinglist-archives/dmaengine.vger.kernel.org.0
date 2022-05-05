Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9BD51BD24
	for <lists+dmaengine@lfdr.de>; Thu,  5 May 2022 12:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355500AbiEEKav (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 May 2022 06:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350947AbiEEKav (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 May 2022 06:30:51 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AB44B1EF;
        Thu,  5 May 2022 03:27:11 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2458kk5s026502;
        Thu, 5 May 2022 12:26:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=U6Bf9hl5wzM7Kpw0BRIGT7+zxjqmU+6MCbiv78o43HQ=;
 b=uKxJBbrQebDAJL1hegBON8CuXGn3vGGx8dUygYvFjYDiYidzgmg5nfLJOEsoVBKZSOzB
 TTRwyVs641g4Tw7P33i/You4WSEI00M6Lyo7xsrFaTLz31J5HjI84Z2hQEhupbKDifd2
 UmNrGJqlqUehNEnaEEouJnvdaM2Iv0mC+djI8mFwy6W13jMfVmK65/JPTnihKnAokS6v
 Jc3tBT0/bg0lhTVfUkNRsnxE9vUC4bjHT13rLgpNKBYE0HUb8AJByffNYGsOYssWqtGl
 r9OgR9d2E8dh6q6y8wse7MRJheplgxVAT06ZSGMLNp9yaPnkYUf4ihIDwdZWLnC74xDH FA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3frt8937f4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 12:26:55 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AD7A010002A;
        Thu,  5 May 2022 12:26:53 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A51622171CE;
        Thu,  5 May 2022 12:26:53 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 5 May 2022 12:26:53
 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH 0/4] STM32 DMA pause/resume support
Date:   Thu, 5 May 2022 12:26:32 +0200
Message-ID: <20220505102636.35506-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-05_04,2022-05-05_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patchset introduces pause/resume support in stm32-dma driver.
[1/4], [2/4] and [3/4] ease the introduction of device_pause/device_resume
ops management in [4/4].

Amelie Delaunay (4):
  dmaengine: stm32-dma: introduce stm32_dma_sg_inc to manage
    chan->next_sg
  dmaengine: stm32-dma: pass DMA_SxSCR value to
    stm32_dma_handle_chan_done()
  dmaengine: stm32-dma: rename pm ops before dma pause/resume
    introduction
  dmaengine: stm32-dma: add device_pause/device_resume support

 drivers/dma/stm32-dma.c | 311 ++++++++++++++++++++++++++++++++++------
 1 file changed, 268 insertions(+), 43 deletions(-)

-- 
2.25.1

