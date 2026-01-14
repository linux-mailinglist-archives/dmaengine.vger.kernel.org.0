Return-Path: <dmaengine+bounces-8246-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0CBD20196
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 17:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C472E308ED7A
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 16:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A35E3A1D12;
	Wed, 14 Jan 2026 16:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hvvyLSnt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PtqPzWYi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038933A1E7F
	for <dmaengine@vger.kernel.org>; Wed, 14 Jan 2026 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406707; cv=none; b=HpNrwXqDAHRIYMdGCHdmAG43Jx81UpF61vBkIg3q5kSfXboLrSZdjyT9vG+drXS8e+2mEZB/5FhMnrLLcSUwFkiB6UYvwq6ePOmOKtID84RAnkZJ0EBhCbQ0swcdqnrF1UMg4U1yed8VY5QCOt1Q1hovmeGai1ZOAnoUycIKI64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406707; c=relaxed/simple;
	bh=9H8wiyUnF4ylFKzCr5J4gfcYevv9VaRGGFZiwCFq/48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgHt8D6t4fbBGAJE+tJyhYjO044+E7N6bA6mcasjTYzfFVH9JzTuvV6f9tFiJLDFLXth+xv5hgNmZjQoyGWUxiECzDEmAuIUlns7HHFHB14lHdQM9VE8OldC28nk4+38nnkEtScxFvKX6YFLRO9+c7wODIY4t9ZVUe0cQYxga5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hvvyLSnt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PtqPzWYi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EE37mU147882
	for <dmaengine@vger.kernel.org>; Wed, 14 Jan 2026 16:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+iaUhLfP280G9UZEsC2EmbnNHrNb/7z1dRVbvA0ugOA=; b=hvvyLSnt6H4DELQT
	0Rr6yKGo4pmwmJxgbgeWK41sEZa7zAG02d7bu9mLTzjjHRabPxb4DIw5+44KET7L
	TUXXGZ5LdM4MVTamDs84Qlk1gEuy0la4IaxtC/f7BRiGSfN7QvQ3UujqvzwvSPPk
	uT5SCGbOuyCJC28x7Trb1DmdSafN/5pfzWqiSHCqMgFxM241YaqaAxMfYbKSLP7D
	TcGi/s+Q63DzgGVAX5JI8vbQn+rq0t4BKLd5X9XyM6SNwEz81EvG7Ern4sSkmr0L
	Ek22DAKnXcgzmMqsm74/Yys6SD0iMJqS4O7P1TcPIZdwqdInlQ/AtWJtBHKEpIBn
	+zgXrg==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bp6rahuj5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 14 Jan 2026 16:05:02 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-9411b2335f4so20553837241.3
        for <dmaengine@vger.kernel.org>; Wed, 14 Jan 2026 08:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768406697; x=1769011497; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+iaUhLfP280G9UZEsC2EmbnNHrNb/7z1dRVbvA0ugOA=;
        b=PtqPzWYizov+FfbZHMUQEct8WHW2RqHApQBcX3A7wgWKXL7SHWUnSHB003FQcD1II+
         mD/bR8VhAhpBsJNCxERjJY8FZVruIS2Wua1BTTv+4DuVNzzmttkFlrdI/dnQWzQMTlmH
         WqTqqHKsqQpt9ctK4F+wBrnbehF8aZ3lod9w/Y5/TRmLK8vlvfyP9lrhKAD/77CgBLdy
         zfpE8RJx/EowNgMMIVqlPdI8jljn0mwELY5dBCKtaBB3QyXgkt1kCIeWxR1hZvzie629
         OYGOYTViOW9SPGyuq9x9l1rytgTBPGjco7ymfqVEqAk8SspS+MtzJxQ3jdmtlba0n1b8
         qI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406697; x=1769011497;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+iaUhLfP280G9UZEsC2EmbnNHrNb/7z1dRVbvA0ugOA=;
        b=JKRiAdjYbDwWkWGreaEvf6iKkYyBHF8CuFAN3XXC2sJuIbv/Xk6cxlY6AQQmCyEIFa
         z+I8f9IETf6B8mbcvsktge/TIV0KqYwTpwmQaTZLCgPhXuPRUAL6aof3dU5FUvY/YcWt
         lR/gHw8jwtZ3YHnAyA/6Z26aNUCxd61BpWYCnRkvGiLRpr5UjRGZML4Yk6hbKqS3AIpq
         ZXd4ZP0rjCXcgn5b1nWkQYl2GxwyLDf4ob/yDaM7hxO02vVJE1SXT1SGHkXQhky3M8nl
         tdy2Udl7nJQ53YOTMv9EOA3JTXsL1XnrBfPbiw12zvgCEohAiso05XhxXAKuac1hl7ot
         Faqw==
X-Forwarded-Encrypted: i=1; AJvYcCWmPFJyxN3IAnsXR24AYUgREiubMP/ImwMdofKq6jyBrGbm2hOb1wGt1cVSv6wi63t1f+yo7zUa7HQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfH0JBojlqSl26ItZTY/G4pKsgzMKn2RDGjG9hgSmazEJ3yXtN
	tVm15Vwp3IuNJ8ytfpoXYMJHaeFtMFsSpnlb3AP3Mxn96lfHKB1KAzKKxiENt0enLR8tVa0TKom
	V6HmrjSWY9udt55v+cP890o9TZRa5NkfcDYoiibLCIG3qEzZ5pDHRfPmY8GnZD2o=
X-Gm-Gg: AY/fxX7bmP8wIZtPOf/TwjNsRePdhM5BKBkBuGpO0p4WPW2PKmKiX4XoHpjitLSKmCU
	eYuwDkwvIxQUsWpDJj3jo+wjDrgy+AJxhMGfkwPaCM0eOFSkPJaG/9sorSiPjE26Zsngfuu2SDQ
	DXibBGW8cHh56FPQKzQX2eGBMYykoW/IWXYZgIJqn04DE58a2+MjtoVRNYbU/aneP5q0yxRds16
	+fFh/dn7vLZ/muzf3cN0HekGTFlhwy8jtXSpLpXcZATCJEZM9lpBQq+OqVYIsdCME3zjCoi5tT/
	1CP9zjLPanstrHGD5yVhbLHUZBWrcKkuJkrmgyGTjcvzYxT2TGd+5UugzL1CgrdLM/W+zVNPrwC
	2ZURUeWUEtGj7vsmXl51QtyyfqcrMfFbMql5ofil3f7RaDfri0au73RdNxIes/6lw8uYfnoXprn
	yYLM+EQMcJlv8hrDMvbmS8YSA=
X-Received: by 2002:a05:6102:5691:b0:534:cfe0:f861 with SMTP id ada2fe7eead31-5f17f4dcb94mr1446247137.18.1768406696341;
        Wed, 14 Jan 2026 08:04:56 -0800 (PST)
X-Received: by 2002:a05:6102:5691:b0:534:cfe0:f861 with SMTP id ada2fe7eead31-5f17f4dcb94mr1446067137.18.1768406694401;
        Wed, 14 Jan 2026 08:04:54 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382eb7c708fsm53807741fa.21.2026.01.14.08.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 08:04:53 -0800 (PST)
Date: Wed, 14 Jan 2026 18:04:51 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Tiwari <quic_utiwari@quicinc.com>,
        Daniel Perez-Zoghbi <dperezzo@quicinc.com>,
        Md Sadre Alam <mdalam@qti.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v9 03/11] dmaengine: qcom: bam_dma: implement support for
 BAM locking
Message-ID: <bwhczqghukhoy2ktedizkexwhzdmirrxcucoewrc5dfe7ebvjk@554mr7q2urmr>
References: <CAMRc=MetbSuaU9VpK7CTio4kt-1pkwEFecARv7ROWDH_yq63OQ@mail.gmail.com>
 <aUF2gj_0svpygHmD@vaman>
 <CAMRc=McO-Fbb=O3VjFk5C14CD6oVA4UmLroN4_ddCVxtfxr03A@mail.gmail.com>
 <aUpyrIvu_kG7DtQm@vaman>
 <CAMRc=Md6ucK-TAmtvWMmUGX1KuVE9Wj_z4i7_-Gc7YXP=Omtcw@mail.gmail.com>
 <aVZh3hb32r1oVcwG@vaman>
 <CAMRc=MePAVMZPju6rZsyQMir4CkQi+FEqbC++omQtVQC1rHBVg@mail.gmail.com>
 <aVf5WUe9cAXZHxPJ@vaman>
 <CAMRc=Mdaucen4=QACDAGMuwTR1L5224S0erfC0fA7yzVzMha_Q@mail.gmail.com>
 <aWBndOfbtweRr0uS@vaman>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aWBndOfbtweRr0uS@vaman>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEzMyBTYWx0ZWRfX3/Gii51LJcfY
 FTa4X2Kk6QUbCuRZEzPJWvM1c1S8/8XVhPQY7wjVFQBxZG2tYPvRpN9r3lSvYiXIFkfL8i5adYQ
 yXnH2BWswfcm6Z+P9uJ0h3sVdOogKk+oM/LwSKpJ1gdM1PDVh8NKiw0WFup9Rk5l8t8oBtdxWL2
 t/WLPkMc9SyOzvEm29ivkvl0rEI89+Zh2/JUKa8n6IbFUJHZbdtzJphG/nfu/KwSHbAUPC99MsM
 RLUerUYN0rTQyc0x8nV7Xy1DTQY++w6mOwWeLS6BydHeWzvIQeIbT9cDoiCqly2Faxe6x4GS7ye
 i/+i9z9GnNXEqHXLlssvvCS6ykaAWd4ujRSgjCLWirf/IifIkwnmxWmm3wGG8PxgbboUdZ4b2v0
 j2dwe9xSzzNfd7hV7idV99SCqdE8YDmEjc3DiVBRF5mnw4SJhr7tMJgvXBrepQFSwKw/078uo4g
 IJ+KmFaN3BdXx0eJBxQ==
X-Proofpoint-GUID: Ca_uaSPPdRLNOTF9kaYxz-ysHtDbVMR4
X-Proofpoint-ORIG-GUID: Ca_uaSPPdRLNOTF9kaYxz-ysHtDbVMR4
X-Authority-Analysis: v=2.4 cv=L/EQguT8 c=1 sm=1 tr=0 ts=6967beae cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=tFmwwPv8JJdzMd2mOjkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_05,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140133

On Fri, Jan 09, 2026 at 07:57:00AM +0530, Vinod Koul wrote:
> On 02-01-26, 18:14, Bartosz Golaszewski wrote:
> > On Fri, Jan 2, 2026 at 5:59 PM Vinod Koul <vkoul@kernel.org> wrote:
> > >
> > > On 02-01-26, 10:26, Bartosz Golaszewski wrote:
> > > > On Thu, Jan 1, 2026 at 1:00 PM Vinod Koul <vkoul@kernel.org> wrote:
> > > > >
> > > > > > >
> > > > > > > > It will perform register I/O with DMA using the BAM locking mechanism
> > > > > > > > for synchronization. Currently linux doesn't use BAM locking and is
> > > > > > > > using CPU for register I/O so trying to access locked registers will
> > > > > > > > result in external abort. I'm trying to make the QCE driver use DMA
> > > > > > > > for register I/O AND use BAM locking. To that end: we need to pass
> > > > > > > > information about wanting the command descriptor to contain the
> > > > > > > > LOCK/UNLOCK flag (this is what we set here in the hardware descriptor)
> > > > > > > > from the QCE driver to the BAM driver. I initially used a global flag.
> > > > > > > > Dmitry said it's too Qualcomm-specific and to use metadata instead.
> > > > > > > > This is what I did in this version.
> > > > > > >
> > > > > > > Okay, how will client figure out should it set the lock or not? What are
> > > > > > > the conditions where the lock is set or not set by client..?
> > > > > > >
> > > > > >
> > > > > > I'm not sure what you refer to as "client". The user of the BAM engine
> > > > > > - the crypto driver? If so - we convert it to always lock/unlock
> > > > > > assuming the TA *may* use it and it's better to be safe. Other users
> > > > > > are not affected.
> > > > >
> > > > > Client are users of dmaengine. So how does the crypto driver figure out
> > > > > when to lock/unlock. Why not do this always...?
> > > > >
> > > >
> > > > It *does* do it always. We assume the TA may be doing it so the crypto
> > > > driver is converted to *always* perform register I/O with DMA *and* to
> > > > always lock the BAM for each transaction later in the series. This is
> > > > why Dmitry inquired whether all the HW with upstream support actually
> > > > supports the lock semantics.
> > >
> > > Okay then why do we need an API?
> > >
> > > Just lock it always and set the bits in the dma driver
> > >
> > 
> > We need an API because we send a locking descriptor, then a regular
> > descriptor (or descriptors) for the actual transaction(s) and then an
> > unlocking descriptor. It's a thing the user of the DMA engine needs to
> > decide on, not the DMA engine itself.
> 
> I think downstream sends lock descriptor always. What is the harm in
> doing that every time if we go down that path?
> Reg Dmitry question above, this is dma hw capability, how will client
> know if it has to lock on older rev of hardware or not...?

We can identify that on the calling side, but I doubt we'd need it: The
lock semantics was absent on APQ8064 / MSM8960 / IPQ8064 and it seems to
be present for all devices afterwards.

Frankly speaking, I think this is the best API we can get. It is
definitely much better than the original proposal.

> 
> > Also: only the crypto engine needs it for now, not all the other users
> > of the BAM engine.
> 
> But they might eventually right?

-- 
With best wishes
Dmitry

