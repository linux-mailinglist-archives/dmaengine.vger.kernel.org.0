Return-Path: <dmaengine+bounces-3258-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C053C98CD09
	for <lists+dmaengine@lfdr.de>; Wed,  2 Oct 2024 08:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2BA81C21523
	for <lists+dmaengine@lfdr.de>; Wed,  2 Oct 2024 06:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1D67DA7D;
	Wed,  2 Oct 2024 06:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsq55Jai"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34CF2581;
	Wed,  2 Oct 2024 06:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727849948; cv=none; b=CZuqFH2b/pwa0j6p7EOOWSDgcvmTyhLcTyCSb+vx0KZ0rg3dDjrI+XnkNg25+v0HuLolN8DRzXi6n0mI407Z4lPw8HRBye0xVKhoW9hsrqeEakoQTFUrPQ+MFjIzaMj4bReRfKwGj70a0zzqFMzSQPvFHPZRHq/ANWeQ/M3EuZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727849948; c=relaxed/simple;
	bh=Ec69O9tYD2gVzjwH4yVPMdo8/xd0Z/q0QMbyEZrhR5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+ne/JtqjlWkf5HIgpz3g6HwumweCIXTyjWMLjlI4o9iJvbmlzsJHB+a/ZcEckLJNIxpaOCWLrD5GgfJrUCd3uYyMhU11HScA8TtDE60tKZiduQLbNun6huMk1thkJZzQu038Ay6jguuam+M4NGCiaDf25Xt8PnxrpVSX16iTi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsq55Jai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998E1C4CEC5;
	Wed,  2 Oct 2024 06:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727849947;
	bh=Ec69O9tYD2gVzjwH4yVPMdo8/xd0Z/q0QMbyEZrhR5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gsq55Jai/rVlmYmu9vZu8GVdmryh5Q+w4TDqtyfLLvEqD+DwI7uDEqWMTCDDfqlKI
	 1UVCuyuySerrVb2X9qVUYOdE6pVt+a7s5+pDxEWakBsuyGMDliPFZCC11cLQvGFCYS
	 3ImcC1kgoB/sCzzM/kJNHZNL1idi4SdMQPfJ6X+kXXv0ouMB/XspR0vTaI+4oINXI3
	 2Pn02QBmMNc8F4lW+nBWHBBresJPcTXaEF1DkGcJynOpWQAAbY9DqYTISqQh1GKOSG
	 xdQIyoZhNrU+VrurTcFAwG9cD3bL9IT4jrV6q5AgNDU4t0J080zknc3KUPzleewl0v
	 eUY6Sx6WUKMeQ==
Date: Wed, 2 Oct 2024 08:19:03 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: dma: rz-dmac: Document RZ/A1H SoC
Message-ID: <qifp4hpndfhe6jlmzjmngr7uolfzvj663donhjg5x7kmeb4ey3@a2a66w5l35zf>
References: <20241001124310.2336-1-wsa+renesas@sang-engineering.com>
 <20241001124310.2336-3-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241001124310.2336-3-wsa+renesas@sang-engineering.com>

On Tue, Oct 01, 2024 at 02:43:08PM +0200, Wolfram Sang wrote:
> Document the Renesas RZ/A1H DMAC block. This one does not require clocks
> and resets, so update the bindings accordingly. Introduce a generic name
> in the header to make future additions easier.

Does not require or does not have? What does it mean that device does
not require clocks? It has its own, internal clock oscillator? But then
how does it match with external clocks which are still apparently
supplied?

It looks like constrains are relaxed because of current driver
structure or current DTS...

Best regards,
Krzysztof


