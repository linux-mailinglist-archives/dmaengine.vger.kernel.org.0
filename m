Return-Path: <dmaengine+bounces-2513-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 342F991424D
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2024 07:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7166EB2188D
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2024 05:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC751C6A5;
	Mon, 24 Jun 2024 05:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAjx1hwZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D32D1C695;
	Mon, 24 Jun 2024 05:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719208107; cv=none; b=eYrqbQ8JXFxXWh+v3yuW5zEF1YI+g9ws9e37sZ/Fjj2TDGv60z0TkKLZdnGtQi/nKFMGzfx1h3mWTEQf1tWgQyUWplmhphCeMKEdkL8i8FGYJ3HveRMun6jntpnuTYcQyOYsiN6v/SBgRVx/q39rrNWJppURKpSodTs4dm0olw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719208107; c=relaxed/simple;
	bh=EourWPaNB2bHqBYEW7rh4epgCS+pHIlvg5pzFoxaYKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlYFYFkbN+NXGmfmP9ca+0FJ66pGcQrClKC8NjD8VD1tD6snkiocLcUWTdiVxOhzD4xZV4ZEZz5YWgQvPBTOUxqDF5JAzo3vhbASZGB1jTddOXMPIJBnVT4EqfnhKrMl4Vrpik54CGER5XzvMZ1ZpQKsfEbncf1BU2GXqolNpTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAjx1hwZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84385C2BBFC;
	Mon, 24 Jun 2024 05:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719208107;
	bh=EourWPaNB2bHqBYEW7rh4epgCS+pHIlvg5pzFoxaYKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LAjx1hwZutEw3xMd1HuvOxKMJvFyeHFNuNl3dt7Qss+ZPxCwZVZVOn6BzJCHcYcXY
	 3Yj6AMnYB1GK5I15UVQwsVfh0jj5R7Lpo/2BKRbNUrmqFwalHi8C438KNdQecfeas3
	 X8Qa1iCojnIj4YB5wpvX0FQtyp16CjusVmLDjBsdfZOgDzK3m35A+On04v6EAeI1it
	 ZlT1cjtHwaQ5Q4ibZzZ7jEJ5A+1ekFeDa+rmEDLuSofYL9L6gl96TTTglOUePEZu8D
	 GoM1hp9ZjpNUZOz0BDpbEKVP/7MPj9+Jw+OmquoAVuYyhXkncEDpOGzDhP5aT1ELEt
	 pxMwZs6xL0c1A==
Date: Mon, 24 Jun 2024 11:18:23 +0530
From: Vinod Koul <vkoul@kernel.org>
To: nikita.shubin@maquefel.me
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v10 38/38] dmaengine: cirrus: remove platform code
Message-ID: <ZnkIp8bOcZK3yVKP@matsya>
References: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
 <20240617-ep93xx-v10-38-662e640ed811@maquefel.me>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617-ep93xx-v10-38-662e640ed811@maquefel.me>

On 17-06-24, 12:37, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Remove DMA platform header, from now on we use device tree for DMA
> clients.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

