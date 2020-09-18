Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C955E26F5EE
	for <lists+dmaengine@lfdr.de>; Fri, 18 Sep 2020 08:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgIRGa3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Sep 2020 02:30:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgIRGaZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 18 Sep 2020 02:30:25 -0400
Received: from localhost.localdomain (unknown [136.185.124.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C0E021534;
        Fri, 18 Sep 2020 06:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600410624;
        bh=+e+IoK54qWZAhooHnoOb+SkccNGfKNqvzSHWUZVBsF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rz2vEuuh8wJA5hH04sBlqBHc7a8+ygfS/eJcj/ibJiRT2ZIunUlTBCr0TW/XtZAoG
         c84aRC6/p8K6V1WzUPxTz6uTQmaqzPi+N+K6OwxvjoLk8WEgY5SdbW6+JMqqqMgFtg
         CzQOeFCfxhcTWb35yawbH3azOXR0EwMUPxL06GDE=
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 2/3] dmaengine: add peripheral configuration
Date:   Fri, 18 Sep 2020 11:59:54 +0530
Message-Id: <20200918062955.2095156-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200918062955.2095156-1-vkoul@kernel.org>
References: <20200918062955.2095156-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Some complex dmaengine controllers have capability to program the
peripheral device, so pass on the peripheral configuration as part of
dma_slave_config

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 include/linux/dmaengine.h | 90 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 6fbd5c99e30c..89e0fe8e0b1c 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -380,6 +380,93 @@ enum dma_slave_buswidth {
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
+};
+
+enum i2c_op {
+	I2C_WRITE = 1,
+	I2C_READ,
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
+ * @stretch: stretch the clock at eot
+ * @op: i2c cmd
+ */
+struct dmaengine_i2c_config {
+	u8 pack_enable;
+	u8 cycle_count;
+	u8 high_count;
+	u8 low_count;
+	u16 clk_div;
+	u8 addr;
+	u8 stretch;
+	enum i2c_op op;
+};
+
+enum dmaengine_peripheral {
+	DMAENGINE_PERIPHERAL_SPI = 1,
+	DMAENGINE_PERIPHERAL_UART = 2,
+	DMAENGINE_PERIPHERAL_I2C = 3,
+	DMAENGINE_PERIPHERAL_LAST = DMAENGINE_PERIPHERAL_I2C,
+};
+
+/**
+ * struct dmaengine_peripheral_config - peripheral configuration for
+ * dmaengine peripherals
+ *
+ * @peripheral: type of peripheral to DMA to/from
+ * @set_config: set peripheral config
+ * @rx_len: receive length for buffer
+ * @spi: peripheral config for spi
+ * @i2c: peripheral config for i2c
+ */
+struct dmaengine_peripheral_config {
+	enum dmaengine_peripheral peripheral;
+	u8 set_config;
+	u32 rx_len;
+	struct dmaengine_spi_config spi;
+	struct dmaengine_i2c_config i2c;
+};
 /**
  * struct dma_slave_config - dma slave channel runtime config
  * @direction: whether the data shall go in or out on this slave
@@ -418,6 +505,8 @@ enum dma_slave_buswidth {
  * @slave_id: Slave requester id. Only valid for slave channels. The dma
  * slave peripheral will have unique id as dma requester which need to be
  * pass as slave config.
+ * @peripheral: peripheral configuration for programming peripheral for
+ * dmaengine transfer
  *
  * This struct is passed in as configuration data to a DMA engine
  * in order to set up a certain channel for DMA transport at runtime.
@@ -443,6 +532,7 @@ struct dma_slave_config {
 	u32 dst_port_window_size;
 	bool device_fc;
 	unsigned int slave_id;
+	struct dmaengine_peripheral_config *peripheral;
 };
 
 /**
-- 
2.26.2

