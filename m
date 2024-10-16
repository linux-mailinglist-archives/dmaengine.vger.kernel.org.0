Return-Path: <dmaengine+bounces-3390-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51979A10B3
	for <lists+dmaengine@lfdr.de>; Wed, 16 Oct 2024 19:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7969B283EE2
	for <lists+dmaengine@lfdr.de>; Wed, 16 Oct 2024 17:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716F0210198;
	Wed, 16 Oct 2024 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNS5eEYv"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4472A18B48F;
	Wed, 16 Oct 2024 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729100017; cv=none; b=rhM+t87LdyUh/9jlUwR/HZvMwJIEIKxo9qoo/BO7tjJ7DHj/uo+/A2BAtuHr9JjpwLy9fULf8+PW+aV2vXJHhQS4SJHgC1P1IpIz1GwCyafUdYqKXh7QD1Oc6cj6N2TQ3JvNovxfrI5Hd0aScBp0c/pJuLYi5NRW6R59mD90x6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729100017; c=relaxed/simple;
	bh=wtfh80IvBuoxq9N6HapzeJouFtMVgk01N3a0zNQebwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6XaAZWWc3PNX9r7Q/UEOS3DYOHnS4fSxvPT14JSi1hXPqU5XXFDzLBWvxdgdqkUASl6ww+bMEgW+saa/7xyerfmFEXmiMF8ihZfjO3KGfC+acFbK6LNsNyRy/thg2CI/Q5oGnAzcbUcqCs628OX+hhJlY6vA6jfRF41LMLV1hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNS5eEYv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F8BC4CEC5;
	Wed, 16 Oct 2024 17:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729100017;
	bh=wtfh80IvBuoxq9N6HapzeJouFtMVgk01N3a0zNQebwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bNS5eEYvRqJajb3r44E/MqXiN0sPJLO9zE0WvRZwP4EViidiEvNC3vMPyVD6iH39O
	 22/xqfZUjLo7wVqgCl27Ysy+/3Ykt5RU0c4bJzujMJI+EfNzjK8gyv8cC1msNXDMjB
	 hQstHfqn4her+5zt4L8TDXMHf/XL4aUsUtneUlJzy67G0H6fg9Kkj1K6W0ctNhKoxv
	 M1F8Vtsj2tnMcGYDsl0bD6cjcZMfoERgwYLDWQPa/OhoGXIAjWu8LEcUb++quCxkut
	 y4SiEXGFJ+15lnQaPLplTbpjqjTgzaCilWAxoMpch2tGc9mByUY/hLg43N3/DgKSE4
	 WhrKcARfumXgw==
Date: Wed, 16 Oct 2024 12:33:36 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/9] dt-bindings: dma: stm32-dma3: prevent additional
 transfers
Message-ID: <172910001570.2076913.18277281938022731096.robh@kernel.org>
References: <20241016-dma3-mp25-updates-v3-0-8311fe6f228d@foss.st.com>
 <20241016-dma3-mp25-updates-v3-4-8311fe6f228d@foss.st.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-dma3-mp25-updates-v3-4-8311fe6f228d@foss.st.com>


On Wed, 16 Oct 2024 14:39:56 +0200, Amelie Delaunay wrote:
> Some devices require a single transfer. For example, reading FMC ECC status
> registers does not support multiple transfers.
> Add the possibility to prevent additional transfers, by setting bit 17 of
> the 'DMA transfer requirements' bit mask.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
> Changes in v3:
> - Refine commit description as per Rob's suggestion.
> Changes in v2:
> - Reword commit title/message/content as per Rob's suggestion.
> ---
>  Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


