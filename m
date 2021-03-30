Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BB734F059
	for <lists+dmaengine@lfdr.de>; Tue, 30 Mar 2021 19:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhC3R6g (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Mar 2021 13:58:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:39759 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232481AbhC3R62 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 30 Mar 2021 13:58:28 -0400
IronPort-SDR: dk9YRbEEfVmQ2b57f4c7cmzGvGmQbwXEJoZbTtV6EA59N4yuvIohfwNL3mM7FzYMYKV13rkw/9
 yF96T/XCa78w==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="188561789"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="188561789"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 10:58:27 -0700
IronPort-SDR: KcpYiUh6+SufGRWsDAseVWUQQLTTnVVxqpOWZouXmzYdi6YSh5YLrPc28vXywmRnllatd4KLbr
 dqAA+bVgzMug==
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="376928116"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.209.140.11]) ([10.209.140.11])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 10:58:25 -0700
Subject: Re: [PATCH v8 0/8] idxd 'struct device' lifetime handling fixes
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     vkoul@kernel.org, Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, dan.carpenter@oracle.com
References: <161668743322.2670112.2302120522403482843.stgit@djiang5-desk3.ch.intel.com>
 <20210330174546.GW2356281@nvidia.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <b6653dea-acf4-cfe2-9409-9da09720c92f@intel.com>
Date:   Tue, 30 Mar 2021 10:58:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210330174546.GW2356281@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 3/30/2021 10:45 AM, Jason Gunthorpe wrote:
> On Thu, Mar 25, 2021 at 08:54:31AM -0700, Dave Jiang wrote:
>
>> Vinod,
>> The series fixes the various 'struct device' lifetime handling in the
>> idxd driver. The devm managed lifetime is incompatible with 'struct device'
>> objects that resides in the idxd context. Tested with
>> CONFIG_DEBUG_KOBJECT_RELEASE and address all issues from that.
>>
>> Please consider for damengine/fixes for the 5.12-rc.
> It seems like an improvement..
>
> The flow around probe is still weird:
>
> static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> {
> 	idxd = idxd_alloc(pdev);
>          ^^ but we don't device_initialize() this
>
> 	rc = idxd_probe(idxd);
> 	if (rc)
> 		goto err;
>
>   err:
>   err_iomap:
> 	idxd_free(idxd);
>   
> static int idxd_probe(struct idxd_device *idxd)
> {
>
>   err_int:
> 	idxd_free(idxd);
> 	return rc;
>
> So we call idxd_free twice on error unwinds, and that will
> crash. Unify idxd_free() and idxd_conf_device_release() as
> appropriate.
>
> Confused why they are different, why are some of the kfrees missing
> from the release function?
>
> Call device_initialize in idxd_alloc() and make it so that the release
> function works properly. Move all the error unwind put_device's to
> idxd_pci_probe()

I think understand where you are pulling this towards. I think we'll 
need to rework conf_dev initialization into the main initialization 
rather than doing it at the end. Let me go rework that.


>
> ..
>
> 	idxd->id = idr_alloc(&idxd_idrs[idxd->type], idxd, 0, 0, GFP_KERNEL);
>
> Nothing ever reads the idxd_idr, so this should be an ida

Yep Dan pointed that out the other day. I have a patch that fixes it but 
it's in the next patch series. I'll pull it out and into this one.


>
> Jason
