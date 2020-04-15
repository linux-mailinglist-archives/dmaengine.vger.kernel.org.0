Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFEB1AACE7
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2020 18:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406240AbgDOQE1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Apr 2020 12:04:27 -0400
Received: from mga04.intel.com ([192.55.52.120]:37881 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406243AbgDOQEY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Apr 2020 12:04:24 -0400
IronPort-SDR: EH+GVyFUvtP5FsBolRtJ4AEBbPjLNlgwejXp/iifZPPIot1zm02n+DfHjSc/Vb8sVG9ViPn52w
 qgbRLutSVDhw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 09:04:24 -0700
IronPort-SDR: 0oiUL99t9mxtoPNS8bN1nCK+ZyRq6aX95Q3XZacp/WdF7CRMNGcrFOwghUWhrmEq/e1pej1w2R
 oipQw3PMIbaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,387,1580803200"; 
   d="scan'208";a="271771217"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.209.100.229]) ([10.209.100.229])
  by orsmga002.jf.intel.com with ESMTP; 15 Apr 2020 09:04:23 -0700
Subject: Re: [PATCH] dmaengine: idxd: export hw version through sysfs
To:     Vinod Koul <vkoul@kernel.org>
Cc:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
References: <158594715310.27813.14140257595400126459.stgit@djiang5-desk3.ch.intel.com>
 <20200415155922.GV72691@vkoul-mobl>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <0eaf0a7b-05ae-90f1-24e7-f4b6c2cff883@intel.com>
Date:   Wed, 15 Apr 2020 09:04:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200415155922.GV72691@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 4/15/2020 8:59 AM, Vinod Koul wrote:
> On 03-04-20, 13:52, Dave Jiang wrote:
>> Some user apps would like to know the hardware version in order to
>> determine the variation of the hardware. Export the hardware version number
>> to userspace via sysfs.
> 
> Documentation update?

Ah right! Will add that.

> 
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/dma/idxd/sysfs.c |   11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
>> index 5fb6b5cafb55..bd05a04d3aa3 100644
>> --- a/drivers/dma/idxd/sysfs.c
>> +++ b/drivers/dma/idxd/sysfs.c
>> @@ -1377,6 +1377,16 @@ static const struct attribute_group *idxd_wq_attribute_groups[] = {
>>   };
>>   
>>   /* IDXD device attribs */
>> +static ssize_t version_show(struct device *dev, struct device_attribute *attr,
>> +			    char *buf)
>> +{
>> +	struct idxd_device *idxd =
>> +		container_of(dev, struct idxd_device, conf_dev);
>> +
>> +	return sprintf(buf, "%#x\n", idxd->hw.version);
>> +}
>> +static DEVICE_ATTR_RO(version);
>> +
>>   static ssize_t max_work_queues_size_show(struct device *dev,
>>   					 struct device_attribute *attr,
>>   					 char *buf)
>> @@ -1618,6 +1628,7 @@ static ssize_t cdev_major_show(struct device *dev,
>>   static DEVICE_ATTR_RO(cdev_major);
>>   
>>   static struct attribute *idxd_device_attributes[] = {
>> +	&dev_attr_version.attr,
>>   	&dev_attr_max_groups.attr,
>>   	&dev_attr_max_work_queues.attr,
>>   	&dev_attr_max_work_queues_size.attr,
> 
