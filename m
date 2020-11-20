Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2C22BB075
	for <lists+dmaengine@lfdr.de>; Fri, 20 Nov 2020 17:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbgKTQXl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Nov 2020 11:23:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:41542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729660AbgKTQXS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 20 Nov 2020 11:23:18 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8B372240B;
        Fri, 20 Nov 2020 16:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889398;
        bh=rmaDY9nYXHbucnp1zbru/h6Fjyr4l11wnGIr71foVYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o0H6rNWpJo7LGr8vsmCu46FAHcCAYg2XoLjiauh9GqqlERlHyAa9w47c9nqWGw1Zy
         llJmRHJAAB4oN94hKv2J6K13GT50n0X/K7KpdVCghqF7qhk2rCZqFoIeH4UEB+OXV2
         KitU28DOev8rDPUJJ4O6MpqFhP10YQ9P7/SbM6/Y=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/6] dmaengine: mv_xor: drop of_match_ptr from of_device_id table
Date:   Fri, 20 Nov 2020 17:23:00 +0100
Message-Id: <20201120162303.482126-3-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120162303.482126-1-krzk@kernel.org>
References: <20201120162303.482126-1-krzk@kernel.org>
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

    drivers/dma/mv_xor.c:1281:34: warning:
        ‘mv_xor_dt_ids’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/dma/mv_xor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 00cd1335eeba..23b232b57518 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1455,7 +1455,7 @@ static struct platform_driver mv_xor_driver = {
 	.resume         = mv_xor_resume,
 	.driver		= {
 		.name	        = MV_XOR_NAME,
-		.of_match_table = of_match_ptr(mv_xor_dt_ids),
+		.of_match_table = mv_xor_dt_ids,
 	},
 };
 
-- 
2.25.1

