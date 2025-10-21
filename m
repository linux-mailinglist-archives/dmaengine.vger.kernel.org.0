Return-Path: <dmaengine+bounces-6920-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C37F1BF93F4
	for <lists+dmaengine@lfdr.de>; Wed, 22 Oct 2025 01:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A86D18C7713
	for <lists+dmaengine@lfdr.de>; Tue, 21 Oct 2025 23:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A49286D4B;
	Tue, 21 Oct 2025 23:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mXfgdhU6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E6C272811;
	Tue, 21 Oct 2025 23:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761089595; cv=none; b=IBWEmbhIR2frO5qTMvmm6btcoYjICEiBt9Z9Dx+XGHVWCUIisb8elrNdqAUdbv1NyOEjDr8AJ2nNXSMbtOBeVhzA51aZiPkW1vFCwlLSYX15YYIB/ZdzQ0RsrFh56rwh3V9cbCYayGQ8qCCBZApcGOTx1IC58rynkvW/7wsYVWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761089595; c=relaxed/simple;
	bh=AJaVbX4mgWucjzYIHmh9A+dLYHj2n5htJHv7lvWxxGE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dwppBgTIRieXYJlwWRtq6E7XBh1wqS/M61Kb06mtyvsbyucNyC+REQYnbOLNZ0wUJR/R81r992F2YjYFuHWCtXPw8HUtIRBgS+n1ZwBZTFkGCaJA1syfU1kvjF00lXzyDMGAVYi7abINDVEce2QLplmwYsi5O/3rGR1YqOzNMMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mXfgdhU6; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761089594; x=1792625594;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=AJaVbX4mgWucjzYIHmh9A+dLYHj2n5htJHv7lvWxxGE=;
  b=mXfgdhU6yPCDi9L345+1N9AHeaNnQV4p1SNu4JQNzdN0VtWKLH5PlX/V
   y5rB6EkVFHXHDhA12Dw2dHGcg/zBV0mmczSXLog6rlmRlyyJif4jLlEtn
   MbZWtXBs4AQQjQPCilVTIrChad5NUPmJjUZe5k/tZVsJ0QIP3Lx0EiutI
   vuXH5aqAVQgbAdVzaMRO1ingH5xxaR0+pJH3W5hkxBmUmWdMl6NY7i+ZQ
   IaNTxib9z/r1ICALvsigSz7s5lHJD/4oaeefsPKeQz6x1t2kFc+RcqSBv
   +sOyM2BIZYDStmUCTFYHVpgZt1hvEL+pfIFnLKs4Bsjo2fUhgZcj0oU8+
   w==;
X-CSE-ConnectionGUID: i/gPhJ2jRrOD4pwEMSmgsw==
X-CSE-MsgGUID: p/leEhOsRU2FJwxsTljItw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="88696284"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="88696284"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 16:33:13 -0700
X-CSE-ConnectionGUID: 4Yop0g7DQdaZFeD19mD7AQ==
X-CSE-MsgGUID: ZWWD1EG+Qke9lWgDIjslQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="220895849"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.88.27.140])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 16:33:14 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Dave Hansen <dave.hansen@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, Dan
 Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] dmaengine: idxd: Fix lockdep warnings when
 calling idxd_device_config()
In-Reply-To: <c7a454f4-c471-49d5-ac35-5375a45a6610@intel.com>
References: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-0-595d48fa065c@intel.com>
 <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-1-595d48fa065c@intel.com>
 <c7a454f4-c471-49d5-ac35-5375a45a6610@intel.com>
Date: Tue, 21 Oct 2025 16:33:26 -0700
Message-ID: <878qh3keyh.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Dave Hansen <dave.hansen@intel.com> writes:

> On 8/21/25 15:59, Vinicius Costa Gomes wrote:
>> Move the check for IDXD_FLAG_CONFIGURABLE and the locking to "inside"
>> idxd_device_config(), as this is common to all callers, and the one
>> that wasn't holding the lock was an error (that was causing the
>> lockdep warning).
>
> What is "the lockdep error"? I don't see any details about an error in
> the changelog here or the cover letter?

I should have added the lockdep splat here, idxd_reset_done() is calling
idxd_device_config() without holding the lock, and the lockdep assert
inside idxd_device_config() complains about that.

I thought the commit message ("one wasn't holding") and the code would
be clear enough. In case of a another version the series, I will add the
information here.


Cheers,
-- 
Vinicius

