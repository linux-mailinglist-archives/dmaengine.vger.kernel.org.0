Return-Path: <dmaengine+bounces-10197-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKkNMTZ08mkHrgEAu9opvQ
	(envelope-from <dmaengine+bounces-10197-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 29 Apr 2026 23:12:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A6049A769
	for <lists+dmaengine@lfdr.de>; Wed, 29 Apr 2026 23:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD22F300D84F
	for <lists+dmaengine@lfdr.de>; Wed, 29 Apr 2026 21:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2EB377006;
	Wed, 29 Apr 2026 21:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RtvNTKM5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE204964F;
	Wed, 29 Apr 2026 21:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777497054; cv=none; b=iqrLn6Xif8Af9e4pz76ec+Hzg8HDb4fslMVBG2Nn8YMHXoznOgFjoMq6738nvsiXdQt/ghgv0pLO4EJtlM+EjbxoKt3poeGBn6Wh36GBbHAb3D1nV4gH3GWm2UQ1jiReX4raSORZ1TMTTeaUoTlbfpEg52FfFIBMHUWZYYa6cZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777497054; c=relaxed/simple;
	bh=bjJjP44Vdub/JDSArIcAt79NnL4gMxt4Patnw0OhOlU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UnbA4KTsL2EuWl6BjtmLzxMMBh1ZqE0V3EJHpRL+H6/Ar7ENhdhdwjpbxWyRLaEh+O4Mo67lKB/HAxGhj38Mo3UXFV1wk6guAOc27o/ZeQUzAkCJ+Ja0FIRV0WNPDsjukPF7hBAFoRT7XQonuRPVzIUt7AXLQxw6umnuQ077R+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RtvNTKM5; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777497053; x=1809033053;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=bjJjP44Vdub/JDSArIcAt79NnL4gMxt4Patnw0OhOlU=;
  b=RtvNTKM53EvrC6dJQAFJ874scpjzCmtEMTl+RcTs7V/VG18STQP9mJ0W
   3pox49dI3SgC9ZDgBThV5mFhLko5mmKelLVDO49wGX+LbFa0vsxaHjeyk
   FvR9rbDFRWXteErx6L1eUritw6H6pQjiR038ELUNBQeLMvCty2xIMWwMD
   /6h5lNXCPckyRqMG5Xsm2F6scdgJaPkLyo9WyTYdrxGNhM1NxK3Am1Ht1
   Mi38fOdT4wZqBdhEKOInwzex9WH8v/r9Gn6fy8XcWwW2jMADZwrYxAThO
   pCbE9DQtZHjoY5xfUHopeQxdc/P4TsAEKzKx3uCqQ5ja2PnNiSh381GWa
   A==;
X-CSE-ConnectionGUID: tRVARrpTT2uo5rHfSAlWYA==
X-CSE-MsgGUID: Ga3doYYsRDqPdduR/rwe1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="89528340"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="89528340"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 14:10:53 -0700
X-CSE-ConnectionGUID: ZHUuYr25Qm6x//lEWy8yYA==
X-CSE-MsgGUID: MACfbqJDRGau3IjnpXqCVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="231745302"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.88.27.144])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 14:10:53 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Fenghua Yu <fenghuay@nvidia.com>, Shuai Xue <xueshuai@linux.alibaba.com>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: idxd: fix double free in idxd_alloc()
 error path
In-Reply-To: <CANUHTR_UiN8V6wWkb2d=9p2FpxH79Fvv-mXCG9217h-aeak6bQ@mail.gmail.com>
References: <20260413113113.2725940-1-lgs201920130244@gmail.com>
 <87340m3bi5.fsf@intel.com>
 <CANUHTR_UiN8V6wWkb2d=9p2FpxH79Fvv-mXCG9217h-aeak6bQ@mail.gmail.com>
Date: Wed, 29 Apr 2026 14:10:52 -0700
Message-ID: <87lde5wjz7.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 26A6049A769
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10197-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vinicius.gomes@intel.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]

Guangshuo Li <lgs201920130244@gmail.com> writes:

> Hi Vinicius,
>
> Thanks for reviewing.
>
> On Thu, 23 Apr 2026 at 05:56, Vinicius Costa Gomes
> <vinicius.gomes@intel.com> wrote:
>>
>> On the review of 'v1', you agreed to the comments I made, but they are
>> neither reflected in the code nor in the series organization.
>>
>
> You're right =E2=80=94 my v2 did not incorporate the broader issues you p=
ointed out.
>
> At the moment I don't have a good fix for the similar patterns in
> idxd_clean_wqs(), idxd_clean_engines(), idxd_clean_groups(), and
> idxd_free(). Do you have any suggestion on the preferred way to
> restructure those cleanup paths?
>

The idea is that the explicit free's
(kfree()/bitmap_free()/ida_free()/etc) should be removed and instead
rely on device_put() doing the right thing on the _release() path.

Just not sure if we need to check that the workqueue was already created
before calling destroy_workqueue().


Cheers,
--=20
Vinicius

