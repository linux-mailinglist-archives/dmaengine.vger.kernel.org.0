Return-Path: <dmaengine+bounces-4244-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1611DA24236
	for <lists+dmaengine@lfdr.de>; Fri, 31 Jan 2025 18:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CD45167E2A
	for <lists+dmaengine@lfdr.de>; Fri, 31 Jan 2025 17:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EE01EEA44;
	Fri, 31 Jan 2025 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GX59X3JF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0031F18E25;
	Fri, 31 Jan 2025 17:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738345619; cv=none; b=SE7eQEtqDtNoBEaGI0O3xI9kLgURmyzUucNbekh+mvGRgC+Yj1IzouL7P5hd3LrR26m2biKsdDRHiwINqeHTumpFDZMEmxI7hJ453T9OT+SXhd4sIPCaZ+U2E8HD4AB5IIRVqTjCnq/br1rOcWk16Er8/GvjTyfqJzyXVwNFXYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738345619; c=relaxed/simple;
	bh=akk78lekrk7s2ZeViZ6kG8Tq1BDpRyufbOmNEHkma2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fkX+GThol1F3nGspNw4v5btGIN5ApSEpEkzFFH/CXv8afAyZxK6hrKe1nVUdv1sn9hm8k2qgbTqoo+j5UZQvu+I2dLG+8wsgnyhXrW3A/7R5loWXHXcJVVek4SPN3EbonocZ78Wm7NHGwddyf4rhLkH2gfZ7k3z70Ff1XkoYKwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GX59X3JF; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738345617; x=1769881617;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=akk78lekrk7s2ZeViZ6kG8Tq1BDpRyufbOmNEHkma2I=;
  b=GX59X3JFk6CZRPE9oy7IWj4he6VJSFv0txunqFprCVBXm2P3C0lFBDP/
   z6OcIGHn8u0ScH9iWrIKtqULPfiH04dOi49JhWjwpiCxM4qfM5M70e3Nd
   yCJBS+syQvEMWJsa/xpANXkTWvl3FqTPZcix1xXRX4mx/So7R4mU/EZBP
   OHUalfXSumy1y84YzaRChqQbzjrV02We4UUR2qioUIZlxBcXSwSVkIjGC
   SQzEIGKrSWzpsMo7tjcJXntK+a/oV47NLRWeQWwSTIy1jOCqI9uR6A5Rn
   AaGvSEX97UvjU4WFquMMSWQ8lULPcZ2EfexSngOmvBHh3KFWeQm1j4pYC
   Q==;
X-CSE-ConnectionGUID: 2Exl/7dwTYy97h4YZd/nvg==
X-CSE-MsgGUID: Rpgk27bjSQyUmCza9MyVHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11332"; a="38810015"
X-IronPort-AV: E=Sophos;i="6.13,249,1732608000"; 
   d="scan'208";a="38810015"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 09:46:56 -0800
X-CSE-ConnectionGUID: QcJoQNLPQdy6o4GHhHrurg==
X-CSE-MsgGUID: XPdAq+XQTYCKMh4AZeNqug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114836811"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.109.72]) ([10.125.109.72])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 09:46:55 -0800
Message-ID: <66ff0040-1495-4ac6-a0bc-754f39690aac@intel.com>
Date: Fri, 31 Jan 2025 10:46:55 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Change maintainer for IDXD
To: Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
References: <20250131173551.3979408-1-fenghua.yu@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250131173551.3979408-1-fenghua.yu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/31/25 10:35 AM, Fenghua Yu wrote:
> Due to job transition, I am stepping down as IDXD maintainer.
> Vinicius will take over maintainership responsibilities moving forward.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d1086e53a317..08ce00b6c1f3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11677,7 +11677,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git
>  F:	drivers/idle/intel_idle.c
>  
>  INTEL IDXD DRIVER
> -M:	Fenghua Yu <fenghua.yu@intel.com>
> +M:	Vinicius Costa Gomes <vinicius.gomes@intel.com>
>  R:	Dave Jiang <dave.jiang@intel.com>
>  L:	dmaengine@vger.kernel.org
>  S:	Supported


