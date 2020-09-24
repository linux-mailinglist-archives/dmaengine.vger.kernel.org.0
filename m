Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28E4277B78
	for <lists+dmaengine@lfdr.de>; Fri, 25 Sep 2020 00:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgIXWFy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Sep 2020 18:05:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:46631 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbgIXWFw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 24 Sep 2020 18:05:52 -0400
IronPort-SDR: FGmcqjYZTPQ1qH/MCUqmH8gCgVQD3NjaiNhZQatO93qpCDKsUQAZV5J9gUKz6h2lSEGGqgE92J
 iGgmME5krYxA==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="222952993"
X-IronPort-AV: E=Sophos;i="5.77,299,1596524400"; 
   d="scan'208";a="222952993"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 15:05:51 -0700
IronPort-SDR: Oezyrdj/M3l0gJXPKkRKciKgrwvoJBY2QePT600tfvRabNY+6iI7vPej8IgrW/DHLoq49L+HGR
 IxzFX0ltXvrA==
X-IronPort-AV: E=Sophos;i="5.77,299,1596524400"; 
   d="scan'208";a="336185644"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.218.169]) ([10.212.218.169])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 15:05:50 -0700
Subject: Re: [PATCH v6 0/5] Add shared workqueue support for idxd driver
To:     Borislav Petkov <bp@alien8.de>
Cc:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, fenghua.yu@intel.com, kevin.tian@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200924180041.34056-1-dave.jiang@intel.com>
 <a2a6f147-c4ad-a225-e348-b074a8017a10@intel.com>
 <20200924215136.GS5030@zn.tnic>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <71a1831b-b57f-610f-70b6-7d42cb889f20@intel.com>
Date:   Thu, 24 Sep 2020 15:05:49 -0700
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

Thanks Boris. Locally I have based on the latest dmaengine/next branch, merged 
in the x86/pasid branch, and then applied the series on top for testing. But 
yes, if Vinod accepts the series into his dmaengine/next tree, we will need all 
the parts for testing.
