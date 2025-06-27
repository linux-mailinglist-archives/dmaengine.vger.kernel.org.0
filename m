Return-Path: <dmaengine+bounces-5648-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0A6AEADB2
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 06:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED3A1BC7F36
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 04:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DFF433CB;
	Fri, 27 Jun 2025 04:05:15 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C5719F420
	for <dmaengine@vger.kernel.org>; Fri, 27 Jun 2025 04:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750997115; cv=none; b=hgHucziW0JCtl+px+EiI9moPnWxVX0bDBDlsZGzhdyWayc63g7AZiRr9jJMMllTq6sA+mAa0Ltpxjfe1Aj4+BLM31wTc2U0SDhRAQwV5o0yL/VOphA0gTxUbIh8q4gJ8u6SRtogec6Zd7tE/eVMeV5g1R1oOgsw7OjJBUW7RnoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750997115; c=relaxed/simple;
	bh=sXh5HbUv0Wx8zw1uzqs5pIySnVyMYm/ft9ALz9exwWw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVnk7TPb/LnJrzXlI/Zw8Fj3XQ3nkavKiRbHclvTjHdvuktLbG9U3f7lvZaP8N4N1hxvGp4jR2QFGUVql+Pz+FJFUR9mr22XAkDAZoedSkHVgr8WveBaYLZbC48TdfA0gCqHJn+Y4x1tOKHosKF/zpBCAcbEDZahbcyi9D07B4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id e9f85e0a-530b-11f0-a015-005056bd6ce9;
	Fri, 27 Jun 2025 07:05:08 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 27 Jun 2025 07:05:08 +0300
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yi Sun <yi.sun@intel.com>, gordon.jin@intel.com,
	yi.sun@linux.intel.com,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
Subject: Re: [PATCH v2] dmaengine: idxd: Remove __packed from structures
Message-ID: <aF4YdFZnAWcZlpbW@surfacebook.localdomain>
References: <20250404053614.3096769-1-yi.sun@intel.com>
 <175097809157.79884.15067500318866840512.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175097809157.79884.15067500318866840512.b4-ty@kernel.org>

Thu, Jun 26, 2025 at 03:48:11PM -0700, Vinod Koul kirjoitti:
> 
> On Fri, 04 Apr 2025 13:36:14 +0800, Yi Sun wrote:
> > The __packed attribute introduces potential unaligned memory accesses
> > and endianness portability issues. Instead of relying on compiler-specific
> > packing, it's much better to explicitly fill structure gaps using padding
> > fields, ensuring natural alignment.
> > 
> > Since all previously __packed structures already enforce proper alignment
> > through manual padding, the __packed qualifiers are unnecessary and can be
> > safely removed.

[...]

> Applied, thanks!

Please, don't or fix it ASAP. This patch is broken in the formal things,
i.e. changelog entry must not disrupt SoB chain. I'm not sure if Stephen's
scripts will catch this up on Linux Next integration, though.

-- 
With Best Regards,
Andy Shevchenko



