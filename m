Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B809277828
	for <lists+dmaengine@lfdr.de>; Thu, 24 Sep 2020 20:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgIXSBO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Sep 2020 14:01:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728659AbgIXSBO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 24 Sep 2020 14:01:14 -0400
Received: from localhost (unknown [192.55.55.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68A7D2311B;
        Thu, 24 Sep 2020 18:01:13 +0000 (UTC)
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dan.j.williams@intel.com, tony.luck@intel.com,
        jing.lin@intel.com, ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        fenghua.yu@intel.com, kevin.tian@intel.com, David.Laight@ACULAB.COM
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/5] dmaengine: idxd: Add ABI documentation for shared wq
Date:   Thu, 24 Sep 2020 11:00:41 -0700
Message-Id: <20200924180041.34056-6-dave.jiang@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200924180041.34056-1-dave.jiang@intel.com>
References: <20200924180041.34056-1-dave.jiang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add the sysfs attribute bits in ABI/stable for shared wq support.

Signed-off-by: Jing Lin <jing.lin@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/stable/sysfs-driver-dma-idxd | 14 ++++++++++++++
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
-- 
2.21.3

