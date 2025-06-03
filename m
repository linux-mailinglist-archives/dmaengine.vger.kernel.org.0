Return-Path: <dmaengine+bounces-5299-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6AAACC240
	for <lists+dmaengine@lfdr.de>; Tue,  3 Jun 2025 10:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3D87188C8E2
	for <lists+dmaengine@lfdr.de>; Tue,  3 Jun 2025 08:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E543281362;
	Tue,  3 Jun 2025 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m5vEW+eC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B607228137D;
	Tue,  3 Jun 2025 08:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748939641; cv=none; b=BsenGov7+peL0Vh8ucASPk3ZVug7PJIYYWyn1BDz58cB9bWzO5DgNGAfHMuNphOFXz/jIQ41nRGncf0L0TNwRX7EsJ3mzelwH+YoH+RecAfUErtmMlnRjqMUJq0A8eBpPCzY8VqxMWSlcEfGyqeNQXVOZzXjhRXClB5nsaKKqws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748939641; c=relaxed/simple;
	bh=6I08uDTKcAQGN/a1ejgxT2X3Yj5mTmjSPZuG++wTGII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2xPatR5QFYtkHLeBMt7Md0PKT0QSjzjkC4vO2bXIUbQrGJmke31/4lp18V6gl4tJAyNCCl9SkKTHeAh5wzPC7BfGs7b7ygVt/980/1yIZ/ahR8cInNoj9uifHiA6hJYkyVozOeA5n+DGdFO64Q1yySRCA9tdp5xktlLlzX7gw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m5vEW+eC; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748939640; x=1780475640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6I08uDTKcAQGN/a1ejgxT2X3Yj5mTmjSPZuG++wTGII=;
  b=m5vEW+eCEyFJPT4RpKYBMFC8RSnJmHTHQsthDrWC749C3djQVx780s0K
   02/D4I6j6Si/2XzeVo8yePvCGirHIjcVcu2rw7KBqxhqJBPFp/abZQiSr
   kuUpNLwkvMT1a33JSDV8S9QoehPRbQuUheeiChd19mU3c6FcaqWWAl6ET
   rD3qG9W9ur/Qoaxj2AvvWooAiUIa+hSuzwZIJ8CQDNpoFF0zAVf8wGlif
   HgnuTg0B8G9aTg6HBTGHqk5oLY4lQUopNx9IE7lrrh9FolQ9z+dVbJeAd
   ixp+n5seficgFSWpKbnbiPN4VitlfKUmc0LhKbxzU6+svH4XRdCpUKd8c
   A==;
X-CSE-ConnectionGUID: rZxcwEPETxaghYYC4lh9Ow==
X-CSE-MsgGUID: Z9+Q1QQVQI+tZqEbpMu2cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="73501160"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="73501160"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 01:33:59 -0700
X-CSE-ConnectionGUID: q/EF/En/TSSgP7GHtoFsaA==
X-CSE-MsgGUID: zq5IgQeSQGGApg3ljPIyOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="145285714"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 01:33:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uMN5l-000000035SG-43gV;
	Tue, 03 Jun 2025 11:33:53 +0300
Date: Tue, 3 Jun 2025 11:33:53 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: agski33 <agski33@proton.me>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	dmaengine@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [REGRESSION] Re: ELAN1206 Touchpad Bugzilla 219799
Message-ID: <aD6zcaMAK_r0Bei6@smile.fi.intel.com>
References: <z9A_-FfhGGSZqAHPl-DnF-qPhbI563CsiUUiC8nhdhcZUZYkgpkruvHQ6Vdt8Jt0s0ogm9tCNXFAfn06utR9Zwh_UNTUy4whJ2Z9oVcfPEA=@proton.me>
 <PN3PR01MB9597C74E424033DC90B6F3B2B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597F96188E061EB0B7ACBD6B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PN3PR01MB9597F96188E061EB0B7ACBD6B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jun 02, 2025 at 11:37:21PM +0530, Aditya Garg wrote:
> On 02-06-2025 11:35 pm, Aditya Garg wrote:
> > On 28-05-2025 07:44 pm, agski33 wrote:

...

> >> I am currently experiencing the issue that was previously reported in the
> >> following BugZilla
> >> entry: https://bugzilla.kernel.org/show_bug.cgi?id=219799.  I noticed that
> >> the bug was marked as NEEDINFO so I attempted to fill in the relevant
> >> information.
> >>
> >>  From my testing, it seems like IDMA transfers relating to the touchpad
> >> input are taking too long and causing timeouts within hid-multitouch.  

Is touchpad interface is I²C?

> >> I contacted ASUS in an attempt to obtain information relating to the
> >> workings of the touchpad that may assist with this issue, however I
> >> believe it is unlikely that I will be able to obtain anything useful from
> >> them.
> >>
> >> I am wondering if anyone has any additional suggestions for next debugging
> >> steps or things that I may try - would be happy to provide any additional
> >> information or do additional debugging etc.
> >>
> >> System Details:
> >> Device: ASUS Q528EH with ELAN1206 Touchpad
> >> Kernel versions: 6.9-rc6 is where the issue starts, persists through all
> >> kernel versions after including latest.
> >> Symptoms: Touchpad cursor will not move.  
> >>  Additional Observations: Something of potential interest that I noticed
> >> was that it appeared the touchpad is sending data byte by byte when doing
> >> an IDMA transfer, not sure if that is normal or not.
> >>
> >> Any suggestions for next steps are appreciated!  Thank you in advance for your time and input.
> > 
> > Looking at https://bugzilla.kernel.org/show_bug.cgi?id=219799#c2, dd4478d63b6a2b6891fcc1800eb26ce3f1ead1d4
> > seems to be the patch causing regression.
> 
> My bad, its 9140ce47872bfd89fca888c2f992faa51d20c2bc, the mailing list link is correct though.

It doesn't matter, the patch is technically correct — we do not serve the
spurious (not ours) interrupts.

> > https://lore.kernel.org/lkml/20240321120453.1360138-1-andriy.shevchenko@linux.intel.com/
> > 
> > Ccing relevant folks here.

-- 
With Best Regards,
Andy Shevchenko



