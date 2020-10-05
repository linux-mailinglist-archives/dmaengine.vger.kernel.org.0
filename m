Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592E0282FB0
	for <lists+dmaengine@lfdr.de>; Mon,  5 Oct 2020 06:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgJEEnJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Oct 2020 00:43:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgJEEnJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 5 Oct 2020 00:43:09 -0400
Received: from localhost (unknown [171.61.67.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BA7B2080C;
        Mon,  5 Oct 2020 04:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601872988;
        bh=MbbLBYuegn4YgXarPqMDqfjSYeEDqbxc8UP6ULFWH0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W0fSppHdhWuFT9YHpB4xBOg7lFMAreACU7THiyvRNdYqo5n5sed2I5uXJ9ylaxKWQ
         oeyhKpDuJPugXRHVQEd3s30J88jBJ5UGKTcce0i4fbDlU+7dTqAQCQ+txsivZtdcBw
         yBYiYOj8FlxrC0tUshVFu2uDCCTKrKaJJ4AiheWo=
Date:   Mon, 5 Oct 2020 10:13:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        fenghua.yu@intel.com, kevin.tian@intel.com,
        David.Laight@aculab.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/5] dmaengine: idxd: Add ABI documentation for shared
 wq
Message-ID: <20201005044304.GG2968@vkoul-mobl>
References: <20200924180041.34056-1-dave.jiang@intel.com>
 <20200924180041.34056-6-dave.jiang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924180041.34056-6-dave.jiang@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-09-20, 11:00, Dave Jiang wrote:
> Add the sysfs attribute bits in ABI/stable for shared wq support.

OK I take back the documentation comment now....

> 
> Signed-off-by: Jing Lin <jing.lin@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  Documentation/ABI/stable/sysfs-driver-dma-idxd | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
> index b44183880935..42d3dc03ffea 100644
> --- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
> +++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
> @@ -77,6 +77,13 @@ Contact:        dmaengine@vger.kernel.org
>  Description:    The operation capability bit mask specify the operation types
>  		supported by the this device.
>  
> +What:		/sys/bus/dsa/devices/dsa<m>/pasid_enabled
> +Date:		Sep 17, 2020
> +KernelVersion:	5.10.0
> +Contact:	dmaengine@vger.kernel.org
> +Description:	To indicate if PASID (process address space identifier) is
> +		enabled or not for this device.
> +
>  What:           /sys/bus/dsa/devices/dsa<m>/state
>  Date:           Oct 25, 2019
>  KernelVersion:  5.6.0
> @@ -122,6 +129,13 @@ KernelVersion:	5.10.0
>  Contact:	dmaengine@vger.kernel.org
>  Description:	The last executed device administrative command's status/error.
>  
> +What:		/sys/bus/dsa/devices/wq<m>.<n>/block_on_fault
> +Date:		Sept 17, 2020
> +KernelVersion:	5.10.0
> +Contact:	dmaengine@vger.kernel.org
> +Description:	To indicate block on fault is allowed or not for the work queue
> +		to support on demand paging.
> +
>  What:           /sys/bus/dsa/devices/wq<m>.<n>/group_id
>  Date:           Oct 25, 2019
>  KernelVersion:  5.6.0
> -- 
> 2.21.3

-- 
~Vinod
