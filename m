Return-Path: <dmaengine+bounces-7938-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72609CDBCFC
	for <lists+dmaengine@lfdr.de>; Wed, 24 Dec 2025 10:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48C533027E35
	for <lists+dmaengine@lfdr.de>; Wed, 24 Dec 2025 09:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A68332EDB;
	Wed, 24 Dec 2025 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GsemOaCZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hX+FlAiN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B8C32AACB
	for <dmaengine@vger.kernel.org>; Wed, 24 Dec 2025 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766568827; cv=none; b=b4rewMeB2mpTKQkg540HdZs+mRbDT8PDrFmtiyY5S3KOy37O1ov8dEcmaO9pnukMQILVG7/99cRWpuB8RMzbgiBWfNj+NhDWIL4Rt8V/OpDayZzz6aL7BxGzMBb4re7mxLiAoFwImMqrdNOAH5twc2Tk6Jyzl5fPhC8kTcWldO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766568827; c=relaxed/simple;
	bh=zVdEgswMYjQdFi1JeSShfaN1iG2FgjULqfySt+Vg0TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+PLqTVjWJc04dQZArxw1HidPQsC8I+zZqIbael9QsLgsyctLnsNSoRgYqrB9JcDH8L6K6IpGz8sf5qhXHwTtbXohrrdkrgxNtt9KVb7muhb7OIul88iOQly9uhwTF0QA2Z1+VdKpQn1NGPi+NJnrtB/5IQSlf8MQgs8RZLXB7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GsemOaCZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hX+FlAiN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BO8umhK700762
	for <dmaengine@vger.kernel.org>; Wed, 24 Dec 2025 09:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wCT5puBa0vZxEsV1PmXlTlfWqvvSkkEkK3rx6XjgTJE=; b=GsemOaCZgkA3GF2n
	yq1m5gKVNgStOdLutlPqyuiUNmRn2ZDUV3P099M7NjUj5Tb7VjLFClOFeI95dA5j
	3bcSgmM9hvXtul7HPGgB1hFQM0M0+1j+Emw5ZkPqS3JOpjGMjbdvxrAzH1DK+q4J
	OMMWjI2Z3T5S6VZ9CqRkQkxXJtY+g3Nc9ZxFbB2mYyKq7u9t9LS+8n9wb3kfBezp
	1SjUeI50+zrBM86t33KAzJ5dIXyc9ZPJbIEmVuFk/P6EyAuVJTn6jYdcXSiY73je
	ZvwJwkga/R7AlUnMmk06lJz556cgmgguTkqgZzP0Eo008K+0RRGSzEMy2bH+OamV
	XLJdDA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b7t7juadp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 24 Dec 2025 09:33:45 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4f4a5dba954so136302461cf.0
        for <dmaengine@vger.kernel.org>; Wed, 24 Dec 2025 01:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766568824; x=1767173624; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wCT5puBa0vZxEsV1PmXlTlfWqvvSkkEkK3rx6XjgTJE=;
        b=hX+FlAiNqiWPzX26D/g3OZtWGyTJZg6QDvJDLK3uk8FlYap7clXIM/UNi4e1UJ3YYh
         Ooc5KG8ER3uERx18RTiKq75FcLQtSt5baaR3gx/8Ejemm6uyMGQtN2cAbvU0LOiOX/lk
         oAVbcZ4c/AHa+L6bc5XSab0z2/AUsMWGQvxL25+6lmNtOpKDyMGilNnkickYXOap2XzV
         wJBansgBGvRRqWXYuWra1SsUK5d5Qw5+l6xcPjsh9Wbpc7GAUnzYtSVpeJXPEk+hHs0D
         Wsr6mpTGRMsXng+sKn8jc0cRbsfVZqY0w+gqMrtawv7RcHKIhL+dGTQpH8Tnd9E4CNEN
         S2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766568824; x=1767173624;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wCT5puBa0vZxEsV1PmXlTlfWqvvSkkEkK3rx6XjgTJE=;
        b=FwvhytcZFN+TF30S/StJD7/BHsR8tlFUoCCGaJaZpy4FXbEgMj0+HSMrp07oJXErWW
         Zds7ALE/hFl161NKrvI4lq1vwMbWI5qsR/jw+0KqMYMvvMkQyzmJFTvpgu/SQ2FvnLjH
         IxCr+r0ecP2sx4DWnZelJTyxlLO9zxj0gfDjiBAtUR5QWc2gF29xZnDGHwSqJIsSMhQ6
         aPhrTOpIetqBNYrmIeqfFDiyOd8x4Ldv8VzRaZC+Ww4JFTQOzisUmSEh9kLWseiiShy/
         0WHtaSjf4y3hLUK5T9PafKeUDMsuHZB/MKvVcGoTq2QGRo6RSTdh5kiU2qRrO3fs9DEf
         pKMg==
X-Forwarded-Encrypted: i=1; AJvYcCWEP1wq5GT/0CiNfVoUC1XXF9o3/ElmmrsKETpOK32xJLl/J+QUusbUxgmlmETO9INHbLEeMN5Avqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKxAM0ib0v+J0uXxx4p5Hv0dDrelVljafs7ndHOAGTs7fqCENw
	Nz5I/EXvchvA44+9jRb0EpUJ/4v1nBRrPrh4DCIyZCEzITe3UtXl6JbGVuZoTiqDRYVpHQg8WR2
	UTVvshiKHVCvRQ8LaP/j0finz6IR2ZFFKcUwKWhRMOkjeUPvf3/CCbDDKwQuaogQ=
X-Gm-Gg: AY/fxX4LHEFVAQmTGJXi1xFH9pWFjGjgH5QxaMZn1hbF7zna3cOCrQGpVfarBxx8KRj
	H27DV2UA/nDz6YGIp1e4+x/T7ZacbRqhQeyKuGz0FH8V63xtmonFS/5EmCgBKSOGlTqtpuEvlfq
	K9YXupg0RLcVxTG2XmMtjxzE8E7ko5dqHP9UHaFe7x64lGC8sUM81Nf2PeynocVXzUTTuZgu22X
	hQ7gACMy6z0miJQLG9vMAGBB8qA64fl49fGZFra5dcprFQ+SN28+OoRMYeLo045HlgtNt5FSgWm
	df5cmGxQkY9iSR3vboDMXGtSpPakTXOpAH+CLpblRmqZSz8/rL08ru9qKJCHBqi9iwjQeaUKXi3
	16C14UIRQApF/KrRDhj4EQIPRbGFFiKGKpk8ID5dLOz95h41CzhT8OBnFVkG4XK5o6nBLDvQzPE
	L5VWYOO2nVfFMI4B5/dDIeca8=
X-Received: by 2002:a05:622a:1e94:b0:4ee:209c:be59 with SMTP id d75a77b69052e-4f4abd9541bmr285600531cf.55.1766568823928;
        Wed, 24 Dec 2025 01:33:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTtJvGuZJ+6HZuaWCfDcLRCi2CO3Y1cH64XvF4HtgM7+D/lE6qLs/pPDX1cnrX9nkUFmcopw==
X-Received: by 2002:a05:622a:1e94:b0:4ee:209c:be59 with SMTP id d75a77b69052e-4f4abd9541bmr285600351cf.55.1766568823441;
        Wed, 24 Dec 2025 01:33:43 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a1862026bsm4759801e87.84.2025.12.24.01.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 01:33:42 -0800 (PST)
Date: Wed, 24 Dec 2025 11:33:40 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
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
Message-ID: <b5oi5dcffzhrhpeqzfzoq5ztla2mzvaerij4262yunzozko2c6@bwayrzs7dumo>
References: <20251128-qcom-qce-cmd-descr-v9-0-9a5f72b89722@linaro.org>
 <20251128-qcom-qce-cmd-descr-v9-3-9a5f72b89722@linaro.org>
 <aUFX14nz8cQj8EIb@vaman>
 <CAMRc=MetbSuaU9VpK7CTio4kt-1pkwEFecARv7ROWDH_yq63OQ@mail.gmail.com>
 <aUF2gj_0svpygHmD@vaman>
 <CAMRc=McO-Fbb=O3VjFk5C14CD6oVA4UmLroN4_ddCVxtfxr03A@mail.gmail.com>
 <aUpyrIvu_kG7DtQm@vaman>
 <CAMRc=Md6ucK-TAmtvWMmUGX1KuVE9Wj_z4i7_-Gc7YXP=Omtcw@mail.gmail.com>
 <c2ctqk7z6n5mmrr2namz4psmpcohefyv6qu6gkycqykzgdpz2u@2qwils6lwwz4>
 <CAMRc=Md8nAVWvKK=Vib7TKVzC15M4FmET7TCCdrdS74DKQQjzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Md8nAVWvKK=Vib7TKVzC15M4FmET7TCCdrdS74DKQQjzg@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDA4MSBTYWx0ZWRfX+D8SmbCHAWtv
 G4W7KDBHGYtjxYAcEpVQJLmOws9/JIZq6zcqHMfkgLztUATOxhF8Py5gGX3fg9SxPXJ9tPKOpaK
 dDBjiRq1kYdFcCqwTRf2x5dQHA1MqsihQCB15398mQapRWzN+WlUFiEp1CzrznB6CoGAqFjYpgL
 8Q6rR+sRyisD1XKCFl6qPV6nriERZOxeJl9RncM1h6meLvOVYgQYzOVHaqfkGzx7H1fjsordtyd
 ANEysJjn+NDdJs+dwTBfRiy7rtBBfe0wsk+ISkOnlZ30Db/GrDKDKPXFC5p4uZRNyXRNWUEzOs0
 jYTqBnv8wIZ6dmlshTm11Lbs1UJ+Rk/7V6snxfJFVV3hw+r1ra+ZpYKXWhtnep3Eb+3VUiwwn6/
 g/212fGP6lhpSbe9M042Bt8Mzh5LaMiZPRV8+N9J4BK2nWTAdtl3wiHHdoDB63IDtedmeXQ5cLm
 dw8AWIS86bHtU7gZXow==
X-Authority-Analysis: v=2.4 cv=IvATsb/g c=1 sm=1 tr=0 ts=694bb379 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=RJy7UuovsIgBqIiFHQ4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: AelgZUMS4Vvvta47RoYJjqZjVjcGX9Xk
X-Proofpoint-ORIG-GUID: AelgZUMS4Vvvta47RoYJjqZjVjcGX9Xk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_02,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512240081

On Wed, Dec 24, 2025 at 09:58:05AM +0100, Bartosz Golaszewski wrote:
> On Tue, Dec 23, 2025 at 9:19 PM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > On Tue, Dec 23, 2025 at 01:35:30PM +0100, Bartosz Golaszewski wrote:
> > > On Tue, Dec 23, 2025 at 11:45 AM Vinod Koul <vkoul@kernel.org> wrote:
> > > >
> > > > On 17-12-25, 15:31, Bartosz Golaszewski wrote:
> > > > > On Tue, Dec 16, 2025 at 4:11 PM Vinod Koul <vkoul@kernel.org> wrote:
> > > >
> > > > > >
> > > > > > I am trying to understand what the flag refers to and why do you need
> > > > > > this.. What is the problem that lock tries to solve
> > > > > >
> > > > >
> > > > > In the DRM use-case the TA will use the QCE simultaneously with linux.
> > > >
> > > > TA..?
> > >
> > > Trusted Application, the one to which we offload the decryption of the
> > > stream. That's not really relevant though.
> > >
> > > >
> > > > > It will perform register I/O with DMA using the BAM locking mechanism
> > > > > for synchronization. Currently linux doesn't use BAM locking and is
> > > > > using CPU for register I/O so trying to access locked registers will
> > > > > result in external abort. I'm trying to make the QCE driver use DMA
> > > > > for register I/O AND use BAM locking. To that end: we need to pass
> > > > > information about wanting the command descriptor to contain the
> > > > > LOCK/UNLOCK flag (this is what we set here in the hardware descriptor)
> > > > > from the QCE driver to the BAM driver. I initially used a global flag.
> > > > > Dmitry said it's too Qualcomm-specific and to use metadata instead.
> > > > > This is what I did in this version.
> > > >
> > > > Okay, how will client figure out should it set the lock or not? What are
> > > > the conditions where the lock is set or not set by client..?
> > > >
> > >
> > > I'm not sure what you refer to as "client". The user of the BAM engine
> > > - the crypto driver? If so - we convert it to always lock/unlock
> > > assuming the TA *may* use it and it's better to be safe. Other users
> > > are not affected.
> >
> > Just to confirm, we support QCE since IPQ4019 and MSM8996. Is lock
> > semantics supported on those platforms?
> >
> 
> Yes, locking is supported on BAM since version 1.4. The only user of
> this feature right now is the crypto engine and even on IPQ4019 and
> MSM8996 the crypto BAM is version 1.7.

Ack, thanks for the confirmation.

For the record, BAM 1.3 is APQ8064, MSM8960 and IPQ8064.

> 
> Bartosz

-- 
With best wishes
Dmitry

