Return-Path: <dmaengine+bounces-7302-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0AEC7CB7C
	for <lists+dmaengine@lfdr.de>; Sat, 22 Nov 2025 10:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EFD2C35B9B3
	for <lists+dmaengine@lfdr.de>; Sat, 22 Nov 2025 09:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39582F83A7;
	Sat, 22 Nov 2025 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qe4ztp9i"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BF92F7ADC;
	Sat, 22 Nov 2025 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763803827; cv=none; b=PwZ5PovVZa9soKz0rEjUTHfdt2lGCATziTcxQ5XVWhFhHhmWIUuXyJ2IbWEXNhDAhK3hNiLgEnRSdzJ1Xlcv4HFxBJ0cQhjq1YiL7WLAPxuRB1vhVJUbHbahKPsQlLIOgp7LScA9X1DZghUZvOrDzSK8mHR8u8pvf7M0RXZmxXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763803827; c=relaxed/simple;
	bh=gPjOlFCNoZCOPFYYmDNQGk4CstdDU63SlfKt0ghBK/U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D8R+tpW+J9H2v1S3psYsRBy0WotdE3har1eA8Pcn8204KvyiYME8oeZo4HaVKN+AAslIatq8KAs2YnNIFvRcYpUzmfwj8se5AbK/m/YlQlc5B5xIC3+8B9nAvHG5f+pNcTP7VJVUXEyLJjZ6+1ObWd2n4wdYusq3bgci+xzBhl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qe4ztp9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6247DC4AF09;
	Sat, 22 Nov 2025 09:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763803827;
	bh=gPjOlFCNoZCOPFYYmDNQGk4CstdDU63SlfKt0ghBK/U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qe4ztp9icLSb3JA2rlTw7LjNl3nL9Ts/kLMEd37mMkQ6nauIyCVPCqEnzePojWovf
	 pbA6AN5h3KLss2XexDniq7LIhGnHHxEdHRPCCPITmUq4Mi6ENe38TNcjgPin6YRelD
	 RwnAKrRBcKu5Wfh2DbfvXScU+bnB2eR0h+dxRv7cwX/e6+EdoT3PZKchBXZCigbL4H
	 SPFL4RIbTiCmQj9tnoVUh3vZBEymynpD2hd8P+guGx1+Kv9QxkgZsejMz602HIsx2Y
	 BZ8Ycm69H/QxSdZo9tJgxNWTF5Bs1OBmizNErw/N4ExHBcvAhcoJjzEOZw9dHMvEEe
	 hJhU8aY6cNkyg==
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@nxp.com>, Joy Zou <joy.zou@nxp.com>, 
 Han Xu <han.xu@nxp.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251119163255.502070-1-han.xu@nxp.com>
References: <20251119163255.502070-1-han.xu@nxp.com>
Subject: Re: [PATCH] dmaengine: fsl-edma: configure tcd attr with separate
 src and dst settings
Message-Id: <176380382502.330370.8930670246601246927.b4-ty@kernel.org>
Date: Sat, 22 Nov 2025 15:00:25 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 19 Nov 2025 10:32:55 -0600, Han Xu wrote:
> Set the edma tcd transfer attribution settings for the src and dst based
> on their respective dma_addr values, to remove the previous 32-byte
> alignment limitation in the EDMA memcpy function.
> 
> Fixes: e067485394328 ("dmaengine: fsl-edma: support edma memcpy")
> 
> 
> [...]

Applied, thanks!

[1/1] dmaengine: fsl-edma: configure tcd attr with separate src and dst settings
      commit: 1ecd8b6016c07da162175c708666762e058a0b29

Best regards,
-- 
~Vinod



