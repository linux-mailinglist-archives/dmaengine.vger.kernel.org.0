Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38E621A24D8
	for <lists+dmaengine@lfdr.de>; Wed,  8 Apr 2020 17:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgDHPTh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Apr 2020 11:19:37 -0400
Received: from smaract.com ([82.165.73.54]:59522 "EHLO smaract.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbgDHPTh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 8 Apr 2020 11:19:37 -0400
Received: from mx1.smaract.de (staticdsl-213-168-205-127.ewe-ip-backbone.de [213.168.205.127])
        by smaract.com (Postfix) with ESMTPSA id A49F6A0D41;
        Wed,  8 Apr 2020 15:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smaract.com;
        s=default; t=1586359175;
        bh=Xo7Di48HUgBQ68hR7s+3kQsxvlOUd6nyWtGjsvNG0Mw=; l=1061;
        h=Received:From:To:Subject;
        b=B/TAjH8FbeAflH0K4O+AjEQbtsppwxunVBaQSNhGzPkKn3TufN1yGpdg+4WiGLcrx
         LkIhJIX7WPvkDm35qqwAq341+r78B3nicmBH0reKNlBEhyx0Xcv8setF1cOnEvlfFB
         2ciBr1m/CtsCLr33W13TO08eERo9Jt31FsFDJjPo=
Authentication-Results: smaract.com;
        spf=pass (sender IP is 213.168.205.127) smtp.mailfrom=vonohr@smaract.com smtp.helo=mx1.smaract.de
Received-SPF: pass (smaract.com: connection is authenticated)
Received: from localhost.localdomain (10.110.203.18) by ols12mx1.smaract.local
 (172.16.16.90) with Microsoft SMTP Server (TLS) id 15.1.225.42;
 Wed, 8 Apr 2020 17:19:35 +0200
From:   Sebastian von Ohr <vonohr@smaract.com>
To:     <radheys@xilinx.com>, <vkoul@kernel.org>, <appanad@xilinx.com>,
        <michals@xilinx.com>
CC:     <dmaengine@vger.kernel.org>
Subject: RE: [PATCH] dmaengine: xilinx_dma: Add missing check for empty list
Date:   Wed, 8 Apr 2020 17:19:26 +0200
Message-ID: <20200408151926.11709-1-vonohr@smaract.com>
In-Reply-To: <BYAPR02MB5638DED4EF67EB842164DB0AC7C00@BYAPR02MB5638.namprd02.prod.outlook.com>
References: <BYAPR02MB5638DED4EF67EB842164DB0AC7C00@BYAPR02MB5638.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ols12mx1.smaract.local (172.16.16.90) To
 ols12mx1.smaract.local (172.16.16.90)
X-PPP-Message-ID: <158635917575.23621.11904158816826310670@smaract.com>
X-PPP-Vhost: mario.smaract.com
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

I've attached a patch below. When using this patch with the xilinx-v2019.2.01
tag I get a kernel panic immediately when loading the module. Maybe the exact
components on the FPGA are also important. I have one AXI DMA component with
scatter/gather enabled, read/write widths set to 64bit and a max burst size
of 16.


diff --git a/drivers/dma/xilinx/axidmatest.c b/drivers/dma/xilinx/axidmatest.c
index 3d88982c9f7e..757bab152e0a 100644
--- a/drivers/dma/xilinx/axidmatest.c
+++ b/drivers/dma/xilinx/axidmatest.c
@@ -407,6 +407,7 @@ static int dmatest_slave_func(void *data)
 		dma_async_issue_pending(tx_chan);
 		dma_async_issue_pending(rx_chan);
 
+		dma_sync_wait(tx_chan, tx_cookie);
 		tx_tmo = wait_for_completion_timeout(&tx_cmp, tx_tmo);
 
 		status = dma_async_is_tx_complete(tx_chan, tx_cookie,
@@ -428,6 +429,7 @@ static int dmatest_slave_func(void *data)
 			continue;
 		}
 
+		dma_sync_wait(rx_chan, rx_cookie);
 		rx_tmo = wait_for_completion_timeout(&rx_cmp, rx_tmo);
 		status = dma_async_is_tx_complete(rx_chan, rx_cookie,
 							NULL, NULL);
