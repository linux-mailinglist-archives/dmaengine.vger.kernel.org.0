Return-Path: <dmaengine+bounces-971-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DE784C69F
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 09:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22BC284D5D
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 08:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A8C224CC;
	Wed,  7 Feb 2024 08:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHhc/yqb"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E921822330;
	Wed,  7 Feb 2024 08:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707295763; cv=none; b=kExAMLV5XBppyBfzM0N+4b6ZsWl6JyeA84LYIoWiaU6LzNm9JpOjhNRyQvrSJzvE72ihdW1i6cQo7eT4wXalsVgCsBAm0tX86d4ORQ9y+rgYXcWMaXtN205FmdCzPW1ywi9YYF3FZMbkrNRhQGpi4OZQpYGeCgDyJYbRQYloNxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707295763; c=relaxed/simple;
	bh=TbAcqz0mGJsR9fiXxXrluv9eRK49GCzOINwUfJOjukE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iwfqlNB89/CfV3wkZvn8yxzcKyG7H+wUk+k2OFthK85er4Udz11pKS3st+tOVY4tuKaIh3LnjBHfmUbTJWsOTWW+iNOXjBSdi0J3BCCGLIgPTdLn0iiKuQlWB5iwuwHDVCh0Fnp6sNiBbW15dSy0gwav94PicqbFg9n5yQ12c98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHhc/yqb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3D2C43394;
	Wed,  7 Feb 2024 08:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707295762;
	bh=TbAcqz0mGJsR9fiXxXrluv9eRK49GCzOINwUfJOjukE=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=JHhc/yqbKeDphleMDK7XumtKf7+IPNEaDzyy/raKvGfWZta98X0CySmPovTXvE3t0
	 lR89FkKfZThv1sLTlPHiKwvbuR8FWGtkek1gQBuLFW/PNbBgSuA3rmmgh6l/A84avs
	 ogg0+yWgf7E+Vp6qfeYBab7ceexyBbfxdQCQrXwctQyMPupR6tnT1adi8LhYmCZ3s1
	 llM+X+ILjH5HffeOQUS/t9dQLh7307cJErZ+DWZyRB4UmQ4LXZZAFBqlWwgc96IHPV
	 8QAgULi3Xo2aUQhNnkxj4vQJkTPBEF2X4vguSZ5KlkAAyGr2E5nCURntaanUWwtK1k
	 3goUWRlBHguDg==
From: Vinod Koul <vkoul@kernel.org>
To: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20240131163318.360315-1-Frank.Li@nxp.com>
References: <20240131163318.360315-1-Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] dmaengine: fsl-edma: correct calculation of
 'nbytes' in multi-fifo scenario
Message-Id: <170729576129.88665.15939613879389769749.b4-ty@kernel.org>
Date: Wed, 07 Feb 2024 09:49:21 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Wed, 31 Jan 2024 11:33:18 -0500, Frank Li wrote:
> The 'nbytes' should be equivalent to burst * width in audio multi-fifo
> setups. Given that the FIFO width is fixed at 32 bits, adjusts the burst
> size for multi-fifo configurations to match the slave maxburst in the
> configuration.
> 
> 

Applied, thanks!

[1/1] dmaengine: fsl-edma: correct calculation of 'nbytes' in multi-fifo scenario
      commit: 9ba17defd9edd87970b701085402bc8ecc3a11d4

Best regards,
-- 
~Vinod



