Return-Path: <dmaengine+bounces-475-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0005780E356
	for <lists+dmaengine@lfdr.de>; Tue, 12 Dec 2023 05:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E85A1C219FA
	for <lists+dmaengine@lfdr.de>; Tue, 12 Dec 2023 04:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE65AD2FF;
	Tue, 12 Dec 2023 04:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wy92Xu0G"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE13DD2E1
	for <dmaengine@vger.kernel.org>; Tue, 12 Dec 2023 04:34:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE29AC433C8;
	Tue, 12 Dec 2023 04:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702355694;
	bh=I4R2B+RBsqShG0X7SO/Qln27isb1UxQm2PVbMLk8OOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wy92Xu0GuNi3RkDwWZAuzbNoIjXotFScQWQgipvCy8rbWuwEtGNNfejlHjThN+JMl
	 47IMZuY5r71OZiQSS+oTobYoux2XYkkJGsTZmX2r4rwxhT5YW0upI5RB+2eYOqIAaq
	 FrY7N19ZDQWDBgU79AkenynQOiD73Dn1ow0ZzAAtDfWD3dn21gS3fPLRSiy+PmD5eO
	 CHNjFvcfPdIOf2/DXZDZornN/EJsnNiKYar/FWS2KQzm68Iiz1h6xNTZLcC1YE818F
	 isoBWGEF1bIvYOpoykA83aW7SDPHzY4lV21NK4YH3U4Ak+PTDnucDx3jdwrZeQnrAr
	 2btfDRBwjS89A==
Date: Tue, 12 Dec 2023 10:04:49 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dmaengine: axi-dmac: Small code cleanup
Message-ID: <ZXfi6dqrZADEkCya@matsya>
References: <20231204140352.30420-1-paul@crapouillou.net>
 <20231204140352.30420-2-paul@crapouillou.net>
 <ZXb5IhaNiKJufH/k@matsya>
 <3da88ffe37e1fa20918848fdef8f80e5ae49743a.camel@crapouillou.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3da88ffe37e1fa20918848fdef8f80e5ae49743a.camel@crapouillou.net>

On 11-12-23, 13:15, Paul Cercueil wrote:
> Hi Vinod,
> 
> Le lundi 11 décembre 2023 à 17:27 +0530, Vinod Koul a écrit :
> > On 04-12-23, 15:03, Paul Cercueil wrote:
> > > Use a for() loop instead of a while() loop in
> > > axi_dmac_fill_linear_sg().
> > 
> > Why?
> 
> Simplicity? Code quality?

It would be great to mention the reason :-) right?

-- 
~Vinod

