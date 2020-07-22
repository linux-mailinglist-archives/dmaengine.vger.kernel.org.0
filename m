Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5708E229AB5
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jul 2020 16:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbgGVOyk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jul 2020 10:54:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730465AbgGVOyk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 22 Jul 2020 10:54:40 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47C7620787;
        Wed, 22 Jul 2020 14:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595429680;
        bh=UsbJ/WPuFJeHoZ5MA/QB0f3jjziZ+fYgz8kZDhezwwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UpD2FNh+502O1/QZ8nqCh2HgpAFa1vWvWHR7r9I8uCWxS34WkOBYv0NrtjKydDCHf
         CZxxjFVZUWcM30Aqunl8RYvbDDO5jn6NcK9ThW+odPYrX2KU6rKlpinbGabkvprIcT
         aXXJbbSR6SbhDNq4PyyimhoxI3Qw6NgaD8VDweyc=
Date:   Wed, 22 Jul 2020 20:24:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dmaengine@vger.kernel.org, Hyun Kwon <hyun.kwon@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 3/3] dmaengine: xilinx: dpdma: fix kernel doc format
Message-ID: <20200722145435.GS12965@vkoul-mobl>
References: <20200718135201.191881-1-vkoul@kernel.org>
 <20200718135201.191881-3-vkoul@kernel.org>
 <20200722131119.GH5833@pendragon.ideasonboard.com>
 <20200722142608.GR12965@vkoul-mobl>
 <20200722145127.GC29813@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722145127.GC29813@pendragon.ideasonboard.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-07-20, 17:51, Laurent Pinchart wrote:

> > W=1 build again..
> 
> I get the same when plumbing the source file into the kerneldoc build.
> The generated documentation however contains the description of both
> desc.pending and desc.active. If you want to fix the warning, I think
> you should instead add a line to document @desc, but without removing
> the existing @desc.pending and @desc.active lines.

I would like to see clean build with W=1, helps to find other issues :)
So do feel free to send the patch to fix this, i will swap them..

-- 
~Vinod
