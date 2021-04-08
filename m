Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB303587C0
	for <lists+dmaengine@lfdr.de>; Thu,  8 Apr 2021 17:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbhDHPD4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 8 Apr 2021 11:03:56 -0400
Received: from mga03.intel.com ([134.134.136.65]:57042 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231923AbhDHPD4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 8 Apr 2021 11:03:56 -0400
IronPort-SDR: wBdldclUCNPVxx7SFMakjTEjxNmzBD104BcJ/MjB3NUSjuRbYj2o1taI7y1aybWDOZ23m+8LqJ
 rzjsCRYth6nQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="193600541"
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="193600541"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 08:03:44 -0700
IronPort-SDR: 3GSuFWXWjC8GoQP+4KJLHfxxDFhBDuPOq2gxz8EgHHEMTqza0CHSHDA7EvFRAEtMI7KULlt2Fc
 oXd3ydkz+8ig==
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="397115709"
Received: from kilau-mobl.amr.corp.intel.com (HELO [10.209.162.225]) ([10.209.162.225])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 08:03:43 -0700
Subject: Re: [PATCH v9 00/11] idxd 'struct device' lifetime handling fixes
To:     Jason Gunthorpe <jgg@nvidia.com>, Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
References: <161739324574.2945060.13103097793006713734.stgit@djiang5-desk3.ch.intel.com>
 <8ba1ad4c-c6da-a511-91ae-b02a374965db@intel.com>
 <20210408120020.GP7405@nvidia.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <e2716f65-1042-e611-bfd6-0dac73ab8def@intel.com>
Date:   Thu, 8 Apr 2021 08:03:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210408120020.GP7405@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 4/8/2021 5:00 AM, Jason Gunthorpe wrote:
> On Wed, Apr 07, 2021 at 05:00:21PM -0700, Dave Jiang wrote:
>> On 4/2/2021 12:56 PM, Dave Jiang wrote:
>>> v9:
>>> - Fill in details for commit messages (Jason)
>>> - Fix wrong indentation (Jason)
>>> - Move stray change to the right patch (Jason)
>>> - Remove idxd_free() and refactor 'struct device' setup so we can use
>>>     ->release() calls to clean up. (Jason)
>>> - Change idr to ida. (Jason)
>>> - Remove static type detection for each device type (Dan)
>> Hi Jason, thanks for all your reviews. Do you have any additional comments
>> with this series? I'd like this series to be accepted by Vinod for 5.12-rc
>> if possible. Thanks!
> It is probably way to big for a -rc6 kernel.
>
> Nothing stands out as making this worse, so I have no objection to
> Vinod taking it, but I didn't look to see if there are more things
> that need attention.

Thanks for the reviews! There is another series coming after that that 
cleans up the driver setup side of things.


Vinod, please let me know how you want this handled. Thanks!


> Jason
