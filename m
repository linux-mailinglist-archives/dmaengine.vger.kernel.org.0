Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11D12C9A91
	for <lists+dmaengine@lfdr.de>; Thu,  3 Oct 2019 11:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbfJCJOp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Oct 2019 05:14:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38313 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729087AbfJCJOo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Oct 2019 05:14:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id x10so1379207pgi.5
        for <dmaengine@vger.kernel.org>; Thu, 03 Oct 2019 02:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2vKbldndzFc1Ual386BQ7E3WFEYeo8xZQGDApFlT8dI=;
        b=f2YDZuhud4dK2X9PKXRDWQgtsC8YmWa/pMHZn7PGBMkvcvIh5c0kaqJBzSrD6W48++
         ulqgy+niqIsVPTGUN1HMRou0c9gxKQMNxJ7BOTESuppvEH+io35C1L5HXrYtHBcZ7nBz
         aMSmQ34saNLtImo5kikISUDY6J0KXI3u84MOhaACp/b95sW6JHlwgzMzP0Lbz8XL+Rn0
         +LskHMYAeCDMFrOZ+ajkUmy2KTW3ylMORBzrrvdE9xLD2Dnl+xLrFoR+tZPGkLBg4AVv
         reKHZVmG9MkgZ56l47Sc01EHOPKqPZYyE7gVpwM8GNfmTKyFwpvxj2hiAp+nOQnsdmee
         /5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2vKbldndzFc1Ual386BQ7E3WFEYeo8xZQGDApFlT8dI=;
        b=IEpGMNLnjsg6VQGOpmyJFaqL115nsSVefe06haaxB7JaPp77e24r1893+Uggc9J+B1
         kpTW//UdtI1PwNeDuHzJE599RGsZGoX3feHP31OZ+gCg1rAijLdBK2pUsdb6Dtnl1GLB
         Eh9mvHu19mbjRpvnayzKFV7Ve7/Piagt/fn21qQwMljSgZKW6SNuBc4syu+eOUPJ2o3M
         UDpAMFDGxYxMiqp58Hdf0oWtAU2d5UwcJphIdiXDJZp0TPawger3AMHzoTYAxWrxwTPF
         Vdhdj6ypxw6WdsDZT+cJoKAdIrMrmJxRaKq8ljlURRvfeJLR46t5iuBhtI+UhByUExdK
         Btsw==
X-Gm-Message-State: APjAAAUIUFTk5GBPN64SR1ZqeQ6+/gmhc9ftOKl5kb1u3ie2ek/8nr+h
        Z9czefwTO/3Z9aeBZ6X3au4zJg==
X-Google-Smtp-Source: APXvYqzcQ1k2avDmG3DyS4ozTUbUn772X9S8sGX+mjjQG1JqrLKlw/f6wAjumUBurg6Y5zOWSte2uA==
X-Received: by 2002:a65:56c8:: with SMTP id w8mr8535370pgs.100.1570094082866;
        Thu, 03 Oct 2019 02:14:42 -0700 (PDT)
Received: from localhost.localdomain (111-241-164-136.dynamic-ip.hinet.net. [111.241.164.136])
        by smtp.gmail.com with ESMTPSA id f128sm3445422pfg.143.2019.10.03.02.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 02:14:42 -0700 (PDT)
From:   Green Wan <green.wan@sifive.com>
To:     linux-hackers@sifive.com
Cc:     Green Wan <green.wan@sifive.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Yash Shah <yash.shah@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] MAINTAINERS: Add Green as SiFive PDMA driver maintainer
Date:   Thu,  3 Oct 2019 17:09:04 +0800
Message-Id: <20191003090945.29210-5-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191003090945.29210-1-green.wan@sifive.com>
References: <20191003090945.29210-1-green.wan@sifive.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Update MAINTAINERS for SiFive PDMA driver.

Signed-off-by: Green Wan <green.wan@sifive.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 30a5b4028d2f..6c12da0a324d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14779,6 +14779,12 @@ F:	drivers/media/usb/siano/
 F:	drivers/media/usb/siano/
 F:	drivers/media/mmc/siano/
 
+SIFIVE PDMA DRIVER
+M:	Green Wan <green.wan@sifive.com>
+S:	Maintained
+F:	drivers/dma/sf-pdma/
+F:	Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
+
 SIFIVE DRIVERS
 M:	Palmer Dabbelt <palmer@sifive.com>
 M:	Paul Walmsley <paul.walmsley@sifive.com>
-- 
2.17.1

