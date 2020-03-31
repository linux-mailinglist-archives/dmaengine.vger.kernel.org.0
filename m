Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3366619A100
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2020 23:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgCaVoW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 Mar 2020 17:44:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:49441 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbgCaVoW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 31 Mar 2020 17:44:22 -0400
IronPort-SDR: Iy3uAk8PDG1b9WYDPs+Db9CzPTI0QqGYFZOxx2QG981W6oBv1UhlL2n33ykXiX9ek8esfd7ntK
 vTDDXiP9tafw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 14:44:21 -0700
IronPort-SDR: ZCpEvb3x6ajjAIVOyJOO4PJc2/P9QWnShp0oYi8QoJIZklgsg+TQa9CV5ggOCWNpfEt6qxirJo
 9o398wmqiIRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,329,1580803200"; 
   d="scan'208";a="240258902"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.251.20.204]) ([10.251.20.204])
  by fmsmga007.fm.intel.com with ESMTP; 31 Mar 2020 14:44:19 -0700
Subject: Re: [PATCH 2/6] device/pci: add cmdmem cap to pci_dev
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, gregkh@linuxfoundation.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        ashok.raj@intel.com, fenghua.yu@intel.com,
        linux-pci@vger.kernel.org, tony.luck@intel.com, jing.lin@intel.com,
        sanjay.k.kumar@intel.com
References: <20200331160309.GA194762@google.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <e94b0403-ba68-4984-973b-6a4c5162df74@intel.com>
Date:   Tue, 31 Mar 2020 14:44:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331160309.GA194762@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 3/31/2020 9:03 AM, Bjorn Helgaas wrote:
> On Mon, Mar 30, 2020 at 02:27:00PM -0700, Dave Jiang wrote:
>> Since the current accelerator devices do not have standard PCIe capability
>> enumeration for accepting ENQCMDS yet, for now an attribute of pdev->cmdmem has
>> been added to struct pci_dev.  Currently a PCI quirk must be used for the
>> devices that have such cap until the PCI cap is standardized. Add a helper
>> function to provide the check if a device supports the cmdmem capability.
>>
>> Such capability is expected to be added to PCIe device cap enumeration in
>> the future.

Re-send. My misconfigured mail client caused mailing lists to bounce the 
send.

> 
> This needs some sort of thumbnail description of what "synchronous
> write notification" and "cmdmem" mean.

I will add more explanation.

> 
> Do you have a pointer to a PCI-SIG ECR or similar?



Deferrable Memory Write (DMWr) ECR


https://members.pcisig.com/wg/PCI-SIG/document/13747

 From what I'm told it should be available for public review by EOW.

> 
> Your window size seems to be 85 or so.  It would be easier if you used
> 80 and wrapped the commit log to fit in 75 columns so it looks decent
> when "git log" indents it by 4.
> 
Ok I will fix.
