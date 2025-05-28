Return-Path: <dmaengine+bounces-5271-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F978AC5F46
	for <lists+dmaengine@lfdr.de>; Wed, 28 May 2025 04:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480DE1890AE7
	for <lists+dmaengine@lfdr.de>; Wed, 28 May 2025 02:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9991DDA09;
	Wed, 28 May 2025 02:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M9TdeUvL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5453137932;
	Wed, 28 May 2025 02:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748398912; cv=none; b=bBm4ZA9DuJJ1T5ChzVKS2y4C1BCSzMTPSVb9aT91+y5dqcN+q/ZxORGMyDHqZufN0gTSf5xYwQj4qDPD63IffPzeWWuIm2S8L3aeTZvya4U6Bn1iOYKhkjISKJ14TN6OioJj8RItil701FNHxXqQR1pcdanuhKMoZlYBc1NrEKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748398912; c=relaxed/simple;
	bh=qb3jRL/0E3NrKIW9DVamyFCMdvGUtKYDx0GQpM67T8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DiXR1IeEVfsbovmd1u787zcIX0XclNRGOZQCtarLAUDmawdw0mxFoDrEPIupLqDIugQHtgUciUI27HFAmKl85NlbQHiyW0HnoJJQos2DJNscoQQTiqt+VTW5b6Q5H+/JvR3LWvFPV7E2p4MEmuEk2SOp/eSUSmBfsypwHIrle+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M9TdeUvL; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748398909; x=1779934909;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=qb3jRL/0E3NrKIW9DVamyFCMdvGUtKYDx0GQpM67T8c=;
  b=M9TdeUvL80JuAh0hFZ0cQuLJV5P659BWOYR9O8stYAhX8yYN3CObZppE
   q9wvwtfWO9GbHqY7JN08uZJ7bE7slBwCBsht0cP9/xmlD921vfgDQQlTB
   MU18vchZparZ/0z5ub51zxC/7L8dRc506Elt8bbaQLDyPe98lHIzxwkC+
   JKTSKQ5ggAKmAE0l7QsY4LoQXJExLImDAyPunO3NRXLrjQEnJrsyEhwsm
   KsJAVkClEDXjabrBIbKWFH5tvxOAyHekDLjRPo56A/7liZEQQCJyOyTXy
   1i5jQyH/+5AlOPaU2KPGVGNU1HoRuUeyum01J+8m54Ih88AVvvKGH7EyK
   A==;
X-CSE-ConnectionGUID: zkHycBu+SoWSDEsoF+wq1g==
X-CSE-MsgGUID: D54U6OvqRfCkcqo5GB0xkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="60663691"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="60663691"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 19:21:49 -0700
X-CSE-ConnectionGUID: uZa9ILcfQcamj6NR0ldV8A==
X-CSE-MsgGUID: PkzsLG17S5GoUTZwnFJeaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="142991895"
Received: from unknown (HELO vcostago-mobl3) ([10.241.225.218])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 19:21:49 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>, Dave Jiang
 <dave.jiang@intel.com>, fenghuay@nvidia.com, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, colin.i.king@gmail.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dmaengine: idxd: Fix race condition between WQ
 enable and reset paths
In-Reply-To: <87234fab-081e-4e2e-9ef1-0414b23601ce@linux.alibaba.com>
References: <20250522063329.51156-1-xueshuai@linux.alibaba.com>
 <20250522063329.51156-2-xueshuai@linux.alibaba.com>
 <a03e4f97-2289-4af7-8bfc-ad2d38ec8677@intel.com>
 <b2153756-a57e-4054-bde2-deb8865c9e59@linux.alibaba.com>
 <4cd53b91-bd20-46a1-854c-9bf0950ea496@intel.com>
 <87234fab-081e-4e2e-9ef1-0414b23601ce@linux.alibaba.com>
Date: Tue, 27 May 2025 19:21:48 -0700
Message-ID: <874ix5bhkz.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Shuai Xue <xueshuai@linux.alibaba.com> writes:

> =E5=9C=A8 2025/5/23 22:54, Dave Jiang =E5=86=99=E9=81=93:
>>=20
>>=20
>> On 5/22/25 10:20 PM, Shuai Xue wrote:
>>>
>>>
>>> =E5=9C=A8 2025/5/22 22:55, Dave Jiang =E5=86=99=E9=81=93:
>>>>
>>>>
>>>> On 5/21/25 11:33 PM, Shuai Xue wrote:
>>>>> A device reset command disables all WQs in hardware. If issued while =
a WQ
>>>>> is being enabled, it can cause a mismatch between the software and ha=
rdware
>>>>> states.
>>>>>
>>>>> When a hardware error occurs, the IDXD driver calls idxd_device_reset=
() to
>>>>> send a reset command and clear the state (wq->state) of all WQs. It t=
hen
>>>>> uses wq_enable_map (a bitmask tracking enabled WQs) to re-enable them=
 and
>>>>> ensure consistency between the software and hardware states.
>>>>>
>>>>> However, a race condition exists between the WQ enable path and the
>>>>> reset/recovery path. For example:
>>>>>
>>>>> A: WQ enable path=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 B: Reset and reco=
very path
>>>>> ------------------=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ------------------------
>>>>> a1. issue IDXD_CMD_ENABLE_WQ
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b1. i=
ssue IDXD_CMD_RESET_DEVICE
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b2. c=
lear wq->state
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b3. c=
heck wq_enable_map bit, not set
>>>>> a2. set wq->state =3D IDXD_WQ_ENABLED
>>>>> a3. set wq_enable_map
>>>>>
>>>>> In this case, b1 issues a reset command that disables all WQs in hard=
ware.
>>>>> Since b3 checks wq_enable_map before a2, it doesn't re-enable the WQ,
>>>>> leading to an inconsistency between wq->state (software) and the actu=
al
>>>>> hardware state (IDXD_WQ_DISABLED).
>>>>
>>>>
>>>> Would it lessen the complication to just have wq enable path grab the =
device lock before proceeding?
>>>>
>>>> DJ
>>>
>>> Yep, how about add a spin lock to enable wq and reset device path.
>>>
>>> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
>>> index 38633ec5b60e..c0dc904b2a94 100644
>>> --- a/drivers/dma/idxd/device.c
>>> +++ b/drivers/dma/idxd/device.c
>>> @@ -203,6 +203,29 @@ int idxd_wq_enable(struct idxd_wq *wq)
>>>  =C2=A0}
>>>  =C2=A0EXPORT_SYMBOL_GPL(idxd_wq_enable);
>>>=20=20=20
>>> +/*
>>> + * This function enables a WQ in hareware and updates the driver maint=
ained
>>> + * wq->state to IDXD_WQ_ENABLED. It should be called with the dev_lock=
 held
>>> + * to prevent race conditions with IDXD_CMD_RESET_DEVICE, which could
>>> + * otherwise disable the WQ without the driver's state being properly
>>> + * updated.
>>> + *
>>> + * For IDXD_CMD_DISABLE_DEVICE, this function is safe because it is on=
ly
>>> + * called after the WQ has been explicitly disabled, so no concurrency
>>> + * issues arise.
>>> + */
>>> +int idxd_wq_enable_locked(struct idxd_wq *wq)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct idxd_device *idxd =3D wq->=
idxd;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&idxd->dev_lock);
>>=20
>> Let's start using the new cleanup macro going forward:
>> guard(spinlock)(&idxd->dev_lock);
>>=20
>> On a side note, there's been a cleanup on my mind WRT this driver's lock=
ing. I think we can replace idxd->dev_lock with idxd_confdev(idxd) device l=
ock. You can end up just do:
>> guard(device)(idxd_confdev(idxd));
>
> Then we need to replace the lock from spinlock to mutex lock?

We still need a (spin) lock that we could hold in interrupt contexts.

>
>>=20
>> And also drop the wq->wq_lock and replace with wq_confdev(wq) device loc=
k:
>> guard(device)(wq_confdev(wq));
>>=20
>> If you are up for it that is.
>
> We creates a hierarchy: pdev -> idxd device -> wq device.
> idxd_confdev(idxd) is the parent of wq_confdev(wq) because:
>
>      (wq_confdev(wq))->parent =3D idxd_confdev(idxd);
>
> Is it safe to grap lock of idxd_confdev(idxd) under hold
> lock of wq_confdev(wq)?
>
> We have mounts of code use spinlock of idxd->dev_lock under
> hold of wq->wq_lock.
>

I agree with Dave that the locking could be simplified, but I don't
think that we should hold this series because of that. That
simplification can be done later.

>>=20
>>=20
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D idxd_wq_enable_locked(wq);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&idxd->dev_lock);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> +}
>>> +
>>>  =C2=A0int idxd_wq_disable(struct idxd_wq *wq, bool reset_config)
>>>  =C2=A0{
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct idxd_device *idxd =
=3D wq->idxd;
>>> @@ -330,7 +353,7 @@ int idxd_wq_set_pasid(struct idxd_wq *wq, int pasid)
>>>=20=20=20
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __idxd_wq_set_pasid_locked(=
wq, pasid);
>>>=20=20=20
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D idxd_wq_enable(wq);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D idxd_wq_enable_locked(wq);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc < 0)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return rc;
>>>=20=20=20
>>> @@ -380,7 +403,7 @@ int idxd_wq_disable_pasid(struct idxd_wq *wq)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iowrite32(wqcfg.bits[WQCFG_=
PASID_IDX], idxd->reg_base + offset);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&idxd->dev_lock=
);
>>>=20=20=20
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D idxd_wq_enable(wq);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D idxd_wq_enable_locked(wq);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc < 0)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return rc;
>>>=20=20=20
>>> @@ -644,7 +667,11 @@ int idxd_device_disable(struct idxd_device *idxd)
>>>=20=20=20
>>>  =C2=A0void idxd_device_reset(struct idxd_device *idxd)
>>>  =C2=A0{
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&idxd->dev_lock);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 idxd_cmd_exec(idxd, IDXD_CM=
D_RESET_DEVICE, 0, NULL);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&idxd->dev_lock);
>>> +
>>>
>>=20
>> I think you just need the wq_enable locked and also in idxd_device_clear=
_state(), extend the lock to the whole function. Locking the reset function=
 around just the command execute won't protect the wq enable path against t=
he changing of the software states on the reset side.
>
> Quite agreed.
>
>>=20
>> DJ
>>=20
>>> (The dev_lock should also apply to idxd_wq_enable(), I did not paste he=
re)
>>>
>>> Also, I found a new bug that idxd_device_config() is called without
>>> hold idxd->dev_lock.
>>>> idxd_device_config() explictly asserts the hold of idxd->dev_lock.
>>>
>>> +++ b/drivers/dma/idxd/irq.c
>>> @@ -33,12 +33,17 @@ static void idxd_device_reinit(struct work_struct *=
work)
>>>  =C2=A0{
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct idxd_device *idxd =
=3D container_of(work, struct idxd_device, work);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D &idx=
d->pdev->dev;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int rc, i;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int rc =3D 0, i;
>>>=20=20=20
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 idxd_device_reset(idxd);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D idxd_device_config(idxd);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc < 0)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&idxd->dev_lock);
>> I wonder if you should also just lock the idxd_device_reset() and the id=
xd_device_enable() as well in this case as you don't anything to interfere =
with the entire reinit path.
>
> During reset, any operation to enable wq should indeed be avoided,
> but there isn't a suitable lock currently. idxd->dev_lock is a
> lightweight lock, only used when updating the device state, and
> it's used while holding wq->wq_lock. Therefore, holding idxd->dev_lock
> currently cannot form mutual exclusion with wq->wq_lock.
>
> And the sub caller of idxd_device_reset(), e.g. idxd_device_clear_state()
> also spins to hold idxd->dev_lock.
>
> A hack way it to grab wq_lock of all wqs before before reinit, but
> this is hardly elegant (:
>
> Thanks.
> Have a nice holiday!
>
> Best regards,
> Shuai
>


Cheers,
--=20
Vinicius

