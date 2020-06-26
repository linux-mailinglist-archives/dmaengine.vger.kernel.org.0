Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FD320AC6F
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2020 08:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgFZGjV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Jun 2020 02:39:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727960AbgFZGjV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 26 Jun 2020 02:39:21 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE4372076E;
        Fri, 26 Jun 2020 06:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593153560;
        bh=Vk4Dd6jWDlWznC6TYCEqsWbJ8Ixro9RHg/d75xZ29DA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iajXq+mP7K8oNQ33XvOdkHJKqHvEr8u8oLdJJblBj6CczYbagVRP9D+kLVKUT8epC
         aSp4eRp/nX5x6wvUVUjnQuqcwN9sHj7neNyLUwhKigkNlAQh0yPoY5b8rKKiSu8yqZ
         0k6YhLqP4q50G+gC5tAHkoU3zdSdpdizVpDCJ5zw=
Date:   Fri, 26 Jun 2020 12:09:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org, swathi.kovvuri@intel.com
Subject: Re: [PATCH] dmaengine: check device and channel list for empty
Message-ID: <20200626063915.GF6228@vkoul-mobl>
References: <158957055210.11529.14023177009907426289.stgit@djiang5-desk3.ch.intel.com>
 <20200624072911.GL2324254@vkoul-mobl>
 <c27b6058-a406-e6bd-55cd-15b67ab89f48@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c27b6058-a406-e6bd-55cd-15b67ab89f48@intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-06-20, 11:31, Dave Jiang wrote:
> 
> 
> On 6/24/2020 12:29 AM, Vinod Koul wrote:
> > On 15-05-20, 12:22, Dave Jiang wrote:
> > > Check dma device list and channel list for empty before iterate as the
> > > iteration function assume the list to be not empty. With devices and
> > > channels now being hot pluggable this is a condition that needs to be
> > > checked. Otherwise it can cause the iterator to spin forever.
> > 
> > Can you rebase and resend, they dont apply on next
> 
> Hi Vinod. I'm trying to figure out how to do all the patches outstanding to
> avoid conflicts for you. Some will go to your fixes branch and some will go
> to the next branch. But next doesn't have the patches in fixes. So when you
> merge next later for 5.9, you are going to hit conflict from my patches that
> went in through the fixes branch for 5.8.

I dont typically merge fixes, unless we have a conflicts. I can merge if
there are conflicts, just let me know :-)

-- 
~Vinod
