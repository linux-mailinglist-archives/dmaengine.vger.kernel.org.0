Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D843311988
	for <lists+dmaengine@lfdr.de>; Thu,  2 May 2019 14:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfEBM4F (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 May 2019 08:56:05 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15822 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfEBM4E (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 May 2019 08:56:04 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ccae8ea0001>; Thu, 02 May 2019 05:56:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 02 May 2019 05:56:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 02 May 2019 05:56:03 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 2 May
 2019 12:56:03 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 2 May 2019 12:56:03 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ccae8e00000>; Thu, 02 May 2019 05:56:02 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 6/6] dmaengine: tegra210-adma: restore channel status
Date:   Thu, 2 May 2019 18:25:17 +0530
Message-ID: <1556801717-31507-7-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556801717-31507-1-git-send-email-spujar@nvidia.com>
References: <1556801717-31507-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556801770; bh=ID1XhaNkmlyJ4/V2Ya86P+TASPDdWK0Uaupkd2J88Bw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=n2lidRma0qX0AogLFQDPKxyZVWcErquDzWjfn6Bx9UVSk8IPl3QLiElIh0dQ+apHL
         yeAD6UfKBnatpe5KXo4es19Mcy168IiXU4gvws3WD1fcWjlvzLpMtRIjENeVuxbg5i
         /ynIjXqC/KjbNAdrPV7KmhNpa3K+DAgBfvX3vqEChvbgyOhGaG04q4uuC1HFRrrlFe
         6EggbaUn5iv8DBbrM8k1hBC/MG3UYpoZGD9dlNlDYTh0+ZWTLJMKTkcczqTMoy05TZ
         b0xTjsUwHHNUxmOxKucDDKU28F75CZu44/ZHH/ktvYw/ACsWk/VFaxqNUVLm6JU9oX
         bs0j84nX/ZW4g==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Status of ADMA channel registers is not saved and restored during system
suspend. During active playback if system enters suspend, this results in
wrong state of channel registers during system resume and playback fails
to resume properly. Fix this by saving following channel registers in
runtime suspend and restore during runtime resume.
 * ADMA_CH_LOWER_SRC_ADDR
 * ADMA_CH_LOWER_TRG_ADDR
 * ADMA_CH_FIFO_CTRL
 * ADMA_CH_CONFIG
 * ADMA_CH_CTRL
 * ADMA_CH_CMD
 * ADMA_CH_TC
Runtime PM calls will be inovked during system resume path if a playback
or capture needs to be resumed. Hence above changes work fine for system
suspend case.

Fixes: f46b195799b5 ("dmaengine: tegra-adma: Add support for Tegra210 ADMA")
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 46 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 953669d..21f6be1 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -112,6 +112,7 @@ struct tegra_adma_chan_regs {
 	unsigned int src_addr;
 	unsigned int trg_addr;
 	unsigned int fifo_ctrl;
+	unsigned int cmd;
 	unsigned int tc;
 };
 
@@ -141,6 +142,7 @@ struct tegra_adma_chan {
 	enum dma_transfer_direction	sreq_dir;
 	unsigned int			sreq_index;
 	bool				sreq_reserved;
+	struct tegra_adma_chan_regs	ch_regs;
 
 	/* Transfer count and position info */
 	unsigned int			tx_buf_count;
@@ -711,8 +713,30 @@ static struct dma_chan *tegra_dma_of_xlate(struct of_phandle_args *dma_spec,
 static int tegra_adma_runtime_suspend(struct device *dev)
 {
 	struct tegra_adma *tdma = dev_get_drvdata(dev);
+	struct tegra_adma_chan_regs *ch_reg;
+	struct tegra_adma_chan *tdc;
+	int i;
 
 	tdma->global_cmd = tdma_read(tdma, ADMA_GLOBAL_CMD);
+	if (!tdma->global_cmd)
+		goto clk_disable;
+
+	for (i = 0; i < tdma->nr_channels; i++) {
+		tdc = &tdma->channels[i];
+		ch_reg = &tdc->ch_regs;
+		ch_reg->cmd = tdma_ch_read(tdc, ADMA_CH_CMD);
+		/* skip if channel is not active */
+		if (!ch_reg->cmd)
+			continue;
+		ch_reg->tc = tdma_ch_read(tdc, ADMA_CH_TC);
+		ch_reg->src_addr = tdma_ch_read(tdc, ADMA_CH_LOWER_SRC_ADDR);
+		ch_reg->trg_addr = tdma_ch_read(tdc, ADMA_CH_LOWER_TRG_ADDR);
+		ch_reg->ctrl = tdma_ch_read(tdc, ADMA_CH_CTRL);
+		ch_reg->fifo_ctrl = tdma_ch_read(tdc, ADMA_CH_FIFO_CTRL);
+		ch_reg->config = tdma_ch_read(tdc, ADMA_CH_CONFIG);
+	}
+
+clk_disable:
 	clk_disable_unprepare(tdma->ahub_clk);
 
 	return 0;
@@ -721,7 +745,9 @@ static int tegra_adma_runtime_suspend(struct device *dev)
 static int tegra_adma_runtime_resume(struct device *dev)
 {
 	struct tegra_adma *tdma = dev_get_drvdata(dev);
-	int ret;
+	struct tegra_adma_chan_regs *ch_reg;
+	struct tegra_adma_chan *tdc;
+	int ret, i;
 
 	ret = clk_prepare_enable(tdma->ahub_clk);
 	if (ret) {
@@ -730,6 +756,24 @@ static int tegra_adma_runtime_resume(struct device *dev)
 	}
 	tdma_write(tdma, ADMA_GLOBAL_CMD, tdma->global_cmd);
 
+	if (!tdma->global_cmd)
+		return 0;
+
+	for (i = 0; i < tdma->nr_channels; i++) {
+		tdc = &tdma->channels[i];
+		ch_reg = &tdc->ch_regs;
+		/* skip if channel was not active earlier */
+		if (!ch_reg->cmd)
+			continue;
+		tdma_ch_write(tdc, ADMA_CH_TC, ch_reg->tc);
+		tdma_ch_write(tdc, ADMA_CH_LOWER_SRC_ADDR, ch_reg->src_addr);
+		tdma_ch_write(tdc, ADMA_CH_LOWER_TRG_ADDR, ch_reg->trg_addr);
+		tdma_ch_write(tdc, ADMA_CH_CTRL, ch_reg->ctrl);
+		tdma_ch_write(tdc, ADMA_CH_FIFO_CTRL, ch_reg->fifo_ctrl);
+		tdma_ch_write(tdc, ADMA_CH_CONFIG, ch_reg->config);
+		tdma_ch_write(tdc, ADMA_CH_CMD, ch_reg->cmd);
+	}
+
 	return 0;
 }
 
-- 
2.7.4

