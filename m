Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3BE1D87AD
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2020 20:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbgERSyP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 May 2020 14:54:15 -0400
Received: from mga03.intel.com ([134.134.136.65]:11287 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729960AbgERSyO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 18 May 2020 14:54:14 -0400
IronPort-SDR: OiqKDccjH+PEwIkMVtRKky2iNrz7FP/HC1sZ0pvAkhjwMCGl2gvWvHYX11xvuu1rPiTZobG8KQ
 rnZ5WvaQyedg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 11:54:10 -0700
IronPort-SDR: LOCXksuhS6J3SWZox9VDZyhkSdJzbosWevFE2tmZFivn4ntaza/jI0KqzzoRGAV5CqpXY6OEKB
 g5zWSybhRDKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="282067521"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga002.jf.intel.com with ESMTP; 18 May 2020 11:54:09 -0700
Subject: [PATCH v2 8/9] dmaengine: idxd: add leading / for sysfspath in ABI
 documentation
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, dan.j.williams@intel.com, ashok.raj@intel.com,
        fenghua.yu@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        sanjay.k.kumar@intel.com, dave.hansen@intel.com
Date:   Mon, 18 May 2020 11:54:09 -0700
Message-ID: <158982804924.37989.17925358688258210666.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <158982749959.37989.2096629611303670415.stgit@djiang5-desk3.ch.intel.com>
References: <158982749959.37989.2096629611303670415.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Correct to standard convention. All sysfs paths seem to be missing leading
/.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/stable/sysfs-driver-dma-idxd |   54 ++++++++++++------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
index b5bebf642db6..2253bb1550d6 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -1,47 +1,47 @@
-What:		sys/bus/dsa/devices/dsa<m>/version
+What:		/sys/bus/dsa/devices/dsa<m>/version
 Date:		Apr 15, 2020
 KernelVersion:	5.8.0
 Contact:	dmaengine@vger.kernel.org
 Description:	The hardware version number.
 
-What:           sys/bus/dsa/devices/dsa<m>/cdev_major
+What:           /sys/bus/dsa/devices/dsa<m>/cdev_major
 Date:           Oct 25, 2019
 KernelVersion: 	5.6.0
 Contact:        dmaengine@vger.kernel.org
 Description:	The major number that the character device driver assigned to
 		this device.
 
-What:           sys/bus/dsa/devices/dsa<m>/errors
+What:           /sys/bus/dsa/devices/dsa<m>/errors
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
 Contact:        dmaengine@vger.kernel.org
 Description:    The error information for this device.
 
-What:           sys/bus/dsa/devices/dsa<m>/max_batch_size
+What:           /sys/bus/dsa/devices/dsa<m>/max_batch_size
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
 Contact:        dmaengine@vger.kernel.org
 Description:    The largest number of work descriptors in a batch.
 
-What:           sys/bus/dsa/devices/dsa<m>/max_work_queues_size
+What:           /sys/bus/dsa/devices/dsa<m>/max_work_queues_size
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
 Contact:        dmaengine@vger.kernel.org
 Description:    The maximum work queue size supported by this device.
 
-What:           sys/bus/dsa/devices/dsa<m>/max_engines
+What:           /sys/bus/dsa/devices/dsa<m>/max_engines
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
 Contact:        dmaengine@vger.kernel.org
 Description:    The maximum number of engines supported by this device.
 
-What:           sys/bus/dsa/devices/dsa<m>/max_groups
+What:           /sys/bus/dsa/devices/dsa<m>/max_groups
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
 Contact:        dmaengine@vger.kernel.org
 Description:    The maximum number of groups can be created under this device.
 
-What:           sys/bus/dsa/devices/dsa<m>/max_tokens
+What:           /sys/bus/dsa/devices/dsa<m>/max_tokens
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
 Contact:        dmaengine@vger.kernel.org
@@ -50,7 +50,7 @@ Description:    The total number of bandwidth tokens supported by this device.
 		implementation, and these resources are allocated by engines to
 		support operations.
 
-What:           sys/bus/dsa/devices/dsa<m>/max_transfer_size
+What:           /sys/bus/dsa/devices/dsa<m>/max_transfer_size
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
 Contact:        dmaengine@vger.kernel.org
@@ -58,57 +58,57 @@ Description:    The number of bytes to be read from the source address to
 		perform the operation. The maximum transfer size is dependent on
 		the workqueue the descriptor was submitted to.
 
-What:           sys/bus/dsa/devices/dsa<m>/max_work_queues
+What:           /sys/bus/dsa/devices/dsa<m>/max_work_queues
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
 Contact:        dmaengine@vger.kernel.org
 Description:    The maximum work queue number that this device supports.
 
-What:           sys/bus/dsa/devices/dsa<m>/numa_node
+What:           /sys/bus/dsa/devices/dsa<m>/numa_node
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
 Contact:        dmaengine@vger.kernel.org
 Description:    The numa node number for this device.
 
-What:           sys/bus/dsa/devices/dsa<m>/op_cap
+What:           /sys/bus/dsa/devices/dsa<m>/op_cap
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
 Contact:        dmaengine@vger.kernel.org
 Description:    The operation capability bit mask specify the operation types
 		supported by the this device.
 
-What:           sys/bus/dsa/devices/dsa<m>/state
+What:           /sys/bus/dsa/devices/dsa<m>/state
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
 Contact:        dmaengine@vger.kernel.org
 Description:    The state information of this device. It can be either enabled
 		or disabled.
 
-What:           sys/bus/dsa/devices/dsa<m>/group<m>.<n>
+What:           /sys/bus/dsa/devices/dsa<m>/group<m>.<n>
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
 Contact:        dmaengine@vger.kernel.org
 Description:    The assigned group under this device.
 
-What:           sys/bus/dsa/devices/dsa<m>/engine<m>.<n>
+What:           /sys/bus/dsa/devices/dsa<m>/engine<m>.<n>
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
 Contact:        dmaengine@vger.kernel.org
 Description:    The assigned engine under this device.
 
-What:           sys/bus/dsa/devices/dsa<m>/wq<m>.<n>
+What:           /sys/bus/dsa/devices/dsa<m>/wq<m>.<n>
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
 Contact:        dmaengine@vger.kernel.org
 Description:    The assigned work queue under this device.
 
-What:           sys/bus/dsa/devices/dsa<m>/configurable
+What:           /sys/bus/dsa/devices/dsa<m>/configurable
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
 Contact:        dmaengine@vger.kernel.org
 Description:    To indicate if this device is configurable or not.
 
-What:           sys/bus/dsa/devices/dsa<m>/token_limit
+What:           /sys/bus/dsa/devices/dsa<m>/token_limit
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
 Contact:        dmaengine@vger.kernel.org
@@ -116,19 +116,19 @@ Description:    The maximum number of bandwidth tokens that may be in use at
 		one time by operations that access low bandwidth memory in the
 		device.
 
-What:           sys/bus/dsa/devices/wq<m>.<n>/group_id
+What:           /sys/bus/dsa/devices/wq<m>.<n>/group_id
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
 Contact:        dmaengine@vger.kernel.org
 Description:    The group id that this work queue belongs to.
 
-What:           sys/bus/dsa/devices/wq<m>.<n>/size
+What:           /sys/bus/dsa/devices/wq<m>.<n>/size
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
 Contact:        dmaengine@vger.kernel.org
 Description:    The work queue size for this work queue.
 
-What:           sys/bus/dsa/devices/wq<m>.<n>/type
+What:           /sys/bus/dsa/devices/wq<m>.<n>/type
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
 Contact:        dmaengine@vger.kernel.org
@@ -136,20 +136,20 @@ Description:    The type of this work queue, it can be "kernel" type for work
 		queue usages in the kernel space or "user" type for work queue
 		usages by applications in user space.
 
-What:           sys/bus/dsa/devices/wq<m>.<n>/cdev_minor
+What:           /sys/bus/dsa/devices/wq<m>.<n>/cdev_minor
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
 Contact:        dmaengine@vger.kernel.org
 Description:    The minor number assigned to this work queue by the character
 		device driver.
 
-What:           sys/bus/dsa/devices/wq<m>.<n>/mode
+What:           /sys/bus/dsa/devices/wq<m>.<n>/mode
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
 Contact:        dmaengine@vger.kernel.org
 Description:    The work queue mode type for this work queue.
 
-What:           sys/bus/dsa/devices/wq<m>.<n>/priority
+What:           /sys/bus/dsa/devices/wq<m>.<n>/priority
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
 Contact:        dmaengine@vger.kernel.org
@@ -157,20 +157,20 @@ Description:    The priority value of this work queue, it is a vlue relative to
 		other work queue in the same group to control quality of service
 		for dispatching work from multiple workqueues in the same group.
 
-What:           sys/bus/dsa/devices/wq<m>.<n>/state
+What:           /sys/bus/dsa/devices/wq<m>.<n>/state
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
 Contact:        dmaengine@vger.kernel.org
 Description:    The current state of the work queue.
 
-What:           sys/bus/dsa/devices/wq<m>.<n>/threshold
+What:           /sys/bus/dsa/devices/wq<m>.<n>/threshold
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
 Contact:        dmaengine@vger.kernel.org
 Description:    The number of entries in this work queue that may be filled
 		via a limited portal.
 
-What:           sys/bus/dsa/devices/engine<m>.<n>/group_id
+What:           /sys/bus/dsa/devices/engine<m>.<n>/group_id
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
 Contact:        dmaengine@vger.kernel.org

