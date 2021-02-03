Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672E730E332
	for <lists+dmaengine@lfdr.de>; Wed,  3 Feb 2021 20:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhBCTX7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Feb 2021 14:23:59 -0500
Received: from mga11.intel.com ([192.55.52.93]:16278 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231801AbhBCTXz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 3 Feb 2021 14:23:55 -0500
IronPort-SDR: t9DISk4ZhQwchBxTUw8hc1RQ8G3cFgLxzXVAmUPoMtvfpwCRu8IY+3WDxRoGj2Qa0I13Wd/Maq
 WzbCAqscub7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="177595332"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="177595332"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 11:23:05 -0800
IronPort-SDR: PvH66FiX93h9r8ZDZFKobESepSQLYgc7x5WQNLPfBQY+jueYgPBgmh/1bI+VIlmJzSN5fGzLNf
 4oQPsZadU+Tw==
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="433580596"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.2.151]) ([10.213.2.151])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 11:23:03 -0800
Subject: Re: [PATCH] Revert "dmaengine: dw: Enable runtime PM"
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        viresh kumar <vireshk@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
References: <20210203155100.15034-1-cezary.rojewski@intel.com>
 <CAHp75VeuL0d48JBBQrb=twQvtwh4E_oB8Aszy+GtszhNWKqAmg@mail.gmail.com>
 <CAHp75Vc-By8mNzBoMqVSNac_yjX3J_Tv24pSxAw1FEFHTAwFLA@mail.gmail.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <5dd21b4c-2159-5a79-f33f-f199cf352db4@intel.com>
Date:   Wed, 3 Feb 2021 20:23:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc-By8mNzBoMqVSNac_yjX3J_Tv24pSxAw1FEFHTAwFLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2021-02-03 6:08 PM, Andy Shevchenko wrote:
> On Wed, Feb 3, 2021 at 7:06 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>>
>> On Wed, Feb 3, 2021 at 5:53 PM Cezary Rojewski
>> <cezary.rojewski@intel.com> wrote:
>>>
>>> This reverts commit 842067940a3e3fc008a60fee388e000219b32632.
>>> For some solutions e.g. sound/soc/intel/catpt, DW DMA is part of a
>>> compound device (in that very example, domains: ADSP, SSP0, SSP1, DMA0
>>> and DMA1 are part of a single entity) rather than being a standalone
>>> one. Driver for said device may enlist DMA to transfer data during
>>> suspend or resume sequences.
>>>
>>> Manipulating RPM explicitly in dw's DMA request and release channel
>>> functions causes suspend() to also invoke resume() for the exact same
>>> device. Similar situation occurs for resume() sequence. Effectively
>>> renders device dysfunctional after first suspend() attempt. Revert the
>>> change to address the problem.
>>
>> I kinda had the mixed feelings about this, thanks for the report.
> 
> Side note: the better solution in general seems to have a specific
> power domain for the ASoC multi-function devices (if ever you move to
> use auxiliary bus, it may be done easier I think).

This is an area I haven't touched yet. Will definitely check it out.

Thanks for the recommendations, Andy. Much appreciated.

Regards,
Czarek
