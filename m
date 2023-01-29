Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F8E6802BC
	for <lists+dmaengine@lfdr.de>; Mon, 30 Jan 2023 00:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbjA2XLF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 29 Jan 2023 18:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA2XLE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 29 Jan 2023 18:11:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD181ABEE;
        Sun, 29 Jan 2023 15:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=R2A7akXKvYokl+Oel/FVm+wy+mVQyUawn1NxgC81E2Q=; b=zSp0BbbBdQr9EfVSvgvP22raaU
        3by1qWSActPJchHujFog9jq8U9bD09KWALit/PoDIWAXB62QJZJ7FqEV0cDK8NtPUqBY4euVkJm7C
        5aZ6ygloTkJoZZeRFycGe7YG7eUgxn6dHifeRyGGC4j59taGhIqdN+bVKSSwdKo0d+znj30e3JG94
        IE8+My/lfubfvwFpq9mBu0qC5BILedVg+M05sz4ObNr3Ra4JJKy1hxj70InMvlSZatYjk8jeZMBs9
        sdfl1rVr2jluVTgYQhVtb31TtB3jQ6ZrbCYjDpkRCGZ2s3IQ7mYkXQmdXWG79I8we7VOAfQ5gEmLy
        W3B9eVRg==;
Received: from [2601:1c2:d00:6a60::9526] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMGp7-0020M2-63; Sun, 29 Jan 2023 23:10:57 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 2/9] Documentation: driver-api: correct spelling
Date:   Sun, 29 Jan 2023 15:10:46 -0800
Message-Id: <20230129231053.20863-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230129231053.20863-1-rdunlap@infradead.org>
References: <20230129231053.20863-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Correct spelling problems for Documentation/driver-api/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: nvdimm@lists.linux.dev
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: Song Liu <song@kernel.org>
Cc: linux-raid@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
---
 Documentation/driver-api/dma-buf.rst                  |    2 +-
 Documentation/driver-api/dmaengine/client.rst         |    2 +-
 Documentation/driver-api/dmaengine/dmatest.rst        |    2 +-
 Documentation/driver-api/hsi.rst                      |    4 ++--
 Documentation/driver-api/io-mapping.rst               |    4 ++--
 Documentation/driver-api/md/md-cluster.rst            |    2 +-
 Documentation/driver-api/md/raid5-cache.rst           |    2 +-
 Documentation/driver-api/media/drivers/vidtv.rst      |    2 +-
 Documentation/driver-api/media/dtv-demux.rst          |    2 +-
 Documentation/driver-api/media/v4l2-subdev.rst        |    4 ++--
 Documentation/driver-api/mei/nfc.rst                  |    2 +-
 Documentation/driver-api/nfc/nfc-hci.rst              |    2 +-
 Documentation/driver-api/nvdimm/nvdimm.rst            |    2 +-
 Documentation/driver-api/nvdimm/security.rst          |    2 +-
 Documentation/driver-api/pin-control.rst              |    2 +-
 Documentation/driver-api/pldmfw/index.rst             |    2 +-
 Documentation/driver-api/serial/driver.rst            |    2 +-
 Documentation/driver-api/surface_aggregator/ssh.rst   |    2 +-
 Documentation/driver-api/thermal/intel_powerclamp.rst |    2 +-
 Documentation/driver-api/usb/dwc3.rst                 |    2 +-
 Documentation/driver-api/usb/usb3-debug-port.rst      |    2 +-
 21 files changed, 24 insertions(+), 24 deletions(-)

diff -- a/Documentation/driver-api/dma-buf.rst b/Documentation/driver-api/dma-buf.rst
--- a/Documentation/driver-api/dma-buf.rst
+++ b/Documentation/driver-api/dma-buf.rst
@@ -264,7 +264,7 @@ through memory management dependencies w
 randomly hangs workloads until the timeout kicks in. Workloads, which from
 userspace's perspective, do not contain a deadlock.  In such a mixed fencing
 architecture there is no single entity with knowledge of all dependencies.
-Thefore preventing such deadlocks from within the kernel is not possible.
+Therefore preventing such deadlocks from within the kernel is not possible.
 
 The only solution to avoid dependencies loops is by not allowing indefinite
 fences in the kernel. This means:
diff -- a/Documentation/driver-api/hsi.rst b/Documentation/driver-api/hsi.rst
--- a/Documentation/driver-api/hsi.rst
+++ b/Documentation/driver-api/hsi.rst
@@ -4,7 +4,7 @@ High Speed Synchronous Serial Interface
 Introduction
 ---------------
 
-High Speed Syncronous Interface (HSI) is a fullduplex, low latency protocol,
+High Speed Synchronous Interface (HSI) is a full duplex, low latency protocol,
 that is optimized for die-level interconnect between an Application Processor
 and a Baseband chipset. It has been specified by the MIPI alliance in 2003 and
 implemented by multiple vendors since then.
@@ -52,7 +52,7 @@ hsi-char Device
 ------------------
 
 Each port automatically registers a generic client driver called hsi_char,
-which provides a charecter device for userspace representing the HSI port.
+which provides a character device for userspace representing the HSI port.
 It can be used to communicate via HSI from userspace. Userspace may
 configure the hsi_char device using the following ioctl commands:
 
diff -- a/Documentation/driver-api/mei/nfc.rst b/Documentation/driver-api/mei/nfc.rst
--- a/Documentation/driver-api/mei/nfc.rst
+++ b/Documentation/driver-api/mei/nfc.rst
@@ -3,7 +3,7 @@
 MEI NFC
 -------
 
-Some Intel 8 and 9 Serieses chipsets supports NFC devices connected behind
+Some Intel 8 and 9 Series chipsets support NFC devices connected behind
 the Intel Management Engine controller.
 MEI client bus exposes the NFC chips as NFC phy devices and enables
 binding with Microread and NXP PN544 NFC device driver from the Linux NFC
diff -- a/Documentation/driver-api/nfc/nfc-hci.rst b/Documentation/driver-api/nfc/nfc-hci.rst
--- a/Documentation/driver-api/nfc/nfc-hci.rst
+++ b/Documentation/driver-api/nfc/nfc-hci.rst
@@ -150,7 +150,7 @@ LLC
 
 Communication between the CPU and the chip often requires some link layer
 protocol. Those are isolated as modules managed by the HCI layer. There are
-currently two modules : nop (raw transfert) and shdlc.
+currently two modules : nop (raw transfer) and shdlc.
 A new llc must implement the following functions::
 
   struct nfc_llc_ops {
diff -- a/Documentation/driver-api/serial/driver.rst b/Documentation/driver-api/serial/driver.rst
--- a/Documentation/driver-api/serial/driver.rst
+++ b/Documentation/driver-api/serial/driver.rst
@@ -24,7 +24,7 @@ console support.
 Console Support
 ---------------
 
-The serial core provides a few helper functions.  This includes identifing
+The serial core provides a few helper functions.  This includes identifying
 the correct port structure (via uart_get_console()) and decoding command line
 arguments (uart_parse_options()).
 
diff -- a/Documentation/driver-api/surface_aggregator/ssh.rst b/Documentation/driver-api/surface_aggregator/ssh.rst
--- a/Documentation/driver-api/surface_aggregator/ssh.rst
+++ b/Documentation/driver-api/surface_aggregator/ssh.rst
@@ -77,7 +77,7 @@ after the frame structure and before the
 its own CRC (over all payload bytes). If the payload is not present (i.e.
 the frame has ``LEN=0``), the CRC of the payload is still present and will
 evaluate to ``0xffff``. The |LEN| field does not include any of the CRCs, it
-equals the number of bytes inbetween the CRC of the frame and the CRC of the
+equals the number of bytes between the CRC of the frame and the CRC of the
 payload.
 
 Additionally, the following fixed two-byte sequences are used:
diff -- a/Documentation/driver-api/nvdimm/nvdimm.rst b/Documentation/driver-api/nvdimm/nvdimm.rst
--- a/Documentation/driver-api/nvdimm/nvdimm.rst
+++ b/Documentation/driver-api/nvdimm/nvdimm.rst
@@ -82,7 +82,7 @@ LABEL:
   Metadata stored on a DIMM device that partitions and identifies
   (persistently names) capacity allocated to different PMEM namespaces. It
   also indicates whether an address abstraction like a BTT is applied to
-  the namepsace.  Note that traditional partition tables, GPT/MBR, are
+  the namespace.  Note that traditional partition tables, GPT/MBR, are
   layered on top of a PMEM namespace, or an address abstraction like BTT
   if present, but partition support is deprecated going forward.
 
diff -- a/Documentation/driver-api/nvdimm/security.rst b/Documentation/driver-api/nvdimm/security.rst
--- a/Documentation/driver-api/nvdimm/security.rst
+++ b/Documentation/driver-api/nvdimm/security.rst
@@ -83,7 +83,7 @@ passed in.
 6. Freeze
 ---------
 The freeze operation does not require any keys. The security config can be
-frozen by a user with root privelege.
+frozen by a user with root privilege.
 
 7. Disable
 ----------
diff -- a/Documentation/driver-api/thermal/intel_powerclamp.rst b/Documentation/driver-api/thermal/intel_powerclamp.rst
--- a/Documentation/driver-api/thermal/intel_powerclamp.rst
+++ b/Documentation/driver-api/thermal/intel_powerclamp.rst
@@ -85,7 +85,7 @@ migrated, unless the CPU is taken offlin
 belong to the offlined CPUs will be terminated immediately.
 
 Running as SCHED_FIFO and relatively high priority, also allows such
-scheme to work for both preemptable and non-preemptable kernels.
+scheme to work for both preemptible and non-preemptible kernels.
 Alignment of idle time around jiffies ensures scalability for HZ
 values. This effect can be better visualized using a Perf timechart.
 The following diagram shows the behavior of kernel thread
diff -- a/Documentation/driver-api/usb/dwc3.rst b/Documentation/driver-api/usb/dwc3.rst
--- a/Documentation/driver-api/usb/dwc3.rst
+++ b/Documentation/driver-api/usb/dwc3.rst
@@ -18,7 +18,7 @@ controller which can be configured in on
 	4. Hub configuration
 
 Linux currently supports several versions of this controller. In all
-likelyhood, the version in your SoC is already supported. At the time
+likelihood, the version in your SoC is already supported. At the time
 of this writing, known tested versions range from 2.02a to 3.10a. As a
 rule of thumb, anything above 2.02a should work reliably well.
 
diff -- a/Documentation/driver-api/usb/usb3-debug-port.rst b/Documentation/driver-api/usb/usb3-debug-port.rst
--- a/Documentation/driver-api/usb/usb3-debug-port.rst
+++ b/Documentation/driver-api/usb/usb3-debug-port.rst
@@ -48,7 +48,7 @@ kernel boot parameter::
 	"earlyprintk=xdbc"
 
 If there are multiple xHCI controllers in your system, you can
-append a host contoller index to this kernel parameter. This
+append a host controller index to this kernel parameter. This
 index starts from 0.
 
 Current design doesn't support DbC runtime suspend/resume. As
diff -- a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
--- a/Documentation/driver-api/dmaengine/client.rst
+++ b/Documentation/driver-api/dmaengine/client.rst
@@ -175,7 +175,7 @@ The details of these operations are:
     driver can ask for the pointer, maximum size and the currently used size of
     the metadata and can directly update or read it.
 
-    Becasue the DMA driver manages the memory area containing the metadata,
+    Because the DMA driver manages the memory area containing the metadata,
     clients must make sure that they do not try to access or get the pointer
     after their transfer completion callback has run for the descriptor.
     If no completion callback has been defined for the transfer, then the
diff -- a/Documentation/driver-api/dmaengine/dmatest.rst b/Documentation/driver-api/dmaengine/dmatest.rst
--- a/Documentation/driver-api/dmaengine/dmatest.rst
+++ b/Documentation/driver-api/dmaengine/dmatest.rst
@@ -89,7 +89,7 @@ The following command returns the state
 
     % cat /sys/module/dmatest/parameters/run
 
-To wait for test completion userpace can poll 'run' until it is false, or use
+To wait for test completion userspace can poll 'run' until it is false, or use
 the wait parameter. Specifying 'wait=1' when loading the module causes module
 initialization to pause until a test run has completed, while reading
 /sys/module/dmatest/parameters/wait waits for any running test to complete
diff -- a/Documentation/driver-api/io-mapping.rst b/Documentation/driver-api/io-mapping.rst
--- a/Documentation/driver-api/io-mapping.rst
+++ b/Documentation/driver-api/io-mapping.rst
@@ -44,7 +44,7 @@ This _wc variant returns a write-combini
 used with mappings created by io_mapping_create_wc()
 
 Temporary mappings are only valid in the context of the caller. The mapping
-is not guaranteed to be globaly visible.
+is not guaranteed to be globally visible.
 
 io_mapping_map_local_wc() has a side effect on X86 32bit as it disables
 migration to make the mapping code work. No caller can rely on this side
@@ -78,7 +78,7 @@ variant, although this may be significan
 				unsigned long offset)
 
 This works like io_mapping_map_atomic/local_wc() except it has no side
-effects and the pointer is globaly visible.
+effects and the pointer is globally visible.
 
 The mappings are released with::
 
diff -- a/Documentation/driver-api/media/drivers/vidtv.rst b/Documentation/driver-api/media/drivers/vidtv.rst
--- a/Documentation/driver-api/media/drivers/vidtv.rst
+++ b/Documentation/driver-api/media/drivers/vidtv.rst
@@ -28,7 +28,7 @@ Currently, it consists of:
   takes parameters at initialization that will dictate how the simulation
   behaves.
 
-- Code reponsible for encoding a valid MPEG Transport Stream, which is then
+- Code responsible for encoding a valid MPEG Transport Stream, which is then
   passed to the bridge driver. This fake stream contains some hardcoded content.
   For now, we have a single, audio-only channel containing a single MPEG
   Elementary Stream, which in turn contains a SMPTE 302m encoded sine-wave.
diff -- a/Documentation/driver-api/media/dtv-demux.rst b/Documentation/driver-api/media/dtv-demux.rst
--- a/Documentation/driver-api/media/dtv-demux.rst
+++ b/Documentation/driver-api/media/dtv-demux.rst
@@ -24,7 +24,7 @@ unless this is fixed in the HW platform.
 
 The demux kABI only controls front-ends regarding to their connections with
 demuxes; the kABI used to set the other front-end parameters, such as
-tuning, are devined via the Digital TV Frontend kABI.
+tuning, are defined via the Digital TV Frontend kABI.
 
 The functions that implement the abstract interface demux should be defined
 static or module private and registered to the Demux core for external
diff -- a/Documentation/driver-api/pin-control.rst b/Documentation/driver-api/pin-control.rst
--- a/Documentation/driver-api/pin-control.rst
+++ b/Documentation/driver-api/pin-control.rst
@@ -836,7 +836,7 @@ hardware and shall be put into different
 
 Depending on the exact HW register design, some functions exposed by the
 GPIO subsystem may call into the pinctrl subsystem in order to
-co-ordinate register settings across HW modules. In particular, this may
+coordinate register settings across HW modules. In particular, this may
 be needed for HW with separate GPIO and pin controller HW modules, where
 e.g. GPIO direction is determined by a register in the pin controller HW
 module rather than the GPIO HW module.
diff -- a/Documentation/driver-api/pldmfw/index.rst b/Documentation/driver-api/pldmfw/index.rst
--- a/Documentation/driver-api/pldmfw/index.rst
+++ b/Documentation/driver-api/pldmfw/index.rst
@@ -20,7 +20,7 @@ Overview of the ``pldmfw`` library
 
 The ``pldmfw`` library is intended to be used by device drivers for
 implementing device flash update based on firmware files following the PLDM
-firwmare file format.
+firmware file format.
 
 It is implemented using an ops table that allows device drivers to provide
 the underlying device specific functionality.
diff -- a/Documentation/driver-api/md/md-cluster.rst b/Documentation/driver-api/md/md-cluster.rst
--- a/Documentation/driver-api/md/md-cluster.rst
+++ b/Documentation/driver-api/md/md-cluster.rst
@@ -65,7 +65,7 @@ There are three groups of locks for mana
 2.3 new-device management
 -------------------------
 
- A single lock: "no-new-dev" is used to co-ordinate the addition of
+ A single lock: "no-new-dev" is used to coordinate the addition of
  new devices - this must be synchronized across the array.
  Normally all nodes hold a concurrent-read lock on this device.
 
diff -- a/Documentation/driver-api/md/raid5-cache.rst b/Documentation/driver-api/md/raid5-cache.rst
--- a/Documentation/driver-api/md/raid5-cache.rst
+++ b/Documentation/driver-api/md/raid5-cache.rst
@@ -81,7 +81,7 @@ The write-through and write-back cache u
 is organized as a simple write log. The log consists of 'meta data' and 'data'
 pairs. The meta data describes the data. It also includes checksum and sequence
 ID for recovery identification. Data can be IO data and parity data. Data is
-checksumed too. The checksum is stored in the meta data ahead of the data. The
+checksummed too. The checksum is stored in the meta data ahead of the data. The
 checksum is an optimization because MD can write meta and data freely without
 worry about the order. MD superblock has a field pointed to the valid meta data
 of log head.
diff -- a/Documentation/driver-api/media/v4l2-subdev.rst b/Documentation/driver-api/media/v4l2-subdev.rst
--- a/Documentation/driver-api/media/v4l2-subdev.rst
+++ b/Documentation/driver-api/media/v4l2-subdev.rst
@@ -321,7 +321,7 @@ response to video node operations. This
 hardware from applications. For complex devices, finer-grained control of the
 device than what the video nodes offer may be required. In those cases, bridge
 drivers that implement :ref:`the media controller API <media_controller>` may
-opt for making the subdevice operations directly accessible from userpace.
+opt for making the subdevice operations directly accessible from userspace.
 
 Device nodes named ``v4l-subdev``\ *X* can be created in ``/dev`` to access
 sub-devices directly. If a sub-device supports direct userspace configuration
@@ -574,7 +574,7 @@ issues with subdevice drivers that let t
 as they expect to receive the appropriate state as a parameter. To help the
 conversion of subdevice drivers to a managed active state without having to
 convert all callers at the same time, an additional wrapper layer has been
-added to v4l2_subdev_call(), which handles the NULL case by geting and locking
+added to v4l2_subdev_call(), which handles the NULL case by getting and locking
 the callee's active state with :c:func:`v4l2_subdev_lock_and_get_active_state()`,
 and unlocking the state after the call.
 
