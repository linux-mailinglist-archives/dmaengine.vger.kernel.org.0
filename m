Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDF63243A8
	for <lists+dmaengine@lfdr.de>; Wed, 24 Feb 2021 19:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbhBXSSk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Feb 2021 13:18:40 -0500
Received: from mga05.intel.com ([192.55.52.43]:43257 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234371AbhBXSSj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Feb 2021 13:18:39 -0500
IronPort-SDR: ULcd7Ckxj3C9gR4+Bm/kOwA5xyJH2Ms331XxbHsBUPP4M3rKNh9vgdVhaSiUKsNl91bMoCfOeI
 ETyKE+tQB1pw==
X-IronPort-AV: E=McAfee;i="6000,8403,9905"; a="270229329"
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400"; 
   d="scan'208";a="270229329"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 10:17:57 -0800
IronPort-SDR: SzsfcZZV7xGPH/Y/x744NR4WX0cvqRmWFVYb4AxQenseUR99Sng3Cfo2u5bzTgzdVSqt/TKjuj
 VzrXmk/g/Pkg==
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400"; 
   d="scan'208";a="403836795"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.198.74]) ([10.212.198.74])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 10:17:56 -0800
Subject: Re: [PATCH v2] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
References: <161418136625.1883632.9123020856542653686.stgit@djiang5-desk3.ch.intel.com>
 <CAPcyv4igM0O2U2+vqJRPL+Rh_pLydwdYpTorxhPa2MaDz-naJQ@mail.gmail.com>
 <ed5dd7c1-76be-468c-6453-3a3dc645d2a4@intel.com>
 <CAPcyv4huU8qTjdB6X+cNcgr-zX6XHoVT7nE6q2Sr6Y0UoiUkCw@mail.gmail.com>
 <20210224180008.GL4247@nvidia.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <e2bef74c-91fe-a0e7-c924-9bf1048eac92@intel.com>
Date:   Wed, 24 Feb 2021 11:17:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210224180008.GL4247@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 2/24/2021 11:00 AM, Jason Gunthorpe wrote:
> On Wed, Feb 24, 2021 at 09:49:39AM -0800, Dan Williams wrote:
>
>>>> I'd say this is follow-on work post bug-fix for the current lifetime violation.
>>>>
>>>>> +       kfree(idxd->msix_entries);
>>>>> +       kfree(idxd->irq_entries);
>>>>> +       kfree(idxd->int_handles);
>>>> These seem tied to the lifetime of the driver bind to the pci_device
>>>> not the conf_dev, or are those lines blurred here?
>>> Jason asked those to be not allocated by devm_* so there wouldn't be any
>>> inter-mixing of allocation methods and causing a mess.
>> Ok, it wasn't clear to me where the lines were drawn, so moving all to
>> the lowest common denominator lifetime makes sense.
> Usualy when I see things like this I ask why those are dedicated
> allocations too?
>
> It looks like msix_entries is usless, this could be a temp allocation
> during probe and the vector # stored in the irq_entries.

Ok.

>
> int_handles might like to be a flex array, not sure
>
> The other devm stuff looks questionable:
>
>          rc = devm_request_threaded_irq(dev, msix->vector, idxd_irq_handler,
>                                         idxd_misc_thread, 0, "idxd-misc",
>                                         irq_entry);
>
> So we pass irq_entry which is not devm managed memory to the irq, but
> we don't remove the irq during the driver remove() function, so this
> could use-after free.
>
> However this is counter-acted by masking and synchronize_irq extra
> code.
>
> Looks to be a lot simpler/clearer to just skip devm and call release
> irq instead of the other stuff.


Ok, I'll add the cleanup for that as part of the removing devm_* calls.

>
> Jason
