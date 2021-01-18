Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA952FA6F8
	for <lists+dmaengine@lfdr.de>; Mon, 18 Jan 2021 18:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406768AbhARRCE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Jan 2021 12:02:04 -0500
Received: from mga17.intel.com ([192.55.52.151]:48261 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406659AbhARRCA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 18 Jan 2021 12:02:00 -0500
IronPort-SDR: ELdoJcUhT5baTFH46lXWdMlrsoBxzXpkA1+1kpcu9oTwF9IYConcT8Fjkjdfg83jVDhBYkjV9V
 4qxVw1m3I/9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="158600039"
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="158600039"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 09:01:14 -0800
IronPort-SDR: EYnQgxKrSq+Z8Ni8Y2aUcD4RgtB3yVXfdYZOu7eqOXVEWHvjmQfYHInuj5n0dDOC5Sb+qEoVgN
 wQw8VIAXNG6g==
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="365389562"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.181.223]) ([10.212.181.223])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 09:01:14 -0800
Subject: Re: Query on dmaengine: add support to dynamic register/unregister of
 channels patch
To:     Radhey Shyam Pandey <radheys@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>,
        Paul Thomas <pthomas8589@gmail.com>
Cc:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
References: <BY5PR02MB6520E4FECB26ACD6DB836728C7A40@BY5PR02MB6520.namprd02.prod.outlook.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <bee9cd1c-c320-28ff-77ca-dfbf73f5a631@intel.com>
Date:   Mon, 18 Jan 2021 10:01:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <BY5PR02MB6520E4FECB26ACD6DB836728C7A40@BY5PR02MB6520.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 1/18/2021 12:54 AM, Radhey Shyam Pandey wrote:
> Hi Dave,
>
> I have a query on below patch (commit-e81274cd6b52). It causes regression
> in xilinx_dma driver and there is a reported kernel crash on rmmod.
>
> commit e81274cd6b5264809384066e09a5253708822522
> Author: Dave Jiang <dave.jiang@intel.com>
> Date:   Tue Jan 21 16:43:53 2020 -0700
>
> dmaengine: add support to dynamic register/unregister of channels
>      
> With the channel registration routines broken out, now add support code to
> allow independent registering and unregistering of channels in a hotplug
> fashion.
>
> Crash on the unloading xilinx_dma module is reproducible after e81274cd6b526
> mainline commit is added in the 5.6 kernel.
>
> [   42.142705] Internal error: Oops: 96000044 [#1] SMP
> [   42.147566] Modules linked in: xilinx_dma(-) clk_xlnx_clock_wizard
> uio_pdrv_genirq
> [   42.155139] CPU: 1 PID: 2075 Comm: rmmod Not tainted
> 5.10.1-00026-g3a2e6dd7a05-dirty #192
> [   42.163302] Hardware name: Enclustra XU5 SOM (DT)
> [   42.167992] pstate: 40000005 (nZcv daif -PAN -UAO -TCO BTYPE=--)
> [   42.173996] pc : xilinx_dma_chan_remove+0x74/0xa0 [xilinx_dma]
> [   42.179815] lr : xilinx_dma_chan_remove+0x70/0xa0 [xilinx_dma]
> [   42.185636] sp : ffffffc01112bca0
> [   42.188935] x29: ffffffc01112bca0 x28: ffffff80402ea640
>
>
> xilinx_dma_chan_remove+0x74/0xa0:
> __list_del at ./include/linux/list.h:112 (inlined by)
>   __list_del_entry at./include/linux/list.h:135 (inlined by)
> list_del at ./include/linux/list.h:146 (inlined by)
> xilinx_dma_chan_remove at drivers/dma/xilinx/xilinx_dma.c:2546
>
> Looking into e81274cd6b526 commit - It deletes channel device_node entry.
> Same channel device_node entry is also deleted in
> xilinx_dma_chan_remove as a result we see this crash.
>
> @@ -993,12 +1007,22 @@ static
> void __dma_async_device_channel_unregister(struct dma_device *device,
>                    "%s called while %d clients hold a reference\n",
>                    __func__, chan->client_count);
>          mutex_lock(&dma_list_mutex);
> +       list_del(&chan->device_node);
> +       device->chancnt--;
>
> I want to know some background for this change.  In dmaengine driver -
> we are adding channel device node entry so deleting it in the exit
> the path should be done in dmaengine driver and not in _channel_unregister?

Yes you are correct. It seems we need to remove that and push the 
management to the driver as that seems to be the way. The chancnt will 
continue to be managed by dmaengine. I'll create a fix.


>
> NOTE:  This issue is reported in https://www.spinics.net/lists/dmaengine/msg24923.html
>
> Thanks,
> Radhey
