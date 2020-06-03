Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE26A1ED61C
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2020 20:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgFCS27 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Jun 2020 14:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFCS27 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Jun 2020 14:28:59 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AB8C08C5C0;
        Wed,  3 Jun 2020 11:28:57 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id a13so3528366ilh.3;
        Wed, 03 Jun 2020 11:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3NGIVu2o5ZfD238nU7EioWKtwbHFSnlq8NDGe0k+Ao4=;
        b=k3ilaOYF8Zi0ElPbQJ/D49l1sxfzgbs2aELXse9DU/MINXIppqkdvBI8IRGXkt7qnr
         YYF3d7PfHOOFB+hGrxZ3+xPRdzQU6XMqlx9T38qqrfKVoP64G+ZP4jO5wUMxTHl8sVhS
         cTJIPP/Q/q3qVd/z5hd/6Of2I0zkRaYEO0Z7YG2BOh+yG84ubkHJDtAHlttRRrV18rqD
         6X5ezQCYJ9TFzK4NOjPnaGDjgL1OfSlWRI0KRsAwMaDAIJY0CKKCJmptYGerKyak8Eud
         VNWoH3Z8z2mFwedGksqyvg03pOBIA90ohxYaa7prO8d+ShBZ3ixbSd3YzdNuJUYaEL/3
         qzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3NGIVu2o5ZfD238nU7EioWKtwbHFSnlq8NDGe0k+Ao4=;
        b=LaK+7v3zgpTuq1rrTGZyxqNzjVGk8YJ05HaZYuH3m7ZecAPlbBElqczPoBg4lvNElK
         jR1dHLJ/RMBR36QoaF7pAmK7gWibA6buSCuw5CeHQOhG/Kz5BCOjDeZYLxcXl4jpRaRn
         itd7yMCP/prlvve8Uw/A6PbRyaKIX3TJIdmfuHXNShQGQ37KeiS+7JEVE9StUlJMSGlb
         QQ60nDDN/OGDAlQIjljZlDjs2QijZByZJ8oCfuH2VDNyQjPKjRBgYf5qR36v41kTOtO5
         bqJj2Ki3I7Oc7nenl0XZ1UIFnwA5F3SCC5RUcYoynMf0ZmCfgJph//OHlOQjdKNc6iaK
         f/iQ==
X-Gm-Message-State: AOAM530Le5wLL+/h8ERvFD35nLz6w+GXcg968De7VQKHxy3fSe7rpCnw
        5u1gP01pDZyqYXhpfw3vzKA=
X-Google-Smtp-Source: ABdhPJxloba1LOqTexHUXjZhHas0R9a8NLk9aQarShAtzLkMpIQM5Zn2/I2esN8JN1+SF46qVDdTtQ==
X-Received: by 2002:a92:5e59:: with SMTP id s86mr843617ilb.104.1591208937224;
        Wed, 03 Jun 2020 11:28:57 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id y2sm152329ilg.69.2020.06.03.11.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 11:28:56 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] dmaengine: stm32-mdma: call pm_runtime_put if pm_runtime_get_sync fails
Date:   Wed,  3 Jun 2020 13:28:50 -0500
Message-Id: <20200603182850.66692-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Calling pm_runtime_get_sync increments the counter even in case of
failure, causing incorrect ref count. Call pm_runtime_put if
pm_runtime_get_sync fails.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/dma/stm32-mdma.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index 5469563703d1..79bee1bb73f6 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -1449,8 +1449,10 @@ static int stm32_mdma_alloc_chan_resources(struct dma_chan *c)
 	}
 
 	ret = pm_runtime_get_sync(dmadev->ddev.dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put(dmadev->ddev.dev);
 		return ret;
+	}
 
 	ret = stm32_mdma_disable_chan(chan);
 	if (ret < 0)
@@ -1718,8 +1720,10 @@ static int stm32_mdma_pm_suspend(struct device *dev)
 	int ret;
 
 	ret = pm_runtime_get_sync(dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_sync(dev);
 		return ret;
+	}
 
 	for (id = 0; id < dmadev->nr_channels; id++) {
 		ccr = stm32_mdma_read(dmadev, STM32_MDMA_CCR(id));
-- 
2.17.1

