Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50C126E739
	for <lists+dmaengine@lfdr.de>; Thu, 17 Sep 2020 23:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgIQVPn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Sep 2020 17:15:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:58727 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgIQVPm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 17 Sep 2020 17:15:42 -0400
IronPort-SDR: EigG3werYRB04hiiO3osg1nZoAsgS1JXnEm1WBTQIr3vOpRVmHbKD5GIUdZobSNHH8DcCE+OxV
 /TfNfotnos4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="159851184"
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; 
   d="scan'208";a="159851184"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 14:15:42 -0700
IronPort-SDR: 41W9HVJbmnPVNGavp6bKJ/JvLkIFG37MLbLq1gleWjuWXj+SosUSKVKRTv+Zy2s/dnfTglG/NB
 rloQ3AXb5Wtw==
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; 
   d="scan'208";a="508591161"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 14:15:41 -0700
Subject: [PATCH v4 5/5] dmaengine: idxd: add ABI documentation for shared wq
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dan.j.williams@intel.com, tony.luck@intel.com,
        jing.lin@intel.com, ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        fenghua.yu@intel.com, kevin.tian@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 17 Sep 2020 14:15:41 -0700
Message-ID: <160037734142.3777.10569472774737564836.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <160037680630.3777.16356270178889649944.stgit@djiang5-desk3.ch.intel.com>
References: <160037680630.3777.16356270178889649944.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
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
index b44183880935..42d3dc03ffea 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -77,6 +77,13 @@ Contact:        dmaengine@vger.kernel.org
 Description:    The operation capability bit mask specify the operation types
 		supported by the this device.
 
+What:		/sys/bus/dsa/devices/dsa<m>/pasid_enabled
+Date:		Sep 17, 2020
+KernelVersion:	5.10.0
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
+Date:		Sept 17, 2020
+KernelVersion:	5.10.0
+Contact:	dmaengine@vger.kernel.org
+Description:	To indicate block on fault is allowed or not for the work queue
+		to support on demand paging.
+
 What:           /sys/bus/dsa/devices/wq<m>.<n>/group_id
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0

