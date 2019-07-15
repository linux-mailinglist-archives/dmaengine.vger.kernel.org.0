Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 411086827D
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jul 2019 05:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfGODRX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 14 Jul 2019 23:17:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35483 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfGODRX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 14 Jul 2019 23:17:23 -0400
Received: by mail-pg1-f195.google.com with SMTP id s1so688682pgr.2;
        Sun, 14 Jul 2019 20:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kb+x/QfQL3MhHmQt7WtgTjEDw3oPpOHTLxeQqt85Sps=;
        b=FyizgDvESf0WxQAwT0SmLWw0LWmQhG/GqMsWQbLcchozulcZDeW8RA646zEZU/iBe1
         FvEPS84PQqkYYTQHzFA6nqMqQYL1K0VT9Cu4ymMkQAgEnXgg+4aKO8wZ+QSc6Wbwiuj6
         fj898vDRCSR6rWtvaKmLXD8+9VGWXrVaGh5mGtkvNCAiDevV0YNRB91r+mOJONBdL5Iu
         R0go95hfRJSrk3iAmNQYQP/bteZP5Uzbwh6R/sGJB6HP2lARLbRiHJyZ4AGVLCD1fzSd
         OkUVmmKxpRsAUbzu1NOJUkqd6/11nkXA/0caghE2Bx/9xAHYXlCxQNp1HYPVln8u+C+C
         ytzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kb+x/QfQL3MhHmQt7WtgTjEDw3oPpOHTLxeQqt85Sps=;
        b=h4sNo+SZPBNTj45HdB3FBuP8YZz3tMggzid+5MXKHPqe8nrbD27zSaLWQcQ0wOgvAC
         QTeYkqOdzSBPWE/vig3O4wk8OiREsD+3xxeHRZhxsFAYmnzoRHn51UPZmA5W9Z8g2daj
         4TPyXGZ+qzEckzU3FOFmwJf+NMJUWqOlbSGkY/kQTTjHmVREYr7258jsypnuVh6Fvw6b
         RB/g5+u7Yadi2/q03HF6CPPCL1fBqboW3DyJmsPWaErOydUCK9a5R5AKfFZOYdelxywJ
         Bi+y9BvjU3obA/eNhuTzznyQwdHizXIQHDnoneGDaambLSRVxXLkLzvRGCFah9rxc0ZR
         mZsw==
X-Gm-Message-State: APjAAAUxu99VwZ7irt851aJmbVAcaedHWsx1KVi3AsMn/ToG4U5TlofF
        8sRo8RiRr+ddIN0aAcdN7SAvXDBaX3c=
X-Google-Smtp-Source: APXvYqz6wZgg8ErMw/22BWmPi/6AZiUkRYU00MUkLmykKZJoUOrdWhNoxhMCglQZxUTYlB3JBQU/Mw==
X-Received: by 2002:a65:6081:: with SMTP id t1mr24882534pgu.9.1563160642510;
        Sun, 14 Jul 2019 20:17:22 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id r9sm21256921pjq.3.2019.07.14.20.17.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jul 2019 20:17:22 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 03/24] dmaengine: imx-sdma: Remove call to memset after dma_alloc_coherent
Date:   Mon, 15 Jul 2019 11:17:16 +0800
Message-Id: <20190715031716.6328-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In commit 518a2f1925c3
("dma-mapping: zero memory returned from dma_alloc_*"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Use actual commit rather than the merge commit in the commit message

 drivers/dma/imx-sdma.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 4ec84a633bd3..decfb9e9648a 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1886,10 +1886,6 @@ static int sdma_init(struct sdma_engine *sdma)
 	sdma->context_phys = ccb_phys +
 		MAX_DMA_CHANNELS * sizeof (struct sdma_channel_control);
 
-	/* Zero-out the CCB structures array just allocated */
-	memset(sdma->channel_control, 0,
-			MAX_DMA_CHANNELS * sizeof (struct sdma_channel_control));
-
 	/* disable all channels */
 	for (i = 0; i < sdma->drvdata->num_events; i++)
 		writel_relaxed(0, sdma->regs + chnenbl_ofs(sdma, i));
-- 
2.11.0

