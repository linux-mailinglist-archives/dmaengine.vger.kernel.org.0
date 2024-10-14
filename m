Return-Path: <dmaengine+bounces-3337-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2E899C38C
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2024 10:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0288F284A8D
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2024 08:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9782A14B965;
	Mon, 14 Oct 2024 08:38:30 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899DD14B086
	for <dmaengine@vger.kernel.org>; Mon, 14 Oct 2024 08:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895110; cv=none; b=Vlee5nJaEvRgEw3W0jbXlCo3DOeI/poOOwI1NtOMjNqTFRw3hoHTBxs4ShU1iS5NrhJJQT7OeqYqgRnlnuJMChTCBHp2N+Op7fqgXKj1tm2fXyDPZ+qrz/87rLI7X+cBEuMVc3qZaui7ACrcve7jZvVWTK5ZszsP2Xa5cjd6y4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895110; c=relaxed/simple;
	bh=/dUWEIi+InAp3Vp2QtogS30edtdBl+MDwOreGHW9KvY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Fg+IEkcr1YTbUF+Yg1w2RBn1NVc0FbR9UzvSeWoEt00dPCrmFJvJczLXbsfhxacNZB9U9DXkH0qjZITzZ8uNZu3VwpLzfOYB5Y2aIEa7iPFrUMat9wkwpbtzRAGmomTkIL5tBS+M8iTZfGGfcrRE8dS6N/4jk+F1Oz/sV5O4DQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:3f20:7967:2d40:9ad2])
	by albert.telenet-ops.be with cmsmtp
	id Q8eL2D00W54R7sz068eL3A; Mon, 14 Oct 2024 10:38:20 +0200
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1t0Gaq-003k6x-Jb;
	Mon, 14 Oct 2024 10:38:20 +0200
Date: Mon, 14 Oct 2024 10:38:20 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
cc: linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
    dmaengine@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.12-rc3
In-Reply-To: <20241014072731.3807160-1-geert@linux-m68k.org>
Message-ID: <711d7f6d-b785-7560-f4dc-c6aad2cce99@linux-m68k.org>
References: <CAHk-=wg061j_0+a0wen8E-wxSzKx_TGCkKw-r1tvsp5fLeT0pA@mail.gmail.com> <20241014072731.3807160-1-geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 14 Oct 2024, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.12-rc3[1] to v6.12-rc2[3], the summaries are:
>  - build errors: +3/-1

   + /kisskb/src/crypto/async_tx/async_tx.c: error: no previous prototype for '__async_tx_find_channel' [-Werror=missing-prototypes]:  => 43:1

powerpc-gcc{5,13}/ppc44x_allmodconfig

   + /kisskb/src/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t {aka long long unsigned int}' [-Werror=format=]:  => 126:37
   + /kisskb/src/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Werror=format=]:  => 126:46

powerpc-gcc{5,13}/ppc85xx_allmodconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8e929cb546ee42c9a61d24fae60605e9e3192354/ (all 194 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b/ (131 out of 194 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

