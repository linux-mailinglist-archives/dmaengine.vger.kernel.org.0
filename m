Return-Path: <dmaengine+bounces-673-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAE681FCD6
	for <lists+dmaengine@lfdr.de>; Fri, 29 Dec 2023 04:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3387B285A75
	for <lists+dmaengine@lfdr.de>; Fri, 29 Dec 2023 03:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0378488;
	Fri, 29 Dec 2023 03:31:00 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F918467;
	Fri, 29 Dec 2023 03:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rJ3aD-00FGCm-U3; Fri, 29 Dec 2023 11:30:50 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 29 Dec 2023 11:31:00 +0800
Date: Fri, 29 Dec 2023 11:31:00 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: davem@davemloft.net, fenghua.yu@intel.com, rex.zhang@intel.com,
	dave.jiang@intel.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH] crypto: iaa - Account for cpu-less numa nodes
Message-ID: <ZY49dBFUNwOyK/ED@gondor.apana.org.au>
References: <00e3eea06f5dde61734a53af797b190692060aab.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00e3eea06f5dde61734a53af797b190692060aab.camel@linux.intel.com>

On Tue, Dec 26, 2023 at 02:53:26PM -0600, Tom Zanussi wrote:
> In some configurations e.g. systems with CXL, a numa node can have 0
> cpus and cpumask_nth() will return a cpu value that doesn't exist,
> which will result in an attempt to add an entry to the wq table at a
> bad index.
> 
> To fix this, when iterating the cpus for a node, skip any node that
> doesn't have cpus.
> 
> Also, as a precaution, add a warning and bail if cpumask_nth() returns
> a nonexistent cpu.
> 
> Reported-by: Zhang, Rex <rex.zhang@intel.com>
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  drivers/crypto/intel/iaa/iaa_crypto_main.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

