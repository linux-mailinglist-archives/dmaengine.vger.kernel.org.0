Return-Path: <dmaengine+bounces-4811-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05213A79A9A
	for <lists+dmaengine@lfdr.de>; Thu,  3 Apr 2025 05:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3AE1893756
	for <lists+dmaengine@lfdr.de>; Thu,  3 Apr 2025 03:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E501991B2;
	Thu,  3 Apr 2025 03:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="egR0Qe7w"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15625190676;
	Thu,  3 Apr 2025 03:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743651903; cv=none; b=bQB6dycE4fuBBVfc8nBNTijkqJu6GqRLVKRcKWj7ARxmWfDFKEw881Oc50nfw19R8+Ze0jGmGscaU9LhxWWGLMTJ1kefgNgXmCykUtjPD9wavSW0TcnffJHBoKzA361zejhlZKLaDtmeePjF9yY3LtgMlXoaFWCCHrSvVGbDdWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743651903; c=relaxed/simple;
	bh=g0eeMoCPhUHJLnB0FxQba7YP3aKMy2i0lfXOvJHYqhY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rZpOfDawwkI+gmpUmyO5sQzKMRWeJjetz9hCesvIqGJQqzqGIjQcFXREPwcD1Ub1lW+BRbx/SGjow3mD4wOpN4n7Z5nX2YWP+DFsLli2u/oTeNV4+93VA72nBxIlMagbdIeonkuTQ93fzU6PRBI55msrQfKYOVZIHQq6OVP5r8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=egR0Qe7w; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743651902; x=1775187902;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=g0eeMoCPhUHJLnB0FxQba7YP3aKMy2i0lfXOvJHYqhY=;
  b=egR0Qe7wgeMKD+fvOqGWlY11f293GTdySLLMZl3SE+jpSL+cduIf9oJe
   z3egFWwdBQZpHqSZMobmN25q+J4JOf6n7Ej+Rz1wnF9Jry8W7SPeJ15xn
   +Nmac9am+AGRcgPOUqIiwV2MiSoc58zV9GPq8pjT4sHlUo5yWaBtZ0wM/
   U9H9RlspVEQXG275x4G/j6cyxEw6vCZ2lNEK4PzAHkH7IsIFVJ9oDxEnl
   0DFMcL2nOY4Iqu523Hf0M48JYDZ/Wa8ezwu/lAK+iU/yseLjdV8eFfwUT
   jZBWOJ2m7IBHCVXNf9YsPz8oNmY2JG7NLMH50LLf8Cr1miZt7axZQkiXR
   w==;
X-CSE-ConnectionGUID: Zu18yyjpTmq4sV9N1UUoIQ==
X-CSE-MsgGUID: Fm/jHXoMSsWK2drkQIMWWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="56406226"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="56406226"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 20:45:01 -0700
X-CSE-ConnectionGUID: zggZ+9skQPu8Z6j+r+Pg3w==
X-CSE-MsgGUID: 9TXUhqieQe2H8+kfyYs9HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="126646112"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.222.157])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 20:45:00 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Nathan Lynch <nathan.lynch@amd.com>, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dave.jiang@intel.com, kristen.c.accardi@intel.com, kernel test robot
 <oliver.sang@intel.com>
Subject: Re: [PATCH v1] dmaengine: dmatest: Fix dmatest waiting less when
 interrupted
In-Reply-To: <877c428yng.fsf@AUSNATLYNCH.amd.com>
References: <20250305230007.590178-1-vinicius.gomes@intel.com>
 <878qpa13fe.fsf@AUSNATLYNCH.amd.com> <87senhoq1k.fsf@intel.com>
 <874izx10nx.fsf@AUSNATLYNCH.amd.com> <87wmcslwg4.fsf@intel.com>
 <871pv01vaz.fsf@AUSNATLYNCH.amd.com> <87r030ldbw.fsf@intel.com>
 <87y0x7z45p.fsf@AUSNATLYNCH.amd.com> <87ldt7l081.fsf@intel.com>
 <877c428yng.fsf@AUSNATLYNCH.amd.com>
Date: Wed, 02 Apr 2025 20:44:59 -0700
Message-ID: <87o6xdzz5w.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nathan Lynch <nathan.lynch@amd.com> writes:

> Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:
>> Nathan Lynch <nathan.lynch@amd.com> writes:
>>
>>> Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:
>>>> Nathan Lynch <nathan.lynch@amd.com> writes:
>>>>> dmatest_callback() employs wake_up_all(), which means this change
>>>>> introduces no beneficial difference in the wakeup behavior. The dmatest
>>>>> thread gets woken on receipt of the completion interrupt either way.
>>>>>
>>>>> And to reiterate, the change regresses the combination of dmatest and
>>>>> the task freezer, which is a use case people have cared about,
>>>>> apparently.
>>>>>
>>>>
>>>> If this change in behavior causes a regression for others, glad to send
>>>> a revert and find another solution.
>>>
>>> Thanks - yes it should be reverted or dropped IMO.
>>
>> Here's what I am thinking, I'll work on this a few days and see if I can
>> find an alternative solution and send the revert together with the fix.
>> If I can't find another solution in a few days, I'll propose the revert
>> anyway.
>
> Just checking on this - I see this regression is in Linus's master
> branch now.

I have a series with the revert, a (hopefully better) fix for this
issue, and a couple of others that I found along the way, that I should
be able to propose soon.


Cheers,
-- 
Vinicius

