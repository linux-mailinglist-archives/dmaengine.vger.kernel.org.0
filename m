Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA807FD7F9
	for <lists+dmaengine@lfdr.de>; Fri, 15 Nov 2019 09:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfKOIbV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 Nov 2019 03:31:21 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36373 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfKOIbV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 15 Nov 2019 03:31:21 -0500
Received: by mail-pl1-f194.google.com with SMTP id d7so4132579pls.3;
        Fri, 15 Nov 2019 00:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RnTVU3msasSGFVmLQ6w3HwKQq7iABYeW4r2PZszqmD0=;
        b=UyApXg21rduT6941OYAxmxV6yDowZjbsIqLcSD7rlWy6kVOcgHvexsjgj5UDiJpD7F
         hz7bwGEZ8HB1Ldr6JOXdIjb1JCfIxPcIHmJACnloTi5FuI9WXn0JrtN2FWPWAO56Mm1P
         6TxjN2eM8S1NtjVNnQ1HPojLXZLIaTozP/5UJ0yj23tVe4mAw42syzutqN4R0cB0gHnW
         s1/NQUL6H9jW1kR0JIQdBW85ILQSwtYgM8A5KN8OfZgg8lgIyBrHEFWqehMQ70I7eXUP
         TV9qIHT0XzEa0Td6dRe5snuqkJJNLRQWARQC+xnZpe2dUhbJOBKQt9Mh0Rj5VmdwnBS0
         UvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RnTVU3msasSGFVmLQ6w3HwKQq7iABYeW4r2PZszqmD0=;
        b=Bch2xYkO4lZVZUjGEzYpDU4s5ulBjQM4mgbjR4/t9eUF4DoJPVqoHJgKn4MvOofoGt
         tSM1trur4J5BbOS2MiUfQLva2AwdSFEWljaV5cPZLGXYkwubzqGkSjiRELr+jNKZL+WL
         38+LlqWy1W4rL8jRQSyZjG8M0zgWPbB3DIBEeakXjU2kSSxhZwpwPV2AfaVCWk1lTjb6
         /S50sMcf1V9LQWOl9OX4WloAFLSFX4uc51UvNfGOsN0uKmHQa8PIw/ngG1ry1Hlt4UPP
         chvIDc27cb47GJcRK9zs7NcO2IY+PpUaeUhfZoH82FpRQ8CsyWvNSmc3NkVNmh5GxJ4x
         3EDQ==
X-Gm-Message-State: APjAAAUWhwrBvvGjZQm3hgxLG3h40nRvsiQwV2Pa5E3SXf+n/0at6mff
        m/wMs/jzJNMCHtqV+pLbUHk=
X-Google-Smtp-Source: APXvYqxgxpn5+ozBvP+tWX4FbyNK4npTxvNqQk9+ptchYUGRDCLEYH90309gfNmR/B9Dtwcmu5ymkw==
X-Received: by 2002:a17:90a:b30b:: with SMTP id d11mr17869764pjr.25.1573806680591;
        Fri, 15 Nov 2019 00:31:20 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id 81sm11804997pfx.142.2019.11.15.00.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 00:31:19 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 1/2] dmaengine: mmp_tdma: add missed of_dma_controller_free
Date:   Fri, 15 Nov 2019 16:31:00 +0800
Message-Id: <20191115083100.12220-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The driver calls of_dma_controller_register in probe but does not free
it in remove.
Add the call to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/dma/mmp_tdma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index e7d1e12bf464..10117f271b12 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -544,6 +544,9 @@ static void mmp_tdma_issue_pending(struct dma_chan *chan)
 
 static int mmp_tdma_remove(struct platform_device *pdev)
 {
+	if (pdev->dev.of_node)
+		of_dma_controller_free(pdev->dev.of_node);
+
 	return 0;
 }
 
-- 
2.24.0

