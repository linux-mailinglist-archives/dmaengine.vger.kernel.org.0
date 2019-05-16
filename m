Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C81FA20BA5
	for <lists+dmaengine@lfdr.de>; Thu, 16 May 2019 17:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfEPPyF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 May 2019 11:54:05 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14966 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfEPPyE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 May 2019 11:54:04 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdd87a20000>; Thu, 16 May 2019 08:54:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 16 May 2019 08:54:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 16 May 2019 08:54:04 -0700
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 15:54:03 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 15:54:03 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 16 May 2019 15:54:03 +0000
Received: from moonraker.nvidia.com (Not Verified[10.21.132.148]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cdd879a000a>; Thu, 16 May 2019 08:54:03 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 3/3] dmaengine: tegra210-adma: Fix spelling
Date:   Thu, 16 May 2019 16:53:54 +0100
Message-ID: <1558022034-19911-4-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558022034-19911-1-git-send-email-jonathanh@nvidia.com>
References: <1558022034-19911-1-git-send-email-jonathanh@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558022050; bh=vno5ZnO0uFYdq1GC2u7c0/xM2N790DJl7R77zxmzCPw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Uyj4+7+OviRg6PRW4zSxLHZqaA56FtqX1YNkBy/elP7r2tlhVHYqFHlPGbju7DtNM
         615FTFsrZsnajVrmnfaujkuJApWaNn5aiIY/8RydBWr0Ku6xY+KS7S61JyJDImCNIq
         VS/n6bjKW1Rs+WtDQkXc55uaSO6A3cmJDgfkl4n/plIpGCh6x+eg4w1lmCrCKW/PWm
         c95BC2UQBjGGyN1PNTdChteF5G92IjIDO6wbEYTqr4YVo+nOw4GClTcf0+Ri7tY8YS
         LDvw30CBkDmWFOHKgUJaOgT1Hg2mdHNKk+1p1MX1WnmA9aW4KJpajqnFz/SvDDLx8d
         +8o/CX7BSb+/Q==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Correct spelling of 'register' in Tegra210 ADMA driver.

Fixes: ded1f3db4cd6 ("dmaengine: tegra210-adma: prepare for supporting newer Tegra chips")

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 3f50fd11c380..17ea4dd99c62 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -95,7 +95,7 @@ struct tegra_adma;
  * @global_int_clear: Register offset of DMA global interrupt clear.
  * @ch_req_tx_shift: Register offset for AHUB transmit channel select.
  * @ch_req_rx_shift: Register offset for AHUB receive channel select.
- * @ch_base_offset: Reister offset of DMA channel registers.
+ * @ch_base_offset: Register offset of DMA channel registers.
  * @ch_fifo_ctrl: Default value for channel FIFO CTRL register.
  * @ch_req_mask: Mask for Tx or Rx channel select.
  * @ch_req_max: Maximum number of Tx or Rx channels available.
-- 
2.7.4

