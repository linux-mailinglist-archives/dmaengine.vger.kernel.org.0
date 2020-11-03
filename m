Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621C22A4426
	for <lists+dmaengine@lfdr.de>; Tue,  3 Nov 2020 12:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgKCLZ6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Nov 2020 06:25:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:45932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbgKCLZ6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 3 Nov 2020 06:25:58 -0500
Received: from localhost.localdomain (unknown [122.179.37.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BF6520731;
        Tue,  3 Nov 2020 11:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604402757;
        bh=bI/cN2eK3dgD8W09CCdUq1uvP05TdDTIOdYfKBD5af8=;
        h=From:To:Cc:Subject:Date:From;
        b=eHjQokZKwmzyPkSoDOz8FI5mSFZAhigtrhEJdazY1sKr3FbFdgWkK15DM2DliluF1
         xUCyWiDDOA7fEPuW1Bfe9M7debFa3wXznQ3pgfXUg3Z0m8ZxherQSTB7MOfcXnaCNm
         WRyjOu/cM5PmDNjn9EZg4Q89gtRbtNOh8SgGXARQ=
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v5 0/3] dmaengine: Add support for QCOM GSI dma controller
Date:   Tue,  3 Nov 2020 16:55:41 +0530
Message-Id: <20201103112544.674566-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This series adds support for Qcom GSI dma controller found on Qualcomm SoCs.
This controller can program the peripheral configuration so we add
additional parameters in dma_slave_config for configuring the peripherals
like spi and i2c.

Changes in v5:
 - Add acked by Rob
 - Move qcom-gpi-dma.h header to include/linux/dma/
 - rebase and test on v5.10-rc2

Changes in v3:
 - Update the i2c tre creation based on testing feedback

Changes in v2:
 - Update the binding and drop qcom specific properties
 - Move peripheral configuration as a pointer
 - Move submit queue for transactions to issue_pending

Vinod Koul (3):
  dt-bindings: dmaengine: Document qcom,gpi dma binding
  dmaengine: add peripheral configuration
  dmaengine: qcom: Add GPI dma driver

 .../devicetree/bindings/dma/qcom,gpi.yaml     |   90 +
 drivers/dma/qcom/Kconfig                      |   12 +
 drivers/dma/qcom/Makefile                     |    1 +
 drivers/dma/qcom/gpi.c                        | 2303 +++++++++++++++++
 include/dt-bindings/dma/qcom-gpi.h            |   11 +
 include/linux/dma/qcom-gpi-dma.h              |   83 +
 include/linux/dmaengine.h                     |    5 +
 7 files changed, 2505 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/qcom,gpi.yaml
 create mode 100644 drivers/dma/qcom/gpi.c
 create mode 100644 include/dt-bindings/dma/qcom-gpi.h
 create mode 100644 include/linux/dma/qcom-gpi-dma.h

-- 
2.26.2

