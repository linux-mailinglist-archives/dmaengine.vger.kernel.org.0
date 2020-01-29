Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4DA14C5DB
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jan 2020 06:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgA2F3j (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jan 2020 00:29:39 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:48951 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgA2F3j (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 29 Jan 2020 00:29:39 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 486sVm2BfSz9sPW;
        Wed, 29 Jan 2020 16:29:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1580275776;
        bh=pHwGwtOAVJ9TnzSVuPy5VmTYAx1l6PoUUub/aiK1wwo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Y90O7yK2wwBKXKgGqeryzb1XuKLpTkvrkbORegBzJWY+/5coWv9J/SDXOBuYnMzV7
         tnUzmF4hVKFyDiUqqjB7jsmkA49NMDHn+k8t14If5dzUr9srs37K4X8JE+rWfaQErO
         z+kijznKJDvF20+jfybcfIEQFqZCby0bOHtWLE9tkPmuJcnzgLS/XyBk8gYMv3BB65
         SZ35YJ3wTSINy4L8ro/wbE/L7pg6APuLTY/8xN3t2r2GYMT/kVG3yKccA2vvKcyUKg
         pzqqorKCPfTOCoKWcUxeH0xJmNO4jVrOL5Qqy04NaYXReqCtP+H4ZhRotL0SFCEea+
         zYESTIFuK1jPQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     peter.ujfalusi@ti.com, dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, corbet@lwn.net,
        linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Docs build broken by driver-api/dmaengine/client.rst ? (was Re: [GIT PULL]: dmaengine updates for v5.6-rc1)
In-Reply-To: <20200128122415.GU2841@vkoul-mobl>
References: <20200127145835.GI2841@vkoul-mobl> <87imkvhkaq.fsf@mpe.ellerman.id.au> <20200128122415.GU2841@vkoul-mobl>
Date:   Wed, 29 Jan 2020 16:29:33 +1100
Message-ID: <875zguhltu.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Vinod Koul <vkoul@kernel.org> writes:
> On 28-01-20, 22:50, Michael Ellerman wrote:
...
>
> I have modified this to below as this:
>
> --- a/Documentation/driver-api/dmaengine/client.rst
> +++ b/Documentation/driver-api/dmaengine/client.rst
> @@ -151,8 +151,8 @@ The details of these operations are:
>       Note that callbacks will always be invoked from the DMA
>       engines tasklet, never from interrupt context.
>  
> -  Optional: per descriptor metadata
> -  ---------------------------------
> +Optional: per descriptor metadata
> +---------------------------------
>    DMAengine provides two ways for metadata support.
>  
>    DESC_METADATA_CLIENT
>
> And I will add this as fixes and it should be in linux-next tomorrow

Thanks!

cheers
