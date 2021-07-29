Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA7E3DA2CB
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jul 2021 14:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbhG2MEP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Jul 2021 08:04:15 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:43871 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbhG2MEK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Jul 2021 08:04:10 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d05 with ME
        id b0432500421Fzsu03043Zp; Thu, 29 Jul 2021 14:04:06 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 29 Jul 2021 14:04:06 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     dave.jiang@intel.com, vkoul@kernel.org, dan.j.williams@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] dmaengine: idxd: Fix a possible NULL pointer dereference
Date:   Thu, 29 Jul 2021 14:04:01 +0200
Message-Id: <77f0dc4f3966591d1f0cffb614a94085f8895a85.1627560174.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

'device_driver_attach()' dereferences its first argument (i.e. 'alt_drv')
so it must not be NULL.
Simplify the error handling logic about NULL 'alt_drv' in order to be
more robust and future-proof.

Fixes: 568b2126466f ("dmaengine: idxd: fix uninit var for alt_drv")
Fixes: 6e7f3ee97bbe ("dmaengine: idxd: move dsa_drv support to compatible mode")

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/dma/idxd/compat.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/idxd/compat.c b/drivers/dma/idxd/compat.c
index d7616c240dcd..3df21615f888 100644
--- a/drivers/dma/idxd/compat.c
+++ b/drivers/dma/idxd/compat.c
@@ -45,23 +45,16 @@ static ssize_t bind_store(struct device_driver *drv, const char *buf, size_t cou
 	idxd_dev = confdev_to_idxd_dev(dev);
 	if (is_idxd_dev(idxd_dev)) {
 		alt_drv = driver_find("idxd", bus);
-		if (!alt_drv)
-			return -ENODEV;
 	} else if (is_idxd_wq_dev(idxd_dev)) {
 		struct idxd_wq *wq = confdev_to_wq(dev);
 
-		if (is_idxd_wq_kernel(wq)) {
+		if (is_idxd_wq_kernel(wq))
 			alt_drv = driver_find("dmaengine", bus);
-			if (!alt_drv)
-				return -ENODEV;
-		} else if (is_idxd_wq_user(wq)) {
+		else if (is_idxd_wq_user(wq))
 			alt_drv = driver_find("user", bus);
-			if (!alt_drv)
-				return -ENODEV;
-		} else {
-			return -ENODEV;
-		}
 	}
+	if (!alt_drv)
+		return -ENODEV;
 
 	rc = device_driver_attach(alt_drv, dev);
 	if (rc < 0)
-- 
2.30.2

