Return-Path: <dmaengine+bounces-1212-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 251F286DF9D
	for <lists+dmaengine@lfdr.de>; Fri,  1 Mar 2024 11:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EF7CB2422F
	for <lists+dmaengine@lfdr.de>; Fri,  1 Mar 2024 10:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851396BB5F;
	Fri,  1 Mar 2024 10:52:06 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D056A8D4;
	Fri,  1 Mar 2024 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709290326; cv=none; b=evAOjclDME6G10848gI//+4xtLAr8QiTNXc2/I5+pvfHIVoLGY5CSuHn6E2sPGLnSaVKCuLTnD4p3VjBUHIzshhGwd/MREOkW85xCb2ZATpwFduObL7D1Xh72/T942UyQrssuyiu/BpBf+F/buR1xxOjiDRIjxLu8h63M8/xYvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709290326; c=relaxed/simple;
	bh=UqcMeXZ469xBJVROyP9fJAaPyhxAPb/yoEheBvUS+ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SldYf6Bvkzuk7V/bnXd7uM5pB6chONxtiP9h+Ag3EzO9umWhJ4PJwH71R5jpjwqpzO1lHZ+ZSQq+S2efKy7D2ryRIj5GRTSHREIOhd2TfuMkfZPBRspv6+FvNTTAfSE8Eyg5/ZC8V07eTpT5z/qic+aPb6IFD431z6YU51EpwqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rg0Ub-002Hbj-VP; Fri, 01 Mar 2024 18:51:55 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 01 Mar 2024 18:52:09 +0800
Date: Fri, 1 Mar 2024 18:52:09 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: davem@davemloft.net, rex.zhang@intel.com, andre.glover@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH 0/2] crypto: Intel Analytics Accelerator (IAA) bugfixes
Message-ID: <ZeGzWWKW2RdhW/Ta@gondor.apana.org.au>
References: <20240225201134.759335-1-tom.zanussi@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225201134.759335-1-tom.zanussi@linux.intel.com>

On Sun, Feb 25, 2024 at 02:11:32PM -0600, Tom Zanussi wrote:
> Hi Herbert,
> 
> Here are a couple of bugfixes for some minor problems discovered while
> testing.
> 
> Thanks,
> 
> Tom
> 
> Tom Zanussi (2):
>   crypto: iaa - Fix async_disable descriptor leak
>   crypto: iaa - Fix comp/decomp delay statistics
> 
>  drivers/crypto/intel/iaa/iaa_crypto_main.c  | 13 ++++++++--
>  drivers/crypto/intel/iaa/iaa_crypto_stats.c | 28 ---------------------
>  drivers/crypto/intel/iaa/iaa_crypto_stats.h |  8 +++---
>  3 files changed, 15 insertions(+), 34 deletions(-)
> 
> -- 
> 2.34.1

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

