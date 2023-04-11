Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E8B6DD065
	for <lists+dmaengine@lfdr.de>; Tue, 11 Apr 2023 05:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjDKDkL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Apr 2023 23:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjDKDjy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Apr 2023 23:39:54 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 986ED1BC9;
        Mon, 10 Apr 2023 20:39:52 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id BC545E0EB5;
        Tue, 11 Apr 2023 06:39:51 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=F0aH2rLYFF3yry3CDu2E1nuTkSLviDEruk4l21KZ7ec=; b=EO5tInePAkGU
        hD4YOkhu9BEzfsrtj1LOx433TlBVwIYuWGLJY2F6ZcZvcHO0EpJEhTPLqfWugPDL
        LbGO1bGOhU6HLf1C60ROJW2cFJD6gNzjz8kSKJQP8kslGKBYoVB60eD5K1gMPi8V
        4dfnOACYYAQ+bw+Y4KCJSJZ673YknGY=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 9E4B1E0E6A;
        Tue, 11 Apr 2023 06:39:51 +0300 (MSK)
Received: from localhost (10.8.30.38) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Tue, 11 Apr 2023 06:39:51 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v3 10/10] MAINTAINERS: Add myself as the DW eDMA driver reviewer
Date:   Tue, 11 Apr 2023 06:39:28 +0300
Message-ID: <20230411033928.30397-11-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230411033928.30397-1-Sergey.Semin@baikalelectronics.ru>
References: <20230411033928.30397-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.8.30.38]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The driver maintainer has been inactive for almost two years now. It
doesn't positively affect the new patches tests and reviews process. Since
the DW eDMA engine has been embedded into the PCIe controllers in several
our SoCs we will be interested in helping with the updates review.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 51adcafa0f0c..fb7bada6cdd0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5862,6 +5862,7 @@ F:	drivers/mtd/nand/raw/denali*
 
 DESIGNWARE EDMA CORE IP DRIVER
 M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+R:	Serge Semin <fancer.lancer@gmail.com>
 L:	dmaengine@vger.kernel.org
 S:	Maintained
 F:	drivers/dma/dw-edma/
-- 
2.40.0


