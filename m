Return-Path: <dmaengine+bounces-4376-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF5AA2E939
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 11:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46E743A83E1
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 10:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A641DF998;
	Mon, 10 Feb 2025 10:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhD00Uaj"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C317DA9C;
	Mon, 10 Feb 2025 10:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739182796; cv=none; b=H6kUngWkgqGOQa7C6ypD1a88LWXLj00jFTT38Uc7Ow2hgY0vmwuaxqj1cxzmvnYr5uYf1iQQXCRvs9Y1vbWWyZDgrrOWg05LfjGmdBLi8+/m8YoyDSDuidlgqNdB/oRx7ef4CbHIkBlSnocm1FQcEOtYhesetMSpr+jGDfai4L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739182796; c=relaxed/simple;
	bh=yMGskL7MLJWn/r7OVZbGJx9q7/tbXqUhoIe+Heu7gD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtAMs3PJXT8wVv/J65YLA4uFCO4eELnpf2RYX6crhjBTRjzhPgJDMAvILMFEYGecjfXqHgE0MQK2fV9+H1lQ+IojBCN4M8ZDUAzcXp6mNCkBmmcncUIiT65C2vFIQ2iKjj0HKRQpdjhp33QzlompxL/aqvZ+S0PX9dq7dMCz+UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhD00Uaj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687BCC4CED1;
	Mon, 10 Feb 2025 10:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739182796;
	bh=yMGskL7MLJWn/r7OVZbGJx9q7/tbXqUhoIe+Heu7gD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZhD00UajXsg427yGD5lfKeeKTKd1bX1tI71PbP9zcUKytic7kAV5b0p1NZYbr0rZZ
	 Ei/ERaK5KYp/8TuDMF+t29XFXgyMdIzELoQCayd033tooEjwpzAm9m+FvLr60gOL6x
	 G2Yl8TCgSIxLPfX+UUGcIr5Icg5DZhA6bzt13/Ry3SiqTIBwgcashyHuML1pS2Vzqh
	 xx5K6Sm/4cZoHBpIy37ahaE57EiiTmsEboR3dj27MIWJuoQC5FzDsYpHPXJscBUGS3
	 gtTVPn3qWdoLBF9QbBbyknwyIScZ8FmDLEv2I9wj3cFB3rOSky5GPvnW9w6Z29JAbA
	 UvyCdLBg6S5TA==
Date: Mon, 10 Feb 2025 15:49:52 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Amit Vadhavana <av2082000@gmail.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>, Kees Cook <kees@kernel.org>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Robin Murphy <robin.murphy@arm.com>,
	David Heidelberg <david@ixit.cz>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	dmaengine@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] Revert "dmaengine: qcom: bam_dma: Avoid writing
 unavailable register"
Message-ID: <Z6nSyNz91IIzrVuv@vaman>
References: <20250208223112.142567-1-caleb.connolly@linaro.org>
 <mjyavvk5jymhfdn4czffihi55nvlxea5ldgchsmkyd6lomrlbr@7224az7nsnsa>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mjyavvk5jymhfdn4czffihi55nvlxea5ldgchsmkyd6lomrlbr@7224az7nsnsa>

On 08-02-25, 20:03, Bjorn Andersson wrote:
> On Sat, Feb 08, 2025 at 10:30:54PM +0000, Caleb Connolly wrote:
> > This commit causes a hard crash on sdm845 and likely other platforms.
> > Revert it until a proper fix is found.
> > 
> > This reverts commit 57a7138d0627309d469719f1845d2778c251f358.
> > 
> 
> I posted below patch yesterday, which reverts the change for
> bdev->num_ees != 0 (i.e. SDM845), while still retaining the introduced
> NDP vs Lite logic.

Bjorn,

Given the issues reported by Stephan, do you this we should revert
and then patch it up..?

-- 
~Vinod

