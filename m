Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9690A15D25
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2019 08:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfEGGK3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 May 2019 02:10:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33605 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfEGGK2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 May 2019 02:10:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id h17so1752588pgv.0
        for <dmaengine@vger.kernel.org>; Mon, 06 May 2019 23:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Cnx84NxIhSp4uZgqi6VSWZYaVNVqt10XSPlG8JL56aM=;
        b=zcT6IdJyApB7KuMxuSWwG5peXYnsSHChNqw51B358ycUWDId/NngGMOqGHnT3h3bSm
         qChmgQ9pGa5Yu+EMHMNgnlyKYIB+8jttgce0QhMdtSj38lOgaDPhUawls09xh0d5XiU9
         XcUQsGp7Ng6At2b8JIe5cM9Fi4JL9LcN1RY7mpjCslKb9GSOd5Mhf/HsE8HqngQ8riLP
         Tn/Gs+4flfKLlVDKesVK3VuGQZKXSUi+yaLrRL2c29XWNjnhW/3qUQ/1SZeyFjforxBc
         bUG3zRsnRVBy6oLxJo+88AKeAdIeoUpkW0hyt61HMVCFbY41ZhTb9Ur818qX/RjkvnlV
         3E3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Cnx84NxIhSp4uZgqi6VSWZYaVNVqt10XSPlG8JL56aM=;
        b=tdYhahXJI1PGO8SJL9bUtadjzwe0qEaM0X1h9unC0ISUPVjYsAQIf/y6+55XMdwH5V
         RaDPpCcWaWDNFIMIZzeaet+a/srvJXiT7RydqCElXUimFhSWFARP6aRLuxzWNFPAgWeP
         L81Ro4ygK6X5NwQx1lXcgZuyyG1BtJ61KEJonGJF2H9Le742doPtlEucxqrtsl7uzt1p
         udyHdxsJEwpDdhDrgKkiqV+JKoF2L0dToD5hZ9WL1s7ESo2+46rym9+jBn9vOb90KeN1
         lRzgEZkGty0z7oCo4UNjK6p6uQyuxltheiK5quZUMbA7zgqwB6ztIYAb+hGwznZezIGY
         BquQ==
X-Gm-Message-State: APjAAAWItc/AJJxCJiCenvCgvdPA0GGdNx/f3LiOBMwkj5vPPFDCENl3
        ga1CpLbZBCVKZs+hiHrvE1V+VA==
X-Google-Smtp-Source: APXvYqzkqrYcV0QI2O93YtbQlxdQBJiQcmO6JQgG6k1Oorppv4hJ97iFy40k5ajwk08mkc41nQffKg==
X-Received: by 2002:a65:534b:: with SMTP id w11mr37576307pgr.210.1557209427968;
        Mon, 06 May 2019 23:10:27 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e184sm30786325pfc.102.2019.05.06.23.10.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 23:10:27 -0700 (PDT)
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
Subject: [PATCH 4/8] dmaengine: dma-jz4780: Let the core do the device node validation
Date:   Tue,  7 May 2019 14:09:41 +0800
Message-Id: <0b8b0597623608bee186c573511be127ae5939c0.1557206859.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1557206859.git.baolin.wang@linaro.org>
References: <cover.1557206859.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1557206859.git.baolin.wang@linaro.org>
References: <cover.1557206859.git.baolin.wang@linaro.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Let the DMA engine core do the device node validation instead of drivers.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/dma-jz4780.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 9ce0a38..7e1d381 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -160,7 +160,6 @@ struct jz4780_dma_dev {
 };
 
 struct jz4780_dma_filter_data {
-	struct device_node *of_node;
 	uint32_t transfer_type;
 	int channel;
 };
@@ -765,8 +764,6 @@ static bool jz4780_dma_filter_fn(struct dma_chan *chan, void *param)
 	struct jz4780_dma_dev *jzdma = jz4780_dma_chan_parent(jzchan);
 	struct jz4780_dma_filter_data *data = param;
 
-	if (jzdma->dma_device.dev->of_node != data->of_node)
-		return false;
 
 	if (data->channel > -1) {
 		if (data->channel != jzchan->id)
@@ -790,7 +787,6 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
 	if (dma_spec->args_count != 2)
 		return NULL;
 
-	data.of_node = ofdma->of_node;
 	data.transfer_type = dma_spec->args[0];
 	data.channel = dma_spec->args[1];
 
@@ -815,7 +811,8 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
 		return dma_get_slave_channel(
 			&jzdma->chan[data.channel].vchan.chan);
 	} else {
-		return dma_request_channel(mask, jz4780_dma_filter_fn, &data);
+		return __dma_request_channel(&mask, jz4780_dma_filter_fn, &data,
+					     ofdma->of_node);
 	}
 }
 
-- 
1.7.9.5

