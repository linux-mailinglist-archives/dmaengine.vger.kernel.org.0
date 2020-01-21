Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22E3114487C
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jan 2020 00:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgAUXoN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Jan 2020 18:44:13 -0500
Received: from mga17.intel.com ([192.55.52.151]:51532 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgAUXoN (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 Jan 2020 18:44:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 15:44:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,347,1574150400"; 
   d="scan'208";a="281137021"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jan 2020 15:44:11 -0800
Subject: [PATCH v5 6/9] dmaengine: idxd: add sysfs ABI for idxd driver
From:   Dave Jiang <dave.jiang@intel.com>
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
Cc:     dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com, megha.dey@intel.com,
        jacob.jun.pan@intel.com, yi.l.liu@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, fenghua.yu@intel.com, hpa@zytor.com
Date:   Tue, 21 Jan 2020 16:44:11 -0700
Message-ID: <157965025170.73301.13428570530450446901.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <157965011794.73301.15960052071729101309.stgit@djiang5-desk3.ch.intel.com>
References: <157965011794.73301.15960052071729101309.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Jing Lin <jing.lin@intel.com>

Add the sysfs ABI information for idxd driver in
Documentation/ABI/stable directory.

Signed-off-by: Jing Lin <jing.lin@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 Documentation/ABI/stable/sysfs-driver-dma-idxd |  171 ++++++++++++++++++++++++
 1 file changed, 171 insertions(+)
 create mode 100644 Documentation/ABI/stable/sysfs-driver-dma-idxd

diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
new file mode 100644
index 000000000000..f4be46cc6cb6
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -0,0 +1,171 @@
+What:           sys/bus/dsa/devices/dsa<m>/cdev_major
+Date:           Oct 25, 2019
+KernelVersion: 	5.6.0
+Contact:        dmaengine@vger.kernel.org
+Description:	The major number that the character device driver assigned to
+		this device.
+
+What:           sys/bus/dsa/devices/dsa<m>/errors
+Date:           Oct 25, 2019
+KernelVersion:  5.6.0
+Contact:        dmaengine@vger.kernel.org
+Description:    The error information for this device.
+
+What:           sys/bus/dsa/devices/dsa<m>/max_batch_size
+Date:           Oct 25, 2019
+KernelVersion:  5.6.0
+Contact:        dmaengine@vger.kernel.org
+Description:    The largest number of work descriptors in a batch.
+
+What:           sys/bus/dsa/devices/dsa<m>/max_work_queues_size
+Date:           Oct 25, 2019
+KernelVersion:  5.6.0
+Contact:        dmaengine@vger.kernel.org
+Description:    The maximum work queue size supported by this device.
+
+What:           sys/bus/dsa/devices/dsa<m>/max_engines
+Date:           Oct 25, 2019
+KernelVersion:  5.6.0
+Contact:        dmaengine@vger.kernel.org
+Description:    The maximum number of engines supported by this device.
+
+What:           sys/bus/dsa/devices/dsa<m>/max_groups
+Date:           Oct 25, 2019
+KernelVersion:  5.6.0
+Contact:        dmaengine@vger.kernel.org
+Description:    The maximum number of groups can be created under this device.
+
+What:           sys/bus/dsa/devices/dsa<m>/max_tokens
+Date:           Oct 25, 2019
+KernelVersion:  5.6.0
+Contact:        dmaengine@vger.kernel.org
+Description:    The total number of bandwidth tokens supported by this device.
+		The bandwidth tokens represent resources within the DSA
+		implementation, and these resources are allocated by engines to
+		support operations.
+
+What:           sys/bus/dsa/devices/dsa<m>/max_transfer_size
+Date:           Oct 25, 2019
+KernelVersion:  5.6.0
+Contact:        dmaengine@vger.kernel.org
+Description:    The number of bytes to be read from the source address to
+		perform the operation. The maximum transfer size is dependent on
+		the workqueue the descriptor was submitted to.
+
+What:           sys/bus/dsa/devices/dsa<m>/max_work_queues
+Date:           Oct 25, 2019
+KernelVersion:  5.6.0
+Contact:        dmaengine@vger.kernel.org
+Description:    The maximum work queue number that this device supports.
+
+What:           sys/bus/dsa/devices/dsa<m>/numa_node
+Date:           Oct 25, 2019
+KernelVersion:  5.6.0
+Contact:        dmaengine@vger.kernel.org
+Description:    The numa node number for this device.
+
+What:           sys/bus/dsa/devices/dsa<m>/op_cap
+Date:           Oct 25, 2019
+KernelVersion:  5.6.0
+Contact:        dmaengine@vger.kernel.org
+Description:    The operation capability bit mask specify the operation types
+		supported by the this device.
+
+What:           sys/bus/dsa/devices/dsa<m>/state
+Date:           Oct 25, 2019
+KernelVersion:  5.6.0
+Contact:        dmaengine@vger.kernel.org
+Description:    The state information of this device. It can be either enabled
+		or disabled.
+
+What:           sys/bus/dsa/devices/dsa<m>/group<m>.<n>
+Date:           Oct 25, 2019
+KernelVersion:  5.6.0
+Contact:        dmaengine@vger.kernel.org
+Description:    The assigned group under this device.
+
+What:           sys/bus/dsa/devices/dsa<m>/engine<m>.<n>
+Date:           Oct 25, 2019
+KernelVersion:  5.6.0
+Contact:        dmaengine@vger.kernel.org
+Description:    The assigned engine under this device.
+
+What:           sys/bus/dsa/devices/dsa<m>/wq<m>.<n>
+Date:           Oct 25, 2019
+KernelVersion:  5.6.0
+Contact:        dmaengine@vger.kernel.org
+Description:    The assigned work queue under this device.
+
+What:           sys/bus/dsa/devices/dsa<m>/configurable
+Date:           Oct 25, 2019
+KernelVersion:  5.6.0
+Contact:        dmaengine@vger.kernel.org
+Description:    To indicate if this device is configurable or not.
+
+What:           sys/bus/dsa/devices/dsa<m>/token_limit
+Date:           Oct 25, 2019
+KernelVersion:  5.6.0
+Contact:        dmaengine@vger.kernel.org
+Description:    The maximum number of bandwidth tokens that may be in use at
+		one time by operations that access low bandwidth memory in the
+		device.
+
+What:           sys/bus/dsa/devices/wq<m>.<n>/group_id
+Date:           Oct 25, 2019
+KernelVersion:  5.6.0
+Contact:        dmaengine@vger.kernel.org
+Description:    The group id that this work queue belongs to.
+
+What:           sys/bus/dsa/devices/wq<m>.<n>/size
+Date:           Oct 25, 2019
+KernelVersion:  5.6.0
+Contact:        dmaengine@vger.kernel.org
+Description:    The work queue size for this work queue.
+
+What:           sys/bus/dsa/devices/wq<m>.<n>/type
+Date:           Oct 25, 2019
+KernelVersion:  5.6.0
+Contact:        dmaengine@vger.kernel.org
+Description:    The type of this work queue, it can be "kernel" type for work
+		queue usages in the kernel space or "user" type for work queue
+		usages by applications in user space.
+
+What:           sys/bus/dsa/devices/wq<m>.<n>/cdev_minor
+Date:           Oct 25, 2019
+KernelVersion:  5.6.0
+Contact:        dmaengine@vger.kernel.org
+Description:    The minor number assigned to this work queue by the character
+		device driver.
+
+What:           sys/bus/dsa/devices/wq<m>.<n>/mode
+Date:           Oct 25, 2019
+KernelVersion:  5.6.0
+Contact:        dmaengine@vger.kernel.org
+Description:    The work queue mode type for this work queue.
+
+What:           sys/bus/dsa/devices/wq<m>.<n>/priority
+Date:           Oct 25, 2019
+KernelVersion:  5.6.0
+Contact:        dmaengine@vger.kernel.org
+Description:    The priority value of this work queue, it is a vlue relative to
+		other work queue in the same group to control quality of service
+		for dispatching work from multiple workqueues in the same group.
+
+What:           sys/bus/dsa/devices/wq<m>.<n>/state
+Date:           Oct 25, 2019
+KernelVersion:  5.6.0
+Contact:        dmaengine@vger.kernel.org
+Description:    The current state of the work queue.
+
+What:           sys/bus/dsa/devices/wq<m>.<n>/threshold
+Date:           Oct 25, 2019
+KernelVersion:  5.6.0
+Contact:        dmaengine@vger.kernel.org
+Description:    The number of entries in this work queue that may be filled
+		via a limited portal.
+
+What:           sys/bus/dsa/devices/engine<m>.<n>/group_id
+Date:           Oct 25, 2019
+KernelVersion:  5.6.0
+Contact:        dmaengine@vger.kernel.org
+Description:    The group that this engine belongs to.

