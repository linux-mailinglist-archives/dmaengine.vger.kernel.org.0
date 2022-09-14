Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DBC5B90DF
	for <lists+dmaengine@lfdr.de>; Thu, 15 Sep 2022 01:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiINXI2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Sep 2022 19:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiINXI1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Sep 2022 19:08:27 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3598987095;
        Wed, 14 Sep 2022 16:08:26 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-11e9a7135easo45011165fac.6;
        Wed, 14 Sep 2022 16:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=OG5uQgkMf39mUwpOHjonQtZ4tonh493neJjEEVg5FeY=;
        b=f5mZWatEiHtHYsjX+/2J9ybC6dBmaIliKmhjebHkOCdUcXUrcJYa0GiSw7NHSXpRk2
         EqigwasC0utHelsC5d57UU3cojC3CC9+uI6AoEvc/zdm+5rGU/poVdqEFDORATWnon3z
         YJsLSG50uHXf3xMrJJbsJW+jlQKNxERIdIOdZ7+w3GFdbSW9r/EPRNtVyx94ZfEQHyLh
         uhPzJ0zZ+4BYZi/kZx93JYmkQhrxsEzfX0aKxpahNMsYmGuQAkbYwyh7n9rW8JpIxlVI
         XkPHF/M8WnE+0u5vZf04g/yvPBd7tcB672oQh+/KIjkfaDpCuQvYqOPwYHCbyWAayetL
         Cw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=OG5uQgkMf39mUwpOHjonQtZ4tonh493neJjEEVg5FeY=;
        b=4sTb3j9l0tLroAk0GTy4fsL5YGLW91/upQHFZPHW46LLPxiQ49c6VXXxX+zC0bcYHc
         ITQnFdIhaK9Iu9SYIOvytzA/J64y70eS4ybOdcQDq/yGC6d2Ksb3b7Du6hhwJV4fZMVt
         BQRalfA7ii9uAZj7U76nj/bbMe6WTJbdaq4ubGpmO6xpvTlxIZQRx15C5OsjGYFrE0Uk
         K7F0NVB6l+yS4f+X1r1lbevYTuXDq1D7r3Ws+qVn7FO06McNWFvhPrRSunyQSS5QKu5Y
         RGyAd6xh6K8kpr2xXzhjDKT0d9PXWD4aWxnd7Lbag2i1uwojP1d5N4wekCqO7rn4DqUM
         adqA==
X-Gm-Message-State: ACgBeo2D1fKMmMDipnwaUNXo7UCLJ+PHwqWvfTvcZlCdu0dCzelwGyH1
        ColN0wa0O+FLNsD/7R0V6Nc=
X-Google-Smtp-Source: AA6agR4Y0uGwS2dyAPZZOp1q1FZSHn4XnBflw70zqbMQ3/rXHFy1hJp2Nh95+MCKUYjGgjiREH8zKQ==
X-Received: by 2002:a05:6871:90:b0:11d:cbad:10f5 with SMTP id u16-20020a056871009000b0011dcbad10f5mr3684843oaa.295.1663196905406;
        Wed, 14 Sep 2022 16:08:25 -0700 (PDT)
Received: from macondo.. ([2804:431:e7cd:8cb3:fcc0:78f8:fb58:8a76])
        by smtp.gmail.com with ESMTPSA id s9-20020a056808008900b0034fddfc5922sm2741077oic.36.2022.09.14.16.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:08:25 -0700 (PDT)
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: idxd: Fix memory leak in idxd_alloc()
Date:   Wed, 14 Sep 2022 20:08:14 -0300
Message-Id: <20220914230815.700702-1-rafaelmendsr@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If the IDA id allocation fails, then the allocated memory for the
idxd_device struct doesn't get freed before returning NULL, which leads to
a memleak.

Fixes: 47c16ac27d4c ("dmaengine: idxd: fix idxd conf_dev 'struct device' lifetime")
Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
---
 drivers/dma/idxd/init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index aa3478257ddb..fdc97519b8fb 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -445,8 +445,10 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
 	idxd->data = data;
 	idxd_dev_set_type(&idxd->idxd_dev, idxd->data->type);
 	idxd->id = ida_alloc(&idxd_ida, GFP_KERNEL);
-	if (idxd->id < 0)
+	if (idxd->id < 0) {
+		kfree(idxd);
 		return NULL;
+	}
 
 	device_initialize(conf_dev);
 	conf_dev->parent = dev;
-- 
2.34.1

