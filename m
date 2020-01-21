Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E05714438C
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jan 2020 18:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgAURrG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Jan 2020 12:47:06 -0500
Received: from mga12.intel.com ([192.55.52.136]:32281 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728829AbgAURrG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 Jan 2020 12:47:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 09:46:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,346,1574150400"; 
   d="scan'208";a="227406516"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga003.jf.intel.com with ESMTP; 21 Jan 2020 09:46:55 -0800
Subject: Re: [PATCH v4 0/9] idxd driver for Intel Data Streaming Accelerator
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com, megha.dey@intel.com,
        jacob.jun.pan@intel.com, yi.l.liu@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, fenghua.yu@intel.com, hpa@zytor.com
References: <157842940405.27241.1146722525082010210.stgit@djiang5-desk3.ch.intel.com>
 <20200121091558.GF2841@vkoul-mobl>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <4d619880-af1c-dc29-acdb-ff935f9f662c@intel.com>
Date:   Tue, 21 Jan 2020 10:46:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200121091558.GF2841@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 1/21/20 2:15 AM, Vinod Koul wrote:
> Hi Dave,
> 
> On 07-01-20, 13:40, Dave Jiang wrote:
>> v4:
>> Borislav:
>> - Merge unused __iowrite512() into iosubmit_cmds512().
>> - Fix various comments for iosubmit_cmds512() patch.
>> Vinod:
>> - Drop dmanegine request API and supporting code
>> - Update to use existing dmaengine API
> 
> This looks okay to me but needs a rebase on top of dmaengine-next,
> Peters patches applied earlier move code around a bit

Not a problem. I will get on that. Thanks!

> 
> Thanks
> 
