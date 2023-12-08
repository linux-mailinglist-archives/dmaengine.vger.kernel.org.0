Return-Path: <dmaengine+bounces-429-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BF680AF81
	for <lists+dmaengine@lfdr.de>; Fri,  8 Dec 2023 23:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F071F21111
	for <lists+dmaengine@lfdr.de>; Fri,  8 Dec 2023 22:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F5B563BE;
	Fri,  8 Dec 2023 22:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TwtvYz0b"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108171712;
	Fri,  8 Dec 2023 14:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702073618; x=1733609618;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=w1v4oKJqwHgkdrRyzMFs/vg/GrTCtGOQwJHxok3dXpE=;
  b=TwtvYz0bo1ERyWUUh+r7I3rSv2JB/UEJVLwXDMcGLBUJBd1BPcE/Zb6g
   vPWFSSFoDh4r7IH6GCD29QsYXHFEwDB3JPKPXFzhSAwh9Mwe/Z8YsIyiF
   CZtPzTEqcBowQzport34p3Rtep58VuyyKare3lSgovSOZGKtOD6iuwFnl
   8HSzolmP7vwcfQfqulv+sYv0uCQLChQHHPaXloD02aw3+0Ml+K19uzFRm
   h9ePFrEWUdaaS3BS93vOMgNiVP5BcsqOO8LQdg9puAN5/iqodePpa0AH/
   bgsorwATHKMMfDfsbUfTdPWCMidUoMesKXgEQwChD/jTeyI96i3hqkAZA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="397262425"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="397262425"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 14:13:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="748485527"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="748485527"
Received: from arjunbal-mobl2.amr.corp.intel.com ([10.212.106.93])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 14:13:36 -0800
Message-ID: <433b750a252b778fc5bf6e8caf5bc14485623bac.camel@linux.intel.com>
Subject: Re: [PATCH v11 14/14] dmaengine: idxd: Add support for device/wq
 defaults
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>, herbert@gondor.apana.org.au, 
	davem@davemloft.net, vkoul@kernel.org
Cc: dave.jiang@intel.com, tony.luck@intel.com, wajdi.k.feghali@intel.com, 
 james.guilford@intel.com, kanchana.p.sridhar@intel.com,
 vinodh.gopal@intel.com,  giovanni.cabiddu@intel.com, pavel@ucw.cz,
 linux-kernel@vger.kernel.org,  linux-crypto@vger.kernel.org,
 dmaengine@vger.kernel.org
Date: Fri, 08 Dec 2023 16:13:33 -0600
In-Reply-To: <d4b36905-d6dc-eefb-f07d-a78a83526de4@intel.com>
References: <20231201201035.172465-1-tom.zanussi@linux.intel.com>
	 <20231201201035.172465-15-tom.zanussi@linux.intel.com>
	 <d4b36905-d6dc-eefb-f07d-a78a83526de4@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-08 at 12:12 -0800, Fenghua Yu wrote:
>=20
>=20
> On 12/1/23 12:10, Tom Zanussi wrote:
> > Add a load_device_defaults() function pointer to struct
> > idxd_driver_data, which if defined, will be called when an idxd
> > device
> > is probed and will allow the idxd device to be configured with
> > default
> > values.
> >=20
> > The load_device_defaults() function is passed an idxd device to
> > work
> > with to set specific device attributes.
> >=20
> > Also add a load_device_defaults() implementation IAA devices;
> > future
> > patches would add default functions for other device types such as
> > DSA.
> >=20
> > The way idxd device probing works, if the device configuration is
> > valid at that point e.g. at least one workqueue and engine is
> > properly
> > configured then the device will be enabled and ready to go.
> >=20
> > The IAA implementation, idxd_load_iaa_device_defaults(), configures
> > a
> > single workqueue (wq0) for each device with the following default
> > values:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mode=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 "dedicated"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 threshold=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Total WQ Size from WQCAP
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 priority=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A010
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0IDXD_WQT_KERNEL
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 group=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "iaa_crypto"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 driver_name=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 "crypto"
> >=20
> > Note that this now adds another configuration step for any users
> > that
> > want to configure their own devices/workqueus with something
> > different
> > in that they'll first need to disable (in the case of IAA) wq0 and
> > the
> > device itself before they can set their own attributes and re-
> > enable,
> > since they've been already been auto-enabled.=C2=A0 Note also that in
> > order
> > for the new configuration to be applied to the deflate-iaa crypto
> > algorithm the iaa_crypto module needs to unregister the old
> > version,
> > which is accomplished by removing the iaa_crypto module, and
> > re-registering it with the new configuration by reinserting the
> > iaa_crypto module.
> >=20
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>=20
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
>=20

Thanks, Fenghua!

Tom

> Thanks.
>=20
> -Fenghua


