Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C8E21EEE4
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2020 13:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgGNLQ4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jul 2020 07:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbgGNLQm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Jul 2020 07:16:42 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56267C08C5E3
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2020 04:15:56 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z13so20886675wrw.5
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2020 04:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=271JiKK80FLwolRF6spciLtpgZEz0e7WX3q5gXVxSzM=;
        b=raat87E0F+i5FkKKSfcO3L2BJ5q4wOj/rW3ptZDMlqpAJZ9MaUq1eZax/zYLu3u1ge
         +ZyWI3fFRpkmoWUgc+bymQ9frEC7/F/B8Q1NHD3kAgIQ/7Z1kiTsvp4eMiHBIuvmPQ/d
         FEknbe7lLIOAsbdIS5yrDLkZrtppZzfTEMJFXUnasPMvnauSITv7zvkVKwj2/0xVFxMh
         SXs6P9KeDUBqrH8rP7LfVq+F0db6vfdk3Z/uJilq1e5+7TGTLUh8dK55PbTqHpBb3gjg
         1gwM6YZOar952H6zAlL5fSktswLL5YpeaAWDTx727Q9tMQRM0EP1u+hCI2Gfs35Ni1K8
         6PRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=271JiKK80FLwolRF6spciLtpgZEz0e7WX3q5gXVxSzM=;
        b=jwPmX0L8BaQb0nGjGoJkOgvzlmnrpQBCEKRSoq5zSvchMYi+HRE1Cw7vZgmCNJX1SV
         FQzaebKV6TTlpcY7ckvM0z/ZTRTCl9pRUI8AAYt3uS9fOn0afQL1iGRuUsPXDwuYwdV8
         nNl3D/MJIxU41U6sjvR4plmvBWINjwcKp+TF3g/kxNohVbkw06py7mkeER6e16R00YGT
         aKvehBb0kKRJhKALKugjcGZOAugc8vfC/Z1FmZoFAIK/82Hv8iYUdloXlkZ8pO/2lMz6
         DqyXdzpfkmz/5VVza0pMOwDuELz/rA1uIwvn2pn9aYwbjeRbhmNkiUumgHqj69yUNltN
         MnKg==
X-Gm-Message-State: AOAM5303zNY3nReGwHylCB5H3cKvcIl4M36AKFtenS3QUrPibY9mC3/c
        4LaBiB9G+Olt9z5sYcRSYmP5DQ==
X-Google-Smtp-Source: ABdhPJxHSXSpUZXfp2uA6lo+uRLlOTalaig2KsNnaQ+tQtCBvn+WX9e2f1GMQPSpjVH56EMB/KpxqA==
X-Received: by 2002:a5d:4710:: with SMTP id y16mr4774395wrq.189.1594725355155;
        Tue, 14 Jul 2020 04:15:55 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id l8sm28566052wrq.15.2020.07.14.04.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 04:15:54 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jaswinder Singh <jassi.brar@samsung.com>
Subject: [PATCH 05/17] dma: pl330: Demote obvious misuse of kerneldoc to standard comment block
Date:   Tue, 14 Jul 2020 12:15:34 +0100
Message-Id: <20200714111546.1755231-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714111546.1755231-1-lee.jones@linaro.org>
References: <20200714111546.1755231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

No 'struct' title is provided.  Nor are any attribute descriptions.

Fixes the following W=1 kernel build warning(s):

 drivers/dma/pl330.c:295: warning: cannot understand function prototype: 'struct pl330_reqcfg '

Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Jaswinder Singh <jassi.brar@samsung.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/pl330.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 6a158eef6b8ad..4fc7aeec70a81 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -284,7 +284,7 @@ struct pl330_config {
 	u32		irq_ns;
 };
 
-/**
+/*
  * Request Configuration.
  * The PL330 core does not modify this and uses the last
  * working configuration if the request doesn't provide any.
-- 
2.25.1

