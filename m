Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695BE206DFB
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2020 09:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389929AbgFXHoL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 03:44:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389583AbgFXHoL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Jun 2020 03:44:11 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9EB320768;
        Wed, 24 Jun 2020 07:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592984650;
        bh=1nYDddP44y5PFslcfyEtsRL/mtIUGOtw9RDYWyquThA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k/Yl39q0+YR74/Rc62+9Gw14cIUQAJaPubtTITJoLEYiBRvSLKpXCarJfCHvL8U5d
         5d9fw0tSXtVLLmf4o/wGlI/G3sAEYOtH+gkUjtdN43fu0VUiPrNU7PNuK6pKI6eBDR
         iJrnJVPsa4qcmOd3GH+eNUFi2aIzFYNxg3MGud58=
Date:   Wed, 24 Jun 2020 13:14:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     gaurav singh <gaurav1086@gmail.com>
Cc:     green.wan@sifive.com, dan.j.williams@intel.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma_async_tx_descriptor: Fix null pointer dereference
Message-ID: <20200624074406.GR2324254@vkoul-mobl>
References: <CAFAFadDGQusosHzwqY18bYWF8a3a1OK1+Sr_NtWMOvpFnpmgqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFAFadDGQusosHzwqY18bYWF8a3a1OK1+Sr_NtWMOvpFnpmgqA@mail.gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-06-20, 22:59, gaurav singh wrote:
> The check: if (chan && (!len || !dest || !src)) indicates that chan can be
> NULL, however chan is dereferenced in multiple locations later without
> check. In the function: sf_pdma_alloc_desc() and later: chan->desc = desc;
> This can cause segmentation fault if chan is NULL and it doesn't return in
> the first check. To fix, this: add the check for chan right in the
> beginning.
> 
> Please find the patch below. Let me know if there's any issue.

1. please send using git-send-email
2. pls run checkpatch, below formatting is crap

> 
> Thank you.
> Gaurav.
> 
> >From a2f18613751b4ce5b0dba3a273a75957d872ccd3 Mon Sep 17 00:00:00 2001
> From: Gaurav Singh <gaurav1086@gmail.com>
> Date: Wed, 3 Jun 2020 22:52:31 -0400
> Subject: [PATCH] dma_async_tx_descriptor: Fix null pointer dereference

Care to explain which null pointer dereference?
Also reread Documentation/process/submitting-patches.rst esp word about
subject lines

> 
> ---
>  drivers/dma/sf-pdma/sf-pdma.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
> index 6d0bec947636..0cbc7b379d11 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.c
> +++ b/drivers/dma/sf-pdma/sf-pdma.c
> @@ -94,7 +94,11 @@ sf_pdma_prep_dma_memcpy(struct dma_chan *dchan,
> dma_addr_t dest, dma_addr_t src,
>   struct sf_pdma_chan *chan = to_sf_pdma_chan(dchan);
>   struct sf_pdma_desc *desc;
> 
> - if (chan && (!len || !dest || !src)) {
> + if (!chan) {
> + return NULL;
> + }
> +
> + if (!len || !dest || !src) {
>   dev_err(chan->pdma->dma_dev.dev,
>   "Please check dma len, dest, src!\n");
>   return NULL;
> -- 
> 2.17.1

-- 
~Vinod
