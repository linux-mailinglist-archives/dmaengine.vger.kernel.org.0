Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA83C287438
	for <lists+dmaengine@lfdr.de>; Thu,  8 Oct 2020 14:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbgJHMcR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 8 Oct 2020 08:32:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:58002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729942AbgJHMcQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 8 Oct 2020 08:32:16 -0400
Received: from localhost.localdomain (unknown [122.182.224.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 987BB2083B;
        Thu,  8 Oct 2020 12:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602160335;
        bh=ySoQckmFJh8rm9F+Ix3Hhff1OcUz1ve3KxVHcsZ+2xA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mI5CoUeHWcffAjGKN3ozZqTb3SB5WHq24a0X7oVEUdvQwGB3gnZ0ZuHwmWjtT4YCE
         VzuV6wWCAB1hIqSPSwLECNvMgx5BkSob4Xd2aAxwHzcju4vAIu157bSL9ieDwoIXgr
         lEpMZRRXaO8Ef2e4OMv8n7XMJC+2D8egHO4O1Vns=
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 2/3] dmaengine: add peripheral configuration
Date:   Thu,  8 Oct 2020 18:01:50 +0530
Message-Id: <20201008123151.764238-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201008123151.764238-1-vkoul@kernel.org>
References: <20201008123151.764238-1-vkoul@kernel.org>
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
 include/linux/dmaengine.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 6fbd5c99e30c..a15dc2960f6d 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -418,6 +418,9 @@ enum dma_slave_buswidth {
  * @slave_id: Slave requester id. Only valid for slave channels. The dma
  * slave peripheral will have unique id as dma requester which need to be
  * pass as slave config.
+ * @peripheral_config: peripheral configuration for programming peripheral
+ * for dmaengine transfer
+ * @peripheral_size: peripheral configuration buffer size
  *
  * This struct is passed in as configuration data to a DMA engine
  * in order to set up a certain channel for DMA transport at runtime.
@@ -443,6 +446,8 @@ struct dma_slave_config {
 	u32 dst_port_window_size;
 	bool device_fc;
 	unsigned int slave_id;
+	void *peripheral_config;
+	size_t peripheral_size;
 };
 
 /**
-- 
2.26.2

