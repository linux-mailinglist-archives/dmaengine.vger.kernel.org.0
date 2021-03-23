Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9B43461D4
	for <lists+dmaengine@lfdr.de>; Tue, 23 Mar 2021 15:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbhCWOs4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Mar 2021 10:48:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:24769 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232383AbhCWOsg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 23 Mar 2021 10:48:36 -0400
IronPort-SDR: 6d1A5xA7XG3zdxOGJUDgFsLG/PmMukbZCEvYdR5sJXJZsa0iD/FU8E0GsiCdJwO2s1t1u+LObC
 Y1P4JTo+bt6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="177614394"
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="177614394"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 07:48:35 -0700
IronPort-SDR: BxGhq3yh/g59X8PPXt6Q68KFsmx0mprvIF+XXMi06q6dhGzcGJmKu+hEasEHM0/FgG9/H0jPuA
 Zpt3GsmQYQIw==
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="513770549"
Received: from mkobayas-mobl1.gar.corp.intel.com (HELO [10.212.157.78]) ([10.212.157.78])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 07:48:31 -0700
Subject: Re: [PATCH v7 8/8] dmaengine: idxd: fix cdev setup and free device
 lifetime issues
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
References: <161645534083.2002542.11583610276394664799.stgit@djiang5-desk3.ch.intel.com>
 <161645592123.2002542.5490784749723732920.stgit@djiang5-desk3.ch.intel.com>
 <CAPcyv4j8h3Ec-NX+tfaK+evzG8NQq-meVX8VwELQpDyTsTgZHg@mail.gmail.com>
 <60f12cfc-6f5a-7f0f-e88a-ab0e15b6d759@intel.com>
 <20210323000257.GY2356281@nvidia.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <8314b924-007c-47b6-d04f-ab8bde7168e9@intel.com>
Date:   Tue, 23 Mar 2021 07:48:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210323000257.GY2356281@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 3/22/2021 5:02 PM, Jason Gunthorpe wrote:
> On Mon, Mar 22, 2021 at 04:44:24PM -0700, Dave Jiang wrote:
>> On 3/22/2021 4:38 PM, Dan Williams wrote:
>>> On Mon, Mar 22, 2021 at 4:32 PM Dave Jiang <dave.jiang@intel.com> wrote:
>>>> The char device setup and cleanup has device lifetime issues regarding when
>>>> parts are initialized and cleaned up. The initialization of struct device is
>>>> done incorrectly. device_initialize() needs to be called on the 'struct
>>>> device' and then additional changes can be added. The ->release() function
>>>> needs to be setup via device_type before dev_set_name() to allow proper
>>>> cleanup. The change re-parents the cdev under the wq->conf_dev to get
>>>> natural reference inheritance. No known dependency on the old device path exists.
>>>>
>>>> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
>>>> Fixes: 42d279f9137a ("dmaengine: idxd: add char driver to expose submission portal to userland")
>>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>>> [..]
>>>> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
>>>> index 03079ff54889..8a08988ea9d1 100644
>>>> +++ b/drivers/dma/idxd/sysfs.c
>>>> @@ -1174,8 +1174,14 @@ static ssize_t wq_cdev_minor_show(struct device *dev,
>>>>                                     struct device_attribute *attr, char *buf)
>>>>    {
>>>>           struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
>>>> +       int minor = -1;
>>>>
>>>> -       return sprintf(buf, "%d\n", wq->idxd_cdev.minor);
>>>> +       mutex_lock(&wq->wq_lock);
>>>> +       if (wq->idxd_cdev)
>>>> +               minor = wq->idxd_cdev->minor;
>>>> +       mutex_unlock(&wq->wq_lock);
>>>> +
>>>> +       return sprintf(buf, "%d\n", minor);
>>> As I mentioned, let's not emit a negative value here. ...not that
>>> userspace should be using this awkward recreation of the existing core
>>> 'dev' attribute anyway.
>>>
>>> if (minor == -1)
>>>       return -ENXIO;
>>> return sprintf(buf, "%d\n", minor);
>> Ok I'll update. This will go away when we convert to UACCE based driver.
> Also ensure all new syfs callbacks are using sysfs_emit()
>
Thanks Jason! I have posted a patch that fixes all the instances [1]. 
But I can fix it locally here as well.


[1]: 
https://lore.kernel.org/dmaengine/161495936863.573579.5804720281778882171.stgit@djiang5-desk3.ch.intel.com/


