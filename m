Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F396D6B80D8
	for <lists+dmaengine@lfdr.de>; Mon, 13 Mar 2023 19:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjCMSh7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 14:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjCMShp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 14:37:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F910222D7;
        Mon, 13 Mar 2023 11:36:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E54C61464;
        Mon, 13 Mar 2023 18:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2405FC433EF;
        Mon, 13 Mar 2023 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732225;
        bh=/YljSSK5bkf0A5p++gDOQhTrbvu0meKM3gc6Wqmpcik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZuW8D0A6kYVqF6udIwRPFUbDNKarWp+aG9MdmZAfzvfwL091bU1pRVD06iPU9yQi
         69T46Gdn3EtJ1MbLsLah0P0CImxbvPkAnq4/WJz2qjfGZpM/Az5Srox+oono4i3H1L
         KmNOk7uMQNXhIE3GwY9xte0Bf17QPPPE595IrL1E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: [PATCH 32/36] dmaengine: idxd: use const struct bus_type *
Date:   Mon, 13 Mar 2023 19:29:14 +0100
Message-Id: <20230313182918.1312597-32-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1736; i=gregkh@linuxfoundation.org; h=from:subject; bh=/YljSSK5bkf0A5p++gDOQhTrbvu0meKM3gc6Wqmpcik=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82TX6kZ/vWz5Tste57XYkInulvW3Dsd+vJbdo3OIIn n2O58rajlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZiIaBHD/MAFhiy3Q9NCqiem r3q4bjJbgra+CcM8JY6ke5Pcy60cy4N917PKMUi/nqYGAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In the functions unbind_store() and bind_store(), a struct bus_type *
should be a const one, as the driver core bus functions used by this
variable are expecting the pointer to be constant, and these functions
do not modify the pointer at all.

Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note, this is a patch that is a prepatory cleanup as part of a larger
series of patches that is working on resolving some old driver core
design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
its own, but I'd prefer if I could take it through my driver-core tree
so that the driver core changes can be taken through there for 6.4-rc1.

 drivers/dma/idxd/compat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/compat.c b/drivers/dma/idxd/compat.c
index 3df21615f888..5fd38d1b9d28 100644
--- a/drivers/dma/idxd/compat.c
+++ b/drivers/dma/idxd/compat.c
@@ -16,7 +16,7 @@ extern void device_driver_detach(struct device *dev);
 
 static ssize_t unbind_store(struct device_driver *drv, const char *buf, size_t count)
 {
-	struct bus_type *bus = drv->bus;
+	const struct bus_type *bus = drv->bus;
 	struct device *dev;
 	int rc = -ENODEV;
 
@@ -32,7 +32,7 @@ static DRIVER_ATTR_IGNORE_LOCKDEP(unbind, 0200, NULL, unbind_store);
 
 static ssize_t bind_store(struct device_driver *drv, const char *buf, size_t count)
 {
-	struct bus_type *bus = drv->bus;
+	const struct bus_type *bus = drv->bus;
 	struct device *dev;
 	struct device_driver *alt_drv = NULL;
 	int rc = -ENODEV;
-- 
2.39.2

