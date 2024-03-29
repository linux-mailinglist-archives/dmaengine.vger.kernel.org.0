Return-Path: <dmaengine+bounces-1649-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022078911C0
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 03:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81227B22509
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 02:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFDC32C88;
	Fri, 29 Mar 2024 02:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vu08IIB1"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A911946F;
	Fri, 29 Mar 2024 02:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711680410; cv=none; b=YJQzL2Pp63LNFxqd2F62h/sMakzJIej2NeNrsCF6LwSrp99wiHFRIg0Jaj+8YS3iaXcI9tAeA9RcCWG36Efug+bQozjH/3M0NCKAgNb5XHDoywhTODMFgoBmvg0n3UfjLngNnapSiW8Xhz1vfXYEeIMnNIvNUsjdBLrnnnj5J0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711680410; c=relaxed/simple;
	bh=VYWzIkb5ccN/HVEU/KawfKWrlsv1UWoHi5Ddv2Y4THw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ka+9SUKEUkdSevSNTZ1+bEE06oHIKOXMTXCbKUJZC/tvvKMXbmltUklTtACE/8yvBpU81bNtWa3VCPC/a7Bma1BB6p+/bGy1v7e2P0QckL9pRM3J1hibsLWKDqjeqUa9C/1Q1mhnacacu7slM2si733GPtXhe2zWZvBiTs6cBGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vu08IIB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9364AC433C7;
	Fri, 29 Mar 2024 02:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711680409;
	bh=VYWzIkb5ccN/HVEU/KawfKWrlsv1UWoHi5Ddv2Y4THw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vu08IIB1appIVitbAvoiBg68A5hWj4QkyNdnTv5j4qGdzFr/I1/r5F8zt6pzVSkkL
	 lHBNKyjKY1xMRpSZxOVJ6T8JBF3Z8YXiQwqJHYFtlRfT4xBOHY2MlElkZtW3fGll6m
	 Nf5mygZz1LwVQN6z1693gOnLz9wQUXtEYWJtxjkZTr15R0x+aBZafhbgltNjXjJ1Oc
	 kW9NbrVbhrwXYJjQPnDVE7SkJgtfa03Xv7PAE+J5mhga3Pbf4mAkAgtebFyYgM33K2
	 zz9WzeiIlnO7ZNrQFN0hcJC5K6IgNlYBPa5s5XbD3+DPTBxmpcX21EumBd8+ieLlMz
	 kpYV/XCVVPtYg==
Date: Thu, 28 Mar 2024 19:46:47 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Andre Glover <andre.glover@linux.intel.com>
Cc: tom.zanussi@linux.intel.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, dave.jiang@intel.com, fenghua.yu@intel.com,
	wajdi.k.feghali@intel.com, james.guilford@intel.com,
	vinodh.gopal@intel.com, tony.luck@intel.com,
	linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 0/4] crypto: Add new compression modes for zlib and IAA
Message-ID: <20240329024647.GA20263@sol.localdomain>
References: <cover.1710969449.git.andre.glover@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710969449.git.andre.glover@linux.intel.com>

On Thu, Mar 28, 2024 at 10:44:41AM -0700, Andre Glover wrote:
> The 'canned' compression mode implements a compression scheme that
> uses a statically defined set of Huffman tables, but where the Deflate
> Block Header is implied rather than stored with the compressed data. 

This already exists in standard DEFLATE; it's called fixed mode.  See section
3.2.6 of RFC1951 (https://datatracker.ietf.org/doc/html/rfc1951#page-12).

I think that what's going on is that you've implemented a custom variant of
DEFLATE where you set the fixed Huffman codes to something different from the
ones defined in the standard.

Is that correct, or are there other differences?

Actually, looking at your zlib_tr_flush_block(), it looks instead of using the
reserved block type value (3) or redefining the meaning of the fixed block type
value (1), you actually deleted the BTYPE and BFINAL fields from the data stream
entirely.  So the stream no longer stores the type of block or the flag that
indicates whether the block is the final one or not.

That has the property that there cannot be any standard blocks, even
uncompressed blocks, included in the data stream anymore.  Is that intentional?

Maybe this is why you're using the name "canned", instead of going with
something more consistent with the existing "fixed" name, like "custom-fixed"?

I wonder what the plan is for when the next hardware vendor tries to do this and
chooses their own Huffman codes, different from yours.  Or what if Intel decides
the Huffman codes they chose aren't the best ones anymore and releases new
hardware that uses different codes.  Will we perhaps be getting a tinned mode
too?

Is your customization described in any sort of publicly available document that
could hint at some way to name it properly?

- Eric

