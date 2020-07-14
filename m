Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCBA21EEFF
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2020 13:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgGNLSm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jul 2020 07:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbgGNLQm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Jul 2020 07:16:42 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7ECC08C5F4
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2020 04:15:58 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id b6so20886752wrs.11
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2020 04:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xDspo//ZGGv62/k8vhH8b8dLXko1WA1DYqLJUY7Z0pU=;
        b=lRnHD6+n0Kjyezcw88EVB0+8py6DiaAYhCbxlABYw2m8o9Zqwb0e0UYsTQn6UzdoyM
         Ai/Lwf+avt/HMmYhCR2/TG+yz4ONmkQc2lUl56ky4FIDgvtg1bdsR8ab93IYufj3BDun
         i0WFD7NuGJNJDoZQohH34gqSOOdzQKa+D1J8sCzkxCvJV+Jwbn1/J2Scn0vFBzHdFMU4
         yHlh6N9RzslpQaPG35aqpOqxYCtYF2Q9jqYGfdLmmosobj45f6BOMGXsaHWrN8m60dsA
         vBG+Cnm/FE0W+t1lyKdF9znSpMDeukw6cl5PVzqvlV6+4bcIri+v2g7Y5SvFnTWu1qFI
         jtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xDspo//ZGGv62/k8vhH8b8dLXko1WA1DYqLJUY7Z0pU=;
        b=Ci0U6ykrymbip/82IL9upFixHN2UcVIz6acm4QWQ0KrP+On0JFBUv9Uew6PB6i2EKt
         c0UiOmPU5iJBxh5jTDthup/PKKkhp1Mt4p75YhIsSpnfZzAXmuFx2oTRNoc5KqHiJPlW
         TWLJ8ZaoxGu68f4iZOxdnspn2HYt6A6y3jNqtrPN60POZHA9Qc5dPCMuHiIgkiTYNqQp
         1UuDYmU6FHKmIfthDjmopDXHJXxG6IaLwsBU89Q6OXEWL0hO8ZaF0zAH0KZ+sRiB7tLF
         lF+n1o5ld6xdVoOAnGwcFZFP5VlsPO0UCF4klgnF0S5Anihi0WMBxfIjrC2IQLTPwp73
         SJuQ==
X-Gm-Message-State: AOAM5328QT8c0SlAmRZr++U2tqyMk40NmPQ60YlUbP68amF68AmrsYFM
        P68X7x6BPUPP0ctbQRPegdHFiw==
X-Google-Smtp-Source: ABdhPJzIzSvAOB3xgad3Sen6dlJzxBYaenPpru9T4eTefZSfzMtOdkfpSmMn9BuJRx6p9P4nOKO/4A==
X-Received: by 2002:a5d:6a90:: with SMTP id s16mr4580377wru.8.1594725357328;
        Tue, 14 Jul 2020 04:15:57 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id l8sm28566052wrq.15.2020.07.14.04.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 04:15:56 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Stefan Roese <sr@denx.de>
Subject: [PATCH 07/17] dma: altera-msgdma: Fix struct documentation blocks
Date:   Tue, 14 Jul 2020 12:15:36 +0100
Message-Id: <20200714111546.1755231-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714111546.1755231-1-lee.jones@linaro.org>
References: <20200714111546.1755231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fix some misspelling/description issues, demote non-kerneldoc header
to standard comment block and provide a new description for
msgdma_desc_config()'s 'stride' parameter.

Fixes the following W=1 kernel build warning(s):

 drivers/dma/altera-msgdma.c:163: warning: Function parameter or member 'node' not described in 'msgdma_sw_desc'
 drivers/dma/altera-msgdma.c:163: warning: Function parameter or member 'tx_list' not described in 'msgdma_sw_desc'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'lock' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'dev' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'irq_tasklet' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'pending_list' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'free_list' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'active_list' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'done_list' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'desc_free_cnt' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'idle' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'dmadev' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'dmachan' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'hw_desq' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'sw_desq' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'npendings' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'slave_cfg' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'irq' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'csr' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'desc' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'resp' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:265: warning: Function parameter or member 'stride' not described in 'msgdma_desc_config'

Cc: Stefan Roese <sr@denx.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/altera-msgdma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index 539e785039cac..321ac3a7aa418 100644
--- a/drivers/dma/altera-msgdma.c
+++ b/drivers/dma/altera-msgdma.c
@@ -153,7 +153,8 @@ struct msgdma_extended_desc {
  * struct msgdma_sw_desc - implements a sw descriptor
  * @async_tx: support for the async_tx api
  * @hw_desc: assosiated HW descriptor
- * @free_list: node of the free SW descriprots list
+ * @node: node to move from the free list to the tx list
+ * @tx_list: transmit list node
  */
 struct msgdma_sw_desc {
 	struct dma_async_tx_descriptor async_tx;
@@ -162,7 +163,7 @@ struct msgdma_sw_desc {
 	struct list_head tx_list;
 };
 
-/**
+/*
  * struct msgdma_device - DMA device structure
  */
 struct msgdma_device {
@@ -258,6 +259,7 @@ static void msgdma_free_desc_list(struct msgdma_device *mdev,
  * @dst: Destination buffer address
  * @src: Source buffer address
  * @len: Transfer length
+ * @stride: Read/write stride value to set
  */
 static void msgdma_desc_config(struct msgdma_extended_desc *desc,
 			       dma_addr_t dst, dma_addr_t src, size_t len,
-- 
2.25.1

