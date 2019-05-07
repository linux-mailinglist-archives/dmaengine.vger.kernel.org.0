Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 330FB15D1C
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2019 08:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfEGGKN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 May 2019 02:10:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35552 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfEGGKN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 May 2019 02:10:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id h1so7740215pgs.2
        for <dmaengine@vger.kernel.org>; Mon, 06 May 2019 23:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ocbAuIAf3IKqxmrD8BDylPcrWXIwDT9EtJL2aoTkWT0=;
        b=eW6FDJOcTD20PObfZpdVGKkaItn9WQ1hYpVO8EGcNkYkpbdcbslbka9dSSdhBu5/us
         6m45eQR1VUr0hYBR8zTdkwc7je4Tm5t4GqvYRJYBo0PChRyyqW9tCMQSWgFzI3dX7VsQ
         FwBRCKZZcjZOhGApZPk48kNN24KkN6bXZ0GZ3N3RiLw5WOSQPiDCaTTvmxvt61LC4bxB
         FhvTbk6UNAE7dYiUZA8Wh2/YcDjgNCunpItqcjs/Str0If/TlRH7iOdCUPPabQRLeWXo
         jHa4ds3cktME2Ke6Do2jhx/oYHMVsK/6G4qQBQriJAmke3d62HFFWHJnVc+/TLFbwfpr
         lovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ocbAuIAf3IKqxmrD8BDylPcrWXIwDT9EtJL2aoTkWT0=;
        b=tDcjsd6jguvb/YaIBHVJvfO1zwPIknTlRzIk89QoYa03soH/pA2petvVtJg3w274ZB
         FiYhmquaYd2kC7L6xYfaAfP/N12N1qK277iE3n2W9TxrtEB4i5aGZIinVVSMgAPOyElp
         Gh7PbBZeDAhr9RgBW7QBIqXYXdIlkfc79Zj4ZbGU4DktyARTfkqPrgkSQvDXDfzqrnyw
         91sTyCFW3kSMVYmmnOfRPfzlmE+Obc/57FUkIs8Yq1vYt4DksO6Nfd/btIEKVObepV6I
         KF03QguO8/blXcGnM4XueoCXd0dzGWIDfs0SRs3RWdH2ZKO+OjRN7EZVfjW82upJ492/
         WRIA==
X-Gm-Message-State: APjAAAVvmCsgkKD5/WxOOfNNqcbBD431WitEP211dZKZqQzmUkaENqyQ
        rAwxE7ewT0yfIBpUX1LOKIt9Jw==
X-Google-Smtp-Source: APXvYqxKPo0qOh1P/ydBlkUZtj0v54YJ0oLi3CXxSzI1jQdpcFRZqvq/mvfJH7rjLXKntTXZ9qadKA==
X-Received: by 2002:a63:1706:: with SMTP id x6mr4601020pgl.280.1557209411899;
        Mon, 06 May 2019 23:10:11 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e184sm30786325pfc.102.2019.05.06.23.10.06
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 23:10:11 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Zubair.Kakakhel@imgtec.com,
        wsa+renesas@sang-engineering.com, jroedel@suse.de,
        vincent.guittot@linaro.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/8] dmaengine: Add matching device node validation in __dma_request_channel()
Date:   Tue,  7 May 2019 14:09:38 +0800
Message-Id: <17a22052fdb759ae6129e30f9bd8862f23a03ad9.1557206859.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1557206859.git.baolin.wang@linaro.org>
References: <cover.1557206859.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1557206859.git.baolin.wang@linaro.org>
References: <cover.1557206859.git.baolin.wang@linaro.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When user try to request one DMA channel by __dma_request_channel(), it won't
validate if it is the correct DMA device to request, that will lead each DMA
engine driver to validate the correct device node in their filter function
if it is necessary.

Thus we can add the matching device node validation in the DMA engine core,
to remove all of device node validation in the drivers.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/dmaengine.c   |   10 ++++++++--
 drivers/dma/of-dma.c      |    4 ++--
 include/linux/dmaengine.h |   12 ++++++++----
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 3a11b10..610080c 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -641,11 +641,13 @@ struct dma_chan *dma_get_any_slave_channel(struct dma_device *device)
  * @mask: capabilities that the channel must satisfy
  * @fn: optional callback to disposition available channels
  * @fn_param: opaque parameter to pass to dma_filter_fn
+ * @np: device node to look for DMA channels
  *
  * Returns pointer to appropriate DMA channel on success or NULL.
  */
 struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
-				       dma_filter_fn fn, void *fn_param)
+				       dma_filter_fn fn, void *fn_param,
+				       struct device_node *np)
 {
 	struct dma_device *device, *_d;
 	struct dma_chan *chan = NULL;
@@ -653,6 +655,10 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
 	/* Find a channel */
 	mutex_lock(&dma_list_mutex);
 	list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {
+		/* Finds a DMA controller with matching device node */
+		if (np && device->dev->of_node && np != device->dev->of_node)
+			continue;
+
 		chan = find_candidate(device, mask, fn, fn_param);
 		if (!IS_ERR(chan))
 			break;
@@ -769,7 +775,7 @@ struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask)
 	if (!mask)
 		return ERR_PTR(-ENODEV);
 
-	chan = __dma_request_channel(mask, NULL, NULL);
+	chan = __dma_request_channel(mask, NULL, NULL, NULL);
 	if (!chan) {
 		mutex_lock(&dma_list_mutex);
 		if (list_empty(&dma_device_list))
diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
index 91fd395..6b43d04 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -316,8 +316,8 @@ struct dma_chan *of_dma_simple_xlate(struct of_phandle_args *dma_spec,
 	if (count != 1)
 		return NULL;
 
-	return dma_request_channel(info->dma_cap, info->filter_fn,
-			&dma_spec->args[0]);
+	return __dma_request_channel(&info->dma_cap, info->filter_fn,
+				     &dma_spec->args[0], dma_spec->np);
 }
 EXPORT_SYMBOL_GPL(of_dma_simple_xlate);
 
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index d49ec5c..504085b 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1314,7 +1314,8 @@ static inline enum dma_status dma_async_is_complete(dma_cookie_t cookie,
 enum dma_status dma_wait_for_async_tx(struct dma_async_tx_descriptor *tx);
 void dma_issue_pending_all(void);
 struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
-					dma_filter_fn fn, void *fn_param);
+				       dma_filter_fn fn, void *fn_param,
+				       struct device_node *np);
 struct dma_chan *dma_request_slave_channel(struct device *dev, const char *name);
 
 struct dma_chan *dma_request_chan(struct device *dev, const char *name);
@@ -1339,7 +1340,9 @@ static inline void dma_issue_pending_all(void)
 {
 }
 static inline struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
-					      dma_filter_fn fn, void *fn_param)
+						     dma_filter_fn fn,
+						     void *fn_param,
+						     struct device_node *np)
 {
 	return NULL;
 }
@@ -1411,7 +1414,8 @@ static inline int dmaengine_desc_free(struct dma_async_tx_descriptor *desc)
 void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
 struct dma_chan *dma_get_slave_channel(struct dma_chan *chan);
 struct dma_chan *dma_get_any_slave_channel(struct dma_device *device);
-#define dma_request_channel(mask, x, y) __dma_request_channel(&(mask), x, y)
+#define dma_request_channel(mask, x, y) \
+	__dma_request_channel(&(mask), x, y, NULL)
 #define dma_request_slave_channel_compat(mask, x, y, dev, name) \
 	__dma_request_slave_channel_compat(&(mask), x, y, dev, name)
 
@@ -1429,6 +1433,6 @@ static inline int dmaengine_desc_free(struct dma_async_tx_descriptor *desc)
 	if (!fn || !fn_param)
 		return NULL;
 
-	return __dma_request_channel(mask, fn, fn_param);
+	return __dma_request_channel(mask, fn, fn_param, NULL);
 }
 #endif /* DMAENGINE_H */
-- 
1.7.9.5

