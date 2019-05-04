Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9FA413889
	for <lists+dmaengine@lfdr.de>; Sat,  4 May 2019 11:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfEDJwu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 4 May 2019 05:52:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbfEDJwt (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 4 May 2019 05:52:49 -0400
Received: from localhost.localdomain (unknown [194.230.155.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DAAB206DF;
        Sat,  4 May 2019 09:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556963568;
        bh=yyaQ8JmLbaIGxXWU0tbqV9JpPSBeLwoAskWn0Lg7RkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sP17J3sGzMKPn/79A2HbxCAJeSn30we8Blg4uVPmezrZI0XxrUd2xEihPxUbtIAE9
         JYOKHtf1imUcnR8ETRjVAEGjBI+ZrY39vQHTmEpYN7L9LsXk45GdnKzrjGFtVA++4d
         bUx66cZ/mJF35vM8Az74xFWmhXEFNU+OfH/LPEqs=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     Jules Maselbas <jmaselbas@kalray.eu>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH] usb: dwc2: gadget: Replace phyif with phy_utmi_width
Date:   Sat,  4 May 2019 11:52:24 +0200
Message-Id: <20190504095225.23883-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504095225.23883-1-krzk@kernel.org>
References: <20190504095225.23883-1-krzk@kernel.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Jules Maselbas <jmaselbas@kalray.eu>

The phy utmi width information is already set in hsotg params,
phyif is only used in few places and I don't see any reason to
not use hsotg's params.

Moreover the utmi width was being forced to 16 bits by platform
initialization which doesn't take in account HW configuration.

Acked-by: Minas Harutyunyan <hminas@synopsys.com>
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
---
 drivers/usb/dwc2/core.h     |  2 --
 drivers/usb/dwc2/gadget.c   | 20 ++++++++++++++------
 drivers/usb/dwc2/platform.c |  5 +----
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 764c78ebee28..8e3edf10d76d 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -871,7 +871,6 @@ struct dwc2_hregs_backup {
  *                      removed once all SoCs support usb transceiver.
  * @supplies:           Definition of USB power supplies
  * @vbus_supply:        Regulator supplying vbus.
- * @phyif:              PHY interface width
  * @lock:		Spinlock that protects all the driver data structures
  * @priv:		Stores a pointer to the struct usb_hcd
  * @queuing_high_bandwidth: True if multiple packets of a high-bandwidth
@@ -1056,7 +1055,6 @@ struct dwc2_hsotg {
 	struct dwc2_hsotg_plat *plat;
 	struct regulator_bulk_data supplies[DWC2_NUM_SUPPLIES];
 	struct regulator *vbus_supply;
-	u32 phyif;
 
 	spinlock_t lock;
 	void *priv;
diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 9b737c4e8f50..614f8c34d759 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -3314,20 +3314,28 @@ void dwc2_hsotg_core_init_disconnected(struct dwc2_hsotg *hsotg,
 
 	/* keep other bits untouched (so e.g. forced modes are not lost) */
 	usbcfg = dwc2_readl(hsotg, GUSBCFG);
+	/* remove the HNP/SRP */
 	usbcfg &= ~(GUSBCFG_TOUTCAL_MASK | GUSBCFG_PHYIF16 | GUSBCFG_SRPCAP |
-		GUSBCFG_HNPCAP | GUSBCFG_USBTRDTIM_MASK);
+		GUSBCFG_HNPCAP);
+	usbcfg |= GUSBCFG_TOUTCAL(7);
 
 	if (hsotg->params.phy_type == DWC2_PHY_TYPE_PARAM_FS &&
 	    (hsotg->params.speed == DWC2_SPEED_PARAM_FULL ||
 	     hsotg->params.speed == DWC2_SPEED_PARAM_LOW)) {
 		/* FS/LS Dedicated Transceiver Interface */
 		usbcfg |= GUSBCFG_PHYSEL;
-	} else {
-		/* set the PLL on, remove the HNP/SRP and set the PHY */
-		val = (hsotg->phyif == GUSBCFG_PHYIF8) ? 9 : 5;
-		usbcfg |= hsotg->phyif | GUSBCFG_TOUTCAL(7) |
-			(val << GUSBCFG_USBTRDTIM_SHIFT);
+	} else if (hsotg->params.phy_type == DWC2_PHY_TYPE_PARAM_UTMI) {
+		if (hsotg->params.phy_utmi_width == 16)
+			usbcfg |= GUSBCFG_PHYIF16;
+
+		/* Set turnaround time */
+		usbcfg &= ~GUSBCFG_USBTRDTIM_MASK;
+		if (hsotg->params.phy_utmi_width == 16)
+			usbcfg |= 5 << GUSBCFG_USBTRDTIM_SHIFT;
+		else
+			usbcfg |= 9 << GUSBCFG_USBTRDTIM_SHIFT;
 	}
+
 	dwc2_writel(hsotg, usbcfg, GUSBCFG);
 
 	dwc2_hsotg_init_fifo(hsotg);
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index c01fa8ffc0c8..d10a7f8daec3 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -230,9 +230,6 @@ static int dwc2_lowlevel_hw_init(struct dwc2_hsotg *hsotg)
 
 	reset_control_deassert(hsotg->reset_ecc);
 
-	/* Set default UTMI width */
-	hsotg->phyif = GUSBCFG_PHYIF16;
-
 	/*
 	 * Attempt to find a generic PHY, then look for an old style
 	 * USB PHY and then fall back to pdata
@@ -280,7 +277,7 @@ static int dwc2_lowlevel_hw_init(struct dwc2_hsotg *hsotg)
 		 * width is 8-bit and set the phyif appropriately.
 		 */
 		if (phy_get_bus_width(hsotg->phy) == 8)
-			hsotg->phyif = GUSBCFG_PHYIF8;
+			hsotg->params.phy_utmi_width = 8;
 	}
 
 	/* Clock */
-- 
2.17.1

