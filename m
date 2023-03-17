Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632046BE81C
	for <lists+dmaengine@lfdr.de>; Fri, 17 Mar 2023 12:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjCQLcz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Mar 2023 07:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjCQLcv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Mar 2023 07:32:51 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBB250989
        for <dmaengine@vger.kernel.org>; Fri, 17 Mar 2023 04:32:49 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so8778112pjt.2
        for <dmaengine@vger.kernel.org>; Fri, 17 Mar 2023 04:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1679052769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bus/9rIf8WxfzN8ER9bYpWlzeg5Ck6oeY/WJO+0UvIw=;
        b=wjLLMPk3hLo+Z7RximKbN65/Qady7mVgH6NFCzRlaAFKfTTMXOleyIvUVgDUKtNTHW
         XkBRWU7Yv9qFYCjmMhymhPnGqU1Gnxb5CiMDgbMrJvjlzuGrIPrvsvwR5cxtlJugLZGV
         co+zUqq+4zivVXMhJQ2eAFvwU4LHD885bXe52uZW8+19bCkFrebHPaAmhHxnPmSw5ORZ
         bL3ahR5FRhuZLlebHQMI3fMZLylXZL56GdcJq+T1u6lLJNPggZr8uyQK9tYtqblglhnr
         ZtxRU4ZWLbCj+mVhFVJasDUeXkNzesGWDZYsWOnVXjG2T9Z0Fvu9UVtr0ESVenGwOKqz
         5eTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679052769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bus/9rIf8WxfzN8ER9bYpWlzeg5Ck6oeY/WJO+0UvIw=;
        b=J4aOfIlSpilxIxFOlnf9tNQ4pbUKJHjs9PgbZdCBbNj5bvd0q0NbUHXo+QRlXC5lzg
         2sV8KcmtZZ1bN2mQqIn3PHdTWGJ4ukHe3h1ZzmgIZcodDNpPa3JBVSSCIb8cAEx9itqM
         NniRfJU3ihU7g1Qus1LFon72lmOTVVpkKCPEW2C6SsK494xUMlafOI9/gjTfps1yqmHC
         C3UEvAK44WY50xV/MDpAm03Cj84cn1B0qwzoZbzKRDWAxjl2CX6WDNU6bUtyBb1hDwdq
         LQvEvdAKI5acxSWuQGCIEtOU0Dnv1hFQ3R2Q+ejv4zRyC8B7vdYT+seT9rx1rqb9hmYe
         JiRQ==
X-Gm-Message-State: AO0yUKWCQ8Bvn6V5i7lejIk5rS2PoQ47VjSi7fMhVYmVj2ke7u/yzb7g
        5Kys9xFXtlP98tftGwGpfTdBEA==
X-Google-Smtp-Source: AK7set9ZWKEJMSeTL9s9Yx06FwGSd6i3KWMaGnzaDbwh0J+zPH2o47HFBT8jsfkU9nOpQ6sNvFqkcA==
X-Received: by 2002:a17:902:d10c:b0:19c:a9bc:ce57 with SMTP id w12-20020a170902d10c00b0019ca9bcce57mr5454248plw.64.1679052768772;
        Fri, 17 Mar 2023 04:32:48 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id e3-20020a17090a818300b00233aacab89esm1182904pjn.48.2023.03.17.04.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 04:32:48 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shunsuke Mie <mie@igel.co.jp>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [RFC PATCH 01/11] misc: pci_endpoint_test: Aggregate irq_type checking
Date:   Fri, 17 Mar 2023 20:32:28 +0900
Message-Id: <20230317113238.142970-2-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230317113238.142970-1-mie@igel.co.jp>
References: <20230317113238.142970-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There are the same checkings in each test, so merge the redundant checks.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 drivers/misc/pci_endpoint_test.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 1d8f72b42c0a..22e0cc0b75d3 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -347,6 +347,11 @@ static int pci_endpoint_test_validate_xfer_params(struct device *dev,
 		return -EINVAL;
 	}
 
+	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
+		dev_dbg(dev, "Invalid IRQ type option\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -391,11 +396,6 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 	if (use_dma)
 		flags |= FLAG_USE_DMA;
 
-	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
-		dev_err(dev, "Invalid IRQ type option\n");
-		goto err;
-	}
-
 	orig_src_addr = kzalloc(size + alignment, GFP_KERNEL);
 	if (!orig_src_addr) {
 		dev_err(dev, "Failed to allocate source buffer\n");
@@ -527,11 +527,6 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test,
 	if (use_dma)
 		flags |= FLAG_USE_DMA;
 
-	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
-		dev_err(dev, "Invalid IRQ type option\n");
-		goto err;
-	}
-
 	orig_addr = kzalloc(size + alignment, GFP_KERNEL);
 	if (!orig_addr) {
 		dev_err(dev, "Failed to allocate address\n");
@@ -627,11 +622,6 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
 	if (use_dma)
 		flags |= FLAG_USE_DMA;
 
-	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
-		dev_err(dev, "Invalid IRQ type option\n");
-		goto err;
-	}
-
 	orig_addr = kzalloc(size + alignment, GFP_KERNEL);
 	if (!orig_addr) {
 		dev_err(dev, "Failed to allocate destination address\n");
-- 
2.25.1

