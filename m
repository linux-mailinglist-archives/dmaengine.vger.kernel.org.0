Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1FB2B56FA
	for <lists+dmaengine@lfdr.de>; Tue, 17 Nov 2020 03:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgKQCjd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Nov 2020 21:39:33 -0500
Received: from mga04.intel.com ([192.55.52.120]:52576 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727395AbgKQCjP (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 16 Nov 2020 21:39:15 -0500
IronPort-SDR: jjCem8/6TeXw71m+WF3p4h0KuutXzG97jnOk4LWRWKm5sChkV9JL5TUQ/REn/hU9Sg8uYRX57g
 DdRKF3dEIGRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="168274103"
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; 
   d="scan'208";a="168274103"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 18:39:15 -0800
IronPort-SDR: MSESnvg4CBJChxB2F0dbTmmX1TOCymhtmJvoM7RWfnsASQZ+GEwkVZ7MNPBY/K08qJQnFmp6yd
 Q7WecXEtvhwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; 
   d="scan'208";a="358706126"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by fmsmga004.fm.intel.com with ESMTP; 16 Nov 2020 18:39:12 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v4 12/15] dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA support
Date:   Tue, 17 Nov 2020 10:22:12 +0800
Message-Id: <20201117022215.2461-13-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201117022215.2461-1-jee.heng.sia@intel.com>
References: <20201117022215.2461-1-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for Intel KeemBay AxiDMA to the .compatible field.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 9f7f908b89d8..c2ffc5d44b6e 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1340,6 +1340,7 @@ static const struct dev_pm_ops dw_axi_dma_pm_ops = {
 
 static const struct of_device_id dw_dma_of_id_table[] = {
 	{ .compatible = "snps,axi-dma-1.01a" },
+	{ .compatible = "intel,kmb-axi-dma" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dw_dma_of_id_table);
-- 
2.18.0

