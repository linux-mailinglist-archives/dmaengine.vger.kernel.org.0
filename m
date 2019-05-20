Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF2723283
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2019 13:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732892AbfETLci (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 May 2019 07:32:38 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39725 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732891AbfETLci (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 May 2019 07:32:38 -0400
Received: by mail-pl1-f196.google.com with SMTP id g9so6593726plm.6
        for <dmaengine@vger.kernel.org>; Mon, 20 May 2019 04:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Pu70ShnJxUdtWer7PLRUZo2fIfEap/6ISYxXnxlKkFM=;
        b=tSv5fPUTNSCsf6Ukd/lSAyUahMBsuc98eyjNM/qYxJeGXkwXVbkgNJc+pFwwZNwv2I
         Scn3L30ZnZrh9pzJAS7Meka65ldkpHDUxxklBTFrXzLQCxefgHwNPeqldbEfdzqoduEM
         pTuac3U1VGESKok+UbgmEytjjjr2gT+RbqAUNzQOVoM4Sxre2l02WmG5IoLOn/sX6LQX
         vg81cGBQVbG4FEE6CgSXlvQm1VweLAbyQf/2saQPC28lXohZr907F2vyCvk8jX08yTCl
         8uaY04tYzl4kT8BSqqHpTtAVSWnAndVIQlXLRfe2ou8slxwxC8J8LlE7FFcia65HeMW9
         bRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Pu70ShnJxUdtWer7PLRUZo2fIfEap/6ISYxXnxlKkFM=;
        b=jCCOtdW2AeK8RQ6KaGWBi9QAN2D43SvCjjBNy+iuCFq2Lf4tYsHyzRgAF2WPVyA36+
         aMYgyQ9bdpU96QuYD9Jd4K0iWq3dTIVhEaggytj6tUEvDT5bOrUNO32ToEiTXRjkNADc
         v14RK8gpmqm0yUrRQvrbqaGOiawLvUgCx3xxWjJBwB8uvv/yxoBp+D8GcnHAWxefWQyb
         zT3WiT+XSTq79XoTBsYDce8ALtPMcvDVRLzDADTgwvlhyjZ3TY/a9BzMNIVmpxFN3xdt
         70w3lI9E/0SU7Q3lsrXxsjVJ5RewXHnisuaQ7jGP5/UdaDn8g+VaVBsP1iif3jbBH7ix
         JQCg==
X-Gm-Message-State: APjAAAX/iX6+khLwXMGA2YiCQibUVJFOSoodhwSQlDdo7OMpnMM3xc2Y
        X/0U5Q0/S+DCksJD/Mzk82nG+A==
X-Google-Smtp-Source: APXvYqwHu74YjBkzbQE6BKlSW/l5+RvOSNMRXBkWCZa08ZuVF8USsRLbC/WnBBD/UHKRmsu6Y6DNcQ==
X-Received: by 2002:a17:902:9a9:: with SMTP id 38mr31813396pln.10.1558351957443;
        Mon, 20 May 2019 04:32:37 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id z124sm21310020pfz.116.2019.05.20.04.32.31
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 04:32:36 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, wsa+renesas@sang-engineering.com,
        jroedel@suse.de, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/8] dmaengine: Add matching device node validation in __dma_request_channel()
Date:   Mon, 20 May 2019 19:32:14 +0800
Message-Id: <5eb3a0099f7ade7e81226c69bfab5443e83c03cc.1558351667.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1558351667.git.baolin.wang@linaro.org>
References: <cover.1558351667.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1558351667.git.baolin.wang@linaro.org>
References: <cover.1558351667.git.baolin.wang@linaro.org>
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

Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
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

