Return-Path: <dmaengine+bounces-5272-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBB6AC5F49
	for <lists+dmaengine@lfdr.de>; Wed, 28 May 2025 04:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E58B54A4149
	for <lists+dmaengine@lfdr.de>; Wed, 28 May 2025 02:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE76C1DFDA1;
	Wed, 28 May 2025 02:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T/nXJ8nx"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A4D1C1ADB
	for <dmaengine@vger.kernel.org>; Wed, 28 May 2025 02:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748398925; cv=none; b=FR+fafA6vbBOTo9LJ6RZhXuVlYyvYja5gqAV4Nhf2ak4crVUwl/wCFoagCTLPRv9nIZt+UBhbwv7ab/hYc5hd+BvD6WzfaDEW8V/HyxWisrkOCXxwd7G11cb2IklqwkdiBDQ1iInY1QZZGsYHGNPBCIVXBWiU3jq6B5xOK3Fw+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748398925; c=relaxed/simple;
	bh=ucm4GbNSTF4Jo/Zx+SwkrhZglHvbW6OqOCQj5TVSQxI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V6zWtQ3jlShBse7Dye7GAGrDysZMbT3eLDRno8JrO82hKNJoRm/xUcqpC64z0LdryUQB5mfeI2tBoRq13+9Msa+AgKrrsWNPvKVlHlJDOsv53OpjViIagCBdZNBnXGyICrN+z5K4rN6qDGq5UIrMQyvZqqqdwOPyDe6d4Lg+vwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T/nXJ8nx; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748398924; x=1779934924;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=ucm4GbNSTF4Jo/Zx+SwkrhZglHvbW6OqOCQj5TVSQxI=;
  b=T/nXJ8nxHTXXIQjoOm+zRVld9/qv/sH8EXiYuMXjjv1fGiQYGt0T9Qni
   KwUI1HWAUqQyTxpqRWp23bd/SYPIdM0iXgdPMd5vgfZRBkpTttKxuirnu
   fYHpnJVs1kJU68U81KBli62BUib5TXm+efWBUTf+el24skjiKGtLS4roZ
   tH9RTCVpk0QRq8TZo803Odqk99/bWBrZi6M5HKMT3ANA2Nh1N7K307MTR
   Exk1EposhuM8shahFt+V4xwTVUEiQ8zj/7Kz/5iulJeYcVwi5v9vxuVcx
   MYE7Bd/OPo9wBb8nhFrhxyWAZvyc11bnigAq4llPQlKRe4c8UaPkhq5bF
   g==;
X-CSE-ConnectionGUID: 17cPgsQDQTyNOlleruPw8Q==
X-CSE-MsgGUID: Vrq4DLaTTtSgYfbCkpumOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50336291"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="50336291"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 19:22:03 -0700
X-CSE-ConnectionGUID: WewVpHKpRNW1lRBnUHCLJQ==
X-CSE-MsgGUID: e+2EdGqVQVq84Y91mMC1RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="148205715"
Received: from unknown (HELO vcostago-mobl3) ([10.241.225.218])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 19:22:03 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Dave Jiang <dave.jiang@intel.com>, "Colin King
 (gmail)" <colin.i.king@gmail.com>
Cc: dmaengine@vger.kernel.org
Subject: Re: [bug report] dmaengine: idxd: fix memory leak in error handling
 path of idxd_setup_wqs
In-Reply-To: <08b98863-4700-40a6-b8a9-1ed305a57d8e@linux.alibaba.com>
References: <aDQt3_rZjX-VuHJW@stanley.mountain>
 <08b98863-4700-40a6-b8a9-1ed305a57d8e@linux.alibaba.com>
Date: Tue, 27 May 2025 19:22:02 -0700
Message-ID: <87zfexa305.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Shuai,

Shuai Xue <xueshuai@linux.alibaba.com> writes:

> =E5=9C=A8 2025/5/26 17:01, Dan Carpenter =E5=86=99=E9=81=93:
>> Hello Shuai Xue,
>>=20
>> Commit 3fd2f4bc010c ("dmaengine: idxd: fix memory leak in error
>> handling path of idxd_setup_wqs") from Apr 4, 2025 (linux-next),
>> leads to the following Smatch static checker warning:
>>=20
>> 	drivers/dma/idxd/init.c:246 idxd_setup_wqs()
>> 	error: uninitialized symbol 'conf_dev'.
>>=20
>> drivers/dma/idxd/init.c
>>      177 static int idxd_setup_wqs(struct idxd_device *idxd)
>>      178 {
>>      179         struct device *dev =3D &idxd->pdev->dev;
>>      180         struct idxd_wq *wq;
>>      181         struct device *conf_dev;
>>      182         int i, rc;
>>      183
>>      184         idxd->wqs =3D kcalloc_node(idxd->max_wqs, sizeof(struct=
 idxd_wq *),
>>      185                                  GFP_KERNEL, dev_to_node(dev));
>>      186         if (!idxd->wqs)
>>      187                 return -ENOMEM;
>>      188
>>      189         idxd->wq_enable_map =3D bitmap_zalloc_node(idxd->max_wq=
s, GFP_KERNEL, dev_to_node(dev));
>>      190         if (!idxd->wq_enable_map) {
>>      191                 rc =3D -ENOMEM;
>>      192                 goto err_bitmap;
>>      193         }
>>      194
>>      195         for (i =3D 0; i < idxd->max_wqs; i++) {
>>      196                 wq =3D kzalloc_node(sizeof(*wq), GFP_KERNEL, de=
v_to_node(dev));
>>      197                 if (!wq) {
>>      198                         rc =3D -ENOMEM;
>>      199                         goto err;
>>=20
>> On this error path we either free an uninitialized variable or we
>> double free conf_dev.
>
> Hi, Dan,
>
> Thanks for reporting this bug:)
>
> It has reported by Colin but he forgot to cc mailing list.
> And I sent a patch to fix it:
> https://lore.kernel.org/lkml/19668a72-c523-42ab-87ac-990a4baac214@intel.c=
om/
>
>>=20
>>      200                 }
>>      201
>>      202                 idxd_dev_set_type(&wq->idxd_dev, IDXD_DEV_WQ);
>>      203                 conf_dev =3D wq_confdev(wq);
>>      204                 wq->id =3D i;
>>      205                 wq->idxd =3D idxd;
>>      206                 device_initialize(wq_confdev(wq));
>>      207                 conf_dev->parent =3D idxd_confdev(idxd);
>>      208                 conf_dev->bus =3D &dsa_bus_type;
>>      209                 conf_dev->type =3D &idxd_wq_device_type;
>>      210                 rc =3D dev_set_name(conf_dev, "wq%d.%d", idxd->=
id, wq->id);
>>      211                 if (rc < 0)
>>      212                         goto err;
>>=20
>> When we're cleaning up loops what I recommend is that we clean up the
>> partial iterations before the goto.
>>=20
>> 		if (rc < 0) {
>> 			put_device(conf_dev);
>> 			kfree(wq);
>> 			goto unwind_loop;
>> 		}
>>=20
>> That's sort of how the code was written originally but it missed some
>> frees.
>>=20
>>=20
>>      213
>>      214                 mutex_init(&wq->wq_lock);
>>      215                 init_waitqueue_head(&wq->err_queue);
>>      216                 init_completion(&wq->wq_dead);
>>      217                 init_completion(&wq->wq_resurrect);
>>      218                 wq->max_xfer_bytes =3D WQ_DEFAULT_MAX_XFER;
>>      219                 idxd_wq_set_max_batch_size(idxd->data->type, wq=
, WQ_DEFAULT_MAX_BATCH);
>>      220                 wq->enqcmds_retries =3D IDXD_ENQCMDS_RETRIES;
>>      221                 wq->wqcfg =3D kzalloc_node(idxd->wqcfg_size, GF=
P_KERNEL, dev_to_node(dev));
>>      222                 if (!wq->wqcfg) {
>>      223                         rc =3D -ENOMEM;
>>      224                         goto err;
>>      225                 }
>>=20
>> Same:
>>=20
>> 		if (!wq->wqcfg) {
>> 			put_device(conf_dev);
>> 			kfree(wq);
>> 			rc =3D -ENOMEM;
>> 			goto unwind_loop;
>> 		}
>>=20
>>      226
>>      227                 if (idxd->hw.wq_cap.op_config) {
>>      228                         wq->opcap_bmap =3D bitmap_zalloc(IDXD_M=
AX_OPCAP_BITS, GFP_KERNEL);
>>      229                         if (!wq->opcap_bmap) {
>>      230                                 rc =3D -ENOMEM;
>>      231                                 goto err_opcap_bmap;
>>      232                         }
>>=20
>> 		if (!wq->wqcfg) {
>> 			kfree(wq->wqcfg);
>> 			put_device(conf_dev);
>> 			kfree(wq);
>> 			rc =3D -ENOMEM;
>> 			goto unwind_loop;
>> 		}
>>=20
>>=20
>>      233                         bitmap_copy(wq->opcap_bmap, idxd->opcap=
_bmap, IDXD_MAX_OPCAP_BITS);
>>      234                 }
>>      235                 mutex_init(&wq->uc_lock);
>>      236                 xa_init(&wq->upasid_xa);
>>      237                 idxd->wqs[i] =3D wq;
>>      238         }
>>      239
>>=20
>> Imagine if we add another two allocations here.
>>=20
>> 		foo =3D alloc();
>> 		if (!foo)
>> 			goto err;
>> 		bar =3D alloc();
>> 		if (!bar)
>> 			goto free_foo;
>>=20
>>=20
>>      240         return 0;
>>      241
>>=20
>> Then we have to do a little bunny hop.
>>=20
>> free_foo:
>> 	free(foo);
>> 	goto err; // <-- bunny hop
>>=20
>> err_opcap_bmap:
>> 	kfree(wq->wqcfg);
>>=20
>> People often get confused and forget the bunny hop.
>
> I think so, this is the way I used in the original patch I send.
> but reviewer Markus point to move common free code to additional
> jump targets.
>
> https://lore.kernel.org/lkml/98327a4d-7684-4908-9d67-5dfcaa229ae1@web.de/
>
> I feel free to change back to clean up the partial iterations before the =
goto.
> @Dave, which way do you like?
>
> (Dave is on vacation, I can send a new patch if he prefer the latter way)
>

I think the solution you proposed is fine. At least to me, it looks clear
enough and seems to fix the problem.

>>=20
>>      242 err_opcap_bmap:
>>      243         kfree(wq->wqcfg);
>>      244
>>      245 err:
>> --> 246         put_device(conf_dev);
>>      247         kfree(wq);
>>      248
>>      249         while (--i >=3D 0) {
>>      250                 wq =3D idxd->wqs[i];
>>      251                 if (idxd->hw.wq_cap.op_config)
>>      252                         bitmap_free(wq->opcap_bmap);
>>      253                 kfree(wq->wqcfg);
>>      254                 conf_dev =3D wq_confdev(wq);
>>      255                 put_device(conf_dev);
>>      256                 kfree(wq);
>>      257
>>      258         }
>>      259         bitmap_free(idxd->wq_enable_map);
>>      260
>>      261 err_bitmap:
>>      262         kfree(idxd->wqs);
>>      263
>>      264         return rc;
>>      265 }
>>=20
>> regards,
>> dan carpenter
>
>
> Thanks.
>
> Regards
> Shuai


Cheers,
--=20
Vinicius

