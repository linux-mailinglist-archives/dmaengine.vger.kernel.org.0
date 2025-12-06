Return-Path: <dmaengine+bounces-7520-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E701ECAA59D
	for <lists+dmaengine@lfdr.de>; Sat, 06 Dec 2025 12:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 39AE5303225E
	for <lists+dmaengine@lfdr.de>; Sat,  6 Dec 2025 11:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F22B2E173E;
	Sat,  6 Dec 2025 11:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a6v7ADCx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jUjRfuzX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C4F2EACF2
	for <dmaengine@vger.kernel.org>; Sat,  6 Dec 2025 11:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765021498; cv=none; b=u//OyK832FcggUrLN2eQi2OGS5313++QDsjEaocnNJGuzlks2hnGVeHORtvddoSL2lgjfMTF96g3c6qu2WbLXq1g8szLeFV811PnLpX/ma+FOxVDJJFeJ0T1/WWiwU7dIILXDn+2n358M05JV4NLZ2zHJSQHuHDhVuKf3ZvEcCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765021498; c=relaxed/simple;
	bh=9OMHApkzIG49dRkSfAQFME71Alpd2HcvfbAgDoWtiRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kc+jnf4mBaz1DlAtcfGDZINhmV9Aindstyt9hLHfLqcOAcpIMKIRFIL4e9xY+rY3B32sHfiID4l3wFU2/pPSyUNzdirBT0in/OfPaVJTHDJblKlKcRXvnM6TJFCk+YEzUst0zyA14g+gBJgF62wcy+HhOQG87cUJcxW33rVtcPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a6v7ADCx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jUjRfuzX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B65Yu1h2778290
	for <dmaengine@vger.kernel.org>; Sat, 6 Dec 2025 11:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=P5rGsK5QqxRVUAaqI0WDgQNV
	059B7nGmE4iibyNRAgk=; b=a6v7ADCxCPPsj8T+Y2YMBbv3SpWdUkU1H+f6fQYZ
	I65AUc3Sn3rMINRu/92pE+GRVVUq5o8zM/VfWIzkhnLvvc7UkWow3AXFW6W2q3P5
	8Kc20rDPydU0MILPD6AiXW0wrN5c8+HocQiRkGCFWKi6ugw2lLUNGDp1rmCSwp44
	c0iOkcXtNxubTRgGcK/sCsldvacdBTL9m+oZUpKojKKtQ3o/3FdZoG0YwxXrVmnp
	iy5kO2YylDqeOxGAccRVJSazxz3k5emGprtGNLq+ObH4/DR4Fykb4pHDzYnnbF6Q
	v4RVWpNvmUS5/j7P3Zza22qKm1gVnoIy1u4jxObyBZH9Dw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4avcv80mfg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Sat, 06 Dec 2025 11:44:55 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8804b9afe30so46283976d6.0
        for <dmaengine@vger.kernel.org>; Sat, 06 Dec 2025 03:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765021495; x=1765626295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P5rGsK5QqxRVUAaqI0WDgQNV059B7nGmE4iibyNRAgk=;
        b=jUjRfuzXEKvrYeQOrIkTuWp+Cht0eUpPf3F7T12qriPO8NA19p8QTifM3EOkA7VgM/
         nOW9RgszC/c2TYNeY71XuBFIUIcO0M7Z7HnSL59i4PkZVivXzvyH3S/9wUR52thCGVDL
         Ad8mjRlkoBTMqHkL755/q5ayGDsOMH68mSDpNJOAdiEf2g/jQ7bcO+xx1TUNs55CbEAH
         jYINExaBwgUCP/odhlw8Ht5Uh10Nqv+If2uBxgSH5bsDNftAG9PAJN45kM/0wiz8PR8t
         oZjHOVtYn8wPZ3DTsK0ddAitJBSqxgN4krBorb4BDLSCX5OwO5p08rODblbih3IBxX8p
         jzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765021495; x=1765626295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5rGsK5QqxRVUAaqI0WDgQNV059B7nGmE4iibyNRAgk=;
        b=Ob545ZHnl3222iauJ5+J1GTML1QfKHazGlkGQWfY6PQR+aqTDB0n7/UCPXajtRhkCS
         upCDuoYcax2eXgF47vmfx1mZZNmFIBnLmQZZakjfl3nICH0L7UY+FHhfp2OXMXML3Ry9
         o2QQIdMDPyDSVEtTGJX3q5uYIOBjAGhMS3ENmMtJLbOlTXxOxScjjsIO3Q05rYAd2daN
         gUD8zoBNI8nVdK496oQMkBdKz1J5RfMp05uOCsK/t0C+FG61FE6g83qeOxhqes1ujjeV
         1K61T/nvBW1wwwcq5mCAp9P12TBIUePI4AAHNW3O6ADzvecRGjtqfyZ/LTFq1Em+DSzY
         h9Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUWpsHtpIjPwdZNhMxQKHaO7l9xAdqfSjGb4kykJ/BnvAHOS66ErEVX2TUEvrsKpgeScj8Nus1xxY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx401/hwTM0xwQcmlNFV1JNZ9U0Xr1ey42F/p5DCg+A+LyUvsM4
	RCdm7a+f505Gr11Z4yHfIHxC0RDohjY4d8CUyDrcTJ52tmSTSdpTPezkrhqWxBwA9ImzCXKBoaP
	F80ak4rgIdNbhGUIuEufvxoGQKA3zJhbkMvbDhFHk/zgt8xfMWmQOKe12gyNMViw=
X-Gm-Gg: ASbGncvKpBrXX3gRc6CTHiF1O0Wk3IBkUQ4f/dxVVkY216mCv+KYwC1AiAuiRHmP/Xv
	sf+MH1acbVcLZwQTCJPGSXbUBXVK345xAv0iPqrT/CTqk9kObKkqgIiAE9AwpsW3kFOsgnC4rRa
	F5jPjAF7U2ey/yH2s2Wl53fpjF4nMykS14143ir9BjMFR0yYruNfzPk8ofETbqtKfI0A8kknHAq
	G599hpCwsqO+YpQzBbmLAMcc3aLswRwhgxnSqRQVpB6tNe6KRfBACT2wk0Tcx8EpUKtrWnh601i
	vjLgrQRwOAAYS+PMR+FdQpLVw6ooVFgaQqb8gvLqXu3RcuW2ODs1PU4bxnm6tnDULl5sHKg73V6
	IJve6rIABduKHLBd9DPD8xUJGGpKA+gWqKFvM5P4zlq1VGhelURNHt6joApKNXxKO7NFmJnSigA
	4J2z97KApPxx9HH8xkTr4enBc=
X-Received: by 2002:ad4:4eab:0:b0:887:438f:c40a with SMTP id 6a1803df08f44-8883dc28d50mr36658376d6.32.1765021495043;
        Sat, 06 Dec 2025 03:44:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpxcMtM6xcqRYA7JSNpznEFhk4xBjRDm3jrSMoUpDSyNOJHg1uxxVfLvEP5+cD8A6FmTiQSg==
X-Received: by 2002:ad4:4eab:0:b0:887:438f:c40a with SMTP id 6a1803df08f44-8883dc28d50mr36658066d6.32.1765021494668;
        Sat, 06 Dec 2025 03:44:54 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-597d7c2e2a8sm2380406e87.90.2025.12.06.03.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 03:44:53 -0800 (PST)
Date: Sat, 6 Dec 2025 13:44:51 +0200
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
Subject: Re: [PATCH v9 03/11] dmaengine: qcom: bam_dma: implement support for
 BAM locking
Message-ID: <d7dvcakczg5rugn2jnpx7kaqsbqhgpicbbzmtxdviha2qdnm6p@n52lxjzomu3v>
References: <20251128-qcom-qce-cmd-descr-v9-0-9a5f72b89722@linaro.org>
 <20251128-qcom-qce-cmd-descr-v9-3-9a5f72b89722@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128-qcom-qce-cmd-descr-v9-3-9a5f72b89722@linaro.org>
X-Proofpoint-ORIG-GUID: bSYqcgvqHS3PpWVm7m8rewE7RQJt6SD0
X-Authority-Analysis: v=2.4 cv=KL9XzVFo c=1 sm=1 tr=0 ts=69341737 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=u0ZkndI9OmTMsI82GJsA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDA5NCBTYWx0ZWRfXxqkFiKStONi4
 yBe5x7IrN2Sk3UBqX6neFzyHp7+28cZsu6diEAxj5REKrtwWAQ69XCjquq3FQM3W3G6Ysv7EKIg
 bMHW+pxKzt+Mjx07rZnMpV2CUHGvfQx12Ut9Z1lJTt9bhLTDehtp0t++pAcdRf2+OqR2qGHyDUc
 u0PxP2KkXiEu9/b560+x2DyOlDRAjAg0vemjd0MEnWb1PYDWnsHvbzjci1jMLbVAzXHP2lstp74
 mblr9e4D8iagKCxcHuW9Qr7w1Br94yrdN0OJsUk0hecIr7P5UEb7/I2zaF9mI1kwTSJ/jkrfDoe
 KN3mGrSXrchGhvtIWhiczJEj0f+OFsnfFat/z4MZ3sRLUHefFcbuYinEHDbbRyNXRdCpXjyvB3B
 47n66ocvnLKMluvYA9XpsCExjstYcQ==
X-Proofpoint-GUID: bSYqcgvqHS3PpWVm7m8rewE7RQJt6SD0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512060094

On Fri, Nov 28, 2025 at 12:44:01PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Use metadata operations in DMA descriptors to allow BAM users to pass
> additional information to the engine. To that end: define a new
> structure - struct bam_desc_metadata - as a medium and define two new
> commands: for locking and unlocking the BAM respectively. Handle the
> locking in the .attach() callback.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/dma/qcom/bam_dma.c       | 59 +++++++++++++++++++++++++++++++++++++++-
>  include/linux/dma/qcom_bam_dma.h | 12 ++++++++
>  2 files changed, 70 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

