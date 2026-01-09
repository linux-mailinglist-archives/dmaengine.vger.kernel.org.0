Return-Path: <dmaengine+bounces-8137-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB105D06ED9
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 04:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52F8A30383B2
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 03:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D452326D70;
	Fri,  9 Jan 2026 03:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tu3vzJ+X"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575EE326931;
	Fri,  9 Jan 2026 03:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767928176; cv=none; b=kXotq6/v/xEvDmDt8ReUc262Qi/DhkslwywxzGpNVJtsQU+jAVpD+rZwvDIoTdUzGn5frOwlT3R3qpyhfq0IHDaLveRLRqbwsVpe0Z6osdEQZktc3grTvCMKT2aeg4c27bKf0NzyDgTLrygOPdtMFpu+F5aODoPnxa33P4yaRmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767928176; c=relaxed/simple;
	bh=0cQ804d5oBgJTAsw/RDJuenvuVsOTUFl3Z0qlDfKl+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8LqE/KpTTKb4vSkygaiWwsvCxhA3c9FZbbjwh+wjfEs/P3W21hX3yms9mIKS5XnT3j+Xc/Shzc4gxP0s1BXlFjU3Hooze+HTPeXR7huCMWQ+HVlhvV1PutD/M7bY4+grJDQf8PDXRkgUSatElmRRXmrLFcQn1Ez6hUQa8mnTmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tu3vzJ+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152C1C116C6;
	Fri,  9 Jan 2026 03:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767928175;
	bh=0cQ804d5oBgJTAsw/RDJuenvuVsOTUFl3Z0qlDfKl+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tu3vzJ+XrNLAdFrs0GXEE6PBXDgfqoAxHv8LR+lbtGID2LpqlbGm897xFT8ov4irJ
	 //NewvBNg/TctZFaYPerE+a4bzyUmHKAakfD8pHGA25D36ZPZKnhU6bwTXcnuC65Lr
	 BhspWeAKTF+ANxL146BhbPNZ5CWmGbHDBymeqM3ldi7PkBipDQyXWaQBTNyf5wLRFN
	 9qCapBZTBI7HgGDJMinaGhawFsWvgGxS1g+n7/65cHn+Pt6Qk/nszW9Y95uA5JHVlI
	 UX+X5taqTaNj5nlsF5BAVUl7aaFHnA8mENR3ZFiBGImfSJmTfbCgQe796QDiaT31fZ
	 igx6eD+QPvPjg==
Date: Fri, 9 Jan 2026 08:39:32 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	sibi.sankar@oss.qualcomm.com
Subject: Re: [PATCH] dt-bindings: dma: qcom,gpi: Update max interrupts lines
 to 16
Message-ID: <aWBxbNpRIAxQ6DDu@vaman>
References: <20251231133114.2752822-1-pankaj.patil@oss.qualcomm.com>
 <20260102-fiery-simple-emu-be34ee@quoll>
 <aa62b769-4be2-4e6b-b2ca-52104391a757@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa62b769-4be2-4e6b-b2ca-52104391a757@oss.qualcomm.com>

On 05-01-26, 12:29, Pankaj Patil wrote:
> On 1/2/2026 5:57 PM, Krzysztof Kozlowski wrote:
> > On Wed, Dec 31, 2025 at 07:01:14PM +0530, Pankaj Patil wrote:
> >> Update interrupt maxItems to 16 from 13 per GPI instance to support
> >> Glymur, Qualcomm's latest gen SoC
> > This has to be added with the compatible.
> >
> > Best regards,
> > Krzysztof
> >
> @Vinod can take a call on squashing, the glymur bindings
> have been applied to vkoul/dmaengine next tree.
> Let me know if I should resend.
> Lore Link- https://lore.kernel.org/all/176648931260.697163.17256012300799003526.b4-ty@kernel.org/
> SHA- b729eed5b74eeda36d51d6499f1a06ecc974f31a

Sorry I cant do that. Please send update based on patch already applied

-- 
~Vinod

