Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4AF6F29E0
	for <lists+dmaengine@lfdr.de>; Thu,  7 Nov 2019 09:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733241AbfKGIyv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Nov 2019 03:54:51 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32862 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfKGIyu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Nov 2019 03:54:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id c184so2169916pfb.0
        for <dmaengine@vger.kernel.org>; Thu, 07 Nov 2019 00:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=REr9FfqxVfrOvMfCnBHOUFhY/pw9eZJd+cJfs5nnvmk=;
        b=Ub5AuL2yBlrx2kEGok4LLkMsGs9Tg85TheBaiJPVAl5Zup7IALWGjeBGQNQxT66fGQ
         /+Kx4qiwPKcqzjoOsuuQL20s7hdAkUp1V5GqLlC4CyA4Oh5Qh1iF6hi4f+GocdYoQJOI
         TEVLqzJZE1uOsHzBekKouNqI77hN5vukb/5zyXZIj5F54WAxVrtm9Xh3GUaULvUhz4+v
         Cn4dummdKET9/QWP9fYXYzcRNChTj9x7K4V/zV1j2BojghVhhhmEVvq3FgdM+YbDMPip
         d8lOL0vcQmJYZ5r8tUheQJ+w2J6FE+u4Xwizyk9fU7IUU2M56Ynbz+vgU6uagWRKDDwL
         SkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=REr9FfqxVfrOvMfCnBHOUFhY/pw9eZJd+cJfs5nnvmk=;
        b=cGbBThxxADd779zGq77Gc4EcGrUab5zq7+LP+XvvSKGzC0AWsimMNw9K/K3TLlXWBY
         wKhHtRY9385GWIQplvRfNytNabR8AlU6KE2jyN5ouQ2VThTkY4CQkosphqpYjU66QPYt
         msqZ+nxWhULJ2rWysrCpp7SjUFxeTs5Cp2co2ssh/p/X3Pta9NbN9DAr5G2Ci3pYkhAK
         9QhUVlK1Ey+rByHD739Sl3LmKGHvXkQEb9QgMsmXCqMIVRjXNGKk5qhVAlpefPGp3End
         qjEOqruuLuclcE6Jnq6BDuDKuLfEPlmvIuaSBRwEtq8abe349i37SE1zmNxkbIAyQ81H
         /5ow==
X-Gm-Message-State: APjAAAVzB29PxeIMBKNxs6TlRP1QtYmDHzv+ypAWtkCmJ9i5n7tG6Fs4
        Vj9vNDitrkpxM1REUX0GMPamtw==
X-Google-Smtp-Source: APXvYqwDFuK/xyGSDVKNWtwLPNsCCdPj7+umcyIkizF5k0puUXO125ZdEGWjnl7vA9pTpceKyeB6Bg==
X-Received: by 2002:a63:91c1:: with SMTP id l184mr3073440pge.57.1573116888516;
        Thu, 07 Nov 2019 00:54:48 -0800 (PST)
Received: from localhost.localdomain (36-228-119-18.dynamic-ip.hinet.net. [36.228.119.18])
        by smtp.gmail.com with ESMTPSA id a33sm2402361pgb.57.2019.11.07.00.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 00:54:48 -0800 (PST)
From:   Green Wan <green.wan@sifive.com>
Cc:     Green Wan <green.wan@sifive.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Yash Shah <yash.shah@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/4] MAINTAINERS: Add Green as SiFive PDMA driver maintainer
Date:   Thu,  7 Nov 2019 16:49:22 +0800
Message-Id: <20191107084955.7580-5-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107084955.7580-1-green.wan@sifive.com>
References: <20191107084955.7580-1-green.wan@sifive.com>
To:     unlisted-recipients:; (no To-header on input)
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
index 2a427d1e9f01..d319f7f33407 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14785,6 +14785,12 @@ F:	drivers/media/usb/siano/
 F:	drivers/media/usb/siano/
 F:	drivers/media/mmc/siano/
 
+SIFIVE PDMA DRIVER
+M:	Green Wan <green.wan@sifive.com>
+S:	Maintained
+F:	drivers/dma/sf-pdma/
+F:	Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
+
 SIFIVE DRIVERS
 M:	Palmer Dabbelt <palmer@dabbelt.com>
 M:	Paul Walmsley <paul.walmsley@sifive.com>
-- 
2.17.1

