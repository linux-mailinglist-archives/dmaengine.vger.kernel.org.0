Return-Path: <dmaengine+bounces-11107-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHlQG2TWHWptfQkAu9opvQ
	(envelope-from <dmaengine+bounces-11107-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 20:58:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E4962458C
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 20:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D61AB3006941
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jun 2026 18:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F094782899;
	Mon,  1 Jun 2026 18:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X5ptUMw1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80540356754;
	Mon,  1 Jun 2026 18:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780339531; cv=none; b=RIFGfqVXlNROo8OFU0q9slsXnaciC9PwzhEtmmNpukp9v1q4SaTDkdCQ3qP0nIlRLWnaNC3MHat0MMbX5pzd0TWVZP9icLXp8/UnDWmXn12KEldNeuTvxn7TPgd6QyvlD6E9iqD4yfCv//lLmGEphkHYGP0gDlar8/0kQaBbswQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780339531; c=relaxed/simple;
	bh=BmmM3CBFTQZCQU+w4853+LDZeg7z0nEO7q87wn69SUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpU73Hdz5m9aHWsXTYhXAjdIa9mViXpFefMf7gvNy4Xavsxr7BXT3SVZTTFoB74ERrbXjehkaiC5Lq5yQ0gDAQ0IhpgI7w1hu7yOBBlpTMQT+FijLQXVmIPeQsmcN0R5MeeFoXX0N3HVosOXlRZpnXPCa5DWpP3CK1SwPTpYYHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X5ptUMw1; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780339528; x=1811875528;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BmmM3CBFTQZCQU+w4853+LDZeg7z0nEO7q87wn69SUM=;
  b=X5ptUMw1c+ivlxAAdBiyOSsa/go2f07/k46GZMNZ5Ehi6KsPLvv//cwf
   uPP2VukrxotiXnX9FIZHZ5ZJDLBPX0unPXRyr8jMuqoWKJ0twzZaTHuFd
   NB84a9iKmG1htNuUv0AF5bNTJE1oyWspXnnYWGZOeuCZHqP3B4bvwQKxO
   qFnxlzwqOU7HPJDLwmvd1rl1Xx9HTwT6+v/uFujunCyRlmTVAGzSuc/p6
   szsHcFQyWKMCqiGCOw5sktJbd3y1UsqAdmFzf//jiMTJBI3ulFV5ycfRB
   vai3gfQnKClfMeMvsaJDuUKOHz9AT9JesRVnrWpsDXYXKsWsw5oe7KY98
   A==;
X-CSE-ConnectionGUID: YO8rKSvcSmiO0wBMTofpAg==
X-CSE-MsgGUID: bPcf+nYoSpO74l9U5kA8tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81291917"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="81291917"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 11:45:26 -0700
X-CSE-ConnectionGUID: NmWlB6JjTFi2MkYO7+qV0g==
X-CSE-MsgGUID: Wq1Y0qG8Ssmkmo/xuEvNew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="273937250"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.111])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 11:45:14 -0700
Date: Mon, 1 Jun 2026 21:45:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Simon Schuster <schuster.simon@siemens-energy.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>, Dinh Nguyen <dinguyen@kernel.org>,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	workflows@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
	dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-iio@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
	linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	Kees Cook <kees@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nicholas Piggin <npiggin@gmail.com>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Dave Penkler <dpenkler@gmail.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof WilczyDski <kwilczynski@kernel.org>,
	Andreas Oetken <andreas.oetken@siemens-energy.com>
Subject: Re: [PATCH] nios2: remove the architecture
Message-ID: <ah3TN93e7lRpVihW@ashevche-desk.local>
References: <20260518042833.272221-1-enelsonmoore@gmail.com>
 <d40b1e80-37fc-4c88-9d7f-dae6458efe6c@app.fastmail.com>
 <20260518105735.GW3126523@noisy.programming.kicks-ass.net>
 <20260518172444.zyd47mcagrcwu7wt@dev-vm-schuster>
 <CADkSEUjhq6HSdg4ignzbuJiN5uXATsTdxFbRJ3BMxs5=WUWLDg@mail.gmail.com>
 <20260519103012.blot4bssgiqfer6p@dev-vm-schuster>
 <CANiq72=6oYtHf0Q1NaLXZ+25uQyYbej2xnvUhtgpHyvozhP7_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=6oYtHf0Q1NaLXZ+25uQyYbej2xnvUhtgpHyvozhP7_Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11107-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[siemens-energy.com,gmail.com,sang-engineering.com,infradead.org,arndb.de,kernel.org,vger.kernel.org,lwn.net,linuxfoundation.org,linux.dev,hust.edu.cn,link.tyut.edu.cn,redhat.com,linux-foundation.org,baylibre.com,analog.com,lunn.ch,davemloft.net,google.com];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_GT_50(0.00)[53];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ashevche-desk.local:mid,intel.com:dkim,siemens-energy.com:email]
X-Rspamd-Queue-Id: 12E4962458C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 01:07:46PM +0200, Miguel Ojeda wrote:
> On Tue, May 19, 2026 at 12:41 PM Simon Schuster
> <schuster.simon@siemens-energy.com> wrote:
> >
> > Sure, I'd be glad to do so, but so far I refrained from it as I was a bit
> > unsure about the netiquette (can I simply do so by self-proclamation? At
> > least the git history seems to suggest so...).
> 
> Up to the existing maintainer, in general.
> 
> I would also suggest changing the support level to "Supported",
> instead of "Maintained" -- that would help justify keeping it in
> mainline.

Supported implies that one gets real money for the job. Is this the case here?

-- 
With Best Regards,
Andy Shevchenko



