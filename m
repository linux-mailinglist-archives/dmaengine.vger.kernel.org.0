Return-Path: <dmaengine+bounces-3228-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C264C9888AC
	for <lists+dmaengine@lfdr.de>; Fri, 27 Sep 2024 18:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B831F23383
	for <lists+dmaengine@lfdr.de>; Fri, 27 Sep 2024 16:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EE51487F1;
	Fri, 27 Sep 2024 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lDm6s4gI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AED0200A3;
	Fri, 27 Sep 2024 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727453013; cv=none; b=MrrXRxXvge4FZX/6V/gMtdkflTbVltOSoutChF3PFNYTSPcn8pc1zYY2y5vCBvt9NrA8s/kzkdhlh/1NiXv/AXFQP+AqVDN6Ohb1EmEdPSYX6MtYXvS9In+fFEPxGL6FUo5oSQ4g6qMpUtcN8g7E9vDTO1zDVFoVgN8FAaZYOfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727453013; c=relaxed/simple;
	bh=eMlisuPU8aSOMFD/1F9ex1awVaAko4nscyew5rE08e0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=hCWzJQVUJrYvckMBhJGM8Jai6ApBbJ4WbrmyW5aKYCQWFdtkzGWIC97WT62KdDpmTEJi/HDwl7EQtvtnjZ/+H8hRTFZ67qsjMDfAtebuVnbZIqHVO/nsJ6XfhFl5t/jcg/I5zxHh/XzW4kDJ4mqqYbIn1THAxDUofHXR3VeVnbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lDm6s4gI; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727453013; x=1758989013;
  h=from:to:cc:references:in-reply-to:subject:date:
   message-id:mime-version:content-transfer-encoding;
  bh=eMlisuPU8aSOMFD/1F9ex1awVaAko4nscyew5rE08e0=;
  b=lDm6s4gIbOO88J7/9+3Yp5y2ZS+hcmAfRvbfrGwRY1emBnGvf34itdF4
   tUc/Pa8PBr+9azoPyD+7sw6XSiSNYzpDmYxMlMBI1edIBcIDr/31d9WQq
   PJOoUlQJv/tUjDRwTVovmv6gvglBMwkXVp4IQxoRxNxAjr9oWVpQLoqsj
   L04oqPRZYsz1rGAuAvdm1TFDVvteVFF4/NoBIfxkPYnmpm0VAGJyDL/fR
   qQjwoHKzEwIldJ+73dSBMT7+dWBpJ6OtcNgCBCuD5FZ3lh/qBjSAD9VLJ
   USB6Pn2u+buvGRLZPW2yjE19ohbtYXjeDQdoB3Au0t+nkAXQDSEiqLHTo
   A==;
X-CSE-ConnectionGUID: 9s6ZIaDlSKuz1zlPaVMYlQ==
X-CSE-MsgGUID: Smb4eAr0SfayX9z5wL2tnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11208"; a="49129852"
X-IronPort-AV: E=Sophos;i="6.11,159,1725346800"; 
   d="scan'208";a="49129852"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 09:03:32 -0700
X-CSE-ConnectionGUID: WYjpbBapSlSP2KIipdKD+A==
X-CSE-MsgGUID: D9tt5ylpQWCX5Qd1hHyaOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,159,1725346800"; 
   d="scan'208";a="73004773"
Received: from bseshasa-mobl.amr.corp.intel.com (HELO bseshasaMOBL) ([10.246.171.145])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 09:03:28 -0700
From: <bala.seshasayee@linux.intel.com>
To: "'Barry Song'" <21cnbao@gmail.com>
Cc: <tom.zanussi@linux.intel.com>,
	<minchan@kernel.org>,
	<senozhatsky@chromium.org>,
	<hannes@cmpxchg.org>,
	<yosryahmed@google.com>,
	<nphamcs@gmail.com>,
	<chengming.zhou@linux.dev>,
	<herbert@gondor.apana.org.au>,
	<davem@davemloft.net>,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	"Jiang, Dave" <dave.jiang@intel.com>,
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Guilford, James" <james.guilford@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Caldwell, Heath" <heath.caldwell@intel.com>,
	"Sridhar, Kanchana P" <Kanchana.P.Sridhar@intel.com>,
	<linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>,
	<ryan.roberts@arm.com>,
	<linux-crypto@vger.kernel.org>,
	<dmaengine@vger.kernel.org>
References: <cover.1714581792.git.andre.glover@linux.intel.com> <8fe04e86f0907588d210885ac91965960f97f450.1714581792.git.andre.glover@linux.intel.com> <CAGsJ_4xREUbRWRZEO8EiEBdP9YN0Wip4_p58Cca=B4ZdPb7Mpg@mail.gmail.com>
In-Reply-To: <CAGsJ_4xREUbRWRZEO8EiEBdP9YN0Wip4_p58Cca=B4ZdPb7Mpg@mail.gmail.com>
Subject: RE: [RFC PATCH 2/3] crypto: add by_n attribute to acomp_req
Date: Fri, 27 Sep 2024 09:03:27 -0700
Message-ID: <000001db10f6$cb3ca4b0$61b5ee10$@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHanBEURTUo4d1RW0OV8cvHU+0CnrJax8IAgBHsYLA=
Content-Language: en-us



> -----Original Message-----
> From: Barry Song <21cnbao@gmail.com>
> Sent: Sunday, September 15, 2024 11:16 PM
> To: Andre Glover <andre.glover@linux.intel.com>
> Cc: tom.zanussi@linux.intel.com; minchan@kernel.org;
> senozhatsky@chromium.org; hannes@cmpxchg.org; yosryahmed@google.com;
> nphamcs@gmail.com; chengming.zhou@linux.dev;
> herbert@gondor.apana.org.au; davem@davemloft.net; Yu, Fenghua
> <fenghua.yu@intel.com>; Jiang, Dave <dave.jiang@intel.com>; Feghali, =
Wajdi K
> <wajdi.k.feghali@intel.com>; Guilford, James =
<james.guilford@intel.com>; Gopal,
> Vinodh <vinodh.gopal@intel.com>; Seshasayee, Bala
> <bala.seshasayee@intel.com>; Caldwell, Heath =
<heath.caldwell@intel.com>;
> Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>; linux-
> kernel@vger.kernel.org; linux-mm@kvack.org; ryan.roberts@arm.com; =
linux-
> crypto@vger.kernel.org; dmaengine@vger.kernel.org
> Subject: Re: [RFC PATCH 2/3] crypto: add by_n attribute to acomp_req
>=20
> On Thu, May 2, 2024 at 5:46=E2=80=AFAM Andre Glover =
<andre.glover@linux.intel.com>
> wrote:
> >
> > Add the 'by_n' attribute to the acomp_req. The 'by_n' attribute can =
be
> > used a directive by acomp crypto algorithms for splitting compress =
and
> > decompress operations into "n" separate jobs.
>=20
> Hi Andre,
>=20
> I am definitely in favor of the patchset idea. However, I'm not =
convinced that a
> separate by_n API is necessary. Couldn=E2=80=99t this functionality be =
handled
> automatically within your driver? For instance, if a large folio is =
detected, could it
> automatically apply the by_n concept?
>=20
> Am I overlooking something that makes exposing the API necessary in =
this case?

Hi Barry,

The 'deflate-iaa-canned' compression algorithm is fully compatible with =
the deflate standard. Andre's patchset introduces 'canned-by_n' as a new =
compression algorithm, which is not a deflate stream since it has a =
different header (for the by_n chunks).
The same 'canned-by_n' algorithm along with the value of the acomp_req =
=E2=80=98by_n=E2=80=99 attribute would be used to compress and =
decompress a given input buffer.
Furthermore, with a tunable 'by_n' , the user can experiment with =
different values of by_n for different mTHP sizes to understand =
trade-offs in performance vs. compression ratio.

Thanks
Bala


