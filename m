Return-Path: <dmaengine+bounces-4542-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F6FA3CCEE
	for <lists+dmaengine@lfdr.de>; Thu, 20 Feb 2025 00:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0620178F6C
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2025 23:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BC025C708;
	Wed, 19 Feb 2025 23:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raIXypYF"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083002417C3;
	Wed, 19 Feb 2025 23:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740006019; cv=none; b=RQIW/aYQisFnUd2epBqkuzMHlpJQFYU9w6i33dfI9fctOKzNSNEVq0JS/CPdjkN+7q+r7kwd/gdXw3Qeokz9Jj1ST0T1MT4VH81tI/sz4sWfNYKG4+Hpxxkl/10WKha03myXyqSZCxWUcQLKvqN91cSEuUGnWM+6YptBII9molQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740006019; c=relaxed/simple;
	bh=Fm7ii2ab9wmKHnkgzHIKXYVrWpsA7NKpu2v+Av3Ghh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8Us4RsomsfITU9PDdEg90J130XF70bEBKzecjvLoIR0wVC9k+qx0WNm/Cx7XKSpogyxqlBHZ8lgy6XMhev+oKh1+geWsCpUB2oyD/ssEeBwpHa6ag/kVN8n43lZyruRHnrzcBsuMbK44i6ED+p9owdj563L8MfL7BlsF0K03q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raIXypYF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABB7C4CED1;
	Wed, 19 Feb 2025 23:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740006018;
	bh=Fm7ii2ab9wmKHnkgzHIKXYVrWpsA7NKpu2v+Av3Ghh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=raIXypYFZI9kHKms0Iy1gpDJxZja85zUcLtt4/iedzY/wXqt55qFnkcZmjEPkB5ga
	 NLtetxbVC3/TrBR7e5Qdb0CcXCInXG66fQXmjn6ZRsXqPymT+3JSVfMMontJeM7MYS
	 EgvhE4CRss9oUxw9ev9t97jwvi2vLDDdlYkH/oWegidHL2NDChAydDpWN+R2regoBJ
	 kIPy1h4Q97GI30/COJxkdvh6zfefBIp359ZWAwlR4kneu1pSLr873FkzAdZ80vCcU0
	 6R9f1S/BeLtbMCZTmc/G74oQPy+s8AgpuTlWA1o8uW3ggF7VEdzzFdFdInEAqPUnmu
	 aNV+hrhphurHw==
Date: Wed, 19 Feb 2025 17:00:17 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: linux-kernel@vger.kernel.org, linux@roeck-us.net,
	wim@linux-watchdog.org, claudiu.beznea@tuxon.dev, vkoul@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, nicolas.ferre@microchip.com,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, alexandre.belloni@bootlin.com,
	krzk+dt@kernel.org
Subject: Re: [PATCH 3/8] dt-bindings: dma: atmel: add microchip,sama7d65-dma
Message-ID: <174000601710.3128913.15621337092238580817.robh@kernel.org>
References: <cover.1739555984.git.Ryan.Wanner@microchip.com>
 <8b69f0c6d8955790edcdbe5d1e205b43dedb99ff.1739555984.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b69f0c6d8955790edcdbe5d1e205b43dedb99ff.1739555984.git.Ryan.Wanner@microchip.com>


On Fri, 14 Feb 2025 11:08:16 -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add microchip,sama7d65-dma compatible string to DT bindings
> documentation.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  Documentation/devicetree/bindings/dma/atmel,sama5d4-dma.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


