Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFD48AF0D
	for <lists+dmaengine@lfdr.de>; Tue, 13 Aug 2019 08:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbfHMGAY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Aug 2019 02:00:24 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34319 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfHMGAX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Aug 2019 02:00:23 -0400
Received: by mail-lj1-f194.google.com with SMTP id x18so3978420ljh.1;
        Mon, 12 Aug 2019 23:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ReHlvZFH1ZeXccZOj4ZMudkc0sB4myxec1s5FoIRfYM=;
        b=VMEm/ew89LeoITWhzPDFhZT8IVMh9dV6jacaz9bnY89lMDox3R/Zpncv8uGSalCc7M
         wk9L01A8AEzNduYTDT7YDct37dDK/kewM6TTOqXvMsHAwD9+1XGRYU+9zEDv30L0CxIX
         A4CzLzk9v3H8LXvZNARNKtF1O1wAXGNyxM3PFrRytIMBBOu2e080TqZs3DT4qP0DZmI2
         5Ws/px4vQJ7UMOw4ma2yHfPDf8Vf2zWmWOeHtWOaer3XHbCGXmrcXH/14jtLRGkcMEDi
         MP1WEEev8p2Qjrrslj2xOXiXQg3KgeYAdm00sHVNwt5w4hGD87m/vyyxkoYyXgbGEwpe
         e2fA==
X-Gm-Message-State: APjAAAVy19TnB+YNPJwDIUVh7E0V7GditFgY5S6DXdpzMViye9Z4cIW/
        n7s1YKpqSEHj4Ce7GLlJi0u2niI7vVw=
X-Google-Smtp-Source: APXvYqxcANLDQtTMky+XNKIvXW+Sb2r8gyW8lRSRn8ZT7Kn6Rt2ogKF8m/ewTwP/hDCDhCHPXE3AEQ==
X-Received: by 2002:a2e:b0cf:: with SMTP id g15mr4633433ljl.237.1565676021561;
        Mon, 12 Aug 2019 23:00:21 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id o5sm1427951lji.43.2019.08.12.23.00.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 23:00:21 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-kernel@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, joe@perches.com,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org
Subject: [PATCH] MAINTAINERS: dw axi dmac: Fix typo in a path
Date:   Tue, 13 Aug 2019 09:00:04 +0300
Message-Id: <20190813060004.10594-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325212809.27891-1-joe@perches.com>
References: <20190325212809.27891-1-joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fix typo (s/dwi-/dw-/) in the directory path.

Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: dmaengine@vger.kernel.org
Fixes: 1fe20f1b8454 ("dmaengine: Introduce DW AXI DMAC driver")
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bf5f0467988c..9b4717ea2cfe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15495,7 +15495,7 @@ F:	Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
 SYNOPSYS DESIGNWARE AXI DMAC DRIVER
 M:	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
 S:	Maintained
-F:	drivers/dma/dwi-axi-dmac/
+F:	drivers/dma/dw-axi-dmac/
 F:	Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
 
 SYNOPSYS DESIGNWARE DMAC DRIVER
-- 
2.21.0

