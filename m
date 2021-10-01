Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B2A41ECC6
	for <lists+dmaengine@lfdr.de>; Fri,  1 Oct 2021 14:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354210AbhJAMCc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Oct 2021 08:02:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354141AbhJAMCb (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 1 Oct 2021 08:02:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E62F61A85;
        Fri,  1 Oct 2021 12:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633089647;
        bh=dlFohkdyq4B3ChcKaI0Uh88n7YiWcgS8pefiGzDjOXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h267QHBVglJ5HU3jQ/1Mj5NLl4Mkdkkvyvp7kwvOkY1Upd6Xhr7fjimI/F6NfvQ54
         0x3msTrnmpaDAHrdfVObAQIntRMGjRqST/3ayer4POOJrirJqxT+2DxvzU77S4Hyny
         T1b0K/qWI7AtSks0l6USgco/t50I5CNsESi/dRJdz3OVx+asaTpJv5BS7Vf7x83f0s
         ZVAbEqtwfQR0TT2QjA+Hc2anGr5+n0vn+zE7b4QQkkdGPlp4wCukYKGBexNYp6Oh3a
         jOUUqUTjtvhvz9LwZ6C9ik7FtOT7WoyE5XoxoQvsjJa1Op7HDBaGnbX5X1EsqcBv8k
         /RGRUzAA2qgCA==
Date:   Fri, 1 Oct 2021 17:30:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Qing Wang <wangqing@vivo.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] dma: plx_dma: switch from 'pci_' to 'dma_' API
Message-ID: <YVb4a0CN/X/T+voq@matsya>
References: <1632800542-108522-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1632800542-108522-1-git-send-email-wangqing@vivo.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-09-21, 20:42, Qing Wang wrote:
> The wrappers in include/linux/pci-dma-compat.h should go away.
> 
> The patch has been generated with the coccinelle script below.
> expression e1, e2;
> @@
> -    pci_set_dma_mask(e1, e2)
> +    dma_set_mask(&e1->dev, e2)
> 
> @@
> expression e1, e2;
> @@
> -    pci_set_consistent_dma_mask(e1, e2)
> +    dma_set_coherent_mask(&e1->dev, e2)
> 
> While at it, some 'dma_set_mask()/dma_set_coherent_mask()' have been
> updated to a much less verbose 'dma_set_mask_and_coherent()'.

the susbsystem tag is dmaengine: pls use that and send a series for
similar stuff, no point is having different patches

-- 
~Vinod
