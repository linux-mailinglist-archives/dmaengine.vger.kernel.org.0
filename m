Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330BB202F55
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2020 06:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgFVErj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jun 2020 00:47:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgFVErj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Jun 2020 00:47:39 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76426251D9;
        Mon, 22 Jun 2020 04:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592801259;
        bh=QP/FvS/+xhPIsPI6044PsAdG4oIimgoqOisNnpUKF54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QjJssGyFpc0E8B+/mIdlFlKCQ4FNVFcefjeHVZgjbHADCfFq27dJMLEPyMkSAhRLM
         6VYsWAiAceTcr04HNb6hcjgoVPiNWpOsqROLXcITJiSUvh1IjCejv6pBODOVy2VLGM
         lSH/QLSOzS9q8KkQ4soGDR/BMVPXn2qwb56PX7RM=
Date:   Mon, 22 Jun 2020 10:17:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Federico Vaga <federico.vaga@cern.ch>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: DMA Engine: Transfer From Userspace
Message-ID: <20200622044733.GB2324254@vkoul-mobl>
References: <5614531.lOV4Wx5bFT@harkonnen>
 <fe199e18-be45-cadc-8bad-4a83ed87bfba@intel.com>
 <20200621072457.GA2324254@vkoul-mobl>
 <20200621203634.y3tejmh6j4knf5iz@cwe-513-vol689.cern.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200621203634.y3tejmh6j4knf5iz@cwe-513-vol689.cern.ch>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-06-20, 22:36, Federico Vaga wrote:
> On Sun, Jun 21, 2020 at 12:54:57PM +0530, Vinod Koul wrote:
> > On 19-06-20, 16:31, Dave Jiang wrote:
> > > 
> > > 
> > > On 6/19/2020 3:47 PM, Federico Vaga wrote:
> > > > Hello,
> > > >
> > > > is there the possibility of using a DMA engine channel from userspace?
> > > >
> > > > Something like:
> > > > - configure DMA using ioctl() (or whatever configuration mechanism)
> > > > - read() or write() to trigger the transfer
> > > >
> > > 
> > > I may have supposedly promised Vinod to look into possibly providing
> > > something like this in the future. But I have not gotten around to do that
> > > yet. Currently, no such support.
> > 
> > And I do still have serious reservations about this topic :) Opening up
> > userspace access to DMA does not sound very great from security point of
> > view.
> 
> I was thinking about a dedicated module, and not something that the DMA engine
> offers directly. You load the module only if you need it (like the test module)

But loading that module would expose dma to userspace. 
> 
> > Federico, what use case do you have in mind?
> 
> Userspace drivers

more the reason not do do so, why cant a kernel driver be added for your
usage?

-- 
~Vinod
