Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE6651A48F
	for <lists+dmaengine@lfdr.de>; Wed,  4 May 2022 17:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbiEDP5e (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 May 2022 11:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240198AbiEDP5d (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 May 2022 11:57:33 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD38D45AFD;
        Wed,  4 May 2022 08:53:56 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 244Ed567018222;
        Wed, 4 May 2022 17:53:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=lsywa9G5dBxfR26yhT7KBuxASYe6RDw8F8vw3t47nis=;
 b=f/5ge46UA1X2LstThTJly+iXBdExk5ivNMr9bbkjRU0fCu1EoITghDRyVata/dWqx+QV
 aHeLRjkOQYDnaY2RSBiUk9PepSZ5GOxHY0gus68yc5eqoxyXVenLDOA0kfLMyy11JhRR
 M4n6YUwV6ij+IvgffZXvPadPKgYPAn795ACSdXeGtIAgWU3vX8niFhdVj2AgSleQOGaO
 zl0WXQXSYSB7Of+Tg3VqVoH89g+jqQw/XBuqIWO4qrc7yOKd97NSDdpq2+xbiLK9YC3H
 JcaeyGC179bVXWwe7ZzbbvCzVcO8tf6O7Iupx7GCbgtBrmLL28gQuZK9PmyQFHIfOY6A oA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3frthjweeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 17:53:37 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4EF3B10002A;
        Wed,  4 May 2022 17:53:37 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4818422A6EA;
        Wed,  4 May 2022 17:53:37 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 4 May 2022 17:53:36
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
Subject: [PATCH 0/3] STM32 MDMA IRQ handler code cleaning
Date:   Wed, 4 May 2022 17:53:19 +0200
Message-ID: <20220504155322.121431-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-04_04,2022-05-04_02,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patchset cleans stm32-mdma interrupt handler:
- GISR1 register is not used on any STM32 SoC with MDMA
- Remove chan wrong initialization
- Lower the log level to debug instead of warn in case of spurious it
  on stopped channel

Amelie Delaunay (3):
  dmaengine: stm32-mdma: remove GISR1 register
  dmaengine: stm32-mdma: fix chan initialization in
    stm32_mdma_irq_handler()
  dmaengine: stm32-mdma: use dev_dbg on non-busy channel spurious it

 drivers/dma/stm32-mdma.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

-- 
2.25.1

