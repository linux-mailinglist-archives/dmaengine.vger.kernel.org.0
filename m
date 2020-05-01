Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0133E1C20A4
	for <lists+dmaengine@lfdr.de>; Sat,  2 May 2020 00:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgEAWbx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 May 2020 18:31:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:41078 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgEAWbx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 1 May 2020 18:31:53 -0400
IronPort-SDR: Yuo582PxpoKQCZcs02G473e2EQ1vYsik9vaKXBlSp/+XwJD3gbyzcQaR3RR6om7R+KRdK7nQDk
 kj0+hcwmWcVQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 15:31:52 -0700
IronPort-SDR: 5ekQ+k46xybgF9HW2j412kLZkLzlc6Jvaz+HLd9DSdS0Js4fihZVy+KneV7F1D3hzoz3si5WQC
 EDbL825xEQWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,341,1583222400"; 
   d="scan'208";a="248657049"
Received: from meghadey-mobl1.amr.corp.intel.com (HELO [10.251.135.85]) ([10.251.135.85])
  by fmsmga007.fm.intel.com with ESMTP; 01 May 2020 15:31:51 -0700
Subject: Re: [PATCH RFC 00/15] Add VFIO mediated device support and IMS
 support for the idxd driver.
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
        maz@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, Yi L Liu <yi.l.liu@intel.com>,
        baolu.lu@intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
        Sanjay K Kumar <sanjay.k.kumar@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, Jing Lin <jing.lin@intel.com>,
        kwankhede@nvidia.com, eric.auger@redhat.com, parav@mellanox.com,
        dmaengine@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, linux-pci@vger.kernel.org,
        KVM list <kvm@vger.kernel.org>
References: <158751095889.36773.6009825070990637468.stgit@djiang5-desk3.ch.intel.com>
 <20200421235442.GO11945@mellanox.com>
 <CAPcyv4gMYz1wCYjfnujyGXP0jGehpb+dEYV7hJoAAsDsj9+afQ@mail.gmail.com>
 <20200423191846.GE13640@mellanox.com>
From:   "Dey, Megha" <megha.dey@linux.intel.com>
Message-ID: <098aef60-35a4-dc44-be07-ea43c1a726c7@linux.intel.com>
Date:   Fri, 1 May 2020 15:31:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423191846.GE13640@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jason,

On 4/23/2020 12:18 PM, Jason Gunthorpe wrote:
> On Wed, Apr 22, 2020 at 02:24:11PM -0700, Dan Williams wrote:
>> On Tue, Apr 21, 2020 at 4:55 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>>>
>>> On Tue, Apr 21, 2020 at 04:33:46PM -0700, Dave Jiang wrote:
>>>> The actual code is independent of the stage 2 driver code submission that adds
>>>> support for SVM, ENQCMD(S), PASID, and shared workqueues. This code series will
>>>> support dedicated workqueue on a guest with no vIOMMU.
>>>>
>>>> A new device type "mdev" is introduced for the idxd driver. This allows the wq
>>>> to be dedicated to the usage of a VFIO mediated device (mdev). Once the work
>>>> queue (wq) is enabled, an uuid generated by the user can be added to the wq
>>>> through the uuid sysfs attribute for the wq.  After the association, a mdev can
>>>> be created using this UUID. The mdev driver code will associate the uuid and
>>>> setup the mdev on the driver side. When the create operation is successful, the
>>>> uuid can be passed to qemu. When the guest boots up, it should discover a DSA
>>>> device when doing PCI discovery.
>>>
>>> I'm feeling really skeptical that adding all this PCI config space and
>>> MMIO BAR emulation to the kernel just to cram this into a VFIO
>>> interface is a good idea, that kind of stuff is much safer in
>>> userspace.
>>>
>>> Particularly since vfio is not really needed once a driver is using
>>> the PASID stuff. We already have general code for drivers to use to
>>> attach a PASID to a mm_struct - and using vfio while disabling all the
>>> DMA/iommu config really seems like an abuse.
>>>
>>> A /dev/idxd char dev that mmaps a bar page and links it to a PASID
>>> seems a lot simpler and saner kernel wise.
>>>
>>>> The mdev utilizes Interrupt Message Store or IMS[3] instead of MSIX for
>>>> interrupts for the guest. This preserves MSIX for host usages and also allows a
>>>> significantly larger number of interrupt vectors for guest usage.
>>>
>>> I never did get a reply to my earlier remarks on the IMS patches.
>>>
>>> The concept of a device specific addr/data table format for MSI is not
>>> Intel specific. This should be general code. We have a device that can
>>> use this kind of kernel capability today.
>>
>> This has been my concern reviewing the implementation. IMS needs more
>> than one in-tree user to validate degrees of freedom in the api. I had
>> been missing a second "in-tree user" to validate the scope of the
>> flexibility that was needed.
> 
> IMS is too narrowly specified.
> 
> All platforms that support MSI today can support IMS. It is simply a
> way for the platform to give the driver an addr/data pair that triggers
> an interrupt when a posted write is performed to that pair.
> 

Well, yes and no. IMS requires interrupt remapping in addition to the 
dynamic nature of IRQ allocation.

> This is different from the other interrupt setup flows which are
> tightly tied to the PCI layer. Here the driver should simply ask for
> interrupts.
> 
> Ie the entire IMS API to the driver should be something very simple
> like:
> 
>   struct message_irq
>   {
>     uint64_t addr;
>     uint32_t data;
>   };
> 
>   struct message_irq *request_message_irq(
>      struct device *, irq_handler_t handler, unsigned long flags,
>      const char *name, void *dev);
> 
> And the plumbing underneath should setup the irq chips and so forth as
> required.
> 

yes, this seems correct.
> Jason
> 
