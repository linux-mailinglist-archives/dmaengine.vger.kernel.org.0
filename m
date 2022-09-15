Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33215B9940
	for <lists+dmaengine@lfdr.de>; Thu, 15 Sep 2022 13:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiIOLDD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Sep 2022 07:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiIOLDB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 15 Sep 2022 07:03:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF8199268;
        Thu, 15 Sep 2022 04:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663239780; x=1694775780;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BvAhCZX5jyhhgDIoTNyg7a+Vt6u/p3FEXo7UlgQYAVA=;
  b=Qmo1ux4mx8/5WZdRDRvMitGL/0Kcb+5f0YkwEn7jtFvmkZ8Des14bTib
   leG9BDQzaINdf6hka/+GO3PS9qZWMcL1VhfOtlwpQKki+6u7E8F/H+0DL
   Y1ra59H5j/MLYQl1GOujEb5q+dl1yBkq6ocV0wjGB2bNbkU8IvpaCiU/n
   +KCZFp2Okk7JXldS/Nfj7WAfmhB5oVUG+xRhK2xM9ng+xb49nZy8qWDDw
   jaJwU4t29PxkxI9fy0PTPf2u1JQQ0swQMtxV2gULaXgaeqe/nnt7stRJR
   cQQOppIYSrP2FhC/71fMyjvoqzBrszBecyTOCO3SHSg+lD4wZKwDGtpLv
   w==;
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="174000900"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Sep 2022 04:02:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 15 Sep 2022 04:02:58 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 15 Sep 2022 04:02:56 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ludovic.desroches@microchip.com>, <tudor.ambarus@microchip.com>,
        <vkoul@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/3] dmaengine: at_xdmac: add support for runtime pm
Date:   Thu, 15 Sep 2022 14:05:13 +0300
Message-ID: <20220915110516.4160443-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

The series add support for runtime PM on at_xdmac driver (patch 1/3).
This will enable/disable controller's clock based on work submitted to it.
Along with it I took the chance and added 2 minor cleanups (patches 2/3,
3/3).

Thank you,
Claudiu Beznea

Claudiu Beznea (3):
  dmaengine: at_xdmac: add runtime pm support
  dmaengine: at_xdmac: align properly function members
  dmaengine: at_xdmac: remove empty line

 drivers/dma/at_xdmac.c | 220 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 203 insertions(+), 17 deletions(-)

-- 
2.34.1

