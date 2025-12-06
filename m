Return-Path: <dmaengine+bounces-7519-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D641CAA588
	for <lists+dmaengine@lfdr.de>; Sat, 06 Dec 2025 12:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3AAF303BE21
	for <lists+dmaengine@lfdr.de>; Sat,  6 Dec 2025 11:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AB92DEA74;
	Sat,  6 Dec 2025 11:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UhAu0gMS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LEcbBQ+k"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2CB2D94AB
	for <dmaengine@vger.kernel.org>; Sat,  6 Dec 2025 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765021366; cv=none; b=gzWJKkAfI7mO6tjCHxCGKCd/iQXc5eDJx6ZmtNhxI6Jq1ZjBtJ7xgMlRY4R0lCr/VA8pXVNxW2M0R32D22w8dxuex9ehMq5raI0yl2ptb+00H51bkdyGxDeZ40VN6PzmX8JPW6naIySzmeSkmXt3lc8IlY0XGhg15ApvcfHlwvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765021366; c=relaxed/simple;
	bh=uSnV1L/yoLoYSmvzP4okgFwrjeu+CCdIqOIDRC7h2d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzmyBUy58YTkh3gHQ5+lTX5FSeqxtJaqiHPhWMfHq6qqk7lRoVnFaUBtXQZ55jxvmxsi0EWpBy/oySME0SO3nJkFNS/JqcdhSXuEQoqahiCNoB1Z/hKw7Nj0FkhYEpPRM0Fg8ia127U3lxsfKZ+ZDfZdtO6I7Af+j/toDZvfiPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UhAu0gMS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LEcbBQ+k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B65Z5bt2642159
	for <dmaengine@vger.kernel.org>; Sat, 6 Dec 2025 11:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zsHIxuXaNGoM1O/Vkbmg3zxD
	3eb+BNwHk3XxGSWuP3U=; b=UhAu0gMSkWM5NggVwjfYksNUQzN5WR9fzVDds12a
	yqxAl/xh1OFZonc8DAV83/ZU+Ziv6ERvTwe0A2Giybr4v4J5wL4b/MLKxThssy1T
	sP7UWKE2qffLygUhODTv5RjFWUWF8bx7eQk2DOgW8FaI4YYDkqssxb+oS3+RC4tr
	ZMCexKb9r+9Sv+R4eTDk6SMx2woLwfM/ITjI+16gBlqdug1okQa6lUDH9lIYKuOL
	+GnOnt1W/0hAaKj1toTFzlpk3KEfYUxPNyldZHqqUZwFRkO54Oh92CQrQXB87Pfw
	RZ9zyJznlIDvGLqIrddHya/URgwPjWWT5hd84l6LmU3Gtw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4avcndrn87-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Sat, 06 Dec 2025 11:42:43 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b52a20367fso789090685a.1
        for <dmaengine@vger.kernel.org>; Sat, 06 Dec 2025 03:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765021363; x=1765626163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zsHIxuXaNGoM1O/Vkbmg3zxD3eb+BNwHk3XxGSWuP3U=;
        b=LEcbBQ+keBEXDNHu9i4hcLLlbgDJfE5WxMJfypjAW7OA8cW6792l+4w/fz0oN5kgar
         42Uf9KTs6gN4/Uv7mCZW4961eltkZhuA0rtYhx0LZXPHUicyIOPY+QL8g/gcND3Y2pwM
         J3JXWe8z3u1A/XI3B9siQaKjnEWj0fMXs6yKcBaMv9ROudGVOOhYP4PAeTRlpGRrIvm8
         /Mi3UT2Zwq1QvEa5E84XSZdlwh1bZ3PckFwCn4LK5ZQq+nPnRyuQNwNbzMc4BJQKcY1E
         MFwwatHCllLK6L/jXddp574MMifOVQPUgtXT79G/8CiqxTfTLUnPxci2XImkHGEhy4/L
         4jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765021363; x=1765626163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsHIxuXaNGoM1O/Vkbmg3zxD3eb+BNwHk3XxGSWuP3U=;
        b=oyyb5I1mIsw7t94BsvSn7z5A2e/cc31N6SDekLFOy057q7I4aHuyNVNmGXJT0pIolK
         zrZqNBNuAOaNS/AyIDKtQ+bW68TNrBdTTT3vlJ13rEotYpREg7CsvAMe1BqASZ6K7Ohk
         Wikct+jfCVVQlgHDKyCaxjFbIRK8UlhEDvkcmNYnlt82q/e798YAonRHWxFrjnv+O5SB
         kDV7XCWkSX5YhvDqJ0Zh6VO3hvxo4fQ8quf62FVjuDsHmav99YsY3Iejgi1PAG+UrbTI
         J8Gt2oLci9A/6SCzFi9hthsmG0/T+ZHqT2Fhrcdk09Z/yaykRWQzt3nhSLTpOfq8ZeZ4
         +Uvw==
X-Forwarded-Encrypted: i=1; AJvYcCW4nl4hhZQDUli9TkOkjOX08+IQPkmw3rcmNXhwbYPsaZ0uImwBZpLnqAWtkJupdWlyY2hkOV0YTFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlz0skp9d7cXjnSck+ha3syF3Srua7lUyLge7pcAWQXONVU3RO
	/8yiP1o1xoEIg5XBubMOXp666kBjP7RIqrJxs1b5KmYBTnqnTdT5TmtQMeUVVmc9jjSDrrPIUu2
	w5srOgf1irrx5Op6KSYykuXXy/MHj2e5u/5e1DIRwgzYwpyymNJyj6p7YxsGp2Ko=
X-Gm-Gg: ASbGncvLllhkMFAbsK3dtATsx+XX0B3P10vyTi5Ucw3bRAud+4lQa29nUGJbM3ihYTN
	TZqUu9fqwpGkjVQWk658TgIo7+jSc1Gs+6GKEYHHICCZgtglb17gjr7ADzxcNNaJvyiRFl9psOm
	lR/BeUV3PSW20SbacJEaI9VhVrrvy1qpoPcFjMLLUtvwJUNG1OFIxk7it6jbT21HypXI4g/HW4D
	8grb2MpYrzhKDKyDSvJ+BI54EuZPDSlUo1H/ZNT/3j9Rno3I0fS/eSmJIcLIBhCVaXJ+guodxmx
	eCm4bo+JqqH+5NEBfH7BjIi9OCCo1ZvudDa2WS/AR56avz2SuXiE24d3v1kmoMykzroAXSW2C6G
	8U00/V0GKhfbNv4J75ClJOkA4Sl6Mp11TemyLB0Gh7HAu+Hc9y1UrrYykSSewkQnt/YAvFESgdz
	TG+lfNn3Ntkp4K3Xvz2A6c868=
X-Received: by 2002:a05:620a:4403:b0:828:faae:b444 with SMTP id af79cd13be357-8b6159b7a2dmr1361616585a.20.1765021362614;
        Sat, 06 Dec 2025 03:42:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcZrNL4Sc3FjzMtUYj6baDuC23m6S1Oe/SmVjHFc6/ndE7RqpxwssM9vRMCufWsbeqU/ljaw==
X-Received: by 2002:a05:620a:4403:b0:828:faae:b444 with SMTP id af79cd13be357-8b6159b7a2dmr1361615185a.20.1765021362169;
        Sat, 06 Dec 2025 03:42:42 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-597d7b2481fsm2338116e87.41.2025.12.06.03.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 03:42:40 -0800 (PST)
Date: Sat, 6 Dec 2025 13:42:38 +0200
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
Subject: Re: [PATCH v9 02/11] dmaengine: qcom: bam_dma: Add bam_pipe_lock
 flag support
Message-ID: <bizsf4ubgudrzu6sa7p3s5aruitjssc5juhfsr4uq6p6igg2ak@m6k56syfcz6o>
References: <20251128-qcom-qce-cmd-descr-v9-0-9a5f72b89722@linaro.org>
 <20251128-qcom-qce-cmd-descr-v9-2-9a5f72b89722@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128-qcom-qce-cmd-descr-v9-2-9a5f72b89722@linaro.org>
X-Proofpoint-ORIG-GUID: xZwmwQAo5KmNzk-OMiT5Hj6k6I1pexrY
X-Authority-Analysis: v=2.4 cv=baJmkePB c=1 sm=1 tr=0 ts=693416b3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=8EdCfmeLOmFKhcBkMyAA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: xZwmwQAo5KmNzk-OMiT5Hj6k6I1pexrY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDA5NCBTYWx0ZWRfXwMeawIofD0xj
 mqxj+zBHKrph8LR+NurXcEaCDfW8hovkjT8xHNdBjd0oS1GuOkjjq4WDQY+pq1Xzqsx486PJlxC
 tKkLJI2RD1m8wcpWUQzMbNjzd97nryG604umZmfXHOr3212ZGMY91mWPFoaUmx24vFzkw2q32tE
 JSebPSXrnW0sIyElzxzaohu7cFirNDA/Q8xejgSQP8Fno/ehFPnv+r4hWGzksDFMYeTMZY3I7mp
 3nAkq65bNcsNUCpwtu9Vf1XQIx9+1YMJHLnybQ03w63+ow5QhKOvZ5XRKMHTuud5AzGoH2j+6jj
 csrxeNKGZTEMNqjGZxrHSHs5GoMFmuW5bHTAldQCGbm+6NiCR/Ga5+bfNbIzkXsWVdCMfBnvyS4
 nE3ZAekCLFQDdhKy9SzraFNnyEBbMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512060094

On Fri, Nov 28, 2025 at 12:44:00PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Extend the device match data with a flag indicating whether the IP
> supports the BAM lock/unlock feature. Set it to true on BAM IP versions
> 1.4.0 and above.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/dma/qcom/bam_dma.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 8861245314b1d13c1abb78f474fd0749fea52f06..c9ae1fffe44d79c5eb59b8bbf7f147a8fa3aa0bd 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -58,6 +58,8 @@ struct bam_desc_hw {
>  #define DESC_FLAG_EOB BIT(13)
>  #define DESC_FLAG_NWD BIT(12)
>  #define DESC_FLAG_CMD BIT(11)
> +#define DESC_FLAG_LOCK BIT(10)
> +#define DESC_FLAG_UNLOCK BIT(9)

If this patch gets resend, please move these two definitions to the next
patch. Otherwise:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


>  
>  struct bam_async_desc {
>  	struct virt_dma_desc vd;
> @@ -113,6 +115,7 @@ struct reg_offset_data {
>  
>  struct bam_device_data {
>  	const struct reg_offset_data *reg_info;
> +	bool bam_pipe_lock;
>  };
>  
>  static const struct reg_offset_data bam_v1_3_reg_info[] = {
> @@ -179,6 +182,7 @@ static const struct reg_offset_data bam_v1_4_reg_info[] = {
>  
>  static const struct bam_device_data bam_v1_4_data = {
>  	.reg_info = bam_v1_4_reg_info,
> +	.bam_pipe_lock = true,
>  };
>  
>  static const struct reg_offset_data bam_v1_7_reg_info[] = {
> @@ -212,6 +216,7 @@ static const struct reg_offset_data bam_v1_7_reg_info[] = {
>  
>  static const struct bam_device_data bam_v1_7_data = {
>  	.reg_info = bam_v1_7_reg_info,
> +	.bam_pipe_lock = true,
>  };
>  
>  /* BAM CTRL */
> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry

