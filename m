Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8B286FFFA
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jul 2019 14:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfGVMp1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jul 2019 08:45:27 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:57701 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbfGVMp1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Jul 2019 08:45:27 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MTRAS-1hzSlf0CgG-00TlMc; Mon, 22 Jul 2019 14:45:03 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Joao Pinto <jpinto@synopsys.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] [v2] dmaengine: dw-edma: fix unnecessary stack usage
Date:   Mon, 22 Jul 2019 14:44:43 +0200
Message-Id: <20190722124457.1093886-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YYatoRsXSnmJhuS9zQ32arIsHlbbR5TwQvO540Kwug1HsFi8yk3
 Kt52+hk3Bnc9QwDzzrM0zJ2Xf/TbeFMIaneIxkPz1aAJNiOIPNd0eRa0sxEPiP+XHO5kRHg
 m8DfUJ22fnSE1lSn5KnTavkhtkdXhIOdFPxc4FvDgo5p2/U3ynruupU01STAhoEKwvjkUu/
 aOLbyfKc9JHFrOoAtahUA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xf7VlFbttRk=:P5pqY5XIS0AguTxoatrB85
 6/Dv4kEp/zrxSBGkDC/zCEYr6cIX110dt4M/PUeWZQy6+FeTT3x/AKFEgKWyp6ndpQnCzhNuP
 H9rf8Y684jHk5sEhgtAM3DZ/lMd2BpCPoLw9D/P/d1XWAt+iQCWxHjLUYSQgsjNaPeN7Tyaw7
 5mb4qSCU8e40YszKrlxxiD3ntWflUj1Cv+q8FU7W1AXhoaQ4AxuhvbbPYO44PO937PFKbuidR
 1F47QvQqCAhn83EXGcQGa5EmYyu31pWbtI5+wPH7aoGA6nbbpJvQzyrm5+WO1r4jouJ7MoNSa
 JoPxppQZBmP7+wFPNWdoRPvpvsz6YfjZknEUaTlbQDY9bLPuWwvTvYmvHYWaBH9UnBXpjo2b0
 RwTkRRr4nrgC7ZuGYlxTdmuRpJUG10ErU2Mwnw06qLB6BzlcAZeP18UlQ8dtUOlbdvdY9fCKr
 T7deGhGJ31Mb4iwx7B7qGBndvbvdZW7LIgsIbceYp4YYDXl/F7ACL3ONniD0ASWpBjP9DHdYR
 7pzQ2OOApGUu5xI7UmPJFvE6tKa1cN92IR+zfeEKRlLY9ddFhsk0H3GKh8ZKhIeb+49SdXlTL
 /Bm0/yZZd/L7RzNYSdZCkqXnyDJJwuDql8xgR7FS2SR10muMoOOtZaHw3H8fZwzDiGxES2pu8
 4jRqEK0Hu59ASnTVESHRmh8AuMkMBaIRx/78qfwl6eoAsS4OvpxZnUggXLKs4tuwriLAWd3TA
 oKZK5SY4Gecik5cjHfrU01E2q/zWqheZqoOVug==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Putting large constant data on the stack causes unnecessary overhead
and stack usage:

drivers/dma/dw-edma/dw-edma-v0-debugfs.c:285:6: error: stack frame size of 1376 bytes in function 'dw_edma_v0_debugfs_on' [-Werror,-Wframe-larger-than=]

Mark the variable 'static const' in order for the compiler to move it
into the .rodata section where it does no such harm.

Fixes: 305aebeff879 ("dmaengine: Add Synopsys eDMA IP version 0 debugfs support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: unchanged
---
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index 3226f528cc11..5728b6fe938c 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -48,7 +48,7 @@ static struct {
 } lim[2][EDMA_V0_MAX_NR_CH];
 
 struct debugfs_entries {
-	char					name[24];
+	const char				*name;
 	dma_addr_t				*reg;
 };
 
-- 
2.20.0

