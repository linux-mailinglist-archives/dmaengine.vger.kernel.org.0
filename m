Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5123F38D150
	for <lists+dmaengine@lfdr.de>; Sat, 22 May 2021 00:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhEUWXF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 May 2021 18:23:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:56268 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhEUWXE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 21 May 2021 18:23:04 -0400
IronPort-SDR: J2kb2J17YLZLBAo2wUciguvk7PFLS4Xj1zKH1T/00U6dSdIGufNkwHVTKZUgvA8vAdI+2Z1z9y
 bxtOc1W7MHQw==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="201619819"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="201619819"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:21:34 -0700
IronPort-SDR: rSQcpZ8VaiwAJ3N3VUvbIkbCt5haRw2Y9H6+sqleIi7kYt8dk7CscOBuwhtAj4hBdWJJD0ukZd
 mqNexA7ypJSQ==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="628826803"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:21:34 -0700
Subject: [PATCH 02/18] dmaengine: idxd: add driver name
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        jgg@nvidia.com, ramesh.thomas@intel.com
Date:   Fri, 21 May 2021 15:21:34 -0700
Message-ID: <162163569407.260470.8069733178174299145.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <162163546245.260470.18336189072934823712.stgit@djiang5-desk3.ch.intel.com>
References: <162163546245.260470.18336189072934823712.stgit@djiang5-desk3.ch.intel.com>
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
index da4195a5e2f1..06bf23dabc82 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -34,6 +34,7 @@ enum idxd_type {
 #define IDXD_PMU_EVENT_MAX	64
 
 struct idxd_device_driver {
+	const char *name;
 	struct device_driver drv;
 };
 
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index c46421452c9b..cc6779968bec 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -800,6 +800,7 @@ int __idxd_driver_register(struct idxd_device_driver *idxd_drv, struct module *o
 {
 	struct device_driver *drv = &idxd_drv->drv;
 
+	drv->name = idxd_drv->name;
 	drv->bus = &dsa_bus_type;
 	drv->owner = owner;
 	drv->mod_name = mod_name;
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index c614ffa9a610..9b209788255c 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -323,9 +323,7 @@ struct bus_type dsa_bus_type = {
 };
 
 static struct idxd_device_driver dsa_drv = {
-	.drv = {
-		.name = "dsa",
-	},
+	.name = "dsa",
 };
 
 /* IDXD generic driver setup */


