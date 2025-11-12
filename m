Return-Path: <dmaengine+bounces-7137-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E201C5068E
	for <lists+dmaengine@lfdr.de>; Wed, 12 Nov 2025 04:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB9DB3B2DAE
	for <lists+dmaengine@lfdr.de>; Wed, 12 Nov 2025 03:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9384B2C11E3;
	Wed, 12 Nov 2025 03:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mXl7v1/8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TDrs3HJg"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D032C3245
	for <dmaengine@vger.kernel.org>; Wed, 12 Nov 2025 03:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762917082; cv=none; b=cSrKXXB1HEx7kbH/QXW2P6cPIT8Z8SAFwzvOOlocVB19S0CiJOxJRmFG72EJQC7clwIFlJkgQJdGVEvQMn+tQPxuBcYtN/Wk1/ZOOvPPVOvi2chiytcplfCaoLg4lpgsNDKF47xlyZ2lCI1jMsI2Z88tE+zmfe/Mhz5YAN/C3u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762917082; c=relaxed/simple;
	bh=EXyQo2XCGqUKNjh2SKL/EEEG0nvjTKJ6PDUTuDkSVdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKCdvjgPFVzqx3nSV3rFiG2hoebnDGkAMZCtFlXtqnbwuv36Pl804VrTqzGIQITGWgwqveru4IQ7bk/RiyED36T9TRvRPVeFEk/stfleOejCjIZw62UnCBK5OWObnuy441HLc/kNtk6p5y+yyF8qTGzKr7vLebFbhx0yE8BZ+ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mXl7v1/8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TDrs3HJg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABLbY9O2027695
	for <dmaengine@vger.kernel.org>; Wed, 12 Nov 2025 03:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7I5ASJbiXFUjCDLjJspnGT8T
	6HCYyqonpWR8OtpmpS8=; b=mXl7v1/8JKX+W8UWrLGRWAHiSSkOFdopLhwa1H0d
	q3chLJShw6YtLgwTd17o+mWQz5/0kI68uNAOW2ZIL1QdHoRmsaaMqaxhgiI742zm
	DaQ3H0NBUqNZ10/QujkTP+LSrhfw6q4gdvj/HXfkLtYbxnGvFoYcTMHLZnhn0P+X
	0RQKcXS8+2OLdw3xBPEwbTzTi1w+V46C3MVuSwP05nu/snE5MRmR0bKg4FvWOXS/
	gpZA2fooTNTp2zQo9OIXL5mOnF4rWnmCmBVlF9+fmUTiL48IR51YBPdyB5s8TeqC
	p6TB6nS5oQk60TCz6zynYDIp1gTO8842ZRsBKx+c7FRYAA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abxqw3g3g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 12 Nov 2025 03:11:20 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b24a25cff5so115251585a.2
        for <dmaengine@vger.kernel.org>; Tue, 11 Nov 2025 19:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762917079; x=1763521879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7I5ASJbiXFUjCDLjJspnGT8T6HCYyqonpWR8OtpmpS8=;
        b=TDrs3HJgETMbEeaqCwdTibRPDjZpliWAvjyxaY14XJRQOzQrMoxbPqxB2bCq6aeglJ
         ZGeWd1PKEk4FI4LL7yGchqhD7oQCYMEWSvb4NR3Br+f0feRQytFCjpihCadsMaJkZpW9
         scErHIPwePOBEz6McbPDBkvsppE1WcQggs3L+8DLxyC45vCQZkWPXQEQMOOHaVJfHj+p
         6yvroK+V3fETSNXCIBXm3TMPAeXVclTfcWq7Z6vlTQG1CyuVjuGUjyLHDI15l+nKcwAg
         CFW6XdJPp7Uuto3ezSjiQuWp48DzAu5GQQm/cwencBczeSWNI62+5DOZLQ9uXsEdIM99
         WF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762917079; x=1763521879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7I5ASJbiXFUjCDLjJspnGT8T6HCYyqonpWR8OtpmpS8=;
        b=SsIDUDrxIW7YTYdmXsI8UxOXkZvtIFBqjimnTYK9eCBGKwUuK0U+LeM06olLR5kmVP
         li32tQXr0+I0a4DhFE15klMvzxbAVk+DJ9b9hG0bqPndGeH+XFVtZ73IPGF/tHPrPBCf
         gZ/474CbsEIYZJd/OWTVvQDN/c0epAuJRLkaV5wl8rinbbec11rOJRGh1FyNqfy57oaB
         0oGLSNlyJXRPOCfOuykgDV3Bcodl42p7xilxiDH40FrcJuN0lWe5Vnlzf0F1B+yJV3ms
         AfbhP4nJlrZMjrU+dWDcSDfMTWPAGzBHJ7xNWCt9LJct2+2/Nq0pt6ln7Vu0V3Jh/82n
         j9Og==
X-Forwarded-Encrypted: i=1; AJvYcCX/OCS8oe0SiZunfPjh9lEs0crj5Vu6BKJ1g4g2jzWx2U/4pdcY+hBk8JHEhBb9IuhJcCjXmpSGg6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM0kynS7lSt2xZfWKePC0XdPB0uxeYvL1zT4iSzR2GAQObzl5r
	F7MSjC38tnxL5zu8K0Q2bXIuMGAMGLfI7nzBThhYcllWDDO8lm0YXe/v9V/ioDTVkWW0qhdzl72
	QiZsCaXiWwOcD1vLxBZ+i9uLxMiW9VwZhVO0zbHo5FK9uvee0IbbzvgQwNF5liGKsKg9zQ+w=
X-Gm-Gg: ASbGncsef75CF4PEweaHuJs2SNxzxexG/Q3NFedhpMfkQaJCdAsUo9nropBlySch9uI
	7A0+pKyn2C4JAMAX+n2DYopaKIWoXu7qY1AaCMKOb7uE+2NMTFQfoY+DUTK5oj8WNUSaB3yJBFx
	LsdHfrg4WOHo7uBOQKPsxMVFiaeKlujtPymWKcn6gR1ziUlBe+sRx394N647k7FH4sYH2IA5t+m
	wd7eOQ8ttNOxcZONHB0EKFtTrYNRI3ejkR0ue+iKUKe4tiHfyKyAXbbMG48/MOjQFOFo4BH7GNq
	93T7XdHpQQg2HRCCluCtpd297iFBH4VUvBXQA15W+UpN1gCQguYm21TPU9660P0B25s+dVrzsuP
	LxeOhsxBg+pnDgNDanX/6clonCXmUd+y3V3AZTdpx930Xo3HUOS40JWXnCKDX0i4vvaFxoUnclR
	9FBF+53zEwtbSY
X-Received: by 2002:a05:622a:1990:b0:4ed:685e:f3d3 with SMTP id d75a77b69052e-4eddbdddaafmr19221991cf.81.1762917078905;
        Tue, 11 Nov 2025 19:11:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGItbTS9amgruWtVUfzM5Xu7LUQSRzrfWwGLisuakKtCzvIwYg6qWkM5gDKUv2oTc7wmQsHw==
X-Received: by 2002:a05:622a:1990:b0:4ed:685e:f3d3 with SMTP id d75a77b69052e-4eddbdddaafmr19221891cf.81.1762917078509;
        Tue, 11 Nov 2025 19:11:18 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5957bc49440sm47759e87.9.2025.11.11.19.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 19:11:17 -0800 (PST)
Date: Wed, 12 Nov 2025 05:11:16 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 1/3] dmaengine: qcom: bam_dma: order includes
 alphabetically
Message-ID: <com7xvhrr7hq6axjji6tnkvb5bapmddbzpz2j7zrfog6323d5t@blevtj7w3hzq>
References: <20251106-qcom-bam-dma-refactor-v1-0-0e2baaf3d81a@linaro.org>
 <20251106-qcom-bam-dma-refactor-v1-1-0e2baaf3d81a@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-qcom-bam-dma-refactor-v1-1-0e2baaf3d81a@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDAyMyBTYWx0ZWRfXynVepbHpmGpS
 UWhxXJEyIwDjurL92hmviWzN7e+031ROhxp8mBU+FnfMyNh6BusPo8/t6jXIzf4Az09kUZlPZGP
 a86dhjYA89ECuxqbHJZrEvQ/LrACbsht9UMyTn4hZGdqQruNxQfRUttMYPibgFprTeMn2NFTbNE
 XLTAAVvrd8degkH9SP2DR3K5/G5pWV11Jpfq09pZAeZA3v6lhHRf/09HWKZ/3SUWlkRAVglDsC+
 9+le5Z1dhfmccfUenvkW7/5FxeuyaLPW9DWIOuR2JptDxzHLy+D0iFwRe5I03RtPSXetpwBvSXC
 pFBx9MaabFKgmZlmJd7NwDtEH7kQ5mPnAAZne64lzYaZoYoKymTj7Hckeqw6TJq7i2mO1CmYl5P
 MxMOirJKT1gZRNa+FqIMeFO2q4cPeQ==
X-Proofpoint-GUID: uFBsm7GyqKWzg-OshO8aG__LSVsGg7qW
X-Proofpoint-ORIG-GUID: uFBsm7GyqKWzg-OshO8aG__LSVsGg7qW
X-Authority-Analysis: v=2.4 cv=CeIFJbrl c=1 sm=1 tr=0 ts=6913fad8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=EWPwqxXB_ygDNX-GOH0A:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_01,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511120023

On Thu, Nov 06, 2025 at 04:44:50PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> For easier maintenance and better readability order all includes
> alphabetically.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/dma/qcom/bam_dma.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry

