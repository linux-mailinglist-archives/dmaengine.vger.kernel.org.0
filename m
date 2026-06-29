Return-Path: <dmaengine+bounces-11873-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BHadAsLEQmqeBAoAu9opvQ
	(envelope-from <dmaengine+bounces-11873-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 21:17:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C7E6DE3CF
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 21:17:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hpe.com header.s=pps0720 header.b=OiKap86K;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11873-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11873-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=hpe.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FB6D3010C38
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 19:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5232EFD95;
	Mon, 29 Jun 2026 19:17:18 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344F34A33;
	Mon, 29 Jun 2026 19:17:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782760638; cv=none; b=MpIOqwzzHZXUpCF45VwnfKchPDBb2RZvf/Lz/5RYhrdlv5dA4LgAhPCXAzvVvtPxz94MQQvtNyf0NO9eFdCzg22c4k/p8Dg4PWlf+NMG3t/YxxQKhkk2poD3L8m+IrESRuXSyp6Yktd2mDMZoJy3bySEtyLtUzxBNPqz/DvqHOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782760638; c=relaxed/simple;
	bh=RHxi4XbzWTmRlh22bjxv/t5f0pDwHTVlc6H1tcSTJcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ldylrl//n8Nifml0c9qcIlsU1Ag/2PXNH0MiB7fT84FQ1cZeJFEE/6ZSh/D99mHdbhiWeMaEoMSNqw1F98tXklAZwBBU4/Uw19Rvdac3BFhFT2Y0+FPEqN8YYBqmKdIyFuIuGmOd8Fs4tfTQSqmMM9DpvWWDtb7aQvqABO/msIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=OiKap86K; arc=none smtp.client-ip=148.163.143.35
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TGKZQ6111612;
	Mon, 29 Jun 2026 19:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=eD
	2DakoTxyVKKHw9I9W38m6B9VhqOZdc8yWpcg5Sp4g=; b=OiKap86KlaWNZcFdFj
	bJRJXWWYl3GEzppz2YffEeoY2Scb+pz0DbScY5HmPoMQtHG/B4RNUOr6SwY1ybYf
	1G+3ZB2/8ZrugwC6wEl4/0NezEEEALX7rQ0JHbDtOZWtfN9a6d/tOA+kXT++H/35
	0ESDcuXf3JORqTVwJrWlQJGySBl6vTnUHjVG9ftYN71HFnQOm38kKZQd/xutnkUC
	C7b7JG41AwaxxQ2GmVKHi1xrx4/HApsxRHV+5KisEOIiCSx3XVPUV+xY9ozCPHdB
	Ojid9GR7g4NAnYjmdP66EYoY/D6J/nVbTuzchzVvkVzsMJuL75CEzhnR46JuUJQM
	JX5g==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4f3rv3xrs5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 19:02:14 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 7E36A12EB7;
	Mon, 29 Jun 2026 19:02:13 +0000 (UTC)
Received: from ilogsc-qemu.local (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id B8DF4805871;
	Mon, 29 Jun 2026 19:02:10 +0000 (UTC)
Date: Mon, 29 Jun 2026 14:02:07 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: "Codres, Bogdan" <Bogdan.Codres@windriver.com>,
        Steve Wahl <steve.wahl@hpe.com>, Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH v2 2/2] dmaengine: idxd: fix duplicate memory frees on
 initialization error path.
Message-ID: <akLBL7b2h73pK0AC@ilogsc-qemu.local>
References: <20260522203414.336549-1-steve.wahl@hpe.com>
 <20260522203414.336549-2-steve.wahl@hpe.com>
 <87echsiyur.fsf@intel.com>
 <BYAPR11MB36069EC520DCB9DFD6A411EEF8E82@BYAPR11MB3606.namprd11.prod.outlook.com>
 <BYAPR11MB36068CF244AA0940E39D3B50F8E82@BYAPR11MB3606.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR11MB36068CF244AA0940E39D3B50F8E82@BYAPR11MB3606.namprd11.prod.outlook.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDE1OSBTYWx0ZWRfX6ey4f8bwjARw
 BGxeTXVmouzFpvQy1UaV4arn1y3GDpgkMHBEr6tXLsO72ZE+YzE9veSZPD5z9umTtFlHCRTtd5U
 XeTTFEm+Nhppq0Hsl40XsekK6Y0Qa/g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDE1OSBTYWx0ZWRfX9Ye5oSgEQne+
 CYA3pl+dzxglN2CpSPvY4yWeBgFxb8TJ1hVmvFF9M7AUHOXQ2EBX/YojbDYokS/BxYkQ5DE67Y1
 OHHeVm8AaFc/I1ACqI2ZfFOWCm87rGUkPUolrRkMe/UeqhkCPBSmkcxJZiT2r7yccErAQy80L78
 UMJKPk8IrcQvr7hgfn/GJ27V/hcxspMT25j2PYuhtOJkQPr+nAdsuxq+JH87QcHVzg8haSC3n81
 zxRowDRfowDDR/jXhtoFg6E4mbORX6ktSAWLkPJixTF8acwW6lxhkYLu4bsGQ7Vmm0NqBi0fK7P
 ITz6JeaxOTM4K97D5/ZKgilOyHLdaafQkuXigfQTyUndU/msTkxiBglDrJWiD0qkzeqKOTJT/Ei
 6CfCESJaJkYxhsxRT/B8BHDYvo4QGzotFTlUCTd+/QZyO+CMF9ed7kOWXj2G+E4/+/f2K/9CdMs
 KPWr/dzq08VFImS0Lvw==
X-Proofpoint-GUID: wjhrXeoV40X5zp4wznFl0GUOOC8LZqUI
X-Authority-Analysis: v=2.4 cv=OOIXGyaB c=1 sm=1 tr=0 ts=6a42c136 cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gQcMVamqm3wCPoSYhaRC:22 a=g3u0LPWLDYfGfufhFw6-:22 a=t7CeM3EgAAAA:8
 a=QyXUC8HyAAAA:8 a=MvuuwTCpAAAA:8 a=VwQbUJbxAAAA:8 a=Wbo_-sQPbvIGc4i7mrQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: wjhrXeoV40X5zp4wznFl0GUOOC8LZqUI
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290159
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[hpe.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11873-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,hpe.com:dkim,hpe.com:email,hpe.com:from_mime,windriver.com:email,ilogsc-qemu.local:mid];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vinicius.gomes@intel.com,m:Bogdan.Codres@windriver.com,m:steve.wahl@hpe.com,m:dave.jiang@intel.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rja@hpe.com,m:sivanich@hpe.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[steve.wahl@hpe.com,dmaengine@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[hpe.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steve.wahl@hpe.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 51C7E6DE3CF

On Mon, Jun 29, 2026 at 11:44:36AM +0000, Codres, Bogdan wrote:
> Hi Vinicius, Steve,
> 
> Thanks for the heads-up. I'm totally fine with being added as:
> 
> Reported-by: Bogdan Codres <bogdan.codres@windriver.com>
> 
> on Steve's patch — his fix addresses the same issue I was seeing.
> You can use my splat as the reproducer.
> 
> Regarding the third patch for the dangling ->wq pointer — the proposed change looks reasonable to me.
> 
> Best regards,
> Bogdan
> 
> Ph.D. eng. Bogdan Codres
> Member of Technical Staff in Cloud Platform Engineering, Wind River
> 

Hello, everyone,

As there's no code changes (and I even find it remarkable how similar
the two were, I think only the comments differed), I am completely
open to Vinicius just modifying the commit message to include the
parts he wants to see.  It would take less time than another round of
posting a patch.  But if you need more from me, let me know.

Thanks,

--> Steve

> ________________________________
> From: Codres, Bogdan <Bogdan.Codres@windriver.com>
> Sent: Monday, June 29, 2026 14:32
> To: Vinicius Costa Gomes <vinicius.gomes@intel.com>; Steve Wahl <steve.wahl@hpe.com>; Steve Wahl <steve.wahl@hpe.com>; Dave Jiang <dave.jiang@intel.com>; Vinod Koul <vkoul@kernel.org>; Frank Li <Frank.Li@kernel.org>; dmaengine@vger.kernel.org <dmaengine@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> Cc: Russ Anderson <rja@hpe.com>; Dimitri Sivanich <sivanich@hpe.com>
> Subject: Re: [PATCH v2 2/2] dmaengine: idxd: fix duplicate memory frees on initialization error path.
> 
> Hi Vinicius, Steve,
> Thanks for the heads-up. I'm totally fine with being added as
> Reported-by: Bogdan Codres <bogdan.codres@windriver.com>
> on Steve's patch — his fix addresses the same issue I was seeing.
> You can use my splat ad the reproducer.
> Regarding the third patch for the dangling ->wq pointer — the idxd->wq = NULL after destroy_workqueue() looks reasonable to me
> Best regards, Bogdan
> 
> 
> Best Regards,
> 
> Ph.D. eng. Bogdan Codres
> 
> Member of Technical Staff in Cloud Platform Engineering, Wind River
> 
> ________________________________
> From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Sent: Saturday, June 27, 2026 3:57
> To: Steve Wahl <steve.wahl@hpe.com>; Steve Wahl <steve.wahl@hpe.com>; Dave Jiang <dave.jiang@intel.com>; Vinod Koul <vkoul@kernel.org>; Frank Li <Frank.Li@kernel.org>; dmaengine@vger.kernel.org <dmaengine@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> Cc: Russ Anderson <rja@hpe.com>; Dimitri Sivanich <sivanich@hpe.com>; Codres, Bogdan <Bogdan.Codres@windriver.com>
> Subject: Re: [PATCH v2 2/2] dmaengine: idxd: fix duplicate memory frees on initialization error path.
> 
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> Steve Wahl <steve.wahl@hpe.com> writes:
> 
> > Error paths within idxd_pci_probe_alloc and related functions end up
> > attempting to free memory already freed from idxd_conf_device_release
> > via put_device.
> >
> > This was encountered running in a kexec'd kdump kernel with reduced
> > resources, causing the "Device is HALTED!" branch in
> > idxd_device_init_reset to be taken.
> >
> > In idxd_free and idxd_alloc, do not attempt to free allocations that
> > will already have been freed.
> >
> > Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> > ---
> 
> Bogdan Codres series (but submitted a bit later), tries to fix this
> issue, has a better splat and a reproducer, I think it makes sense to
> add the splat and reproducer here, and add Bogdan as Reported-by (if
> agreed, of course).
> 
> I am wondering about adding a third patch for the dangling ->wq pointer, as
> reported by Sashiko would make sense.
> 
> Something like this might do the job (totally untested):
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index f1cfc7790d95..0a74018f31a8 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -415,6 +415,7 @@ static void idxd_cleanup_internals(struct idxd_device *idxd)
>         idxd_clean_engines(idxd);
>         idxd_clean_wqs(idxd);
>         destroy_workqueue(idxd->wq);
> +       idxd->wq = NULL;
>  }
> 
> How does it sound?
> 
> > v2: split into two patches as requested by Vinicius Costa
> >
> >  drivers/dma/idxd/init.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> > index f1cfc7790d95..227e323cc5a0 100644
> > --- a/drivers/dma/idxd/init.c
> > +++ b/drivers/dma/idxd/init.c
> > @@ -607,9 +607,6 @@ static void idxd_free(struct idxd_device *idxd)
> >               return;
> >
> >       put_device(idxd_confdev(idxd));
> > -     bitmap_free(idxd->opcap_bmap);
> > -     ida_free(&idxd_ida, idxd->id);
> > -     kfree(idxd);
> >  }
> >
> >  static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_data *data)
> > @@ -649,8 +646,13 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
> >       return idxd;
> >
> >  err_name:
> > +     /*
> > +      * once device_initialize(conf_dev) is called,
> > +      * put_device(conf_dev) will end up calling
> > +      * idxd_conf_device_release() which will free the rest.
> > +      */
> >       put_device(conf_dev);
> > -     bitmap_free(idxd->opcap_bmap);
> > +     return NULL;
> >  err_opcap:
> >       ida_free(&idxd_ida, idxd->id);
> >  err_ida:
> > --
> > 2.51.0
> >
> 
> --
> Vinicius

-- 
Steve Wahl, Hewlett Packard Enterprise

