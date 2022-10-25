Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CCC60C795
	for <lists+dmaengine@lfdr.de>; Tue, 25 Oct 2022 11:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbiJYJJX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Oct 2022 05:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiJYJIg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Oct 2022 05:08:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63791645C3;
        Tue, 25 Oct 2022 02:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666688691; x=1698224691;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P9iIMmHJLireRN4HABIXkO8389zu7kysPq2RycWf/1g=;
  b=mZFs/6lGzK2cCvSAFV7JWeidiAUHXAkdr4RtNSVC2PEIevuqKVIz2Lc5
   /A70HT6L8/c1TVyui9PYgNkE7br75epJ/B+KvTFSvwfce8vXNRDoRpKLC
   Bv4RbfOEJErMov4sUFwCJwJQnMr74sAQGsMExoTDUW7tRjxBLQcO/jli1
   YV7D1xzNc2YC8tATbZDyBDy6odmGWKRVrN+f6MOsjWJobZfIqDhLm/4Q7
   Ou61swsynhHYU18CV9j45M7y6HWxmNHTFDtq2c9Ca/euUPdSQ3AAF0B/B
   jA60f+825T/gyYEZoyCVhvKhwzwq/wSw+hpWtxP1JHgPtCMRDYd0RQQyo
   A==;
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="196910329"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Oct 2022 02:04:46 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 25 Oct 2022 02:04:43 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 25 Oct 2022 02:04:41 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>, <peda@axentia.se>, <du@axentia.se>
CC:     <maciej.sosnowski@intel.com>, <nicolas.ferre@microchip.com>,
        <mripard@kernel.org>, <torfl6749@gmail.com>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH v2 31/32] dmaengine: at_hdmac: Remove unused member of at_dma_chan
Date:   Tue, 25 Oct 2022 12:03:05 +0300
Message-ID: <20221025090306.297886-32-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025090306.297886-1-tudor.ambarus@microchip.com>
References: <20221025090306.297886-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pointer to at_dma engine was never used, remove it.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_hdmac.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index e39b9b47234a..143d75c18d1e 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -253,7 +253,6 @@ enum atc_status {
 /**
  * struct at_dma_chan - internal representation of an Atmel HDMAC channel
  * @dma_chan: common dmaengine channel object members
- * @device: parent device
  * @ch_regs: memory mapped register base
  * @mask: channel index in a mask
  * @per_if: peripheral interface
@@ -273,7 +272,6 @@ enum atc_status {
  */
 struct at_dma_chan {
 	struct dma_chan		dma_chan;
-	struct at_dma		*device;
 	void __iomem		*ch_regs;
 	u8			mask;
 	u8			per_if;
-- 
2.25.1

