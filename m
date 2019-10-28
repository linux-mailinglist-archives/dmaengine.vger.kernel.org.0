Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92600E6DB8
	for <lists+dmaengine@lfdr.de>; Mon, 28 Oct 2019 09:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731303AbfJ1IAt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Oct 2019 04:00:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38253 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733125AbfJ1IAt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Oct 2019 04:00:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id c13so6368023pfp.5
        for <dmaengine@vger.kernel.org>; Mon, 28 Oct 2019 01:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Teb+nHfVj7QdEHZ6F94pdipxxAtosBBL8l+HZTtIm4A=;
        b=buaiJ3wCZ4lN8R+UyQC0KOVQoxUBt6E4y93SYARVuR1cEQmv/6DKg4GcFkpHRoxyuZ
         owizS5k3E6U2+4tNLCi2VzzTujDhbLZADv9SNpK6h5Mz6od8pwnNy7juEGYAPj9frn3F
         yMPdfWr/m297s++31zAjbgfMq5FEv0rtrzsAX4Y2BOTh+VgZTwFpHrM5maha5RYfJ28s
         i8vTW8T+L+PZ6mcbUUiC2fx9aHpoqrolWGKjjfqnrPFR5V91EuX3/bL3FfVDEPg26AcG
         iWZwa4z03A1Bx0nETUvG+uyojlpdadDnzPWailVA/qhmAwdUW2H8KxKlfpRvCsiEm6Iu
         D7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Teb+nHfVj7QdEHZ6F94pdipxxAtosBBL8l+HZTtIm4A=;
        b=MWPfZzB85WogXENdYm0yl9xXcWmtnoN/26OZo4jeHP5b3hfSUXl2oSC+rj95ujvzkL
         UlUPBScZy3m83yx8MoT2m8LL6yrxMTrJmvPHpknseOLRUIIJkQ77AKLd3uu5uVV7v1xW
         g6570KdDa1rxzZlE5ais1Q90SdNEzgFy9sglcMHVS0awBgl7FsPOrpnhnGuQtC3c3EMT
         0xNGnVc8ObTPO30cxYt1m1TGKTB5VkV6teWFIs5gDV8zfe1q75cfBm6Jik0if1qAJfei
         DrluMe8OFoAgXqHItfXfLYNfl56BpGbEVnzg347vRSTmaxPoMIbhhfxlXWAKJOlyxzm0
         Q4Aw==
X-Gm-Message-State: APjAAAWw2b24oT4E8K+tLBDt4+tckQJv0ZRmznLJ9O7xYRehfhl9Qpmf
        q0idAMExGIbivxS+3HRQyyjqfg==
X-Google-Smtp-Source: APXvYqw5o9OQqVfoQBgItzsJbWV2pBxZDfEZpu9OM5nA5X7iLkchHyEIoGZfQuSvRNFLCJ9raZ6acA==
X-Received: by 2002:a62:77c2:: with SMTP id s185mr3990854pfc.129.1572249648961;
        Mon, 28 Oct 2019 01:00:48 -0700 (PDT)
Received: from localhost.localdomain (111-241-170-106.dynamic-ip.hinet.net. [111.241.170.106])
        by smtp.gmail.com with ESMTPSA id y36sm9504752pgk.66.2019.10.28.01.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 01:00:48 -0700 (PDT)
From:   Green Wan <green.wan@sifive.com>
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
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Yash Shah <yash.shah@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/4] MAINTAINERS: Add Green as SiFive PDMA driver maintainer
Date:   Mon, 28 Oct 2019 15:56:23 +0800
Message-Id: <20191028075658.12143-5-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028075658.12143-1-green.wan@sifive.com>
References: <20191028075658.12143-1-green.wan@sifive.com>
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
index c6c34d04ce95..330fbd050059 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14782,6 +14782,12 @@ F:	drivers/media/usb/siano/
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

