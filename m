Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41CF52C2E4D
	for <lists+dmaengine@lfdr.de>; Tue, 24 Nov 2020 18:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390561AbgKXRST (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Nov 2020 12:18:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:52602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390140AbgKXRST (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Nov 2020 12:18:19 -0500
Received: from localhost (unknown [122.167.149.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C41F1205CA;
        Tue, 24 Nov 2020 17:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606238298;
        bh=+wWmV1N8dsS3B7Zqy/3n9w0yyzrWnDHlDqlfRId6W3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T6CoL7NJKKzASF8bZaIxpf58W8ehGA+7JZSr2mbALTPTnrB4Qb9DzxdJwXNPgKnZR
         GIl9UOmbSMc6eyj+1+wOQo5RLsyxGHLhSPLYnPerCmTs4e+GA/Ii/bfLbJxuDv08Y/
         d91OFjPqDLF29+TAN2w3+/ymagSgbTYyYYUIY27Q=
Date:   Tue, 24 Nov 2020 22:48:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Vitaly Mayatskih <v.mayatskih@gmail.com>
Cc:     Sanjay R Mehta <Sanju.Mehta@amd.com>, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, Thomas.Lendacky@amd.com,
        Shyam-sundar.S-k@amd.com, Nehal-bakulchandra.Shah@amd.com,
        robh@kernel.org, mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v7 2/3] dmaengine: ptdma: register PTDMA controller as a
 DMA resource
Message-ID: <20201124171813.GS8403@vkoul-mobl>
References: <1602833947-82021-1-git-send-email-Sanju.Mehta@amd.com>
 <1602833947-82021-3-git-send-email-Sanju.Mehta@amd.com>
 <20201118121623.GR50232@vkoul-mobl>
 <CAGF4SLi1qqj6xSBB6=9rS=M_Wvaj9Zec7XzMc7=9EsgPLM21OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGF4SLi1qqj6xSBB6=9rS=M_Wvaj9Zec7XzMc7=9EsgPLM21OQ@mail.gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Vitaly,

On 24-11-20, 09:23, Vitaly Mayatskih wrote:
> On Wed, Nov 18, 2020 at 7:20 AM Vinod Koul <vkoul@kernel.org> wrote:
> 
> > this should be single line
> 
> Vinod, do you see any obvious functional defects still present in the
> driver, or can it be finally merged for us to start testing, while
> Sanjay is working on improvements and style fixes? I'm sure the driver
> has hidden bugs, as any other piece of code on the planet, and Sanjay
> will appreciate bug reports from the actual PTDMA users.

IIRC there were few issues that I would like to get fixed before we can
apply.. I hope authors can reply to the comments received and we can
discuss on this.

-- 
~Vinod
