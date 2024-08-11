Return-Path: <dmaengine+bounces-2846-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 581F494E2DA
	for <lists+dmaengine@lfdr.de>; Sun, 11 Aug 2024 22:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AC4B1C20BA9
	for <lists+dmaengine@lfdr.de>; Sun, 11 Aug 2024 20:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D939158529;
	Sun, 11 Aug 2024 20:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="PrUz/95s"
X-Original-To: dmaengine@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7285B1F945;
	Sun, 11 Aug 2024 20:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723407129; cv=none; b=OBOaFC/iH36P9H1hruyoYkJ6drZ8fikbZSbWpkYEEICZ+KlzYU5hnRxGh3NtWkFQqDEwZoIVwRL/da6dUnj/zHDNFrAq1358c8qyI+PHiU8uJa6RFwbBef8DSXD7v/y1pDwg3K2avCFubO/LJMpy1OepI3Qpx/Ln/A6fLHmIBWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723407129; c=relaxed/simple;
	bh=NSWqP3Udnns/jrhPGY/EYd+/d8+QMBPbqEOC4nz/GC8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gpErbAN9T3hZAYdyEd31cf/n73kwcdbm1+MJMTOu4mBZxjyyZ/IRrivY9rL08B6p0iZfbEh9MAV0vJ3f7HRbGSXrZrR6GwLtXTQ27rP63ru1s6FYWeC+N3uJP6EZd5hTS2C1rqFozUV/oRDoJJ4QZu89Nd/WbN5kXJdAiTNS1X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=PrUz/95s; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 46E80418A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1723407120; bh=9Rm/lSrsRJ+DyBRDGWfjb0Jlly6yythN96aq7WE+WOE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PrUz/95sju0GqBBXkSIwIq8KblLp7jGXmkz+1xDO3ez2nb1EJw69K4lFKHKp6Ujbn
	 pEEGjlycg7cOOZOfBfPV0RkuaGj65mOdzSKDCQx7F50Tidfguo2NarxNkzlffgm29o
	 xcteuCJvxzXPc/sX8kJfLvTYloM0Se95fM6I2A7xkCsjsoTmIb/bam/07RxaLS4oNh
	 ZYiOMfTcQQKINwDXVhyFlgdwjcWLMU5pGFy2d5jrQdimzLd/ciWnrd59f30px1wdNd
	 Frf5RRHTp0obZKIRTKscK0H3GSf8B4EK0992REApc9DbFC28vGWlD/pSxZGxJHxcMM
	 XSaAOkrr5HaVQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 46E80418A0;
	Sun, 11 Aug 2024 20:12:00 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Ivan Orlov <ivan.orlov0322@gmail.com>, Amit Vadhavana
 <av2082000@gmail.com>, linux-doc@vger.kernel.org, ricardo@marliere.net
Cc: linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
 amelie.delaunay@foss.st.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, catalin.marinas@arm.com, will@kernel.org,
 mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 naveen@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 bhelgaas@google.com, conor.dooley@microchip.com, costa.shul@redhat.com,
 dmaengine@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, workflows@vger.kernel.org
Subject: Re: [PATCH] Documentation: Fix spelling mistakes
In-Reply-To: <13beb34b-3ff7-4b88-876f-0a7f65254970@gmail.com>
References: <20240810183238.34481-1-av2082000@gmail.com>
 <13beb34b-3ff7-4b88-876f-0a7f65254970@gmail.com>
Date: Sun, 11 Aug 2024 14:11:59 -0600
Message-ID: <87h6bqbz00.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ivan Orlov <ivan.orlov0322@gmail.com> writes:

> On 8/10/24 19:32, Amit Vadhavana wrote:
>> Corrected spelling mistakes in the documentation to improve readability.
>> 
>
> Hi Amit,
>
> Since this patch contains changes for multiple files from different 
> subsystems, it should be divided into file-specific changes (so you have 
> one patch per updated file).

Often that is the best thing to do but, honestly, in this case I think I
should just take the set through the docs tree.  I don't see much point
in making things harder.

Thanks,

jon

