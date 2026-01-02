Return-Path: <dmaengine+bounces-7999-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D381CEE8A6
	for <lists+dmaengine@lfdr.de>; Fri, 02 Jan 2026 13:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8686F3031376
	for <lists+dmaengine@lfdr.de>; Fri,  2 Jan 2026 12:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5940530F94B;
	Fri,  2 Jan 2026 12:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyZyDXhl"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC8D22424C;
	Fri,  2 Jan 2026 12:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767356874; cv=none; b=diZzQjbmz0/h6Mh8+py0AHaJsMhjoxsjYw9hFtGwYZ6IcuoYgYG6eYEIHmXEX2+aBFHpVuW5SVgkgMTk181COMyEcVdd6467p/VxgeuLGi0Vif8zcvw1pXOIcy6S+qUDCeInnNJ68fJxigvc6h4CcOgLSL8df54lnGoXwLIntcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767356874; c=relaxed/simple;
	bh=UP9g23K0AT5+uGctsz7j7AzYfoKuN52JB86VGi2IS3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B26GABab46ZuYPeqw9+lWn7RIodDWaVewS29B3kGmfeFOmqLGBUTWHqM3qfl36PkPixKz5y8drRZg1NngLmCP60+lnac1pCvWgjdti+na/pCpRlNhZyeHVqhRi6u1ueElWQIuvo/ZparXhVR65BebzBHedoaPlxMvhzicGo5/NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyZyDXhl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D8EC116B1;
	Fri,  2 Jan 2026 12:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767356873;
	bh=UP9g23K0AT5+uGctsz7j7AzYfoKuN52JB86VGi2IS3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lyZyDXhlYXh5p/UGMCjz5GcSST7RHfbqbPQsMKtC2hTwq9En/69zxpecIOHaMGS0/
	 eziWHu5x8bejCENLvp59AMmbgN8g5VzePO8OdJjkRsP9GB9oRLzEzhPG95GgKpBM5b
	 75LNng4CM+IvMHxhFrhx385nAGtEyqcS4609haIf1GRoM5XnKTuM3fvAN01MWRqsNA
	 i8u9Z1IvGV+Xc1Hkv4XSdYMLIXI/naUpNf1OMebPvg1aOdGqBb5/ZGgdZJgZBD9Zzh
	 TAiVZX0HIGWz/jRLWeYmZbz99JbiOow+1q8dEf3pkx8Mledorrjv2VbeortizOUN5p
	 4zClKm21p7TgQ==
Date: Fri, 2 Jan 2026 13:27:51 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sibi.sankar@oss.qualcomm.com
Subject: Re: [PATCH] dt-bindings: dma: qcom,gpi: Update max interrupts lines
 to 16
Message-ID: <20260102-fiery-simple-emu-be34ee@quoll>
References: <20251231133114.2752822-1-pankaj.patil@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251231133114.2752822-1-pankaj.patil@oss.qualcomm.com>

On Wed, Dec 31, 2025 at 07:01:14PM +0530, Pankaj Patil wrote:
> Update interrupt maxItems to 16 from 13 per GPI instance to support
> Glymur, Qualcomm's latest gen SoC

This has to be added with the compatible.

Best regards,
Krzysztof


