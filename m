Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A80E2BB06D
	for <lists+dmaengine@lfdr.de>; Fri, 20 Nov 2020 17:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbgKTQXY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Nov 2020 11:23:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:41684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729999AbgKTQXW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 20 Nov 2020 11:23:22 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A90952225B;
        Fri, 20 Nov 2020 16:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889402;
        bh=b4u/t0Hst9rVcGF2Gll2KrBiXj/Rs/Ms1ZSr/qfr4Qs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oQk4n6t+bHcdcPjjQtvOOCwdEHG56qCd3TPvolN5j9amfJOg0ane3TwUS7DtOF8nV
         9QJlK92mQxfXy1zpdd422CVQk/staQv8VJ+96ZENEy8keCi/5daF3c5D/L0LDy8ltO
         cv4KzWulDnaxZ2kpCFOPy4xGfMfHr9vS5QktGsFE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/6] dmaengine: stm32: mark of_device_id table as maybe unused
Date:   Fri, 20 Nov 2020 17:23:02 +0100
Message-Id: <20201120162303.482126-5-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120162303.482126-1-krzk@kernel.org>
References: <20201120162303.482126-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The driver uses a second of_device_id table in the probe()
function by passing it to of_match_node().  This code will be a no-op
for compile testing (!CONFIG_OF on x86_64):

    drivers/dma/stm32-dmamux.c:171:34: warning:
        ‘stm32_stm32dma_master_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/dma/stm32-dmamux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32-dmamux.c
index a10ccd964376..ef0d0555103d 100644
--- a/drivers/dma/stm32-dmamux.c
+++ b/drivers/dma/stm32-dmamux.c
@@ -168,7 +168,7 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 	return ERR_PTR(ret);
 }
 
-static const struct of_device_id stm32_stm32dma_master_match[] = {
+static const struct of_device_id stm32_stm32dma_master_match[] __maybe_unused = {
 	{ .compatible = "st,stm32-dma", },
 	{},
 };
-- 
2.25.1

