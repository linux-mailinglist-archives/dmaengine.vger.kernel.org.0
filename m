Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9334D36C
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2019 18:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfFTQPy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Jun 2019 12:15:54 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11668 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfFTQPy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Jun 2019 12:15:54 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0bb13a0001>; Thu, 20 Jun 2019 09:15:54 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 20 Jun 2019 09:15:53 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 20 Jun 2019 09:15:53 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Jun
 2019 16:15:53 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 20 Jun 2019 16:15:53 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d0bb1370000>; Thu, 20 Jun 2019 09:15:53 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <dmaengine@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH] dmaengine: tegra210-adma: fix transfer failure
Date:   Thu, 20 Jun 2019 21:45:48 +0530
Message-ID: <1561047348-14413-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561047354; bh=ohJbaSrus9ivGDKfVAYHPSEvxvcXu3P+/EkE2Rx69dQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=P9JNy3PKkOH53Xbyzr0tn2IzDyUc6rvw1q6vv4EefhJPW0Ls6gIkxtwv15tDDQ9O0
         QUQrXsyAoxOmCBB76werU/Km/AA7SZ+37LHZLHI7Ut8rIOUMkEqqrw2hbNcO4Q71zC
         LTNbfXnbxK2A5flHVFQd+OZxkoJ8sSRZq3Qku8Dq/lS3dvnN64wTuT/YgyhX4lz0c+
         BxTImo6r1ORM2cX+MFz9eAMEmP3TYWLkNGziFFgzYFv0U9ie7O8hrY/vARgiL91mN/
         cBopQJ43ksFgPQ2MBsveaW6qBaqdf0wfO20gij0K6I+u4KMpj37de3WGA4PF8ndo06
         xWcLQ3z9qRQWA==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From Tegra186 onwards OUTSTANDING_REQUESTS field is added in channel
configuration register (bits 7:4). ADMA allows a maximum of 8 reads
to source and that many writes to target memory be outstanding at any
given point of time. If this field is not programmed, DMA transfers
fail to happen.

Thus added 'ch_pending_req' member in chip data structure and the
same is populated with maximum allowed pending requests. Since the
field is not applicable to Tegra210, mentioned bit fields are unused
and hence the member is initialized with 0.

Fixes: 433de642a76c ("dmaengine: tegra210-adma: add support for Tegra186/Tegra194")

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 17ea4dd99..8d291cf 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -96,6 +96,7 @@ struct tegra_adma;
  * @ch_req_tx_shift: Register offset for AHUB transmit channel select.
  * @ch_req_rx_shift: Register offset for AHUB receive channel select.
  * @ch_base_offset: Register offset of DMA channel registers.
+ * @ch_pending_req: Outstaning DMA requests for a channel.
  * @ch_fifo_ctrl: Default value for channel FIFO CTRL register.
  * @ch_req_mask: Mask for Tx or Rx channel select.
  * @ch_req_max: Maximum number of Tx or Rx channels available.
@@ -109,6 +110,7 @@ struct tegra_adma_chip_data {
 	unsigned int ch_req_tx_shift;
 	unsigned int ch_req_rx_shift;
 	unsigned int ch_base_offset;
+	unsigned int ch_pending_req;
 	unsigned int ch_fifo_ctrl;
 	unsigned int ch_req_mask;
 	unsigned int ch_req_max;
@@ -613,6 +615,7 @@ static int tegra_adma_set_xfer_params(struct tegra_adma_chan *tdc,
 			 ADMA_CH_CTRL_FLOWCTRL_EN;
 	ch_regs->config |= cdata->adma_get_burst_config(burst_size);
 	ch_regs->config |= ADMA_CH_CONFIG_WEIGHT_FOR_WRR(1);
+	ch_regs->config |= cdata->ch_pending_req;
 	ch_regs->fifo_ctrl = cdata->ch_fifo_ctrl;
 	ch_regs->tc = desc->period_len & ADMA_CH_TC_COUNT_MASK;
 
@@ -797,6 +800,7 @@ static const struct tegra_adma_chip_data tegra210_chip_data = {
 	.ch_req_tx_shift	= 28,
 	.ch_req_rx_shift	= 24,
 	.ch_base_offset		= 0,
+	.ch_pending_req		= 0,
 	.ch_fifo_ctrl		= TEGRA210_FIFO_CTRL_DEFAULT,
 	.ch_req_mask		= 0xf,
 	.ch_req_max		= 10,
@@ -811,6 +815,7 @@ static const struct tegra_adma_chip_data tegra186_chip_data = {
 	.ch_req_tx_shift	= 27,
 	.ch_req_rx_shift	= 22,
 	.ch_base_offset		= 0x10000,
+	.ch_pending_req		= (8 << 4),
 	.ch_fifo_ctrl		= TEGRA186_FIFO_CTRL_DEFAULT,
 	.ch_req_mask		= 0x1f,
 	.ch_req_max		= 20,
-- 
2.7.4

