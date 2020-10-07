Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5CA285C1E
	for <lists+dmaengine@lfdr.de>; Wed,  7 Oct 2020 11:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgJGJxT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Oct 2020 05:53:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbgJGJxS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 7 Oct 2020 05:53:18 -0400
Received: from localhost (unknown [122.171.222.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62E882076C;
        Wed,  7 Oct 2020 09:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602064398;
        bh=BFETRULp85/9ySn5nFr4Sa4lSSQENezpv3LM9VXUZ1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EAalNtG7ilzuOxQ4OzqIu9kEq39Nh8A4jZJKMY5WBTXnCxjHG7EUkZAgw7IuLIvKv
         gZej5OVPQ12eaK9FnmftWvnY/Ogt9yr2oqhd8aMhSIHP/319cIAuLFxRy8hEQ5Ukwb
         EnxD3eWAabqDGkBF6sfCy0GNjAAbRhvZfAsgqGR0=
Date:   Wed, 7 Oct 2020 15:23:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Jiang <dave.jiang@intel.com>, dan.j.williams@intel.com,
        tony.luck@intel.com, ashok.raj@intel.com, kevin.tian@intel.com,
        fenghua.yu@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/5] Add shared workqueue support for idxd driver
Message-ID: <20201007095313.GV2968@vkoul-mobl>
References: <20201005151126.657029-1-dave.jiang@intel.com>
 <20201007070132.GT2968@vkoul-mobl>
 <20201007084856.GE5607@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007084856.GE5607@zn.tnic>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-10-20, 10:48, Borislav Petkov wrote:
> On Wed, Oct 07, 2020 at 12:31:32PM +0530, Vinod Koul wrote:
> > Applied, thanks
> 
> I'm tired of repeating what you should've done - your branch doesn't
> even build. How did you test it?

Right my build failed for x86 and I have dropped these now. I would have
expected the dependency to be a signed tag to be cross merged when I was
asked to merge this.

-- 
~Vinod
