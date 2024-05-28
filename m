Return-Path: <dmaengine+bounces-2185-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFF08D1158
	for <lists+dmaengine@lfdr.de>; Tue, 28 May 2024 03:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4032C2830F6
	for <lists+dmaengine@lfdr.de>; Tue, 28 May 2024 01:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D736D440C;
	Tue, 28 May 2024 01:07:58 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A4B1078F
	for <dmaengine@vger.kernel.org>; Tue, 28 May 2024 01:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716858478; cv=none; b=YrVSgkkny6KubE2Ts5+ulCKTOvxw+JhJYgCAf5lcY6YEM3qkxsCMysU6Y42nJTrHddPQk9ft/g3TntmvKRa7jun8yy0KwmiNLl8Ss/4qggxOIUSL8dZ5z4SYuYgRfzivlk98Tb5RjbGc7E58f84dcNPcnAv8skYScT/U1RDh+MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716858478; c=relaxed/simple;
	bh=jBs+BEPT3DNJ46wlnkfAM+3qXZyiZjD9L1EiDg+gXOM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VAyvGOMylSBsp4PqHO9nmBcT6wC5SCwqMEVPbpA8mYTYmVyGEB6PYeyyF6XQsXAfDrXEPyKl12BmlbeNtsjmvxaPIA9DP1mcwyrmVMHb0UczxH3Yd+8lEORcKF9o/5CrLhcpRpZbpGKQ+WzhF9S2536hsEXOWeYGeoClpvm1oLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: "fenghua.yu@intel.com" <fenghua.yu@intel.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: [PATCH][RFC] dmaengine: idxd: Fix possible Use-After-Free in
 irq_process_work_list
Thread-Topic: [PATCH][RFC] dmaengine: idxd: Fix possible Use-After-Free in
 irq_process_work_list
Thread-Index: AQHar/3Qy6lGGrWqC0CaT4H6iVA4CbGrzJ6A
Date: Tue, 28 May 2024 00:37:05 +0000
Message-ID: <471a0e5718be42ea968085426e9374f4@baidu.com>
References: <20240527061920.48626-1-lirongqing@baidu.com>
In-Reply-To: <20240527061920.48626-1-lirongqing@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.53
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 52:10:53:SYSTEM


> I think when the description is freed, it maybe used again because of rac=
e, then
> it's next maybe pointer a value that should not be freed
>=20
> To prevent this, list_for_each_entry_safe should be used.
>=20

Rewrite the commit header:

    dmaengine: idxd: Fix possible Use-After-Free in irq_process_work_list

    The description has been freed in idxd_desc_complete(), should not be u=
sed
    in iteration, so replace list_for_each_entry with list_for_each_entry_s=
afe
    to prevent the accessing

    Signed-off-by: Li RongQing <lirongqing@baidu.com>


> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/dma/idxd/irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c index
> 8dc029c..0c7fed7 100644
> --- a/drivers/dma/idxd/irq.c
> +++ b/drivers/dma/idxd/irq.c
> @@ -611,7 +611,7 @@ static void irq_process_work_list(struct idxd_irq_ent=
ry
> *irq_entry)
>=20
>  	spin_unlock(&irq_entry->list_lock);
>=20
> -	list_for_each_entry(desc, &flist, list) {
> +	list_for_each_entry_safe(desc, n, &flist, list) {
>  		/*
>  		 * Check against the original status as ABORT is software defined
>  		 * and 0xff, which DSA_COMP_STATUS_MASK can mask out.
> --
> 2.9.4


