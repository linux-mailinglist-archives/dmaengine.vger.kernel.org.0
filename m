Return-Path: <dmaengine+bounces-7136-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8034C50682
	for <lists+dmaengine@lfdr.de>; Wed, 12 Nov 2025 04:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DBB71890485
	for <lists+dmaengine@lfdr.de>; Wed, 12 Nov 2025 03:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E10B296BBD;
	Wed, 12 Nov 2025 03:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q4DgKhqr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="an+HWy3U"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB35199949
	for <dmaengine@vger.kernel.org>; Wed, 12 Nov 2025 03:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762917066; cv=none; b=XrtqWt4KaJp2BL6dI1ZVyUZl7UU5oDO0wxfRm9pHW3HUqvdykjW02xM1hFuscmZQfaAft/K64HbZ9excwL2RZajYE84fkzxyr5xc2BlBSGTdIsPGIMGIhtkl0G9Fm59ZGAbnReNi2EciCdp3R5dgobxdq/iQLKq1K45CrZubcXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762917066; c=relaxed/simple;
	bh=AV0Z2T9JPirL6wq3Vadyyil08SHO4pnprBGlFCMpNMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dojwavIJhu3sgd7lnlHU2EitYvdwvtSpG2ehKO5i0iznM4rC9aWLAhE11GpNmPh9kVaaIaz+diIRSKsunf80su9D0ffcnk3DOVjg+H2TxVzsOQmgFUJTsP+GD/yLum9ZQUtdIoKD/e1dcmtNWIlZ1+6xUTYIUkVXIEzeX4ICgfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q4DgKhqr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=an+HWy3U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABH67Ri3060255
	for <dmaengine@vger.kernel.org>; Wed, 12 Nov 2025 03:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=00ACHchLfutlq+B8BDOIqE1L
	m9BQZ2lNkQP02UwVyvw=; b=Q4DgKhqrcjY5+51/DkQlwsuO2iP0rzo3aC4ps3LT
	CMSJ4TIhtz+ILDjF3JCFSbUOsN1STRSYsyvCgstcaf4QiqulRAx0GjK31ROtuvrp
	ZM1K3SEmoMidZJmaaYq0SNhpvIrKM3qqs2WqoMJc7Opzky14Xms5kW6S/c9MfpAh
	iREiw0FatuVYUU358i6X2XXWI5yl1VS05eaKzQWvJRYlEra2myykslWFbZKJK9TK
	fALm9vHfTpF/LOQm0pO/bHpsRq8fqjrrrtkeeSSfMVPxuGgAiZ2S5dqnvbXAm1S3
	m8OiRLPl52Yk1Z5Xq2RIC+Q58wg/sZDkbNWYtCXrm2dkEA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ac988hexa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 12 Nov 2025 03:11:02 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b2640347c5so126790185a.3
        for <dmaengine@vger.kernel.org>; Tue, 11 Nov 2025 19:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762917062; x=1763521862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=00ACHchLfutlq+B8BDOIqE1Lm9BQZ2lNkQP02UwVyvw=;
        b=an+HWy3UGxOW50NNuN/EvwRRksq8jaQTpzyRYYTcbu5Jc/3obtrfc0IXZcZkXpVzft
         C/V3qjlPWJQvHuDwS4+OsD7QqBI//5wnZSil6u51TzpvuMpl4+8evJdRb/I+HV5Rfs2u
         EMODGYrHnJFotpk/62nxFiMQ1DF6QXbXK5U5MQQRy294TBx4NbmIAprTm2cWmCMO4mDE
         DU5f3UApIWRvNAHD3PWD2IWwz7xGhjyM4iSWWExf+4w5W9GDtNPFbCro2NmfgSblCpug
         o3RIhw5uM7MFIU7ScL0Fcf2BrZAL+cr+p4ffbNXinWHBKNTmG4PwQy5HfedKRQyghEtG
         hfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762917062; x=1763521862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00ACHchLfutlq+B8BDOIqE1Lm9BQZ2lNkQP02UwVyvw=;
        b=tmLRax5CnWwVEaG3BJ6wdyOwAtBvpdX200rBGWlT0T7mxyi+RFN5/YfSo1n9xhiNv8
         OK3j7qi5+BaijXR+D8B8He29QlUVPmLYALREI16beXnaDVB0G00yzhV9rBU2HoLUB77i
         Uq6kJZ12lPJGfiWLH4nOAyn7lTVVzr7jtnKV+nN6IRlph9QzvzlKE7sSJzms01oVy+Rt
         +TN8Vu8b3yRjLYkvdJlSIVEsWiXDXc7LJcCAQ9oPToDTiBtgo1gZWttW0WqeQDs7Joth
         Az4jPpCaS8AieWpk4i++DSUnhbG9FGAd7qg+NZviptBxR/BB3TXxJdVjj67YijtxAFR1
         ucBg==
X-Forwarded-Encrypted: i=1; AJvYcCWmI5ZR5tHEDzc+oFMUITd8b/NvyP/oxaBr2dmoh5rqUKhc/X1Sv5Xp7HsRkYM4XSv4l0Ndr5ZY0Lo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs+kr1DlUpv7n5kgsqspM4WihMnxGD3UdvwQAjKo+zfQ+WFXP6
	Q2lXJHxlMHm1eJHksbt8b6T4RwZEu1R764pc9FpeI9DUgZ4eKM6hgA4RBz4mYUFLuc7nCVyoHrs
	5+5FCeJgL88WFjT4oafFYFd/iH1EAZjZSpbiT61J2et2mAWydkMFudVzoEwF38bU=
X-Gm-Gg: ASbGnctR1AeUZ3PGh8wdc7jBNqzMQHNT4Sgb27TYYMdfhdaaEnHQ47RvWeEoEem6s7q
	Rf2YXvfR38Ul131frzWriEYJs38LkBGxuosrqxSLrbBhFZRE7EGRspVHkZsE2GcqflRbOk56mUM
	vTOlwQP3C8VNmMbv3wux/3BwdkT9Ef/Yz53PYbHVW39488/CQtqAFLYjVQv8oxQ+DCV7eX8oguP
	gO1VT7RYJ+y/kUtKcgP2ori1lmU8vpx3IM3zzn9G0PJts7LhJav/YWtxfMkr1p5cYjGKPv9rA4n
	ZQNc31NH20YwqifIYd3xprxU/N1Axfav/C8umIWIwFd4JZAMf1nXCttwA5gIurofYQmW/ggszPg
	EJXuK5dfqJyIbOq9L7h5Hwh1jsWxkY2ksfu0tlXHCAefA/MHpuMOl4PVYN1+5RV4aXoFLhy6PkM
	xRAXBm2qs8nGlv
X-Received: by 2002:a05:622a:164a:b0:4ec:f035:d60 with SMTP id d75a77b69052e-4eddbc94284mr22754241cf.5.1762917061956;
        Tue, 11 Nov 2025 19:11:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnOBMPhkPCNfg5ipaCCLNaPK7WC6Q06oJen91Q3TPaT/TxRDl+cFPsN144s3cBJGkhCwOVjA==
X-Received: by 2002:a05:622a:164a:b0:4ec:f035:d60 with SMTP id d75a77b69052e-4eddbc94284mr22753961cf.5.1762917061417;
        Tue, 11 Nov 2025 19:11:01 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a0b77aasm5397404e87.69.2025.11.11.19.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 19:11:00 -0800 (PST)
Date: Wed, 12 Nov 2025 05:10:59 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 3/3] dmaengine: qcom: bam_dma: convert tasklet to a
 workqueue
Message-ID: <oipix2ljawizmc4yhortgquua7jxtss5bj7y4mqln6o6ppipc6@khk4u2yymyay>
References: <20251106-qcom-bam-dma-refactor-v1-0-0e2baaf3d81a@linaro.org>
 <20251106-qcom-bam-dma-refactor-v1-3-0e2baaf3d81a@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-qcom-bam-dma-refactor-v1-3-0e2baaf3d81a@linaro.org>
X-Proofpoint-GUID: kA_Z5qD2jTCOto0xG9N-emzz3W6plGZ3
X-Authority-Analysis: v=2.4 cv=eO4eTXp1 c=1 sm=1 tr=0 ts=6913fac6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=_VgC3mAVlmbt8rz3gmwA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDAyMiBTYWx0ZWRfX+bKaDvOpTlCF
 NF2cyYogzVqO3yBjieKPy3S15x9o8sMd+MS9Iouzyv4FAgtuEe2EimnqxB86YEtJxNE6Rs5yD4z
 9/Apfm51j1dFXO6Zx7wJsAkVKNqLDMj9mgRLBGCDCWDxhGTLj6K1OAtAjrrO4bS4W/0A29JjThe
 62oYY175tj+sMbcPDxV0WK1goaHZk/jcM8MZWvo6VtWMBI9cGwHdRaDKs94gR7+YmWZgehDeIjl
 Zmfl5rsQUADo4uDZnQ7D+dzFgSpKLuLxVhHfRqRRErl1+NIPlc/gLCkJo+gMxd4QJ8ettRkKG0+
 QZe0T3ypu7g429RL0h86zsNcG2cTaYUgYnu0POb7KMc2Eqy87g08LgeiXwrprd+T0duTyDpUlOo
 vzOKkhJKJkUjvEWozaipn0F5VIzJBQ==
X-Proofpoint-ORIG-GUID: kA_Z5qD2jTCOto0xG9N-emzz3W6plGZ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_01,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120022

On Thu, Nov 06, 2025 at 04:44:52PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> There is nothing in the interrupt handling that requires us to run in
> atomic context so convert the tasklet to a workqueue.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/dma/qcom/bam_dma.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

