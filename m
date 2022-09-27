Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBB95ED0B8
	for <lists+dmaengine@lfdr.de>; Wed, 28 Sep 2022 01:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiI0XIK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Sep 2022 19:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiI0XIJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Sep 2022 19:08:09 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F9A10C7B4
        for <dmaengine@vger.kernel.org>; Tue, 27 Sep 2022 16:08:08 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id v10-20020a17090a634a00b00205e48cf845so156939pjs.4
        for <dmaengine@vger.kernel.org>; Tue, 27 Sep 2022 16:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/0Wgb/pUWIq+NWeSNBH6i++oWwTqz1d9Kg9pALwjvjA=;
        b=DvNf2QAz0UeP6EdWSsJ0nLp7UC/cTYt1i+tB6cGYeQOQmAvWQhnvHRTda6G8CT3LUk
         mbCmI0RCl74H4fto4GkN5wPH1Sp5wM5BwZqOHEsBMF3nUjAQjhr+sKgNXAT/gUxIaxLy
         TS0GtqYNLZTbvG9W08ShNreSUrTW7Odg64X5lbKYiuW1IDtP4YIZueUASu63Lb63H3EF
         MsuWjw3bxeaJawYs9zIDUEq96bVL5uIMj0e0tlSpES+mCxUsy11ljhhgPlzQ8e7SL1Xr
         s/pXXQamNyJhPCmk8yrZjIPI4SSTUJISb5QBsMYOpH+3kPZX+kjIi+j++pVEb0+yxO1f
         2bVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/0Wgb/pUWIq+NWeSNBH6i++oWwTqz1d9Kg9pALwjvjA=;
        b=vuc3cRUpS653gJUfkOqu5hLk3mP+bGVTkHWh9hPFb7m0C1ctfb1WnruV8iukP3Qo8K
         8D8uM2Vt4ZOhtJrkmNMX8nOhhG+WCr27dx+0FQPfZV6+b7un5G5VbkEdHijfNmrIU+Gl
         FiZVlBcJb5DprtK+n4hGlWru2ZPcK0FTI4YtJH6JYCDu2OLDcyc2Jweflob2zga3QJxT
         Shvh5PzLONAHX7Mgu35S+pBVppn43astwWhBs9Mi2tQgKsBn5mM+HNo4LZRFWS0RRuf0
         JA8CBD6wUmJZCIy+GoDAgzv90D5VERsC7mjqNTcsIlntBM0Jdd3x/QNtQiltFqcVdTHL
         40QA==
X-Gm-Message-State: ACrzQf2QhgBZ5ZExSl+EUFDsoyTcT+Zx0l0H+/hQDuGr1D1720TI8fzN
        ylKYl0yBBluWNqieskWa/Q4xYA==
X-Google-Smtp-Source: AMsMyM5wYuSJqm+bKdlRIYCXAy/FatWIyUqT1yDRQc5JfrKgKJaC3qlgpz/ZghVX344Tk4e8jXrotA==
X-Received: by 2002:a17:902:c1cb:b0:179:edcc:2bf9 with SMTP id c11-20020a170902c1cb00b00179edcc2bf9mr4736379plc.110.1664320087794;
        Tue, 27 Sep 2022 16:08:07 -0700 (PDT)
Received: from localhost ([76.146.1.42])
        by smtp.gmail.com with ESMTPSA id n3-20020a170903110300b00177e590df96sm2134637plh.118.2022.09.27.16.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 16:08:07 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas Frayer <nfrayer@baylibre.com>
Subject: [PATCH v2 1/3] of/irq: export of_msi_get_domain
Date:   Tue, 27 Sep 2022 16:08:02 -0700
Message-Id: <20220927230804.4085579-2-khilman@baylibre.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20220927230804.4085579-1-khilman@baylibre.com>
References: <20220927230804.4085579-1-khilman@baylibre.com>
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

