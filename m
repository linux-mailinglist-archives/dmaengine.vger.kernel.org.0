Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E68201EA2
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2020 01:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbgFSXbZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 19 Jun 2020 19:31:25 -0400
Received: from mga17.intel.com ([192.55.52.151]:58563 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730480AbgFSXbZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 19 Jun 2020 19:31:25 -0400
IronPort-SDR: EqpB4QRoaYRhKAkMy9LBBClhFdW6eTBgE2N2fUaKiOzHzrnZn8wXQRlSDSWnuDTsNX5G3OhR4t
 bDSgg8YkkNtw==
X-IronPort-AV: E=McAfee;i="6000,8403,9657"; a="123403550"
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="123403550"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 16:31:25 -0700
IronPort-SDR: xLtwvaWjtaHWQKnz/TlwPD49xVRdUcU8TFHQz4MXD8QUerzEqPstVlodQfZJfyVCVLjF/X+9LY
 j9N0UTCz3xxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="477780861"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.209.171.94]) ([10.209.171.94])
  by fmsmga006.fm.intel.com with ESMTP; 19 Jun 2020 16:31:24 -0700
Subject: Re: DMA Engine: Transfer From Userspace
To:     Federico Vaga <federico.vaga@cern.ch>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5614531.lOV4Wx5bFT@harkonnen>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <fe199e18-be45-cadc-8bad-4a83ed87bfba@intel.com>
Date:   Fri, 19 Jun 2020 16:31:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <5614531.lOV4Wx5bFT@harkonnen>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 6/19/2020 3:47 PM, Federico Vaga wrote:
> Hello,
> 
> is there the possibility of using a DMA engine channel from userspace?
> 
> Something like:
> - configure DMA using ioctl() (or whatever configuration mechanism)
> - read() or write() to trigger the transfer
> 

I may have supposedly promised Vinod to look into possibly providing something 
like this in the future. But I have not gotten around to do that yet. Currently, 
no such support.
