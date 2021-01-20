Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69DF2FC81F
	for <lists+dmaengine@lfdr.de>; Wed, 20 Jan 2021 03:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbhATCkA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Jan 2021 21:40:00 -0500
Received: from mga06.intel.com ([134.134.136.31]:3913 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387494AbhATCjR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 19 Jan 2021 21:39:17 -0500
IronPort-SDR: mxgiDw+tuMDeHbQB/72JgGLpHagRZOB5POz7dtVacr+C7Txl6hbpBy5CkTnFsF4APipp4u1g/a
 NCrvlJiigNPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="240572463"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="240572463"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 18:37:28 -0800
IronPort-SDR: Zf119pcf4SzdD8zILodBx/X8amBPPZOTguiV0ZLpdjZZQ36bGoKJg+iArkIY9cx15zg5SnzjF1
 vEapR4FdF4Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="466923220"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jan 2021 18:37:28 -0800
Received: from [10.214.172.191] (unknown [10.214.172.191])
        by linux.intel.com (Postfix) with ESMTP id 25C1F5807EA;
        Tue, 19 Jan 2021 18:37:24 -0800 (PST)
Subject: Re: [PATCH v11 0/2] Add Intel LGM SoC DMA support
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, chuanhua.lei@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        malliamireddy009@gmail.com, rtanwar@maxlinear.com,
        lchuanhua@maxlinear.com
References: <cover.1610703653.git.mallikarjunax.reddy@linux.intel.com>
 <20210117055714.GJ2771@vkoul-mobl>
From:   "Reddy, MallikarjunaX" <mallikarjunax.reddy@linux.intel.com>
Message-ID: <f624ed42-f1e8-6309-2439-09f1e496015d@linux.intel.com>
Date:   Wed, 20 Jan 2021 10:37:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210117055714.GJ2771@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Ok Vinod.

Thanks,
Mallikarjuna reddy A

On 1/17/2021 1:57 PM, Vinod Koul wrote:
> On 15-01-21, 17:56, Amireddy Mallikarjuna reddy wrote:
>> Add DMA controller driver for Lightning Mountain (LGM) family of SoCs.
>>
>> The main function of the DMA controller is the transfer of data from/to any
>> peripheral to/from the memory. A memory to memory copy capability can also
>> be configured. This ldma driver is used for configure the device and channnels
>> for data and control paths.
>>
>> These controllers provide DMA capabilities for a variety of on-chip
>> devices such as SSC, HSNAND and GSWIP (Gigabit Switch IP).
>>
>> -------------
>> Future Plans:
>> -------------
>> LGM SOC also supports Hardware Memory Copy engine.
>> The role of the HW Memory copy engine is to offload memory copy operations
>> from the CPU.
> ??
>
> Please send updates against already applied patches and not an updated
> series!
>
