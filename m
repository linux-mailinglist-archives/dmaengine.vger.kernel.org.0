Return-Path: <dmaengine+bounces-1308-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 594C3876335
	for <lists+dmaengine@lfdr.de>; Fri,  8 Mar 2024 12:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8F6EB209B4
	for <lists+dmaengine@lfdr.de>; Fri,  8 Mar 2024 11:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B666C55E57;
	Fri,  8 Mar 2024 11:24:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869E25576D;
	Fri,  8 Mar 2024 11:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709897084; cv=none; b=PDvUmSmx7e6F4CndvNK8RPFJA0R7dUmj5K+CA0Nu0EckNNqcxVOUGfe7DwOW08zzELoWiZTAk/y6haUiSTH7usD1xk62xXYYIyElC+wjMx+ryPfybyTK8AUuLkSw9h9HVp87f/SvZCRMFa4uDUFhOcoRBnj6UaiiBNmigIVVlck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709897084; c=relaxed/simple;
	bh=UQE/1WlfSfWuZu7fVXUh/GqUYDOPcZOra7z2U7FjIv0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eeOSspJSvInsQW1lrQqgPwZ5LwJvdzee0UKixzMU4z1OEXfHaXgILMRVwKnuIn9CcPAkBcPUG5Qsa++D/c+zw036Ed6C1G9kQWCb9Y5tGFw1az8PyFzPPsjFoDKe30rTizYY2gwiU4/gG+kQHo/97fMUFPbI1CM5EgyhbJ6zv9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1riYKw-004tIW-QY; Fri, 08 Mar 2024 19:24:27 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Mar 2024 19:24:42 +0800
Date: Fri, 8 Mar 2024 19:24:42 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: claudiu.beznea@tuxon.dev, nicolas.ferre@microchip.com,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mtd@lists.infradead.org, linux-crypto@vger.kernel.org,
	tudor.ambarus@linaro.org
Subject: Re: [PATCH v2] MAINTAINERS: Remove T Ambarus from few mchp entries
Message-ID: <Zer1ei9qgim1tDb4@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226115225.75675-1-tudor.ambarus@linaro.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi

Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
> I have been no longer at Microchip for more than a year and I'm no
> longer interested in maintaining these drivers. Let other mchp people
> step up, thus remove myself. Thanks for the nice collaboration everyone!
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
> Shall go through the at91 tree.
> 
> v2: make entries as orphan instead of removing them
> 
> MAINTAINERS | 7 ++-----
> 1 file changed, 2 insertions(+), 5 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

