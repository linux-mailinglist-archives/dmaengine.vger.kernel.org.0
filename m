Return-Path: <dmaengine+bounces-1869-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B02CB8A8A0F
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 19:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6645D1F2482A
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 17:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2844416FF4D;
	Wed, 17 Apr 2024 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2TsQmuV"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0444314199C
	for <dmaengine@vger.kernel.org>; Wed, 17 Apr 2024 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713374169; cv=none; b=VovnD1WkxTzIgGQ+Cam+cIYLtjqATKrF8m2fc19kF9o4MEYVZnV+Dlv/aXRXFAchVFubF1737SXuQIIf3344pYWricc6duPhTnxwpIL40Oidt2rQ9wKh6/XYfdzQiYy2kOw+/csJCKlxtRuA96zRGjo8E6P3KRl7uPmVdTGLWL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713374169; c=relaxed/simple;
	bh=imV/g/WEkmaQnDeP2HdMzzqPZJjd9WDskyqZrGH6dtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixLSPiLuQqASIUUAPU6kvSjZLEbDMPD2+VnRSogdgMbvx4PGi/ZLzDPn41Css4eDoZ20H1KLwg4snN+5oi8VOdxkBIdJu4v7TBxq61SLJI42txyWUkWHAflU5OfVYV7zx058O2nRD8R0SdErv91Rs+u3R86qm4kDgSq/dmssRrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2TsQmuV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B5DC072AA;
	Wed, 17 Apr 2024 17:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713374168;
	bh=imV/g/WEkmaQnDeP2HdMzzqPZJjd9WDskyqZrGH6dtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y2TsQmuVhqVduIkJiLFz/4DkIxk5aLbPIe0s7JRgdbB/4Zdprw1NYrU9dKKkjEj4v
	 1jnMewcdw/MHKKc/e7ykGBe/OnGIsvyy7RREL+7TV5Bp/aaLRez6XUne6UVm8Bw+qd
	 xIQswE0cUj6G3pQ/v1nHji49iFlNlYyvwgc6bylYy+roEQ/KHqF7I4WvEmga9cHmuE
	 AdCLGNl3Pm2mn3Vg8eB+MfHb+aaIDpc+ZFymet5GGnqWHQ2eJGbC4rUMkX+j68dra5
	 NKM0dpfhWp1k/xRuI6ZGbGwqtDqkRJLLxyoBIRiEJ9tNaPa7hoNjHtnT+V+0HTuuYL
	 ZwqY4C+wW7jFQ==
Date: Wed, 17 Apr 2024 22:46:04 +0530
From: Vinod Koul <vkoul@kernel.org>
To: EnDe Tan <ende.tan@starfivetech.com>
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	JeeHeng Sia <jeeheng.sia@starfivetech.com>
Subject: Re: [v3,1/1] dmaengine: dw-axi-dmac: Support src_maxburst and
 dst_maxburst
Message-ID: <ZiAD1AzCGzONGwkY@matsya>
References: <20231106095034.2009-1-ende.tan@starfivetech.com>
 <NTZPR01MB10189497FEC4D37D38B8A94FF83BA@NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NTZPR01MB10189497FEC4D37D38B8A94FF83BA@NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn>

On 28-03-24, 00:34, EnDe Tan wrote:
> Hi, I see this v3 patch has been marked "Changes Requested".
> Is there any part to be further modified?

Can you pls rebase this on dmaengine/next and send again

-- 
~Vinod

