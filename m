Return-Path: <dmaengine+bounces-1589-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CF288F650
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 05:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58DA01F299E0
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 04:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F291831A81;
	Thu, 28 Mar 2024 04:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHAwY+1M"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C351C1CFB6;
	Thu, 28 Mar 2024 04:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711600001; cv=none; b=puET09T0qc1ziKprmJ6z40P2WgY7Ot8iseQwyPN0g+0Y4DWDuCeSz16kox7UrD5vm8EbmMYeWA1UsZGMNhTD+S1hWUC8pB/qUQTRmTJ1Fhgg0To7gzjKZ9qi4hKI0JPdt/2HD6KaGuxQwGiPfEAdZjgDgmzkVcVGo9KqC1b4aac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711600001; c=relaxed/simple;
	bh=aNTs/Tyzf7WwBFofaBwMZmFa+VhYHm76TEXTLOPseMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jm0pqLrI6YbP0y7vp7jndtp5DJVnlp5ae/r0nnxkk9QitlvpKD8cjxxNMXd2pdAygspFQBacoHEHTG1zTAc7aI/kAQ9AZ/oA52ticJbb1s9lrnLzB0LvAaK7xjUDjAxxrrjlp9COHmAZX+E4gF9tqmk3PX9gNcH6T3TnPIUSG8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHAwY+1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D21C433C7;
	Thu, 28 Mar 2024 04:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711600001;
	bh=aNTs/Tyzf7WwBFofaBwMZmFa+VhYHm76TEXTLOPseMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uHAwY+1M6nFxp+a5Lc4h54KmxMI8YpN/33FlM5WoEuvzAwk0lEP0J2VzbvRBCercd
	 a5Ui72ou2/dh4QjaVtk2XEJrPp+Cr4+HLvj/wk9+CrNHgDXZvBcP754WX5XPS16Qn9
	 vSvKELvOJRpNzHF8LnjELpFs3QayvMgX9wiEBqiqvOOyg0HSUx1T4Vud+Qrfp7dFZe
	 TW0MZ/Ws/2IQ+A7Gwi7LsumlUt3brY+Pp+p30jIKyXTne8E9l9xWeob2K6a2wl1p0Q
	 55yb9Ybn2CrQQbYGZl36QiS5v7ITlb4sx5gxHteTABWBsT+pFTIyoXzXFYXkodjLbK
	 erjWlXoNWdiFw==
Date: Thu, 28 Mar 2024 09:56:36 +0530
From: Vinod Koul <vkoul@kernel.org>
To: nikita.shubin@maquefel.me
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v9 08/38] dt-bindings: dma: Add Cirrus EP93xx
Message-ID: <ZgTxfLQcIamAXhnl@matsya>
References: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
 <20240326-ep93xx-v9-8-156e2ae5dfc8@maquefel.me>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326-ep93xx-v9-8-156e2ae5dfc8@maquefel.me>

On 26-03-24, 12:18, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Add YAML bindings for ep93xx SoC DMA.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

