Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1701A13B4A5
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jan 2020 22:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgANVse (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jan 2020 16:48:34 -0500
Received: from inva020.nxp.com ([92.121.34.13]:55816 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728928AbgANVse (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 14 Jan 2020 16:48:34 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 649BB1A140C;
        Tue, 14 Jan 2020 22:48:32 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6476B1A0201;
        Tue, 14 Jan 2020 22:48:26 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C2864402CA;
        Wed, 15 Jan 2020 05:48:13 +0800 (SGT)
From:   Han Xu <han.xu@nxp.com>
To:     vkoul@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        esben@geanix.com, boris.brezillon@collabora.com
Cc:     festevam@gmail.com, linux-imx@nxp.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, han.xu@nxp.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] mtd: rawnand: gpmi: set the pinctrl state for suspend/reusme
Date:   Wed, 15 Jan 2020 05:44:03 +0800
Message-Id: <1579038243-28550-7-git-send-email-han.xu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579038243-28550-1-git-send-email-han.xu@nxp.com>
References: <1579038243-28550-1-git-send-email-han.xu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

set the correct pinctrl state in system pm suspend/resume ops

Signed-off-by: Han Xu <han.xu@nxp.com>
---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index 73644c96fa9b..de1e3dbb2eb1 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/dma/mxs-dma.h>
 #include "gpmi-nand.h"
 #include "gpmi-regs.h"
@@ -2692,6 +2693,7 @@ static int gpmi_pm_suspend(struct device *dev)
 {
 	int ret;
 
+	pinctrl_pm_select_sleep_state(dev);
 	ret = pm_runtime_force_suspend(dev);
 
 	return ret;
@@ -2708,6 +2710,8 @@ static int gpmi_pm_resume(struct device *dev)
 		return ret;
 	}
 
+	pinctrl_pm_select_default_state(dev);
+
 	/* re-init the GPMI registers */
 	ret = gpmi_init(this);
 	if (ret) {
-- 
2.17.1

