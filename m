Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5772419B367
	for <lists+dmaengine@lfdr.de>; Wed,  1 Apr 2020 18:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389046AbgDAQiB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Apr 2020 12:38:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:49426 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389044AbgDAQiB (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 1 Apr 2020 12:38:01 -0400
IronPort-SDR: PVq0+WXf0/nwfyy4uySb4YlpxO8ABxpxoQ4NJLqY4D/qF+ebrNKa+CcCL8jBfscQaSPD7y5q76
 nGv8ITFlX4pA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 09:37:59 -0700
IronPort-SDR: TGY5V1axE7pHguliK42idEKM+IAzCJiWTJiHEjfcUUXY+SgNlI/oXwCGcVLomaeMyPf6+6dyqw
 RHBxcEX01Zrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,332,1580803200"; 
   d="scan'208";a="240559676"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.134.75.181]) ([10.134.75.181])
  by fmsmga007.fm.intel.com with ESMTP; 01 Apr 2020 09:37:58 -0700
Subject: Re: [PATCH 2/6] device/pci: add cmdmem cap to pci_dev
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, gregkh@linuxfoundation.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        ashok.raj@intel.com, fenghua.yu@intel.com,
        linux-pci@vger.kernel.org, tony.luck@intel.com, jing.lin@intel.com,
        sanjay.k.kumar@intel.com
References: <20200331220006.GA37376@google.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <1b4fe030-97ca-6345-5775-49c39a63eb03@intel.com>
Date:   Wed, 1 Apr 2020 09:37:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331220006.GA37376@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 3/31/2020 3:00 PM, Bjorn Helgaas wrote:
> On Tue, Mar 31, 2020 at 10:59:44AM -0700, Dave Jiang wrote:
>> On 3/31/2020 9:03 AM, Bjorn Helgaas wrote:
>>> On Mon, Mar 30, 2020 at 02:27:00PM -0700, Dave Jiang wrote:
>>>> Since the current accelerator devices do not have standard PCIe capability
>>>> enumeration for accepting ENQCMDS yet, for now an attribute of pdev->cmdmem has
>>>> been added to struct pci_dev.  Currently a PCI quirk must be used for the
>>>> devices that have such cap until the PCI cap is standardized. Add a helper
>>>> function to provide the check if a device supports the cmdmem capability.
>>>>
>>>> Such capability is expected to be added to PCIe device cap enumeration in
>>>> the future.
>>> This needs some sort of thumbnail description of what "synchronous
>>> write notification" and "cmdmem" mean.
>>
>> I will add more explanation.
>>
>>> Do you have a pointer to a PCI-SIG ECR or similar?
>>
>> Deferrable Memory Write (DMWr) ECR
>>
>> https://members.pcisig.com/wg/PCI-SIG/document/13747
>>
>>  From what I'm told it should be available for public review by EOW.
> 
> Please use terminology from the spec instead of things like
> "synchronous write notification".
> 
> AIUI, ENQCMDS is an x86 instruction.  That would have no meaning in
> the PCIe domain.
> 
> I'm not committing to acking any part of this before the ECR is
> accepted, but if you're adding support for the feature described by
> the ECR, you might as well add support for discovering the DMWr
> capability via Device Capabilities 2 as described in the ECR.

I'll look into adding the support for the ECR.

> 
> If you have hardware that supports DMWr but doesn't advertise it via
> Device Capabilities 2, you can always have a quirk that works around
> that lack.
> 
