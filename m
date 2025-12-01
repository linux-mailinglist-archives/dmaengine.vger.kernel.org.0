Return-Path: <dmaengine+bounces-7430-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAD1C977A7
	for <lists+dmaengine@lfdr.de>; Mon, 01 Dec 2025 14:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AAAF3A2EDB
	for <lists+dmaengine@lfdr.de>; Mon,  1 Dec 2025 13:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B7430FF08;
	Mon,  1 Dec 2025 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KDGZCW8g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WE9/hG1l"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD4130C622
	for <dmaengine@vger.kernel.org>; Mon,  1 Dec 2025 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764594221; cv=none; b=bqTe5GBEVOCslIcuDRSHYjfKg4I8DrF4r99t2qTpFMVxdx/MNvrrwwZ0ltGxundyeRE9qtC/tMghDuQJ44BFNHWDZvIYWv8aml6FGV9SMsYCcYqbuTZPQkhHv0x1qu+u2WWXubTqi+LFN4sSnm3tW4BcgguY/BdH/1F0sFnocA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764594221; c=relaxed/simple;
	bh=mQiRzhVPiTBI5fhfG5QlYmYGwxQKVPYJzIQfa/KT8TY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ch6I0J+avuhYeOfrOefdhCX3HIbHqMUnN/PFUsBOBHyB2z9fjzBVwh361+RVNmloCWENVDi00dcu66qHSTYTEHH67ruUGPxlTG2shq8z1D93B5Pizkr2ah+N6aqMWqKMVEPvBvTXjXNROILnAAtJFX3y0UZWXG+wOdgZtS47JiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KDGZCW8g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WE9/hG1l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B1A7vVr435912
	for <dmaengine@vger.kernel.org>; Mon, 1 Dec 2025 13:03:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ctg+o1lzozlYykOwrPvWfRQts5DzAQREjfwDpCaJEFg=; b=KDGZCW8gOwA5z+dU
	7p+aW47KzL7MlgizscFE3966je9YM+dpKsgar8MEH4sqByEgwL1+J9jrLXceq7eq
	TJyhdYKf6ye20fCWdgnOBcNlFGwctx3HiccJhjUkRyJt+KIm0lCS7wAIvbHeP6bh
	/Pa7jVeOs06DEfVzCkrsO13MIyQFBguVgVdkliy/098XcPRVkPHHAYxFmE/B6GVM
	t13lR+epDg0uX8tjgzql64RjdN73HxOp8jPvCw4sa1f9pM3hytFoT5xKqAHdLfGQ
	bTasuVEGwpElWGthBheU5BKFllo6tc1TJmeflm2de/0jH1KQQvlO1Sx/9h5qYmlb
	BBOhCg==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4as909remq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 01 Dec 2025 13:03:36 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-63fa348e9ebso794431d50.0
        for <dmaengine@vger.kernel.org>; Mon, 01 Dec 2025 05:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764594215; x=1765199015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ctg+o1lzozlYykOwrPvWfRQts5DzAQREjfwDpCaJEFg=;
        b=WE9/hG1l8o1rVTSvsMTs+LqD5jLoS2EOO8y7/gz03w6xBH1W6VVVhxfjfCcdzZYeyj
         Ua6EhknfVA9o5dZ5USSeqitz7VUgp268rw0E3j+kXs6sc8Bn9h/blDv3WzUy4CtC9WRh
         HMmd8kXVoUj+gxzF8uSJvO3D9XKiTvfIcScVKiuliS3YZ0T85QWUWB3er6B7pF2zLPwJ
         Wll3ZJtNogLWBd53SbwD57q/vgv90W4dXZRVfuzU5U71wVkyX+dyQcCtGfKNCamzksyh
         eVDe3de6TKZFYkwU1agaAlWgwHcEP8DszR+KNcye5AhENjBIN2rqrgCF8nFO6JSAvm6S
         bVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764594215; x=1765199015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ctg+o1lzozlYykOwrPvWfRQts5DzAQREjfwDpCaJEFg=;
        b=mnufzyJ+355/4rzMp+fdu0yERXyMgG6PYUM/jV+JteXiaT4rkqEXpCLNc7YE4C0TI/
         S14wP7T72zJzpnWAlyPyxyIG1NIjdBbSwftaqnkAWbR76EUDX9z1IturLjK0i43JXDPq
         7pIMP32JcEjzO2LGRp5lAEN0QPTRwfZRVuetotQRtPzHg97NGUWO3LAGXYUH7IgOdtnL
         8x+a2N/4GmQrhP7ikvNs0tnfjf6LJhbrDzCwZb4rcGgdnZdnrLZSwgB18NeXNgFEAJVS
         ZGlCYm++w50cZ947c7xfPJQiTKPnJktMkooI25cCkCJ9KZq2/dpfCw9SMx22kmbwVfWP
         WnAQ==
X-Gm-Message-State: AOJu0YzlucGs+a0ateEzxNWyHty7tZWKGkytQcGuDHtyYZdR3TO8E0q6
	ZOp9uAdTa4lSI4uZG3NTTU8zVRRwO1rjGMBcopL2846vzOfut7G4LE5J+x73IgETzpIumzBkRqi
	y8dS8UrK0WZFJuKkFLiZHdnBnbHnoecRvHaFjfhHWIto0odtOCPWk3mjzN6O7o5Y=
X-Gm-Gg: ASbGncsdsm4dPUYDxF3+p5lr3Vn9BP5iaeg3BYw411R9bFT/4KD7rxuC9HcIkutbtRl
	xyBdiy6fFMiLKOvzAUNiL0PWGqJkeMWlXYGv210OWZVdI2ypaaCg721DeU5uSf9xpKH/HZyZUt8
	QSAE5+X/OBd7VWXef+aDSanns1mgQrzsT2tY9jPrVJqqA/evzOheaM4wnL5A886L17KHCHCVBit
	TenvvtOXPU0H9L5v9Old8Omz42iTiC2zUlWTycsb3dyD6e/Yf3kwfR//h2kfzXqGDFVhCaMhpuL
	ZGR/2CQnbrD9PDIJoZTabegi1hxjJ8sZmtHvij0qsV/VsYQpRUglKMBK0HMiojrimjNKWuZ/Q0P
	CKiQaM4aAQql2QJTvs52uWkNHY+jhXxhq9xudyczhqA5qdKra17eZiAgzLR1HwOVn19M=
X-Received: by 2002:a05:690e:154d:10b0:640:d0e9:1d7f with SMTP id 956f58d0204a3-64302b44480mr18940968d50.3.1764594215407;
        Mon, 01 Dec 2025 05:03:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqMXMDUrIWgkKWxZqcL0dH0seGl1iVMJGPq0rXLF1jLMt1txAJQwrRO9ii3mNBnFaFb49pNg==
X-Received: by 2002:a05:690e:154d:10b0:640:d0e9:1d7f with SMTP id 956f58d0204a3-64302b44480mr18940933d50.3.1764594214730;
        Mon, 01 Dec 2025 05:03:34 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64751062709sm12436798a12.35.2025.12.01.05.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 05:03:33 -0800 (PST)
Message-ID: <c15e156f-fd11-4d38-98c0-f89b78044407@oss.qualcomm.com>
Date: Mon, 1 Dec 2025 14:03:31 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/11] crypto: qce - Add support for BAM locking
To: Bartosz Golaszewski <brgl@bgdev.pl>, Vinod Koul <vkoul@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Tiwari <quic_utiwari@quicinc.com>,
        Daniel Perez-Zoghbi <dperezzo@quicinc.com>,
        Md Sadre Alam <mdalam@qti.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20251128-qcom-qce-cmd-descr-v9-0-9a5f72b89722@linaro.org>
 <20251128-qcom-qce-cmd-descr-v9-10-9a5f72b89722@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251128-qcom-qce-cmd-descr-v9-10-9a5f72b89722@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAxMDEwNiBTYWx0ZWRfX9QSKLeXtjEOv
 gpWwITJLZ573CAwnNeI9akjkpAKBiYvUPfP/E93soQ28lZcTNEZp1RhFIZwBTRN7YiqJqV425j4
 XZGgHE5ebJr7ggCJMUK1/RDBHFx43doFSpN1+6t8JfaYLWmsaU0A56m+r5bjitN8085OKawWzHd
 FI2bKDzkh8Qvox1Dxh1hQqX8otusith7OVg28osq5tc/D9kQeHApaifRMfjEKWcuy9deMvgoutk
 rilNIWeVaiINS3vBJDJtrWN8Wr/bZFis7MWAvfpL9DXI4HUAsg/KHbB7DJsUv/LkcY1QHMKo0L3
 Nr+BDs842alb0WVofb3uFWCDWfJhfFk0aCZue1IUq/1sskHbwwalF5113ltYwocxP2T/8qEAw6e
 D+2BWM7JGqzbqEdsJHGFmWyzjGNIuw==
X-Authority-Analysis: v=2.4 cv=XJQ9iAhE c=1 sm=1 tr=0 ts=692d9228 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=SbnQZzZDCDfwX-qd_CgA:9
 a=QEXdDO2ut3YA:10 a=yHXA93iunegOHmWoMUFd:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: tJTf1O2cDWU7jBSqylPYzeiejyk3ksVD
X-Proofpoint-GUID: tJTf1O2cDWU7jBSqylPYzeiejyk3ksVD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512010106

On 11/28/25 12:44 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Implement the infrastructure for using the new DMA controller lock/unlock
> feature of the BAM driver. No functional change for now.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/crypto/qce/common.c | 18 ++++++++++++++++++
>  drivers/crypto/qce/dma.c    | 39 ++++++++++++++++++++++++++++++++++-----
>  drivers/crypto/qce/dma.h    |  4 ++++
>  3 files changed, 56 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
> index 04253a8d33409a2a51db527435d09ae85a7880af..74756c222fed6d0298eb6c957ed15b8b7083b72f 100644
> --- a/drivers/crypto/qce/common.c
> +++ b/drivers/crypto/qce/common.c
> @@ -593,3 +593,21 @@ void qce_get_version(struct qce_device *qce, u32 *major, u32 *minor, u32 *step)
>  	*minor = (val & CORE_MINOR_REV_MASK) >> CORE_MINOR_REV_SHIFT;
>  	*step = (val & CORE_STEP_REV_MASK) >> CORE_STEP_REV_SHIFT;
>  }
> +
> +int qce_bam_lock(struct qce_device *qce)
> +{
> +	qce_clear_bam_transaction(qce);
> +	/* Dummy write to acquire the lock on the BAM pipe. */
> +	qce_write(qce, REG_AUTH_SEG_CFG, 0);

This works because qce_bam_lock() isn't used in a place where the state
of this register matters which isn't obvious.. but I'm not sure there's
a much better one to use in its place

Wonder if we could use the VERSION one (base+0x0) - although it's supposed
to be read-only, but at the same time I don't think that matters much for
the BAM engine

Konrad

