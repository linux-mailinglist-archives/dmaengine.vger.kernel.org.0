Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131673B9B1D
	for <lists+dmaengine@lfdr.de>; Fri,  2 Jul 2021 05:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbhGBDrU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Jul 2021 23:47:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234758AbhGBDrU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 1 Jul 2021 23:47:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C80E61351;
        Fri,  2 Jul 2021 03:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625197488;
        bh=FH9ihmHFOloobA056nvq51v/JLxmAlMmEXmE6ME7Rzk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E1H0fFmafakhg7MFITgptj8wRdzSd4q8f5+FDhDxjHxOV53+OKncdTG3xlDfkOfaG
         BEPG4a/cRNTAw+gSuOdSxF5lTm/KNsgCWXqhcOVCgkY8JTe9GG4gB39/MNlD+dUrP9
         wthfWM3RfyA+4mIskNJzKEkeTBpMq0B29980naIiTD+pTwRE/NMWHBuG7yDzX8lLSK
         A0wXWxkVf5PJPirWF3JI6kPgAWxcYc68vUh1yz3lAfztSm44FDGfMsyyewF3+lBGjd
         5GPTyN0kfJa7DZxfPDDs6yv8ZYQC76FD+9Bwc3wzprERLJVxiwAiBqPOInPujqABcR
         j83oAtrxkFK3Q==
Date:   Fri, 2 Jul 2021 09:14:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        jgg@nvidia.com, ramesh.thomas@intel.com
Subject: Re: [PATCH 00/18] Fix idxd sub-drivers setup
Message-ID: <YN6LrRyP8p8sSkV6@matsya>
References: <162163546245.260470.18336189072934823712.stgit@djiang5-desk3.ch.intel.com>
 <4212b8af-0f02-d2b9-a128-0576a2a8b4e5@intel.com>
 <cdf50526-8179-c5ef-b45a-d737f6d3acfd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdf50526-8179-c5ef-b45a-d737f6d3acfd@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-06-21, 09:53, Dave Jiang wrote:
> 
> On 6/14/2021 10:18 AM, Dave Jiang wrote:
> > 
> > On 5/21/2021 3:21 PM, Dave Jiang wrote:
> > > Vinod,
> > > Please consider this series for the 5.14 merge window. Thank you!
> > 
> > Hi Vinod. Gently ping on this series. Thanks!
> 
> Hi Vinod, any chance this series make it into 5.14 merge window? Thanks!

Hi Dave,

Sorry we are late, I will review and do the needful once the merge
window closes

Thanks

-- 
~Vinod
