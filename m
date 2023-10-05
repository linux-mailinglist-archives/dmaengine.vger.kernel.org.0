Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F87F7BA459
	for <lists+dmaengine@lfdr.de>; Thu,  5 Oct 2023 18:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239960AbjJEQFP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Oct 2023 12:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237519AbjJEQEE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 Oct 2023 12:04:04 -0400
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFF5F0;
        Thu,  5 Oct 2023 07:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1696516127;
        bh=zYh0StUlW1/9GZ1nQmMvd67xErwUSkJSZvHWN7RYvWw=;
        h=From:To:Cc:Subject:Date;
        b=n8r8q8SBAMJMvMI3TGCJQMWZ66LiXMwWmRa6kCUFgLRRsK2EHDh51Zll1+NEitWL4
         XrLGaFGK8DJqMyAl1cO9387hUge7xZvFeqxmpcPcP0gBXJqwxzpCJlLg3cVRlSrUu+
         7Bs/L5hvwzt5tG31UDT0XDbKZvuKUZ66boHf6w58=
Received: from KernelDevBox.byted.org ([180.184.103.200])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id 72D30833; Thu, 05 Oct 2023 22:28:45 +0800
X-QQ-mid: xmsmtpt1696516125t7v14ww2j
Message-ID: <tencent_DD2D371DB5925B4B602B1E1D0A5FA88F1208@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAj7Xv7SNfCcx1y4p/riDf0NjD0pb458JvO99e9GBIo18F+sIu9Cw
         HIgV3FhsKAGYxGVDeEp0iZZ2v+Uit8GZN4jLaNGKhniEsWyIyvcPAKJJpQcoINsmbM02QGjS9FvT
         WjJfor7Kwr0s8Tk/I/xm9KWvGthXxCcclnrwEqeQwjlKAZUa1TF20FroXJJKQkWAQkfNFCFxsWK/
         sqFnEUqgcKjCiWnzmBeK7Yzi8tqrC2sdVMEjKUjZr5ZUFSFrb4wkWsiATZpwu5BAxnnOTWsZCedr
         3u3VA+WpzIJasVUjXSASbU2iGT/9RHDi3Xkr2CYE5QsRJ2M+M8qYd7FALEKHQ8kt7XXL40jcnC51
         KmBRzU4iPSs1E4bxFTOMA9OOVOyqiUAdtT5ykPggno5dNpK4/W8ZaJi37e588gy/gOGtUYxGrN8T
         0O4ZaX6BjLLEmuFv1cD7FK11EK2seXmUMe5g5Lvp+iQwtMWLO9jpEfCV+YFpw9uB6YFGJJdkLiCu
         0nfKtHfgdzqYAk6QIBXhYQo4kJXM3mJICHdtx4koyyTbSHCsyO/4JwEShK8A2UkQ8gpcn8BQ0Yyo
         ymT/yUnI+3XzrBEAmDZFwVxnh3Ndqpew2Bbk5AXdgENikl4BuVwc91RWmr0JeJCYVF6ninrmrrH6
         7S+hGQ1ylOit0Mif3P/BFbSib5jUlzbJsVO5aFr/tPMaky/79RbQa8Dv12DEqcJryBU8NHUu2WEr
         R7PJQDC+tLUAFsOd+naif3jS/vL6ucGnkcDtxr4DQUSP7n22TAs2FtTjxw1YXF9z3D2d1jcPmKJc
         CG9vaIEYsIJCOQG1jGjSPRwZY3otkMujjJQyWANn7FQDxknEorKYaeVmI2/iM7Bjy8S7DmaedLfF
         9ExJFtFT1QtQF2pCQzNhWw/zQjP5pJiB3CiHKo2AgRKvlGhY8u7jkBsnsHxj4aJdtAxKoG1dbc+5
         9OqthpWnrGi+DD8RPYFKR/mD9fnP2qsZUOWsNE7w7qPh0XadkrHptb3MuGbNSs2HQC5xaATJx7tK
         9QJdXxeQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     linus.walleij@linaro.org
Cc:     vkoul@kernel.org, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] maengine: ste_dma40: Fix PM disable depth imbalance in d40_probe
Date:   Thu,  5 Oct 2023 22:28:35 +0800
X-OQ-MSGID: <20231005142835.2256265-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pm_runtime_enable will increase power disable depth. Thus
a pairing decrement is needed on the error handling path to
keep it balanced according to context.
We fix it by calling pm_runtime_disable when error returns.

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/dma/ste_dma40.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 89e82508c133..002833fb1fa0 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3668,6 +3668,7 @@ static int __init d40_probe(struct platform_device *pdev)
 		regulator_disable(base->lcpa_regulator);
 		regulator_put(base->lcpa_regulator);
 	}
+	pm_runtime_disable(base->dev);
 
  report_failure:
 	d40_err(dev, "probe failed\n");
-- 
2.30.2

