Return-Path: <dmaengine+bounces-10574-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGovKNMkDmr26QUAu9opvQ
	(envelope-from <dmaengine+bounces-10574-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 23:17:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDD959AA9C
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 23:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF875314398A
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 21:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA78C37BE7E;
	Wed, 20 May 2026 21:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fgS/V5n0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BAC37B01F;
	Wed, 20 May 2026 21:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779311597; cv=none; b=aXgqategntcZBvrUxJR2EvpsJWkMOTMzkD6FHne4KH2zOeNriBtRAd9r4IwSdOlCbS15lf49VwfhQzRknXQNeLZSVRf5+iBWHMksEKgCm8s3CJL0Lhx2XdUMpuDi3RIIOubsXL3Uz2oVr1J2fUpAennB0Py+0v2UOlbzwkvcGb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779311597; c=relaxed/simple;
	bh=Xh5yp40E9LtTIvRcStzKNJkD6r1abPhdkdfsFEL/4to=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pRN7Jxatd6m/M+Bz5K985ph98/IYpENN3k8ZZXjehfwGlBoxbCFd7tlmDXvuJbGOxVa9YBnx7WFlBdKx186A7ZNu1K0RexgCWEWYnoFcNCR0bpF0g7dMpK4A1jFl0apT9fePXnwiUs2AnoY20tw45lW+zOtKK5QgdUH+W1mMBLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fgS/V5n0; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779311596; x=1810847596;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Xh5yp40E9LtTIvRcStzKNJkD6r1abPhdkdfsFEL/4to=;
  b=fgS/V5n0XB/Be7Rf75lu34Ag7ilxBeUtkajdFroPL1jox651h45TTho/
   akoVWL1e/WREs6T7nJpOA8CxKTm+hO/l7GnKfkfQVn7thI3reKwuLDlfL
   F4IGwU8zNEwFf07mLe6PMu90ourAKNnoOjPwJA8nyIM7aV2VJ5whKQmbH
   V6YxsIsE+ZqDU2x6fNOQsW6HBfaM49gksP+sWCffAxDNfTcbJ7M7ShW9m
   L9VPCJ1u3a1D1CkpzbIvH1yP0HWxb69EyGOkdJrgt4V43j5sfbAxCc7+Z
   5sh4koPuL6yayk/9ZlWY9AvvsvXnQLQpcsDqjzjOjpowhptZwjYGG8qwR
   w==;
X-CSE-ConnectionGUID: UY7S67SXT4OMxcutHSaJ0w==
X-CSE-MsgGUID: NNOX8scXR+qotdeKIYhEdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="84079986"
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="84079986"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 14:13:16 -0700
X-CSE-ConnectionGUID: er2BUBohTYyLeMYGLJHIyA==
X-CSE-MsgGUID: Ssgze3Q/SWKLDtQpwCxQyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="233961692"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.88.27.144])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 14:13:14 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Yuho Choi <dbgh9129@gmail.com>, Vinod Koul <vkoul@kernel.org>
Cc: Dave Jiang <dave.jiang@intel.com>, Frank Li <Frank.Li@kernel.org>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, Yuho Choi
 <dbgh9129@gmail.com>
Subject: Re: [PATCH v1] dmaengine: idxd: fix double free of wq, engine, and
 group structs
In-Reply-To: <20260415205452.67155-1-dbgh9129@gmail.com>
References: <20260415205452.67155-1-dbgh9129@gmail.com>
Date: Wed, 20 May 2026 14:13:13 -0700
Message-ID: <8733zlu6mu.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-10574-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vinicius.gomes@intel.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: CFDD959AA9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Yuho Choi <dbgh9129@gmail.com> writes:

> The release callbacks for wq, engine, and group devices
> (idxd_conf_wq_release, idxd_conf_engine_release,
> idxd_conf_group_release) each call kfree() on the enclosing struct.
> The setup error paths and cleanup functions also call kfree()
> explicitly after put_device(), producing a double free whenever
> put_device() drops the reference count to zero and fires the release.
>
> In the setup functions, device_initialize() is called before
> device_add(), so the reference count is exactly 1 at the error sites.
> put_device() unconditionally fires the release, which frees the struct;
> the subsequent explicit kfree() then operates on freed memory.
>
> For idxd_setup_wqs(), the wq release callback also owns opcap_bmap
> and wqcfg. The error unwind additionally freed those fields explicitly
> before calling put_device(), causing further double frees on both.
>
> Remove the redundant explicit kfree() calls from all setup error paths
> and cleanup functions for wq, engine, and group structs, delegating
> sole ownership of those allocations to the release callbacks.
>
> Fixes: 7c5dd23e57c1 ("dmaengine: idxd: fix wq conf_dev 'struct device' lifetime")
> Fixes: 75b911309060 ("dmaengine: idxd: fix engine conf_dev lifetime")
> Fixes: defe49f96012 ("dmaengine: idxd: fix group conf_dev lifetime")
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
> ---

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius

