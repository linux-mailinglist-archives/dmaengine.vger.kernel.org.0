Return-Path: <dmaengine+bounces-6081-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFAFB2E403
	for <lists+dmaengine@lfdr.de>; Wed, 20 Aug 2025 19:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61CDF3ACF0C
	for <lists+dmaengine@lfdr.de>; Wed, 20 Aug 2025 17:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99473219301;
	Wed, 20 Aug 2025 17:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEX92ZKF"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716AA86352;
	Wed, 20 Aug 2025 17:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755711049; cv=none; b=IW4ozOJ70cLxEFwrN7FSYJC0m6lHSpkyUqcYFWJk2wffUfmXsznO2Zf4ScYec8IKj15g/ajem+M50fvX0pstKQH/T/8yBO5IxSO3+ZQymrh9+gRYeNjtrNQpLDY3nR8b9eTywUBltGL50oDb0BQvKkrm7IcU4NwVtP8alyPRpiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755711049; c=relaxed/simple;
	bh=n4pWG4PyINSMgw3ik/XZyQmigx3YpoWLtJHNpIN9bEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPmpEBMPkAYmelUCvPDSSQJ5uiIb2LbYwrdoa5JAeWVbqoKLHNQw0yAVL7WMCEKONbdEEvAmznKXxPXhfBrl7e8BT4TZy5SInEwtNBamRiEhbKjmj8bKreu5SgQn0RDrG1ysbRJrUzQlXwtX37XEjJmfPFSnWqdrenOwEP4N2gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEX92ZKF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585BBC4CEE7;
	Wed, 20 Aug 2025 17:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755711049;
	bh=n4pWG4PyINSMgw3ik/XZyQmigx3YpoWLtJHNpIN9bEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TEX92ZKFq3N4c8QATNrvcqSRRZl8aj/K3XziZ0MJEC68hCm17DRNdQhak068lcZCa
	 P662nCKMSL/hXzfCYpIee4rU5DAs25J1i8rMMMoLJRw1siafwsJePQmt48bRNSpGf/
	 cc3YeH+JfDV8CbneWDVqmnnDQ6rcrt1i4wohpIcwxOxTr3L0BchUnkYVWoSD94jwoQ
	 l+N4tEcdkUazky62/EbCYhaqJs99Me3yu9ggo6arTHA77NF+mkSrtphPAas0qatHX9
	 ooQ9jx4KZV9Dzl4xRHPnxt6nATGZ/fC53s5ExdEv8i7X/OtiTEYa+PjbH6PeARx/E5
	 WG4aOaWi9eblA==
Date: Wed, 20 Aug 2025 23:00:44 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Yi Sun <yi.sun@intel.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>, dave.jiang@intel.com,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	fenghuay@nvidia.com, philip.lantz@intel.com, gordon.jin@intel.com,
	anil.s.keshavamurthy@intel.com
Subject: Re: [PATCH v2 2/2] dmaengine: idxd: Add Max SGL Size Support for
 DSA3.0
Message-ID: <aKYGRC2TzHpnhRyO@vaman>
References: <20250620130953.1943703-1-yi.sun@intel.com>
 <20250620130953.1943703-3-yi.sun@intel.com>
 <87o6ue6kf6.fsf@intel.com>
 <aJqizVCcYSL-4LOm@ysun46-mobl.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJqizVCcYSL-4LOm@ysun46-mobl.ccr.corp.intel.com>

On 12-08-25, 10:11, Yi Sun wrote:
> On 23.06.2025 17:41, Vinicius Costa Gomes wrote:
> > Yi Sun <yi.sun@intel.com> writes:
> > 
> > > Certain DSA 3.0 opcodes, such as Gather copy and Gather reduce, require max
> > > SGL configured for workqueues prior to supporting these opcodes.
> > > 
> > > Configure the maximum scatter-gather list (SGL) size for workqueues during
> > > setup on the supported HW. Application can then properly handle the SGL
> > > size without explicitly setting it.
> > > 
> > > Signed-off-by: Yi Sun <yi.sun@intel.com>
> > > Co-developed-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> > > Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> > > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > > 
> > 
> > Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> > 
> > 
> > Cheers,
> > -- 
> > Vinicius
> 
> Hi Vinod,
> 
> Gentle ping on the entire series.

Can you please rebase and resend this

-- 
~Vinod

