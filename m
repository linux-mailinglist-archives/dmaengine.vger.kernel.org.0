Return-Path: <dmaengine+bounces-5848-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24758B0F1F0
	for <lists+dmaengine@lfdr.de>; Wed, 23 Jul 2025 14:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 377A23ACEA6
	for <lists+dmaengine@lfdr.de>; Wed, 23 Jul 2025 12:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BDD2E54BB;
	Wed, 23 Jul 2025 12:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhbhcSBm"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FD22E4990;
	Wed, 23 Jul 2025 12:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272611; cv=none; b=tuC3mZPF2Pft1MvHvHtKnL6TsXTFpLfEyz21vzsGrj5b9WxzPc5TGJid8lASR4X3YaS0Vp+0d9Jrb/NemdZwAbc9xumKjDsR5DKxpxWQrBMU4xHEueTla1oqO/PieJuRLujpsZSz7Tcqvn2MhW9gnZ4Vdp40z6gjuIhr2vJUZM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272611; c=relaxed/simple;
	bh=kguXGVIYahys1CghrE6fvQ9HN78HLNnT0gHXf8S16f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNYjUvwVfCMZMPOIiDiKN2h3SPNtXPaqSghAgPJgudS26rq9SxpDiD0P9MDTxOCW7KjZaZbPkL3lOgwz8HkdXe1di1W1ZmQMwxVmUFoCjGcEyvIi0oWgGBQtP1pIyR1sDAeIjN7NjHrpkrT9+oBN7jDpHHOXy05tFuodvNjBtfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhbhcSBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49C0C4CEE7;
	Wed, 23 Jul 2025 12:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753272611;
	bh=kguXGVIYahys1CghrE6fvQ9HN78HLNnT0gHXf8S16f4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WhbhcSBmnbcX4TqMivR1ZcpDk+ryonpNXh/HLk8F4QTKlZv09zeWZTvDPoDW7LR2x
	 I1tyfzwuJzp1P4p8+n5ItGrsfsopsM0ug5fXoxHUFd3AI1HJ8CQFBcDdQ9NdM9NG/s
	 v7yRCSiV60ISPREeq5U6c4cIoB/Hv57ThQ/x/KmydKQ1wke0MYlx/AJg6bLNnJffpC
	 f+p/QpTlmQqzV9zh1CW6eDWxOqySgXc0sLuQdub9W8b2t/uXSSiEI5x9ADov2JwTJk
	 s1SA8eARPX6GbS5STT6kY/980PBC/+UlrgS6kpWmULeCxsJDdJwHWk0RaiI8CIYiD9
	 GuezxBHxXWfOQ==
Date: Wed, 23 Jul 2025 17:40:07 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: nbpfaxi:  Add missing check after DMA map
Message-ID: <aIDRHwF2yOfNJAux@vaman>
References: <20250707075752.28674-2-fourier.thomas@gmail.com>
 <aIDQSA3JFbyyaWkM@vaman>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIDQSA3JFbyyaWkM@vaman>

On 23-07-25, 17:36, Vinod Koul wrote:
> On 07-07-25, 09:57, Thomas Fourier wrote:
> > The DMA map functions can fail and should be tested for errors.
> > If the mapping fails, unmap and return an error.
> 
> Pls change this to dmaengine: xxx that is the subsystem name as show in
> the Fixes tag that you picked up below

Ignore this one pls, that was for another patch of your which I fixed up
while applying

-- 
~Vinod

