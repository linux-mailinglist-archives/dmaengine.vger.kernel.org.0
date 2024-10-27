Return-Path: <dmaengine+bounces-3608-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE4D9B2075
	for <lists+dmaengine@lfdr.de>; Sun, 27 Oct 2024 21:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 303DE281D29
	for <lists+dmaengine@lfdr.de>; Sun, 27 Oct 2024 20:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FE517E004;
	Sun, 27 Oct 2024 20:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnEcATsv"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078C4558BB;
	Sun, 27 Oct 2024 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730061658; cv=none; b=VB5r1uJtxAp0UOCEeZkxE0N7DCPOKhPEjrKnIXee/UZc+QPrNNdMVNYb/pyDvkOoCHfQfXYxuP2Xsdc51tVnRtfEj7BW8Uu6odZCmmGMXKGuL7mZ4kVa3Q6lvwHwsOeX1REeF5/JdHz54dic8gu+zLP5u1karETOobjMy8THeG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730061658; c=relaxed/simple;
	bh=CbXmtdv3IjeDBQxB55AZf9jmxsHSvyuvWmObEhgds4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSkCVXSAqWyiyuhQg1WuWAxFOd3MP/ijhVaMaCXxct/wBIreIzfF7uzSAvN7alxGBLcbxd9AcGd/XPvZKLPwXc7ixY5gF2QMCQIbKDtHMX/+jg6f+WCKtFrVhFXlybYlC/A4U821sRZ+4qmrA+MLVPUCdE0Mcp65Kv5dr4YYNNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnEcATsv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB30C4CEC3;
	Sun, 27 Oct 2024 20:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730061657;
	bh=CbXmtdv3IjeDBQxB55AZf9jmxsHSvyuvWmObEhgds4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LnEcATsv4UT/1vK5R7I5/K9/vJjlyku4VD0Cz9tTzKxg/1okqaOmGYhSQzEAM6V4p
	 Bqgb03IVNIqiJq6KW0v26HYIxTMTCWGjAgfHLP7db7WReBwc8ueZRCGXOE7hDBT3cJ
	 EdzATkwXfLrdUZ7w5WKD7j28Vz3F49GEQpVxGh4QDN6MJYqgAovHUBTd1vRHq3acqE
	 4tLI2AJtTNOOtFN2/MJ97OIuaLQwHvO/BIRjct6GUkBM7CTtzLW4g5Wks0Cbg6w1Pj
	 JnM5fmvSBY/n132MaqDfC7WKLFaBSRvfHCaV8xuUmVawSfjDwbKAhP0K/KlY92wRuJ
	 qH7pT4pOKG7zQ==
Date: Sun, 27 Oct 2024 21:40:53 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?Q3PDs2vDoXMs?= Bence <csokas.bence@prolan.hu>
Cc: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 03/10] dt-bindings: dmaengine: Add Allwinner suniv
 F1C100s DMA
Message-ID: <b44xrgwi3swuvliaxzzk5tvanxrmik5zm4tcqzavl32wbgce3e@yb4eerrluanv>
References: <20241027091440.1913863-1-csokas.bence@prolan.hu>
 <20241027091440.1913863-3-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241027091440.1913863-3-csokas.bence@prolan.hu>

On Sun, Oct 27, 2024 at 10:14:34AM +0100, Cs=C3=B3k=C3=A1s, Bence wrote:
> Add compatible string for Allwinner suniv F1C100s DMA.
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://lore.kernel.org/linux-kernel/20241024-recycler-borrowing-5d=
4296fd4a56@spud/
> [ csokas.bence: Reimplemented Mesih Kilinc's binding in YAML ]
> Signed-off-by: Cs=C3=B3k=C3=A1s, Bence <csokas.bence@prolan.hu>

Missing quotes? Are you sure this passes checkpatch?

Best regards,
Krzysztof


