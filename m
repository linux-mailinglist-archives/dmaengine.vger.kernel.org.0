Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2902F4A96
	for <lists+dmaengine@lfdr.de>; Wed, 13 Jan 2021 12:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbhAMLsD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Jan 2021 06:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbhAMLsA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Jan 2021 06:48:00 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6E8C0617A2;
        Wed, 13 Jan 2021 03:47:19 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id o13so2323183lfr.3;
        Wed, 13 Jan 2021 03:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fDwZd0C6Xpa6Bs5HyRFu6WqGn8vAbpuXSME/AOigppU=;
        b=LZhlPPBE3UNvtZEExpjfnWBnuXyEyeiPG18huM6EcwxstsEB0h6GNsC9Cf5cmtOAjX
         69Hj12Rqic7fFHmXUbh4ZNtzl2+dC/jZ6LTjYbcS4TPPf9RlpXksSLRKepHjeZ32nhM8
         d2+8Yog1HCaY5AxCx8N2cReVzj01Hld42Ikxo8ZhnFfcNnuOHaBr4fPwxX5sP6BmuY82
         O8oe6v3QTzo8zT0kqRUztc+IF5wDbkqRTlYoWIsmsPGSMoC+LE6rPNPpNP/CsjsqcvrG
         a3ErF5kBeO+Dcy9JcrrREXOEN13JhI1DyemcnM2eY9bgGLrNmOu7rZ2yeKUAfNFTZpBz
         QwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fDwZd0C6Xpa6Bs5HyRFu6WqGn8vAbpuXSME/AOigppU=;
        b=X2Uxpfn9PCNqMotGQqslQm7OI3MG9AM0ZcvS4wwYe5hKPRllDgJqeCzJbURMkRok1e
         4Y27HPjC6/0t9OHY8VwPyLlfPFFF9yZZmzBUG4s5iQJ73LGAEwjyN1Uk+gsiq3UH9CrV
         jx0JNEQxvz7F/E9sokrDKEkxUKgWVCVeyZ8d5QHMKBjcfsUTDLme8cEEoGNt1lp7n5Pr
         QjVrp3JO/CR41iB4K23mpxykSM+KbHNzACFo5qkjlqiOTvh/nNDsdhgLaYF7KMAcAFY9
         lEXo4y5U2PPbU/MbXY3koEJjD2fRqm2tqxgmZBK6YhFzCJDa3pKILk/WTQHRcZrZahxd
         OQnA==
X-Gm-Message-State: AOAM533Rk+EBSKaJpkzZ5wxKAvYVhC9C/L3Ze7MCO51u3SovnwlIs4YL
        KHYJJxTfk8y0MPm73K9uqH8=
X-Google-Smtp-Source: ABdhPJyHV49q1AH5CNTCnNESmg3AlQiSg17asCYmBkUVU2B/1fDKZdYaqOCxQfVw7XXB3zB7rhL3JQ==
X-Received: by 2002:a19:48ce:: with SMTP id v197mr723627lfa.359.1610538438059;
        Wed, 13 Jan 2021 03:47:18 -0800 (PST)
Received: from localhost.localdomain (91-157-87-152.elisa-laajakaista.fi. [91.157.87.152])
        by smtp.gmail.com with ESMTPSA id f19sm186489lfc.71.2021.01.13.03.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 03:47:17 -0800 (PST)
From:   Peter Ujfalusi <peter.ujfalusi@gmail.com>
To:     vkoul@kernel.org
Cc:     dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, vigneshr@ti.com,
        grygorii.strashko@ti.com, kishon@ti.com
Subject: [PATCH v2 3/3] dmaengine: ti: k3-udma: Do not initialize ret in tisci channel config functions
Date:   Wed, 13 Jan 2021 13:49:23 +0200
Message-Id: <20210113114923.9231-4-peter.ujfalusi@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210113114923.9231-1-peter.ujfalusi@gmail.com>
References: <20210113114923.9231-1-peter.ujfalusi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The ret does not need to be initialized to 0 in the tisci channel config
functions.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
---
 drivers/dma/ti/k3-udma.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 1030c2ff487a..4c0935c6930c 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -1830,7 +1830,7 @@ static int udma_tisci_m2m_channel_config(struct udma_chan *uc)
 	struct udma_tchan *tchan = uc->tchan;
 	struct udma_rchan *rchan = uc->rchan;
 	u8 burst_size = 0;
-	int ret = 0;
+	int ret;
 	u8 tpl;
 
 	/* Non synchronized - mem to mem type of transfer */
@@ -1889,7 +1889,7 @@ static int bcdma_tisci_m2m_channel_config(struct udma_chan *uc)
 	struct ti_sci_msg_rm_udmap_tx_ch_cfg req_tx = { 0 };
 	struct udma_bchan *bchan = uc->bchan;
 	u8 burst_size = 0;
-	int ret = 0;
+	int ret;
 	u8 tpl;
 
 	if (ud->match_data->flags & UDMA_FLAG_BURST_SIZE) {
@@ -1923,7 +1923,7 @@ static int udma_tisci_tx_channel_config(struct udma_chan *uc)
 	int tc_ring = k3_ringacc_get_ring_id(tchan->tc_ring);
 	struct ti_sci_msg_rm_udmap_tx_ch_cfg req_tx = { 0 };
 	u32 mode, fetch_size;
-	int ret = 0;
+	int ret;
 
 	if (uc->config.pkt_mode) {
 		mode = TI_SCI_RM_UDMAP_CHAN_TYPE_PKT_PBRR;
@@ -1964,7 +1964,7 @@ static int bcdma_tisci_tx_channel_config(struct udma_chan *uc)
 	const struct ti_sci_rm_udmap_ops *tisci_ops = tisci_rm->tisci_udmap_ops;
 	struct udma_tchan *tchan = uc->tchan;
 	struct ti_sci_msg_rm_udmap_tx_ch_cfg req_tx = { 0 };
-	int ret = 0;
+	int ret;
 
 	req_tx.valid_params = TISCI_BCDMA_TCHAN_VALID_PARAMS;
 	req_tx.nav_id = tisci_rm->tisci_dev_id;
@@ -1997,7 +1997,7 @@ static int udma_tisci_rx_channel_config(struct udma_chan *uc)
 	struct ti_sci_msg_rm_udmap_rx_ch_cfg req_rx = { 0 };
 	struct ti_sci_msg_rm_udmap_flow_cfg flow_req = { 0 };
 	u32 mode, fetch_size;
-	int ret = 0;
+	int ret;
 
 	if (uc->config.pkt_mode) {
 		mode = TI_SCI_RM_UDMAP_CHAN_TYPE_PKT_PBRR;
@@ -2074,7 +2074,7 @@ static int bcdma_tisci_rx_channel_config(struct udma_chan *uc)
 	const struct ti_sci_rm_udmap_ops *tisci_ops = tisci_rm->tisci_udmap_ops;
 	struct udma_rchan *rchan = uc->rchan;
 	struct ti_sci_msg_rm_udmap_rx_ch_cfg req_rx = { 0 };
-	int ret = 0;
+	int ret;
 
 	req_rx.valid_params = TISCI_BCDMA_RCHAN_VALID_PARAMS;
 	req_rx.nav_id = tisci_rm->tisci_dev_id;
@@ -2094,7 +2094,7 @@ static int pktdma_tisci_rx_channel_config(struct udma_chan *uc)
 	const struct ti_sci_rm_udmap_ops *tisci_ops = tisci_rm->tisci_udmap_ops;
 	struct ti_sci_msg_rm_udmap_rx_ch_cfg req_rx = { 0 };
 	struct ti_sci_msg_rm_udmap_flow_cfg flow_req = { 0 };
-	int ret = 0;
+	int ret;
 
 	req_rx.valid_params = TISCI_BCDMA_RCHAN_VALID_PARAMS;
 	req_rx.nav_id = tisci_rm->tisci_dev_id;
-- 
2.30.0

