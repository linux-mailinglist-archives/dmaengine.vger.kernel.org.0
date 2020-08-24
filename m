Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE6624F8D8
	for <lists+dmaengine@lfdr.de>; Mon, 24 Aug 2020 11:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgHXIrZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Aug 2020 04:47:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729453AbgHXIrW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 24 Aug 2020 04:47:22 -0400
Received: from localhost.localdomain (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBE0E2072D;
        Mon, 24 Aug 2020 08:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258842;
        bh=CxSjv/YPeHn2psgMqZYLdvTV3z8Of2HGj0cgfGf1TRU=;
        h=From:To:Cc:Subject:Date:From;
        b=PmsHv3iHX8VbOuxEQ5PP/9Zngk//r3WsR5lCbiazlkRlyTV7sVe076erSPYbxO0vl
         NXDI8+dFvdXBGLbufkI35IWAhqplZJ0otlCHdAG/HzIw3V6UJRR2wizpl1tTGu8+5Y
         iNnGMtednvU9Tm1Fzx1Lqf9cz5UeaF5xuoHNgp34=
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 0/3] dmaengine: Add support for Qcom GSI dma controller
Date:   Mon, 24 Aug 2020 14:17:09 +0530
Message-Id: <20200824084712.2526079-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This series adds support for Qcom GSI dma controller found on Qualcomm SoCs.
This controller can program the peripheral configuration so we add
additional parameters in dma_slave_config for configuring the peripherals
like spi and i2c.

Vinod Koul (3):
  dt-bindings: dmaengine: Document qcom,gpi dma binding
  dmaengine: add peripheral configuration
  dmaengine: qcom: Add GPI dma driver

 .../devicetree/bindings/dma/qcom-gpi.yaml     |   87 +
 drivers/dma/qcom/Kconfig                      |   12 +
 drivers/dma/qcom/Makefile                     |    1 +
 drivers/dma/qcom/gpi.c                        | 2269 +++++++++++++++++
 include/linux/dmaengine.h                     |   75 +
 5 files changed, 2444 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/qcom-gpi.yaml
 create mode 100644 drivers/dma/qcom/gpi.c

-- 
2.26.2

