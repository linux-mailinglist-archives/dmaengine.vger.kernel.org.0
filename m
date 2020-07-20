Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2B4225D8D
	for <lists+dmaengine@lfdr.de>; Mon, 20 Jul 2020 13:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgGTLkC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Jul 2020 07:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbgGTLkC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Jul 2020 07:40:02 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E651FC061794;
        Mon, 20 Jul 2020 04:40:01 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x72so8928963pfc.6;
        Mon, 20 Jul 2020 04:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ydUkxccpldgiDYqKvhXSUOUhAioZWR9Lw+8lusKjv0=;
        b=BgFDZByinpOxZ38qajfri4IVASZaQbqNn3xQlgqO5+WLJKENmfGAJScC1n2EgkPMY8
         xa8MsYYh+lFA/8zNAh94CGvxNm3l6YHIbhPY3nQBy/k+BlYvMDctWeXPo//vzivmr5Ni
         5DXWg5LcTlbzGykAIDew2X0P5rmqiVjMsvT0Bs6XBiujPXaKE5aBmP+pDU4iCf7x3HrK
         Q1LikTjRMygbayjDDoRqUQq4glc0fC2VEV3CwFDhhMwpSexqhxuWZx09mgi5a05L4B82
         EVtd6NQZS0BA+Edr5RJdfGdR0/Tg4KPnjgYaar0LBWTYAA1+x8rDNd8wS5MxjzpdQwxi
         Vgkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ydUkxccpldgiDYqKvhXSUOUhAioZWR9Lw+8lusKjv0=;
        b=ArGSh1aI/YqF+L7CIKE8WPPKD4dgVHgA9575TdwGoQmCuaagAwbRc0R1ioNoGBm5Qv
         mzY0BYmdxym96yjXWqWq7ueOB5tcmCBGyh+wvVDPxbWOUAHAgYLqA9sYD0Ng1c80z9Vl
         GC0I00WiG/B4n+q+l4IRxXehYi5qKOnMD8UKeRMiNWjsw8CnRP/3RqmGhvNwe1grIJkD
         PeW1EOsQqI47+Ul1oH/0YLOqRjCdqcY0SzKmf4j5cbfU35JQxgwu3uUU+FYCzGwhQKwv
         c/sUXY+S7b8YuYU7rkqH5tovGDvPsnHfixbv/8DrLcb69fzgb0RXPYmsOnuXu85LuOmC
         9gtg==
X-Gm-Message-State: AOAM532X/uoG0iAUtQNPX9doEOn7uh6M/1nHbEWniPw3Rv5Wyr9kESKL
        IvRsoJhNW8NsSOwxvtDF7Ck=
X-Google-Smtp-Source: ABdhPJzn4/Nkjxymf/WNDQhYvjrNU7KoFMAW3Hpf2OEMoq7mFr4jtW2Lu4qzp5HEX54aNZfjTp1pzQ==
X-Received: by 2002:a63:b74f:: with SMTP id w15mr7259245pgt.314.1595245201447;
        Mon, 20 Jul 2020 04:40:01 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id 83sm16680114pfu.60.2020.07.20.04.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 04:40:00 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dmaengine@vger.kernel.org
Subject: [PATCH v1] dmaengine: pch_dma: use generic power management
Date:   Mon, 20 Jul 2020 17:07:41 +0530
Message-Id: <20200720113740.353479-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Drivers using legacy PM have to manage PCI states and device's PM states
themselves. They also need to take care of configuration registers.

With improved and powerful support of generic PM, PCI Core takes care of
above mentioned, device-independent, jobs.

This driver makes use of PCI helper functions like
pci_save/restore_state(), pci_enable/disable_device(),
and pci_set_power_state() to do required operations. In generic mode, they
are no longer needed.

Change function parameter in both .suspend() and .resume() to
"struct device*" type. Use dev_get_drvdata() to get drv data.

Compile-tested only.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/dma/pch_dma.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
index a3b0b4c56a19..e93005837e3f 100644
--- a/drivers/dma/pch_dma.c
+++ b/drivers/dma/pch_dma.c
@@ -735,8 +735,7 @@ static irqreturn_t pd_irq(int irq, void *devid)
 	return ret0 | ret2;
 }
 
-#ifdef	CONFIG_PM
-static void pch_dma_save_regs(struct pch_dma *pd)
+static void __maybe_unused pch_dma_save_regs(struct pch_dma *pd)
 {
 	struct pch_dma_chan *pd_chan;
 	struct dma_chan *chan, *_c;
@@ -759,7 +758,7 @@ static void pch_dma_save_regs(struct pch_dma *pd)
 	}
 }
 
-static void pch_dma_restore_regs(struct pch_dma *pd)
+static void __maybe_unused pch_dma_restore_regs(struct pch_dma *pd)
 {
 	struct pch_dma_chan *pd_chan;
 	struct dma_chan *chan, *_c;
@@ -782,40 +781,25 @@ static void pch_dma_restore_regs(struct pch_dma *pd)
 	}
 }
 
-static int pch_dma_suspend(struct pci_dev *pdev, pm_message_t state)
+static int __maybe_unused pch_dma_suspend(struct device *dev)
 {
-	struct pch_dma *pd = pci_get_drvdata(pdev);
+	struct pch_dma *pd = dev_get_drvdata(dev);
 
 	if (pd)
 		pch_dma_save_regs(pd);
 
-	pci_save_state(pdev);
-	pci_disable_device(pdev);
-	pci_set_power_state(pdev, pci_choose_state(pdev, state));
-
 	return 0;
 }
 
-static int pch_dma_resume(struct pci_dev *pdev)
+static int __maybe_unused pch_dma_resume(struct device *dev)
 {
-	struct pch_dma *pd = pci_get_drvdata(pdev);
-	int err;
-
-	pci_set_power_state(pdev, PCI_D0);
-	pci_restore_state(pdev);
-
-	err = pci_enable_device(pdev);
-	if (err) {
-		dev_dbg(&pdev->dev, "failed to enable device\n");
-		return err;
-	}
+	struct pch_dma *pd = dev_get_drvdata(dev);
 
 	if (pd)
 		pch_dma_restore_regs(pd);
 
 	return 0;
 }
-#endif
 
 static int pch_dma_probe(struct pci_dev *pdev,
 				   const struct pci_device_id *id)
@@ -993,15 +977,14 @@ static const struct pci_device_id pch_dma_id_table[] = {
 	{ 0, },
 };
 
+static SIMPLE_DEV_PM_OPS(pch_dma_pm_ops, pch_dma_suspend, pch_dma_resume);
+
 static struct pci_driver pch_dma_driver = {
 	.name		= DRV_NAME,
 	.id_table	= pch_dma_id_table,
 	.probe		= pch_dma_probe,
 	.remove		= pch_dma_remove,
-#ifdef CONFIG_PM
-	.suspend	= pch_dma_suspend,
-	.resume		= pch_dma_resume,
-#endif
+	.driver.pm	= &pch_dma_pm_ops,
 };
 
 module_pci_driver(pch_dma_driver);
-- 
2.27.0

