Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403773D87BE
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jul 2021 08:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbhG1GPW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jul 2021 02:15:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233574AbhG1GPV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Jul 2021 02:15:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C914460295;
        Wed, 28 Jul 2021 06:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627452920;
        bh=UZLbpTMkNJx9XNrLl9ORaFnwVlTNF/WZnt0ahFZqB9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=co2TwQ8IRyzoFn91SVBLuzHs23MNwMnTcu4yp+1ZXeehNtSxkUhP0FED2noKTaWXw
         e2WH/pO18L3JFSP6ggiYXWCGp6AMqufWtXSrMCXE5nsY9AYY7Z+4y8XQWWbbSpMIIt
         CPjxw7U7TlG9lzMf4JcZERJUbtbOY4pm7oCzQpb4mGhRmjFxmIHN+yONeMuNK9LAPn
         O8Akf6p8bKxvPcq4Yet8+bgaqrSNJ5Na6Pn0S1LP3PYJnSNsK84ZDYlYm5VvajYyxF
         qsbbq4fD500cbGKYU9CJkVHA0EfkaaIfTptuilSSw41Uw1dPC7XSt3PYw7C+3/YiU7
         EJ6t3TSpkotjA==
Date:   Wed, 28 Jul 2021 11:45:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v10 2/3] dmaengine: ptdma: register PTDMA controller as a
 DMA resource
Message-ID: <YQD19B4A/l/ZyySZ@matsya>
References: <1624207298-115928-1-git-send-email-Sanju.Mehta@amd.com>
 <1624207298-115928-3-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624207298-115928-3-git-send-email-Sanju.Mehta@amd.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-06-21, 11:41, Sanjay R Mehta wrote:
> From: Sanjay R Mehta <sanju.mehta@amd.com>
> 
> Register ptdma queue to Linux dmaengine framework as general-purpose
> DMA channels.

Mostly looks good, one question below:

> +static struct pt_dma_desc *pt_alloc_dma_desc(struct pt_dma_chan *chan,
> +					     unsigned long flags)
> +{
> +	struct pt_dma_desc *desc;
> +
> +	desc = kmem_cache_zalloc(chan->pt->dma_desc_cache, GFP_NOWAIT);
> +	if (!desc)
> +		return NULL;
> +
> +	vchan_tx_prep(&chan->vc, &desc->vd, flags);
> +
> +	desc->pt = chan->pt;
> +	desc->issued_to_hw = 0;
> +	desc->status = DMA_IN_PROGRESS;

where is this descriptor freed?

-- 
~Vinod
