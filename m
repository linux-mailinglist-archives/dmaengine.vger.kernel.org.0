Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0BD24F8D7
	for <lists+dmaengine@lfdr.de>; Mon, 24 Aug 2020 11:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgHXJhy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Aug 2020 05:37:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbgHXIr3 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 24 Aug 2020 04:47:29 -0400
Received: from localhost.localdomain (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28FD22072D;
        Mon, 24 Aug 2020 08:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258848;
        bh=0ASM38NtqHvLkfihwuFhfZDcSaxHNeAcxdPp58Kpa4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0gzmVpTI2iar2LvRnsjGkjkzApTW6XVndHLQEY3qt0D8XTS42IHBGP0dgVmubv0aZ
         FqcCNSMULXxLDNsju8mdgsXxYtQ/rm66bzd0zRfxqenI5czhowATCehVbQeJf5Q2vi
         WMJX1C7ea6zTVH2tEWBSvjvlt851G0WzmqythizQ=
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] dmaengine: add peripheral configuration
Date:   Mon, 24 Aug 2020 14:17:11 +0530
Message-Id: <20200824084712.2526079-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200824084712.2526079-1-vkoul@kernel.org>
References: <20200824084712.2526079-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Some complex dmaengine controllers have capability to program the
peripheral device, so pass on the peripheral configuration as part of
dma_slave_config

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 include/linux/dmaengine.h | 75 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 6fbd5c99e30c..264643ca9209 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -380,6 +380,73 @@ enum dma_slave_buswidth {
 	DMA_SLAVE_BUSWIDTH_64_BYTES = 64,
 };
 
+/**
+ * enum spi_transfer_cmd - spi transfer commands
+ */
+enum spi_transfer_cmd {
+	SPI_TX = 1,
+	SPI_RX,
+	SPI_DUPLEX,
+};
+
+/**
+ * struct dmaengine_spi_config - spi config for peripheral
+ *
+ * @loopback_en: spi loopback enable when set
+ * @clock_pol: clock polarity
+ * @data_pol: data polarity
+ * @pack_en: process tx/rx buffers as packed
+ * @word_len: spi word length
+ * @clk_div: source clock divider
+ * @clk_src: serial clock
+ * @cmd: spi cmd
+ * @cs: chip select toggle
+ * @rx_len: receive length for spi buffer
+ */
+struct dmaengine_spi_config {
+	u8 loopback_en;
+	u8 clock_pol;
+	u8 data_pol;
+	u8 pack_en;
+	u8 word_len;
+	u32 clk_div;
+	u32 clk_src;
+	u8 fragmentation;
+	enum spi_transfer_cmd cmd;
+	u8 cs;
+	u32 rx_len;
+};
+
+/**
+ * struct dmaengine_i2c_config - i2c config for peripheral
+ *
+ * @pack_enable: process tx/rx buffers as packed
+ * @cycle_count: clock cycles to be sent
+ * @high_count: high period of clock
+ * @low_count: low period of clock
+ * @clk_div: source clock divider
+ * @addr: i2c bus address
+ * @strech: strech the clock at eot
+ * @op: i2c cmd
+ */
+struct dmaengine_i2c_config {
+	u8 pack_enable;
+	u8 cycle_count;
+	u8 high_count;
+	u8 low_count;
+	u16 clk_div;
+	u8 addr;
+	u8 strech;
+	u8 op;
+};
+
+enum dmaengine_peripheral {
+	DMAENGINE_PERIPHERAL_SPI,
+	DMAENGINE_PERIPHERAL_I2C,
+	DMAENGINE_PERIPHERAL_UART,
+	DMAENGINE_PERIPHERAL_LAST = DMAENGINE_PERIPHERAL_UART,
+};
+
 /**
  * struct dma_slave_config - dma slave channel runtime config
  * @direction: whether the data shall go in or out on this slave
@@ -418,6 +485,10 @@ enum dma_slave_buswidth {
  * @slave_id: Slave requester id. Only valid for slave channels. The dma
  * slave peripheral will have unique id as dma requester which need to be
  * pass as slave config.
+ * @peripheral: type of peripheral to DMA to/from
+ * @set_config: set peripheral config
+ * @spi: peripheral config for spi
+ * @:i2c peripheral config for i2c
  *
  * This struct is passed in as configuration data to a DMA engine
  * in order to set up a certain channel for DMA transport at runtime.
@@ -443,6 +514,10 @@ struct dma_slave_config {
 	u32 dst_port_window_size;
 	bool device_fc;
 	unsigned int slave_id;
+	enum dmaengine_peripheral peripheral;
+	u8 set_config;
+	struct dmaengine_spi_config spi;
+	struct dmaengine_i2c_config i2c;
 };
 
 /**
-- 
2.26.2

