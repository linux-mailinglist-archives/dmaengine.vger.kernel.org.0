Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 298A8199C86
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2020 19:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbgCaRHL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 Mar 2020 13:07:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:11982 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgCaRHL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 31 Mar 2020 13:07:11 -0400
IronPort-SDR: 4gEBLe0ofJ1j45MX/grOzgxBcOdkXfUWzPS5yxv9btCL/PO/nUQ40lmKI+0kkFqNMyxx/hvA0m
 T/4iwUktSN1w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 10:07:10 -0700
IronPort-SDR: eJGmvU91zumNaIcP/GxrKRiqpkMc5ssOc0AxoMctKppSZ+CQvB2X+WDPcUsMh+WEUyNs04EnPM
 eKQfaElUC6cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,328,1580803200"; 
   d="scan'208";a="240192256"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.251.20.204]) ([10.251.20.204])
  by fmsmga007.fm.intel.com with ESMTP; 31 Mar 2020 10:07:07 -0700
Subject: Re: [PATCH 2/6] device/pci: add cmdmem cap to pci_dev
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, bhelgaas@google.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        ashok.raj@intel.com, fenghua.yu@intel.com,
        linux-pci@vger.kernel.org, tony.luck@intel.com, jing.lin@intel.com,
        sanjay.k.kumar@intel.com
References: <158560290392.6059.16921214463585182874.stgit@djiang5-desk3.ch.intel.com>
 <158560362090.6059.1762280705382158736.stgit@djiang5-desk3.ch.intel.com>
 <20200331100406.GB1204199@kroah.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <00d8e780-105e-f552-daf0-9854f2e99a91@intel.com>
Date:   Tue, 31 Mar 2020 10:07:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331100406.GB1204199@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 3/31/2020 3:04 AM, Greg KH wrote:
> On Mon, Mar 30, 2020 at 02:27:00PM -0700, Dave Jiang wrote:
>> Since the current accelerator devices do not have standard PCIe capability
>> enumeration for accepting ENQCMDS yet, for now an attribute of pdev->cmdmem has
>> been added to struct pci_dev.  Currently a PCI quirk must be used for the
>> devices that have such cap until the PCI cap is standardized. Add a helper
>> function to provide the check if a device supports the cmdmem capability.
>>
>> Such capability is expected to be added to PCIe device cap enumeration in
>> the future.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/base/core.c    |   13 +++++++++++++
>>   include/linux/device.h |    2 ++
>>   include/linux/pci.h    |    1 +
>>   3 files changed, 16 insertions(+)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index dbb0f9130f42..cd9f5b040ed4 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -27,6 +27,7 @@
>>   #include <linux/netdevice.h>
>>   #include <linux/sched/signal.h>
>>   #include <linux/sysfs.h>
>> +#include <linux/pci.h>
>>   
>>   #include "base.h"
>>   #include "power/power.h"
>> @@ -3790,3 +3791,15 @@ int device_match_any(struct device *dev, const void *unused)
>>   	return 1;
>>   }
>>   EXPORT_SYMBOL_GPL(device_match_any);
>> +
>> +bool device_supports_cmdmem(struct device *dev)
>> +{
>> +	struct pci_dev *pdev;
>> +
>> +	if (!dev_is_pci(dev))
>> +		return false;
>> +
>> +	pdev = to_pci_dev(dev);
>> +	return pdev->cmdmem;
>> +}
>> +EXPORT_SYMBOL_GPL(device_supports_cmdmem);
> Why would a pci-specific function like this be ok to have in the driver
> core?  Please keep it in the pci core code instead.

The original thought was to introduce a new arch level memory mapping 
semantic. If you feel this should be PCI exclusive, should we make the 
ioremap routines for this memory type pci specific as well?


>
> thanks,
>
> greg k-h
