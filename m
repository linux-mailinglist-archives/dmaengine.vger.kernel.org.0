Return-Path: <dmaengine+bounces-787-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DF2836E90
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 18:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A141CB2A407
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 17:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6A154277;
	Mon, 22 Jan 2024 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrF+s7E1"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9740D3FB0D
	for <dmaengine@vger.kernel.org>; Mon, 22 Jan 2024 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705940732; cv=none; b=HxJ6pvXmePcfUSBaEy+g+plamc5jMGaq2EsO+wLAZPjNYQF3+PsbWAo9twnq5WMUsTUGDvQaABXzJ/rbjTUvGN81a0ihH9fhFEWZ+aDAdLGa7K4ChG5t1GZlEEed+a7DgMOaSQbByzywUZmIXbjUqSw0ssL+8sCRMzSKf8uLfio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705940732; c=relaxed/simple;
	bh=yC8tceaAPQA/5vDe3db7kj5wDh4BnFUykM7Jbkyu65E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Iu6GYW9wk30HrwVEoKVOA7Vs9rP8wD4FZ7RusvvBqXU1L2XBdq44l6ay0uJeOMyShdhq6NoObK0AQa7EwVB+P0AvGeJg5C4Ufcp8ceRdnwSaLehnaqBH8CPMV8Y/PJPrklVMxe+oZvCE5klEmkhcbzlMCj4LTswjE/ICWSVnNiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrF+s7E1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5CCC433C7;
	Mon, 22 Jan 2024 16:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705940732;
	bh=yC8tceaAPQA/5vDe3db7kj5wDh4BnFUykM7Jbkyu65E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BrF+s7E1X1RzaNyROfACgDOYJPPByHxcqeUS8vjqECLUrhICSBO1Z86hyZrQ+mV8j
	 qDMqP0noou8fW40bq5XgQgCD4ib19hlOXp8THELrBVUzORkBASxqyzW9wZnifXgspl
	 9CyMEWQMuU+uSBApsJYFDrL148Pf1B0BOnvJHIBTZ70m8xn08Q5qhcCRJ38HXWx/LA
	 wm0HM0hQ4kxOhQ85q1q+UAdFPnEhiwC9BdKrs9zOjGOYtzxAqHSQstE6uBN+BSGZEk
	 7SUxyYeJV602B85f5WPJKHcUygsQQN0qOYAkDXG5iAo0c+dvJt79ykXC8eHcsNMi0s
	 TvENXTu548FIg==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, Peter Korsgaard <peter@korsgaard.com>
Cc: Michal Simek <michal.simek@amd.com>
In-Reply-To: <20240105105956.1370220-1-peter@korsgaard.com>
References: <20240105105956.1370220-1-peter@korsgaard.com>
Subject: Re: [PATCH] dmaengine: xilinx_dma: check for invalid vdma
 interleaved parameters
Message-Id: <170594073056.298019.12452434779302866510.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 21:55:30 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Fri, 05 Jan 2024 11:59:56 +0100, Peter Korsgaard wrote:
> The VDMA HSIZE register (corresponding to sgl[0].size) is only 16bit wide /
> the VSIZE register (corresponding to numf) is only 13bit wide, so reject
> requests not fitting within that rather than silently transferring too
> little data.
> 
> 

Applied, thanks!

[1/1] dmaengine: xilinx_dma: check for invalid vdma interleaved parameters
      commit: 8fcc3f7dbdaeff3c3be47a15d1acd7863dfee92d

Best regards,
-- 
~Vinod



