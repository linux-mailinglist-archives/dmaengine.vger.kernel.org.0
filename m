Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0630A484611
	for <lists+dmaengine@lfdr.de>; Tue,  4 Jan 2022 17:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbiADQiv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Jan 2022 11:38:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:1249 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235378AbiADQiv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 4 Jan 2022 11:38:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641314331; x=1672850331;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yrlkfkw0EATYTcD13m01vf/iKb4S1IVr6BflCrHC4vI=;
  b=lz2I2SPHLGpLd8x849WPMPoZuUtZsgRrw5dSyj+46deZwRq5ewqKHGT1
   akRqC+CFdZ8mKwJaVWON1zKaRXGnvyfaO43fkiG1h/T6sp4+k8XHzE/Ln
   o7yKAzuOUcIJF8BI5PLVj7TnkpGW5IVjd0FI4BetK1CeU8YtTDoeIIbE+
   AUKR8c5n/A5wsUt6OAXMssLxaboltxG/Ljyf/XT4VkbkeB9kXfD5ic8Wb
   a0Jgdy/hB3w+FL3I78KFCDRAFxwjMU6TnsHGJX7WpKXX+85pRHOnbSbDy
   RYPtpjTySddmE9ZvWSMb0v8lveWSS325uey2+HsrguUpho/2zvsXAPhs2
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="242211648"
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="242211648"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 08:38:46 -0800
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="526311879"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.114.22]) ([10.212.114.22])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 08:38:45 -0800
Message-ID: <d5a34c44-82e1-1d7c-1bb2-3fe257d6a572@intel.com>
Date:   Tue, 4 Jan 2022 09:38:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] dmaengine: ioatdma: use default_groups in kobj_type
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
References: <20220104163330.1338824-1-gregkh@linuxfoundation.org>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220104163330.1338824-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 1/4/2022 9:33 AM, Greg Kroah-Hartman wrote:
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the ioatdma sysfs code to use default_groups field which has
> been the preferred way since aa30f47cf666 ("kobject: Add support for
> default attribute groups to kobj_type") so that we can soon get rid of
> the obsolete default_attrs field.
>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Dave Jiang <dave.jiang@intel.com>


> ---
>   drivers/dma/ioat/sysfs.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
> index aa44bcd6a356..168adf28c5b1 100644
> --- a/drivers/dma/ioat/sysfs.c
> +++ b/drivers/dma/ioat/sysfs.c
> @@ -158,8 +158,9 @@ static struct attribute *ioat_attrs[] = {
>   	&intr_coalesce_attr.attr,
>   	NULL,
>   };
> +ATTRIBUTE_GROUPS(ioat);
>   
>   struct kobj_type ioat_ktype = {
>   	.sysfs_ops = &ioat_sysfs_ops,
> -	.default_attrs = ioat_attrs,
> +	.default_groups = ioat_groups,
>   };
