Return-Path: <dmaengine+bounces-7521-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33799CAA5A9
	for <lists+dmaengine@lfdr.de>; Sat, 06 Dec 2025 12:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68AA13058A5F
	for <lists+dmaengine@lfdr.de>; Sat,  6 Dec 2025 11:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC094280CD5;
	Sat,  6 Dec 2025 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZyOzA7pe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HaLm6bdZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9B322127A
	for <dmaengine@vger.kernel.org>; Sat,  6 Dec 2025 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765021551; cv=none; b=M1V2cxZamufWuMrS7tMealT8Bf/cBq+pq4JEDkT/v+mcf3IJUFpmBrwtmJn3avecz2jl11K1rLKAWNM2UvqDFVlQDTyaCmfSt1bEGVwiCEBD7hpfeBF7+BA9eSp/oq/b3CH2nAMk6agUDPMTwCTynMREHqv+HaXgj51zIn7kZRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765021551; c=relaxed/simple;
	bh=yfJjYI1TKTl+dZ7vuy+EKk5k/Wwc7PCUSaLTtm6n/TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoCgNKW12xkQWITG2vp75DP/C1v80KZOkZ2paByeTIoLxMmA9s+kUdINR+v1vPjvRcb9OS/o45fgZl7otNcexAatxcR97HycXQVuFDoC9OgHA/bbpErKiQgcLOHgN2TE5pyWzfnfa5zfFscLS6a+tdW1z/nFDOH9SSjHh15MS5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZyOzA7pe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HaLm6bdZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B65Z5bw2642159
	for <dmaengine@vger.kernel.org>; Sat, 6 Dec 2025 11:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Qd3aBq0UymBii6ZFMhW0qvHm
	kEhMp8LfhgbHB7N8EfQ=; b=ZyOzA7peZHV4/z2NAtE5wgB8cBXN9TpCFGUdoahZ
	1MhxL98urs58pWFrqkOP3Av/NXo/N2NOFNrvUJajZS911nC9OsuQ391rYqLhSXqu
	4VYdIxXEiTvCcCIXyW+ap5dd+TsquG4n1x5/HTBRRCK1b3JTLmVKO6e4ct5wF1xI
	b2noMPAuSwKT49IYhUVhJ3xzwRehNwKoz5T35XEoSTsqzPQ4K0XAnEetQijpwkPq
	GfrFA1obaGec582kqqyqQIUsw4rLD/V8j7wPsEUUU1rDO9stkb32CHXRrCYMrt6V
	ylYRnP9FmUbZUhWY+54oSEmDUAnEwXpCaXg9cORy9fbgSA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4avcndrnbn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Sat, 06 Dec 2025 11:45:48 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b245c49d0cso92525085a.3
        for <dmaengine@vger.kernel.org>; Sat, 06 Dec 2025 03:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765021548; x=1765626348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qd3aBq0UymBii6ZFMhW0qvHmkEhMp8LfhgbHB7N8EfQ=;
        b=HaLm6bdZP2VYR77HcOq7ui2e4kK0EBKXPAJZEqGiM/dC/kp9f0qAKJcLcL3BUR8rj1
         LT1ty5EMm1K9sNfoEfYbsaRij9KmMGbekpIZRm6K+RbhEd/fwdwWKylZ7cjmTATGdle9
         MPzvSkqMrK7n/XH/xjnqioQ8+VJzJTno+w9s/FOEFw7LPJ0kv9lkLvJU5k7BcTKe7JHy
         GrHw+l6Y0LT9yaqF3u5VYMWr62Z3p8wigBWh8jHPkaoaNmO+x4c2/DoT36/bNDQEbNmA
         a5n8umnTxs4cZih21srC9KWfaznpWlMST0jqS8r8JXZMeK8/9fJvZYoALYTidKLDlzyD
         vovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765021548; x=1765626348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qd3aBq0UymBii6ZFMhW0qvHmkEhMp8LfhgbHB7N8EfQ=;
        b=WO3vsEw8Xn83Nnhj2eGdrWCRJKImYSscjOpWfoUl4lOBP9Rf0UhcLRoRxODHYJsQvF
         CUKnyeTlY5V4//WZ1QKs1OWKxD3xjLjj+rzkclgO6V+ILstyp+tqidkq1QmvJ05GgWVo
         lV6f7a1Smpbej+uOUO+fvxjcV5hjfOVBwu8R+slYny9v9mTQ1i2bBTZtp8rrhwRmjBTs
         Aip2vVXONTEz1vvUZbOoO2VQ2CqwIHfj1+xFxxao2IJukwyz/wIuZX0ZjFrC31sLr256
         KRTHQhNB3tVMGlixPIdDTzGOGkhhyksDwBgjlm1ZQFiDMwme3BL0uGRdCwcWHzM1zr4g
         CeEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuUt+nfey8rTlU5pL6NkrbGNJDPye3TFXaPCJX8onvebFvz16g9K6u4eGhJTjezVetGE2MQabJU14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0NReRAWDRxZGKqtfWAHVyih7JqudbeKT2ahz4SsKlvPws+X+j
	0HNgAbzqnC5QhBblt073QHzZN/9UL0GiYp6AiZjrjDpn05M7mAou23Fb4i1ccGPnJZ6Hj/vB7Wr
	EdoVlkssRES6Sf792UJVMkgkweZoqrY+BEsfewx0+uaEZ+WmijeX7UvxwX/KHHn8=
X-Gm-Gg: ASbGncvHdPO15Qzf3oxRFTgMaLeemrHntqe2jXCTFi7hg9Ih1UtB6YTe2teyBrbZO2L
	AG0dZfkm+9r1X8X0cZmMSeT9Xokg/wdQcDtNw/Ho+U4zXAZrOkr5cLyS/BN/a7feSK2QJXAD21v
	ak25gYIkPBBRCVq4YmMdXMy+8ztAZlCHBZ4Qw+Os98Eekh7i8IxC/kaPb5teK7COpWjkp6mHW5w
	/STDCWPJt9LVKkIqFDcAbtWc4DcOQ6IOMiuMzrFLLwjCTN2oF6aLQkjb97CAth1fhrqFjHEgPCS
	jJyZOJJB23Z8rZefh4gdz0/0UsHqFtx8kAQt2N/JOF9nlY7mWGK1jNJTkErWNDY8KUAJnkzZFCe
	UHjFJs+f8KmrMOn0yLT+qROxkASpEYg9qsEIRFyOMbpIvD1kVdzPOgALitTuIrJgIs6/oETzecF
	ye8+wQyXSEqfI+3/zC9V4vN6w=
X-Received: by 2002:a05:620a:5cc1:b0:8b2:f228:ed73 with SMTP id af79cd13be357-8b6a2348d63mr208850485a.7.1765021547776;
        Sat, 06 Dec 2025 03:45:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7lhRj80fCQhRwzG8Sy9MVABWIaWuDqVkUzPeyO/wCFqFIdnng6bpykxGDH3HN12wdPzhmBQ==
X-Received: by 2002:a05:620a:5cc1:b0:8b2:f228:ed73 with SMTP id af79cd13be357-8b6a2348d63mr208847785a.7.1765021547290;
        Sat, 06 Dec 2025 03:45:47 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37e70660c43sm21834671fa.47.2025.12.06.03.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 03:45:46 -0800 (PST)
Date: Sat, 6 Dec 2025 13:45:44 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
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
Subject: Re: [PATCH v9 11/11] crypto: qce - Switch to using BAM DMA for
 crypto I/O
Message-ID: <2rua7crcsdwikakbchbsmzbcwkofzwwbujskknub42hpkxjlsu@owqmdyl2gyuv>
References: <20251128-qcom-qce-cmd-descr-v9-0-9a5f72b89722@linaro.org>
 <20251128-qcom-qce-cmd-descr-v9-11-9a5f72b89722@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128-qcom-qce-cmd-descr-v9-11-9a5f72b89722@linaro.org>
X-Proofpoint-ORIG-GUID: plK-GD7mpTeX7_jRPTJgrhO_J113jvVK
X-Authority-Analysis: v=2.4 cv=baJmkePB c=1 sm=1 tr=0 ts=6934176d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=RpWgtCqNgKFi5XhArUUA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: plK-GD7mpTeX7_jRPTJgrhO_J113jvVK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDA5NSBTYWx0ZWRfX5V+omM/9gyMS
 VdFSMT+PIsO59121quCcp1VgY33DY+SDmOMKR2Bia2ZHY8IwsG+3YVHaKylcnWHmsGmgEy5xOjv
 owTY1NXKAa6/2+PeSrrO2jNy6U1zpvCGMv9qLbc2ZlYQCNPiQ5EpruAlNHOvpp/IxC4uTzx/FXx
 +J/O8bXfj2+4iXByFqd9f8MIEjB0+67cXDdyTT2Xjkgjy8RqIv7Bm2JXtBJeUBPazL4Wj5AsZL1
 /RXpT+zBPUsd2uZs8eieO7i0fZ/5L69p+OlaPH5X4UGg4KozUYNrZnyvFmB4CXC8DrGrGm2KqGu
 Ba/e9m/M5QshSZNMqlOGZ8vngpoZK1qrGivJ/FMgn8UxljH+Yl2kVnT8G0zdFCKBl4vliO+veN6
 egjUmGFoV+fCuOPI3FOks4n9XxwGqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512060095

On Fri, Nov 28, 2025 at 12:44:09PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> With everything else in place, we can now switch to actually using the
> BAM DMA for register I/O with DMA engine locking.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/crypto/qce/aead.c     | 10 ++++++++++
>  drivers/crypto/qce/common.c   | 21 ++++++++++-----------
>  drivers/crypto/qce/sha.c      |  8 ++++++++
>  drivers/crypto/qce/skcipher.c |  7 +++++++
>  4 files changed, 35 insertions(+), 11 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

