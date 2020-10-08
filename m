Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43046287431
	for <lists+dmaengine@lfdr.de>; Thu,  8 Oct 2020 14:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbgJHMcJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 8 Oct 2020 08:32:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgJHMcI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 8 Oct 2020 08:32:08 -0400
Received: from localhost.localdomain (unknown [122.182.224.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1219D2083B;
        Thu,  8 Oct 2020 12:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602160328;
        bh=LoohXBIYM6by4r1CdV4o7M7SLraeBVy0aFYTWgXT4H4=;
        h=From:To:Cc:Subject:Date:From;
        b=ZEfek5CnZraG3jGE23MQPFNfLhx9Ci/tJIbSUPya0YmTQLcQrwwwXw6EtKsYsV1Ln
         I72Her2u6nuogMlXVB0O3CDIpgO6mVD9pPZqKD3Xge+ySwUXYIsuCNFTtx9PdwzCaE
         pOR0YbR5WcJRVLer1SyYbC+zuNp3YmxgVEcoh/mM=
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 0/3] dmaengine: Add support for QCOM GSI dma controller
Date:   Thu,  8 Oct 2020 18:01:48 +0530
Message-Id: <20201008123151.764238-1-vkoul@kernel.org>
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

 .../devicetree/bindings/dma/qcom,gpi.yaml     |   86 +
 drivers/dma/qcom/Kconfig                      |   12 +
 drivers/dma/qcom/Makefile                     |    1 +
 drivers/dma/qcom/gpi.c                        | 2303 +++++++++++++++++
 include/dt-bindings/dma/qcom-gpi.h            |   11 +
 include/linux/dmaengine.h                     |    5 +
 include/linux/qcom-gpi-dma.h                  |   83 +
 7 files changed, 2501 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/qcom,gpi.yaml
 create mode 100644 drivers/dma/qcom/gpi.c
 create mode 100644 include/dt-bindings/dma/qcom-gpi.h
 create mode 100644 include/linux/qcom-gpi-dma.h

-- 
2.26.2

