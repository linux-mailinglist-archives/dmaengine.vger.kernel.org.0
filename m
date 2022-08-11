Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B38590739
	for <lists+dmaengine@lfdr.de>; Thu, 11 Aug 2022 22:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiHKUIY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 11 Aug 2022 16:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHKUIX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 11 Aug 2022 16:08:23 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B6D9C519
        for <dmaengine@vger.kernel.org>; Thu, 11 Aug 2022 13:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660248502; x=1691784502;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=waqphrTivF4ISb43ZPnYznnaBqQD7VQ8UN36rs3U6qk=;
  b=H6lHPA+O7/92AmnIbGUF9Ij7BGuxtoTchhtQ1L9Tzgsori/ZPdov4+fz
   0o++NjZGhaiutC60W5mWLzD5UlrDW9/XBNeBPaoEfgBAQww5nc1VV22ec
   8BxvCCz2jVNY/QbC5zPwK379ZdbgAUT/MuLZ2xDV4gU2bPqdOnVrnpuME
   4Ue+7baSFJkDv+GwPnOVJqEfitMEcJE9XMeVb31cix15GonCEcu7QL7pV
   Nvq8SV3YsJbtU9FC7HqrIUreld/7U+9PcRMFp+c7ftBXTgrPrOvGs+T+k
   XFvcR4+Bxy4wTLcvYgOYVnz2hf6IzNTO8obsTb7wHEFI65OSEut1xkxXv
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="317417407"
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="317417407"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 13:08:22 -0700
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="933457811"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.81.242]) ([10.212.81.242])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 13:08:22 -0700
Message-ID: <12454f71-125d-cee4-bfa0-63cdd6be9aec@intel.com>
Date:   Thu, 11 Aug 2022 13:08:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: Question about using a DMA/XOR offload engine for md raid5/6.
Content-Language: en-US
To:     Don.Brace@microchip.com, dmaengine@vger.kernel.org
References: <CY4PR11MB12385444DFDB1343F28A41B4E1659@CY4PR11MB1238.namprd11.prod.outlook.com>
 <725501fb-f559-2825-1533-4aca8177d87d@intel.com>
 <CY4PR11MB1238EE0B3F97F98619E6AB49E1649@CY4PR11MB1238.namprd11.prod.outlook.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CY4PR11MB1238EE0B3F97F98619E6AB49E1649@CY4PR11MB1238.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 8/11/2022 12:53 PM, Don.Brace@microchip.com wrote:
> Thanks for your reply.
>
> I'm running on a ProLiant ML110 Gen10 with Intel(R) Xeon(R) Silver 4210R CPU @ 2.40GHz
So that's a Cascade Lake CPU. XOR and PQ are not officially supported 
with IOATDMA of that CPU. Also even if it were, you need a pretty old 
kernel to get that support (maybe 4.x kernel?). It's been deprecated for 
a while now.
>
> I enabled the dmatest driver and the ioat driver and see this when I load the dmatest driver with
> modprobe dmatest timeout=2000 iterations=1 channel=dma0chan0 run=1
>
>
> [ 3527.129243] ioatdma 0000:00:04.0: ioat_check_space_lock: num_descs: 1 (1:1:1)
> [ 3527.129256] ioatdma 0000:00:04.0: desc[1]: (0xfff00040->0xfff00080) cookie: 0 flags: 0x0 ctl: 0x00000000 (op: 0x0 int_en: 0 compl: 0)
> [ 3527.129268] ioatdma 0000:00:04.0: desc[1]: (0xfff00040->0xfff00080) cookie: 0 flags: 0x3 ctl: 0x00000009 (op: 0x0 int_en: 1 compl: 1)
> [ 3527.129276] ioatdma 0000:00:04.0: ioat_tx_submit_unlock: cookie: 4
> [ 3527.129282] ioatdma 0000:00:04.0: __ioat_issue_pending: head: 0x2 tail: 0x1 issued: 0x2 count: 0x2
> [ 3527.129289] ioatdma 0000:00:04.0: ioat_get_current_completion: phys_complete: 0xfff00040
> [ 3527.129295] ioatdma 0000:00:04.0: __cleanup: head: 0x2 tail: 0x1 issued: 0x2
> [ 3527.129300] ioatdma 0000:00:04.0: desc[1]: (0xfff00040->0xfff00080) cookie: 4 flags: 0x3 ctl: 0x00000009 (op: 0x0 int_en: 1 compl: 1)
> [ 3527.129310] ioatdma 0000:00:04.0: __cleanup: cancel completion timeout
> [ 3527.129321] dmatest: dma0chan0-copy0: verifying source buffer...
> [ 3527.129376] dmatest: dma0chan0-copy0: verifying dest buffer...
> [ 3527.129429] dmatest: dma0chan0-copy0: result #1: 'test passed' with src_off=0xa64 dst_off=0xe7c len=0x17ec (0)
> [ 3527.129439] dmatest: dma0chan0-copy0: summary 1 tests, 0 failures 9523.80 iops 47619 KB/s (0)
>
>
> Is there a better way to enable tracing to follow what the md raid456 driver is doing?

Maybe look at event tracing for block? I see some trace calls in drivers/md/


>
> From: Dave Jiang <dave.jiang@intel.com>
> Sent: Wednesday, August 10, 2022 7:27 PM
> To: Don Brace - C33706 <Don.Brace@microchip.com>; dmaengine@vger.kernel.org <dmaengine@vger.kernel.org>
> Subject: Re: Question about using a DMA/XOR offload engine for md raid5/6.
>   
> [You don't often get email from dave.jiang@intel.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>
> On 8/10/2022 3:45 PM, Don.Brace@microchip.com wrote:
>> I have been reading the kernel documentation about using a dmengine provider/client to see if the md driver will utilize a DMA engine when doing XOR and Crypto operations.
>>
>> I notice that the drivers/md/raid5.c calls async_xor_offs() which is found in crypto/async_tx/async_xor.c and it is calling async_tx_find_channel().
>> So, I think the answer is yes if a DMA engine is enabled in the kernel.
>>
>> Is this correct? I did some tracing while doing I/O to my raid5 with
>> crypto enabled and see the above functions called but unsure of how data
>>     flows through each driver and if I am even using a DMA offload.
> What platform are you running on? There are some ARM SOC DMA engines
> that support XOR such as the Marvell chip (mv_xor) as I recall. Intel
> Xeon platforms supported that long while ago. But that has been removed
> since Skylake. If you do a grep in drivers/dma/ for DMA_XOR where the
> driver calls dma_cap_set(DMA_XOR, ...) you can see which drivers
> supports RAID5 offload.
>
>
>> I have the following drivers loaded:
>> lsmod | grep raid
>> raid456               188416  2
>> async_raid6_recov      24576  1 raid456
>> async_memcpy           20480  2 raid456,async_raid6_recov
>> async_pq               20480  2 raid456,async_raid6_recov
>> async_xor              20480  3 async_pq,raid456,async_raid6_recov
>> async_tx               20480  5 async_pq,async_memcpy,async_xor,raid456,async_raid6_recov
>> raid6_pq              122880  3 async_pq,raid456,async_raid6_recov
>> libcrc32c              16384  5 nf_conntrack,nf_nat,nf_tables,xfs,raid456
>>
>> Is there a diagram somewhere that provides any details?
>>
>> I made the raid5 with crypto using
>> mdadm
>>     --create /dev/md/raid5 --force --assume-clean --verbose --level=5
>> --chunk=512K --metadata=1 --data-offset=2048s --raid-devices=5
>> /dev/mapper/mpathb /dev/mapper/mpathc /dev/mapper/mpathd
>> /dev/mapper/mpathe /dev/mapper/mpathl
>> cryptsetup -v luksFormat /dev/md/raid5Crypto
>> cryptsetup luksOpen  /dev/md/raid5Crypto testCrypto
>> mkfs.ext4 /dev/mapper/testCrypto
>>
> modprobe dmatest timeout=2000 iterations=1 channel=dma0chan0 run=1
