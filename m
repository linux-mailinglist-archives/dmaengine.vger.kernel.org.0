Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730DD591FDB
	for <lists+dmaengine@lfdr.de>; Sun, 14 Aug 2022 15:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiHNNNz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 14 Aug 2022 09:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiHNNNy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 14 Aug 2022 09:13:54 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA9310FEE;
        Sun, 14 Aug 2022 06:13:52 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gp7so4889172pjb.4;
        Sun, 14 Aug 2022 06:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=fGiLdsou0tZYmT4+zIed2ZYLs4AlYvI3OzZQVfmavwc=;
        b=X1lEK3uFD84c6GDeRXOQttvfrQ0tWvRd4WfHp1QTHLg0xIbZPpv2hhmDUJ7sYTf4Fe
         gsxpamKzt9Md74IPQpW2gfLOl0TN2jpOIjy6ZnJPk3AonNyT+CBqeB95goBih5/2cjiI
         YtHcR8/ZqdI6QqTpzfrPIJS3p4+WZxCW8fXsM2yIOSsVnp/ogs1WurksOb/CfzN/00UB
         rXMSOgCBywgH8sIgqo+8r1tl3xkmlsLtJGvme9KvwOuVBBsdLLFAsqU/GqSdHW18mppE
         lrhJsMxrFzb8Zt+i4kZCMnxmiklAMIsGgIwdV/igLId8Fi1xHLiY1dpw4jh5npK/YUyQ
         rhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=fGiLdsou0tZYmT4+zIed2ZYLs4AlYvI3OzZQVfmavwc=;
        b=aLqnCepZVKAlf3++v3/CIsIC/RZu6pYewyyB0fXvFarzDOWgUxOliBc7X3wvxZb8T1
         Mh6og0e5w5GetmlgxR3y/RGeT4avjnu1HRmrGIUJ95nopypuwtvUFJiHYUlnavcefH6y
         y1GtMyZnFF88jatoszIaqj03SUCzqPoP9BkXKrtF+upWfTeX7y0ay4iYkUFXgUO6GpVj
         WTXUaZ2MqDoCZYz6I//MvDV6nRMN5vSxqvwoiZp2XnPJoGIC9h6ET+tZXkg2xIy/yPvb
         sWEZD6T5sBwxhUVGRmnUY4LgdvPZmy9pR2NCXyR+XKJD0x1oA2y1UAY8Q6saBnsCy7wX
         YtmA==
X-Gm-Message-State: ACgBeo0KjA13I+z8Egt6G3OCaaaUVZ3SsYJzRBMmpdG7OsSy6EYyUTnq
        sAgHeOWkskl2OaR2K+OZdN0=
X-Google-Smtp-Source: AA6agR56XymXCOBcunnS9iI0VLrdpJ5JeEHde8WRADkXS81AKHnFnWEQGiPhfm+UOR3byye5XCHAxQ==
X-Received: by 2002:a17:902:e80d:b0:16e:f7bf:34a7 with SMTP id u13-20020a170902e80d00b0016ef7bf34a7mr12565939plg.112.1660482831758;
        Sun, 14 Aug 2022 06:13:51 -0700 (PDT)
Received: from localhost.localdomain ([182.160.5.243])
        by smtp.gmail.com with ESMTPSA id x10-20020a170902ec8a00b0016cf195eb16sm5381359plg.185.2022.08.14.06.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 06:13:51 -0700 (PDT)
From:   Tuo Cao <91tuocao@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org
Cc:     konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        91tuocao@gmail.com
Subject: [PATCH] dmaengine: qcom: gpi: move read_lock_bh to read_lock in tasklet
Date:   Sun, 14 Aug 2022 21:13:23 +0800
Message-Id: <20220814131323.7029-1-91tuocao@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

it is unnecessary to call read_lock_bh in a tasklet.

Signed-off-by: Tuo Cao <91tuocao@gmail.com>
---
 drivers/dma/qcom/gpi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 8f0c9c4e2efd..236005f7dd30 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -1150,9 +1150,9 @@ static void gpi_ev_tasklet(unsigned long data)
 {
 	struct gpii *gpii = (struct gpii *)data;
 
-	read_lock_bh(&gpii->pm_lock);
+	read_lock(&gpii->pm_lock);
 	if (!REG_ACCESS_VALID(gpii->pm_state)) {
-		read_unlock_bh(&gpii->pm_lock);
+		read_unlock(&gpii->pm_lock);
 		dev_err(gpii->gpi_dev->dev, "not processing any events, pm_state:%s\n",
 			TO_GPI_PM_STR(gpii->pm_state));
 		return;
@@ -1163,7 +1163,7 @@ static void gpi_ev_tasklet(unsigned long data)
 
 	/* enable IEOB, switching back to interrupts */
 	gpi_config_interrupts(gpii, MASK_IEOB_SETTINGS, 1);
-	read_unlock_bh(&gpii->pm_lock);
+	read_unlock(&gpii->pm_lock);
 }
 
 /* marks all pending events for the channel as stale */
-- 
2.17.1

