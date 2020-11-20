Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDAA72BB070
	for <lists+dmaengine@lfdr.de>; Fri, 20 Nov 2020 17:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbgKTQXa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Nov 2020 11:23:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:41772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729999AbgKTQX1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 20 Nov 2020 11:23:27 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF0252245F;
        Fri, 20 Nov 2020 16:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889406;
        bh=TW9QAW2bJjU901D/24EX/NZE33VO0XZUivHwSIXQ8QQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bcQd5vpH+TDAt1JkLCb6v2m7neiC3aKeXnvHVr4qahN2C2bvsakCH27mqsDJYYroA
         vLTTOXMLaH3m58VfzJu8nfLdyIgpSwVVCT5T7tLv48UY5MDuALgDVm9w4Dg0ADBPfK
         By2b/8jR4sx+fvtNr98fcmssiENpxxTlx1IuPxQc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        chenqiwu <chenqiwu@xiaomi.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 6/6] dmaengine: ti: drop of_match_ptr and mark of_device_id table as maybe unused
Date:   Fri, 20 Nov 2020 17:23:03 +0100
Message-Id: <20201120162303.482126-6-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120162303.482126-1-krzk@kernel.org>
References: <20201120162303.482126-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The driver can match only via the DT table so the main table should be
always used and the of_match_ptr does not have any sense (this also
allows ACPI matching via PRP0001, even though it is not relevant here).

The secondary match of_device_id tables (passed to of_match_node) should
be marked as maybe unused to fix compile testing (!CONFIG_OF on x86_64)
warnings:

    drivers/dma/ti/dma-crossbar.c:125:34: warning:
        ‘ti_am335x_master_match’ defined but not used [-Wunused-const-variable=]
    drivers/dma/ti/dma-crossbar.c:22:34: warning:
        ‘ti_dma_xbar_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/dma/ti/dma-crossbar.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ti/dma-crossbar.c b/drivers/dma/ti/dma-crossbar.c
index 4ba8fa5d9c36..71d24fc07c00 100644
--- a/drivers/dma/ti/dma-crossbar.c
+++ b/drivers/dma/ti/dma-crossbar.c
@@ -122,7 +122,7 @@ static void *ti_am335x_xbar_route_allocate(struct of_phandle_args *dma_spec,
 	return map;
 }
 
-static const struct of_device_id ti_am335x_master_match[] = {
+static const struct of_device_id ti_am335x_master_match[] __maybe_unused = {
 	{ .compatible = "ti,edma3-tpcc", },
 	{},
 };
@@ -292,7 +292,7 @@ static const u32 ti_dma_offset[] = {
 	[TI_XBAR_SDMA_OFFSET] = 1,
 };
 
-static const struct of_device_id ti_dra7_master_match[] = {
+static const struct of_device_id ti_dra7_master_match[] __maybe_unused = {
 	{
 		.compatible = "ti,omap4430-sdma",
 		.data = &ti_dma_offset[TI_XBAR_SDMA_OFFSET],
@@ -460,7 +460,7 @@ static int ti_dma_xbar_probe(struct platform_device *pdev)
 static struct platform_driver ti_dma_xbar_driver = {
 	.driver = {
 		.name = "ti-dma-crossbar",
-		.of_match_table = of_match_ptr(ti_dma_xbar_match),
+		.of_match_table = ti_dma_xbar_match,
 	},
 	.probe	= ti_dma_xbar_probe,
 };
-- 
2.25.1

