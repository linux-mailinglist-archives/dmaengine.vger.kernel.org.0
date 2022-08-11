Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3381D58F53A
	for <lists+dmaengine@lfdr.de>; Thu, 11 Aug 2022 02:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbiHKA1W (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 10 Aug 2022 20:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiHKA1U (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 10 Aug 2022 20:27:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC408FD78
        for <dmaengine@vger.kernel.org>; Wed, 10 Aug 2022 17:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660177639; x=1691713639;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=A5/KKNpIu0U4yburpFPY39OjZTTSfke7bEFCtdqKCqQ=;
  b=Ll6Kv1pCjCMwTIGqYNEajUHqLHJq1+clCrT+2AEETxyQxCY9QmsfHOiS
   NVetczn9Rgdhb3WW7Z3icxAfPOZ0PSyKkDp6nk7fL/T/4QuyCpkEFUBp4
   /2oBkzcKIpEt/eukYsjwkNjOo29DX2UBCBOLdlGg1UOAXIOE2nVDe12d3
   IINpVJYVre4+uCWJv2FROM/hUboy++pFooXucy0OmyYQeK+LRqkLfUvCm
   gmCfzrhee/h+ptfok+0QVhE2tV16Gb8LopVEHJe71K5I/tB4yKhRNP/IM
   0kMnh4Ml8eCRUzQa66DbFVoNEv+TMxrVdvdH2hqYpCeVf2rrY4q/APDFK
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="288793903"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="288793903"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 17:27:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="605347903"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.15.156]) ([10.212.15.156])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 17:27:18 -0700
Message-ID: <725501fb-f559-2825-1533-4aca8177d87d@intel.com>
Date:   Wed, 10 Aug 2022 17:27:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: Question about using a DMA/XOR offload engine for md raid5/6.
Content-Language: en-US
To:     Don.Brace@microchip.com, dmaengine@vger.kernel.org
References: <CY4PR11MB12385444DFDB1343F28A41B4E1659@CY4PR11MB1238.namprd11.prod.outlook.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CY4PR11MB12385444DFDB1343F28A41B4E1659@CY4PR11MB1238.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 8/10/2022 3:45 PM, Don.Brace@microchip.com wrote:
> I have been reading the kernel documentation about using a dmengine provider/client to see if the md driver will utilize a DMA engine when doing XOR and Crypto operations.
>
> I notice that the drivers/md/raid5.c calls async_xor_offs() which is found in crypto/async_tx/async_xor.c and it is calling async_tx_find_channel().
> So, I think the answer is yes if a DMA engine is enabled in the kernel.
>
> Is this correct? I did some tracing while doing I/O to my raid5 with
> crypto enabled and see the above functions called but unsure of how data
>   flows through each driver and if I am even using a DMA offload.

What platform are you running on? There are some ARM SOC DMA engines 
that support XOR such as the Marvell chip (mv_xor) as I recall. Intel 
Xeon platforms supported that long while ago. But that has been removed 
since Skylake. If you do a grep in drivers/dma/ for DMA_XOR where the 
driver calls dma_cap_set(DMA_XOR, ...) you can see which drivers 
supports RAID5 offload.


> I have the following drivers loaded:
> lsmod | grep raid
> raid456               188416  2
> async_raid6_recov      24576  1 raid456
> async_memcpy           20480  2 raid456,async_raid6_recov
> async_pq               20480  2 raid456,async_raid6_recov
> async_xor              20480  3 async_pq,raid456,async_raid6_recov
> async_tx               20480  5 async_pq,async_memcpy,async_xor,raid456,async_raid6_recov
> raid6_pq              122880  3 async_pq,raid456,async_raid6_recov
> libcrc32c              16384  5 nf_conntrack,nf_nat,nf_tables,xfs,raid456
>
> Is there a diagram somewhere that provides any details?
>
> I made the raid5 with crypto using
> mdadm
>   --create /dev/md/raid5 --force --assume-clean --verbose --level=5
> --chunk=512K --metadata=1 --data-offset=2048s --raid-devices=5
> /dev/mapper/mpathb /dev/mapper/mpathc /dev/mapper/mpathd
> /dev/mapper/mpathe /dev/mapper/mpathl
> cryptsetup -v luksFormat /dev/md/raid5Crypto
> cryptsetup luksOpen  /dev/md/raid5Crypto testCrypto
> mkfs.ext4 /dev/mapper/testCrypto
>
