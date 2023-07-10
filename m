Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE7674DDC1
	for <lists+dmaengine@lfdr.de>; Mon, 10 Jul 2023 21:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjGJTHE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Jul 2023 15:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjGJTHD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Jul 2023 15:07:03 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF97511A;
        Mon, 10 Jul 2023 12:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689016021; x=1720552021;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3t1YrJtx1LM84TgBlU7yV4np51FPVzsNT/dFe4jqLtE=;
  b=Gv6SRFAdHoJqu/2UJ2IrS+li6bCfYT8XhqAn3cWSpaMI9w7nCrxFjiR4
   V1Zvxr4rbLBXv34/K7TP4qlzVRsUN0VwIWHgHpjjUkj+7H6/IRJIcHfOW
   wLM3UCyQJGy52vKDEHL5jT39fqXZD/4XWDNyCiShhXYlYuxvGtOIxaHoD
   AAt+GJdt5cjWwmWHol/5Rgtp5JyB4aDho8SQZ2TB/Zfb8PmjVx29lAPbN
   Asv+JqFVdaQdPbQmvbSGoVIpC2Uq+Lx1TigmUQk0aId5S3M5fk+DrqC3h
   aYT5+zft2BFnEnu2qpeSIpA+D/Y2jNA/1sQwWuXDb7KpFpAnf8q3d3DXu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="354290721"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="354290721"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 12:06:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="844990963"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="844990963"
Received: from jdmillsx-mobl1.amr.corp.intel.com (HELO tzanussi-mobl1.intel.com) ([10.212.107.12])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 12:06:56 -0700
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH v7 00/14] crypto: Add Intel Analytics Accelerator (IAA) crypto compression driver
Date:   Mon, 10 Jul 2023 14:06:40 -0500
Message-Id: <20230710190654.299639-1-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, this is v7 of the IAA crypto driver, incorporating feedback from
v6.

v7 changes:

  - Rebased to current cryptodev tree.

  - Removed 'canned' compression mode (deflate-iaa-canned) and fixed
    up dependencies in other patches and Documentation.
  
  - Removed op_block checks.

  - Removed a stray debugging #ifdef.

  - Changed sysfs-driver-dma-idxd driver_name version to 6.6.0.


v6 changes:

  - Rebased to current cryptodev tree.

  - Changed code to create/register separate algorithms for each
    compression mode - one for 'fixed' (deflate-iaa) and one for
    'canned' (deflate-iaa-canned).
  
  - Got rid of 'compression_mode' attribute and all the compression
    mode code that deals with 'active' compression modes, since
    there's no longer a single active compression mode.

  - Use crypto_ctx to allow common compress/decompress code to
    distinguish between the different compression modes.  Also use it
    to capture settings such as verify_compress, use_irq, etc.  In
    addition to being cleaner, this will allow for easier performance
    comparisons using different modes/settings.

  - Update Documentation and comments to reflect the changes.

  - Fixed a bug found by Rex Zhang in decompress_header() which
    unmapped src2 rather than src as it should have.  Thanks, Rex!


v5 changes:

  - Rebased to current cryptodev tree.

  - Changed sysfs-driver-dma-idxd driver_name version to 6.5.0.

  - Renamed wq private accessor functions to idxd_wq_set/get_private().

v4 changes:

  - Added and used DRIVER_NAME_SIZE for wq driver_name.

  - Changed all spaces to tabs in CRYPTO_DEV_IAA_CRYPTO_STATS config
    menu.

  - Removed the private_data void * from wq and replaced with
    wq_confdev() instead, as suggested by Dave Jiang.

  - Added  more Reviewed-by tags.

v3 changes:

  - Reworked the code to only allow the registered crypto alg to be
    unregistered by removing the module.  Also added an iaa_wq_get()
    and iaa_wq_put() to take/give up a reference to the work queue
    while there are compresses/decompresses in flight.  This is
    synchronized with the wq remove function, so that the
    iaa_wq/iaa_devices can't go away beneath active operations.  This
    was tested by removing/disabling the iaa wqs/devices while
    operations were in flight.

  - Simplified the rebalance code and removed cpu_to_iaa() function
    since it was overly complicated and wasn't actually working as
    advertised.

  - As a result of reworking the above code, fixed several bugs such
    as possibly unregistering an unregistered crypto alg, a memory
    leak where iaa_wqs weren't being freed, and making sure the
    compression schemes were registered before registering the driver.

  - Added set_/idxd_wq_private() accessors for wq private data.

  - Added missing XPORT_SYMBOL_NS_GPL() to [PATCH 04/15] dmaengine:
    idxd: Export descriptor management functions

  - Added Dave's Reviewed-by: tags from v2.

  - Updated Documentation and commit messages to reflect the changes
    above.
  
  - Rebased to to cryptodev tree, since that has the earlier changes
    that moved the intel drivers to crypto/intel.

v2 changes:

  - Removed legacy interface and all related code; merged async
    interface into main deflate patch.

  - Added support for the null destination case.  Thanks to Giovanni
    Cabiddu for making me aware of this as well as the selftests for
    it.

  - Had to do some rearrangement of the code in order to pass all the
    selftests.  Also added a testcase for 'canned'.

  - Moved the iaa crypto driver to drivers/crypto/intel, and moved all
    the other intel drivers there as well (which will be posted as a
    separate series immediately following this one).

  - Added an iaa crypto section to MAINTAINERS.

  - Updated the documenation and commit messages to reflect the removal
    of the legacy interface.

  - Changed kernel version from 6.3.0 to 6.4.0 in patch 01/15 (wq
    driver name support)

v1:

This series adds Linux crypto algorithm support for Intel® In-memory
Analytics Accelerator (Intel IAA) [1] hardware compression and
decompression, which is available on Sapphire Rapids systems.

The IAA crypto support is implemented as an IDXD sub-driver.  The IDXD
driver already present in the kernel provides discovery and management
of the IAA devices on a system, as well as all the functionality
needed to manage, submit, and wait for completion of work executed on
them.  The first 7 patches (patches starting with dmaengine:) add
small bits of underlying IDXD plumbing needed to allow external
sub-drivers to take advantage of this support and claim ownership of
specific IAA devices and workqueues.

The remaining patches add the main support for this feature via the
crypto API, making it transparently accessible to kernel features that
can make use of it such as zswap and zram (patches starting with
crypto – iaa:).

These include both sync/async support for the deflate algorithm
implemented by the IAA hardware, as well as an additional option for
driver statistics and Documentation.

Patch 8 ('[PATCH 08/15] crypto: iaa - Add IAA Compression Accelerator
Documentation') describes the IAA crypto driver in detail; the
following is just a high-level synopsis meant to aid the following
discussion.

The IAA hardware is fairly complex and generally requires a
knowledgeable administrator with sufficiently detailed understanding
of the hardware to set it up before it can be used.  As mentioned in
the Documentation, this typically requires using a special tool called
accel-config to enumerate and configure IAA workqueues, engines, etc,
although this can also be done using only sysfs files.

The operation of the driver mirrors this requirement and only allows
the hardware to be accessed via the crypto layer once the hardware has
been configured and bound to the the IAA crypto driver.  As an IDXD
sub-driver, the IAA crypto driver essentially takes ownership of the
hardware until it is given up explicitly by the administrator.  This
occurs automatically when the administrator enables the first IAA
workqueue or disables the last one; the iaa_crypto (sync and async)
algorithms are registered when the first workqueue is enabled, and
deregistered when the last one is disabled.

The normal sequence of operations would normally be: 

  < configure the hardware using accel-config or sysfs > 

  < configure the iaa crypto driver (see below) > 

  < configure the subsystem e.g. zswap/zram to use the iaa_crypto algo >  

  < run the workload > 

There are a small number of iaa_crypto driver attributes that the
administrator can configure, and which also need to be configured
before the algorithm is enabled:

compression_mode: 

  The IAA crypto driver supports an extensible interface supporting
  any number of different compression modes that can be tailored to
  specific types of workloads.  These are implemented as tables and
  given arbitrary names describing their intent.

  There are currently only 2 compression modes, “canned” and “fixed”.
  In order to set a compression mode, echo the mode’s name to the
  compression_mode driver attribute:
 
    echo "canned" > /sys/bus/dsa/drivers/crypto/compression_mode

There are a few other available iaa_crypto driver attributes (see
Documentation for details) but the main one we want to consider in
detail for now is the ‘sync_mode’ attribute.

The ‘sync_mode’ attribute has 3 possible settings: ‘sync’, ‘async’,
and ‘async_irq’.

The context for these different modes is that although the iaa_crypto
driver implements the asynchronous crypto interface, the async
interface is currently only used in a synchronous way by facilities
like zswap that make use of it.

This is fine for software compress/decompress algorithms, since
there’s no real benefit in being able to use a truly asynchronous
interface with them.  This isn’t the case, though, for hardware
compress/decompress engines such as IAA, where truly asynchronous
behavior is beneficial if not completely necessary to make optimal use
of the hardware.

The IAA crypto driver ‘sync_mode’ support should allow facilities such
as zswap to ‘support async (de)compression in some way [2]’ once
they are modified to actually make use of it.

When the ‘async_irq’ sync_mode is specified, the driver sets the bits
in the IAA work descriptor to generate an irq when the work completes.
So for every compression or decompression, the IAA acomp_alg
implementations called by crypto_acomp_compress/decompress() simply
set up the descriptor, turn on the 'request irq' bit and return
immediately with -EINPROGRESS.  When the work completes, the irq fires
and the IDXD driver’s irq thread for that irq invokes the callback the
iaa_crypto module registered with IDXD.  When the irq thread gets
scheduled, it wakes up the caller, which could be for instance zswap,
waiting synchronously via crypto_wait_req().

Using the simple madvise test program in '[PATCH 08/15] crypto: iaa -
Add IAA Compression Accelerator Documentation' along with a set of
pages from the spec17 benchmark and tracepoint instrumentation
measuring the time taken between the start and end of each compress
and decompress, this case, async_irq, takes on average 6,847 ns for
compression and 5,840 ns for decompression. (See Table 1 below for a
summary of all the tests.)

When sync_mode is set to ‘sync’, the interrupt bit is not set and the
work descriptor is submitted in the same way it was for the previous
case.  In this case the call doesn’t return but rather loops around
waiting in the iaa_crypto driver’s check_completion() function which
continually checks the descriptor’s completion bit until it finds it
set to ‘completed’.  It then returns to the caller, again for example
zswap waiting in crypto_wait_req().  From the standpoint of zswap,
this case is exactly the same as the previous case, the difference
seen only in the crypto layer and the iaa_crypto driver internally;
from its standpoint they’re both synchronous calls.  There is however
a large performance difference: an average of 3,177 ns for compress
and 2,235 ns for decompress.

The final sync_mode is ‘async’.  In this case also the interrupt bit
is not set and the work descriptor is submitted, returning immediately
to the caller with -EINPROGRESS.  Because there’s no interrupt set to
notify anyone when the work completes, the caller needs to somehow
check for work completion.  Because core code like zswap can’t do this
directly by for example calling iaa_crypto’s check_completion(), there
would need to be some changes made to code like zswap and the crypto
layer in order to take advantage of this mode.  As such, there are no
numbers to share for this mode.

Finally, just a quick discussion of the remaining numbers in Table 1,
those comparing the iaa_crypto sync and async irq cases to software
deflate.  Software deflate took average of 108,978 ns for compress and
14,485 ns for decompress.

As can be seen from Table 1, the numbers using the iaa_crypto driver
for deflate as compared to software are so much better that merging it
would seem to make sense on its own merits.  The 'async' sync_mode
described above, however, offers the possibility of even greater gains
to be had against higher-performing algorithms such as lzo, via
parallelization, once the calling facilities are modified to take
advantage of it.  Follow-up patchsets to this one will demonstrate
concretely how that might be accomplished.

Thanks, 

Tom  


  Table 1. Zswap latency and compression numbers (in ns): 

  Algorithm                    compress      decompress
  ----------------------------------------------------------
  iaa sync			3,177		2,235
  iaa async irq   		6,847		5,840
  software deflate	      108,978	       14,485

[1] https://cdrdv2.intel.com/v1/dl/getContent/721858

[2] https://lore.kernel.org/lkml/20201107065332.26992-1-song.bao.hua@hisilicon.com/


Dave Jiang (2):
  dmaengine: idxd: add wq driver name support for accel-config user tool
  dmaengine: idxd: add external module driver support for dsa_bus_type

Tom Zanussi (12):
  dmaengine: idxd: Export drv_enable/disable and related functions
  dmaengine: idxd: Export descriptor management functions
  dmaengine: idxd: Export wq resource management functions
  dmaengine: idxd: Add wq private data accessors
  dmaengine: idxd: add callback support for iaa crypto
  crypto: iaa - Add IAA Compression Accelerator Documentation
  crypto: iaa - Add Intel IAA Compression Accelerator crypto driver core
  crypto: iaa - Add per-cpu workqueue table with rebalancing
  crypto: iaa - Add compression mode management along with fixed mode
  crypto: iaa - Add support for deflate-iaa compression algorithm
  crypto: iaa - Add irq support for the crypto async interface
  crypto: iaa - Add IAA Compression Accelerator stats

 .../ABI/stable/sysfs-driver-dma-idxd          |    6 +
 .../driver-api/crypto/iaa/iaa-crypto.rst      |  645 ++++++
 Documentation/driver-api/crypto/iaa/index.rst |   20 +
 Documentation/driver-api/crypto/index.rst     |   20 +
 Documentation/driver-api/index.rst            |    1 +
 MAINTAINERS                                   |    7 +
 crypto/testmgr.c                              |   10 +
 drivers/crypto/intel/Kconfig                  |    1 +
 drivers/crypto/intel/Makefile                 |    1 +
 drivers/crypto/intel/iaa/Kconfig              |   19 +
 drivers/crypto/intel/iaa/Makefile             |   12 +
 drivers/crypto/intel/iaa/iaa_crypto.h         |  182 ++
 .../crypto/intel/iaa/iaa_crypto_comp_fixed.c  |   92 +
 drivers/crypto/intel/iaa/iaa_crypto_main.c    | 2056 +++++++++++++++++
 drivers/crypto/intel/iaa/iaa_crypto_stats.c   |  271 +++
 drivers/crypto/intel/iaa/iaa_crypto_stats.h   |   58 +
 drivers/dma/idxd/bus.c                        |    6 +
 drivers/dma/idxd/cdev.c                       |    7 +
 drivers/dma/idxd/device.c                     |    9 +-
 drivers/dma/idxd/dma.c                        |    9 +-
 drivers/dma/idxd/idxd.h                       |   84 +-
 drivers/dma/idxd/irq.c                        |   12 +-
 drivers/dma/idxd/submit.c                     |    9 +-
 drivers/dma/idxd/sysfs.c                      |   28 +
 include/uapi/linux/idxd.h                     |    1 +
 25 files changed, 3546 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/driver-api/crypto/iaa/iaa-crypto.rst
 create mode 100644 Documentation/driver-api/crypto/iaa/index.rst
 create mode 100644 Documentation/driver-api/crypto/index.rst
 create mode 100644 drivers/crypto/intel/iaa/Kconfig
 create mode 100644 drivers/crypto/intel/iaa/Makefile
 create mode 100644 drivers/crypto/intel/iaa/iaa_crypto.h
 create mode 100644 drivers/crypto/intel/iaa/iaa_crypto_comp_fixed.c
 create mode 100644 drivers/crypto/intel/iaa/iaa_crypto_main.c
 create mode 100644 drivers/crypto/intel/iaa/iaa_crypto_stats.c
 create mode 100644 drivers/crypto/intel/iaa/iaa_crypto_stats.h

-- 
2.34.1

