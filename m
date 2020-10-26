Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7086B2991AD
	for <lists+dmaengine@lfdr.de>; Mon, 26 Oct 2020 17:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784678AbgJZQCK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Oct 2020 12:02:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1773879AbgJZQBa (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 26 Oct 2020 12:01:30 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DA9320706;
        Mon, 26 Oct 2020 16:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603728089;
        bh=hxlUO93iSjn7XTJn8G5zlplf5TFU5wC+vKL/JdLpdZg=;
        h=From:To:Cc:Subject:Date:From;
        b=QLYhQreuUHpvopmb0mcrEkGGLQ/WrGUmEBVyHVGkdBSH6N0QSvomVc41jGf7bgU2f
         UzfajfszhEm/uMC5WNHdyzgQQBfodG4c2glo6HZyREDOLqphwMuqRUE/CzfSbdOV3V
         TAGcMhdf7bVSqBvpaBk55+J0POu6c7hDOrQhYv5o=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Yu Kuai <yukuai3@huawei.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: ti: k3-udma: fix -Wenum-conversion warning
Date:   Mon, 26 Oct 2020 17:01:15 +0100
Message-Id: <20201026160123.3704531-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc warns about a mismatch argument type when passing
'false' into a function that expects an enum:

drivers/dma/ti/k3-udma-private.c: In function 'xudma_tchan_get':
drivers/dma/ti/k3-udma-private.c:86:34: warning: implicit conversion from 'enum <anonymous>' to 'enum udma_tp_level' [-Wenum-conversion]
  86 |  return __udma_reserve_##res(ud, false, id);   \
     |                                  ^~~~~
drivers/dma/ti/k3-udma-private.c:95:1: note: in expansion of macro 'XUDMA_GET_PUT_RESOURCE'
   95 | XUDMA_GET_PUT_RESOURCE(tchan);
      | ^~~~~~~~~~~~~~~~~~~~~~

In this case, false has the same numerical value as
UDMA_TP_NORMAL, so passing that is most likely the correct
way to avoid the warning without changing the behavior.

Fixes: d70241913413 ("dmaengine: ti: k3-udma: Add glue layer for non DMAengine users")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/ti/k3-udma-private.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ti/k3-udma-private.c b/drivers/dma/ti/k3-udma-private.c
index aa24e554f7b4..8563a392f30b 100644
--- a/drivers/dma/ti/k3-udma-private.c
+++ b/drivers/dma/ti/k3-udma-private.c
@@ -83,7 +83,7 @@ EXPORT_SYMBOL(xudma_rflow_is_gp);
 #define XUDMA_GET_PUT_RESOURCE(res)					\
 struct udma_##res *xudma_##res##_get(struct udma_dev *ud, int id)	\
 {									\
-	return __udma_reserve_##res(ud, false, id);			\
+	return __udma_reserve_##res(ud, UDMA_TP_NORMAL, id);		\
 }									\
 EXPORT_SYMBOL(xudma_##res##_get);					\
 									\
-- 
2.27.0

