Return-Path: <dmaengine+bounces-2986-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C8C962F17
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 19:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31D97B2167E
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 17:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC371A76AB;
	Wed, 28 Aug 2024 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlHtseyY"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA00149C53;
	Wed, 28 Aug 2024 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724867669; cv=none; b=M3sUS/0QIcO4GMAAisUvNBKnKTN4h55MCbr9i4bTk5VhdAdcKwm1ZfzKTb8HeFv/gHYrDGXVipYcrzjA4GHi1EoKeu9xbcS/GDBZOInCl+CchJoagaNypUeq5zHLRL/81yGTl4qejKLvxgLR5gKI8T0M5Bu0v5L1xzQUT1fXu1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724867669; c=relaxed/simple;
	bh=l/ZNIom6N7B5N0r4yLqJa5E9u6l8R83pQOwCw712860=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlfcGdZE5qM42Vkq3wIfSQszYu+xaztLLe17+c9/NuryxqQVdgbFhP5hLwzZSBb+oYyxOj/1DQJdPvW6nbEXmjeH0vhGGUDNDKWLGHAPosOVsOZ5In77sleb+WLC3H1YFYEJvcqTQ3Zi44ga0mBldAR7i3NGCHmleLhlK5oqBkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlHtseyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057F7C4CEC2;
	Wed, 28 Aug 2024 17:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724867668;
	bh=l/ZNIom6N7B5N0r4yLqJa5E9u6l8R83pQOwCw712860=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TlHtseyYUnvzFrDhzTzOTDq6caNJFit2vOYHfsQ+Ekj8CEW13UuLXQH3KjwZsWF4+
	 RFt3qiPIs+z3LhA2g6O9sXyZOSbEqfj22du1mkvyIUPyDeI9+exV1r6FCpN31RNc97
	 roAS4+/g6VXIG4d4vkMpR7iaUbsQLJMX5owG01QAYRxpGBsIYiUTvpPjp5ti2wPpii
	 HHGVAPlT0vCv3wkdncqs82GwIIAf+XjYkVyhJ9ltNnavsG4Xn/YjF3HIQULHMfgp62
	 o3vt63T5D2+P9UPPR5WXU2fpYk0Z3l0ZkXxYz3EIR+6UdYkADuqCT5i/N4qP6vvSZZ
	 yFX48MWaAGLAQ==
Date: Wed, 28 Aug 2024 23:24:24 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v12 2/3] soc/sophgo: add top sysctrl layout file for
 CV18XX/SG200X
Message-ID: <Zs9kUAeapWeN/4GS@vaman>
References: <IA1PR20MB495396729244074C36E51E11BB942@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953E0D56CE4010C470E4A71BB942@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953E0D56CE4010C470E4A71BB942@IA1PR20MB4953.namprd20.prod.outlook.com>

On 27-08-24, 14:49, Inochi Amaoto wrote:
> The "top" system controller of CV18XX/SG200X exposes control
> register access for various devices. Add soc header file to
> describe it.

I dont think I am full onboard this idea, but still need someone to ack
it

> 
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---
>  include/soc/sophgo/cv1800-sysctl.h | 30 ++++++++++++++++++++++++++++++

is soc/sophgo/ right path? why not include/soc/sifive/... (sorry dont
know much about this here...)


-- 
~Vinod

