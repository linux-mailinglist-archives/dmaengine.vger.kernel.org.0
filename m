Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9482BB063
	for <lists+dmaengine@lfdr.de>; Fri, 20 Nov 2020 17:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbgKTQXP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Nov 2020 11:23:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:41466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729479AbgKTQXO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 20 Nov 2020 11:23:14 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A890A2225B;
        Fri, 20 Nov 2020 16:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889394;
        bh=GD/4TnOvthPn81TQPxKjq+gxB6xPNHIl91TStLL37aU=;
        h=From:To:Cc:Subject:Date:From;
        b=OPC/Fo8NlZ6n6dQYPkb9WFyGkxKKmUHVGLLeYtth3dz5rxZsnRO4rQEBD9pJj0Skv
         E4KDFiLfOBhQB3bW4+63ZmM2vPHrEh5E1wgwaV1RS3Hq6AyJ2YLwm8vV3NGU5jXKmv
         Gt7HQ8xzwVvW/gBqJbZ7rnBK2KVSJjozb8uSHH+g=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/6] dmaengine: jz4780: drop of_match_ptr from of_device_id table
Date:   Fri, 20 Nov 2020 17:22:58 +0100
Message-Id: <20201120162303.482126-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it is not relevant here).  This fixes
compile warning (!CONFIG_OF on x86_64):

    drivers/dma/dma-jz4780.c:1031:34: warning:
        ‘jz4780_dma_dt_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/dma/dma-jz4780.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index a608efaa435f..612d353648cf 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -1044,7 +1044,7 @@ static struct platform_driver jz4780_dma_driver = {
 	.remove		= jz4780_dma_remove,
 	.driver	= {
 		.name	= "jz4780-dma",
-		.of_match_table = of_match_ptr(jz4780_dma_dt_match),
+		.of_match_table = jz4780_dma_dt_match,
 	},
 };
 
-- 
2.25.1

