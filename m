Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84221ED362
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2020 17:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgFCPbA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Jun 2020 11:31:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:1925 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgFCPbA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 3 Jun 2020 11:31:00 -0400
IronPort-SDR: v/FJQZzj4uITHQy9RMmYKayHDGazVz5hDLVEszTNMY4pvLrwOYFLxy8jiXIZNRrIoB5AvEPaOD
 wCht4o2i8yXQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 08:30:59 -0700
IronPort-SDR: Oniq7Cm8/PZnngHlDtNkd/idZC+NX75xBlorwCaXdFsYm/GawlMGtQlcbjd0wgRRNcv7nJQRE+
 7j0qvVI+EFLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400"; 
   d="scan'208";a="287071457"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.64.56]) ([10.212.64.56])
  by orsmga002.jf.intel.com with ESMTP; 03 Jun 2020 08:30:58 -0700
Subject: Re: [PATCH v2 0/9] Add shared workqueue support for idxd driver
To:     Vinod Koul <vkoul@kernel.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        bhelgaas@google.com, gregkh@linuxfoundation.org, arnd@arndb.de,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, dan.j.williams@intel.com, ashok.raj@intel.com,
        fenghua.yu@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        sanjay.k.kumar@intel.com, dave.hansen@intel.com
References: <158982749959.37989.2096629611303670415.stgit@djiang5-desk3.ch.intel.com>
 <95eb8203-a332-37ae-28fb-5a2af4d1daba@intel.com>
 <20200603063342.GA41080@vkoul-mobl>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <b909892c-b755-b184-2cd4-60f9cff6abd3@intel.com>
Date:   Wed, 3 Jun 2020 08:30:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200603063342.GA41080@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 6/2/2020 11:33 PM, Vinod Koul wrote:
> Hi Dave,
> 
> On 01-06-20, 15:09, Dave Jiang wrote:
>> Vinod,
>> Obviously this series won't make it for 5.8 due to being blocked by
>> Fenghua's PASID series. Do you think you can take patches 4 and 5
>> independently? I think these can go into 5.8 and is not dependent on
>> anything. Thanks.
> 
> I was out last week, can you resend these two after merge window and we
> can do the needful

Sure thing. I'll break them out and resend. Thanks!

> 
> Thanks
> 
