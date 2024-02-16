Return-Path: <dmaengine+bounces-1029-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDDC857CAF
	for <lists+dmaengine@lfdr.de>; Fri, 16 Feb 2024 13:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D963288B1B
	for <lists+dmaengine@lfdr.de>; Fri, 16 Feb 2024 12:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE431292D8;
	Fri, 16 Feb 2024 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFNps+VE"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBE51292D0;
	Fri, 16 Feb 2024 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708086894; cv=none; b=ETohflCwY41hMZABkAEsIIeqv72gTqa+aCPSwD9xB7sbVfpLPYPyre8VcS43sLnaX2wxCXDrSiZiIqR9WvYbtq5B/9u6p0jrc5lfF+RHOb8MHZL4wSymmciCBdnUSu5eb/3h0YhLbC8IXIsi+crSCuIbcrES1+8VYSS2o4rWJVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708086894; c=relaxed/simple;
	bh=84+avuu+fRMIcuxjHdSmoCFBpNYOfQji7oeZS1P70Eg=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Jpcqobn2cZCwUVeH9FtR3A9gwToD79w85IUkSa7/jDeXTVB4C2tP60tx7O4335XP5i/A4md0jvpUN8/Y0EvNF3oqenWIRTUOEZG7bj8Gu/H/SVrcBfezav1Sr62W5E5CqBG0TvYBLKnc9OqV8RvRglCwgdluBhmz6RGU2af2zLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFNps+VE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB3BC43390;
	Fri, 16 Feb 2024 12:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708086893;
	bh=84+avuu+fRMIcuxjHdSmoCFBpNYOfQji7oeZS1P70Eg=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=EFNps+VE5v4ktvGSguZn/YLkAOyz6mAOG3xR01t70lNtXw2P6faE5fHeX0DYu6DAg
	 iv3RBLsj/b3nW5j4MtWh7G3CD33jzNf6FjBYMTJZnjoTksEfVwn8pS2aFwErlDHXJ0
	 Z5/05bNuC5uLLe81Kgfy0exRy1fcMO2Rc3O11TOE5fjHitEosq4Q+OGI89Ot8wkwIN
	 YV8yqCssLJtm/rB8rv3vMht8hESiWFNSYBhZbuKXX1JzUkhLW+3dvNdQ18A0QfpgqO
	 ZD5sEUMkPTg37Kz44EGlqM/m3aDgLmPyoy+bTZqvn+9uBkQHTCNzwKYmngg6YW10eu
	 EGl1uKpnU9j0Q==
From: Vinod Koul <vkoul@kernel.org>
To: Joy Zou <joy.zou@nxp.com>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20240207194733.2112870-1-Frank.Li@nxp.com>
References: <20240207194733.2112870-1-Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] dmaengine: fsl-edma: correct max_segment_size
 setting
Message-Id: <170808689144.369567.8654351635732648675.b4-ty@kernel.org>
Date: Fri, 16 Feb 2024 18:04:51 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Wed, 07 Feb 2024 14:47:32 -0500, Frank Li wrote:
> Correcting the previous setting of 0x3fff to the actual value of 0x7fff.
> 
> Introduced new macro 'EDMA_TCD_ITER_MASK' for improved code clarity and
> utilization of FIELD_GET to obtain the accurate maximum value.
> 
> 

Applied, thanks!

[1/1] dmaengine: fsl-edma: correct max_segment_size setting
      commit: a79f949a5ce1d45329d63742c2a995f2b47f9852

Best regards,
-- 
~Vinod



