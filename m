Return-Path: <dmaengine+bounces-4166-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C384FA1736F
	for <lists+dmaengine@lfdr.de>; Mon, 20 Jan 2025 21:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D691884E27
	for <lists+dmaengine@lfdr.de>; Mon, 20 Jan 2025 20:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5BE1EE00F;
	Mon, 20 Jan 2025 20:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwF8CHED"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32579190067;
	Mon, 20 Jan 2025 20:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737403688; cv=none; b=BpV5jGbU719lzRDlOvjggMeAaMOCV5DjCd7KKXc4oV0qXflqaGu0p1Q8e+z7nG5YN6PUEYYIG1ZJvaXYo47kx4MTHd48YIJvZkWXP9drlFKw0J8AgQm2frsL2UL0+26g7NGuZC9LiZPD7WkP+MsFWwRhVJeQHpA2cc+zhUyZqfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737403688; c=relaxed/simple;
	bh=aGb2QpaJvRtjEmeNSrWQbWribxm6Ts1/Eac/8u/SorY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gLQSwEwrizYg3MXeeKjMSuW9qQRYbbI50UyPb24iIm6kkl4mseh+vOzNXNrDdPNVJHK8QyXIX4lwgZqk6cPSv8pXcQe0l8czwmeapwUs9WPbGxnOio9zSRAgXrsYbNM8fmYwU9kqdfMzCcV3g/QF2W1/UxkB/B7nyY6IcSe35dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwF8CHED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1371FC4CEDD;
	Mon, 20 Jan 2025 20:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737403687;
	bh=aGb2QpaJvRtjEmeNSrWQbWribxm6Ts1/Eac/8u/SorY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PwF8CHEDwHRAcjUJDlUCdzQ0OIJ/NkPeyd6WzZddg5UiYw4dF2ZI/Nj0/Ni2G+NFy
	 aWxDrKlXxSnbikG5fzqk9JoCDxwj+tEq3TohUFKadpo3ruuspy4A8GTTLQBOzEXWkJ
	 oK5eMgJyxVPE4OXPog1HGYVI3/EOiDlAY/H+gfQzphhYViqnXem0byyyVilhHXQkrd
	 Y0fPcR+n0N5eLhZulG8zofPpT+w/O8QX+uameQNXt6KvOc75Qpfia/72aW36OrRfc3
	 m1GMsKV8J43/Y704H0giQjOLLZD5kw84V1RhPWHqN2wVM+C84SUjvK5hehVW8aAMKe
	 iyWy4uwXGevRA==
Date: Mon, 20 Jan 2025 12:08:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>, Vinod Koul
 <vkoul@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, MD Danish Anwar <danishanwar@ti.com>, Siddharth
 Vadapalli <s-vadapalli@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 srk@ti.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dmaengine: ti: k3-udma-glue: Drop skip_fdq argument
 from k3_udma_glue_reset_rx_chn
Message-ID: <20250120120806.4d1fd70e@kernel.org>
In-Reply-To: <20250116-k3-udma-glue-single-fdq-v1-1-a0de73e36390@kernel.org>
References: <20250116-k3-udma-glue-single-fdq-v1-1-a0de73e36390@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 17:00:46 +0200 Roger Quadros wrote:
> The user of k3_udma_glue_reset_rx_chn() e.g. ti_am65_cpsw_nuss can
> run on multiple platforms having different DMA architectures.
> On some platforms there can be one FDQ for all flows in the RX channel
> while for others there is a separate FDQ for each flow in the RX channel.
> 
> So far we have been relying on the skip_fdq argument of
> k3_udma_glue_reset_rx_chn().

Assuming this goes via the DMA tree:

Acked-by: Jakub Kicinski <kuba@kernel.org>
-- 
pw-bot: nap

