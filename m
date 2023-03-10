Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8286B472C
	for <lists+dmaengine@lfdr.de>; Fri, 10 Mar 2023 15:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjCJOtL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Mar 2023 09:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbjCJOrs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Mar 2023 09:47:48 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A43B10BA55;
        Fri, 10 Mar 2023 06:47:27 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id bh20so4393065oib.9;
        Fri, 10 Mar 2023 06:47:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/a9bhNxzRZ1IGTLJ7xUEetWlshq1uPn2lTjxElE89s=;
        b=wAvizEdyWZhB85D/WMJtL4i+KloQT+631ZKTusm0Al7LLIxHaJeGxmn3z7MQT8q0VV
         /2clFs3Ux+3/h82442TaTZ1HjI9lPN2kasuM3F3sNPyGDFxan2bbQaBS4HrmNjBUIFyG
         KfU7qY+zRVhHAUorvloJI03oGsqPD3LegNVCePMl1rNsPNDJg2DU57i/YY4+SPKLxPeT
         Cg+wxDdTp9hufsdQyotlq6Qa6jRWy+2IwhNs5Xxhe8ejTvewyLK+GuUJpQqEg1XlTfUm
         zBwfdPLFxe1DaIy22cXGy7PD65JIJGwHKB5BU62wK3Dgj8vlFkQDO/fnEaY8Cg3YKjrW
         izKA==
X-Gm-Message-State: AO0yUKVIUwp4oL9sJoLMYOoO/mFHSEr7X6aUPdQ3NDbd/e0X2uNj7Mi6
        HHoNOjd3JlJL4nKd7RKt9rs0DUB8bw==
X-Google-Smtp-Source: AK7set+JthFJDb6u+EXgJnToD2sJtYf6XUQ0pqttCtiB0kVUHsXyPrwoMLReWyeXF71vwK5JTucg+A==
X-Received: by 2002:a05:6808:6d8:b0:37f:b1d6:9f4e with SMTP id m24-20020a05680806d800b0037fb1d69f4emr11392794oih.40.1678459643119;
        Fri, 10 Mar 2023 06:47:23 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l188-20020acabbc5000000b003785996ef36sm969477oif.19.2023.03.10.06.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:22 -0800 (PST)
Received: (nullmailer pid 1542002 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:04 -0000
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:03 -0600
Message-Id: <20230310144704.1541976-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties. As
part of this, convert of_get_property/of_find_property calls to the
recently added of_property_present() helper when we just want to test
for presence of a property and nothing more.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/dma/of-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
index ac61ecda2926..775a7f408b9a 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -264,7 +264,7 @@ struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
 	}
 
 	/* Silently fail if there is not even the "dmas" property */
-	if (!of_find_property(np, "dmas", NULL))
+	if (!of_property_present(np, "dmas"))
 		return ERR_PTR(-ENODEV);
 
 	count = of_property_count_strings(np, "dma-names");
-- 
2.39.2

