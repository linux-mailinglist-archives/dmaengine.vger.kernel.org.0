Return-Path: <dmaengine+bounces-9873-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WE3qJMqpzmkgpQYAu9opvQ
	(envelope-from <dmaengine+bounces-9873-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 19:39:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B5338C9E7
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 19:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CF1830086F6
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2026 17:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AA8284881;
	Thu,  2 Apr 2026 17:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fakOowFz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030883E8678;
	Thu,  2 Apr 2026 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775151380; cv=none; b=K3tW7488fzTgHHl75GAaUSEWI+AeJM0zG6UYY6vIlewdDXWJBQ2tKRRYcf/qjM1dRwFIZug28yrKWB8yARB5AArAo7ZPU/EZ2U3f1g3nF9A/4TQeqtv/Al3TPDmJIFIj9LZI5Ldy9rSrAhInyO8q8KojGeArZ6jKGIHSIiFDUAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775151380; c=relaxed/simple;
	bh=YxRLoN+QdyTmYlTT2U0r+OH1crBHfDC8pB2LkxXEa2o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y4/LlC+T0AryVpj7llu4PpFYBpgjZgUDyUD/rBSVC/pJyhVdVG4L0sqH4RQ9lzqqWjBUd2gqax4dbbbqSFaHS1U69xa+rQRVsWZ+ZpU2U9FoEntSdA3ItFbXgjN9gaTuTp4rkM0vtCsU8bmMdKukcY8QTUG8qjsfb/5AvA5OhEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fakOowFz; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775151378; x=1806687378;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=YxRLoN+QdyTmYlTT2U0r+OH1crBHfDC8pB2LkxXEa2o=;
  b=fakOowFzKxF+ArHF85eUcc7uDLzjqOKHrR96/pXSnTP7NPYLrD0RihO1
   gEDHABILuWHBXq9nS/O7cwuHltkERW2Kf+4AsH/0U5CYaG6fZJxqmGOB9
   p0zdpfZvJ5gwy4dqbABDtj/IKbC4O+4IQQ0npZtOgEfpJh9jhxbhNwuzw
   ygMoJ0yUTRdm/8PzR3/muqUal0he+65leoYgxa1XmUAdg9+eupGPC0icN
   zEmQumx8+F7RCZsOoQ2EwM8Dixdc0He81geSAox7P29eSJGXfsbjK8I+Q
   r8+bzZdkKHYTyU52NjQX8zfH7F/rMYb4D09RfNzhEVfckl34SM5znKHd0
   g==;
X-CSE-ConnectionGUID: LBX3ENddQMe6JhSdlljx8A==
X-CSE-MsgGUID: GkR6irE/QlO+QC9VouJWLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="80106522"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="80106522"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 10:36:17 -0700
X-CSE-ConnectionGUID: 8sJSDTgrQlqZ0EuJQwiehQ==
X-CSE-MsgGUID: PLkfxU4rQzqSsqIRsqENVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="223760481"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.88.27.144])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 10:36:16 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, Shuai
 Xue <xueshuai@linux.alibaba.com>, Fenghua Yu <fenghuay@nvidia.com>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: fix double free in idxd_alloc() error
 path
In-Reply-To: <CANUHTR94+ZEO6d3+Pm1cdHw3firrAaVqxO90XwfHGrAkx37wsg@mail.gmail.com>
References: <20260401094003.1482794-1-lgs201920130244@gmail.com>
 <87h5puxoa2.fsf@intel.com>
 <CANUHTR94+ZEO6d3+Pm1cdHw3firrAaVqxO90XwfHGrAkx37wsg@mail.gmail.com>
Date: Thu, 02 Apr 2026 10:36:16 -0700
Message-ID: <87bjg1xo1b.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9873-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vinicius.gomes@intel.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: F1B5338C9E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Guangshuo Li <lgs201920130244@gmail.com> writes:

> Hi Vinicius,
>
> Thanks for reviewing  =E2=80=94 the feedback is helpful.
>
> I'm working on top of v6.19-rc8-214-ge7aa57247700.
>
> Regarding the concern about put_device(conf_dev) triggering
> idxd_conf_device_release() and hitting a NULL idxd->wq in
> destroy_workqueue():
>
> idxd_conf_device_release() does not call destroy_workqueue(). That
> call lives in idxd_cleanup_internals(), which is a separate code path.
> The actual release callback is:
>

Current master includes that code:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/dma/idxd/sysfs.c#n1839

That modification was part of fix series that I proposed and was applied
on time for v7.0. It seems that I didn't do a good enough job of going
through the error paths.


Cheers,
--=20
Vinicius

