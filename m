Return-Path: <dmaengine+bounces-11825-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dPayCLsgP2pIPAkAu9opvQ
	(envelope-from <dmaengine+bounces-11825-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jun 2026 03:00:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6958C6D0AB3
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jun 2026 03:00:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=hq0mh7kW;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11825-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11825-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2888530363AB
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jun 2026 01:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9553F19F137;
	Sat, 27 Jun 2026 01:00:40 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8662231835;
	Sat, 27 Jun 2026 01:00:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782522040; cv=none; b=S0HBuOdLKNvfbbE13fm7vFJuhyXlrR2DRDl86GiHoduCZIudYScP22vY3affFR9BNrdjBTFMOK+OnQMJgdTJJSwxiQTw4kRyB63yQX5cC68g5GTcyd7QDcqcRHQElQV7/zdqa36mg8k2DzHNuPa/IwRQrlmt50PGglss2HZtQbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782522040; c=relaxed/simple;
	bh=u+9yEanISwFaRD+RR499j/edC/9S25+XHlhqWjUfj0k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sa6NAaJHocm7jMSYAt+hOpv0dcEjtR7Wr/MaJY2li/kuQINLYJsingkamocr5d5kXFzvv/9N06X17Sg3w52kZYYT+bV4+IuIqhp4irWAJVnaUIo7tUJVO/Kge1NjW84gFHJ6VTvPPljGFF1vghmk/d+hRQ1ojvQg0vrHojb+Zx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hq0mh7kW; arc=none smtp.client-ip=192.198.163.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782522038; x=1814058038;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=u+9yEanISwFaRD+RR499j/edC/9S25+XHlhqWjUfj0k=;
  b=hq0mh7kWeqRxMAMu09ng6gCzeaqWvM0/8UxAVCaW88ZxpklCFKmAx9yQ
   ewmtjf2aH436LWscOhWUxims6DxZd03BmARinmsuWdUW9W5XAyXbHXQ86
   zPVhqmN6Ivnld98w7PKk8uMAvyjlfvi6eVdb7WznrOznKIstkHYRn2Hqk
   sAfN4Elg7Wx3qAZwBs3Ha8Ok0TgYNforiOAsdULaqOHo58W+qUH4H0PFy
   TfDj2Z9Aqb2A71yvi/cDO6JiSn2uhaH3KXLPOjr+QCn8n1XLs4rLllmRe
   nwLp6ed6CinvoamTOZDW5azu9JLYmWFLulwiPbUo2UpWiXeRe8kZwZk85
   g==;
X-CSE-ConnectionGUID: T6Saj5iQQDKvZHoN8mRMqA==
X-CSE-MsgGUID: WGmyKS8wRIS7FEoV6GeY5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11829"; a="83455726"
X-IronPort-AV: E=Sophos;i="6.24,227,1774335600"; 
   d="scan'208";a="83455726"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 18:00:37 -0700
X-CSE-ConnectionGUID: 9Wwy2+JkQk6o7jO+wx+SXw==
X-CSE-MsgGUID: 923HrOrUR8C4D1BGZdeMzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,227,1774335600"; 
   d="scan'208";a="274659985"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.88.27.144])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 18:00:37 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Yuho Choi <dbgh9129@gmail.com>, Vinod Koul <vkoul@kernel.org>
Cc: Dave Jiang <dave.jiang@intel.com>, Frank Li <Frank.Li@kernel.org>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, Yuho Choi
 <dbgh9129@gmail.com>
Subject: Re: [PATCH v3] dmaengine: idxd: fix fdev setup failure cleanup in
 idxd_cdev_open()
In-Reply-To: <20260525141550.1385581-1-dbgh9129@gmail.com>
References: <20260525141550.1385581-1-dbgh9129@gmail.com>
Date: Fri, 26 Jun 2026 18:00:36 -0700
Message-ID: <877bnkiyq3.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11825-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dbgh9129@gmail.com,m:vkoul@kernel.org,m:dave.jiang@intel.com,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER(0.00)[vinicius.gomes@intel.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vinicius.gomes@intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6958C6D0AB3

Hi,

Yuho Choi <dbgh9129@gmail.com> writes:

> The failed_dev_add and failed_dev_name paths drop the file-device
> reference while wq->wq_lock is still held. If put_device(fdev) drops the
> last reference, idxd_file_dev_release() runs synchronously and tries to
> take wq->wq_lock again, deadlocking.
>
> Those paths also fall through into the later ctx cleanup labels even
> though idxd_file_dev_release() owns that cleanup and frees ctx. This can
> make idxd_xa_pasid_remove(ctx) and kfree(ctx) operate on a freed context.
>
> Move idxd_wq_get() before file-device setup can fail, since the release
> callback always calls idxd_wq_put(). Then unlock wq->wq_lock before
> put_device(fdev) and return directly from the file-device setup failure
> path, leaving ctx cleanup to the release callback.
>
> Fixes: e6fd6d7e5f0fe ("dmaengine: idxd: add a device to represent the file opened")
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
> ---

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius

