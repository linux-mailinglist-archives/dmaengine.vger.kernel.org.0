Return-Path: <dmaengine+bounces-7177-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABECC59EC3
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 21:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 23AF6349305
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 20:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248113126DA;
	Thu, 13 Nov 2025 20:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gf7BzC6B";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Afd7Cm+u"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822092C2357
	for <dmaengine@vger.kernel.org>; Thu, 13 Nov 2025 20:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763064762; cv=none; b=En5S3TbfFLg2nwuhRprru+/b/zKias4lJ6PFtc/VMR5+tB0sCO7tc3DVW/Xc7ajLSc2Mx6GizlF2FQFTXs9TDX2I4hSYKsAkh+/8m9rUzNlI9pppcs8YzasKAwClbRr5obU1PBzGdrTXsTpRNSYJaIF1dO5ov/7R/YUv5s8bw8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763064762; c=relaxed/simple;
	bh=RDx5dz0e5GnBBm/MAj6xKbVI2FDM3MsclgzK5hYTxNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQSJuzn4UmzDX5tdMwxW69M2S/NTRHily+yM4WRzQYS+tLwGZ4gNCDy/N353mz/QaN6enDZzNRG5la0LSrZB8scdXXHNGVraG/y+5vePymjKB2l+cnnnF8iTzLaGrOeXcrIrpStMYULMBBssFDEuI9jDJyUdM9qyrzTeJk7iK5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gf7BzC6B; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Afd7Cm+u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADET5Pe3801856
	for <dmaengine@vger.kernel.org>; Thu, 13 Nov 2025 20:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6EqNtYCdIa5BLP8lbDNwtORof81XIy0mVAFt0m//rc4=; b=Gf7BzC6B8e081yal
	vjEBOwPIHlibvAEbvorzDxpu5i4vFGoguoHxWFpfs+mILKG+kBod5OsqcsBO8Eih
	PVEU++yB+QXRHGYjMud2LseSSGJfJkdGdXyj7slxclUtV3z1zdFwfOo6ReA/J/x0
	GcwuOuqL/Pn/xag5X596RKkimD2Bpiu+f5aNWcxPczkJnzCqrKwc5yTJFL9nW5kx
	FhkuJGu24pTuZRFpOVly+DLYEvvxjpwCO8emRMi5IMmKUW+9WABIONOCq1CVsOpm
	J1BldoOVgVygzOEJdcK/t0utcEP1xak3hUDfIGI40oOAN5iLB71xfN2t+I7edn7L
	4LCmAQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adaamah0u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 13 Nov 2025 20:12:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b22ab98226so543188085a.2
        for <dmaengine@vger.kernel.org>; Thu, 13 Nov 2025 12:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763064758; x=1763669558; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6EqNtYCdIa5BLP8lbDNwtORof81XIy0mVAFt0m//rc4=;
        b=Afd7Cm+utttpKHE46CQ1kSstmsyHRbVmurZf/+197ve7GVxqGvHFADKzhl30zjViM5
         l8RGWftyLBzS1qOaueB7Ij4LdcfPm0Ry+VIRgLloNrzMC+K2EiLlybpp3fmdg5FtmBvo
         /Ik/AdvWNLYyyBazmlKaOxWXxISZOdPHgQwQsWAZMYgNwMVJ4ApI0iqlb55u8bkwZuVg
         VGxCEJt+mIGTzH6oH1Lb/UyBzR3HDphuqe2ASo0ZtfpRabMgKpGgYXuNVDIdzW3zE7ic
         A9phCb8bPkAiMG/kMfiV235uoowT6wBI08MBw1Hwd8aWXIvKcatkGdwyoSglK8wJmqlR
         OnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763064758; x=1763669558;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6EqNtYCdIa5BLP8lbDNwtORof81XIy0mVAFt0m//rc4=;
        b=Qb/SaLUJUarTdmyzSuaWIBM9DBScXiHEJNVBrt0t9NghSerqi9bxvKNH90tdClKQXQ
         f1d7I/u3hsMAkYAMH4Yc5oK8LtmMOsEmFR5mx9FQyaHCrbe4o2ywGwEWxD1WZSXY/V0C
         zgjqSn0IpZ0Q1L/UD2XxvNWQjkjEgWTAdNRSGdg+3KfYbjpucgy+vtMzRpBaZM6sSctT
         imjfWa++JO2Mqa+q2OjXx1Mcdk6mHgw0kWjnXd81+KdTMOe+ugkcCmj85CWxgT1Z8DuM
         YZ8B25R7JYIXCqij0k8cfPbQZD+ZiwstwyeG+n4Ss/7py+Io2mhxBQzsWCSeecGrZRth
         x3gw==
X-Forwarded-Encrypted: i=1; AJvYcCUt20dEc4PJZLh5TOvgjZ41Is1oqVeljJGrGk8+DV6E9SKYDHPDqb/T//7p7k6Y7OREsuHzSUgpvYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpJJFwBZvbWn+BOcmOw/iMvUuaold3EaZIP0V/Bvvmw3Jz8AjF
	3o36bWPH7+6fyRhYTNUE19YNjarh4nfpRM2uXoZ6dR2NziCVoHsXLmbNovl5p29NJMCIEQRmIg+
	bb9/mQI9B3/pf47dQkJw1wxfjwwFIOte9AEhoz1DUVwofH+8zhX0ToUbpZnrJFZI=
X-Gm-Gg: ASbGncskeWd9oNDXSVLfEI1GRyA0BIQNpg1bFkdBpRWO2sDFLCLiJqqZ2zSwsfZCZEb
	IfW3Q2zJwkd7kB/i37NSj/ii0kOJk1ISovnQekBk9riIuajtt/Jl3rR5AnsTL/omU5ZlHfNdOfA
	6gE8BqtoYbsO3apmF+igUCmRbWGs80kuAx2eB89xJUz6wxZhxqZK4nt/A7qIdTZxhlJT7jJgfit
	miUanCoKXcZYVQqDepV2ntzrVULTeO7Yr+WH53BbT2WfciHaLLCDD/UeZLa3eMHNxE/8J2DJP8Q
	qQiHhwl9OtnnBBv4HucfZgXh8AuSV//0KBaStzfFvgqO6fLOjsnp8FmLO86ovhRZCqYdcQqV8LT
	2hoYvstria2vDCPJWlcJIlfQ5WdH7Oejw/AT0DGtosWBHwnOQr04rO/3wzOhlUKt6PlgQ/7QQhK
	oJpB611XtOsYHH
X-Received: by 2002:a05:620a:4689:b0:8b2:737d:aa24 with SMTP id af79cd13be357-8b2c315e556mr89755685a.26.1763064758457;
        Thu, 13 Nov 2025 12:12:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfftwI33WcTytiC/mz27Cvb5o52FXrSqcNcUgmDQbZd9S+FCYZL8u1cWrY+wAhlrdUZMYlYg==
X-Received: by 2002:a05:620a:4689:b0:8b2:737d:aa24 with SMTP id af79cd13be357-8b2c315e556mr89752085a.26.1763064757998;
        Thu, 13 Nov 2025 12:12:37 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37b9ced4acfsm5675661fa.30.2025.11.13.12.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 12:12:36 -0800 (PST)
Date: Thu, 13 Nov 2025 22:12:35 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Tiwari <quic_utiwari@quicinc.com>,
        Daniel Perez-Zoghbi <dperezzo@quicinc.com>,
        Md Sadre Alam <mdalam@qti.qualcomm.com>, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v8 01/11] dmaengine: Add DMA_PREP_LOCK/DMA_PREP_UNLOCK
 flags
Message-ID: <66nhvrt4krn7lvmsrqoc5quygh7ckc36fax3fgol2feymqfbdp@lqlfye47cs2p>
References: <20251106-qcom-qce-cmd-descr-v8-0-ecddca23ca26@linaro.org>
 <20251106-qcom-qce-cmd-descr-v8-1-ecddca23ca26@linaro.org>
 <xozu7tlourkzuclx7brdgzzwomulrbznmejx5d4lr6dksasctd@zngg5ptmedej>
 <CAMRc=MdC7haZ9fkCNGKoGb-8R5iB0P2UA5+Fap8Svjq-WdE-=w@mail.gmail.com>
 <m4puer7jzmicbjrz54yx3fsrlakz7nwkuhbyfedqwco2udcivp@ctlklvrk3ixg>
 <CAMRc=MfkVoRGFLSp6gy0aWe_3iA2G5v0U7yvgwLp5JFjmqkzsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfkVoRGFLSp6gy0aWe_3iA2G5v0U7yvgwLp5JFjmqkzsw@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE1OCBTYWx0ZWRfX9PV7E8d5NMh7
 L7QjBu3kf1PN53DxqGW8tFEUZ2pOPVIEsPawRl5AbQNz/OgEDjia9/qlQu5Yq5OOfQCWASVWa3H
 +3ykOfHknWCOsHjrpVYSA3zcSg/WlU5bY0lDRHgnF+KAybFGyFDkSgSQac2u1V+Zd2CN7LLF/IE
 na7TE6uJ4xEOsHhqL8tFO5Wj/Wa72ATDegi/OXGXEMTTmkXjcdCOppq095X46Kpy3Ep9sLDuOTb
 wRxyYnjPeaaoCxZodSEhuVF0J75v1U/B+mqIAPLvdnjaWdBfN6C823dFWbup3BP5zK6MG0xgUAF
 3MyhKnsI4h3mhwbKeD+92Zg2jQOHmK+qfjEppAPCuAow0vrmwJOIPA5ndk7mdlkvVb5yBQJGJ2h
 RYDTNzGUUkyJgL4yhY77LfVIPH7lOg==
X-Authority-Analysis: v=2.4 cv=d4f4CBjE c=1 sm=1 tr=0 ts=69163bb7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=mQADmR9Bmzp49jEYGiUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: LV4qPOTeCPsJSZsDAsmtHovu9lva6HM4
X-Proofpoint-GUID: LV4qPOTeCPsJSZsDAsmtHovu9lva6HM4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_05,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130158

On Thu, Nov 13, 2025 at 04:52:56PM +0100, Bartosz Golaszewski wrote:
> On Thu, Nov 13, 2025 at 1:28 PM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > On Thu, Nov 13, 2025 at 11:02:11AM +0100, Bartosz Golaszewski wrote:
> > > On Tue, Nov 11, 2025 at 1:30 PM Dmitry Baryshkov
> > > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > > >
> > > > On Thu, Nov 06, 2025 at 12:33:57PM +0100, Bartosz Golaszewski wrote:
> > > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > >
> > > > > Some DMA engines may be accessed from linux and the TrustZone
> > > > > simultaneously. In order to allow synchronization, add lock and unlock
> > > > > flags for the command descriptor that allow the caller to request the
> > > > > controller to be locked for the duration of the transaction in an
> > > > > implementation-dependent way.
> > > >
> > > > What is the expected behaviour if Linux "locks" the engine and then TZ
> > > > tries to use it before Linux has a chance to unlock it.
> > > >
> > >
> > > Are you asking about the actual behavior on Qualcomm platforms or are
> > > you hinting that we should describe the behavior of the TZ in the docs
> > > here? Ideally TZ would use the same synchronization mechanism and not
> > > get in linux' way. On Qualcomm the BAM, once "locked" will not fetch
> > > the next descriptors on pipes other than the current one until
> > > unlocked so effectively DMA will just not complete on other pipes.
> > > These flags here however are more general so I'm not sure if we should
> > > describe any implementation-specific details.
> > >
> > > We can say: "The DMA controller will be locked for the duration of the
> > > current transaction and other users of the controller/TrustZone will
> > > not see their transactions complete before it is unlocked"?
> >
> > So, basically, we are providing a way to stall TZ's DMA transactions?
> > Doesn't sound good enough to me.
> 
> Can you elaborate because I'm not sure if you're opposed to the idea
> itself or the explanation is not good enough?

I find it a bit strange that the NS-OS (Linux) can cause side-effects to
the TZ. Please correct me if I'm wrong, but I assumed that TZ should be
able to function even when LInux is misbehaving.

-- 
With best wishes
Dmitry

