Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D34B7BDAB
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jul 2019 11:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfGaJsU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 31 Jul 2019 05:48:20 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11421 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfGaJsU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 31 Jul 2019 05:48:20 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4163e30000>; Wed, 31 Jul 2019 02:48:19 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 31 Jul 2019 02:48:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 31 Jul 2019 02:48:19 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 31 Jul
 2019 09:48:16 +0000
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
To:     Vinod Koul <vkoul@kernel.org>, Sameer Pujar <spujar@nvidia.com>
CC:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <dan.j.williams@intel.com>,
        <tiwai@suse.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sharadg@nvidia.com>,
        <rlokhande@nvidia.com>, <dramesh@nvidia.com>, <mkumard@nvidia.com>
References: <b7e28e73-7214-f1dc-866f-102410c88323@nvidia.com>
 <20190613044352.GC9160@vkoul-mobl.Dlink>
 <09929edf-ddec-b70e-965e-cbc9ba4ffe6a@nvidia.com>
 <20190618043308.GJ2962@vkoul-mobl>
 <23474b74-3c26-3083-be21-4de7731a0e95@nvidia.com>
 <20190624062609.GV2962@vkoul-mobl>
 <e9e822da-1cb9-b510-7639-43407fda8321@nvidia.com>
 <75be49ac-8461-0798-b673-431ec527d74f@nvidia.com>
 <20190719050459.GM12733@vkoul-mobl.Dlink>
 <3e7f795d-56fb-6a71-b844-2fc2b85e099e@nvidia.com>
 <20190729061010.GC12733@vkoul-mobl.Dlink>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <98954eb3-21f1-6008-f8e1-f9f9b82f87fb@nvidia.com>
Date:   Wed, 31 Jul 2019 10:48:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729061010.GC12733@vkoul-mobl.Dlink>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564566499; bh=HHdeh0Q9nVSJSKiZCGe/6zd+CdDHolqKIOG6wzk4WBk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=kl8dp3defSlJOE/ZyCyFjo7g0khae/buI9PGry7OWvtv0TK0MicYAONXN3jUCfR2/
         FwgDppb12PAG8brzUWLi+O2M9cF4LIsWFp6e/ABNJSFfQwJyTQOU1u4MDPtqSUeapu
         xv3yiiMgpVwRgMcW+RfMTxr/aG8RbJbAOVtNjFrjIjHhzauFi9y2NSCWiMjP4k3/GM
         nV50DteZoujy8tp0VF/+wBWLTlJN/WKiOw9T62QyNwK3vlWG50EoG5Q6awW84BrkHn
         VPm/eqJY7V8boYvTc7Xdzb3upbgmO9UhYUuWjchK/9LQ1GdPHBD/0KUA1I4N5OvKU1
         47VbS0LScGlxA==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 29/07/2019 07:10, Vinod Koul wrote:
> On 23-07-19, 11:24, Sameer Pujar wrote:
>>
>> On 7/19/2019 10:34 AM, Vinod Koul wrote:
>>> On 05-07-19, 11:45, Sameer Pujar wrote:
>>>> Hi Vinod,
>>>>
>>>> What are your final thoughts regarding this?
>>> Hi sameer,
>>>
>>> Sorry for the delay in replying
>>>
>>> On this, I am inclined to think that dma driver should not be involved.
>>> The ADMAIF needs this configuration and we should take the path of
>>> dma_router for this piece and add features like this to it
>>
>> Hi Vinod,
>>
>> The configuration is needed by both ADMA and ADMAIF. The size is
>> configurable
>> on ADMAIF side. ADMA needs to know this info and program accordingly.
> 
> Well I would say client decides the settings for both DMA, DMAIF and
> sets the peripheral accordingly as well, so client communicates the two
> sets of info to two set of drivers

That maybe, but I still don't see how the information is passed from the
client in the first place. The current problem is that there is no means
to pass both a max-burst size and fifo-size to the DMA driver from the
client.

IMO there needs to be a way to pass vendor specific DMA configuration
(if this information is not common) otherwise we just end up in a
scenario like there is for the xilinx DMA driver
(include/linux/dma/xilinx_dma.h) that has a custom API for passing this
information.

Cheers
Jon

-- 
nvpublic
