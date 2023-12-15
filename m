Return-Path: <dmaengine+bounces-543-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF87E814DA6
	for <lists+dmaengine@lfdr.de>; Fri, 15 Dec 2023 17:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 285321C2119C
	for <lists+dmaengine@lfdr.de>; Fri, 15 Dec 2023 16:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3813EA6B;
	Fri, 15 Dec 2023 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U+TR9UVY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DD23EA69;
	Fri, 15 Dec 2023 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702659319; x=1734195319;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RoQz5Hj3AlwnPNUQqmm0YVyXpkRm7JA23dpjOTRWF2o=;
  b=U+TR9UVYD8nm/zUSFD/Bje9kvwpxBFBhMD/T2aBlMJe56SL+/flFqUD0
   tTTIHJf8AhTTxyHmcsL2hS2PDkzP3kzKTVmTAqSSH39EpveAOzLEH9IhI
   zS99okglr2g5qVJNdntCacIJTZYDDJMT9gZbIP+5d4yH3NuYAwOovTVXl
   M2nUrSNkLrz7aFwc1AATm9Qb5r+7vanJzrRNyT/Ufl8KsX9AXDTGedqDW
   56y/cRsmI92UbK2wqrzwXAPzxHu/Yz0VxTJyZPxQFLzutORR70nlXOImb
   N80O1siJZSaqAsxoM7RpCCRcZG6f9oEu2paqpf79WrrzfnVA0N8PDzbF3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="398091302"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="398091302"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 08:55:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="948027381"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="948027381"
Received: from gyuchull-mobl2.amr.corp.intel.com ([10.212.27.50])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 08:55:16 -0800
Message-ID: <204ec32b24062a29baf2cb0e9c1c4bba097833d5.camel@linux.intel.com>
Subject: Re: [PATCH v12 00/14] crypto: Add Intel Analytics Accelerator (IAA)
 crypto compression driver
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: davem@davemloft.net, fenghua.yu@intel.com, vkoul@kernel.org, 
 dave.jiang@intel.com, tony.luck@intel.com, wajdi.k.feghali@intel.com, 
 james.guilford@intel.com, kanchana.p.sridhar@intel.com,
 vinodh.gopal@intel.com,  giovanni.cabiddu@intel.com, pavel@ucw.cz,
 linux-kernel@vger.kernel.org,  linux-crypto@vger.kernel.org,
 dmaengine@vger.kernel.org
Date: Fri, 15 Dec 2023 10:55:15 -0600
In-Reply-To: <ZXwi+UN0OP9+ht99@gondor.apana.org.au>
References: <20231205212530.285671-1-tom.zanussi@linux.intel.com>
	 <ZXwi+UN0OP9+ht99@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-15 at 17:57 +0800, Herbert Xu wrote:
> On Tue, Dec 05, 2023 at 03:25:16PM -0600, Tom Zanussi wrote:
> > Hi, this is v12 of the IAA crypto driver, incorporating feedback

[snip]

> All applied.=C2=A0 Thanks.

Thanks, Herbert!

Tom


