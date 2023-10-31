Return-Path: <dmaengine+bounces-35-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC68D7DCC19
	for <lists+dmaengine@lfdr.de>; Tue, 31 Oct 2023 12:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7D59B20E2C
	for <lists+dmaengine@lfdr.de>; Tue, 31 Oct 2023 11:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665241B26E;
	Tue, 31 Oct 2023 11:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4800C1A73C
	for <dmaengine@vger.kernel.org>; Tue, 31 Oct 2023 11:46:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9AE2591;
	Tue, 31 Oct 2023 04:46:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E613EC15;
	Tue, 31 Oct 2023 04:47:35 -0700 (PDT)
Received: from [192.168.1.102] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B92C33F64C;
	Tue, 31 Oct 2023 04:46:52 -0700 (PDT)
Message-ID: <3fc50cc1-e4b1-49f9-a0f3-cc527d942e00@arm.com>
Date: Tue, 31 Oct 2023 11:46:47 +0000
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IOVA address range
To: Bjorn Helgaas <helgaas@kernel.org>, Eric Pilmore <epilmore@gigaio.com>
Cc: linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231030181622.GA1878727@bhelgaas>
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231030181622.GA1878727@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-10-30 6:19 pm, Bjorn Helgaas wrote:
> [+cc folks from ./scripts/get_maintainer.pl -f drivers/iommu]
> 
> On Fri, Oct 27, 2023 at 12:17:17PM -0700, Eric Pilmore wrote:
>> Need a little IOVA/IOMMU help.
>>
>> Is it correct that the IOVA address range for a device goes from
>> address 0x0 up to the dma-mask of the respective device?
>>
>> Is it correct to assume that the base of the IOVA address space for a
>> device will always be zero (0x0)? Is there any reason to think that
>> this has changed in some newer iteration of the kernel, perhaps 5.10,
>> and that the base could be non-zero?
>>
>> I realize an IOVA itself can be non-zero. I'm trying to verify what
>> the base address is of the IOVA space as a whole on a per device
>> basis.

In short, "No."

In detail, it depends on the architecture, since there are still a 
number of different IOMMU-based DMA API backends. Off-hand I do know 
that 32-bit Arm allocates upwards from 0, since there are some drivers 
annoyingly relying on that behaviour. I've never looked too closely at 
what the likes of Alpha, Sparc and PowerPC do. The generic IOVA 
allocator used by iommu-dma on x86, arm64, and soon s390, allocates 
top-down, but for historical reasons has a special behaviour for PCI 
devices where it tries to stay below the 32-bit boundary and only goes 
up to the full DMA mask (if larger) once that space is full. iommu-dma 
also always reserves 0 as an invalid IOVA - initially this was more of a 
convenience measure to help catch certain potential bugs, but it's long 
since also been relied upon as a special value in the internal caching 
mechanism. Note also that any device may have holes reserved anywhere in 
its otherwise-usable address space, and/or its entire notion of usable 
ranges constrained as described by firmware (e.g. a devicetree 
"dma-ranges" property or ACPI "_DMA" method).

Thanks,
Robin.

