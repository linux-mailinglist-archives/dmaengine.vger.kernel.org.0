Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B09438FC4
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 08:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhJYG6R (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 02:58:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229727AbhJYG6Q (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 02:58:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FE2B60FBF;
        Mon, 25 Oct 2021 06:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635144955;
        bh=mCUUICw/JeXhAZz3eSIXTOZdzi+Udz+TQU0R3Z2yS5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PeLi8oMrZObadCGLF1LOUnP7iNF/bwmCw/WHlLWuN7cu51mee8+a9tdUMfi3SC6Ya
         OZHgQUxWeH59ggZqSuE2twrHhkV+eVs9zAamyeXR7Nyd83RLezKQPLkokRlTUzUltz
         P3zYpvG3YkKBlCoPl7hyZWgumhbR7BnK5OK6MhnHLc5MDjRgCZTnyNfTzvkuG+QUI6
         5WM+ZtWLUCk+QPIyX/TWpAt3fuJMG4jGjcGAKLjFBn9NmyWr/KIUbtqIfh2Umg0ui8
         RGIb9pSHSkvbbidAmw2q5hvsgIsk5814LApAy4Gerjzc9Usi85bKBjLrrLiConxtGO
         MRdrP5WXgNrRg==
Date:   Mon, 25 Oct 2021 12:25:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Qing Wang <wangqing@vivo.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH V3 0/7] switch from 'pci_' to 'dma_' API
Message-ID: <YXZU9suGqrIurbX2@matsya>
References: <1633663733-47199-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1633663733-47199-1-git-send-email-wangqing@vivo.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-10-21, 20:28, Qing Wang wrote:
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
> 
> This type of patches has been going on for a long time, I plan to 
> clean it up in the near future. If needed, see post from 
> Christoph Hellwig on the kernel-janitors ML:
> https://marc.info/?l=kernel-janitors&m=158745678307186&w=4

Applied, thanks

-- 
~Vinod
