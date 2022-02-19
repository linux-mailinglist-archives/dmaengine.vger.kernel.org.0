Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060AF4BC6FB
	for <lists+dmaengine@lfdr.de>; Sat, 19 Feb 2022 09:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241673AbiBSIc6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 19 Feb 2022 03:32:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239001AbiBSIc6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 19 Feb 2022 03:32:58 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C1766F9A;
        Sat, 19 Feb 2022 00:32:39 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21J8WUgM057790;
        Sat, 19 Feb 2022 02:32:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645259550;
        bh=6rcQBzyUPydjIamqI3RLR9Nf5jVDcMv1yS+W72Ii/FM=;
        h=From:To:CC:Subject:Date;
        b=CeMm+gb1MEZMnCzvs2yjRGurtJaNDmWQaCkZE0vIhjjhUsERYzVpRCzziQUxeJtNF
         plwNb7yZLz20tobk4AedLvfnSxkmpIzTGCXFrt1RtDt7XQteCJk1cW3N9tvmLa0EIk
         67h7W1/n3xfgA9ye/G9c1vEFZ/UIi7rAqQxVOsJ4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21J8WU0h001563
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 19 Feb 2022 02:32:30 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sat, 19
 Feb 2022 02:32:30 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sat, 19 Feb 2022 02:32:30 -0600
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21J8WRX6017343;
        Sat, 19 Feb 2022 02:32:28 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/2] dmaengine: ti: k3-udma: Add support for AM62x SoC
Date:   Sat, 19 Feb 2022 14:02:18 +0530
Message-ID: <20220219083220.489420-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add AM62x SoC specific data for k3-udma driver

TRM: https://www.ti.com/lit/pdf/spruiv7

Vignesh Raghavendra (2):
  dmaengine: ti: k3-udma: Add AM62x DMSS support
  dmaengine: ti: k3-psil: Add AM62x PSIL and PDMA data

 drivers/dma/ti/Makefile       |   3 +-
 drivers/dma/ti/k3-psil-am62.c | 186 ++++++++++++++++++++++++++++++++++
 drivers/dma/ti/k3-psil-priv.h |   1 +
 drivers/dma/ti/k3-psil.c      |   1 +
 drivers/dma/ti/k3-udma.c      |   1 +
 5 files changed, 191 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/ti/k3-psil-am62.c

-- 
2.35.1

