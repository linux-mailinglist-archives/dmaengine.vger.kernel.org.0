Return-Path: <dmaengine+bounces-778-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 951C1836224
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 12:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4B61F2504F
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 11:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5623A8DB;
	Mon, 22 Jan 2024 11:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeZRFDWB"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28B71DFF3;
	Mon, 22 Jan 2024 11:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923168; cv=none; b=s/LmjE9JzY7lqup1Q0D5PrF7NXUjjOKmnXly8VXx3nxKjdaBAvPe01K7J+gkD/eteXQmOQhe+ZM7zajJZpRk/esFRPEZDx4VqKXmqc4VMJnqIMoo9X7+2F7dLLK1YPUsATX2w15H/0J4i4DwA3hRM+fOsVrKJCCmXB2My/4f5Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923168; c=relaxed/simple;
	bh=uDy/5VBSa8J4k7spOOc9VWyfuTTwmCdLUf/HonS9y3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhmmARDm+pQR5n/WsaulL2MnGU3kFPsMg2lEOFIvpgAa1RNWONhpMG7mRY3PQgvLLe1qCxcN/t4L0jvuc7XLmSzRLFSkhpjxnWGe3QIoHgi0zFlI+dZBnpJjxBE9ND3SOVjMXGk9kfSZxRTziC3oR+w3h9p/BGTGnF2bCHBjqWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeZRFDWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6FAC433C7;
	Mon, 22 Jan 2024 11:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705923168;
	bh=uDy/5VBSa8J4k7spOOc9VWyfuTTwmCdLUf/HonS9y3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LeZRFDWBtG4m+vzh0CM0FpBZgpXzK+0ecxKH/VyLqiQSj+G+Je7HBvO5vGED9OJHg
	 9sV4xhBBF9IIS432+5yOTFnMllWWtFeRih1BT8Bs0GymuFHpuQgAhAnFUBNUFNLl6c
	 8CUzve+N4QmRypTLWrJTu6ZqFZjfEPHOuXIlQBBEB7BrBqZ9KE84HwTWiE9NTVO3hY
	 XloT+zFbYb02uk7LZoGvKVZ3C5+0nOhH19+8VTfojS/VOorMPLtJAJEsuxDJAtm8dd
	 L7iJoht57ux6s3bdQEHbelQmhYzMsz4+iZ3hTx0MGsZfll9oTbkhKjem9svnbkhHQV
	 FymWMC0lYTdgA==
Date: Mon, 22 Jan 2024 17:02:43 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: Re: [PATCH 0/3] dmaengine: timb_dma: Adjustments for
 td_alloc_init_desc()
Message-ID: <Za5SW6xdsOFylD7x@matsya>
References: <ebd531dd-60e3-4ac3-821e-aa9890960283@web.de>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebd531dd-60e3-4ac3-821e-aa9890960283@web.de>

On 25-12-23, 11:15, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 25 Dec 2023 11:05:45 +0100
> 
> A few update suggestions were taken into account
> from static source code analysis.

was this anaysis done by you or some tool reported this.
Frabkly I dont see much value in these patches, can you fix something
real please

> 
> Markus Elfring (3):
>   Return directly after a failed kzalloc()
>   Improve a size determination
>   One function call less after error detection
> 
>  drivers/dma/timb_dma.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> --
> 2.43.0

-- 
~Vinod

