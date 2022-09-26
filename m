Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6606D5EAF9F
	for <lists+dmaengine@lfdr.de>; Mon, 26 Sep 2022 20:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiIZSWd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Sep 2022 14:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiIZSWR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 26 Sep 2022 14:22:17 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7D75142C
        for <dmaengine@vger.kernel.org>; Mon, 26 Sep 2022 11:18:52 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id l65so7501424pfl.8
        for <dmaengine@vger.kernel.org>; Mon, 26 Sep 2022 11:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/0Wgb/pUWIq+NWeSNBH6i++oWwTqz1d9Kg9pALwjvjA=;
        b=OAbnJpnmU6XFNt5nES+EJFQyCvS7N43F1TH8Qvar/5VyAvdmf04DqJIB+zQlY/21Fo
         KevaxR1gGYYO1iMedhUOPk6f4fg1m93ghagAUs06mw/zHuzurupi7t21VCRdiV8CW5bd
         xPdL9ubtYkZSyTQrRPXPJ11aj2Wb/IYTA/AmLxTalsQlXxUYKFCqvrGNDIJWFrQpL50m
         /mj3thiS3dYLLd2s/Wa/3QPVv4QHWMrEuvmV2vW4pLQvVBTZvFHMRZmrHU6xpPDntZqo
         fnzHYGEr6VxiwHkg+cXT3hAp4a1o3uiIPGNdBn91PmQXB5U81wCzSzuGjnX8yhOxKnXy
         f0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/0Wgb/pUWIq+NWeSNBH6i++oWwTqz1d9Kg9pALwjvjA=;
        b=pcqHXJYJwUAp+cMzPPWJFT+pwPTgLnodG20VC8/NAJ4lOPw4Dsp+8se3Dv8X2ZXedn
         72Kwj/oWUu5b86J/S+7QIAd6iApqh8iuN5EskiTQ/vadft9m7tc24CKwNEeQjuq9wDnW
         qG6naeoetysMncwZQxSkzFb5w8vSmWR7VTt33kIsVWFngautVCQE66URicemi3L3bfld
         2v3H/RQXQ+6Ve3mCKSCAiiEF/HIqDIBD0Jmtupx5Q3rzqBEGW6KZErRA/KWvtu8d+s3R
         abcSXj3H86+8YOXsYRpMhc3QpyuW5z6PPxK3fL1eiuOxzQAwad8W8psvQD1iHx8u1uc+
         hcCw==
X-Gm-Message-State: ACrzQf325hZL09Kh3uZQO0QrRRQq+6TnmtDA++orocZ5bAJQs1SzdtZr
        oBNlCwQaJs8WVYmUc3WjpFw9OA==
X-Google-Smtp-Source: AMsMyM7ITbNUZuCGG4FQ4Hb14MHVV8qELDpnSpkbJKtx6Z/tP/VCS6/W2sMfgf6huxANh254I8Kr1Q==
X-Received: by 2002:aa7:9af5:0:b0:54e:5455:2b8c with SMTP id y21-20020aa79af5000000b0054e54552b8cmr25379183pfp.63.1664216332104;
        Mon, 26 Sep 2022 11:18:52 -0700 (PDT)
Received: from localhost ([76.146.1.42])
        by smtp.gmail.com with ESMTPSA id z16-20020aa79e50000000b00537d7cc774bsm12510356pfq.139.2022.09.26.11.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 11:18:51 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas Frayer <nfrayer@baylibre.com>
Subject: [PATCH 1/3] of/irq: export of_msi_get_domain
Date:   Mon, 26 Sep 2022 11:18:46 -0700
Message-Id: <20220926181848.2917639-2-khilman@baylibre.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20220926181848.2917639-1-khilman@baylibre.com>
References: <20220926181848.2917639-1-khilman@baylibre.com>
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

