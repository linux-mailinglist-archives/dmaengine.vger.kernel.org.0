Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AD574E036
	for <lists+dmaengine@lfdr.de>; Mon, 10 Jul 2023 23:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjGJV2P (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Jul 2023 17:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjGJV2O (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Jul 2023 17:28:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F82DE;
        Mon, 10 Jul 2023 14:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689024493; x=1720560493;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=0qkWoxl+0canLRzNJ94V2V3aItW8Yk1wz+ICURPIxH4=;
  b=G/ymhnV+CoUBRd5IBgbrMSXUs3qT8Pdi8iViGEBH3WOhYPW639KVjlfO
   fIQjPi8n/Q/lJIArm52fM/sKpJHVK0iqYaP+CsMvpUghA0IHY2g8Ssakf
   5DFrZMuMek1jEwDPdAx6W1yt0YXVUzUzocQPrFmpGYO2rx++37kje8d+x
   /MlQ65r6IBQQ/H4fpMIja8qc0hXbczz8uiuWwR+fEhG2nFsrxMfXD5N57
   IvVqcSHfjsk1jJ9wKsi+OSFDtCmwzECjJuNkRW3JNTrokyKBUumM2gDEU
   7piOwk29Z92dbAsztOujhnHCJl7Q4BVXzmnSCEjILnhZtPkbm3HqtHVSd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="354321747"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="354321747"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 14:28:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="967554592"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="967554592"
Received: from britta5x-mobl1.amr.corp.intel.com ([10.212.44.7])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 14:28:11 -0700
Message-ID: <60b70751a1a1ad786f534ca0b7fd3cc423736f0a.camel@linux.intel.com>
Subject: Re: [PATCH] dmaengine:idxd: Use local64_try_cmpxchg in
 perfmon_pmu_event_update
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, Uros Bizjak <ubizjak@gmail.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Date:   Mon, 10 Jul 2023 16:28:10 -0500
In-Reply-To: <e816aa75-4588-dae4-2d01-6f5ba9d4a4f3@intel.com>
References: <20230703145346.5206-1-ubizjak@gmail.com>
         <e816aa75-4588-dae4-2d01-6f5ba9d4a4f3@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 2023-07-05 at 07:53 -0700, Dave Jiang wrote:
>=20
>=20
> On 7/3/23 07:52, Uros Bizjak wrote:
> > Use local64_try_cmpxchg instead of local64_cmpxchg (*ptr, old, new) =3D=
=3D old
> > in perfmon_pmu_event_update.=C2=A0 x86 CMPXCHG instruction returns succ=
ess in
> > ZF flag, so this change saves a compare after cmpxchg (and related move
> > instruction in front of cmpxchg).
> >=20
> > Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxc=
hg
> > fails. There is no need to re-read the value in the loop.
> >=20
> > No functional change intended.
> >=20
> > Cc: Fenghua Yu <fenghua.yu@intel.com>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
>=20
>=20
> Cc: Tom Zanussi
>=20
> Tom do you mind review this patch? Thanks!

Looks fine to me.

Thanks,

Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>

>=20
> > ---
> > =C2=A0 drivers/dma/idxd/perfmon.c | 7 +++----
> > =C2=A0 1 file changed, 3 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/dma/idxd/perfmon.c b/drivers/dma/idxd/perfmon.c
> > index d73004f47cf4..fdda6d604262 100644
> > --- a/drivers/dma/idxd/perfmon.c
> > +++ b/drivers/dma/idxd/perfmon.c
> > @@ -245,12 +245,11 @@ static void perfmon_pmu_event_update(struct perf_=
event *event)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int shift =3D 64 - idxd=
->idxd_pmu->counter_width;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct hw_perf_event *h=
wc =3D &event->hw;
> > =C2=A0=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prev_raw_count =3D local64_r=
ead(&hwc->prev_count);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0do {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0prev_raw_count =3D local64_read(&hwc->prev_count);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0new_raw_count =3D perfmon_pmu_read_counter(event=
);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} while (local64_cmpxchg(&hw=
c->prev_count, prev_raw_count,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0new_ra=
w_count) !=3D prev_raw_count);
> > -
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} while (!local64_try_cmpxch=
g(&hwc->prev_count,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &p=
rev_raw_count, new_raw_count));
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0n =3D (new_raw_count <<=
 shift);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0p =3D (prev_raw_count <=
< shift);
> > =C2=A0=20

