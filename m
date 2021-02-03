Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB1530E32B
	for <lists+dmaengine@lfdr.de>; Wed,  3 Feb 2021 20:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbhBCTWX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Feb 2021 14:22:23 -0500
Received: from mga18.intel.com ([134.134.136.126]:30054 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232537AbhBCTWW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 3 Feb 2021 14:22:22 -0500
IronPort-SDR: HmPgQe5LkTSlsiWXG/UCFs26TBVdY6p1Rg1qls4MrqLnuWyXAjKEorFIA6K/o0NBwWkjhq0ULP
 QIpFjRaT8k9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="168783439"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="168783439"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 11:21:41 -0800
IronPort-SDR: c7BbC7er/Y3isxxf17IArJ9L2B97uO3qhVTNANLHGWtu2nREckNiAKEIddxIZJzDj+PjzHskhL
 BM2DjRCQD2lw==
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="433580143"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.2.151]) ([10.213.2.151])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 11:21:37 -0800
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
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <cdb0eaaf-5b00-e4af-29c9-2328fd23fbd2@intel.com>
Date:   Wed, 3 Feb 2021 20:21:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VeuL0d48JBBQrb=twQvtwh4E_oB8Aszy+GtszhNWKqAmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2021-02-03 6:06 PM, Andy Shevchenko wrote:
> On Wed, Feb 3, 2021 at 5:53 PM Cezary Rojewski
> <cezary.rojewski@intel.com> wrote:
>>
>> This reverts commit 842067940a3e3fc008a60fee388e000219b32632.
>> For some solutions e.g. sound/soc/intel/catpt, DW DMA is part of a
>> compound device (in that very example, domains: ADSP, SSP0, SSP1, DMA0
>> and DMA1 are part of a single entity) rather than being a standalone
>> one. Driver for said device may enlist DMA to transfer data during
>> suspend or resume sequences.
>>
>> Manipulating RPM explicitly in dw's DMA request and release channel
>> functions causes suspend() to also invoke resume() for the exact same
>> device. Similar situation occurs for resume() sequence. Effectively
>> renders device dysfunctional after first suspend() attempt. Revert the
>> change to address the problem.
> 
> I kinda had the mixed feelings about this, thanks for the report.
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Fixes tag?

Noted, sent v2 with updated tag area.

Thanks,
Czarek
