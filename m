Return-Path: <dmaengine+bounces-1685-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A7B894636
	for <lists+dmaengine@lfdr.de>; Mon,  1 Apr 2024 22:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88C961F22465
	for <lists+dmaengine@lfdr.de>; Mon,  1 Apr 2024 20:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04759524DF;
	Mon,  1 Apr 2024 20:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ORbPADi+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E3C50271;
	Mon,  1 Apr 2024 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712004386; cv=none; b=g+/RhOIap6e9L8gFyUwElUYGn0+1V+4FzbFmpDkAzsdbk6Mfv3I0wwABhcpw4BPzks7b2g6TojYS8xFrecDnyi3GtKeWqbeJigmXhHnlrwOLvai1X0xbJ7XwHiLHYuFW1C47WsZ2R9FuQCs9z+ZPns5YHzXCp9KmE4HtudojqKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712004386; c=relaxed/simple;
	bh=sN2OnWo1blaAHUPbQ3DGs+S1l5xEBgA9JyrPdsZmu3Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=piCzWQI/2slOmhEIuNaV72NkP+ZbXN29eJd6EdPebK8UcuAlX6cglS3LstyJWga/e5ffRR9n3+FMlYc0vZKWVUei1kCG7JlFMp/aCNCjNruOiaBc0/xqUA5M9EW3yydW55uVv/nwMgq1HbvdT4K9rSUZuEyUhha/1lYRVaZ7vbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ORbPADi+; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712004385; x=1743540385;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=sN2OnWo1blaAHUPbQ3DGs+S1l5xEBgA9JyrPdsZmu3Y=;
  b=ORbPADi+EKO2mby/HJpGPMUS8e3ylb68y9ILgjbuMTwWdb6+MRPC8WQQ
   DrP78fpZxfEqC8N6IHz/UYIkaCAIuHVYsFWpeTQusmcEt0TwUYhF9YFLv
   oBFhPeFXGy4/cRHhOkyGQ6DPDoc5uyKDHhWEiS0PiU3BKyh2ePgGq5xTK
   h9qTDugU9sfwpzah0l7FAI/rPh4GjhzDjAzJwP8KBn4+1CgtjB9B/7mxJ
   k2ewpVuBLxMPi5ain5gOrD69VjSEx0HL9p13Ka302Q5xJjhbYksBn2KeD
   StJg4wjpe3s3CuIYzxSlD248C9EmAYxnetoHXWpEFr57YdIa3o5L8gfC4
   A==;
X-CSE-ConnectionGUID: v//Yf4TRT9ips8F5xDPyhQ==
X-CSE-MsgGUID: jKAyL9vxRIKzBsqFFthhXA==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7012898"
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="7012898"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 13:46:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="17784626"
Received: from a4bf0157aa04.jf.intel.com ([10.54.34.37])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 13:46:24 -0700
Message-ID: <c88986d77451321bdeead216b3933c381b3b2b84.camel@linux.intel.com>
Subject: Re: [PATCH 0/4] crypto: Add new compression modes for zlib and IAA
From: Andre Glover <andre.glover@linux.intel.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: tom.zanussi@linux.intel.com, herbert@gondor.apana.org.au, 
 davem@davemloft.net, dave.jiang@intel.com, fenghua.yu@intel.com, 
 wajdi.k.feghali@intel.com, james.guilford@intel.com,
 vinodh.gopal@intel.com,  tony.luck@intel.com, linux-crypto@vger.kernel.org,
 dmaengine@vger.kernel.org
Date: Mon, 01 Apr 2024 13:46:23 -0700
In-Reply-To: <20240329024647.GA20263@sol.localdomain>
References: <cover.1710969449.git.andre.glover@linux.intel.com>
	 <20240329024647.GA20263@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Eric,

Thank you for reviewing the patch. Please see responses to your
questions inline below.

On Thu, 2024-03-28 at 19:46 -0700, Eric Biggers wrote:
> On Thu, Mar 28, 2024 at 10:44:41AM -0700, Andre Glover wrote:
> > The 'canned' compression mode implements a compression scheme that
> > uses a statically defined set of Huffman tables, but where the
> > Deflate
> > Block Header is implied rather than stored with the compressed
> > data.=20
>=20
> This already exists in standard DEFLATE; it's called fixed mode.=C2=A0 Se=
e
> section
> 3.2.6 of RFC1951
> (https://datatracker.ietf.org/doc/html/rfc1951#page-12).
>=20
> I think that what's going on is that you've implemented a custom
> variant of
> DEFLATE where you set the fixed Huffman codes to something different
> from the
> ones defined in the standard.
>=20
> Is that correct, or are there other differences?
>=20

We view it as a variant of dynamic block Deflate as opposed to a
variant of fixed. In particular, it is compressing the input with
static Huffman tables (i.e. ones that do not vary with the input), and
where the Deflate block header (which is a constant) is not stored with
the compressed data. If the missing block header were to be prepended
to the compressed data, the result would be a valid dynamic compressed
block.

One might think of this as vaguely similar to dictionary compression.
In that case, the dictionary is not stored with the compressed data but
is agreed to by the compressor and decompression. In the case of canned
compression, the header is not stored with the compressed data but is
agreed to by both entities.

> Actually, looking at your zlib_tr_flush_block(), it looks instead of
> using the
> reserved block type value (3) or redefining the meaning of the fixed
> block type
> value (1), you actually deleted the BTYPE and BFINAL fields from the
> data stream
> entirely.=C2=A0 So the stream no longer stores the type of block or the
> flag that
> indicates whether the block is the final one or not.
>=20
> That has the property that there cannot be any standard blocks, even
> uncompressed blocks, included in the data stream anymore.=C2=A0 Is that
> intentional?
>=20

Conceptually, there is a valid dynamic block header associated with the
compressed data, it is just not stored with the data in order to save
space (since it is effectively an unchanging constant). In this usage,
it is envisioned that the output would consist of a single Deflate
block (i.e. the implied header is marked as BFINAL). In theory, one
could have the implied block header not marked as BFINAL, and so the
compressed data would need to contain at least two blocks (i.e. the
body of the initial block, an EOB, and a normal block with header), but
this would be counterproductive to the intended usage.

> Maybe this is why you're using the name "canned", instead of going
> with
> something more consistent with the existing "fixed" name, like
> "custom-fixed"?
>=20

Again, we view this as a variant of dynamic compression rather than as
a variant of fixed compression. We use the term "static" to describe
compression with a dynamic block where the tables are unchanging (i.e.
not dependent on the input data) . This can allow the compression to be
done in one pass rather than two. The "canned" compression uses a
static table, but is different in that the header is implied rather
than stored.

> I wonder what the plan is for when the next hardware vendor tries to
> do this and
> chooses their own Huffman codes, different from yours.=C2=A0 Or what if
> Intel decides
> the Huffman codes they chose aren't the best ones anymore and
> releases new
> hardware that uses different codes.=C2=A0 Will we perhaps be getting a
> tinned mode
> too?
>=20

The Huffman tables are not built into the hardware. The Huffman
tables/block header is in this case built into the software. The same
tables are embedded in the zlib portion of the patch for software
compression/decompression and in the hardware driver portion of the
patch for IAA compression/decompression. The hardware itself can work
with any desired set of tables.

Thanks,
Andre


