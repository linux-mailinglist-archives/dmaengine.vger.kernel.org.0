Return-Path: <dmaengine+bounces-5042-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F9CAA4845
	for <lists+dmaengine@lfdr.de>; Wed, 30 Apr 2025 12:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F5C9A75AD
	for <lists+dmaengine@lfdr.de>; Wed, 30 Apr 2025 10:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E64248F49;
	Wed, 30 Apr 2025 10:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XamfUbB2"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6448524728A;
	Wed, 30 Apr 2025 10:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746008816; cv=none; b=naInMrpSSIJjS2NlUktYX3yOYjUnfTn+frQiC52xkNdWQfPHW+Oe1N95aBfecSmRn6V8Uz5/WATfNhOuL6YTTD2AsEaJUNMILACojh7Dd12xQ1iiLTRSPVKhgkRXSx2vXVCXXjQVyuS6wwGx/PYXCvVqNepP/6+p54Qa9PI8AmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746008816; c=relaxed/simple;
	bh=5S9/3Cg3zb0MLDpEzZB/1IkVH5v3jhxJVRqkX8S9KxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIMUte7oh7WeDAyECW9JWswmo+30OCiRplrpwXbB8sVLUJ+DgljpftAkw6p/WYDJ9Tln2yC+1lIyGPaAlDC+iixXKYN9J+NReTCZjnPvQbU9ZhL2F/AETymsYk3yERwk7x8gD1WOuUcKh+7moVH2hDcfRsmlxNhNFXxadsZziek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XamfUbB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63953C4CEEA;
	Wed, 30 Apr 2025 10:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746008814;
	bh=5S9/3Cg3zb0MLDpEzZB/1IkVH5v3jhxJVRqkX8S9KxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XamfUbB2nzUFIt1CdO7w6/fo7KeVY+bm/23pzrF6jyDFiUYDH2my85ZglLFDGHjnA
	 BCEd7KgzlpkYX5nxDPVB3dYH7R24PIwHlTPzTKTGHuO8P5wEBC+mAKJ6Qp3+b1BPg8
	 gg1Ezd37VscW1RdpaMlgvofeBpQw+LraPWHyRnjqwM2D0aG4S35ssbyyTeE0kghGwH
	 OTPzsT/2+nc4U0HFv+Ldyk2fWsLpn+i7f3VoSr2S5420CL+TuaSoJ2QIxcbku/Q1rE
	 pgI58zZpMEp57tXGkjiVIhLtL0adU9RA783eE7IxEBd649ZigrJNBFEaBh/55kdG45
	 RSY7C7o2RtlEw==
Date: Wed, 30 Apr 2025 12:26:52 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>
Cc: peter.ujfalusi@gmail.com, vkoul@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, nm@ti.com, ssantosh@kernel.org, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, praneeth@ti.com, vigneshr@ti.com, u-kumar1@ti.com, 
	a-chavda@ti.com
Subject: Re: [PATCH 2/8] dt-bindings: dma: ti: Add document for K3 PKTDMA V2
Message-ID: <20250430-imperial-masked-coati-e35bdd@kuoka>
References: <20250428072032.946008-1-s-adivi@ti.com>
 <20250428072032.946008-3-s-adivi@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250428072032.946008-3-s-adivi@ti.com>

On Mon, Apr 28, 2025 at 12:50:26PM GMT, Sai Sree Kartheek Adivi wrote:
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |+
> +    cbass_main {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +

Same comments.

> +      main_pktdma: dma-controller@485c0000 {

Also, drop unused label.

> +        compatible = "ti,dmss-pktdma-v2";
> +        reg = <0x00 0x485c0000 0x00 0x4000>,
> +          <0x00 0x48900000 0x00 0x80000>,
> +          <0x00 0x47200000 0x00 0x100000>;
> +        reg-names = "gcfg", "chanrt", "ringrt";
> +        #dma-cells = <2>;
> +      };
> +    };
> -- 
> 2.34.1
> 

