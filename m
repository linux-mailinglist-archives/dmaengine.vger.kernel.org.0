Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56EDB3C9463
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jul 2021 01:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237518AbhGNXX1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 19:23:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:11101 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230525AbhGNXX1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Jul 2021 19:23:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="197628129"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="197628129"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 16:20:34 -0700
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="630544378"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 16:20:34 -0700
Subject: [PATCH v2 02/18] dmaengine: idxd: add driver name
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
Date:   Wed, 14 Jul 2021 16:20:33 -0700
Message-ID: <162630483384.631529.181123559773872953.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <162630468448.631529.1963704964865951650.stgit@djiang5-desk3.ch.intel.com>
References: <162630468448.631529.1963704964865951650.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add name field in idxd_device_driver so we don't have to touch the
'struct device_driver' during declaration.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/idxd.h  |    1 +
 drivers/dma/idxd/init.c  |    1 +
 drivers/dma/idxd/sysfs.c |    4 +---
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index c26f7baa812d..b1e4fd202d7e 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -34,6 +34,7 @@ enum idxd_type {
 #define IDXD_PMU_EVENT_MAX	64
 
 struct idxd_device_driver {
+	const char *name;
 	struct device_driver drv;
 };
 
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index c2f2709fc8cc..1b3ee5f5b559 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -851,6 +851,7 @@ int __idxd_driver_register(struct idxd_device_driver *idxd_drv, struct module *o
 {
 	struct device_driver *drv = &idxd_drv->drv;
 
+	drv->name = idxd_drv->name;
 	drv->bus = &dsa_bus_type;
 	drv->owner = owner;
 	drv->mod_name = mod_name;
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 983ccc32813e..1d71dbad85fc 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -311,9 +311,7 @@ struct bus_type dsa_bus_type = {
 };
 
 static struct idxd_device_driver dsa_drv = {
-	.drv = {
-		.name = "dsa",
-	},
+	.name = "dsa",
 };
 
 /* IDXD generic driver setup */


