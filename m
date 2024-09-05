Return-Path: <dmaengine+bounces-3084-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF42A96E431
	for <lists+dmaengine@lfdr.de>; Thu,  5 Sep 2024 22:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DD2A286E57
	for <lists+dmaengine@lfdr.de>; Thu,  5 Sep 2024 20:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A471A38C6;
	Thu,  5 Sep 2024 20:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="h0zoMm50"
X-Original-To: dmaengine@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941521A2C3D;
	Thu,  5 Sep 2024 20:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725568600; cv=none; b=Xm5jOJiEozpH9lKP58U3OttscqA5KVfIj3J1QejVVisxsqa0u8VKqGB1f6hFYLYMnfqqniGWHLqaKn/MTJCxOT6LJC7mx0k5Dlrs0SX7mLnMuMDLGuRzZfNAzkwcIcXQRB4SJlLWr/d0i3ydEv/w5w3M3UWuCsaxrFm4LlFuMhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725568600; c=relaxed/simple;
	bh=JM2T45xkDtlvthbGkhpdgiyICNhya4XmwB99ESMCAZM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=es847T94wnYmcrMlswq7JOATi8dRIVQrQ0JBOQj8NbjtHO5q19AlU7cPSICtjMh2rScwtYJu5KGDDDQ8tVTqCWtesS3mAxMR3ZUdS66r1s/Z1WiXjYBGiNl/eIrTrhMDj2LhCtKZ9Y5tkxlHOLsfkUkchPOjP6K3Nd+w0KGc/oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=h0zoMm50; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8461E42B25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1725568598; bh=xNa+Q8PSCW7m4DRccVXfDl/4+sYRB5egVm1KwZDSX3o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=h0zoMm502MrG8P+tHBYLhudhoCbq24HA1qpkZtuUbwUtZTwObc1fXJaRRAVp8FhcR
	 nWvUYpxqk7s1CCA6d4ZAu87f2KG0CbR/VnnoPVuk9lrJafWcQ1J34H85Lvl6QXMctk
	 KLTGOAz5vZsqRLCTwY9a6AuRjwhTz367BjTSMbmRf5Iv/RsBJPWZ45b6pQ4Mlc2N5P
	 vKT+2Shk+oU/VZ6d+wxHOr8TVRNEzFrKQFe2xrVDnNqA1EOotMhzWEag/bPIy+p1na
	 7RliLaleNk/AA3A5S6ceD25TJtqPxGrLtpWu453Kgj/JqRPvQXrzr0sGXm5eSVPugh
	 nVaTWsMGo1sYA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8461E42B25;
	Thu,  5 Sep 2024 20:36:38 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Amit Vadhavana <av2082000@gmail.com>, linux-doc@vger.kernel.org,
 ricardo@marliere.net
Cc: av2082000@gmail.com, linux-kernel-mentees@lists.linux.dev,
 skhan@linuxfoundation.org, amelie.delaunay@foss.st.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
 npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 bhelgaas@google.com, conor.dooley@microchip.com, costa.shul@redhat.com,
 dmaengine@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, workflows@vger.kernel.org
Subject: Re: [PATCH V2] Documentation: Fix spelling mistakes
In-Reply-To: <20240817072724.6861-1-av2082000@gmail.com>
References: <20240817072724.6861-1-av2082000@gmail.com>
Date: Thu, 05 Sep 2024 14:36:37 -0600
Message-ID: <87ttetg7my.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Amit Vadhavana <av2082000@gmail.com> writes:

> Correct spelling mistakes in the documentation to improve readability.
>
> Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
> ---
> V1: https://lore.kernel.org/all/20240810183238.34481-1-av2082000@gmail.com
> V1 -> V2:
> - Write the commit description in imperative mode.
> - Fix grammer mistakes in the sentence.
> ---
>  Documentation/arch/arm/stm32/stm32-dma-mdma-chaining.rst | 4 ++--
>  Documentation/arch/arm64/cpu-hotplug.rst                 | 2 +-
>  Documentation/arch/powerpc/ultravisor.rst                | 2 +-
>  Documentation/arch/riscv/vector.rst                      | 2 +-
>  Documentation/arch/x86/mds.rst                           | 2 +-
>  Documentation/arch/x86/x86_64/fsgs.rst                   | 4 ++--
>  Documentation/process/backporting.rst                    | 6 +++---
>  7 files changed, 11 insertions(+), 11 deletions(-)
>

Applied, thanks.

jon

