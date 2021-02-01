Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B3330A1CF
	for <lists+dmaengine@lfdr.de>; Mon,  1 Feb 2021 07:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbhBAGCl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 Feb 2021 01:02:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:58234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231858AbhBAGAM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 1 Feb 2021 01:00:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1986F64E2A;
        Mon,  1 Feb 2021 05:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612159165;
        bh=CeJC55H3/xwTv2a4Y3zjX/fqjXeFNWlxPycOqvLIng0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PYS6ecaJAG0x/LbGl3Nl1jfNE0VfiTe9uYPd5OhVm1bY99ch37M+MQX987CYReA9Y
         s3SaSzeALhLDjgx8RqaImMyakUpNfJaRRYTV0GCnCyx9ikpoh/VrwF06sdUsvO/8t+
         CsB7zla59HnJ85iSWm4ajqIXu4oCTEXcvq0WZlxWOX0Kv0EHm0XvANbvlUCjNcCPxE
         S+tmopmpNI3y0TK8eEjGGwTiQ7Cr6qsJsZ+wUM2HPgrFPOPySBTcuUON4tjQXXT6aN
         d63DAFBJ8XwHzUWNTYLZBAYxW6SkPQiO+5+E1G53AOilLbRKmDnwbVNGhbDkruSv/G
         BX3oZoIX9fn4w==
Date:   Mon, 1 Feb 2021 11:29:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] dmaengine: ti: k3-psil: optimize struct
 psil_endpoint_config for size
Message-ID: <20210201055920.GJ2771@vkoul-mobl>
References: <20210129193117.28833-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129193117.28833-1-grygorii.strashko@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-01-21, 21:31, Grygorii Strashko wrote:
> Optimize struct psil_endpoint_config for size by
> - reordering fields
> - grouping bitfields
> - change mapped_channel_id type to s16 (32K channel is enough)
> - default_flow_id type to s16 as it's assigned to -1
> 
> before:
> text            data     bss    dec	        hex	filename
> 12654100	5211472	 666904	18532476	11ac87c	vmlinux
> 
> after:
> 12654100	5208528	 666904	18529532	11abcfc	vmlinux
> 
> diff: 2944 bytes

Applied, thanks

-- 
~Vinod
