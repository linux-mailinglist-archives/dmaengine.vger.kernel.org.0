Return-Path: <dmaengine+bounces-7298-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFA4C7CB55
	for <lists+dmaengine@lfdr.de>; Sat, 22 Nov 2025 10:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0A8EB356256
	for <lists+dmaengine@lfdr.de>; Sat, 22 Nov 2025 09:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E59B230BE9;
	Sat, 22 Nov 2025 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spcxbr0V"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348FD1B4156;
	Sat, 22 Nov 2025 09:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763803819; cv=none; b=Rcos8gHLI4/uBui6ioMCtjQyixnmoRRiznwbVlcUO4ZncjGZXj4efcec2VcMFRd2nxHDmCQuNL4OTPXGU5ebab1+C4aXY1kHfU8QpwzB5qQQcM9reFJIyqfAyhIn905HT2ygVnB3vmsXZnUxC7+xof1McDZODFVbjxYj/igbaUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763803819; c=relaxed/simple;
	bh=Ai+LE8Gr95nnOMo5dHhh4+Xl9SJvGnQwsoBd7ie891w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Rn+YoJwke5m3c3tATXzuv7SQhtxM+pVpp+UGTLBSaaykYR8aJqy/Bs/ZQJCPxI+OAHkzMFURR4Kqbm2EPK0JtxfJPwhWrdKRQ1Xy65OfnRlwRDVrwI79GDmL75Rmkm8fBIbFTjPhbkvimAequfi0OQgXpsxvmP3qEjTWl9QKrnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spcxbr0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578F6C4CEF5;
	Sat, 22 Nov 2025 09:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763803818;
	bh=Ai+LE8Gr95nnOMo5dHhh4+Xl9SJvGnQwsoBd7ie891w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=spcxbr0Vb+zV9Jg+OS45WrgZgjKKRLox9UNR5ofiLGgRbFvJqeEAD2myouhEnziJ0
	 KALERaD28C0Gap2b6HMiiuwy/2xh3BO0ZI1xb/a3YSdgYWIS/xqnzFoFyjbC1Co9xo
	 iWvAC5yt+cMNPjkDH8+y6BOPTsa1JMReARM/CxeYrC90dTf0dacWhDOHmhwCCHDgV3
	 IdS7J0FWsai3Kgdq+urIq8aqW0JHhHfae56saW+3pv9VuRyIHCDufSb0CV2QrWwpkB
	 9yTYIbmusTz774RBJGGfLpNY5QlkXaEPGTeepgs14Z8IO4dnOVjYD7m9ZoIAaGl5D7
	 /6pWyeCNyOjOA==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20251106022405.85604-1-rosenp@gmail.com>
References: <20251106022405.85604-1-rosenp@gmail.com>
Subject: Re: [PATCH dmaengine 0/2] dmaengine: at_hdmac: support
 COMPILE_TEST
Message-Id: <176380381696.330370.13914894604690798483.b4-ty@kernel.org>
Date: Sat, 22 Nov 2025 15:00:16 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 05 Nov 2025 18:24:03 -0800, Rosen Penev wrote:
> First commit fixes compilation under 64-bit and second actually enables
> it.
> 
> Rosen Penev (2):
>   dmaengine: at_hdmac: fix formats under 64-bit
>   dmaengine: at_hdmac: add COMPILE_TEST support
> 
> [...]

Applied, thanks!

[1/2] dmaengine: at_hdmac: fix formats under 64-bit
      commit: 938eae912ac52f8e9e5f2463e2db30cfe6f895d5
[2/2] dmaengine: at_hdmac: add COMPILE_TEST support
      commit: 5d8c5bea0da97809813b5f702700019cfffb6085

Best regards,
-- 
~Vinod



