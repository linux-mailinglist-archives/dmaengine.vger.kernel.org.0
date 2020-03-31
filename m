Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0397199D9C
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2020 20:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgCaSCp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 Mar 2020 14:02:45 -0400
Received: from mga06.intel.com ([134.134.136.31]:16127 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgCaSCo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 31 Mar 2020 14:02:44 -0400
IronPort-SDR: j2NZ3SlPxn625hqJet8G8+Vs3jyT3gZveo1kbHBzeVr1Sq3iAHkMkzORzP03etou3Uum/AALkx
 TLEV/skRKVDw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 11:02:44 -0700
IronPort-SDR: Xmx1u/O6AfpkZBrQjD1Mw4wxecKCMtKYwvOUKO7DlkvZwglVp87aDyPldtXFWEkyA6bcaalHGx
 HGz90nJ1R8Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,328,1580803200"; 
   d="scan'208";a="240205398"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.251.20.204]) ([10.251.20.204])
  by fmsmga007.fm.intel.com with ESMTP; 31 Mar 2020 11:02:42 -0700
Subject: Re: [PATCH 3/6] pci: add PCI quirk cmdmem fixup for Intel DSA device
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, gregkh@linuxfoundation.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        ashok.raj@intel.com, fenghua.yu@intel.com,
        linux-pci@vger.kernel.org, tony.luck@intel.com, jing.lin@intel.com,
        sanjay.k.kumar@intel.com
References: <20200331155906.GA191980@google.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <03073d25-9351-5bc7-e971-8e21b82f122f@intel.com>
Date:   Tue, 31 Mar 2020 11:02:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331155906.GA191980@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 3/31/2020 8:59 AM, Bjorn Helgaas wrote:
> Take a look and make yours match (applies to other patches in the
> series as well):
>
>    $ git log --oneline drivers/pci/quirks.c
>    299bd044a6f3 ("PCI: Add ACS quirk for Zhaoxin Root/Downstream Ports")
>    0325837c51cb ("PCI: Add ACS quirk for Zhaoxin multi-function devices")
>    2880325bda8d ("PCI: Avoid ASMedia XHCI USB PME# from D0 defect")
>    b88bf6c3b6ff ("PCI: Add boot interrupt quirk mechanism for Xeon chipsets")
>    5e89cd303e3a ("PCI: Mark AMD Navi14 GPU rev 0xc5 ATS as broken")
>    7b90dfc4873b ("PCI: Add DMA alias quirk for PLX PEX NTB")
>    09298542cd89 ("PCI: Add nr_devfns parameter to pci_add_dma_alias()")
>
> There's no need to mention "PCI" twice.  Also no need for both "quirk"
> and "fixup".  This is all in the interest of putting more information
> in the small space of the subject line.
Ok I'll fix up.
>
> On Mon, Mar 30, 2020 at 02:27:06PM -0700, Dave Jiang wrote:
>> Since there is no standard way that defines a PCI device that receives
>> descriptors or commands with synchronous write operations, add quirk to set
>> cmdmem for the Intel accelerator device that supports it.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/pci/quirks.c |   11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 29f473ebf20f..ba0572b9b9c8 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -5461,3 +5461,14 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
>>   DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
>>   			      PCI_CLASS_DISPLAY_VGA, 8,
>>   			      quirk_reset_lenovo_thinkpad_p50_nvgpu);
>> +
>> +/*
>> + * Until the PCI Sig defines a standard capaiblity check that indicates a
>> + * device has cmdmem with synchronous write capability, we'll add a quirk
>> + * for device that supports it.
> s/PCI Sig/PCI-SIG/
> s/capaiblity/capability/
>
> It's not clear why this would need to be in drivers/pci/quirks.c as
> opposed to being in the driver itself.

That would make the driver to set the PCI device struct cap bit instead 
of this being set on discovery right? And if the driver isn't loaded, 
then the cap wouldn't be set. In the future if user space wants to 
discover this information that may be an issue.



>
>> + */
>> +static void device_cmdmem_fixup(struct pci_dev *pdev)
>> +{
>> +	pdev->cmdmem = 1;
>> +}
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0b25, device_cmdmem_fixup);
>>
