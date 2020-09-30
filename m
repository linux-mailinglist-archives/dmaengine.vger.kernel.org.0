Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E7227F4FB
	for <lists+dmaengine@lfdr.de>; Thu,  1 Oct 2020 00:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbgI3WTm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Sep 2020 18:19:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:33634 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbgI3WTm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 30 Sep 2020 18:19:42 -0400
IronPort-SDR: 4429sXK86C5d58sDZMhLeTY8x5FdbyvwR14cAYryMwjU5jSXMv/VLSPV4h6L29wni4JCD/N+AG
 xe9NYHXU9cwg==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="180717603"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="180717603"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 15:19:39 -0700
IronPort-SDR: 7RQ/vIx0xXVvd23TkIym7ShsvtnHs41z9qrsWhaF3QEiNihFRdJcAwl/KuJ3f7j6qvjIQLrL5T
 1s8IkxCJltbw==
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="385280567"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.154.90]) ([10.212.154.90])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 15:19:37 -0700
Subject: Re: [PATCH v6 0/5] Add shared workqueue support for idxd driver
To:     vkoul@kernel.org
Cc:     Borislav Petkov <bp@alien8.de>, dan.j.williams@intel.com,
        tony.luck@intel.com, jing.lin@intel.com, ashok.raj@intel.com,
        fenghua.yu@intel.com, kevin.tian@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200924180041.34056-1-dave.jiang@intel.com>
 <a2a6f147-c4ad-a225-e348-b074a8017a10@intel.com>
 <20200924215136.GS5030@zn.tnic>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <4d857287-c751-8b37-d067-b471014c3b73@intel.com>
Date:   Wed, 30 Sep 2020 15:19:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200924215136.GS5030@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 9/24/2020 2:51 PM, Borislav Petkov wrote:
> On Thu, Sep 24, 2020 at 02:32:35PM -0700, Dave Jiang wrote:
>> Hi Vinod,
>> Looks like we are cleared on the x86 patches for this series with sign offs
>> from maintainer Boris. Please consider the series for 5.10 inclusion. Thank
>> you!
> 
> As I said here, I'd strongly suggest we do this:
> 
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/5FKNWNCCRV3AXUAEXUGQFF4EDQNANF3F/
> 
> and Vinod should merge the x86/pasid branch. Otherwise is his branch
> and incomplete you could not have tested it properly.
> 

Hi Vinod,
Just checking to see if you have any objections or concerns with respect to this 
series. We are hoping it can be queued for the 5.10 merge if there are no 
objections. Thanks!
