Return-Path: <dmaengine+bounces-2512-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EC391424A
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2024 07:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 850FD284B15
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2024 05:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B9417BCA;
	Mon, 24 Jun 2024 05:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKq9L4FD"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA6E4A3D;
	Mon, 24 Jun 2024 05:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719208095; cv=none; b=p7fmVG14PjUcQYiPkCOYiz2wNTzt/Va2LNk/yzSbGacHtQ/0c3MnzaHKCBLMKJJ16jtRnCOLTgB7mc6AFMJxOsTxFmKR3PV9Z1vlIXWIMYprzuW9EHzT2nIWK53Mq5EflFuaifKsvJQ57PDfdeufhsdbHd2BLf9ecsaZ84QZPoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719208095; c=relaxed/simple;
	bh=P7D2dMLb4LOYZpWwddedj19OdPDHaTOoKLKfKE0fCqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U72WAz2TqYfK8mz3Z0ir6nL9phGdeg3Ys92rvqhqpfeIJJFli4hzlticlB+a0bNG2fv0YXaEgbkvBslwkMyEBLldemp1GY6DVhG+sEZ3pBWXMSQq1j1WdrItnpqU1446dMKv0Rmru9fP+ft02l0x+5YClJkQsSl+Uc2NTPYnDZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKq9L4FD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB0AC2BBFC;
	Mon, 24 Jun 2024 05:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719208094;
	bh=P7D2dMLb4LOYZpWwddedj19OdPDHaTOoKLKfKE0fCqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BKq9L4FDZg0sGDs3TJTuxmpGFp9WMwdDO/jQZC9pXh97rtb/42Fr1QH+Bc35Kcnow
	 KZyCJWeMA68YEXch+IJUBeKVuWLIo4gWJM5rIslrvykyJPJGDQqmwicBB6zgBm2lqU
	 Muez8rpnYDwoGdVeDm0/pGRcQFrPnO/tGBHSlNLS132cO2XIC0ZqZNjMRYDPNw1yfH
	 1pmi94PdHF8nr90v4zNbb45Q8M5+A5rOMUZfnJHolbIOL6+THVXjcKI0DEtrikX3Bm
	 s4S/CDpzv9t4czsYq1imrBK3u30KQZ+v4nZyTnhnO4byAVw8GX0uBlz/xD9rzd0kcf
	 W0J+TsUZl+BZQ==
Date: Mon, 24 Jun 2024 11:18:10 +0530
From: Vinod Koul <vkoul@kernel.org>
To: nikita.shubin@maquefel.me
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v10 09/38] dmaengine: cirrus: Convert to DT for Cirrus
 EP93xx
Message-ID: <ZnkImp8BtTdxl7O3@matsya>
References: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
 <20240617-ep93xx-v10-9-662e640ed811@maquefel.me>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617-ep93xx-v10-9-662e640ed811@maquefel.me>

On 17-06-24, 12:36, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Convert Cirrus EP93xx DMA to device tree usage:
> 
> - add OF ID match table with data
> - add of_probe for device tree
> - add xlate for m2m/m2p
> - drop subsys_initcall code
> - drop platform probe
> - drop platform structs usage
> 
> >From now on it only supports device tree probing.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

