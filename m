Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3C128653C
	for <lists+dmaengine@lfdr.de>; Wed,  7 Oct 2020 18:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgJGQuU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Oct 2020 12:50:20 -0400
Received: from mga04.intel.com ([192.55.52.120]:9895 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbgJGQuU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 7 Oct 2020 12:50:20 -0400
IronPort-SDR: 7SKj03YEsZi8siPJ2A1AVVwwOLGlDr3+9+Du9rjDk13OLA2WrbiqCW1gaijhiCcAJoLyy+OhwI
 ZNw4srPX4WQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="162398123"
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="162398123"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 09:50:19 -0700
IronPort-SDR: JrC6QF5/odrbn7CHDLJIcwmsP3AqDxNK02WJ+trXcOUzbJi0697Tne5mMaR9MpX4PfTWVixQ51
 Qwd/An4C/C6A==
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="311818876"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.241.84]) ([10.212.241.84])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 09:50:18 -0700
Subject: Re: [PATCH v7 0/5] Add shared workqueue support for idxd driver
To:     Vinod Koul <vkoul@kernel.org>
Cc:     bp@alien8.de, dan.j.williams@intel.com, tony.luck@intel.com,
        ashok.raj@intel.com, kevin.tian@intel.com, fenghua.yu@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201005151126.657029-1-dave.jiang@intel.com>
 <20201007070132.GT2968@vkoul-mobl>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <c25b11ce-4588-6663-c9d6-b1177c627c98@intel.com>
Date:   Wed, 7 Oct 2020 09:50:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201007070132.GT2968@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 10/7/2020 12:01 AM, Vinod Koul wrote:
> On 05-10-20, 08:11, Dave Jiang wrote:
> 
>> == Background ==
>> A typical DMA device requires the driver to translate application buffers to hardware addresses,
>> and a kernel-user transition to notify the hardware of new work. Shared Virtual Addressing (SVA)
>> allows the processor and device to use the same virtual addresses without requiring software to
>> translate between the address spaces. ENQCMD is a new instruction on Intel Platforms that allows
>> user applications to directly notify hardware of new work, much like how doorbells are used in
>> some hardware, but it carries a payload along with it. ENQCMDS is the supervisor version (ring0)
>> of ENQCMD.
>>
>> == ENQCMDS ==
>> Introduce enqcmds(), a helper funciton that copies an input payload to a 64B aligned
>> destination and confirms whether the payload was accepted by the device or not.
>> enqcmds() wraps the new ENQCMDS CPU instruction. The ENQCMDS is a ring 0 CPU instruction that
>> performs similar to the ENQCMD instruction. Descriptor submission must use ENQCMD(S) for shared
>> workqueues (swq) on an Intel DSA device.
>>
>> == Shared WQ support ==
>> Introduce shared workqueue (swq) support for the idxd driver. The current idxd driver contains
>> dedicated workqueue (dwq) support only. A dwq accepts descriptors from a MOVDIR64B instruction.
>> MOVDIR64B is a posted instruction on the PCIe bus, it does not wait for any response from the
>> device. If the wq is full, submitted descriptors are dropped. A swq utilizes the ENQCMDS in
>> ring 0, which is a non-posted instruction. The zero flag would be set to 1 if the device rejects
>> the descriptor or if the wq is full. A swq can be shared between multiple users
>> (kernel or userspace) due to not having to keep track of the wq full condition for submission.
>> A swq requires PASID and can only run with SVA support.
>>
>> == IDXD SVA support ==
>> Add utilization of PASID to support Shared Virtual Addressing (SVA). With PASID support,
>> the descriptors can be programmed with host virtual address (HVA) rather than IOVA.
>> The hardware will work with the IOMMU in fulfilling page requests. With SVA support,
>> a user app using the char device interface can now submit descriptors without having to pin the
>> virtual memory range it wants to DMA in its own address space.
>>
>> The series does not add SVA support for the dmaengine subsystem. That support is coming at a
>> later time.
> 
> Applied, thanks
> 

Thanks Vinod!
