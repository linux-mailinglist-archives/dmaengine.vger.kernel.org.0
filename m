Return-Path: <dmaengine+bounces-2874-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEC3954E18
	for <lists+dmaengine@lfdr.de>; Fri, 16 Aug 2024 17:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6633B1F23779
	for <lists+dmaengine@lfdr.de>; Fri, 16 Aug 2024 15:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C818D1BDA99;
	Fri, 16 Aug 2024 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pvqv5U9j"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977071BD4F9;
	Fri, 16 Aug 2024 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723823152; cv=none; b=QuZ2xlHUF21XFGZjjkPX6e6zPapMp4utKSTYdVJIwHpJgLQ9nTm56GD+EU/bM+QoikEMASybOMOaA+O8QD37iz0xKg3IDgzcoNDDZ3lIkV6SMD6sOt0IwWAUAlydTn6cJEguwzGbD/2D0qOHgh8Alnlru/PK2sPjlAj+C7oHOv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723823152; c=relaxed/simple;
	bh=k60ptvcyhSt0uzzj7CjZLlBOJLU8RKW2PArwUoO+w4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBqb2IvGfpS5OLel+kriT6j14bCfh9+qXsSee5My7NOySsArl1uT6UQX3DuR7oMZkBM6YSTlvMqGPLvB+58BtgO2oN91A9S8/UiymV6tAOrbyD5HMgQ9YLAEl+zbtPilevLW3xOIVkxYPpuvSVe/U0kvNQvz6bZnEhH3h/bscAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pvqv5U9j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0479C32782;
	Fri, 16 Aug 2024 15:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723823152;
	bh=k60ptvcyhSt0uzzj7CjZLlBOJLU8RKW2PArwUoO+w4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pvqv5U9jTHHhqoF83Kfat79hnD/YVywjq+W1UhlPQ0AtfiikJt6I4l4IdRE6vLKs2
	 Hqa6u6SkQKtIyyxcUt2ymEI5A0rvGgqHh88JDTj/bI2YLgRbejZlTD8LfMHWJ5TUcJ
	 ZtzRXmAWPkP7v13IKG6ne2Zsa7nHLjdA3i/WFiymcLf6CcCCxtqDFTNh1EAHJ9kD8w
	 o0UHS7nz98kPB3qw/MFnOpgc5w79qMfX7XSYPmpTiAMg88+ZXwPIDskRvP+QXiSb78
	 UULmxk6L5g/jukeOVjAb+gj8Xn8L7dYCuT/5BrDBsYpp4wk//vEpCEEwYA+0vF0gVP
	 CKb7tlU98242Q==
Date: Fri, 16 Aug 2024 10:45:49 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, vkoul@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org, 
	thara.gopinath@gmail.com, herbert@gondor.apana.org.au, davem@davemloft.net, 
	gustavoars@kernel.org, u.kleine-koenig@pengutronix.de, kees@kernel.org, 
	agross@kernel.org, linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	quic_srichara@quicinc.com, quic_varada@quicinc.com, quic_utiwari@quicinc.com
Subject: Re: [PATCH v2 00/16] Add cmd descriptor support
Message-ID: <3vfiwr4uwaejksihd32qb7ryf3euts6urjfqwzhptkivpvo5tv@u4l2mkuoh3ln>
References: <20240815085725.2740390-1-quic_mdalam@quicinc.com>
 <f341e9e9-3da6-4029-9892-90e6ec856544@linaro.org>
 <21fa1207-be83-ffdc-deab-81c070bb94c7@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21fa1207-be83-ffdc-deab-81c070bb94c7@quicinc.com>

On Fri, Aug 16, 2024 at 05:33:43PM GMT, Md Sadre Alam wrote:
> On 8/15/2024 6:38 PM, Caleb Connolly wrote:
[..]
> > On 15/08/2024 10:57, Md Sadre Alam wrote:
[..]
> > > 
> > > tested with "tcrypt.ko" and "kcapi" tool.
> > > 
> > > Need help to test these all the patches on msm platform
> > 
> > DT changes here are only for a few IPQ platforms, please explain in the cover letter if this is some IPQ specific feature which doesn't exist on other platforms, or if you're only enabling it on IPQ.
> 
>    This feature is BAM hardware feature so its applicable for all the QCOM Soc where bam is there. Its not IPQ specific. Will add all the explanation in cover letter in next patch

Please configure your email client such that your replies follow the
typical style of mail list discussions. I believe go/upstream has
instructions for this.

> > 
> > Some broad strokes testing instructions (at the very least) and requirements (testing on what hardware?) aren't made obvious at all here.
> 
>    Sure will update in cover letter in next patch.

I'm interested in these instructions as well, but no need to wait for
another version to provide these instructions. Please just reply here
(and then include them if there are future versions)

Regards,
Bjorn

