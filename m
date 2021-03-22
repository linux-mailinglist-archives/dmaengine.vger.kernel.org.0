Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BA1345328
	for <lists+dmaengine@lfdr.de>; Tue, 23 Mar 2021 00:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhCVXof (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Mar 2021 19:44:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:51062 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229622AbhCVXo0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Mar 2021 19:44:26 -0400
IronPort-SDR: WoABmx3w/oEczJ04KUTrOAo62LNIFPEF528LAriOXKLxxmQtywY2CLUgD7aHe5zYP+4F3xkqLO
 mhGkOoKYn9vw==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="189770314"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="189770314"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 16:44:25 -0700
IronPort-SDR: Pz5+ofL6b1qvtijgQUn/QHwlTLGQLcgdeou8q/+4Ed5+RAsVMRzUWQ2rTZak6JV3q3cOB9gr1k
 GgZG96KjSPuA==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="408029722"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.251.146.111]) ([10.251.146.111])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 16:44:25 -0700
Subject: Re: [PATCH v7 8/8] dmaengine: idxd: fix cdev setup and free device
 lifetime issues
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
        dmaengine@vger.kernel.org
References: <161645534083.2002542.11583610276394664799.stgit@djiang5-desk3.ch.intel.com>
 <161645592123.2002542.5490784749723732920.stgit@djiang5-desk3.ch.intel.com>
 <CAPcyv4j8h3Ec-NX+tfaK+evzG8NQq-meVX8VwELQpDyTsTgZHg@mail.gmail.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <60f12cfc-6f5a-7f0f-e88a-ab0e15b6d759@intel.com>
Date:   Mon, 22 Mar 2021 16:44:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4j8h3Ec-NX+tfaK+evzG8NQq-meVX8VwELQpDyTsTgZHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 3/22/2021 4:38 PM, Dan Williams wrote:
> On Mon, Mar 22, 2021 at 4:32 PM Dave Jiang <dave.jiang@intel.com> wrote:
>> The char device setup and cleanup has device lifetime issues regarding when
>> parts are initialized and cleaned up. The initialization of struct device is
>> done incorrectly. device_initialize() needs to be called on the 'struct
>> device' and then additional changes can be added. The ->release() function
>> needs to be setup via device_type before dev_set_name() to allow proper
>> cleanup. The change re-parents the cdev under the wq->conf_dev to get
>> natural reference inheritance. No known dependency on the old device path exists.
>>
>> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
>> Fixes: 42d279f9137a ("dmaengine: idxd: add char driver to expose submission portal to userland")
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> [..]
>> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
>> index 03079ff54889..8a08988ea9d1 100644
>> --- a/drivers/dma/idxd/sysfs.c
>> +++ b/drivers/dma/idxd/sysfs.c
>> @@ -1174,8 +1174,14 @@ static ssize_t wq_cdev_minor_show(struct device *dev,
>>                                    struct device_attribute *attr, char *buf)
>>   {
>>          struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
>> +       int minor = -1;
>>
>> -       return sprintf(buf, "%d\n", wq->idxd_cdev.minor);
>> +       mutex_lock(&wq->wq_lock);
>> +       if (wq->idxd_cdev)
>> +               minor = wq->idxd_cdev->minor;
>> +       mutex_unlock(&wq->wq_lock);
>> +
>> +       return sprintf(buf, "%d\n", minor);
> As I mentioned, let's not emit a negative value here. ...not that
> userspace should be using this awkward recreation of the existing core
> 'dev' attribute anyway.
>
> if (minor == -1)
>      return -ENXIO;
> return sprintf(buf, "%d\n", minor);
Ok I'll update. This will go away when we convert to UACCE based driver.
