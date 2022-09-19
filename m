Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3715BD5F9
	for <lists+dmaengine@lfdr.de>; Mon, 19 Sep 2022 23:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiISVAE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Sep 2022 17:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiISVAE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Sep 2022 17:00:04 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944F1286E6;
        Mon, 19 Sep 2022 14:00:02 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28JKxu7T130791;
        Mon, 19 Sep 2022 15:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1663621196;
        bh=5LDtXqC/Fuw59qvlxxOyK1bFoI0HK+/kPMgwS/duCx4=;
        h=From:To:CC:Subject:Date;
        b=hd8G944Xcdk0cK1bc9r1Zn8eiGTIXKV6/Sofopp/M8mSUX8Gfa4+MsQ0VDN9c4Q8s
         HWfLY4RVFpdIGLE/NM/tZfHdzpwTfDZ5ivOz9EA2Zv8fjXLLj3/6njrT7iR6Y0wsAe
         bTVtAPcc4gogBA6SBbnWas/WAOiA59aIveuA0deg=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28JKxuAe022209
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Sep 2022 15:59:56 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 19
 Sep 2022 15:59:55 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 19 Sep 2022 15:59:55 -0500
Received: from ubuntu.ent.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28JKxoAJ014294;
        Mon, 19 Sep 2022 15:59:51 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <nm@ti.com>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Matt Ranostay <mranostay@ti.com>
Subject: [PATCH RESEND 0/2] dmaengine: ti: k3-psil: add TX threads for J721E + J7200 platforms
Date:   Mon, 19 Sep 2022 13:59:29 -0700
Message-ID: <20220919205931.8397-1-mranostay@ti.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add additional PSI-L TX threads for peripherals on both J721E and J7200 platforms.

Matt Ranostay (2):
  dmaengine: ti: k3-psil: add additional TX threads for j721e
  dmaengine: ti: k3-psil: add additional TX threads for j7200

 drivers/dma/ti/k3-psil-j7200.c | 67 ++++++++++++++++++++++++++++
 drivers/dma/ti/k3-psil-j721e.c | 79 ++++++++++++++++++++++++++++++++++
 2 files changed, 146 insertions(+)

-- 
2.37.2

