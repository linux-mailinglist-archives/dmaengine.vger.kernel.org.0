Return-Path: <dmaengine+bounces-1082-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC7C860B2C
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 08:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADAB0284589
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 07:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AEA12E46;
	Fri, 23 Feb 2024 07:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbUYA4Wa"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A70111B5
	for <dmaengine@vger.kernel.org>; Fri, 23 Feb 2024 07:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708672223; cv=none; b=LTVZe407acurKop5rKcLMzSX7CyAPg0WFxQb02U5W7wV3QWBuiv62ptmL+Fp55La3+RhRGIjoIy47cN1/7FGmJZ/5OiQbAdjH3TaaHh8jjXtg6hAmgemK9cmyV1ALtchrk45d+JlxbfQdSZbOJYg7lZE7KuvCPB3ltBDdE75E+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708672223; c=relaxed/simple;
	bh=3eVLF2ZUABFGxE9k31vBPei5Vo4JSC5Sx9LI5jj/uiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMMujs3d/eq/fykvwtFmfSDmiVQXdF1aZZjXrlhr9RaNKa+ST2OHbpiFSOkBexYxwtKhImASXp2h/xG4TRngsWkwpHhSjqA2EDOMdn25tvZ2DNgmwwLHOYtLtoSDQPBC+HA2hy4bmM3z+QsVKoSBm5DhPJX4d1cxvpWKBuGKXz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbUYA4Wa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19419C433F1;
	Fri, 23 Feb 2024 07:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708672222;
	bh=3eVLF2ZUABFGxE9k31vBPei5Vo4JSC5Sx9LI5jj/uiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LbUYA4Wa/9GQRY6mUsrgypLPhnKeze7G/jcXJSvZ9R0uRwZ6mF5MYcsRqIcZSuAPE
	 Ts7x/suh4M3V8vWzMd9mn/0rGLRCbr1yDwgLm5Gy9E3P0bWfmA6+poAQBzjoR580Qp
	 FiAu6A1zyKjZMadanaFXLtWW5PyeSHed1NRCuVqOtwvLV1T9tXufgJy8b3P12SJW9j
	 u4i+EpIPPheYKOCFjUzsjrNSCYLLg7K6K01+5+EGHKvuJwSG/91KIEd5qnm2eufXXt
	 AkiWuTrkKjIdkHClRi7RNPwla79bU5PQv+vC/yOkoq5E0POCsghpaoFHhjj1BYpPTa
	 NYmtxC0pFB2Pg==
Date: Fri, 23 Feb 2024 12:40:18 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 2/2] dmaengine: axi-dmac: move to device managed probe
Message-ID: <ZdhE2m40lsxIgdr7@matsya>
References: <20240222-axi-dmac-devm-probe-v3-0-16bdca9e64d6@analog.com>
 <20240222-axi-dmac-devm-probe-v3-2-16bdca9e64d6@analog.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222-axi-dmac-devm-probe-v3-2-16bdca9e64d6@analog.com>

On 22-02-24, 16:15, Nuno Sa wrote:
> In axi_dmac_probe(), there's a mix in using device managed APIs and
> explicitly cleaning things in the driver .remove() hook. Move to use
> device managed APIs and thus drop the .remove() hook.

This one fails for me somehow (applied on next after merging fixes with
patch1 on fixes)

-- 
~Vinod

