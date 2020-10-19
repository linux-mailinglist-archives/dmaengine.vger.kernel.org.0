Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24588292AF8
	for <lists+dmaengine@lfdr.de>; Mon, 19 Oct 2020 18:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbgJSQAE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Oct 2020 12:00:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730496AbgJSQAE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 19 Oct 2020 12:00:04 -0400
Received: from localhost.localdomain (unknown [194.230.155.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F6BD222C2;
        Mon, 19 Oct 2020 16:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603123203;
        bh=YbT4xVqbiqIk3+wEZ89dSG3aONU5hUzF61bG7fyN8VU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nm1l8fbpvyqmiSmCl9ZvOV5SwxGHflWu7G5+/5W72WOm9qmKGhaZUxK7e4ev/KHe0
         JleqRGEmmqbNcrxu5CzksWlfhlx5200TJ6qwvMhYgaL3e7t6hSfkWIN3OgNUd72H8T
         lY45gPgfPIj2+9gdcboVCqb0c/7XAz3kMGx4WNw0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/2] dmaengine: ppc4xx: remove xor_hw_desc assignment without reading
Date:   Mon, 19 Oct 2020 17:57:56 +0200
Message-Id: <20201019155756.21445-2-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201019155756.21445-1-krzk@kernel.org>
References: <20201019155756.21445-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The xor_hw_desc local variable is assigned but never read:

    drivers/dma/ppc4xx/adma.c: In function ‘ppc440spe_desc_set_src_mult’:
    drivers/dma/ppc4xx/adma.c:562:17: warning: variable ‘xor_hw_desc’ set but not used [-Wunused-but-set-variable]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/dma/ppc4xx/adma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index fea598550582..df7704053d91 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -559,7 +559,6 @@ static void ppc440spe_desc_set_src_mult(struct ppc440spe_adma_desc_slot *desc,
 			int sg_index, unsigned char mult_value)
 {
 	struct dma_cdb *dma_hw_desc;
-	struct xor_cb *xor_hw_desc;
 	u32 *psgu;
 
 	switch (chan->device->id) {
@@ -590,7 +589,6 @@ static void ppc440spe_desc_set_src_mult(struct ppc440spe_adma_desc_slot *desc,
 		*psgu |= cpu_to_le32(mult_value << mult_index);
 		break;
 	case PPC440SPE_XOR_ID:
-		xor_hw_desc = desc->hw_desc;
 		break;
 	default:
 		BUG();
-- 
2.25.1

