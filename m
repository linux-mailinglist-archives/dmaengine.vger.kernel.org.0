Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3CF292AF6
	for <lists+dmaengine@lfdr.de>; Mon, 19 Oct 2020 18:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbgJSQAA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Oct 2020 12:00:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730475AbgJSQAA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 19 Oct 2020 12:00:00 -0400
Received: from localhost.localdomain (unknown [194.230.155.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0564922283;
        Mon, 19 Oct 2020 15:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603123200;
        bh=74gScxROzXVRQQgGZLhzzit9KPSYZrzEyqfBjkTFQ1s=;
        h=From:To:Cc:Subject:Date:From;
        b=0DsTqLN/LzHqTFqRVlwIRJMEizvXtH/vexrm0vxIAozaHcthOty9ebaedleZ9Rngr
         zQMidbyYzkDOkhBas77QzvBsVk2fZpwQuZVjIj5hkUbJO4e8Fp6zmMJZAO49T8ISyo
         b9PHWyZv7K7wuWADg2ehBThajuRqzdT0qJZvSnN8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] dmaengine: ppc4xx: make ppc440spe_adma_chan_list static
Date:   Mon, 19 Oct 2020 17:57:55 +0200
Message-Id: <20201019155756.21445-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The ppc440spe_adma_chan_list file-scope variable is not used outside of
the unit so it can be made static.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/dma/ppc4xx/adma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index 71cdaaa8134c..fea598550582 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -69,7 +69,7 @@ struct ppc_dma_chan_ref {
 };
 
 /* The list of channels exported by ppc440spe ADMA */
-struct list_head
+static struct list_head
 ppc440spe_adma_chan_list = LIST_HEAD_INIT(ppc440spe_adma_chan_list);
 
 /* This flag is set when want to refetch the xor chain in the interrupt
-- 
2.25.1

