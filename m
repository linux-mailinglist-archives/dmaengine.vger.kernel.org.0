Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73B1BD5D67
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2019 10:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbfJNI2W (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Oct 2019 04:28:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729928AbfJNI2W (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 14 Oct 2019 04:28:22 -0400
Received: from localhost (unknown [122.167.124.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26CDA20673;
        Mon, 14 Oct 2019 08:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571041702;
        bh=jKgNaP0v8cTTDhEPs2ezN75/xaUqdo1htn1yKOHPl9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xVk461+GjC4lyAV0WuRDS0ehfTQX26cye94VMCfNOBC/ddERjWNUKTkt50ibpBvzc
         N4OsIlIyVkBQYCBA01ljNR7y/nPhjKdYw551Y6mcNWGtRPO1Wzc2SnuEyMUczsk8Sp
         OOb1HEKX9Yy+I0rzIfEpnyys2PCO4j46YI75cubY=
Date:   Mon, 14 Oct 2019 13:58:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: iop-adma: make array 'handler' static const,
 makes object smaller
Message-ID: <20191014082817.GO2654@vkoul-mobl>
References: <20190905163726.19690-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905163726.19690-1-colin.king@canonical.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-09-19, 17:37, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the array 'handler' on the stack but instead make it
> static const. Makes the object code smaller by 80 bytes.
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   38225	   9084	     64	  47373	   b90d	drivers/dma/iop-adma.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   38081	   9148	     64	  47293	   b8bd	drivers/dma/iop-adma.o
> 
> (gcc version 9.2.1, amd64)

Applied, thanks

-- 
~Vinod
