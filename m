Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1EA2A2D26
	for <lists+dmaengine@lfdr.de>; Mon,  2 Nov 2020 15:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgKBOmB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Nov 2020 09:42:01 -0500
Received: from mga02.intel.com ([134.134.136.20]:42107 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgKBOmA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 2 Nov 2020 09:42:00 -0500
IronPort-SDR: OqqDJhooQDjKhVKlzgh/Ap67roQEdw9dzCsVLsW80B2ExVggj7C7B44lFVCSS8ovg7OKvq0ZsT
 Ld0+ssIJnqmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9792"; a="155881046"
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; 
   d="scan'208";a="155881046"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 06:41:59 -0800
IronPort-SDR: ex1tWBcSp/TxhNC24k34383oyQ8zr8wuTlCNVa6YLNXDK1k0YF20c+xHoTOXZNjSfIa/FGoUff
 QEAzsIhpkxbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; 
   d="scan'208";a="526695352"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 02 Nov 2020 06:41:58 -0800
Received: from [10.249.65.176] (mreddy3x-MOBL.gar.corp.intel.com [10.249.65.176])
        by linux.intel.com (Postfix) with ESMTP id 50789580870;
        Mon,  2 Nov 2020 06:41:55 -0800 (PST)
Subject: Re: [PATCH v7 1/2] dt-bindings: dma: Add bindings for intel LGM SOC
To:     Thomas Langer <tlanger@maxlinear.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "chuanhua.lei@linux.intel.com" <chuanhua.lei@linux.intel.com>,
        "Kim, Cheol Yong" <Cheol.Yong.Kim@intel.com>,
        "Wu, Qiming" <qi-ming.wu@intel.com>,
        "malliamireddy009@gmail.com" <malliamireddy009@gmail.com>,
        "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>,
        "Langer, Thomas" <thomas.langer@intel.com>
References: <cover.1600827061.git.mallikarjunax.reddy@linux.intel.com>
 <f298715ab197ae72ab9b33caee2a19cc3e8be3f5.1600827061.git.mallikarjunax.reddy@linux.intel.com>
 <DM6PR19MB3594E466A1B76229EC1395BABB160@DM6PR19MB3594.namprd19.prod.outlook.com>
From:   "Reddy, MallikarjunaX" <mallikarjunax.reddy@linux.intel.com>
Message-ID: <9882db7a-755b-84c9-b132-1839dea5e6b8@linux.intel.com>
Date:   Mon, 2 Nov 2020 22:41:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB3594E466A1B76229EC1395BABB160@DM6PR19MB3594.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Thomas,
Thanks for the review, my comments inline.

On 10/28/2020 3:24 AM, Thomas Langer wrote:
> Hello Reddy,
>
> I think "Intel" should always be written with a capital "I" (like in the Subject, but except in the binding below)
OK.
>
>> + compatible:
>> +  oneOf:
>> +   - const: intel,lgm-cdma
>> +   - const: intel,lgm-dma2tx
>> +   - const: intel,lgm-dma1rx
>> +   - const: intel,lgm-dma1tx
>> +   - const: intel,lgm-dma0tx
>> +   - const: intel,lgm-dma3
>> +   - const: intel,lgm-toe-dma30
>> +   - const: intel,lgm-toe-dma31
> Bindings are normally not per instance.
> What if next generation chip gets more DMA modules but has no other changes in the HW block?
> What is wrong with
>    - const: intel,lgm-cdma
>    - const: intel,lgm-hdma
> and extra attributes to define the rx/tx restriction (or what do it mean?)?
>  From the driver code I saw that "toe" is also just of type "hdma" and no further differences in code are done.
We had a discussion on the same in the previous patches and Rob Herring 
said Okay using Different compatibles.
below the snippet.
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 >>> + compatible:
 >>> +  anyOf:
 >>> +   - const: intel,lgm-cdma
 >>> +   - const: intel,lgm-dma2tx
 >>> +   - const: intel,lgm-dma1rx
 >>> +   - const: intel,lgm-dma1tx
 >>> +   - const: intel,lgm-dma0tx
 >>> +   - const: intel,lgm-dma3
 >>> +   - const: intel,lgm-toe-dma30
 >>> +   - const: intel,lgm-toe-dma31
 >> Please explain why you need so many different compatible strings.
 > This hw dma has 7 DMA instances.
 > Some for datapath, some for memcpy  and some for TOE.
 > Some for TX only, some for RX only, and some for TX/RX(memcpy and ToE).
 >
 > dma TX/RX type we considered as driver specific data of each instance and
 > used different compatible strings for each instance.
 > And also idea is in future if any driver specific data of any particular
 > instance we can handle.
 >
 > Here if dma name and type(tx or rx) will be accepted as devicetree
 > attributes then we can move .name = "toe_dma31", & .type = DMA_TYPE_MCPY
 > to devicetree. So that the compatible strings can be limited to two.
 > intel,lgm-cdma & intel,lgm-hdma .

[Rob]
Different compatibles are okay if the instances are different and we
don't have properties to describe the differences.

For some of what you have in this binding, I think it should be part of
the consumer cells.
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>
> Best regards,
> Thomas
>
