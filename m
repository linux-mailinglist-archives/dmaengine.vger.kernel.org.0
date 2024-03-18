Return-Path: <dmaengine+bounces-1431-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5164B87F2BC
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 22:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD842821FC
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 21:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535EF59B74;
	Mon, 18 Mar 2024 21:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NDIqzqGP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD65159B5E
	for <dmaengine@vger.kernel.org>; Mon, 18 Mar 2024 21:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710799076; cv=none; b=FYKnQTaNg01Fgeby2iLv6E86qutByEvyv4Mgy302YIeWf6BSIxp39JLpYC42kSlSXGkoY7wYRv5/O4uLMIS5EiKh0c8LQI5BcE3PZ9cUSLAbXqlOWJ7G87UhIN8fIiZRpVbwgohwSB9+bycfsJz1D2QnkbYbem0pAFiJg4j8LyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710799076; c=relaxed/simple;
	bh=mq3n7w9kxKV1JhodLnChinrnRTOJjSY/07Pp5pJlD7k=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SSn+rRd7ABpBm9h5blO9kl4l1R7LMCowD1CYXj/CBk33feFGF/8BB/IrDWlaDEDaZwQZy9vJKYE2PKOOacp1QVJsYglYQMIKS7Gr5Gs9jMviQCj0B9UOI1Mc1xMOBfHDHdUAi62YpJpnzKACeJuN+Oj2WUhVfdZoY6Yv01EaqVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NDIqzqGP; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710799075; x=1742335075;
  h=message-id:subject:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version;
  bh=mq3n7w9kxKV1JhodLnChinrnRTOJjSY/07Pp5pJlD7k=;
  b=NDIqzqGPfEtbAgm9ZIWAdmWukSyLE8md/L0MgfaqAR1aF2Cr1diIRXXZ
   6ShOCHhS+VZIgyYC/izmaYA6hNOOpyOZvlMBhR+PCpMcNaW2S+pZ1XA8Z
   GMntLIjT63o+85iJoRqDcMYt2Qlo5YG/6Xtql7osxkxoyug8mqTt1VWUi
   GesPI/rANEH5GSj7IASdXQQpLZmU/t0f+yyiuGTdpyFjb35jaIr3cNPYV
   gU6iQ7L6xQ5g/u6PSWrginCqX8+F27pr77OESoYfLmN8Vs9bQruW8p1j9
   ZP6nOxeLqcZABQfG8Vrj31GjTjFFCJvXXJ2CU3FGXARO16k8LLuy8Ihuv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="23095167"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="23095167"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 14:57:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="13559029"
Received: from achriczk-mobl.amr.corp.intel.com ([10.212.85.116])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 14:57:53 -0700
Message-ID: <f653d44ae2a955b021eea2acb7616321d8e0cff7.camel@linux.intel.com>
Subject: Re: Question about the recent idxd/iaa changes
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: Jerry Snitselaar <jsnitsel@redhat.com>, Fenghua Yu
 <fenghua.yu@intel.com>,  Dave Jiang <dave.jiang@intel.com>,
 dmaengine@vger.kernel.org
Date: Mon, 18 Mar 2024 16:57:52 -0500
In-Reply-To: <oqg5575kdaifbkftpg6rcp7koc572agsbuatkty63rosfl47hu@utiou35xdt4y>
References: 
	<6jxxptlp44ipbafnbfi4ntyphd22eqj7j7grpwfsnvunuspkre@iolf6nbqfoxp>
	 <oqg5575kdaifbkftpg6rcp7koc572agsbuatkty63rosfl47hu@utiou35xdt4y>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jerry,

On Mon, 2024-03-18 at 13:35 -0700, Jerry Snitselaar wrote:
> On Mon, Mar 18, 2024 at 01:18:58AM -0700, Jerry Snitselaar wrote:
> > With adding the support for loading external drivers like iaa,
> > autoloading, and default configs, systems with IAA that are booted
> > in
> > legacy mode get a number of probe failing messages from the user
> > driver for the iax wqs before it probes with the iaa_crypto
> > driver. Should the name match check occur prior to checking if user
> > pasid is enabled in idxd_user_drv_probe? On a GNR system this will
> > generate over 100 log messages at boot like the following:
> >=20
> > [=C2=A0=C2=A0 56.885504] user: probe of wq15.0 failed with error -95
> >=20
> > Regards,
> > Jerry
> >=20
>=20
> Hi Tom,
>=20
> A couple more iaa questions I had:
>=20
> - Are you supposed to disable all iax workqueues/devices to
> =C2=A0 reconfigure a workqueue? It seems perfectly happy to let you
> =C2=A0 disable, reconfigure, and enable just one. I know for idxd in
> =C2=A0 general the intent is to be able to disable, configure, and enable
> =C2=A0 workqueues/devices as needed for different users. I'm wondering if
> =C2=A0 that is the case for iaa as well since it talks about unloading an=
d
> =C2=A0 loading iaa_crypto for new configurations.
>=20

In general the idea is that you set up your workqueues/devices, which
registers the=C2=A0iaa-crypto algorithm and makes it available as a plugin
to e.g. zswap. The register happens on the probe of the first wq,
subsequent wqs are added after that and rebalance the wq table, so
yeah,  you can also reconfigure wqs in the same way.

But you can't remove and reconfigure everything and re-register the
algorithm, see below.

>=20
> - Is there a reason that iaa_crypto needs to be reloaded beyond the
> =C2=A0 compression algorithm registration? I tried moving the unregister
> =C2=A0 into iaa_crypto_remove with a check that the iaa_devices list is
> =C2=A0 empty, and it seemed to work, but I wasn't sure if there some othe=
r
> =C2=A0 reason for it being in iaa_crypto_cleanup_module instead of
> =C2=A0 iaa_crypto_remove similar to the register call in iaa_crypto_probe=
.
>=20

The requirement to only allow the algorithm to be unregistered on
module unload came from the crypto maintainer during review [1].

Specifically, this part:

  1) Never unregister your crypto algorithms, even after the last
  piece of hardware has been unplugged.  The algorithms should only
  be unregistered (if they have been registered through the first
  successful probe call) in the module unload function.

hth,

Tom


[1] https://lore.kernel.org/lkml/ZC58JggIXgpJ1tpD@gondor.apana.org.au/





> Regards,
> Jerry
>=20


