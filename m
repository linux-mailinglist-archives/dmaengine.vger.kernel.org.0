Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCEC5F018A
	for <lists+dmaengine@lfdr.de>; Fri, 30 Sep 2022 01:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiI2Xs0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 19:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiI2XsZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 19:48:25 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7790C1FBCA2
        for <dmaengine@vger.kernel.org>; Thu, 29 Sep 2022 16:48:24 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id bu5-20020a17090aee4500b00202e9ca2182so6299073pjb.0
        for <dmaengine@vger.kernel.org>; Thu, 29 Sep 2022 16:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/0Wgb/pUWIq+NWeSNBH6i++oWwTqz1d9Kg9pALwjvjA=;
        b=FFA5AvFdiJoD8ZXGTOX9XObUPvpOTpcri23xQDTYSWUroIjKZvko7P8Fgb195CoThl
         ZmZIMUqXJU7WOREVUj0tG9xEvAxFnyJ4CPZRZrrYy5Ykud5bDwSpxMAKrA2LXtmAq9Oo
         6ygMDK0KTq0tcn6WvlIsH3C2F90gID986kXVk3cZPS9lefu2Ug4XnwSt2PA5B1FntdkI
         yuTFUDSXZ11PXSmgAwNZVJBWD1SB8dmPutEf1IjLs/BmrLhos8ZQFWrRSTb+MwZduAtC
         fjNrimJVYhr6HMdVJoWAplnxkFyKWkkY8LLd4TIv4iur/27axEeNLJhG7N6MCc8vfv/q
         5cAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/0Wgb/pUWIq+NWeSNBH6i++oWwTqz1d9Kg9pALwjvjA=;
        b=eDqBDSXpMmXCT5DpKyoMWPp9Oos+OR/fm4r6ym+iVQttSMkOiT/NWDzRBAk/eYaJxI
         oKCmq6NJP8DGcwE02KUscMTBf+/gn+AHv/6vrwJPkVSUEa8l/xhCD6Mg4BcwXEDjEaTd
         lfZXmyQ4ol/f73Pw/DacfBLtqXkX/XE8iaS2QR+qii+FPOjM6LWf5g7Z8h2Rg9256FEu
         OJ0mq2fPruwPA5yW5i5XCGtgRE8pAuzW4Sl+mckXJj1HPWdSjZhv6MxuMrgH+cXLob/1
         +FgDgTT5M8nyr+LxVTDQSvkQ8hJgsrYoNbl7kt9XWcAm8UO+V3c0cwhgcUN0IYDuw7rh
         2hKQ==
X-Gm-Message-State: ACrzQf0zaGMgiiOtGtPrT//ikcCy3K98vFkYuLvNKxjVu02NzssHQCAL
        8nzn2xL3IDGdD7VrB7MH+iMxLXEQl5upwQ==
X-Google-Smtp-Source: AMsMyM63oMj5kO7k7gGLUNOH4mETJh8gyb0IpoCD4PoCB57/pCr6/9T+lo9fUigXsPu6NBe//v4STw==
X-Received: by 2002:a17:90b:3909:b0:203:a4c6:32b8 with SMTP id ob9-20020a17090b390900b00203a4c632b8mr19051414pjb.5.1664495304010;
        Thu, 29 Sep 2022 16:48:24 -0700 (PDT)
Received: from localhost ([75.172.140.17])
        by smtp.gmail.com with ESMTPSA id d17-20020a170902f15100b0017b224969d6sm468132plb.76.2022.09.29.16.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 16:48:23 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas Frayer <nfrayer@baylibre.com>
Subject: [PATCH v3 1/3] of/irq: export of_msi_get_domain
Date:   Thu, 29 Sep 2022 16:48:18 -0700
Message-Id: <20220929234820.940048-2-khilman@baylibre.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20220929234820.940048-1-khilman@baylibre.com>
References: <20220929234820.940048-1-khilman@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Export of_mis_get_domain to enable it for users from outside.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20200122104723.16955-1-peter.ujfalusi@ti.com
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/of/irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index d22f605fa7ee..c9308baa32c5 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -727,6 +727,7 @@ struct irq_domain *of_msi_get_domain(struct device *dev,
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(of_msi_get_domain);
 
 /**
  * of_msi_configure - Set the msi_domain field of a device
-- 
2.34.0

