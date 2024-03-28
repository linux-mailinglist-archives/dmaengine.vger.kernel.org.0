Return-Path: <dmaengine+bounces-1595-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D2988F81E
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 07:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC4328E3B8
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 06:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FBE4F894;
	Thu, 28 Mar 2024 06:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUs/Eaw+"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4B34F889;
	Thu, 28 Mar 2024 06:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711608692; cv=none; b=iDwCa9CVbvPT3hnp/DLeWflRSD6JWPKlNfEwnL80dwUPoGlcde4KPiUepJRReV8cSib8rhh6dBfJJ1mnj4A8l18SI70qnIRDdX6kmUfVv1lTpzFbFgeBCT4syiKz9WWz0CLLhG/BPkyPqUa2SpY5eOfHZhCrgQNAiX1qajpmrF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711608692; c=relaxed/simple;
	bh=LIDoAU5YVIxdpGw5qxykbilLNFof0t4byLQ0YDnjk58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulYYhOUD79+r467zLvW+5eHelO+GB/3wKX+EUFYKy475Ogf4Wj0sUstjepEEI1TMyANcBTLe8HpxWfdZOTdyFQYljC7Wkbvdm03GSn3vhczwOl2kcVGfIRaj/UvIgRbDlmZ7JuPzVksWX25Udv0FJ6hAAsBnFIzZi/cnP7rk6CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUs/Eaw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE52C433F1;
	Thu, 28 Mar 2024 06:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711608691;
	bh=LIDoAU5YVIxdpGw5qxykbilLNFof0t4byLQ0YDnjk58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DUs/Eaw+N4AwggWOeEtrI6Y1nrWJvaS1iuv+3LHFcXD4DUiCX3rIc2uITA+DXZPPm
	 ECVDRpq9cV7tNlC7HPfcMfI/sA7v6Xcm2RTCWfxQxeNT6ZUPZCcRBILnfXv+5/t2ZE
	 IyltIgBcWuY42pRbwQv6meEl7tCERg05/I6ykZgIspWukeeVwQaYL89u5jvZz2/cPx
	 u76V9Jwab7ZeW3vPwhmXiF2Er4T9CRUrz/3Jp1auWN+1hiV03z/pz8Cgz8BZPC15rk
	 yJzYdvy5YeZpDGQp/6DR0NZuoY8fxSIngrEzKqejqcwL3NgKyST5mAVGpzd2aFAW4h
	 i/3Vzn5A45LRA==
Date: Thu, 28 Mar 2024 12:21:26 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	parthiban@linumiz.com, saravanan@linumiz.com,
	'karthikeyan' <karthikeyan@linumiz.com>,
	"bumyong.lee" <bumyong.lee@samsung.com>
Subject: Re: dmaengine: CPU stalls while loading bluetooth module
Message-ID: <ZgUTbiL86_bg0ZkZ@matsya>
References: <CGME20240305062038epcas2p143c5e1e725d8a934b0208266a2f78ccb@epcas2p1.samsung.com>
 <1553a526-6f28-4a68-88a8-f35bd22d9894@linumiz.com>
 <000001da6ecc$adb25420$0916fc60$@samsung.com>
 <12de921e-ae42-4eb3-a61a-dadc6cd640b8@leemhuis.info>
 <000001da7140$6a0f1570$3e2d4050$@samsung.com>
 <07b0c5f6-1fe2-474e-a312-5eb85a14a5c8@leemhuis.info>
 <001001da7a60$78603130$69209390$@samsung.com>
 <9490757c-4d7c-4d8b-97e2-812a237f902b@leemhuis.info>
 <8734a80b-c7a9-4cc2-91c9-123b391d468c@leemhuis.info>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734a80b-c7a9-4cc2-91c9-123b391d468c@leemhuis.info>

On 26-03-24, 14:50, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> for once, to make this easily accessible to everyone.
> 
> Vinod Koul, what's your option here? We have two reports about
> regressions caused by 22a9d958581244 ("dmaengine: pl330: issue_pending
> waits until WFP state") [v6.8-rc1] now:
> 
> https://lore.kernel.org/lkml/1553a526-6f28-4a68-88a8-f35bd22d9894@linumiz.com/
> 
> https://lore.kernel.org/all/ZYhQ2-OnjDgoqjvt@wens.tw/
> [the first link points to the start of this thread]
> 
> To me it sounds like this is a change that better should be reverted,
> but you are of course the better judge here.

Sure I have reverted this, so original issue exist as is now...

> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> 
> On 20.03.24 07:28, Linux regression tracking (Thorsten Leemhuis) wrote:
> > On 20.03.24 01:49, bumyong.lee wrote:
> >>>>> Hmmm. 6.8 final is due. Is that something we can live with? Or would
> >>>>> it be a good idea to revert above commit for now and reapply it when
> >>>>> something better emerged? I doubt that the answer is "yes, let's do
> >>>>> that", but I have to ask.
> >>>>
> >>>> I couldn't find better way now.
> >>>> I think it's better to follow you mentioned
> >>>
> >>> 6.8 is out, but that issue afaics was not resolved, so allow me to ask:
> >>> did "submit a revert" fell through the cracks or is there some other
> >>> solution in the works? Or am I missing something?
> >>
> >> "submit a revert" would fix the issue. but it would make another issue
> >> that the errata[1] 719340 described.
> > 
> > "Make" as it "that other issue was present before the culprit was
> > applied"? Then that other issue does not matter due to the "no
> > regression" rule and how Linus afaics wants to see it applied in
> > practice. For details on the latter, see the quotes from him here:
> > https://docs.kernel.org/process/handling-regressions.html
> >  Hence please submit a revert (or tell me if I misunderstood something)
> > -- or of course a workaround for the other issue that does not cause the
> > regression people reported.
> > 
> >> [...]
> >> [1]: https://developer.arm.com/documentation/genc008428/latest
> > 
> > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> > --
> > Everything you wanna know about Linux kernel regression tracking:
> > https://linux-regtracking.leemhuis.info/about/#tldr
> > If I did something stupid, please tell me, as explained on that page.
> > 
> > 
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> #regzbot poke

-- 
~Vinod

