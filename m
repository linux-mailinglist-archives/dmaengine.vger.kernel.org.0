Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04F9723284
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2019 13:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732907AbfETLcn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 May 2019 07:32:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34021 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732905AbfETLcn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 May 2019 07:32:43 -0400
Received: by mail-pl1-f196.google.com with SMTP id w7so6613292plz.1
        for <dmaengine@vger.kernel.org>; Mon, 20 May 2019 04:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=SH6bOeq9QaZcFruKHetHjcR5Vxn/cn2SAhXtcAspD6Q=;
        b=sflEPPU61og2VFcVypItpwuhuRDg9RrZEU06pKHkq2dyUELMdFIRetA3Amp70Gtasf
         LhfWjt1c9cmf+TG5FSEfkVz+lZS0jhnu+radx8ygtiMy6DUBV6VY/q7zmVwRrpmQQgY2
         B9Dc9sKeRreukolUt81y2EoSpDcHlDSNm3QhtmO5fmJhtkfyi6KzETanmpcUjlCFpOcf
         Q26N+Ofg3YiM4/uR0pX24XqD7mW/EcgeKAO2TfSrLASTOTfUwr2snO69Ns6Zc+0XQf1M
         LBwZV3ZxwK9YX1i7P0cXIqNlvHWZPbknS8ZDFw4g+tubEeoIjZHWwcDoF3THlN+Gxy0Y
         vhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=SH6bOeq9QaZcFruKHetHjcR5Vxn/cn2SAhXtcAspD6Q=;
        b=bnwd7WvW6VOfYMVsHzTOnsGL+zTcE8+fD0paGl98zSGLyqVCyxFCR6PPaexYXZp+Km
         5CCjhntdTtBVEVH/9s06bBVwg38uDF79qTKnACYUiby2gwxIJfFdAt27ZQQpHt8v7AAn
         cW/ggCJRz3yIvcMufh3RbHRr8GmHNlJht0PrCeY0RvJ+gDyU3QaZ8a9Vc44AgB7CClFn
         mv1QTj8b28CJKBzr64ntsOs172ZtbJeBnnNRGDDT+QyGeU954r3sVMehmwNlMYnXEUdR
         4nn1gNvKYcE3V/Zo6rX1rWAn+qQd3ci/HT+nxg+Q9cmGkJet0LQIE7EaPrngg9jXPtBO
         qwSA==
X-Gm-Message-State: APjAAAVKCsOfprLZQ0rI31quJjjLF1F7rHL3NN8LOmoK0qu95oEb6UBZ
        6Tf+Rx0h2Jx4t27stGlovs0Tyw==
X-Google-Smtp-Source: APXvYqw5fPKlpPwCDX8Prno12aw6CFqlLCWkN1e77syboLkhzA1LnbIZ14RetfpmMHPjpaxnXWlwXw==
X-Received: by 2002:a17:902:a81:: with SMTP id 1mr29319466plp.287.1558351962410;
        Mon, 20 May 2019 04:32:42 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id z124sm21310020pfz.116.2019.05.20.04.32.37
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 04:32:42 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, wsa+renesas@sang-engineering.com,
        jroedel@suse.de, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/8] soc: tegra: fuse: Use dma_request_channel instead of __dma_request_channel()
Date:   Mon, 20 May 2019 19:32:15 +0800
Message-Id: <f1dc31b78b6852bc12a126380816ee32cf78a3f5.1558351667.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1558351667.git.baolin.wang@linaro.org>
References: <cover.1558351667.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1558351667.git.baolin.wang@linaro.org>
References: <cover.1558351667.git.baolin.wang@linaro.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The __dma_request_channel() prototype has been changed to help to do
device node validation, thus we can use dma_request_channel() instead
of __dma_request_channel() to keep kernel bisectable.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/soc/tegra/fuse/fuse-tegra20.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra20.c b/drivers/soc/tegra/fuse/fuse-tegra20.c
index 49ff017..f40a06f 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra20.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra20.c
@@ -110,7 +110,7 @@ static int tegra20_fuse_probe(struct tegra_fuse *fuse)
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	fuse->apbdma.chan = __dma_request_channel(&mask, dma_filter, NULL);
+	fuse->apbdma.chan = dma_request_channel(mask, dma_filter, NULL);
 	if (!fuse->apbdma.chan)
 		return -EPROBE_DEFER;
 
-- 
1.7.9.5

