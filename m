Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293B349FEB8
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jan 2022 18:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350482AbiA1ROK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Jan 2022 12:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239932AbiA1ROK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Jan 2022 12:14:10 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2072C061714;
        Fri, 28 Jan 2022 09:14:09 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id q75so5720802pgq.5;
        Fri, 28 Jan 2022 09:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=3HKvw7RmRl9AmLbgC4sjiOJOnps10BqulQIk/YMasUM=;
        b=V+of1R+dqR7p3vfs7edHrhH7kXfGFKcKThZN9TiZjMY4tyfa6hlisnp1JDgmZLVrsV
         ItvTpvu2cZzrQnic1W1yvZq7ZMPFS6UGbjXAu/rSEQpAIUTNHg2rGbIt7v/9PRqcwuV1
         Hr+aWDGnfgvC3rNqJDbCYsgH9k/SmVUSez2P7BkHusXpBDqjyPKp0w01gMRhh2VftcLT
         FnmhJ7YqAWV9E70bZCkmqRf+5PgzTVR/zzj21l4eyZVjOFyS2Rw+1uY+j2P8zqZ3GPOr
         YH0CEICmjc4Bw7Qk0tQWf8vFVDezSbhbaOJcghHsX29jNCekuXnkrUerdqWMNWTU9mmH
         U9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3HKvw7RmRl9AmLbgC4sjiOJOnps10BqulQIk/YMasUM=;
        b=110MRnCsVVrGfxT7AL8dj0ex9Oa/RJgIveAbJD6ht7irWm+dKrpymvCeIWaeGIQJ3B
         TCOUxlU71GC7ol7EeKCg2uLSwNvxpWVwmVPTbM4xtGjnV8a+EZmBtabFDS5vIXoald4D
         ECZvR++OjA092GWbSi9Q5PgrdV5+0kH9nVCG61GFRIgmnppPx9ToDdkflTOWfRLHWHnX
         du1v5FwZZKdN1bPaqsX3AAewegu6tSugxPkeJhBxcrpIt1IfgLuUZ6CWhDfW6QqM1Jnz
         W97T2LqIeK3iQ/Te7A4ZPwkTsAW5CSGuK4CmjZtMjyUzN4a7t4hsTy6STZvi8egL+WBY
         qpbg==
X-Gm-Message-State: AOAM533RjaomgmL+KwfYvfX4tWKz6n7i2bCS2IU6nI/FDmGHl7G7zjXW
        8asm4zbwAWmW26ZJt4TBYKs=
X-Google-Smtp-Source: ABdhPJzyj2s37MUyXeQ5otVkNfOpDjIDAn9bLvgGUPoTXA7E84cwE8k4iXyVZBfXra8gBXD7dZuqvg==
X-Received: by 2002:a05:6a00:14cf:: with SMTP id w15mr6294747pfu.53.1643390049558;
        Fri, 28 Jan 2022 09:14:09 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id l14sm10420502pjf.1.2022.01.28.09.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 09:14:09 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Zhangfei Gao <zhangfei.gao@marvell.com>,
        Arnd Bergmann <arnd@arndb.de>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] dmaengine: mmp_pdma: Fix missing IRQ check in mmp_pdma_probe
Date:   Fri, 28 Jan 2022 17:14:03 +0000
Message-Id: <20220128171403.29878-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This func misses checking for platform_get_irq()'s call and may passes the
negative error codes to request_threaded_irq(), which takes unsigned IRQ #,
causing it to fail with -EINVAL, overriding an original error code.
Stop calling request_threaded_irq() with invalid IRQ #s.

Fixes: c8acd6aa6bed ("dmaengine: mmp-pdma support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/dma/mmp_pdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 5a53d7fcef01..c03f4f7ece88 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -1067,6 +1067,8 @@ static int mmp_pdma_probe(struct platform_device *op)
 	if (irq_num != dma_channels) {
 		/* all chan share one irq, demux inside */
 		irq = platform_get_irq(op, 0);
+		if (irq < 0)
+			return irq;
 		ret = devm_request_irq(pdev->dev, irq, mmp_pdma_int_handler,
 				       IRQF_SHARED, "pdma", pdev);
 		if (ret)
-- 
2.17.1

