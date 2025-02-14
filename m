Return-Path: <dmaengine+bounces-4475-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8114A36479
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 18:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D225189765B
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 17:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3C6267F79;
	Fri, 14 Feb 2025 17:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mfKtbrpw"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED3C2686A5;
	Fri, 14 Feb 2025 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553754; cv=none; b=D0zPrWtVtU19TcwLVyrGL7j3LBKu+mOZo83+f8QP70QhUCE4aLDY/A9xMfgI4OFQYC5hzG19tIDLUBoOah+haiQBWq8/lD+whFLeqsPtjyZkRGaiD2uY50puNARKA5/fcQB2a6NWxWHwVOFlISenqghcECtEiGtlP9H+kP0Lf28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553754; c=relaxed/simple;
	bh=DPQdmghsK7jEQ7jsF+P1vpaIBGgBftXHy4VvMzKvPpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=elLIZA7FqCGBpV/R+tHRMBRgDaBBIC0qyN9QxhedmjQVFlPWS3uiyBxvNMdvjhx2yAx+K8ORMix0wqIb1mStnPIpHLTupnR52o/Pkg6Ea6neuIEXsW0bGvzfLuEAirzVtzBZPoXkQYlwGL7thEE2f/MfvYEjNTzYjDP+Ij9qssY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mfKtbrpw; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739553753; x=1771089753;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DPQdmghsK7jEQ7jsF+P1vpaIBGgBftXHy4VvMzKvPpQ=;
  b=mfKtbrpw6mrkhIu4HpDSma8J2fo4r+zUqXh6UsJUhvPd/aOYs3Gl/nLV
   T84X7ezmkGuiDpzgfY62w1lRgc2u8U8eIDS+jqmMxMbnKmvusMG02KYls
   INhC+DX22kR4XZH40mIKb1hr8MIoi+hH3lGCVeHqpG/oek64a1cWmSmXS
   k126xHNLEpYyXnKLOR7YUg/RmOBhPX/LqujN71BmHU7YaEZ5cs/f4poys
   QteRd75Koh7sPOZkK3JTf2sdQFOa03tiF7XAb/048gQ4S3N93eg0gfOt1
   temm15JHlKxujU04xg2r6cfFfOxLWsbXoT7IGA79OClGFQyy7CGQwDumX
   Q==;
X-CSE-ConnectionGUID: lsvpmlSyRTmIqzrZGytYIA==
X-CSE-MsgGUID: wyW/InxiTfS5F7sLJnjRlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40181572"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40181572"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 09:22:32 -0800
X-CSE-ConnectionGUID: c/VwesapRja7LYYHnQz68Q==
X-CSE-MsgGUID: SeOk57vJQSiMVzrLWl5jpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="113487381"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.125.109.34]) ([10.125.109.34])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 09:22:31 -0800
Message-ID: <3bcf7b21-d894-4aa1-ba00-d32a32a72b2d@intel.com>
Date: Fri, 14 Feb 2025 10:22:30 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] dmaengine: idxd: fix memory leak in error handling
 path
To: Markus Elfring <Markus.Elfring@web.de>,
 Shuai Xue <xueshuai@linux.alibaba.com>, dmaengine@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>
References: <20250110082237.21135-1-xueshuai@linux.alibaba.com>
 <61c9c416-711c-44dc-87af-b1aefc76b87e@web.de>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <61c9c416-711c-44dc-87af-b1aefc76b87e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/14/25 10:15 AM, Markus Elfring wrote:
> …
>>  drivers/dma/idxd/init.c | 62 ++++++++++++++++++++++++++++++++---------
> …
> 
> How do you think about to add any tags (like “Fixes” and “Cc”)
> for the presented patches accordingly?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.14-rc2#n145

I actually thought about asking for that. But I believe the fixes are against code that just went in for 6.14 so backporting won't be necessary. 

> 
> Regards,
> Markus


