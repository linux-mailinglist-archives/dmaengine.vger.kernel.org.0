Return-Path: <dmaengine+bounces-9126-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HEsHX7yn2kyfAQAu9opvQ
	(envelope-from <dmaengine+bounces-9126-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 08:13:02 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D341A1B24
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 08:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47B96307E844
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 07:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A56638E110;
	Thu, 26 Feb 2026 07:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q04UTGbf"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1737E38BF94;
	Thu, 26 Feb 2026 07:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772089671; cv=none; b=YdNsLnTt7DhEsbYjEIo6ILBAfH1oCpUlhzPOas33Z8dxadojuX+0fVeBSldx/ISC0KMufLr/JL8NgJB0KLO8K/SAxM6tI4X4PCTyApUKTmUr3gPjw2WxdrYEJInmUMjsHLG0qPDv6vIB3Wfz2LE5ONRcZ+7QHFKdqftAFhTq7Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772089671; c=relaxed/simple;
	bh=RT93O7jTBol1YGqh80blX9bj2WHRyJuArkFn2VBcPEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9/6rjuE/cXCXs5HRGR1Q6FaN3oBEQw/fLe6ssoqlkxZmIc3x/VdJSiRE35OH9al5Y+c0VXw4hLCs2AQX5yT5sQwKFSkn1DTDjWUJG1x0fJ3MlKISM6G3D33R18yCpNpD4zWzXaAO9lEARlSIbGK2LuVW6RgLvb2JCU8OwCspjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q04UTGbf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F10C19422;
	Thu, 26 Feb 2026 07:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772089670;
	bh=RT93O7jTBol1YGqh80blX9bj2WHRyJuArkFn2VBcPEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q04UTGbfGv4R3KRDHg3m8AYKAE5kCykWSpG9ZTuAxAHmas7jGfgOPqpct4D2U4mAd
	 v2MEFMqJfX6SBuITztQmsZU4OTLEemutnAFlhDwUURnIUg3gS1kibO85xMDsP1E2cR
	 PlIQowYBAw3YtGvdGuxzHSR5/YAbTyggXQU7TTbO1JEqpBcuRp3Bfw6UthqPZ2IOzl
	 SSqqRwouAV/CBvHC6gl3ldbTFd4XjP4jBImNO8nYYxMtQHMd+Gnwimr44zo9kxc7KA
	 ErDGzmuIYrH+M0Q/x8EYlbAUX5rpdLu7SvyoBFRM9qtIdNeHcmV+XzBf3CxT1z35S+
	 o9UfPx6r8y6iA==
Date: Thu, 26 Feb 2026 12:37:47 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Alexander Gordeev <a.gordeev.box@gmail.com>
Cc: Frank Li <Frank.li@nxp.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] dma: DMA slave device bringup tool
Message-ID: <aZ_xQ8jk049d1OgW@vaman>
References: <20260221132248.17721-1-a.gordeev.box@gmail.com>
 <aZ4njFwdYsMLTcSa@lizhi-Precision-Tower-5810>
 <aZ7CwvrgPMkzMouW@vaman>
 <aZ9lL6-Q07PryHqN@ideapad>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ9lL6-Q07PryHqN@ideapad>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9126-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E1D341A1B24
X-Rspamd-Action: no action

On 25-02-26, 22:10, Alexander Gordeev wrote:
> On Wed, Feb 25, 2026 at 03:07:06PM +0530, Vinod Koul wrote:
> 
> Hi Vinod, Frank,
> 
> > > I am not sure if it can work for general dma engine because it slave setting
> > > is tight coupling with FIFO settings and timing, some periphal require
> > > start dma firstly, then enable DMA. some perphial require enable DMA first
> > > then queue dma transfer.
> > > 
> > > burst len is also related with FIFO 's watermark settings.
> > 
> > Correct!
> > 
> > I like the idea but it is not practical. Every dmaengine is tied to the
> > peripheral for setting up the transfer. It is not a memcpy! How did you
> > test it, which controller was used ..?
> 
> I likely missing something, but how this differs from dmatest, which also
> lacks any controller-specific setup?

slave dma needs a peripheral to test. For example a spi/i2c etc
dmaengine in slave mode will not work untill unless there is some
signalling for dmaengine from peripheral to push/pull data.

> I tested it on Avalon-MM Interface on Arria 10 FPGA and found it super-
> useful - thus an attempt to share.

Which driver is that? Seems more like a memcpy masked as slave to me

-- 
~Vinod

