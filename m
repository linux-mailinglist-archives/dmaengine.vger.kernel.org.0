Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4341EB185
	for <lists+dmaengine@lfdr.de>; Tue,  2 Jun 2020 00:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgFAWJt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 Jun 2020 18:09:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:14332 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728216AbgFAWJt (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 1 Jun 2020 18:09:49 -0400
IronPort-SDR: OmzUdPgYKxV0cdIpmpnSPx5NitXXJUsmh39dcJLgI91vZJUSzLAukjCruhjNJlHe6/dOhODcQO
 2pgo7/5+DQMA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 15:09:48 -0700
IronPort-SDR: sUumJ0VgGRtZTVt9P3HLsMnP6pZDuBTCtCYYDqxkNxI9Y5oEam8LIoybQoiyNdSRvyOZSHIZq4
 44bOdemssgYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,462,1583222400"; 
   d="scan'208";a="347190913"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.251.235.125]) ([10.251.235.125])
  by orsmga001.jf.intel.com with ESMTP; 01 Jun 2020 15:09:45 -0700
Subject: Re: [PATCH v2 0/9] Add shared workqueue support for idxd driver
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, dan.j.williams@intel.com, ashok.raj@intel.com,
        fenghua.yu@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        sanjay.k.kumar@intel.com, dave.hansen@intel.com
References: <158982749959.37989.2096629611303670415.stgit@djiang5-desk3.ch.intel.com>
Message-ID: <95eb8203-a332-37ae-28fb-5a2af4d1daba@intel.com>
Date:   Mon, 1 Jun 2020 15:09:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <158982749959.37989.2096629611303670415.stgit@djiang5-desk3.ch.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Vinod,
Obviously this series won't make it for 5.8 due to being blocked by Fenghua's 
PASID series. Do you think you can take patches 4 and 5 independently? I think 
these can go into 5.8 and is not dependent on anything. Thanks.

On 5/18/2020 11:53 AM, Dave Jiang wrote:
> v2:
> - Dropped device feature enabling (GregKH)
> - Dropped PCI device feature enabling (Bjorn)
> 	- https://members.pcisig.com/wg/PCI-SIG/document/14237
> 	- After some internal discussion, we have decided to hold off on the
> 	  enabling of DMWR due to the following reasons. 1. Most first gen hw
> 	  will not have the feature bits. 2. First gen hw that support the
> 	  feature are all Root Complex integrated endpoints. 3. PCI devices
> 	  that are not RCiEP’s with this capability won’t surface for a few
> 	  years so we can wait until we can test the full code.
> - Dropped special ioremap (hch)
> - Added proper support for WQ flush (tony, dan)
> - Changed descriptor submission to use sbitmap_queue for blocking. (dan)
> - Split out MOBDIR64B to right location for ENQCMDS placement. (daveh)
> - Split out SVM kernel dependencies for driver. (daveh)
> - Call enqcmds() directly (daveh)
> - Fix enqcmds() commit log (daveh)
> - Split out fault processing code (tony)
> 
> Driver stage 1 postings for context: [1]
> 
> The patch series has functionality dependency on Fenghua's "Tag application
> address space for devices" patch series for the ENQCMD CPU command enumeration
> and the PASID MSR support. [2]
> 
> The first patch enumerating ENQCMD is lifted from Fenghua's patch series. It
> removes the compilation dependency for the driver. It can be dropped by the
> maintainer merging the driver patch series once Fenghua's patch series is
> merged.
> 
> == Background ==
> A typical DMA device requires the driver to translate application buffers to
> hardware addresses, and a kernel-user transition to notify the hardware of new
> work. Shared Virtual Addressing (SVA) allows the processor and device to use the
> same virtual addresses without requiring software to translate between the
> address spaces. ENQCMD is a new instruction on Intel Platforms that allows user
> applications to directly notify hardware of new work, much like how doorbells
> are used in some hardware, but it carries a payload along with it. ENQCMDS is
> the supervisor version (ring0) of ENQCMD.
> 
> == ENQCMDS ==
> Introduce iosubmit_cmd512_sync(), a common wrapper that copies an input payload
> to a 64B aligned destination and confirms whether the payload was accepted by
> the device or not. iosubmit_cmd512_sync() wraps the new ENQCMDS CPU instruction.
> The ENQCMDS is a ring 0 CPU instruction that performs similar to the ENQCMD
> instruction. Descriptor submission must use ENQCMD(S) for shared workqueues
> (swq) on an Intel DSA device.
> 
> == Shared WQ support ==
> Introduce shared workqueue (swq) support for the idxd driver. The current idxd
> driver contains dedicated workqueue (dwq) support only. A dwq accepts
> descriptors from a MOVDIR64B instruction. MOVDIR64B is a posted instruction on
> the PCIe bus, it does not wait for any response from the device. If the wq is
> full, submitted descriptors are dropped. A swq utilizes the ENQCMDS in ring 0,
> which is a non-posted instruction. The zero flag would be set to 1 if the device
> rejects the descriptor or if the wq is full. A swq can be shared between
> multiple users (kernel or userspace) due to not having to keep track of the wq
> full condition for submission. A swq requires PASID and can only run with SVA
> support.
> 
> == IDXD SVA support ==
> Add utilization of PASID to support Shared Virtual Addressing (SVA). With PASID
> support, the descriptors can be programmed with host virtual address (HVA)
> rather than IOVA. The hardware will work with the IOMMU in fulfilling page
> requests. With SVA support, a user app using the char device interface can now
> submit descriptors without having to pin the virtual memory range it wants to
> DMA in its own address space.
> 
> The series does not add SVA support for the dmaengine subsystem. That support
> is coming at a later time.
> 
> [1]: https://lore.kernel.org/lkml/157965011794.73301.15960052071729101309.stgit@djiang5-desk3.ch.intel.com/
> [2]: https://lore.kernel.org/lkml/1585596788-193989-1-git-send-email-fenghua.yu@intel.com/
> [3]: https://software.intel.com/en-us/articles/intel-sdm
> [4]: https://software.intel.com/en-us/download/intel-scalable-io-virtualization-technical-specification
> [5]: https://software.intel.com/en-us/download/intel-data-streaming-accelerator-preliminary-architecture-specification
> [6]: https://01.org/blogs/2019/introducing-intel-data-streaming-accelerator
> [7]: https://intel.github.io/idxd/
> [8]: https://github.com/intel/idxd-driver idxd-stage2
> 
> ---
> 
> Dave Jiang (8):
>        x86/asm: move the raw asm in iosubmit_cmds512() to special_insns.h
>        x86/asm: add enqcmds() to support ENQCMDS instruction
>        dmaengine: idxd: add work queue drain support
>        dmaengine: idxd: move submission to sbitmap_queue
>        dmaengine: idxd: add shared workqueue support
>        dmaengine: idxd: clean up descriptors with fault error
>        dmaengine: idxd: add leading / for sysfspath in ABI documentation
>        dmaengine: idxd: add ABI documentation for shared wq
> 
> Fenghua Yu (1):
>        x86/cpufeatures: Enumerate ENQCMD and ENQCMDS instructions
> 
> 
>   Documentation/ABI/stable/sysfs-driver-dma-idxd |   68 ++++--
>   arch/x86/include/asm/cpufeatures.h             |    1
>   arch/x86/include/asm/io.h                      |   43 +++-
>   arch/x86/include/asm/special_insns.h           |   17 ++
>   arch/x86/kernel/cpu/cpuid-deps.c               |    1
>   drivers/dma/Kconfig                            |   15 +
>   drivers/dma/idxd/cdev.c                        |   38 ++++
>   drivers/dma/idxd/device.c                      |  252 +++++++++++++++---------
>   drivers/dma/idxd/dma.c                         |    9 -
>   drivers/dma/idxd/idxd.h                        |   32 ++-
>   drivers/dma/idxd/init.c                        |  122 +++++++-----
>   drivers/dma/idxd/irq.c                         |  184 ++++++++++++++----
>   drivers/dma/idxd/registers.h                   |   14 +
>   drivers/dma/idxd/submit.c                      |  105 ++++++----
>   drivers/dma/idxd/sysfs.c                       |  150 +++++++++++++-
>   15 files changed, 758 insertions(+), 293 deletions(-)
> 
> --
> 
