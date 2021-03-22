Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA326344CC9
	for <lists+dmaengine@lfdr.de>; Mon, 22 Mar 2021 18:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhCVRHR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Mar 2021 13:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbhCVRGv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Mar 2021 13:06:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725E0C061574;
        Mon, 22 Mar 2021 10:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ZSM3dI/CckcxUOL4ke1D9dDxhlhi+GbY+VaBTYOuHtk=; b=Ng69Y6C9sxOQbarSJYTyurvkdJ
        HN19yAakV7WBKbUqmy5Pnx/A7J9ykloIwQI3na+M4xWiy+pYmd+VxGcG/hruO5qDt7kWPskwUPubv
        f50vCBWToTpYR18RaY6/SPcUWZLlgYGQ3fAYT42prumMZTEEXJG3vxqXUYDsyTEzQQeGbra3Ld6xK
        gZCvDldUxGxWxvuA+sVh4174qeVCMMsldkBM4F/YotEviK+xCMQNhNbYThVuP1xMOzqP/X27Qie6E
        8nTzPfli2hyg39x1/v3uAR+z8UV06M96sdZ+NYganVq6T6X45N53rpFTGXe57XBTXfXA11YXljw1M
        Px0VXOXA==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOO0B-008p1B-Tu; Mon, 22 Mar 2021 17:06:15 +0000
Subject: Re: [PATCH v8 1/3] dmaengine: ptdma: Initial driver for the AMD PTDMA
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>, vkoul@kernel.org
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1616389172-6825-1-git-send-email-Sanju.Mehta@amd.com>
 <1616389172-6825-2-git-send-email-Sanju.Mehta@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e33e0979-6688-0da8-c5a6-6b76073dbafc@infradead.org>
Date:   Mon, 22 Mar 2021 10:06:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1616389172-6825-2-git-send-email-Sanju.Mehta@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 3/21/21 9:59 PM, Sanjay R Mehta wrote:
> From: Sanjay R Mehta <sanju.mehta@amd.com>
> 
> Add support for AMD PTDMA controller. It performs high-bandwidth
> memory to memory and IO copy operation. Device commands are managed
> via a circular queue of 'descriptors', each of which specifies source
> and destination addresses for copying a single buffer of data.
> 
> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> ---

> diff --git a/drivers/dma/ptdma/Kconfig b/drivers/dma/ptdma/Kconfig
> new file mode 100644
> index 0000000..c4f8c6f
> --- /dev/null
> +++ b/drivers/dma/ptdma/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config AMD_PTDMA
> +	tristate  "AMD PassThru DMA Engine"
> +	depends on X86_64 && PCI
> +	help
> +	  Enable support for the AMD PTDMA controller. This controller
> +	  provides DMA capabilities to performs high bandwidth memory to

	                            to perform

> +	  memory and IO copy operation. It performs DMA transfer through

better:	                     operations.

> +	  queue based descriptor management. This DMA controller is intended

	  queue-based

> +	  to use with AMD Non-Transparent Bridge devices and not for general

	  to be used with
or
	  for use with

> +	  purpose peripheral DMA.


-- 
~Randy

