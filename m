Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7F048AFFB
	for <lists+dmaengine@lfdr.de>; Tue, 13 Aug 2019 08:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfHMGgT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Aug 2019 02:36:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38991 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfHMGgS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Aug 2019 02:36:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so16542235wra.6;
        Mon, 12 Aug 2019 23:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ie9Rb39uo73LLfEZw6hnNpJOlbAByYR2bYHJOHwVGT4=;
        b=PrDlhu4Tx7zsRCfOXZOsnL1TJFuXNGHrh16hPwLDqfX87N7eCnStElYnmqq6kUY317
         eZhawYFQNFhY361FIZVhqJGS4t3Tq5/YEZfG+hfxnwj8ZfRoN9gbRAzXUt1MrgCUl32N
         kLB8f0h2WUV9bSyf9G3ePleAFIJz2kPW9X7kaAsxbhECDmu/aRUcJJC4atpvu4WmWSDu
         yI0L56vcYp6SAoqRNGVFMpBQOfAgKR5Tc+EdPYqz8U4Dk0UgcIwH7W4ZsZcESKIXnWdV
         VszWgugrHuxLGqUGoWLHacz+ZcG+DMuuYkcHw96jkWy6k03+731g7kI+P8EZ+ur767Ny
         vm7A==
X-Gm-Message-State: APjAAAWlYfdk/JFMBHk9jihKRsBNyInrdZk5fuUQ6ZjcCaSxumHVSgKT
        vSvc0hH0kbLPe03eCAtyoCHYxQCr53w=
X-Google-Smtp-Source: APXvYqxYnRe7RYbzul5+gXRnf0USBcbQpm4WXxEuqRbLFKP2XLbynxueCIAILTHcZaFcUEXdg2ZGbQ==
X-Received: by 2002:adf:f507:: with SMTP id q7mr21370026wro.210.1565678176672;
        Mon, 12 Aug 2019 23:36:16 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id q20sm57578075wrc.79.2019.08.12.23.36.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 23:36:16 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-kernel@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, joe@perches.com,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: [RESEND PATCH] MAINTAINERS: dw axi dmac: Fix typo in a path
Date:   Tue, 13 Aug 2019 09:36:05 +0300
Message-Id: <20190813063605.23102-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190813060004.10594-1-efremov@linux.com>
References: <20190813060004.10594-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fix typo (s/dwi-/dw-/) in the directory path.

Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Fixes: 1fe20f1b8454 ("dmaengine: Introduce DW AXI DMAC driver")
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5ec418d8c386..eeeb4097d5bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15482,7 +15482,7 @@ F:	Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
 SYNOPSYS DESIGNWARE AXI DMAC DRIVER
 M:	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
 S:	Maintained
-F:	drivers/dma/dwi-axi-dmac/
+F:	drivers/dma/dw-axi-dmac/
 F:	Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
 
 SYNOPSYS DESIGNWARE DMAC DRIVER
-- 
2.21.0

