Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADA42F2F25
	for <lists+dmaengine@lfdr.de>; Tue, 12 Jan 2021 13:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbhALMcM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Jan 2021 07:32:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:48122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbhALMcM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 12 Jan 2021 07:32:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCD3F23109;
        Tue, 12 Jan 2021 12:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610454692;
        bh=BtD61F+RAP3Yv3WfEUjwIDVe48zMPhJpisO2OtiId90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YuPDxeFiitS2kKFvGgE7iRl8XKs6QeHdTqOebZfJb3wfW499VmSKT6o9Dj7IBeqar
         WlQEUHtRvVEneCm9zePEkO68iG1Af0Usb6+Rur53obIYiKSjQSzZCiyShkEVceJsOT
         kKTkqN1OQOP4HOpWdb8UUbKWrxU3czq7+ELhQKEHPfAupzrxNjZOrOPcCewGJIGRjP
         6vv6THKmCTCribmRuxfig4kmtbCEetXeHP7LYGSwdTH3BiqbIQ/SD5O++GEfMasbfz
         iAvU5K738yBEu/LH6ehrjG4QyuMxaB1iCDoeY/jLlewp2Cr34NBbf4aDnWwePzoN/0
         s08pGBtLQGBXw==
Date:   Tue, 12 Jan 2021 18:01:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dan.j.williams@intel.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: owl-dma: Fix a resource leak in the remove
 function
Message-ID: <20210112123127.GT2771@vkoul-mobl>
References: <20201212162535.95727-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201212162535.95727-1-christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-12-20, 17:25, Christophe JAILLET wrote:
> A 'dma_pool_destroy()' call is missing in the remove function.
> Add it.
> 
> This call is already made in the error handling path of the probe function.

Applied, thanks

-- 
~Vinod
