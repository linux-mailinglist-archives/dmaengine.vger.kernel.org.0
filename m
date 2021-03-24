Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A845347B3D
	for <lists+dmaengine@lfdr.de>; Wed, 24 Mar 2021 15:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236336AbhCXO6L (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Mar 2021 10:58:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:32624 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236269AbhCXO6B (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Mar 2021 10:58:01 -0400
IronPort-SDR: 1WV5rjnKvr+N+iKrs7qtyKYOsUExshZVtgPMV/41kkPoPweUm0yZ5+2IKG27+y2wFJUsrvBVwX
 koXXjKK5HqKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="190137234"
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="190137234"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 07:57:59 -0700
IronPort-SDR: T8NshD4fKOfnhZ3d2I0xnNnhmgRbyYSinc5EaT+uIjKKriYtZ/8dmZpUXPy7vDQiPVYHIjCQO5
 Ou0kXy/bW8DA==
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="452624604"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.255.87.203]) ([10.255.87.203])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 07:57:59 -0700
Subject: Re: [PATCH v7 0/8] idxd 'struct device' lifetime handling fixes
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
References: <161645534083.2002542.11583610276394664799.stgit@djiang5-desk3.ch.intel.com>
 <YFnU2oqNavQEsmNZ@vkoul-mobl.Dlink> <20210323115600.GA2356281@nvidia.com>
 <3e68045f-8901-c81e-a1d8-506c591060bf@intel.com>
 <20210324135640.GF2356281@nvidia.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <d160ba36-84f8-1fac-2802-8b1393e17bd4@intel.com>
Date:   Wed, 24 Mar 2021 07:57:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210324135640.GF2356281@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 3/24/2021 6:56 AM, Jason Gunthorpe wrote:
> On Tue, Mar 23, 2021 at 08:44:29AM -0700, Dave Jiang wrote:
>
>> 1. Introduce UACCE framework support for idxd and have a wq driver resides
>> under drivers/misc/uacce/idxd to support the char device operations and
>> deprecate the current custom char dev in idxd. This should remove the burden
>> on you to deal with the char device.
> Gah, I feel I already complained at Intel for cramming their own
> private char devices into subsystems! *subsystems* define the user
> API, not random drivers in them.
>
> uacce is a reasonable place to put something like this if there isn't
> a multi-driver standard
>
> If this is the plan we should block of the char dev under
> CONFIG_EXPERIMENTAL or something to discourage people using the uAPI
> we are planning to delete
The whole reason to move to UACCE is to relieve Vinod the burden of 
having to review that code under dmaengine. It was unfortunate that 
UACCE showed up a kernel version later after the idxd driver was 
accepted. Do you have a better suggestion?
