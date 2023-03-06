Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800B76ACD11
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 19:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjCFSwi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 13:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjCFSwh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 13:52:37 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC824AFC5;
        Mon,  6 Mar 2023 10:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678128755; x=1709664755;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b3/J//9BRvy9p0fhsU2LeJiaZAgIJk+YU5NTytqT8ko=;
  b=G0ZJj+TR8g+j+X/8lENhYABvL3SRi4yvGSF8nRkG6NXyNJQMiiIdd9us
   mwT4NsOfFUS8B4jzgdiXi9XJjKhQ+6BwYZ0VNER4WCXIwiPvpAVPq55CA
   4s+tm/u5ukmUWAnRLAQH6rlFLqMbFK0ZkhTXnh+jlYBlUlZ1StU61swuu
   SG/5yftWom5n0AyMyJTGSEGcLf0PtR+M2PCtB1OZ/PPt4TGf4O/ES6SQj
   sNQSpP7xdvezMH9VxrnAJoKVItpqxCCr3DVENKX8DO09hXABAw/JLNJok
   CsVMAmfo2Fni7K6y50cN02Ugq2ovrbB42Ywz9O76D7yaaknf6gaaitOdJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398227644"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="398227644"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:52:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="626255713"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="626255713"
Received: from jeblanco-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.hsd1.il.comcast.net) ([10.212.118.26])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:52:29 -0800
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH 00/16] crypto: Add Intel Analytics Accelerator (IAA) crypto compression driver
Date:   Mon,  6 Mar 2023 12:52:10 -0600
Message-Id: <20230306185226.26483-1-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

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

Patch 8 ('[PATCH 08/16] crypto: iaa - Add IAA Compression Accelerator
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

Using the simple madvise test program in '[PATCH 09/17] crypto: iaa -
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

Tom Zanussi (14):
  dmaengine: idxd: Export drv_enable/disable and related functions
  dmaengine: idxd: Export descriptor management functions
  dmaengine: idxd: Export wq resource management functions
  dmaengine: idxd: Add private_data to struct idxd_wq
  dmaengine: idxd: add callback support for iaa crypto
  crypto: iaa - Add IAA Compression Accelerator Documentation
  crypto: iaa - Add Intel IAA Compression Accelerator crypto driver core
  crypto: iaa - Add per-cpu workqueue table with rebalancing
  crypto: iaa - Add compression mode management along with fixed mode
  crypto: iaa - Add support for iaa_crypto deflate compression algorithm
  crypto: iaa - Add support for default IAA 'canned' compression mode
  crypto: iaa - Add support for iaa_crypto async deflate compression
    algorithm
  crypto: iaa - Add irq support for the crypto async interface
  crypto: iaa - Add IAA Compression Accelerator stats

 .../ABI/stable/sysfs-driver-dma-idxd          |    6 +
 .../driver-api/crypto/iaa/iaa-crypto.rst      |  743 ++++++
 Documentation/driver-api/crypto/iaa/index.rst |   20 +
 Documentation/driver-api/crypto/index.rst     |   20 +
 Documentation/driver-api/index.rst            |    1 +
 drivers/crypto/Kconfig                        |    1 +
 drivers/crypto/Makefile                       |    1 +
 drivers/crypto/iaa/Kconfig                    |   19 +
 drivers/crypto/iaa/Makefile                   |   12 +
 drivers/crypto/iaa/iaa_crypto.h               |  171 ++
 drivers/crypto/iaa/iaa_crypto_comp_canned.c   |  110 +
 drivers/crypto/iaa/iaa_crypto_comp_fixed.c    |   92 +
 drivers/crypto/iaa/iaa_crypto_main.c          | 2086 +++++++++++++++++
 drivers/crypto/iaa/iaa_crypto_stats.c         |  271 +++
 drivers/crypto/iaa/iaa_crypto_stats.h         |   58 +
 drivers/dma/idxd/bus.c                        |    6 +
 drivers/dma/idxd/cdev.c                       |    8 +
 drivers/dma/idxd/device.c                     |    9 +-
 drivers/dma/idxd/dma.c                        |    9 +-
 drivers/dma/idxd/idxd.h                       |   74 +-
 drivers/dma/idxd/irq.c                        |   12 +-
 drivers/dma/idxd/submit.c                     |    9 +-
 drivers/dma/idxd/sysfs.c                      |   28 +
 include/uapi/linux/idxd.h                     |    1 +
 24 files changed, 3747 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/driver-api/crypto/iaa/iaa-crypto.rst
 create mode 100644 Documentation/driver-api/crypto/iaa/index.rst
 create mode 100644 Documentation/driver-api/crypto/index.rst
 create mode 100644 drivers/crypto/iaa/Kconfig
 create mode 100644 drivers/crypto/iaa/Makefile
 create mode 100644 drivers/crypto/iaa/iaa_crypto.h
 create mode 100644 drivers/crypto/iaa/iaa_crypto_comp_canned.c
 create mode 100644 drivers/crypto/iaa/iaa_crypto_comp_fixed.c
 create mode 100644 drivers/crypto/iaa/iaa_crypto_main.c
 create mode 100644 drivers/crypto/iaa/iaa_crypto_stats.c
 create mode 100644 drivers/crypto/iaa/iaa_crypto_stats.h

-- 
2.34.1

