Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91B3366B5E
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jul 2019 13:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfGLLKl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 Jul 2019 07:10:41 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16905 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfGLLKl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 12 Jul 2019 07:10:41 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d286aae0001>; Fri, 12 Jul 2019 04:10:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 12 Jul 2019 04:10:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 12 Jul 2019 04:10:40 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 12 Jul
 2019 11:10:39 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 12 Jul 2019 11:10:39 +0000
Received: from audio.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d286aae0002>; Fri, 12 Jul 2019 04:10:39 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <vkoul@kernel.org>, <jonathanh@nvidia.com>, <ldewangan@nvidia.com>
CC:     <thierry.reding@gmail.com>, <dmaengine@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2] dmaengine: tegra210-adma: fix transfer failure
Date:   Fri, 12 Jul 2019 16:40:30 +0530
Message-ID: <1562929830-29344-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562929838; bh=Bpqg9THc564UW6jjpjAHE0A0InKGoedygKCtxONKZcs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=eGt/lEK4ZiNSFr3+bBHWDszzCsqjqSQOqjI8cZnUZtSOXysZKzpFj5TBoaaTDYhIb
         r9Es5jpJS0aK9wN0Tsu9ZHR7SEmuJob8WhC9oBOZf40OR0dBgPU9zm5PXHkmvjvC4L
         b6uUfUeprEkuyIr125i+VTE7fPOiNWBEQaGhCyQ03ejxFd6l+XijouYHXHWBAZLFJd
         dxivpdCPnhlHDxcLgVv/Nc1Ithl5K6InIWk1rVo6jt1cFlCfj1xAYSgAUz5KAgzykk
         KCuSV7Htjn3cI6snTvbg+wWSgfzXoJj8JWmc3F4EBEZ/QYlT1l61JbzlrHC+0rQdJR
         eX5OYALgjMZfA==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From Tegra186 onwards OUTSTANDING_REQUESTS field is added in channel
configuration register(bits 7:4) which defines the maximum number of reads
from the source and writes to the destination that may be outstanding at
any given point of time. This field must be programmed with a value
between 1 and 8. A value of 0 will prevent any transfers from happening.

Thus added 'ch_pending_req' member in chip data structure and the same is
populated with maximum allowed pending requests. Since the field is not
applicable to Tegra210, mentioned bit fields are unused and hence the
member is initialized with 0. For Tegra186, by default program this field
with the maximum permitted value of 8.

Fixes: 433de642a76c ("dmaengine: tegra210-adma: add support for Tegra186/Tegra194")

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 2805853..5ab4e3a9 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -74,6 +74,8 @@
 				    TEGRA186_ADMA_CH_FIFO_CTRL_TXSIZE(3)    | \
 				    TEGRA186_ADMA_CH_FIFO_CTRL_RXSIZE(3))
 
+#define TEGRA186_DMA_MAX_PENDING_REQS			8
+
 #define ADMA_CH_REG_FIELD_VAL(val, mask, shift)	(((val) & mask) << shift)
 
 struct tegra_adma;
@@ -85,6 +87,7 @@ struct tegra_adma;
  * @ch_req_tx_shift: Register offset for AHUB transmit channel select.
  * @ch_req_rx_shift: Register offset for AHUB receive channel select.
  * @ch_base_offset: Register offset of DMA channel registers.
+ * @ch_pending_req: Outstaning DMA requests for a channel.
  * @ch_fifo_ctrl: Default value for channel FIFO CTRL register.
  * @ch_req_mask: Mask for Tx or Rx channel select.
  * @ch_req_max: Maximum number of Tx or Rx channels available.
@@ -98,6 +101,7 @@ struct tegra_adma_chip_data {
 	unsigned int ch_req_tx_shift;
 	unsigned int ch_req_rx_shift;
 	unsigned int ch_base_offset;
+	unsigned int ch_pending_req;
 	unsigned int ch_fifo_ctrl;
 	unsigned int ch_req_mask;
 	unsigned int ch_req_max;
@@ -602,6 +606,7 @@ static int tegra_adma_set_xfer_params(struct tegra_adma_chan *tdc,
 			 ADMA_CH_CTRL_FLOWCTRL_EN;
 	ch_regs->config |= cdata->adma_get_burst_config(burst_size);
 	ch_regs->config |= ADMA_CH_CONFIG_WEIGHT_FOR_WRR(1);
+	ch_regs->config |= cdata->ch_pending_req;
 	ch_regs->fifo_ctrl = cdata->ch_fifo_ctrl;
 	ch_regs->tc = desc->period_len & ADMA_CH_TC_COUNT_MASK;
 
@@ -786,6 +791,7 @@ static const struct tegra_adma_chip_data tegra210_chip_data = {
 	.ch_req_tx_shift	= 28,
 	.ch_req_rx_shift	= 24,
 	.ch_base_offset		= 0,
+	.ch_pending_req		= 0,
 	.ch_fifo_ctrl		= TEGRA210_FIFO_CTRL_DEFAULT,
 	.ch_req_mask		= 0xf,
 	.ch_req_max		= 10,
@@ -800,6 +806,7 @@ static const struct tegra_adma_chip_data tegra186_chip_data = {
 	.ch_req_tx_shift	= 27,
 	.ch_req_rx_shift	= 22,
 	.ch_base_offset		= 0x10000,
+	.ch_pending_req		= (TEGRA186_DMA_MAX_PENDING_REQS << 4),
 	.ch_fifo_ctrl		= TEGRA186_FIFO_CTRL_DEFAULT,
 	.ch_req_mask		= 0x1f,
 	.ch_req_max		= 20,
-- 
2.7.4

