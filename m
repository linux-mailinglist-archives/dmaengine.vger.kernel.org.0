Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5019C23108E
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jul 2020 19:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbgG1RJo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Jul 2020 13:09:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731070AbgG1RJo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 28 Jul 2020 13:09:44 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10DEF20786;
        Tue, 28 Jul 2020 17:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595956184;
        bh=Vc2rMDS5cOizIyVH8O3qqpisYycogDLFoYxum968D7o=;
        h=From:To:Cc:Subject:Date:From;
        b=qHuYyuwqh5urEGHmKOBY7VYwAq9K+8QG/tt9zPJMFOI3WY0jQsXZv/NPYp4+kuifW
         NnUvl6v+K9i0gUfTj1rj1N7f0ojQjcvvejl/5QZkke9BlItAy2UxLf47ikL307zwP+
         9mvsrmrNP0JeIqaIIyo34HMrdEkeSdmIsdeSfgIE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] dmaengine: ti: omap-dma: Drop of_match_ptr to fix -Wunused-const-variable
Date:   Tue, 28 Jul 2020 19:09:39 +0200
Message-Id: <20200728170939.28278-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The of_device_id is included unconditionally by of.h header and used
in the driver as well.  Remove of_match_ptr to fix W=1 compile test
warning with !CONFIG_OF:

    drivers/dma/ti/omap-dma.c:1892:34: warning: 'omap_dma_match' defined but not used [-Wunused-const-variable=]
     1892 | static const struct of_device_id omap_dma_match[] = {

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/dma/ti/omap-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 918301e17552..c9fe5e3a6b55 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1904,7 +1904,7 @@ static struct platform_driver omap_dma_driver = {
 	.remove	= omap_dma_remove,
 	.driver = {
 		.name = "omap-dma-engine",
-		.of_match_table = of_match_ptr(omap_dma_match),
+		.of_match_table = omap_dma_match,
 	},
 };
 
-- 
2.17.1

