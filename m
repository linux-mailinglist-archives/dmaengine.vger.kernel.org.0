Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9904202954
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2020 09:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgFUHZD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 21 Jun 2020 03:25:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729410AbgFUHZC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 21 Jun 2020 03:25:02 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81CF724861;
        Sun, 21 Jun 2020 07:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592724302;
        bh=O+HtJYaaPHUMFJE4t1nnQ2MuJq56zD7rjTetemmt5lM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=unppcI2Q4B6j3eqWu1fxtJn6mxib5JV88n8S/w4kYFhB91e+KoQgufAF8fYFoQQkd
         RETm3PEbbTdzQI8VfTSirlfGcaXH4kpaHzrAqmM8DHjaZLVCt4qmn0s0a80ejOWAIe
         MbJwa3BZrkhyI/8HjGnjVKmKWntVRLEWAsiIlwjo=
Date:   Sun, 21 Jun 2020 12:54:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Federico Vaga <federico.vaga@cern.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: DMA Engine: Transfer From Userspace
Message-ID: <20200621072457.GA2324254@vkoul-mobl>
References: <5614531.lOV4Wx5bFT@harkonnen>
 <fe199e18-be45-cadc-8bad-4a83ed87bfba@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe199e18-be45-cadc-8bad-4a83ed87bfba@intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-06-20, 16:31, Dave Jiang wrote:
> 
> 
> On 6/19/2020 3:47 PM, Federico Vaga wrote:
> > Hello,
> > 
> > is there the possibility of using a DMA engine channel from userspace?
> > 
> > Something like:
> > - configure DMA using ioctl() (or whatever configuration mechanism)
> > - read() or write() to trigger the transfer
> > 
> 
> I may have supposedly promised Vinod to look into possibly providing
> something like this in the future. But I have not gotten around to do that
> yet. Currently, no such support.

And I do still have serious reservations about this topic :) Opening up
userspace access to DMA does not sound very great from security point of
view.

Federico, what use case do you have in mind?

We should keep in mind dmaengine is an in-kernel interface providing
services to various subsystems, so you go thru the respective subsystem
kernel interface (network, display, spi, audio etc..) which would in
turn use dmaengine.

-- 
~Vinod
