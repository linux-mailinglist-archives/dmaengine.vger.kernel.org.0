Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD50B7833E
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jul 2019 04:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfG2CI6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Jul 2019 22:08:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36086 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfG2CI6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Jul 2019 22:08:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so27389693pgm.3;
        Sun, 28 Jul 2019 19:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GgqqXrj0IVL3XCjuqMEeh46rLbd7N7hEVY5Hg1vftSk=;
        b=VhQ24Xm4qxQ1CYPaB6WhF5IedavT1hfH+pAW+nNKczx/aBxtKhr9dgC0SKzTRe7Ki1
         Q/JIQnvaFXbFkPQPNUtjOH9TiNTZxLeArg10E3/dbQT5HukCE3gU6ogpsY0Xe023uXaB
         xn6L0Njlqzzes1/8U6W8kkKjqQWd09QkV9vm68h+BXbnNyszCP9lzlVNMEulf7UTfHVd
         r6c/3wkyPbUYYHd411oyZDnVh08fs0lVD0Tki4DtGEgvvM2GURS+ibiV/DJcHrma8HIU
         g/7LUwI7OneWn3HokbE90LPxQFDugrsUgxA8SSO9yUJfauib0nV78nnai5iBhOqMhig/
         QmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GgqqXrj0IVL3XCjuqMEeh46rLbd7N7hEVY5Hg1vftSk=;
        b=YTtsZdVqAT+oNTb226A4dkGA/wjs3+wDyJeEWgpDuOvVpFEssrFyDTcIiJh+5unUFE
         tEnSfCu//qrGe22KCBhYgdeVEaCE3ocQyA/5mCirq1itXgtLPKugxg6qKby3HZ4MAxUH
         DmJjL0wWYW3B6Az2LxE1sxaBbhPpkHiuMip0isUBQppFfEbp0ZgTs8DLidoeT/Cd2Uf+
         4jlpHYe7mNKGMXJc0hwsztI4GuwNB7zMSp6d1YIIxqAoGhu7TFafJgtEy6zizSUtDym4
         OvvLVANjll60Jx6jt3v1VN2Ku12LwLhhqKyg4mKgPARj05fP851T00epmC3KMs8ynhcn
         jhYg==
X-Gm-Message-State: APjAAAWnHR2BXCf6u18yzQMhCN3GEThi/NiVU3cpDoIblAyIgPTzAUBB
        VVPYBlduzL3A81QfnFuG2Tg=
X-Google-Smtp-Source: APXvYqziKiVqdTi0EohhcF4w3kBjAEogyGJ2Ibb+1USarrNmtJONCBPCB1AYleTdYQ9v52s4F2E6kA==
X-Received: by 2002:a65:68c9:: with SMTP id k9mr68919329pgt.17.1564366137516;
        Sun, 28 Jul 2019 19:08:57 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id p15sm57011634pjf.27.2019.07.28.19.08.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 19:08:56 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] dma: stm32-mdma: Fix a possible null-pointer dereference in stm32_mdma_irq_handler()
Date:   Mon, 29 Jul 2019 10:08:49 +0800
Message-Id: <20190729020849.17971-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In stm32_mdma_irq_handler(), chan is checked on line 1368.
When chan is NULL, it is still used on line 1369:
    dev_err(chan2dev(chan), "MDMA channel not initialized\n");

Thus, a possible null-pointer dereference may occur.

To fix this bug, "dev_dbg(mdma2dev(dmadev), ...)" is used instead.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/dma/stm32-mdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index d6e919d3936a..1311de74bfdd 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -1366,7 +1366,7 @@ static irqreturn_t stm32_mdma_irq_handler(int irq, void *devid)
 
 	chan = &dmadev->chan[id];
 	if (!chan) {
-		dev_err(chan2dev(chan), "MDMA channel not initialized\n");
+		dev_dbg(mdma2dev(dmadev), "MDMA channel not initialized\n");
 		goto exit;
 	}
 
-- 
2.17.0

