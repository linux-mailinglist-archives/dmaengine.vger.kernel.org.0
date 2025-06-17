Return-Path: <dmaengine+bounces-5502-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7C2ADC201
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 08:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5071D166ACC
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 06:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7482A25D52D;
	Tue, 17 Jun 2025 06:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDqEObYq"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E57199924;
	Tue, 17 Jun 2025 06:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750140170; cv=none; b=LiZS6illaEm3SGect5LHmgT0MX8cYEooYLK/yDufrhIIaA28zcYy40ei4hUPOUiHeEe9GaQmdoU39CIExfSJVAixR55iP3FA28n1tdzNyZNeAYQkNu2w1CScjCpfn9feoBByMaer1IBzHxwv6iCcql/yFo6v1T8P0oX99kSMEHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750140170; c=relaxed/simple;
	bh=y3LjvVl5E7KxK3T3g5NR+r6/2sbufh9dPYcDzRkbfdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8ATYWOcTq4aZQEiozy/xuaTwREyauZJ+JE8LTwTclizO75hCnQ9joC6VYJopZ5G/sv+k/D/5ThQ36FRMtUf2sOwi0yLWz1NaWRb7SYmnBJTQy3w9kHYVLYC98a74DwjJEY18GA4CMLw0SbGKLK9xVGoXQj1t2Z3MUolTF7rgQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDqEObYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985FCC4CEE3;
	Tue, 17 Jun 2025 06:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750140170;
	bh=y3LjvVl5E7KxK3T3g5NR+r6/2sbufh9dPYcDzRkbfdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vDqEObYqJgZsr3HsU3JEM5UdeuznK8bpOubp16XshTnWA4lQcYuVdnMkfpsodMRMN
	 z1a5IKqyB0y+o1RcfgyJ46ItVjTYPamCYQ/Qm71gkCNlStAGZGVQpx7sl7POMeF4RK
	 0KI7oe4MIJZRktHYrKioauhHZHUHpGzYfPBZLjSFxMfDwc8vxkBrqLffqXvZzq+yMv
	 29xWo4gTwmZYpvTUlPH2ujpdU+I74jbP+MKRW+m2zbr+92LlD1kG7Y8n9iRHR1mI4h
	 UbKYyQBeARoIQF8nW7oaH3tr2pDf6moA0Yyfo4Ya6y1MNnRDwqg3RQT6UWWp1Gy/e1
	 TmSHYwDY4gMyg==
Date: Tue, 17 Jun 2025 11:32:46 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dlan@gentoo.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
	drew@pdp7.com, emil.renner.berthing@canonical.com,
	inochiama@gmail.com, geert+renesas@glider.be, tglx@linutronix.de,
	hal.feng@starfivetech.com, joel@jms.id.au, duje.mihanovic@skole.hr,
	elder@riscstar.com, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH 4/8] dma: mmp_pdma: Add SpacemiT PDMA support with 64-bit
 addressing
Message-ID: <aFEFBss3RT7NbQkV@vaman>
References: <20250611125723.181711-1-guodong@riscstar.com>
 <20250611125723.181711-5-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611125723.181711-5-guodong@riscstar.com>

On 11-06-25, 20:57, Guodong Xu wrote:
> Extend the MMP PDMA driver to support SpacemiT PDMA controllers with
> 64-bit physical addressing capabilities, as used in the K1 SoC. This
> change introduces a flexible architecture that maintains compatibility
> with existing 32-bit Marvell platforms while adding 64-bit support.
> 
> Key changes:
> - Add struct mmp_pdma_config to abstract platform-specific behaviors
> - Implement 64-bit address support through:
>   * New high address registers (DDADRH, DSADRH, DTADRH)
>   * DCSR_LPAEEN bit for Long Physical Address Extension mode
>   * Helper functions for 32/64-bit address handling
> - Add "spacemit,pdma-1.0" compatible string with associated config
> - Extend descriptor structure to support 64-bit addresses
> - Refactor address handling code to be platform-agnostic
> - Add proper DMA mask configuration for both 32-bit and 64-bit modes
> 
> The implementation uses a configuration-based approach to keeps all
> platform-specific code isolated in config structures. It maintains clean
> separation between 32-bit and 64-bit code paths, provides consistent
> API for both addressing modes and preserves backward compatibility.

I would ask for this to be split, first to to driver changes for adding
new ops and then adding new soc support. This way the two changes are
independent

-- 
~Vinod

