Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5292F5996
	for <lists+dmaengine@lfdr.de>; Thu, 14 Jan 2021 04:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbhANDuA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Jan 2021 22:50:00 -0500
Received: from mga02.intel.com ([134.134.136.20]:14918 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbhANDt7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 13 Jan 2021 22:49:59 -0500
IronPort-SDR: /nDJhYewr+JeHUOxaBVmHDdtdIf6RJsOnwA5ZndkDMI6qc5mJ6kBbQ5oK0SnQ9SOg9rIpbV5rG
 xr1Hrr9DODgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="165392178"
X-IronPort-AV: E=Sophos;i="5.79,346,1602572400"; 
   d="scan'208";a="165392178"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 19:48:13 -0800
IronPort-SDR: 9ihKpaDZxgMq/yioalNK/DjgG+j8A0/MMSPqj02P1FPG2nwdp4glytJPZO8PAmxeKpK4MTPHvK
 rSEc9BWmF24w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,346,1602572400"; 
   d="scan'208";a="572219502"
Received: from imail001.iil.intel.com ([10.184.82.104])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jan 2021 19:48:10 -0800
Received: from [10.215.249.35] (cheolyon-MOBL.gar.corp.intel.com [10.215.249.35])
        by imail001.iil.intel.com with ESMTP id 10E3mClv007474;
        Thu, 14 Jan 2021 05:48:13 +0200
Subject: Re: [PATCH v10 0/2] Add Intel LGM SoC DMA support
To:     Vinod Koul <vkoul@kernel.org>, Rahul Tanwar <rtanwar@maxlinear.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, chuanhua.lei@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        malliamireddy009@gmail.com, peter.ujfalusi@ti.com,
        ckim@maxlinear.com, "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>,
        Lei Chuan Hua <lchuanhua@maxlinear.com>,
        Amireddy Mallikarjuna reddy 
        <mallikarjunax.reddy@linux.intel.com>
References: <cover.1606905330.git.mallikarjunax.reddy@linux.intel.com>
 <20210112122905.GR2771@vkoul-mobl>
From:   "Kim, Cheol Yong" <cheol.yong.kim@linux.intel.com>
Message-ID: <b3d0aa18-4000-afa7-a59d-b3143ec152f7@linux.intel.com>
Date:   Thu, 14 Jan 2021 11:47:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210112122905.GR2771@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Thanks! Vinod

Added relevant people for maintenance. Rahul <rtanwar@maxlinear.com>  
and Chuan Hua <lchuanhua@maxlinear.com>

On 1/12/2021 8:29 PM, Vinod Koul wrote:
> On 03-12-20, 12:10, Amireddy Mallikarjuna reddy wrote:
>> Add DMA controller driver for Lightning Mountain (LGM) family of SoCs.
>>
>> The main function of the DMA controller is the transfer of data from/to any
>> peripheral to/from the memory. A memory to memory copy capability can also
>> be configured. This ldma driver is used for configure the device and channnels
>> for data and control paths.
>>
>> These controllers provide DMA capabilities for a variety of on-chip
>> devices such as SSC, HSNAND and GSWIP (Gigabit Switch IP).
>
> Applied after fixing tag on driver patch, thanks
>
