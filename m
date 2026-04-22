Return-Path: <dmaengine+bounces-10084-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PWNHhlE6WmqWwIAu9opvQ
	(envelope-from <dmaengine+bounces-10084-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 22 Apr 2026 23:56:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A25744B2CE
	for <lists+dmaengine@lfdr.de>; Wed, 22 Apr 2026 23:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2DCD3057748
	for <lists+dmaengine@lfdr.de>; Wed, 22 Apr 2026 21:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9A8371D05;
	Wed, 22 Apr 2026 21:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AWFEv+JD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C282882B7;
	Wed, 22 Apr 2026 21:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776894997; cv=none; b=QzjOkhlnPAXLa0hqJ7oaoLz2uMp0imCPS9F5Oz7GqlM85rhSDp8YFp5r7kbCP+fS+Ys6RadzRf96FfmEWTVSbCHdO1TEyz/EK5udeaCgPlGyA4FnhKyUXxzdrQa8RILra1gHAhQyH3DArTzhw+0Zh58a5jUea1PDm+0TNB7JIvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776894997; c=relaxed/simple;
	bh=HNAMYz5AtPHIhDSjv6tsP5jrePYIGO3SagzyMioYCKQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JrGRACc5lepP8CEEbWZo5p/S8W/nRPSPQOywdoKt3YOTSuFD7b+p1PnGfY5A3BjO9umVx0PVxsvKfCB6znMGgZkmDjbsFWm7OJaIPL3FpMb5ign/UUM1QaY2OTuEO/ZL0B72qtB9rkfYR4dj2/5HZkfqbAyy3j6AYgN+XhKhkzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AWFEv+JD; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776894995; x=1808430995;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=HNAMYz5AtPHIhDSjv6tsP5jrePYIGO3SagzyMioYCKQ=;
  b=AWFEv+JDqJ0svL75sJel8w+sNnYL12XFU+z4queZoqQFkhdwfbtZLtAM
   iI357QJMfEk+rUdotgWmJcJrEtaqOgMJs+pJ2dl7zOcIc7RWEMeQS1BWY
   evuf0GQnBe9Pn0Tjg21YNp3FHcMhsuSZqsPeyBASHZeHLCa9EYZrcgvu6
   se3uJdghiXqDjg7DSH8oqc9DFJoZ75/QI0IjAbMzi7F5qURqejo5vPSK5
   y1kGk3CHm9cGvAD+YXfr0y87qOUff46cgHsxPBU+8d2RoN2Tn9uV2QKxs
   Do+jMfPzrJdiKUnlAKwSu+DAIQu2uq3MC7dtIOz6IbZSMf0x6+0PDG5x8
   A==;
X-CSE-ConnectionGUID: Tl4r5bmFTUu5++SswiE8dw==
X-CSE-MsgGUID: T2Ny5bAGSCK5bF1gM6U68Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="80447626"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="80447626"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 14:56:18 -0700
X-CSE-ConnectionGUID: 2VsgkjtXQrmUNPrxPfNQZA==
X-CSE-MsgGUID: 8TLOyhpARhW5FVxn8JtrMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="234257420"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.88.27.144])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 14:56:18 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>, Dave Jiang
 <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, Fenghua Yu
 <fenghuay@nvidia.com>, Shuai Xue <xueshuai@linux.alibaba.com>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: idxd: fix double free in idxd_alloc()
 error path
In-Reply-To: <20260413113113.2725940-1-lgs201920130244@gmail.com>
References: <20260413113113.2725940-1-lgs201920130244@gmail.com>
Date: Wed, 22 Apr 2026 14:56:18 -0700
Message-ID: <87340m3bi5.fsf@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,kernel.org,nvidia.com,linux.alibaba.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10084-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vinicius.gomes@intel.com,dmaengine@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5A25744B2CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Guangshuo Li <lgs201920130244@gmail.com> writes:

> When dev_set_name() fails after device_initialize(), idxd_alloc()
> calls put_device(conf_dev).
>
> For these devices, conf_dev->type is set from idxd->data->dev_type,
> which resolves to dsa_device_type or iax_device_type, and both use
> idxd_conf_device_release() as their release callback. That release
> callback frees idxd, idxd->opcap_bmap, and releases idxd->id, but
> the current error path then frees those resources again directly,
> causing a double free.
>
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
>
> Keep the cleanup in idxd_conf_device_release() after put_device() and
> avoid freeing idxd-managed resources again in idxd_alloc().
>
> Fixes: 46a5cca76c76 ("dmaengine: idxd: fix memory leak in error handling path of idxd_alloc")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---

On the review of 'v1', you agreed to the comments I made, but they are
neither reflected in the code nor in the series organization.


-- 
Vinicius

