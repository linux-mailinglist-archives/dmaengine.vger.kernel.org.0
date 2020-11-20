Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601BC2BB065
	for <lists+dmaengine@lfdr.de>; Fri, 20 Nov 2020 17:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbgKTQXS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Nov 2020 11:23:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:41500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729610AbgKTQXQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 20 Nov 2020 11:23:16 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6FBC238E6;
        Fri, 20 Nov 2020 16:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889396;
        bh=Nr2UVcXq814pz5C9y4SEPaezF6RLs/f3ieQtap18svU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iYQRJ7n63pEHrYrbiXyPz8lsBLHQ8AhPVl0hNhq9BoLPfBImEtTQXgIeJy8qjMYKH
         0jt5VjbeKTctY5wox9MRs61kcgZ74x7Un/BAUMpX9xRlSWsHHB2g+fT1Nu7Bi+L75L
         OVbHikRkq0yrQbd2BftlLst1fVTMSgaA+cRE67dw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 2/6] dmaengine: dw-axi-dmac: drop of_match_ptr from of_device_id table
Date:   Fri, 20 Nov 2020 17:22:59 +0100
Message-Id: <20201120162303.482126-2-krzk@kernel.org>
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

    drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:984:34: warning:
        ‘dw_dma_of_id_table’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 14c1ac26f866..e164f3295f5d 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -992,7 +992,7 @@ static struct platform_driver dw_driver = {
 	.remove		= dw_remove,
 	.driver = {
 		.name	= KBUILD_MODNAME,
-		.of_match_table = of_match_ptr(dw_dma_of_id_table),
+		.of_match_table = dw_dma_of_id_table,
 		.pm = &dw_axi_dma_pm_ops,
 	},
 };
-- 
2.25.1

