Return-Path: <dmaengine+bounces-4421-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB1DA31C36
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 03:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D701116630C
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 02:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C431D5CC4;
	Wed, 12 Feb 2025 02:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDvbkQHU"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502C71D5176;
	Wed, 12 Feb 2025 02:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739328196; cv=none; b=fRRfvSoRu+V07/qn/FhBXngFEeFf/ETxtvGtfhxKC2zU10mA+D41AI47XMXP+iIJsf7FN4sc0IlJvMELVv2bC9QG1s1F62ZTdaRQRODbwZYI221la+whDB+WNZiDy14aN36qFKunGDrTz2A5Ne0DBylqt1YeUwkIeJPkY3wlxtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739328196; c=relaxed/simple;
	bh=ceYSAdXaY8pnXbbzOQibX6XNuK9H+yJSiYcYvOVf6J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pa+1b9/0AWdsRr1HRDUz+NSvRkO4PGRXAyHltSg+C9HhvCN2duv6GVWdwCUB/PI6UaCnOGmZWEAd0wCjbn69xvBtHn/7VpZ59p7YufPcKWBcDvjoL3YTYrw7qYmDI3xlXfMVZPeh99ahcde+rxhJmVsk88GKXWlu88fwl/zsA7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDvbkQHU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E8EC4CEDD;
	Wed, 12 Feb 2025 02:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739328194;
	bh=ceYSAdXaY8pnXbbzOQibX6XNuK9H+yJSiYcYvOVf6J4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EDvbkQHU8bLjDhLIgumXDGYygG100855wmm0pTQw0rJDC5+hTGoBnHA/JzsJETCe8
	 oQB8PszoSOGU3sz59GAV78xFje88v0B6ZCG448h6BsgjtLSeARXHnZ5JvKYc3i57e3
	 Qq+Y4jFTQ7Fb9iCopSIJ/GvB0oX9IVnKzLK/GQRs4cpsW21PsyxmxI8W0eVLWcO0z8
	 Wwd9eendZWy0Q66qGhVfeI7amh7SLwtJCO/pfpEFLv7bLkQKtJgzNqwe4/jKaVhZmU
	 Wt4czAFmyxZVDvlVNcz6nT++jec14vv3udqMGWtDGBYEjCg4+MOnf99RzxQR9rpCHP
	 09XrMMxnrvwrg==
Date: Tue, 11 Feb 2025 20:43:12 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
	Vinod Koul <vkoul@kernel.org>, Md Sadre Alam <quic_mdalam@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Georgi Djakov <djakov@kernel.org>
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: Avoid accessing BAM_REVISION
 on remote BAM
Message-ID: <jzb4ccukx6u64ewtwyhik2ezhrmawc2in5eyktt5dnm2orr3jh@bwtgerefsukb>
References: <20250207-bam-read-fix-v1-1-027975cf1a04@oss.qualcomm.com>
 <Z6m8btwhJ9q4RjB6@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6m8btwhJ9q4RjB6@linaro.org>

On Mon, Feb 10, 2025 at 09:44:30AM +0100, Stephan Gerhold wrote:
> On Fri, Feb 07, 2025 at 12:17:33PM -0800, Bjorn Andersson wrote:
> > Commit '57a7138d0627 ("dmaengine: qcom: bam_dma: Avoid writing
> > unavailable register")' made this read unconditional, in order to
> > identify if the instance is BAM-NDP or BAM-Lite.
> > But the BAM_REVISION register is not accessible on remotely managed BAM
> > instances and attempts to access it causes the system to crash.
> > 
> > Move the access back to be conditional and expand the checks that was
> > introduced to restore the old behavior when no revision information is
> > available.
> > 
> > Fixes: 57a7138d0627 ("dmaengine: qcom: bam_dma: Avoid writing unavailable register")
> > Reported-by: Georgi Djakov <djakov@kernel.org>
> > Closes: https://lore.kernel.org/lkml/9ef3daa8-cdb1-49f2-8d19-a72d6210ff3a@kernel.org/
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> 
> This patch fixes the most critical regression (the bus hang), but the
> in_range(..., BAM_NDP) checks are also wrong. They do not consider the
> plain "BAM" type where the register is apparently also available. The
> check should be !in_range(..., BAM_LITE) instead to fix this.
> 

Sorry, I must have not paid sufficient attention while browsing the
replies; and just tried to restore the one case I thought the author
didn't consider...

Thanks for staying on top of it. Revert makes total sense.

Regards,
Bjorn

> I mentioned this twice to Md Sadre Alam [1, 2], but a fix was
> unfortunately never sent for that part of the regression.
> 
> I think we should take Caleb's patch and revert the entire patch for the
> 6.14 cycle. There are several incorrect assumptions in the original
> patch, it will be easier to review a fixed version with the full diff,
> rather than looking at incremental fixups.
> 
> On a somewhat related note, I'm working on a patch series for bam_dma to
> clean up the handling of remotely controlled BAMs. It will make it more
> clear when it's safe to access BAM registers and when not, and should
> allow reading the revision also for remotely controlled BAMs. This would
> avoid the need for all these if (!bdev->bam_revision) checks.
> 
> Thanks,
> Stephan
> 
> [1]: https://lore.kernel.org/linux-arm-msm/Z4D2jQNNW94qGIlv@linaro.org/
> [2]: https://lore.kernel.org/linux-arm-msm/Z4_U19_QyH2RJvKW@linaro.org/
> 
> > ---
> >  drivers/dma/qcom/bam_dma.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> > index c14557efd577..d42d913492a8 100644
> > --- a/drivers/dma/qcom/bam_dma.c
> > +++ b/drivers/dma/qcom/bam_dma.c
> > @@ -445,8 +445,8 @@ static void bam_reset(struct bam_device *bdev)
> >  	writel_relaxed(val, bam_addr(bdev, 0, BAM_CTRL));
> >  
> >  	/* set descriptor threshold, start with 4 bytes */
> > -	if (in_range(bdev->bam_revision, BAM_NDP_REVISION_START,
> > -		     BAM_NDP_REVISION_END))
> > +	if (!bdev->bam_revision ||
> > +	    in_range(bdev->bam_revision, BAM_NDP_REVISION_START, BAM_NDP_REVISION_END))
> >  		writel_relaxed(DEFAULT_CNT_THRSHLD,
> >  			       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
> >  
> > @@ -1006,8 +1006,8 @@ static void bam_apply_new_config(struct bam_chan *bchan,
> >  			maxburst = bchan->slave.src_maxburst;
> >  		else
> >  			maxburst = bchan->slave.dst_maxburst;
> > -		if (in_range(bdev->bam_revision, BAM_NDP_REVISION_START,
> > -			     BAM_NDP_REVISION_END))
> > +		if (!bdev->bam_revision ||
> > +		    in_range(bdev->bam_revision, BAM_NDP_REVISION_START, BAM_NDP_REVISION_END))
> >  			writel_relaxed(maxburst,
> >  				       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
> >  	}
> > @@ -1199,11 +1199,12 @@ static int bam_init(struct bam_device *bdev)
> >  	u32 val;
> >  
> >  	/* read revision and configuration information */
> > -	val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
> > -	if (!bdev->num_ees)
> > +	if (!bdev->num_ees) {
> > +		val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
> >  		bdev->num_ees = (val >> NUM_EES_SHIFT) & NUM_EES_MASK;
> >  
> > -	bdev->bam_revision = val & REVISION_MASK;
> > +		bdev->bam_revision = val & REVISION_MASK;
> > +	}
> >  
> >  	/* check that configured EE is within range */
> >  	if (bdev->ee >= bdev->num_ees)
> > 
> > ---
> > base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> > change-id: 20250207-bam-read-fix-2b31297d3fa1
> > 
> > Best regards,
> > -- 
> > Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> > 
> 

