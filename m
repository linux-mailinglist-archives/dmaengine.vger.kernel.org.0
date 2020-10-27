Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0D729C26E
	for <lists+dmaengine@lfdr.de>; Tue, 27 Oct 2020 18:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441440AbgJ0Rfo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Oct 2020 13:35:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:42393 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1820353AbgJ0Rey (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 27 Oct 2020 13:34:54 -0400
IronPort-SDR: JZeh3czguF6MHTgxMtdcSLwAcMY7bgy6e/NyIhu0J4CCTl+v/sweyBlrAXCyMSthZj6B4BRiym
 Uay6yx+ImnqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9787"; a="168257390"
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="168257390"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 10:34:47 -0700
IronPort-SDR: GFQTfihICg6kDwMk+kJBrZvBpcJjlQX0TSgl/6pdm+n5A/xhY/GIwKxYIcv3/nFYpmaAAK5h0x
 WgNI2fQ0r/Vw==
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="350673714"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 10:34:46 -0700
Subject: [PATCH v8 3/3] dmaengine: idxd: Add ABI documentation for shared wq
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Tue, 27 Oct 2020 10:34:46 -0700
Message-ID: <160382008649.3911367.10851752182908509837.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <160381975739.3911367.10543310695440091523.stgit@djiang5-desk3.ch.intel.com>
References: <160381975739.3911367.10543310695440091523.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add the sysfs attribute bits in ABI/stable for shared wq support.

Signed-off-by: Jing Lin <jing.lin@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/stable/sysfs-driver-dma-idxd |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
index b44183880935..5ea81ffd3c1a 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -77,6 +77,13 @@ Contact:        dmaengine@vger.kernel.org
 Description:    The operation capability bit mask specify the operation types
 		supported by the this device.
 
+What:		/sys/bus/dsa/devices/dsa<m>/pasid_enabled
+Date:		Oct 27, 2020
+KernelVersion:	5.11.0
+Contact:	dmaengine@vger.kernel.org
+Description:	To indicate if PASID (process address space identifier) is
+		enabled or not for this device.
+
 What:           /sys/bus/dsa/devices/dsa<m>/state
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
@@ -122,6 +129,13 @@ KernelVersion:	5.10.0
 Contact:	dmaengine@vger.kernel.org
 Description:	The last executed device administrative command's status/error.
 
+What:		/sys/bus/dsa/devices/wq<m>.<n>/block_on_fault
+Date:		Oct 27, 2020
+KernelVersion:	5.11.0
+Contact:	dmaengine@vger.kernel.org
+Description:	To indicate block on fault is allowed or not for the work queue
+		to support on demand paging.
+
 What:           /sys/bus/dsa/devices/wq<m>.<n>/group_id
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0


