Return-Path: <dmaengine+bounces-1979-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E82EF8B9188
	for <lists+dmaengine@lfdr.de>; Thu,  2 May 2024 00:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731081F22CD9
	for <lists+dmaengine@lfdr.de>; Wed,  1 May 2024 22:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBC4165FBF;
	Wed,  1 May 2024 22:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FKmbj/hU"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296D3165FAA;
	Wed,  1 May 2024 22:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714601252; cv=none; b=c17cf7rjr8LP13cCMixygBoOPMAlUV6psWl9DNGqvIlGhmR6xPoHjW22OI2dhcQRfpx2Ewsnm63li170TLZ+trBYEEXmi7MH0+Gg5KioYq/8/FkesxgOp286kdH4OyYHqvnkTH2T0MBdlFjAZerVq7ZV4fUls+s9EevxDPbFHVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714601252; c=relaxed/simple;
	bh=dzMMcZXpNSmLkhfRYOw0UtbzZ2n+xiKCO8/PWDvxKsQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p2eKEs8B+yz7tqfYv0ODQieH47lP1CXUNszgOpVwFXjSGaepMoEXZKZ+fqE5YU9d8IMHRP3qe5OCjOKYUrBdJ79tJWpLq7zWi08SuJPh1mvuuaV7nGo9Cl7vqL62NIuCIE/idF9Yh6e+uiWYCWuH37rIfd3gIM9ac1wCxugCVdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FKmbj/hU; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714601251; x=1746137251;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=dzMMcZXpNSmLkhfRYOw0UtbzZ2n+xiKCO8/PWDvxKsQ=;
  b=FKmbj/hUTQM3vK45sk0vpLJxMD0YcoNB+KFXcyQ9zQmbsUtWWhPrF9HO
   7FLFcthalMDLhW9Z4XtpzRyANHgf0No4EjX5z2EZtlBr5wBsKw105HMYP
   WjZlJrHuWmHMb3MKmIjeutXXqEZRmWkn8U9K2M+jBwD8er4a5ofJkTkPP
   /GzyxBXDmVK1Rv/yM38g+wR08jxAKRpsc8qoHkXaDox+wMlex/J0cDls5
   OT/qM82ORbtdSyBNCeTGhONxL4X7L1IUlizb33kUpN50vi7b+JfQ7rBAT
   s3wVH6wiy23fZ1Tvb3MEkyHr4LZretj37rGESRwoh4biDh0iBRXY96j6L
   g==;
X-CSE-ConnectionGUID: wiNcyBVMTOadjq5vhHS98A==
X-CSE-MsgGUID: vo+B/DwYTDSS34q56zZKzg==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="20971039"
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="20971039"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 15:07:30 -0700
X-CSE-ConnectionGUID: vfdw8mxDS9GzrQTp/MWkMA==
X-CSE-MsgGUID: JNafHgGuTAad5P9cUyU2bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="31393980"
Received: from sdp.jf.intel.com ([10.165.56.45])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 15:07:30 -0700
Message-ID: <8c687681e566ce6c11d3e71e728d12ac2ef08b07.camel@linux.intel.com>
Subject: Re: [PATCH 0/4] crypto: Add new compression modes for zlib and IAA
From: Andre Glover <andre.glover@linux.intel.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: tom.zanussi@linux.intel.com, davem@davemloft.net, dave.jiang@intel.com, 
	fenghua.yu@intel.com, wajdi.k.feghali@intel.com, james.guilford@intel.com, 
	vinodh.gopal@intel.com, tony.luck@intel.com, linux-crypto@vger.kernel.org, 
	dmaengine@vger.kernel.org
Date: Wed, 01 May 2024 15:07:15 -0700
In-Reply-To: <Zg+jMc/shIgX11lP@gondor.apana.org.au>
References: <cover.1710969449.git.andre.glover@linux.intel.com>
	 <Zg+jMc/shIgX11lP@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Herbert,

On Fri, 2024-04-05 at 15:07 +0800, Herbert Xu wrote:
> On Thu, Mar 28, 2024 at 10:44:41AM -0700, Andre Glover wrote:
> >=20
> > Below is a table showing the latency improvements with zlib,
> > between
> > zlib dynamic and zlib canned modes, and the compression ratio for=20
> > each mode while using a set of 4300 4KB pages sampled from SPEC=20
> > CPU17 workloads:
> > _________________________________________________________
> > > Zlib Level |=C2=A0 Canned Latency Gain=C2=A0 |=C2=A0=C2=A0=C2=A0 Comp=
 Ratio=C2=A0=C2=A0=C2=A0 |
> > > ------------|-----------------------|------------------|
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | compre=
ss | decompress | dynamic | canned |
> > > ____________|__________|____________|_________|________|
> > > =C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0 49%=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 29%=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 3.16=C2=A0=C2=A0 |=C2=A0 2.92=C2=A0 |
> > > ------------|----------|------------|---------|--------|
> > > =C2=A0=C2=A0=C2=A0 6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0 27%=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 28%=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 3.35=C2=A0=C2=A0 |=C2=A0 3.09=C2=A0 |
> > > ------------|----------|------------|---------|--------|
> > > =C2=A0=C2=A0=C2=A0 9=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0 12%=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 29%=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 3.36=C2=A0=C2=A0 |=C2=A0 3.11=C2=A0 |
> > > ____________|__________|____________|_________|________|
>=20
> So which kernel user (zswap I presume) is clamouring for this
> feature? We don't add new algorithms that have no in-kernel
> users.=C2=A0 So we need to be sure that the kernel user actually
> want this.
>=20
> Thanks,

Hi Herbert,
We have recently submitted an RFC to zswap and zram maintainers and
users for by_n compression with Intel IAA [1] feedback. This work is in
support of efforts to swap in/out large and multi-sized folios. With
by_n compression, we have created a scheme that allows parallel IAA
compression and decompression operations on a single folio resulting in
performance gains. Currently the by_n scheme uses the canned mode
compression algorithm to perform the compression and decompression
operations. Using canned mode compression results in reduced
compression latency because the deflate header doesnt need to be
created dynamically, while also producing better ratio than Deflate
Fixed mode. We would appreciate your feedback on this scheme.

Here is data from the RFC showing a performance comparison for 64KB
folio swap in/out=20
with zram on Sapphire Rapids, whose core frequency is fixed at 2500MHz:
+------------+-------------+---------+-------------+----------+-------+
|            | Compression | Decomp  | Compression | zram     | zram  |
| Algorithm  | latency     | latency | ratio       | write    | read  |
+------------+-------------+---------+-------------+----------+-------+
|            |       Median (ns)     |             |      Median (ns) |
+------------+-------------+---------+-------------+----------+-------+
|            |             |         |             |          |       |
| IAA by_1   | 34,493      | 20,038  | 2.93        | 40,130   | 24,478|
| IAA by_2   | 18,830      | 11,888  | 2.93        | 24,149   | 15,536|
| IAA by_4   | 11,364      |  8,146  | 2.90        | 16,735   | 11,469|
| IAA by_8   |  8,344      |  6,342  | 2.77        | 13,527   |  9,177|
| IAA by_16  |  8,837      |  6,549  | 2.33        | 15,309   |  9,547|
| IAA by_32  | 11,153      |  9,641  | 2.19        | 16,457   | 14,086|
| IAA by_64  | 18,272      | 16,696  | 1.96        | 24,294   | 20,048|
|            |             |         |             |          |       |
| lz4        | 139,190     | 33,687  | 2.40        | 144,940  | 37,312|
|            |             |         |             |          |       |
| lzo-rle    | 138,235     | 61,055  | 2.52        | 143,666  | 64,321|
|            |             |         |             |          |       |
| zstd       | 251,820     | 90,878  | 3.40        | 256,384  | 94,328|
+------------+-------------+---------+-------------+----------+-------+

[1]https://lore.kernel.org/all/cover.1714581792.git.andre.glover@linux.
intel.com/


