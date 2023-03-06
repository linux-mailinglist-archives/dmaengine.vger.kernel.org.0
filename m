Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E846ACD29
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 19:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjCFSxk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 13:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjCFSxT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 13:53:19 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E611572B29;
        Mon,  6 Mar 2023 10:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678128770; x=1709664770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qz/Y7pzaDWJSk/YJ+9MShHfc55gV8C2hlMea4CKzUnM=;
  b=THmCv4w3nMrlnJzpZrHGJ3/F2m4GMyLjfQQIpJMQiHHuNPVZJgD5cAvP
   CzOjWk/xK7tssgknUh6y9tHSzk+OZmopN7wOeoMLiO4a244FtbQsfQ2ma
   2Ug7IZxyKCzt036yZjKBdwwkqb+47OYNm34dlO8zLnsQw1LHaAvW9f9ur
   h+v57XGl6A3mTEbY2In+4rZ8wNH+9VEm/h0NoRBMf6vGHIYWmkDUkggx7
   5R/Uid2A0Xq4yQsptdcplyo1MiVbC+onfbmYBHycPvQ+lJP3lFmmWh70S
   sCWGZ+st1p/IRH2/7nbcjoWBLdtNJyn/SWrruBaMXsYuBhoZPR6fpAIyx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398227740"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="398227740"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:52:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="626255823"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="626255823"
Received: from jeblanco-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.hsd1.il.comcast.net) ([10.212.118.26])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:52:48 -0800
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH 08/16] crypto: iaa - Add IAA Compression Accelerator Documentation
Date:   Mon,  6 Mar 2023 12:52:18 -0600
Message-Id: <20230306185226.26483-9-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230306185226.26483-1-tom.zanussi@linux.intel.com>
References: <20230306185226.26483-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Because the IAA Compression Accelerator requires significant user
setup in order to be used properly, this adds documentation on the
iaa_crypto driver including setup, usage, and examples.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 .../driver-api/crypto/iaa/iaa-crypto.rst      | 743 ++++++++++++++++++
 Documentation/driver-api/crypto/iaa/index.rst |  20 +
 Documentation/driver-api/crypto/index.rst     |  20 +
 Documentation/driver-api/index.rst            |   1 +
 4 files changed, 784 insertions(+)
 create mode 100644 Documentation/driver-api/crypto/iaa/iaa-crypto.rst
 create mode 100644 Documentation/driver-api/crypto/iaa/index.rst
 create mode 100644 Documentation/driver-api/crypto/index.rst

diff --git a/Documentation/driver-api/crypto/iaa/iaa-crypto.rst b/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
new file mode 100644
index 000000000000..13808700bf27
--- /dev/null
+++ b/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
@@ -0,0 +1,743 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================================
+IAA Compression Accelerator Crypto Driver
+=========================================
+
+Tom Zanussi <tom.zanussi@linux.intel.com>
+
+The IAA crypto driver supports compression/decompression compatible
+with the DEFLATE compression standard described in RFC 1951, which is
+the compression/decompression algorithm exported by this module.
+
+The IAA hardware spec can be found here:
+
+  https://cdrdv2.intel.com/v1/dl/getContent/721858
+
+The iaa_crypto driver is designed to work as a layer underneath
+higher-level compression devices such as zswap and zram.
+
+Users can select IAA compress/decompress acceleration by specifying
+'iaa_crypto' as the compression algorithm to use by whatever facility
+allows compression algorithms to be selected.
+
+For example, a zram drive can select iaa_crypto via::
+
+  # echo iaa_crypto > /sys/block/zram1/comp_algorithm
+
+Similarly for zswap::
+
+  # echo iaa_crypto > /sys/module/zswap/parameters/compressor
+
+
+Config options and other setup
+==============================
+
+The IAA crypto driver is available via menuconfig using the following
+path::
+
+  Cryptographic API -> Hardware crypto devices -> Support for Intel(R) IAA Compression Accelerator
+
+In the configuration file the option called CONFIG_CRYPTO_DEV_IAA_CRYPTO.
+
+The IAA crypto driver also supports statistics, which are available
+via menuconfig using the following path::
+
+  Cryptographic API -> Hardware crypto devices -> Support for Intel(R) IAA Compression -> Enable Intel(R) IAA Compression Accelerator Statistics
+
+In the configuration file the option called CONFIG_CRYPTO_DEV_IAA_CRYPTO_STATS.
+
+The following config options should also be enabled::
+
+  CONFIG_IRQ_REMAP=y
+  CONFIG_INTEL_IOMMU=y
+  CONFIG_INTEL_IOMMU_SVM=y
+  CONFIG_PCI_ATS=y
+  CONFIG_PCI_PRI=y
+  CONFIG_PCI_PASID=y
+  CONFIG_INTEL_IDXD=m
+  CONFIG_INTEL_IDXD_SVM=y
+
+IAA is one of the first Intel accelerator IPs that can work in
+conjunction with the Intel IOMMU.  There are multiple modes that exist
+for testing. Based on IOMMU configuration, there are 3 modes::
+
+  - Scalable
+  - Legacy
+  - No IOMMU
+
+
+Scalable mode
+-------------
+
+Scalable mode supports Shared Virtual Memory (SVM or SVA). It is
+entered when using the kernel boot commandline::
+
+  intel_iommu=on,sm_on
+
+with VT-d turned on in BIOS.
+
+With scalable mode, both shared and dedicated workqueues are available
+for use.
+
+For scalable mode, the following BIOS settings should be enabled::
+
+  Socket Configuration > IIO Configuration > Intel VT for Directed I/O (VT-d) > Intel VT for Directed I/O
+
+  Socket Configuration > IIO Configuration > PCIe ENQCMD > ENQCMDS
+
+
+Legacy mode
+-----------
+
+Legacy mode is entered when using the kernel boot commandline::
+
+  intel_iommu=off, intel_iommu=on
+
+or VT-d is not turned on in BIOS.
+
+If you have booted into Linux and not sure if VT-d is on, do a "dmesg
+| grep -i dmar". If you don't see a number of DMAR devices enumerated,
+most likely VT-d is not on.
+
+With legacy mode, only dedicated workqueues are available for use.
+
+
+No IOMMU mode
+-------------
+
+No IOMMU mode is entered when using the kernel boot commandline::
+
+  iommu=off.
+
+With no IOMMU mode, only dedicated workqueues are available for use.
+
+
+Usage
+=====
+
+accel-config
+------------
+
+Unlike typical drivers, the iaa_crypto driver does not enable the
+device on driver load.  Due to complexity and configurability of the
+accelerator devices, it was a design decision to have the user
+configure the device and manually enable the desired devices and
+workqueues.
+
+The userspace tool to help doing that is called accel-config.  Using
+accel-config to configure device or loading a previously saved config
+is highly recommended.  The device can be controlled via sysfs
+directly but comes with the warning that do this ONLY if you know
+exactly what you are doing.  This document will not cover the sysfs
+interface but assumes you will be using accel-config.
+
+The accel-config tool along with instructions for building it can be
+found here:
+
+  https://github.com/intel/idxd-config/#readme
+
+
+Typical usage
+-------------
+
+In order for the iaa_crypto module to actually do any
+compression/decompression work on behalf of a facility, one or more
+IAA workqueues need to be bound to the iaa_crypto driver.
+
+For instance, here's an example of configuring an IAA workqueue and
+binding it to the iaa_crypto driver (note that device names are
+specified as 'iax' rather than 'iaa' - this is because upstream still
+has the old 'iax' device naming in place) ::
+
+  # configure wq1.0
+
+  accel-config config-wq --group-id=0 --mode=shared --type=kernel --name="iaa_crypto" --device_name="crypto" iax1/wq1.0
+
+  # enable IAA device iax1
+
+  accel-config enable-device iax1
+
+  # enable wq1.0 on IAX device iax1
+
+  accel-config enable-wq iax1/wq1.0
+
+Whenever a new workqueue is bound to or unbound from the iaa_crypto
+driver, the available workqueues are 'rebalanced' such that work
+submitted from a particular CPU is given to the most appropriate
+workqueue available.  Current best practice is to configure and bind
+at least one workqueue for each IAA device, but as long as there is at
+least one workqueue configured and bound to any IAA device in the
+system, the iaa_crypto driver will work, albeit most likely not as
+efficiently.
+
+The IAA crypto algorigthms is operational and compression and
+decompression operations are fully enabled following the successful
+binding of the first IAA workqueue to the iaa_crypto driver, and
+similarly, the IAA crypto algorithm is automatically unregistered when
+there are no IAA workqueues bound to the driver, following their
+removal.
+
+As a result, the iaa_crypto crypto algorithm and thus the IAA hardware
+are only available when one or more workques are bound to the
+iaa_crypto driver.
+
+Driver attributes
+-----------------
+
+There are a few user-configurable driver attributes that can be used
+to configure various modes of operation.  They're listed below, along
+with their default values.  To set any of these attributes, echo the
+appropriate values to the attribute file located under
+/sys/bus/dsa/drivers/crypto/
+
+  - verify_compress
+
+    Toggle compression verification.  If set, each compress will be
+    internally decompressed and the contents verified, returning error
+    codes if unsuccessful.  This can be toggled with 0/1:
+
+      echo 0 > /sys/bus/dsa/drivers/crypto/verify_compress
+
+    The default setting is '1' - verify all compresses.
+
+  - compression_mode
+
+    Select compression mode to be used by all compresses and
+    decompresses.  There are a number ofcompression modes available,
+    each identified by a unique string.  These can be selected by
+    echoing the string to the 'compression_mode' driver attribute.
+    Currently, there are only two compression modes available,
+    'canned' and 'fixed' modes.
+
+    The 'fixed' compression mode implements the compression scheme
+    specified by RFC 1951.
+
+    The 'canned' compression mode implements a good general-purpose
+    compression scheme whose tables were generated from statistics
+    derived from a wide variety of SPEC17 workloads.  It provides much
+    better overall characteristics than the existing deflate-1951
+    tables implemented by 'fixed'.
+
+    Either 'fixed' or 'canned' modes can be chosen as the mode to be used
+    for compression/decompression via the iaa_crypto compression_mode
+    iaa_crypto driver attribute:
+
+      echo "canned" >  /sys/bus/dsa/drivers/crypto/compression_mode
+
+    The default setting is 'fixed'.
+
+  - sync_mode
+
+    Select mode to be used to wait for completion of each compresses
+    and decompress operation.
+
+    The crypto async interface support implemented by iaa_crypto
+    provides an implementation that satisfies the interface but does
+    so in a synchronous manner - it fills and submits the IDXD
+    descriptor and then loops around waiting for it to complete before
+    returning.  This isn't a problem at the moment, since all existing
+    callers (e.g. zswap) wrap any asynchronous callees in a
+    synchronous wrapper anyway.
+
+    The iaa_crypto driver does however provide true asynchronous
+    support for callers that can make use of it.  In this mode, it
+    fills and submits the IDXD descriptor, then returns immediately
+    with -EINPROGRESS.  The caller can then either poll for completion
+    itself, which requires specific code in the caller which currently
+    nothing in the upstream kernel implements, or go to sleep and wait
+    for an interrupt signaling completion.  This latter mode is
+    supported by current users in the kernel such as zswap via
+    synchronous wrappers.  Although it is supported this mode is
+    significantly slower than the synchronous mode that does the
+    polling in the iaa_crypto driver previously mentioned.
+
+    This mode can be enabled by writing 'async_irq' to the sync_mode
+    iaa_crypto driver attribute:
+
+      echo async_irq > /sys/bus/dsa/drivers/crypto/sync_mode
+
+    Async mode without interrupts (caller must poll) can be enabled by
+    writing 'async' to it:
+
+      echo async > /sys/bus/dsa/drivers/crypto/sync_mode
+
+    The mode that does the polling in the iaa_crypto driver can be
+    enabled by writing 'sync' to it:
+
+      echo sync > /sys/bus/dsa/drivers/crypto/sync_mode
+
+    The default mode is 'sync'.
+
+
+Statistics
+==========
+
+If the optional debugfs statistics support is enabled, the IAA crypto
+driver will generate statistics which can be accessed in debugfs at::
+
+  # ls -al /sys/kernel/debug/iaa-crypto/
+  total 0
+  drwxr-xr-x  2 root root 0 Mar  3 09:35 .
+  drwx------ 47 root root 0 Mar  3 09:35 ..
+  -rw-r--r--  1 root root 0 Mar  3 09:35 max_acomp_delay_ns
+  -rw-r--r--  1 root root 0 Mar  3 09:35 max_adecomp_delay_ns
+  -rw-r--r--  1 root root 0 Mar  3 09:35 max_comp_delay_ns
+  -rw-r--r--  1 root root 0 Mar  3 09:35 max_decomp_delay_ns
+  -rw-r--r--  1 root root 0 Mar  3 09:35 stats_reset
+  -rw-r--r--  1 root root 0 Mar  3 09:35 total_comp_bytes_out
+  -rw-r--r--  1 root root 0 Mar  3 09:35 total_comp_calls
+  -rw-r--r--  1 root root 0 Mar  3 09:35 total_decomp_bytes_in
+  -rw-r--r--  1 root root 0 Mar  3 09:35 total_decomp_calls
+  -rw-r--r--  1 root root 0 Mar  3 09:35 wq_stats
+
+Most of the above statisticss are self-explanatory.  The wq_stats file
+shows per-wq stats, a set for each iaa device and wq in addition to
+some global stats::
+
+  # cat wq_stats
+  global stats:
+    total_comp_calls: 100
+    total_decomp_calls: 100
+    total_comp_bytes_out: 22800
+    total_decomp_bytes_in: 22800
+    total_completion_einval_errors: 0
+    total_completion_timeout_errors: 0
+    total_completion_comp_buf_overflow_errors: 0
+
+  iaa device:
+    id: 1
+    n_wqs: 1
+    comp_calls: 0
+    comp_bytes: 0
+    decomp_calls: 0
+    decomp_bytes: 0
+    wqs:
+      name: iaa_crypto
+      comp_calls: 0
+      comp_bytes: 0
+      decomp_calls: 0
+      decomp_bytes: 0
+
+  iaa device:
+    id: 3
+    n_wqs: 1
+    comp_calls: 0
+    comp_bytes: 0
+    decomp_calls: 0
+    decomp_bytes: 0
+    wqs:
+      name: iaa_crypto
+      comp_calls: 0
+      comp_bytes: 0
+      decomp_calls: 0
+      decomp_bytes: 0
+
+  iaa device:
+    id: 5
+    n_wqs: 1
+    comp_calls: 100
+    comp_bytes: 22800
+    decomp_calls: 100
+    decomp_bytes: 22800
+    wqs:
+      name: iaa_crypto
+      comp_calls: 100
+      comp_bytes: 22800
+      decomp_calls: 100
+      decomp_bytes: 22800
+
+Writing 0 to 'stats_reset' resets all the stats, including the
+per-device and per-wq stats::
+
+  # echo 0 > stats_reset
+  # cat wq_stats
+    global stats:
+    total_comp_calls: 0
+    total_decomp_calls: 0
+    total_comp_bytes_out: 0
+    total_decomp_bytes_in: 0
+    total_completion_einval_errors: 0
+    total_completion_timeout_errors: 0
+    total_completion_comp_buf_overflow_errors: 0
+    ...
+
+
+Use cases
+=========
+
+Simple zram test
+----------------
+
+For this example, the kernel should be configured according to the
+scalable mode options described above, and zram should be enabled as
+well::
+
+  CONFIG_ZRAM=m
+  CONFIG_ZSMALLOC=m
+  CONFIG_ZSMALLOC_STAT=y
+  CONFIG_ZRAM_WRITEBACK=y
+
+This is a simple test that uses iaa_compress as the compressor for a
+zram filesystem. It simply copies a file to an iaa_compressed zram
+disk and then copies it back, to demonstrate both compress and
+decompress.
+
+The first step is to make sure the iaa_crypto module is loaded::
+
+  modprobe iaa_crypto
+
+Following that the IAA device(s) should be configured and enabled.
+
+The zram test expects the work queues for each IAA device on the
+system to be configured properly as a kernel workqueue with a
+workqueue driver_name of "crypto".
+
+The below script automatically does that::
+
+  #!/bin/bash
+
+  echo "IAA devices:"
+  lspci -d:0cfe
+  echo "# IAA devices:"
+  lspci -d:0cfe | wc -l
+
+  #
+  # count iaa instances
+  #
+  iaa_dev_id="0cfe"
+  num_iaa=$(lspci -d:${iaa_dev_id} | wc -l)
+  echo "Found ${num_iaa} IAA instances"
+
+  #
+  # disable iaa wqs and devices
+  #
+  echo "Disable IAA"
+
+  for ((i = 1; i < ${num_iaa} * 2; i += 2)); do
+      echo disable wq iax${i}/wq${i}.0
+      accel-config disable-wq iax${i}/wq${i}.0
+      echo disable iaa iax${i}
+      accel-config disable-device iax${i}
+  done
+
+  echo "End Disable IAA"
+
+  #
+  # configure iaa wqs and devices
+  #
+  echo "Configure IAA"
+  for ((i = 1; i < ${num_iaa} * 2; i += 2)); do
+      accel-config config-wq --group-id=0 --mode=shared --size=128 --priority=10 --type=kernel --name="iaa_crypto" --device_name="crypto" --threshold=10 iax${i}/wq${i}
+  done
+
+  echo "End Configure IAA"
+
+  #
+  # enable iaa wqs and devices
+  #
+  echo "Enable IAA"
+
+  for ((i = 1; i < ${num_iaa} * 2; i += 2)); do
+      echo enable iaa iaa${i}
+      accel-config enable-device iaa${i}
+      echo enable wq iaa${i}/wq${i}.0
+      accel-config enable-wq iaa${i}/wq${i}.0
+  done
+
+  echo "End Enable IAA"
+
+When the workqueues are bound to the iaa_crypto driver, you should
+see something similar to the following in dmesg output if you've
+enabled debug output (echo -n 'module iaa_crypto +p' >
+/sys/kernel/debug/dynamic_debug/control)::
+
+  [   60.752344] idxd 0000:f6:02.0: add_iaa_wq: added wq 000000004068d14d to iaa 00000000c9585ba2, n_wq 1
+  [   60.752346] iaa_crypto: rebalance_wq_table: nr_nodes=2, nr_cpus 160, nr_iaa 8, cpus_per_iaa 20
+  [   60.752347] iaa_crypto: rebalance_wq_table: iaa=0
+  [   60.752349] idxd 0000:6a:02.0: request_iaa_wq: getting wq from iaa_device 0000000042d7bc52 (0)
+  [   60.752350] idxd 0000:6a:02.0: request_iaa_wq: returning unused wq 00000000c8bb4452 (0) from iaa device 0000000042d7bc52 (0)
+  [   60.752352] iaa_crypto: rebalance_wq_table: assigned wq for cpu=0, node=0 = wq 00000000c8bb4452
+  [   60.752354] iaa_crypto: rebalance_wq_table: iaa=0
+  [   60.752355] idxd 0000:6a:02.0: request_iaa_wq: getting wq from iaa_device 0000000042d7bc52 (0)
+  [   60.752356] idxd 0000:6a:02.0: request_iaa_wq: returning unused wq 00000000c8bb4452 (0) from iaa device 0000000042d7bc52 (0)
+  [   60.752358] iaa_crypto: rebalance_wq_table: assigned wq for cpu=1, node=0 = wq 00000000c8bb4452
+  [   60.752359] iaa_crypto: rebalance_wq_table: iaa=0
+  [   60.752360] idxd 0000:6a:02.0: request_iaa_wq: getting wq from iaa_device 0000000042d7bc52 (0)
+  [   60.752361] idxd 0000:6a:02.0: request_iaa_wq: returning unused wq 00000000c8bb4452 (0) from iaa device 0000000042d7bc52 (0)
+  [   60.752362] iaa_crypto: rebalance_wq_table: assigned wq for cpu=2, node=0 = wq 00000000c8bb4452
+  [   60.752364] iaa_crypto: rebalance_wq_table: iaa=0
+  .
+  .
+  .
+
+Once the workqueues and devices have been enabled, the iaa_crypto
+algorithm is enabled and available.  When the iaa_crypto algorithm has
+been successfully enabled, you should see the following dmesg output::
+
+  [   64.893759] iaa_crypto: iaa_crypto_enable: iaa_crypto now ENABLED
+
+Now that the iaa_crypto module is ready to go, we can set up
+zram. Start by setting up a few vm params::
+
+  echo 100 > /proc/sys/vm/swappiness
+  echo never > /sys/kernel/mm/transparent_hugepage/enabled
+  echo 1 > /proc/sys/vm/overcommit_memory
+
+Next, insert the zram module for 1 device and configure the new
+/dev/zram1 to use iaa_crypto as the compression algorithm::
+
+  modprobe zram num_devices=1
+
+  echo iaa_crypto > /sys/block/zram1/comp_algorithm
+  echo 32G > /sys/block/zram1/disksize
+  echo 32G > /sys/block/zram1/mem_limit
+
+Now create an ext4 filesytem on /dev/zram1 and mount it::
+
+  mkfs.ext4 /dev/zram1
+  mount /dev/zram1 /tmp
+
+Now that our /tmp filesystem is set up and using iaa_crypto for
+compress/decompress, copy a big file to /tmp::
+
+  cp -f somebigfile.txt /tmp; sync
+
+You should see something like the following in the dmesg output if
+you've enabled debug output (echo -n 'module iaa_crypto +p' >
+/sys/kernel/debug/dynamic_debug/control)::
+
+  [  836.226331] idxd 0000:6f:02.0: iaa_comp_compress: dma_map_single, src_addr 2cdffb000, dev 0000000063891379, src 000000004d193d53, slen 4096
+  [  836.226333] idxd 0000:6f:02.0: iaa_comp_compress: dma_map_single, dst_addr 281182000, dev 0000000063891379, dst 0000000014a9f578, *dlen 8192
+  [  836.226335] idxd 0000:6f:02.0: iaa_comp_compress: src 000000004d193d53, src_addr 2cdffb000, slen 4096, dst 0000000014a9f578, dst_addr 281182000, dlen 8192
+  [  836.226337] idxd 0000:6f:02.0: iaa_compress: desc->src1_addr 2cdffb000, desc->src1_size 4096, desc->dst_addr 281182000, desc->max_dst_size 8192, desc->src2_addr 28270a000, desc->src2_size 1568
+  [  836.226344] idxd 0000:6f:02.0: iaa_compress_verify: (verify) desc->src1_addr 281182000, desc->src1_size 468, desc->dst_addr 2cdffb000, desc->max_dst_size 4096, desc->src2_addr 0, desc->src2_size 0
+  [  836.226381] idxd 0000:6f:02.0: iaa_comp_compress: dma_map_single, src_addr 280367000, dev 0000000063891379, src 00000000b72795f1, slen 4096
+  [  836.226383] idxd 0000:6f:02.0: iaa_comp_compress: dma_map_single, dst_addr 281182000, dev 0000000063891379, dst 0000000014a9f578, *dlen 8192
+  [  836.226385] idxd 0000:6f:02.0: iaa_comp_compress: src 00000000b72795f1, src_addr 280367000, slen 4096, dst 0000000014a9f578, dst_addr 281182000, dlen 8192
+  [  836.226388] idxd 0000:6f:02.0: iaa_compress: desc->src1_addr 280367000, desc->src1_size 4096, desc->dst_addr 281182000, desc->max_dst_size 8192, desc->src2_addr 28270a000, desc->src2_size 1568
+  [  836.226394] idxd 0000:6f:02.0: iaa_compress_verify: (verify) desc->src1_addr 281182000, desc->src1_size 285, desc->dst_addr 280367000, desc->max_dst_size 4096, desc->src2_addr 0, desc->src2_size 0
+
+To see the file decompress (again, turn on debug output in the
+kernel)::
+
+  sync; echo 3 > /proc/sys/vm/drop_caches; sync
+  cat /tmp/somebigfile.txt
+
+You should see something like the following in the dmesg output if
+you've enabled debug output (echo -n 'module iaa_crypto +p' >
+/sys/kernel/debug/dynamic_debug/control)::
+
+  [  929.394416] idxd 0000:74:02.0: iaa_comp_decompress: using wq for cpu=81 = wq 000000007e629f8f
+  [  929.394417] idxd 0000:74:02.0: iaa_comp_decompress: dma_map_single, src_addr 272a58008, dev 000000002bf7270d, src 000000007e580802, slen 1564
+  [  929.394418] idxd 0000:74:02.0: iaa_comp_decompress: dma_map_single, dst_addr 274bbe000, dev 000000002bf7270d, dst 0000000037de3d04, *dlen 4096
+  [  929.394420] idxd 0000:74:02.0: iaa_comp_decompress: src 000000007e580802, src_addr 272a58008, slen 1564, dst 0000000037de3d04, dst_addr 274bbe000, dlen 4096
+  [  929.394421] idxd 0000:74:02.0: iaa_decompress: desc->src1_addr 272a58008, desc->src1_size 1564, desc->dst_addr 274bbe000, desc->max_dst_size 4096, desc->src2_addr 0, desc->src2_size 0
+  [  929.394427] idxd 0000:74:02.0: iaa_comp_decompress: using wq for cpu=81 = wq 000000007e629f8f
+  [  929.394428] idxd 0000:74:02.0: iaa_comp_decompress: dma_map_single, src_addr 2b8539008, dev 000000002bf7270d, src 0000000021939c1e, slen 849
+  [  929.394430] idxd 0000:74:02.0: iaa_comp_decompress: dma_map_single, dst_addr 2b89b7000, dev 000000002bf7270d, dst 00000000850a85fa, *dlen 4096
+  [  929.394431] idxd 0000:74:02.0: iaa_comp_decompress: src 0000000021939c1e, src_addr 2b8539008, slen 849, dst 00000000850a85fa, dst_addr 2b89b7000, dlen 4096
+  [  929.394433] idxd 0000:74:02.0: iaa_decompress: desc->src1_addr 2b8539008, desc->src1_size 849, desc->dst_addr 2b89b7000, desc->max_dst_size 4096, desc->src2_addr 0, desc->src2_size 0
+
+When finished, disable the device(s), and remove the zram and
+iaa_crypto modules::
+
+  umount -f /dev/zram1
+  echo 0 > /sys/class/zram-control/hot_remove
+
+  rmmod zram
+  rmmod iaa_crypto
+
+
+Simple zswap test
+-----------------
+
+For this example, the kernel should be configured according to the
+scalable mode options described above, and zswap should be enabled as
+well::
+
+  CONFIG_ZSWAP=y
+
+This is a simple test that uses iaa_compress as the compressor for a
+swap (zswap) device.  It sets up the zswap device and then uses the
+memory_memadvice program listed below to forcibly swap out and in a
+specified number of pages, demonstrating both compress and decompress.
+
+The zswap test expects the work queues for each IAA device on the
+system to be configured properly as a kernel workqueue with a
+workqueue driver_name of "crypto".
+
+The first step is to make sure the iaa_crypto module is loaded::
+
+  modprobe iaa_crypto
+
+Following that the IAA device(s) should be configured and enabled.
+
+Repeat the above steps but instead of the zram setup following the iaa
+device/workqueue setup script, run the following zswap-specific setup
+commands. For zswap, CONFIG_ZSWAP=y should be enabled as well:
+
+The below script automatically does that::
+
+  #!/bin/bash
+
+  echo "IAA devices:"
+  lspci -d:0cfe
+  echo "# IAA devices:"
+  lspci -d:0cfe | wc -l
+
+  #
+  # count iaa instances
+  #
+  iaa_dev_id="0cfe"
+  num_iaa=$(lspci -d:${iaa_dev_id} | wc -l)
+  echo "Found ${num_iaa} IAA instances"
+
+  #
+  # disable iaa wqs and devices
+  #
+  echo "Disable IAA"
+
+  for ((i = 1; i < ${num_iaa} * 2; i += 2)); do
+      echo disable wq iax${i}/wq${i}.0
+      accel-config disable-wq iax${i}/wq${i}.0
+      echo disable iaa iax${i}
+      accel-config disable-device iax${i}
+  done
+
+  echo "End Disable IAA"
+
+  #
+  # configure iaa wqs and devices
+  #
+  echo "Configure IAA"
+  for ((i = 1; i < ${num_iaa} * 2; i += 2)); do
+      accel-config config-wq --group-id=0 --mode=shared --size=128 --priority=10 --type=kernel --name="iaa_crypto" --device_name="crypto" --threshold=10 iax${i}/wq${i}
+  done
+
+  echo "End Configure IAA"
+
+  #
+  # enable iaa wqs and devices
+  #
+  echo "Enable IAA"
+
+  for ((i = 1; i < ${num_iaa} * 2; i += 2)); do
+      echo enable iaa iaa${i}
+      accel-config enable-device iaa${i}
+      echo enable wq iaa${i}/wq${i}.0
+      accel-config enable-wq iaa${i}/wq${i}.0
+  done
+
+  echo "End Enable IAA"
+
+When the iaa_crypto algorithm has been successfully enabled, you
+should see the following dmesg output::
+
+  [  196.377326] iaa_crypto: iaa_crypto_enable: iaa_crypto now ENABLED
+
+Now run the following zswap-specific setup commands::
+
+  echo 0 > /sys/module/zswap/parameters/enabled
+  echo 50 > /sys/module/zswap/parameters/max_pool_percent
+  echo iaa_crypto > /sys/module/zswap/parameters/compressor
+  echo zsmalloc > /sys/module/zswap/parameters/zpool
+  echo 1 > /sys/module/zswap/parameters/enabled
+  echo 0 > /sys/module/zswap/parameters/same_filled_pages_enabled
+
+  echo 100 > /proc/sys/vm/swappiness
+  echo never > /sys/kernel/mm/transparent_hugepage/enabled
+  echo 1 > /proc/sys/vm/overcommit_memory
+
+Finally, you can now run the zswap workload you want to measure. For
+example, using the code below, the following command will swap in and
+out 100 pages::
+
+  ./memory_madvise 100
+
+  Allocating 100 pages to swap in/out
+  Swapping out 100 pages
+  Swapping in 100 pages
+  Swapped out and in 100 pages
+
+You should see something like the following in the dmesg output if
+you've enabled debug output (echo -n 'module iaa_crypto +p' >
+/sys/kernel/debug/dynamic_debug/control)::
+
+  [  404.202972] idxd 0000:e7:02.0: iaa_comp_acompress: dma_map_sg, src_addr 223925c000, nr_sgs 1, req->src 00000000ee7cb5e6, req->slen 4096, sg_dma_len(sg) 4096
+  [  404.202973] idxd 0000:e7:02.0: iaa_comp_acompress: dma_map_sg, dst_addr 21dadf8000, nr_sgs 1, req->dst 000000008d6acea8, req->dlen 4096, sg_dma_len(sg) 8192
+  [  404.202975] idxd 0000:e7:02.0: iaa_compress: desc->src1_addr 223925c000, desc->src1_size 4096, desc->dst_addr 21dadf8000, desc->max_dst_size 4096, desc->src2_addr 2203543000, desc->src2_size 1568
+  [  404.202981] idxd 0000:e7:02.0: iaa_compress_verify: (verify) desc->src1_addr 21dadf8000, desc->src1_size 228, desc->dst_addr 223925c000, desc->max_dst_size 4096, desc->src2_addr 0, desc->src2_size 0
+  [  409.203227] idxd 0000:e7:02.0: iaa_comp_adecompress: dma_map_sg, src_addr 21ddd8b100, nr_sgs 1, req->src 0000000084adab64, req->slen 228, sg_dma_len(sg) 228
+  [  409.203235] idxd 0000:e7:02.0: iaa_comp_adecompress: dma_map_sg, dst_addr 21ee3dc000, nr_sgs 1, req->dst 000000004e2990d0, req->dlen 4096, sg_dma_len(sg) 4096
+  [  409.203239] idxd 0000:e7:02.0: iaa_decompress: desc->src1_addr 21ddd8b100, desc->src1_size 228, desc->dst_addr 21ee3dc000, desc->max_dst_size 4096, desc->src2_addr 0, desc->src2_size 0
+  [  409.203254] idxd 0000:e7:02.0: iaa_comp_adecompress: dma_map_sg, src_addr 21ddd8b100, nr_sgs 1, req->src 0000000084adab64, req->slen 228, sg_dma_len(sg) 228
+  [  409.203256] idxd 0000:e7:02.0: iaa_comp_adecompress: dma_map_sg, dst_addr 21f1551000, nr_sgs 1, req->dst 000000004e2990d0, req->dlen 4096, sg_dma_len(sg) 4096
+  [  409.203257] idxd 0000:e7:02.0: iaa_decompress: desc->src1_addr 21ddd8b100, desc->src1_size 228, desc->dst_addr 21f1551000, desc->max_dst_size 4096, desc->src2_addr 0, desc->src2_size 0
+
+memory_madvise.c (gcc -o memory_memadvise memory_madvise.c)::
+
+  #include <stdio.h>
+  #include <stdlib.h>
+  #include <string.h>
+  #include <unistd.h>
+  #include <sys/mman.h>
+  #include <linux/mman.h>
+
+  #ifndef MADV_PAGEOUT
+  #define MADV_PAGEOUT    21      /* force pages out immediately */
+  #endif
+
+  #define PG_SZ           4096
+
+  int main(int argc, char **argv)
+  {
+        int i, nr_pages = 1;
+        int64_t *dump_ptr;
+        char *addr, *a;
+        int loop = 1;
+
+        if (argc > 1)
+                nr_pages = atoi(argv[1]);
+
+        printf("Allocating %d pages to swap in/out\n", nr_pages);
+
+        /* allocate pages */
+        addr = mmap(NULL, nr_pages * PG_SZ, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+        *addr = 1;
+
+        /* initialize data in page to all '*' chars */
+        memset(addr, '*', nr_pages * PG_SZ);
+
+         printf("Swapping out %d pages\n", nr_pages);
+
+        /* Tell kernel to swap it out */
+        madvise(addr, nr_pages * PG_SZ, MADV_PAGEOUT);
+
+        while (loop > 0) {
+                /* Wait for swap out to finish */
+                sleep(5);
+
+                a = addr;
+
+                printf("Swapping in %d pages\n", nr_pages);
+
+                /* Access the page ... this will swap it back in again */
+                for (i = 0; i < nr_pages; i++) {
+                        if (a[0] != '*') {
+                                printf("Bad data from decompress!!!!!\n");
+
+                                dump_ptr = (int64_t *)a;
+                                 for (int j = 0; j < 100; j++) {
+                                        printf("  page %d data: %#llx\n", i, *dump_ptr);
+                                        dump_ptr++;
+                                }
+                        }
+
+                        a += PG_SZ;
+                }
+
+                loop --;
+        }
+
+       printf("Swapped out and in %d pages\n", nr_pages);
diff --git a/Documentation/driver-api/crypto/iaa/index.rst b/Documentation/driver-api/crypto/iaa/index.rst
new file mode 100644
index 000000000000..aa6837e27264
--- /dev/null
+++ b/Documentation/driver-api/crypto/iaa/index.rst
@@ -0,0 +1,20 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================================
+IAA (Intel Analytics Accelerator)
+=================================
+
+IAA provides hardware compression and decompression via the crypto
+API.
+
+.. toctree::
+   :maxdepth: 1
+
+   iaa-crypto
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/driver-api/crypto/index.rst b/Documentation/driver-api/crypto/index.rst
new file mode 100644
index 000000000000..fb9709b98bea
--- /dev/null
+++ b/Documentation/driver-api/crypto/index.rst
@@ -0,0 +1,20 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============
+Crypto Drivers
+==============
+
+Documentation for crypto drivers that may need more involved setup and
+configuration.
+
+.. toctree::
+   :maxdepth: 1
+
+   iaa/index
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index ff9aa1afdc62..2ad1237d5d5f 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -113,6 +113,7 @@ available subsections can be seen below.
    xillybus
    zorro
    hte/index
+   crypto/index
 
 .. only::  subproject and html
 
-- 
2.34.1

