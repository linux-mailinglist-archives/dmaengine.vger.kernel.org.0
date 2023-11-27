Return-Path: <dmaengine+bounces-265-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5047FADA4
	for <lists+dmaengine@lfdr.de>; Mon, 27 Nov 2023 23:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8901C20DB1
	for <lists+dmaengine@lfdr.de>; Mon, 27 Nov 2023 22:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA2345944;
	Mon, 27 Nov 2023 22:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DcvTiRIk"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD63191;
	Mon, 27 Nov 2023 14:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701124937; x=1732660937;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=EL9OSVyrYjPUdtMrgwZBR2eyGtrdMhnTa9tZlQ/698A=;
  b=DcvTiRIkXWCancvhmcecopMGyrJjQnc8NLeVugiqgjNy6UV+QmcuP1/F
   TvSBC1rpAqt+PSGflEBhXuc+NQpFpd9TzmXQ7c+lsJeaP+zyOkJKFLXH1
   7NgdCw2upbFs2bNuIbSwz99K0Sdla0QYBP0Qe2THYDBgVNWd2spoTds6f
   Gk62ez1Gks2usmcB7ToQ6Ru+ikPvwB6xWD8Cc3tcosh9IzwUNP7tJL/Km
   GQS36HWyyG8t52BhIjaGpeGKTFfWob/bODPKrteDk/Kz/LmYUsEapdLPI
   pwjqZzbgBSBONE9it9ey8l+LSsNKYm0Mml5mfPtRo+6Z0loGqin1oiSyr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="395621007"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="395621007"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 14:42:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="891884484"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="891884484"
Received: from avenkat1-mobl.amr.corp.intel.com ([10.213.174.38])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 14:42:15 -0800
Message-ID: <24ea5fa0d43bcd67f98f9c236e64bddbaec06b07.camel@linux.intel.com>
Subject: Re: [PATCH v10 14/14] dmaengine: idxd: Add support for device/wq
 defaults
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: Dave Jiang <dave.jiang@intel.com>, herbert@gondor.apana.org.au, 
	davem@davemloft.net, fenghua.yu@intel.com, vkoul@kernel.org
Cc: tony.luck@intel.com, wajdi.k.feghali@intel.com,
 james.guilford@intel.com,  kanchana.p.sridhar@intel.com,
 vinodh.gopal@intel.com, giovanni.cabiddu@intel.com,  pavel@ucw.cz,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
 dmaengine@vger.kernel.org
Date: Mon, 27 Nov 2023 16:42:13 -0600
In-Reply-To: <6d68774a-1f2d-4a9a-b96c-0e9c93655021@intel.com>
References: <20231127202704.1263376-1-tom.zanussi@linux.intel.com>
	 <20231127202704.1263376-15-tom.zanussi@linux.intel.com>
	 <6d68774a-1f2d-4a9a-b96c-0e9c93655021@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-11-27 at 15:14 -0700, Dave Jiang wrote:
>=20
>=20
> On 11/27/23 13:27, Tom Zanussi wrote:
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
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mode=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "dedicated"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 threshold=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A00
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A016
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 priority=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A010
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0IDXD_WQT_KERNEL
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 group=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "iaa_crypto"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 driver_name=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 "crypto"
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
>=20
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Thanks, Dave!

Tom

>=20
> > ---
> > =C2=A0drivers/dma/idxd/Makefile=C2=A0=C2=A0 |=C2=A0 2 +-
> > =C2=A0drivers/dma/idxd/defaults.c | 53
> > +++++++++++++++++++++++++++++++++++++
> > =C2=A0drivers/dma/idxd/idxd.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +++
> > =C2=A0drivers/dma/idxd/init.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 +++++
> > =C2=A04 files changed, 65 insertions(+), 1 deletion(-)
> > =C2=A0create mode 100644 drivers/dma/idxd/defaults.c
> >=20
> > diff --git a/drivers/dma/idxd/Makefile b/drivers/dma/idxd/Makefile
> > index c5e679070e46..2b4a0d406e1e 100644
> > --- a/drivers/dma/idxd/Makefile
> > +++ b/drivers/dma/idxd/Makefile
> > @@ -4,7 +4,7 @@ obj-$(CONFIG_INTEL_IDXD_BUS) +=3D idxd_bus.o
> > =C2=A0idxd_bus-y :=3D bus.o
> > =C2=A0
> > =C2=A0obj-$(CONFIG_INTEL_IDXD) +=3D idxd.o
> > -idxd-y :=3D init.o irq.o device.o sysfs.o submit.o dma.o cdev.o
> > debugfs.o
> > +idxd-y :=3D init.o irq.o device.o sysfs.o submit.o dma.o cdev.o
> > debugfs.o defaults.o
> > =C2=A0
> > =C2=A0idxd-$(CONFIG_INTEL_IDXD_PERFMON) +=3D perfmon.o
> > =C2=A0
> > diff --git a/drivers/dma/idxd/defaults.c
> > b/drivers/dma/idxd/defaults.c
> > new file mode 100644
> > index 000000000000..a0c9faad8efe
> > --- /dev/null
> > +++ b/drivers/dma/idxd/defaults.c
> > @@ -0,0 +1,53 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright(c) 2023 Intel Corporation. All rights rsvd. */
> > +#include <linux/kernel.h>
> > +#include "idxd.h"
> > +
> > +int idxd_load_iaa_device_defaults(struct idxd_device *idxd)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct idxd_engine *engine;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct idxd_group *group;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct idxd_wq *wq;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!test_bit(IDXD_FLAG_CONF=
IGURABLE, &idxd->flags))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return 0;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0wq =3D idxd->wqs[0];
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (wq->state !=3D IDXD_WQ_D=
ISABLED)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -EPERM;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* set mode to "dedicated" *=
/
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0set_bit(WQ_FLAG_DEDICATED, &=
wq->flags);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0wq->threshold =3D 0;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* set size to 16 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0wq->size =3D 16;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* set priority to 10 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0wq->priority =3D 10;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* set type to "kernel" */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0wq->type =3D IDXD_WQT_KERNEL=
;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* set wq group to 0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0group =3D idxd->groups[0];
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0wq->group =3D group;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0group->num_wqs++;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* set name to "iaa_crypto" =
*/
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memset(wq->name, 0, WQ_NAME_=
SIZE + 1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0strscpy(wq->name, "iaa_crypt=
o", WQ_NAME_SIZE + 1);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* set driver_name to "crypt=
o" */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memset(wq->driver_name, 0, D=
RIVER_NAME_SIZE + 1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0strscpy(wq->driver_name, "cr=
ypto", DRIVER_NAME_SIZE + 1);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0engine =3D idxd->engines[0];
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* set engine group to 0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0engine->group =3D idxd->grou=
ps[0];
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0engine->group->num_engines++=
;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > +}
> > diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> > index 62ea21b25906..47de3f93ff1e 100644
> > --- a/drivers/dma/idxd/idxd.h
> > +++ b/drivers/dma/idxd/idxd.h
> > @@ -277,6 +277,8 @@ struct idxd_dma_dev {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct dma_device dma;
> > =C2=A0};
> > =C2=A0
> > +typedef int (*load_device_defaults_fn_t) (struct idxd_device
> > *idxd);
> > +
> > =C2=A0struct idxd_driver_data {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const char *name_prefix=
;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0enum idxd_type type;
> > @@ -286,6 +288,7 @@ struct idxd_driver_data {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int evl_cr_off;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int cr_status_off;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int cr_result_off;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0load_device_defaults_fn_t lo=
ad_device_defaults;
> > =C2=A0};
> > =C2=A0
> > =C2=A0struct idxd_evl {
> > @@ -730,6 +733,7 @@ void idxd_unregister_devices(struct idxd_device
> > *idxd);
> > =C2=A0void idxd_wqs_quiesce(struct idxd_device *idxd);
> > =C2=A0bool idxd_queue_int_handle_resubmit(struct idxd_desc *desc);
> > =C2=A0void multi_u64_to_bmap(unsigned long *bmap, u64 *val, int count);
> > +int idxd_load_iaa_device_defaults(struct idxd_device *idxd);
> > =C2=A0
> > =C2=A0/* device interrupt control */
> > =C2=A0irqreturn_t idxd_misc_thread(int vec, void *data);
> > diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> > index 0eb1c827a215..14df1f1347a8 100644
> > --- a/drivers/dma/idxd/init.c
> > +++ b/drivers/dma/idxd/init.c
> > @@ -59,6 +59,7 @@ static struct idxd_driver_data idxd_driver_data[]
> > =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.evl_cr_off =3D offsetof(struct iax_evl_entry, c=
r),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.cr_status_off =3D offsetof(struct
> > iax_completion_record, status),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.cr_result_off =3D offsetof(struct
> > iax_completion_record, error_code),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0.load_device_defaults =3D
> > idxd_load_iaa_device_defaults,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > =C2=A0};
> > =C2=A0
> > @@ -745,6 +746,12 @@ static int idxd_pci_probe(struct pci_dev
> > *pdev, const struct pci_device_id *id)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0goto err;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (data->load_device_defaul=
ts) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0rc =3D data->load_device_defaults(idxd);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (rc)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_wa=
rn(dev, "IDXD loading device defaults
> > failed\n");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rc =3D idxd_register_de=
vices(idxd);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_err(dev, "IDXD sysfs setup failed\n");


