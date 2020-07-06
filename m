Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D54215E42
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2020 20:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbgGFSWE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Jul 2020 14:22:04 -0400
Received: from mga07.intel.com ([134.134.136.100]:55280 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729647AbgGFSWD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 6 Jul 2020 14:22:03 -0400
IronPort-SDR: 9pD/5DerAwCwSyfQWsNu2vzvNOzf3p319ejckPWeFW08yageC1bZ2ItHsEI3NLlSuKpELhA68L
 Ax4hOQwE9u7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="212454138"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="212454138"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 11:22:02 -0700
IronPort-SDR: oN9m+rIQCN3syuIFmMlur2gPncmerVM4+pwhjHFM5sag09qNc72pYXSYJPgdQYw9tFcjioVOOt
 AWvVDpXhwOUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="427187389"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga004.jf.intel.com with ESMTP; 06 Jul 2020 11:22:01 -0700
Subject: [PATCH v3 6/6] dmaengine: idxd: add ABI documentation for shared wq
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     Jing Lin <jing.lin@intel.com>, Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, dan.j.williams@intel.com, ashok.raj@intel.com,
        fenghua.yu@intel.com, tony.luck@intel.com, jing.lin@intel.com
Date:   Mon, 06 Jul 2020 11:22:01 -0700
Message-ID: <159405972142.19216.202541495863164149.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <159405827797.19216.15283540319201919054.stgit@djiang5-desk3.ch.intel.com>
References: <159405827797.19216.15283540319201919054.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
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
index 1af9c4175213..a336d2b2009a 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -77,6 +77,13 @@ Contact:        dmaengine@vger.kernel.org
 Description:    The operation capability bit mask specify the operation types
 		supported by the this device.
 
+What:		/sys/bus/dsa/devices/dsa<m>/pasid_enabled
+Date:		Jul 5, 2020
+KernelVersion:	5.9.0
+Contact:	dmaengine@vger.kernel.org
+Description:	To indicate if PASID (process address space identifier) is
+		enabled or not for this device.
+
 What:           /sys/bus/dsa/devices/dsa<m>/state
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
@@ -116,6 +123,13 @@ Description:    The maximum number of bandwidth tokens that may be in use at
 		one time by operations that access low bandwidth memory in the
 		device.
 
+What:		/sys/bus/dsa/devices/wq<m>.<n>/block_on_fault
+Date:		Jul 5, 2020
+KernelVersion:	5.9.0
+Contact:	dmaengine@vger.kernel.org
+Description:	To indicate block on fault is allowed or not for the work queue
+		to support on demand paging.
+
 What:           /sys/bus/dsa/devices/wq<m>.<n>/group_id
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0

