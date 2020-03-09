Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8B1B17E44B
	for <lists+dmaengine@lfdr.de>; Mon,  9 Mar 2020 17:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgCIQI7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Mar 2020 12:08:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:46874 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgCIQI7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 9 Mar 2020 12:08:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 09:08:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,533,1574150400"; 
   d="scan'208";a="288726374"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Mar 2020 09:08:57 -0700
Subject: Re: [PATCH] MAINTAINERS: rectify the INTEL IADX DRIVER entry
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, Joe Perches <joe@perches.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200307205737.5829-1-lukas.bulwahn@gmail.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <26c4fdca-4a36-d710-0504-569adf5ec079@intel.com>
Date:   Mon, 9 Mar 2020 09:08:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200307205737.5829-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 3/7/20 1:57 PM, Lukas Bulwahn wrote:
> Commit bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data
> accelerators") added the INTEL IADX DRIVER entry in MAINTAINERS, which
> mentions include/linux/idxd.h as file entry. However, this header file was
> not added in this commit, nor in any later one.
> 
> Hence, since then, ./scripts/get_maintainer.pl --self-test complains:
> 
>    warning: no file matches F: include/linux/idxd.h
> 
> Drop the file entry to the non-existing file in INTEL IADX DRIVER now.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thanks. That was a mistake.

Acked-by: Dave Jiang <dave.jiang@intel.com>



> ---
> applies cleanly on current master and next-20200306
> 
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c93e4937164c..303e1ea83484 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8478,7 +8478,6 @@ L:	dmaengine@vger.kernel.org
>   S:	Supported
>   F:	drivers/dma/idxd/*
>   F:	include/uapi/linux/idxd.h
> -F:	include/linux/idxd.h
>   
>   INTEL IDLE DRIVER
>   M:	Jacob Pan <jacob.jun.pan@linux.intel.com>
> 
