Return-Path: <dmaengine+bounces-5043-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2333AA4853
	for <lists+dmaengine@lfdr.de>; Wed, 30 Apr 2025 12:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F6999A769C
	for <lists+dmaengine@lfdr.de>; Wed, 30 Apr 2025 10:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB67E2528E4;
	Wed, 30 Apr 2025 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3E+X7C8"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E9B24EAB3;
	Wed, 30 Apr 2025 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746008918; cv=none; b=LJPcERntMk4/HYBFzan/f9OzlgXoGzioijglvw9k8ps2ASyoQhcmw0upxE52la0Y59b9HKT8Aq8O3sU42W8uvdxK3GPFmO/FIwJQwYMkLX7JdMfUTrrfPkTZs5qEMYiUnLJwo1NKyxN8IK2evLLS/qkhIQ0o43kcidJHqAGXYqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746008918; c=relaxed/simple;
	bh=d3X6TbzGnM0uYj/utTjN7zqqW+wG0ygiugDmgPjIW7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srzOpYzFm17G5pTdz0/GuU3G5sIuxS+x1kHtpePh11gWZZlzmwy4rZxq92ttsxJaD/qqKIuxY2XYndCCtOgBHKjood0tC2ULBq55O04fO4iW6klk4RTCg6fmdEfUDwBYkzFBPQ4+HUz+APv/h/i5VPY0g4tGdboB0bOokDlq8xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3E+X7C8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D040C4CEEC;
	Wed, 30 Apr 2025 10:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746008918;
	bh=d3X6TbzGnM0uYj/utTjN7zqqW+wG0ygiugDmgPjIW7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f3E+X7C8mRqOxnq1fLHIC5AWbgma1iiUO0TA6rWhMuv5lN9DKabN90fnWQ/86gBG+
	 Z+ldxSWRTqXBi3WWojlQ01Be3jthptR3Gu8quaEzSAT5VeMXnsOQh5+JBfaf8A6kp6
	 it7cqvFiprtdJo2yP1wnuywYxbhaOykTeuwg75+yT/oZ42zkdW7ZNfQ8EcOaYw4Qr7
	 M0GsrYkEksr+W4RWwx21AsT43u1YCEtibVY2mFaxDqJgmMly4UROzru9nJlCWK9JdP
	 G8/J9Y+P3iT2fcKBYiGyfgB1/zCiJWtwJ6raEb64pqfwMhbA16scDUamgTnufSE9Dp
	 H/2xZSpBqNSeQ==
Date: Wed, 30 Apr 2025 12:28:35 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>
Cc: peter.ujfalusi@gmail.com, vkoul@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, nm@ti.com, ssantosh@kernel.org, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, praneeth@ti.com, vigneshr@ti.com, u-kumar1@ti.com, 
	a-chavda@ti.com
Subject: Re: [PATCH 3/8] drivers: dma: ti: Refactor TI K3 UDMA driver
Message-ID: <20250430-vegan-pudu-of-enterprise-8f122f@kuoka>
References: <20250428072032.946008-1-s-adivi@ti.com>
 <20250428072032.946008-4-s-adivi@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250428072032.946008-4-s-adivi@ti.com>

On Mon, Apr 28, 2025 at 12:50:27PM GMT, Sai Sree Kartheek Adivi wrote:
> Refactors and split the driver into common and device
> specific parts. There are no functional changes.
> 
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>

Keep consistent subject prefixes, not random choices.

> ---
>  drivers/dma/ti/Makefile         |    2 +-
>  drivers/dma/ti/k3-udma-common.c | 2909 ++++++++++++++++++++++++
>  drivers/dma/ti/k3-udma.c        | 3751 ++-----------------------------

That's way more removals than addons...  Not sure how this can be easily
reviewed...

Best regards,
Krzysztof


