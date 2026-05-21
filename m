Return-Path: <dmaengine+bounces-10699-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ie26FPg3D2rTHwYAu9opvQ
	(envelope-from <dmaengine+bounces-10699-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:51:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9745A99D7
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C1323336ED3
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 16:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582C337C0E6;
	Thu, 21 May 2026 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="RFfFsvXO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE2337DAB3;
	Thu, 21 May 2026 16:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380607; cv=none; b=mwf0VSbE0hisCyBlW3sSquiWPGywcP6GdC+OkT2MAYgXil3fiE72j3CtGP9Wzt9SIYzU4xQLb8w2kanmT2cegRsHoJuiYpsnf8DUWNLSlUm7+fp9cHVHIizi/EW76aR7Okql7F1I3PE9b0js4Qi8FDRCzAutmw3eaOJpf1UMygU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380607; c=relaxed/simple;
	bh=dRyEpS7/jLenOpax2KBuKvElXGgPQzwvre+AudyPlq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brFkJQP6Tv9aMhKuq5v5qYtmow/Q8rgbRRhR3Ghk17UxU99kXgM6UYilOOqkdj6cyRJ0VRq4CDeV+k9HmCRNri8oli9TgP1IU929pbOVYAhGRd+057gdi0/28pRQXBjgWtXWPYzMcY9YT+sBGFSueBohZ007YYr8ktcHmFB6+yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=RFfFsvXO; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LGG3N94045411;
	Thu, 21 May 2026 16:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=R85p5o5WOfj5qcGSHbaji46YKN
	X/cLDpL8V7o6wqJFM=; b=RFfFsvXOpbv1fBC63Q1YcziY2u2RZsLVEkKKMaZzGk
	jdOGteWZrVl3NZh9IUT+SOeiSrg5snmZVI3HvmdW4xzzDRaMbiHUgQ7+pHYecsSv
	N9C3xuxE5GWHNSmmUZs9N/pOs4DT8DjaDT8Wd+B8IQouck9F9ngkYKw/G43cd/Mq
	sZsfhYyaNDdbZWwgzZE5Qy4lXLFOS7T7Ui6QwoLpLl70jGMY42oXymLXwODqYaXH
	F05t0xX6/ZPD9SeKj8TciSvu7h+TWxqr5LqBitST05+cQ/pk09aMOPvDmuTFMi4q
	yO5Z5kOlFXCbRonmyIvlGuWWjtANskrdtDP6v5wRJPEA==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4ea5dyr2nh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 16:23:20 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 5FF101318C;
	Thu, 21 May 2026 16:23:20 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id A5AB4803DB3;
	Thu, 21 May 2026 16:23:19 +0000 (UTC)
Date: Thu, 21 May 2026 11:23:18 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Steve Wahl <steve.wahl@hpe.com>, Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH] dmaengine: idxd: fix problems on initialization error
 path.
Message-ID: <ag8xdgtBbgQ3OLek@swahl-home.5wahls.com>
References: <20260520143732.119407-1-steve.wahl@hpe.com>
 <878q9du9k4.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878q9du9k4.fsf@intel.com>
X-Proofpoint-ORIG-GUID: jk2SN3hh6W8-Hp5-2C9OKga9vkvh5655
X-Authority-Analysis: v=2.4 cv=bd9bluPB c=1 sm=1 tr=0 ts=6a0f3178 cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gQcMVamqm3wCPoSYhaRC:22 a=NCWKwCw8Xy9Og0ibBRsL:22 a=MvuuwTCpAAAA:8
 a=yUV34dKJdjJyaZkkQE0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: jk2SN3hh6W8-Hp5-2C9OKga9vkvh5655
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE2NCBTYWx0ZWRfX8V2hrGRrp9V8
 DyoVkl8Sao6v7L+eXRFkIHFKhWp1IrwrNlz/FLAvk3AIl8d0SZZW0zTZhBivYM+h/dr7mbG8ACU
 68ndVjF+RaVCm4ElUSN4ENVD88/UhmKWCBuZuHq6WQPrPtzIXCS6fxZ0qwCk3Czy9oMdOf8V9gb
 MLOzRZW3sZXTC+m9Cf9412zRER43A+IsJYgGNlj+HL3JRkdT6Qmb9VH4RfxlkJU93lnSuRRMjC9
 KcWys5mrkvGgA1YBmc2zZGQAC0DJQz5p8DFBGjAP69S9PAYKkt8mjsso91fFE0kLNIeawfGnFY1
 b1k2icI4GsACw7WhL98HqrSziQWcgdlOvlxyi6/odpp4FSzAL3dU6cEJpl7VopGrFjTdDOCvtYy
 5hBDC9c6U7kC3tzdOGVw1eD2OGBVhIPSXdPxAsTvQXxu//LaehurB3A1P2Ne/s9R7nzCgSO6ujU
 guNWFOHRMz2AKa1WxUQ==
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210164
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[hpe.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10699-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,hpe.com:email,hpe.com:dkim];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steve.wahl@hpe.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6D9745A99D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 01:10:03PM -0700, Vinicius Costa Gomes wrote:
> Hi Steve,
> 
> Steve Wahl <steve.wahl@hpe.com> writes:
> 
> > Some error paths within idxd_pci_probe_alloc and functions it calls
> > did not keep proper track of what has already been allocated or freed,
> > resulting in calling destroy_workqueue with a null pointer, and once
> > that was fixed, attempting to free structures more than once.  These
> > conditions were hit running in a kexec'd kdump kernel with reduced
> > resources, causing the "Device is HALTED!" branch in
> > idxd_device_init_reset to be taken.
> >
> > In idxd_conf_device_release, check that the workqueue has been
> > allocated before trying to destroy it.  And in idxd_free and
> > idxd_alloc, do not attempt to free allocations that
> > idxd_conf_device_release, called through put_device, will already have
> > freed.
> >
> > Fixes: 3d33de353b1f ("dmaengine: idxd: Fix not releasing workqueue on .release()")
> >
> > Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> > ---
> >  drivers/dma/idxd/init.c  | 10 ++++++----
> >  drivers/dma/idxd/sysfs.c |  3 ++-
> >  2 files changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> > index f1cfc7790d95..227e323cc5a0 100644
> > --- a/drivers/dma/idxd/init.c
> > +++ b/drivers/dma/idxd/init.c
> > @@ -607,9 +607,6 @@ static void idxd_free(struct idxd_device *idxd)
> >  		return;
> >  
> >  	put_device(idxd_confdev(idxd));
> > -	bitmap_free(idxd->opcap_bmap);
> > -	ida_free(&idxd_ida, idxd->id);
> > -	kfree(idxd);
> >  }
> >  
> >  static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_data *data)
> > @@ -649,8 +646,13 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
> >  	return idxd;
> >  
> >  err_name:
> > +	/*
> > +	 * once device_initialize(conf_dev) is called,
> > +	 * put_device(conf_dev) will end up calling
> > +	 * idxd_conf_device_release() which will free the rest.
> > +	 */
> >  	put_device(conf_dev);
> > -	bitmap_free(idxd->opcap_bmap);
> > +	return NULL;
> >  err_opcap:
> >  	ida_free(&idxd_ida, idxd->id);
> >  err_ida:
> 
> I think that this first part should be a separate patch.
> 
> > diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> > index 6d251095c350..d5ffc641c856 100644
> > --- a/drivers/dma/idxd/sysfs.c
> > +++ b/drivers/dma/idxd/sysfs.c
> > @@ -1836,7 +1836,8 @@ static void idxd_conf_device_release(struct device *dev)
> >  {
> >  	struct idxd_device *idxd = confdev_to_idxd(dev);
> >  
> > -	destroy_workqueue(idxd->wq);
> > +	if (idxd->wq)
> > +		destroy_workqueue(idxd->wq);
> >  	kfree(idxd->groups);
> >  	bitmap_free(idxd->wq_enable_map);
> >  	kfree(idxd->wqs);
> 
> And this another.

I can split it as you desire.

--> Steve

-- 
Steve Wahl, Hewlett Packard Enterprise

