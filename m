Return-Path: <dmaengine+bounces-4810-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EACB2A799C5
	for <lists+dmaengine@lfdr.de>; Thu,  3 Apr 2025 03:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C73C188C4C3
	for <lists+dmaengine@lfdr.de>; Thu,  3 Apr 2025 01:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB1B136E37;
	Thu,  3 Apr 2025 01:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JaBcBIt/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B096326AFB;
	Thu,  3 Apr 2025 01:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743644342; cv=none; b=Z93dZPPDXFBn0afA+tUWUGRqg9YreaUrQU5MVZ6BC1PDihL2ty9xWTbUavGRXmkcJO+2vb+2eWY1zSL8NjuiznZq4wJ96FWmDJbU65Yt3IZTSbN+zLMpV1HVteFEYTFzN4Jb3ptF3EMYvTAy3HW4aweIK2LxXw4hYkMNNLmE6eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743644342; c=relaxed/simple;
	bh=L+LOVKg8rjqy6R1x3DVxd//2w0iclMYWlpzEp/RzccY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WFDjyk4oTHipmYIrqCiv6t3FXd/tSu2Bmxv6T0vMIIgNFvLnxJhWLWqrS8LjfVs/7d3ktBZtgHljwPI7DHts7d0W0I9VDRNJ+2BKVwx5wuOS+Tu+997YserbZb4oL18wjsFweM25F3sVfUZERV8yQzjK/I0vsmEzLnLnR9HoPT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JaBcBIt/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743644340; x=1775180340;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=L+LOVKg8rjqy6R1x3DVxd//2w0iclMYWlpzEp/RzccY=;
  b=JaBcBIt/u86jFzPm3r3yrthivvyv1g7DZqkKw60wnMqt7pW3vJca4s1h
   4PUzN5bjOVDpJhD/pr2dmydetRq6YiQl59xnQOzSdgS18CMT/ONOTAtrw
   IJoRHasBkzVUyoPhqHR2bVcQc2E8v01vs3pwIX+EEUt2m5Gi7rEfUQxFc
   H4WbhKYtUaMhL2zvZRJkTK76LE9+j8HPRSeUmmd4J15K5etjYCt5by5F3
   3G5gxZBhMvGiY+ANHlQ+3n2G/u9fJip1GqfbFiXh9UghxjqPUOFEveCqJ
   pFsp1+XKmB3xEwp1T8n5ZIZOv+cQFMDZ021PDsM0A0GdpSVFpPRna0Xuu
   g==;
X-CSE-ConnectionGUID: dgrDzuz7Te6h6dqc8oaZag==
X-CSE-MsgGUID: UOwg+gsnRASWqkP+aQfW4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44743258"
X-IronPort-AV: E=Sophos;i="6.15,183,1739865600"; 
   d="scan'208";a="44743258"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 18:39:00 -0700
X-CSE-ConnectionGUID: TrY4WBAZTFagp9NMiuG2SA==
X-CSE-MsgGUID: oDx9EIkITT21SkKHOrEtHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,183,1739865600"; 
   d="scan'208";a="127772721"
Received: from unknown (HELO vcostago-mobl3) ([10.241.225.148])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 18:39:00 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Fenghua Yu <fenghuay@nvidia.com>, Dave Jiang <dave.jiang@intel.com>,
 Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: Re: [PATCH v1] dmaengine: idxd: Narrow the restriction on BATCH to
 ver. 1 only
In-Reply-To: <a1b7d7d8-4fc0-4faf-9938-57ccd1b861ab@nvidia.com>
References: <20250312221511.277954-1-vinicius.gomes@intel.com>
 <a1b7d7d8-4fc0-4faf-9938-57ccd1b861ab@nvidia.com>
Date: Wed, 02 Apr 2025 18:38:59 -0700
Message-ID: <87v7rmyqfg.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Fenghua,

Fenghua Yu <fenghuay@nvidia.com> writes:

> Hi, Vinicius,
>
> On 3/12/25 15:15, Vinicius Costa Gomes wrote:
>> Allow BATCH operations to be submitted and the capability to be
>> exposed for DSA version 2 (or later) devices.
>>
>> DSA version 2 devices allow safe submission of BATCH operations.
>>
>> Signed-off-by: Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>
>> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> ---
>>   drivers/dma/idxd/cdev.c  | 6 ++++--
>>   drivers/dma/idxd/sysfs.c | 6 ++++--
>>   2 files changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
>> index ff94ee892339..6a1dc15ee485 100644
>> --- a/drivers/dma/idxd/cdev.c
>> +++ b/drivers/dma/idxd/cdev.c
>> @@ -439,10 +439,12 @@ static int idxd_submit_user_descriptor(struct idxd=
_user_context *ctx,
>>   	 * DSA devices are capable of indirect ("batch") command submission.
>>   	 * On devices where direct user submissions are not safe, we cannot
>>   	 * allow this since there is no good way for us to verify these
>> -	 * indirect commands.
>> +	 * indirect commands. Narrow the restriction of operations with the
>> +	 * BATCH opcode to only DSA version 1 devices.
>>   	 */
>>   	if (is_dsa_dev(idxd_dev) && descriptor.opcode =3D=3D DSA_OPCODE_BATCH=
 &&
>> -		!wq->idxd->user_submission_safe)
>> +	    wq->idxd->hw.version =3D=3D DEVICE_VERSION_1 &&
>> +	    !wq->idxd->user_submission_safe)
>>   		return -EINVAL;
>>   	/*
>>   	 * As per the programming specification, the completion address must =
be
>> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
>> index 6af493f6ba77..9f0701021af0 100644
>> --- a/drivers/dma/idxd/sysfs.c
>> +++ b/drivers/dma/idxd/sysfs.c
>> @@ -1208,9 +1208,11 @@ static ssize_t op_cap_show_common(struct device *=
dev, char *buf, unsigned long *
>>=20=20=20
>>   		/* On systems where direct user submissions are not safe, we need to=
 clear out
>>   		 * the BATCH capability from the capability mask in sysfs since we c=
annot support
>> -		 * that command on such systems.
>> +		 * that command on such systems. Narrow the restriction of operations=
 with the
>> +		 * BATCH opcode to only DSA version 1 devices.
>>   		 */
>> -		if (i =3D=3D DSA_OPCODE_BATCH/64 && !confdev_to_idxd(dev)->user_submi=
ssion_safe)
>> +		if (i =3D=3D DSA_OPCODE_BATCH/64 && !confdev_to_idxd(dev)->user_submi=
ssion_safe &&
>> +		    confdev_to_idxd(dev)->hw.version =3D=3D DEVICE_VERSION_1)
>>   			clear_bit(DSA_OPCODE_BATCH % 64, &val);
>>=20=20=20
>>   		pos +=3D sysfs_emit_at(buf, pos, "%*pb", 64, &val)
>
> Maybe folder the DEVICE_VERSION_1 check into user_submission_safe variabl=
e?
>
> This way patch is a bit smaller, a bit faster in run-time,=C2=A0 and easi=
er=20
> to be extend in case there are other restriction changes in the future?
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 86075cdc4420..80f95cb815c8 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -1258,7 +1258,8 @@ int idxd_pci_probe_alloc(struct idxd_device *idxd,=
=20
> struct pci_dev *pdev,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 idxd->hw.version);
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (data)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 idxd->user_submission_safe =3D data->user_submission_safe;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 idxd->user_submission_safe =3D data->user_submission_safe |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (idxd->hw.version !=3D=20
> DEVICE_VERSION_1);
>

I don't think so, this would lift the restriction that we have on mmap()
for regular userspace applications.

The reality is that the "only" change is that the submission of
operations with the BATCH opcode is now allowed for regular applications
(via write()) with V2 devices, mmap() should still be restricted.


Cheers,
--=20
Vinicius

