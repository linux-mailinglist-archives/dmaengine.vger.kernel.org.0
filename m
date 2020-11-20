Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17102BB068
	for <lists+dmaengine@lfdr.de>; Fri, 20 Nov 2020 17:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgKTQXU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Nov 2020 11:23:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:41646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729961AbgKTQXU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 20 Nov 2020 11:23:20 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B04382245F;
        Fri, 20 Nov 2020 16:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889400;
        bh=Y0apPeHoItDbAMBFQS1AgZJTxllIuZ8ISE2pZIsLLGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E9Ia9noNivCNv/5TDEcxKRv3mULcwe5bpbrbaSAS/OSM98o06pq1OF8sq3nZXL8c3
         kn1q+g3lfHkfDxvyp2QDg4RK/1O13oW8zbapbaqOaJkcx4DZtxWvUqgNwXzEvlSyne
         UwwpYuXMXUzhS9DI9tvfQtefVoEnJA8bF4xqntxw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Green Wan <green.wan@sifive.com>
Subject: [PATCH 4/6] dmaengine: sf: drop of_match_ptr from of_device_id table
Date:   Fri, 20 Nov 2020 17:23:01 +0100
Message-Id: <20201120162303.482126-4-krzk@kernel.org>
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

    drivers/dma/sf-pdma/sf-pdma.c:576:34: warning:
        ‘sf_pdma_dt_ids’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/dma/sf-pdma/sf-pdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index 528deb5d9f31..d5b73a765eb5 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -584,7 +584,7 @@ static struct platform_driver sf_pdma_driver = {
 	.remove		= sf_pdma_remove,
 	.driver		= {
 		.name	= "sf-pdma",
-		.of_match_table = of_match_ptr(sf_pdma_dt_ids),
+		.of_match_table = sf_pdma_dt_ids,
 	},
 };
 
-- 
2.25.1

